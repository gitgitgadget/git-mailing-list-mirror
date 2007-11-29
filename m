From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH v2] Replace instances of export VAR=VAL with VAR=VAL; export VAR
Date: Thu, 29 Nov 2007 11:17:59 +0100
Message-ID: <85prxt5p9k.fsf@lola.goethe.zz>
References: <109026BC-408F-451A-8F7C-A4012DD8DBDF@wincent.com>
	<C3971B37-F75A-40EE-B30A-E88E5DAFAD55@lrde.epita.fr>
	<D21294CA-6FD0-40F5-B0D6-5155865DA69A@wincent.com>
	<CDF48716-F198-4B33-A5F5-8A2DE1F177EB@wincent.com>
	<474AC136.8060906@viscovery.net>
	<451492C9-F3EA-4C37-A1AD-59FC72E0A0A2@wincent.com>
	<Pine.LNX.4.64.0711261340470.27959@racer.site>
	<97F6E8DE-4022-4458-B6A9-C644A6EDC1E3@wincent.com>
	<7vir3m94ku.fsf@gitster.siamese.dyndns.org>
	<50645A3B-C5F0-4A99-A2B8-AD9251024244@wincent.com>
	<7v1waa7lcv.fsf@gitster.siamese.dyndns.org>
	<1570EAD5-9F47-4105-B3DA-49CA6FA57369@wincent.com>
	<Pine.LNX.4.64.0711281355460.27959@racer.site>
	<474D7956.8050401@viscovery.net>
	<Pine.LNX.4.64.0711281428180.27959@racer.site>
	<474D7D92.2000106@viscovery.net>
	<Pine.LNX.4.64.0711281552440.27959@racer.site>
	<85ve7m8iix.fsf@lola.goethe.zz>
	<7vzlwy2dkm.fsf@gitster.siamese.dyndns.org>
	<85sl2q6kyu.fsf@lola.goethe.zz> <474E6CC8.8000301@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 29 11:18:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxgTB-0006wv-NF
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 11:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbXK2KRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 05:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754503AbXK2KRu
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 05:17:50 -0500
Received: from mail-in-12.arcor-online.net ([151.189.21.52]:49539 "EHLO
	mail-in-12.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754209AbXK2KRt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 05:17:49 -0500
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id D0C404C9FB;
	Thu, 29 Nov 2007 11:17:47 +0100 (CET)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id AD15828EDE0;
	Thu, 29 Nov 2007 11:17:47 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-009-099.pools.arcor-ip.net [84.61.9.99])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 8C8862BB6EE;
	Thu, 29 Nov 2007 11:17:42 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 0FCE91C4D3AA; Thu, 29 Nov 2007 11:17:58 +0100 (CET)
In-Reply-To: <474E6CC8.8000301@viscovery.net> (Johannes Sixt's message of
	"Thu, 29 Nov 2007 08:39:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4948/Wed Nov 28 21:42:33 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66524>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> What problem are we talking about exactly, and with what shell?
>
> $ export foo="bar    baz"
> $ bash
> bash$ export JUNK=$foo
> bash$ sh -c 'echo "$JUNK"'
> bar    baz
> bash$ exit
> exit
> $ ash
> ash$ export JUNK=$foo
> ash$ sh -c 'echo "$JUNK"'
> bar
> ash$ exit
>
> The problem is $foo not being quoted on the RHS of the assignment of
> the export command: bash doesn't word-split, but ash does. Hence, *if*
> export VAR=VAL is used, always quote VAL.

I much prefer the quoting solution over the quite more invasive rewrites
proposed here.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
