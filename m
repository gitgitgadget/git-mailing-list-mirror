From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status example
Date: Sun, 29 Jul 2007 13:33:27 +0200
Message-ID: <85bqdvxx4o.fsf@lola.goethe.zz>
References: <20070729002427.GA1566@coredump.intra.peff.net>
	<alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
	<20070729041159.GA5544@coredump.intra.peff.net>
	<alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
	<7vbqdvolww.fsf@assigned-by-dhcp.cox.net>
	<7vwswjmu08.fsf@assigned-by-dhcp.cox.net>
	<20070729094955.GA14915@coredump.intra.peff.net>
	<Pine.LNX.4.64.0707291214060.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 29 13:34:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF72A-0002gv-0h
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 13:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761544AbXG2Ld7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 07:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761543AbXG2Ld7
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 07:33:59 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:55725 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761491AbXG2Ld6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 07:33:58 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 71F9E31F23F;
	Sun, 29 Jul 2007 13:33:57 +0200 (CEST)
Received: from mail-in-15.arcor-online.net (mail-in-15.arcor-online.net [151.189.21.55])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 4E728ABCE2;
	Sun, 29 Jul 2007 13:33:52 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-015.pools.arcor-ip.net [84.61.17.15])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id F2BF245939;
	Sun, 29 Jul 2007 13:33:49 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3D9821CFF95E; Sun, 29 Jul 2007 13:33:27 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0707291214060.14781@racer.site> (Johannes Schindelin's message of "Sun\, 29 Jul 2007 12\:14\:49 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54105>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:


>>  	}
>>  	rev.diffopt.allow_external = 1;
>> +	rev.diffopt.recursive = 1;
>
> How about
>
> 	if (!rev.diffopt.quiet)
> 		rev.diffopt.recursive = 1;
>
> instead?

I think that the optimization "don't descend if we can figure this out
at the top level" should be rather implemented at the program flow
level than in the option processing, and quietness does not actually
play into this: _any_ diff operation can skip trees with identical
top-level SHA1.

So the above optimization should not cause a performance difference
(if it does, this is better fixed elsewhere), and makes it obscure to
guess the "-q" behavior which should be more or less equivalent to
--exit-status >/dev/null

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
