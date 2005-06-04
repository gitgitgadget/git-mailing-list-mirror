From: Dave Airlie <airlied@gmail.com>
Subject: Re: [doc]playing with git, and netdev/libata-dev trees
Date: Sat, 4 Jun 2005 20:31:34 +1000
Message-ID: <21d7e99705060403312234aa07@mail.gmail.com>
References: <42955DF7.4000805@pobox.com>
	 <21d7e99705060401405cfd5a11@mail.gmail.com>
	 <42A181C1.3010902@pobox.com>
Reply-To: Dave Airlie <airlied@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 12:29:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeVtG-0007Ww-Pb
	for gcvg-git@gmane.org; Sat, 04 Jun 2005 12:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVFDKbq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Jun 2005 06:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVFDKbq
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jun 2005 06:31:46 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:41177 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261311AbVFDKbf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Jun 2005 06:31:35 -0400
Received: by rproxy.gmail.com with SMTP id 40so108535rnz
        for <git@vger.kernel.org>; Sat, 04 Jun 2005 03:31:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gTkB3AE7rDry/tJmuwoVf5PVztbhGDuQfSl4ytojehHPZ2D1Yhkd42Gxyu9N3rNVyxEoqyKB6hQaklgrlz5tY3P7YTb1UjDevTKaVZBVskYaHfzCCtO3V6XxgDM/CgqzJpUoyXHeBTwBBg0QEid+e/rDADLA1hxP4AXeLxgRzWQ=
Received: by 10.11.119.74 with SMTP id r74mr91463cwc;
        Sat, 04 Jun 2005 03:31:34 -0700 (PDT)
Received: by 10.11.117.46 with HTTP; Sat, 4 Jun 2005 03:31:34 -0700 (PDT)
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <42A181C1.3010902@pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> > 1. when you want to publish your tree what do you do? just rsync it
> > onto kernel.org?
> 
> Basically.  I copy the attached script into each repo, customize the
> script for the upload destination.
> 
> When I publish the tree, I just cd to the toplevel dir on my local
> workstation, and run "./push"
> 
> 
> > 2. When you are taking things from your queue for Linus do you create
> > another tree and merge your branches into it or what?
> 
> Not quite sure what you're asking, but I'll attempt to answer anyway :)

Yes that's what I'm asking, mainly the pulling of multiple trees into
one tree for giving to Linus, for Andrew I'm quite happy to have him
pull multiple HEADs from the one tree assuming I don't have many
interdependencies between trees...

Say I want something like this one tree with

drm-2.6 - HEAD <- linus tree
            - drm-via < a via driver
            - drm-initmap 
                      - drm-savage <- a savage driver that depends on
the drm-initmap tree

How would I construct such a beast, how does it work out from where to
branch, can I branch a branch for something like drm-savage so I can
say send Linus the initmap branch and then have -mm pulling the savage
one...

if that makes any sense :-)

Dave.
> 
> 
> [1] I'm still scared of conflicts in the merge process.  Simple and
> automatic merging works just fine, like it did under BitKeeper.  But if
> there are conflicts that cause git-pull-script/git-resolve-script to
> bail, then I bail as well:  I export a patch, run patch(1), and then
> handle the merge the Old Fashioned Way(tm) by looking at .rej files.
> 
> I really wish somebody would write a merge helper for git that places
> the conflicts side-by-side in the code [in the working dir].  BitKeeper
> and CVS both presented conflicts to you in this manner.
> 
> The "I resolved this conflict, now let's continue where we left off"
> process is still quite raw in git.  I suppose this is something that is
> left for others to script, above the plumbing, but hey...
> 
> 
> 
> #!/bin/sh
> 
> rsync -e ssh --verbose --delete --stats --progress -az .git/ master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git
> 
> 
>
