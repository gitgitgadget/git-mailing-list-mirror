Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F8BC25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 15:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjAVPCV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 10:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjAVPCU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 10:02:20 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4547EF6
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 07:02:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jl3so9197681plb.8
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 07:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvBPjblRHubwg8I7DZstYMsW9B+rGa6GkQ65IAxLKpk=;
        b=de50vqWTh7LL+04oeJbJ0IEjUkugmiYChrvmmQ1jjOKH8vRjAkynfqACG9saWRwBjw
         txHtHbUX15+QQ0YNrQpIqGsN9J6EztOt/BQtUQzSneUpciXjIxHx2q4xFr2s4mpkhHVT
         2HPoOS8Iab3+0HLDFpyUrz8yv9u3sUbaHCP0L63OHlpa+h/J4cUzdNcu+JGhu0uwCwPL
         l4pO0HEmfW5ZMk1F3Bq5Uaj26EYuY/oEL+ncSlustDiByW7Iy2n/17Aegc/u52MOaX/8
         g5EzreLrnhPXosKzTyGAjBCAeqCcdIodQmWuY/41trzsMJvAhd4LVdVILX9Zte9VlrhB
         7lRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvBPjblRHubwg8I7DZstYMsW9B+rGa6GkQ65IAxLKpk=;
        b=oBuIcJz88FlO7LHtejCTKhcnUu49VRr8bpbovEXJ+5cW0VCbcRPoP+vBMVSxnDoeYF
         uZwJRjgcYFFYoyI+/FaWZ1Xhgs9wc5hx5c0k7hL4lFs/hYlZKksvw6jwn1OdBEyuq9LQ
         Ln4EYq4siGEgPsHnaArU4OjyMJseTZ5UIDUKb2E4BzOeAKklszblooQpzqs2r9L5zJbD
         Oyeqn9yONwPZdneWxERLUUGwsSaMMhc7BiPYfLfRjLUaXJwEJ2mdcpcKQZMLEu61ZQ/F
         1kD21zrY3EvRFaa72Hx6RlDnOpe0I2CpZmRMylxBk3nesVjdrBwpdYhfAeGuXqIQsq1k
         pChQ==
X-Gm-Message-State: AFqh2kog4meWptYuCaqAJKnXkzntl78HSrmIw45jQxe5vnQP/g8OCIOW
        nTbHhF4Yk7eY7fDDpgQnXrX3WSRqcKoDI9f5
X-Google-Smtp-Source: AMrXdXspVbYDQvvjZLo8WSU/Yi22Ixswf3scjHF4prA9lYHzhzY762Jp2FiuTzWyxuqWgfuKMiC6CA==
X-Received: by 2002:a17:90a:d342:b0:229:72eb:750 with SMTP id i2-20020a17090ad34200b0022972eb0750mr22811471pjx.8.1674399738537;
        Sun, 22 Jan 2023 07:02:18 -0800 (PST)
Received: from initialcommit.io ([2600:8801:9c0a:f300:246a:6216:f05e:8318])
        by smtp.gmail.com with ESMTPSA id j29-20020a634a5d000000b004d06a8938absm7934748pgl.64.2023.01.22.07.02.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 07:02:18 -0800 (PST)
Date:   Sun, 22 Jan 2023 07:02:15 -0800
From:   Jacob Stopak <jacob@initialcommit.io>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] git-sim: a command line tool to visually simulate local
 git operations
Message-ID: <Y81P9w6osdfUcxb9.jacob@initialcommit.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been working on a free and open-source dev tool called "git-sim" which
allows devs to visually simulate Git commands using a git-like syntax directly
in their local repos from the command-line.

Posting it here to put out some feelers and to see if folks in the community might
find it interesting / useful, and if so to get some feedback on how to improve it.

The goal of the tool is to help make Git more accessible to newcomers, as well
as to allows users of all experience levels to get a clear, visual idea of how a
particular Git command will affect the state of their repo before actually
running it.

Think of it as serving a similar purpose as the --dry-run option that some Git
commands have, but where the result is an output image (default) or video
animation of the impact of the Git command in question. My hope is that this
could be a great asset for visual learners.

Git-Sim is written in Python and leverages the GitPython library to interact
with local Git repos and Manim (Math-animation) library to draw and animate the
simulated Git command output.

Here's a link to the codebase/readme on GitHub detailing what Git-Sim does:

https://github.com/initialcommit-com/git-sim

Supported commands so far are: log, status, add, restore, commit, stash, branch,
tag, reset, revert, merge, rebase, cherry-pick

So far the functionality is quite basic, but built out enough that hopefully
folks can get a decent idea of how (and whether) it can be useful. I'm sure
it has bugs and obvious enhancements to be made.

All thoughts/suggestions/criticisms/ideas are welcome.

-Jack
