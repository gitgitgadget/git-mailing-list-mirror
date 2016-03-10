From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Thu, 10 Mar 2016 18:51:55 +0700
Message-ID: <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com>
References: <cover.1457609615.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 10 12:52:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adz8p-0005Qo-Ms
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 12:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbcCJLw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 06:52:28 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34441 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbcCJLw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 06:52:26 -0500
Received: by mail-lb0-f175.google.com with SMTP id xr8so104731962lbb.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 03:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SYs1Pw66BKMM+smWdkqn0DvPHQ8dfbfbqIPLWg3WNCw=;
        b=kyggABRjdWxYHN8Xdks9W8zI58f7F8Qyl/rcKfzT4Og+1h8+KfPR73ScoR1a5lZAtd
         W8ZlkuipBQ3QIqOQKB+92Z+Nyesa4AXK5ayPAcMKc0YRzEtZokHJxKKpwlgegF3tK2dU
         He02HpzeN44ufgfTZmEsBHiuW/gYRJ593TVgBRVmx1GDY39N/6fkmvJHy2Rb2uyYxgps
         oq0/+CjhdZYQIK0n1HcyURKCoLEGSuXKW8QfjDkhwPIva2syZeraiiP2LVTNWRFW7nS6
         Ox9IDGUnJpycCYzPv+XMJH/uZ+8VDbNePkGMFtRl/6cmbj+9QLKMYpvtt0sp0hp06/Mo
         I/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SYs1Pw66BKMM+smWdkqn0DvPHQ8dfbfbqIPLWg3WNCw=;
        b=GtgGDQ5Zw5wtFeqxGRDJQO0XK/AxLIhvC06dsTNZVS2qwsbLs+Hy/0MJyCuicbbOCh
         0zj1yA8PH+8XMZYUZ2XR+RmbttlrBokb8BE0zXGufDkx5uHcIMTsK7c+Q3xE200j4F5f
         9dBB9F1chogJ59dF68fDwRVwLzfaf1TR3thFGFg6Cee0pwHAMttnBg3LJ0AYgSLHkw7J
         EWT8wF5i8zWGSufp0B4+tv+B5US4mhW5cbf0JS4KZ3SvHxlrMAA9Ols9A01m6sPVSCr7
         tVdGO+iiFsj5ZKnPXCuLLFELttNBHIVIbSbHrIo2S7JotekFOr8BGptgciqUdkayj8Er
         eI1A==
X-Gm-Message-State: AD7BkJLNLGv1/EjQQW3wAy1cOehABQ9cbV74PGdxDQ6xFiZ4AO6cK9h6Y/5SCZxVWLozbKp71k60LxmSIb3BxQ==
X-Received: by 10.25.147.202 with SMTP id v193mr1073164lfd.162.1457610745003;
 Thu, 10 Mar 2016 03:52:25 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Thu, 10 Mar 2016 03:51:55 -0800 (PST)
In-Reply-To: <cover.1457609615.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288616>

On Thu, Mar 10, 2016 at 6:34 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The invention of the `git worktree` command changed this developer's
> working style dramatically. Rather than switching between branches all
> the time, topic branches are created and checked out in newly-added
> worktrees, to be reworked and refined until the topic branch is either
> merged into `master` or abandoned.
>
> It gets rather tiresome, and also typo-prone, to call "git branch xyz
> upstream/master && git worktree add xyz xyz" all the time.

You can actually do "git worktree -b xyz xyz upstream/master" for the
same effect. Maybe we can avoid "xyz" duplication with "-b -" or a new
option name?

> Hence this
> proposal: "git branch -w xyz upstream/master" to do the same.
>
> The plan is to also support "git branch -d -w xyz" once the `git
> worktree` command learned a `remove` (or `delete`) subcommand.

"git worktree remove" is coming (will be resent after -rc period). And
I agree it's convenient for it to remove the branch as well because
that happened to (and annoyed) me a few times. I still think it should
be centered around git-worktree than git-branch though.

> One possible improvement would be to add "/xyz/" to the parent
> repository's .git/info/exclude, but this developer hesitates to
> introduce that feature without the "delete" counterpart: those exclude
> entries would likely go stale very quickly. Besides, there might be a
> plan in the working to exclude worktrees automagically?

That's needed because you add a worktree inside another worktree? I
know that feeling, but I've changed my layout from ~/w/git as main
worktree (and ~/w/git/.git as repo) to ~/w/git as a non-worktree dir
that contains all worktrees, e.g. ~/w/git/reinclude-dir,
~/w/git/worktree-config, ~/w/git/lmdb... My typical worktree add
command is "git worktree add ../<some-name>" then move there and do
stuff. No nested worktrees, no need to update exclude file (and no
messing up emacs' rgrep command, which does not understand .gitignore
anyway)
-- 
Duy
