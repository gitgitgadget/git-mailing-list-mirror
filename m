From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 03:03:59 -0400
Message-ID: <42BA5EDF.3020804@pobox.com>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com> <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com> <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org> <42BA271F.6080505@pobox.com> <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org> <42BA45B1.7060207@pobox.com> <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 09:02:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlLik-000684-IG
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 09:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbVFWHHf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 03:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVFWHHY
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 03:07:24 -0400
Received: from mail.dvmed.net ([216.237.124.58]:28338 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262563AbVFWHEK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 03:04:10 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DlLko-00037i-K4; Thu, 23 Jun 2005 07:04:03 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> Pulling a regular head _cannot_ and _must_not_ update tags. Tags are not 
> associated with the tree, and they _cannot_ and _must_not_ be so, exactly 

For general git implementation, strongly agreed.


> And not making them separate breaks a lot of things. As mentioned, it
> fundamentally breaks the distributed nature, but that also means that it
> breaks whenever two people use the same name for a tag, for example. You
> can't "merge" tags. BK had a very strange form of merging, which was (I
> think) to pick the one last in the BK ChangeSet file, but that didn't make
> it "right". You just never noticed, because Linux could never use tags at
> all due to the lack of privacy, except for big releases..

Agreed.


> How is this AT ALL different from just having a separate script that does
> this? You've introduced nothing but syntactic fluff, and you've made it
> less flexible at the same time. First off, you might want to get new tags
> _without_ fetching anything else, and you might indeed want to get the 
> tags _first_ in order to decide what you want to fetch.

That's a fair point.  A separate script would be better.


> because that would make them global instead of private, and it would 
> fundamentally make them not be distributed, and would mean that they'd be 
> pointless as anything but "Linus' official tags".
[...]
> the fact that tags _should_ be normal every-day things that you just use
> as "book-marks", and that the kind of big "synchronization point for many
> people" tag should actually be the _rare_ case.

For my use, I require all "Linus official tags" to be present in all my 
kernel trees, precisely because it is a big sync point for many people.

User A sends me a patch against 2.6.12-rc2, user B sends me a patch 
against 2.6.12-rc3, user C sends me a patch against 2.6.12...  I create 
a branch with
	cp .git/refs/tags/$kversion .git/refs/heads/foo-net-drvr
	git checkout -f foo-net-drvr
apply the patch, then pull linux-2.6.git to merge up to the latest version.

So in my case, the rare case is the 99% common case :)

I suppose this usage is just highly specific to me.

	Jeff


