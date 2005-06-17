From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: git merging
Date: Fri, 17 Jun 2005 19:08:07 -0400
Message-ID: <42B357D7.6030302@pobox.com>
References: <20050617133440.GI6957@suse.de> <Pine.LNX.4.58.0506170937260.8487@ppc970.osdl.org> <20050617175653.GS6957@suse.de> <Pine.LNX.4.58.0506171101450.2268@ppc970.osdl.org> <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org> <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <axboe@suse.de>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 18 01:02:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjPrR-0005Ww-LQ
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 01:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbVFQXIR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 19:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVFQXIR
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 19:08:17 -0400
Received: from mail.dvmed.net ([216.237.124.58]:63119 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261730AbVFQXIN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2005 19:08:13 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DjPwX-0000LJ-VG; Fri, 17 Jun 2005 23:08:10 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org>
X-Spam-Score: 0.4 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Linus Torvalds wrote: > The "git prune" script is
	really trivial, you can see for yourself what > "git-prune-script"
	does. I've been too lazy to report this, but... last time I tried it,
	git-prune-script ate valid objects, for my multi-branch trees. This was
	100% reproducible. Luckily, the objects it ate were all in the main
	branch, so an rsync-without-delete from linux-2.6.git/objects would
	restore the missing data. [...] 
	Content analysis details:   (0.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.4 SEE_FOR_YOURSELF       BODY: See for yourself
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> The "git prune" script is really trivial, you can see for yourself what 
> "git-prune-script" does.


I've been too lazy to report this, but...

last time I tried it, git-prune-script ate valid objects, for my 
multi-branch trees.  This was 100% reproducible.  Luckily, the objects 
it ate were all in the main branch, so an rsync-without-delete from 
linux-2.6.git/objects would restore the missing data.

This was verified by repeated runs of
	git-fsck-cache		# OK
	git-prune-script
	git-fsck-cache		# spits out tons of errors
	rsync ...		# restore deleted objects
	git-fsck-cache		# OK

I use hardlinks on the local disk, between several multi-branch repos, 
if that matters.

	Jeff


