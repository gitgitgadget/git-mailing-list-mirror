Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4418C2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 12:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756897AbcJYM0Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 08:26:24 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36387 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbcJYM0V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 08:26:21 -0400
Received: by mail-oi0-f43.google.com with SMTP id m72so94506917oik.3
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 05:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BJm+ekcEdi0uAldVU/b5/OIVuGh71MduN69uUYKV7Ls=;
        b=Jm9sgJovE7C4q85kDSfb+ysx7ViN5SEJ+URAPUCphU5DL02Vppn9nT6UZCQPtQlV5C
         USUwKGQShZxeKs5Kx5c6e0Cq4ZxmhFTKVS9NEv4XeQ/8FmT0IQ23ML29qoGl5As71Q8o
         VbOVEA/VHGBJKBDYAH1/JqSre9HTJCzIgBqsXaJPgF//3MCAjzN5ANOS3Kg71e7iaUkn
         KtM7h8Z8ODtfms3lWj3OotOm0smoBBvKhsbbjuiKvIas/e/DW3UjlRCnQvVd96Nes2cQ
         c6FO/jYT2DjsvSfSHmD8l2C6ZbpKqW/gxc8BkonmwHmDTR7fAHWjR3aO28Q4aA2a7dy1
         xA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BJm+ekcEdi0uAldVU/b5/OIVuGh71MduN69uUYKV7Ls=;
        b=cPGmau+1Zpp5/3aH+i+SINJe5bdhNAkjIjX89Y1koxp4fLlESXctC2YeKVN0u1ew7w
         R5S24THFpelD+Ifqbpbhxhal+eR/LMXcOawpOdPU0vcP3fFRX08kHdBs2MDID5oL9Lt2
         EZ+goc2IgzAX3VySvU7BvbQexUTK0GJdEq+4dDEbW9lbC4pIJEGoi3PVYT7kocMSzoVa
         An+TQrcXoqOIzvxe5FMHLqLGU+pCZHQLOrDRfXP4lHVYUsek1iGVitd9GO7FshN7FCy7
         pxA7qRHr5pSim5try89/J8B/17KN6FZkzGnvfCMYtboVN1ogeAEVrJgbICBcYrXk3fBb
         rmCA==
X-Gm-Message-State: ABUngvdcFtaJbmqXiK+VnHANdcwQxS/2pXw0aSw7gnNBbm3SUjLGZiHwntK99WeL6aQYB0kJzrngrLYb+w/eyQ==
X-Received: by 10.107.59.6 with SMTP id i6mr17273268ioa.176.1477398321388;
 Tue, 25 Oct 2016 05:25:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 05:24:50 -0700 (PDT)
In-Reply-To: <20161020061641.3enppkoxfzr76has@sigill.intra.peff.net>
References: <20161020061536.6fqh23xb2nhxodpa@sigill.intra.peff.net> <20161020061641.3enppkoxfzr76has@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 19:24:50 +0700
Message-ID: <CACsJy8Bk32TcivD-5UO28UhdbpvCcxTE71cxFO2p_A4TZ1+GVw@mail.gmail.com>
Subject: Re: [PATCH 1/7] read info/{attributes,exclude} only when in repository
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 1:16 PM, Jeff King <peff@peff.net> wrote:
> The low-level attribute and gitignore code will try to look
> in $GIT_DIR/info for any repo-level configuration files,
> even if we have not actually determined that we are in a
> repository (e.g., running "git grep --no-index"). In such a
> case they end up looking for ".git/info/attributes", etc.
>
> This is generally harmless, as such a file is unlikely to
> exist outside of a repository, but it's still conceptually
> the wrong thing to do.
>
> Let's detect this situation explicitly and skip reading the
> file (i.e., the same behavior we'd get if we were in a
> repository and the file did not exist).

On the other hand, if we invoke attr machinery too early by mistake,
before setup_git_directory* is called, then we skip
.git/info/attributes file as well even though I think we should shout
"call setup_git_directory first!" so the developer can fix it.

I wonder if we should have two flags in startup_info to say "yes
setup_git_dir... has been called, you can trust
startup_info->have_repository" and "yes, i do not call setup_git_dir
on purpose, quit complaining" then we could still catch unintended
.git/info/attributes ignore while letting git grep --no-index work
correctly.
-- 
Duy
