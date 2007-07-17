From: Sam Vilain <sam@vilain.net>
Subject: Re: 'git gc' & number of unpacked objects ?
Date: Tue, 17 Jul 2007 10:57:47 -1000
Message-ID: <469D2D4B.8090900@vilain.net>
References: <f36b08ee0707170914g7ece7124qf5d8d6a1307cc07e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 22:58:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAu7W-0002uv-30
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 22:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667AbXGQU6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 16:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755751AbXGQU6E
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 16:58:04 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:39244 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbXGQU6B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 16:58:01 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id B3D9F21CF1B; Wed, 18 Jul 2007 08:57:59 +1200 (NZST)
Received: from [192.168.1.12] (rrcs-67-52-91-213.west.biz.rr.com [67.52.91.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 0FA8821CF16;
	Wed, 18 Jul 2007 08:57:52 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <f36b08ee0707170914g7ece7124qf5d8d6a1307cc07e@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52801>

Yakov Lerner wrote:
> By the analogy with the maxtime and maxmount in the ext3 when it
> reminds you to fsck, when number of mounts since last fsck, or time since
> last fsck is above some limits. I think this makes practical sense. I
> think
> the similar thing makes sense wrt to 'git gc'.
>
> Is it possible that git repo had a parameter N, and when the counter of
> unpacked object hit this number,  then git operations start to print
> semi-annoying warnings
>      "Time to optimize your repo using 'git gc' command ... "
> ?

I also wrote a commit hook that counts loose objects and just runs
repack with differing parameters.  Check for threads with terms
"generational repack" in them.

To make it a really fast check, Linus suggested estimating the number of
loose objects with a sample, eg if the threshold is 256 loose objects
and you find 3 or more objects in directories 01, 02, and 03 then it's
time to repack.

I've been using the script I posted on my own repositories for a while
and was never really annoyed by the 2-3s aside it took every few dozen
commits to repack.  But then I'm probably biased and usually playing on
relatively zippy machines.

Sam.
