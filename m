From: Ryan Anderson <ryan@michonline.com>
Subject: Re: pack-e3117bbaf6a59cb53c3f6f0d9b17b9433f0e4135.pack
Date: Fri, 8 Jul 2005 04:18:59 -0400
Message-ID: <20050708081859.GG20369@mythryan2.michonline.com>
References: <200507081149.45344.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 10:19:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqo4j-00028v-LE
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 10:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVGHITC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 04:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVGHITC
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 04:19:02 -0400
Received: from mail.autoweb.net ([198.172.237.26]:20896 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262101AbVGHITB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 04:19:01 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1Dqo4a-00048L-M9; Fri, 08 Jul 2005 04:19:00 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DqoAo-0004hZ-00; Fri, 08 Jul 2005 04:25:26 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1Dqo4Z-0005rb-Pa; Fri, 08 Jul 2005 04:18:59 -0400
To: Alexey Dobriyan <adobriyan@gmail.com>
Content-Disposition: inline
In-Reply-To: <200507081149.45344.adobriyan@gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2005 at 11:49:45AM +0400, Alexey Dobriyan wrote:
> Being a happy user of
> 
> 	$ cat ./rsync-linus
> 	#!/bin/sh -x
> 
> 	cd linux-linus
> 	rsync -avz --progress \
> 	        rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
> 	        .git/
> 
> I'm confused now. This pack file is ~60M in size. Will rsync download
> another 60M next time? What command should I use now to a) get latest and
> greatest and b) be nice with my traffic?

You won't need to download another 60M next time.

Run this:
	cd linux-linus
	du -sh .
	git-prune-packed
	du -sh .

You should see a nice drop i space used, as that one big "pack" file is
now taking the place of almost every object in the kernel repository.

In the future, you'll just download new packs as Linus generates them.
I suspect objects will trickle in as well, but an occassional
git-prune-packed will tidy things back up.

The packs internally use a delta-based algorithm to save huge amounts of
space, and for speed of daily use, the standalone objects are still in
use.

-- 

Ryan Anderson
  sometimes Pug Majere
