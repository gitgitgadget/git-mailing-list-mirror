From: David Kastrup <dak@gnu.org>
Subject: Re: Significant performance waste in git-svn and friends
Date: Wed, 05 Sep 2007 23:19:18 +0200
Message-ID: <85bqcghktl.fsf@lola.goethe.zz>
References: <20070905184710.GA3632@glandium.org>
	<7vd4wwj16d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 23:19:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT2HV-0003ed-Ps
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 23:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbXIEVTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 17:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754949AbXIEVTU
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 17:19:20 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:39726 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752966AbXIEVTU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2007 17:19:20 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 41660302EC6;
	Wed,  5 Sep 2007 23:19:19 +0200 (CEST)
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net [151.189.21.50])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 3336421300A;
	Wed,  5 Sep 2007 23:19:19 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-072-218.pools.arcor-ip.net [84.61.72.218])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id D767C23D1E3;
	Wed,  5 Sep 2007 23:19:18 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 770061CAD71B; Wed,  5 Sep 2007 23:19:18 +0200 (CEST)
In-Reply-To: <7vd4wwj16d.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 05 Sep 2007 13\:40\:42 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4166/Wed Sep  5 17:20:22 2007 on mail-in-10.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57766>

Junio C Hamano <gitster@pobox.com> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>> The same things obviously apply to git-cvsimport and other scripts
>> calling git-hash-object a lot.
>
> I *obviously* hate this patch, as it makes this Porcelain
> command to be aware of the internal representation too much.
>
> I wonder if letting fast-import handle the object creation is an
> option, though.

I think it would be saner to give git-hash-object an operation mode
that makes it usable as a pipe-controlled daemon, so that one needs
not fork and exec for interning another object.  That way, porcelain
commands could keep one bidirectional pipe (feed object type and
source and whether to use -w into git-hash-project, receive object id)
to git-hash-object around until they finish.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
