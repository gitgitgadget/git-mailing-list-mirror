Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E02C43217
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 12:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKXMc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 07:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXMc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 07:32:58 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06762B623
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 04:32:57 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b29so1505694pfp.13
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 04:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EmJIcSrhgHZB6EYG6MgoPdTSdR8vkLX46oI3PCyezTo=;
        b=LfF5sdT8AsPMSC+bBXgX79K++HN2/vnXdBG7fRQvwrNhTJQmE8gzYdRatz22KwyfRe
         BAgoJeQVRY0pohKT7cQvWxq/Vr/o3xrcpi7JigoIBnBwdMAo91oRrN87XdYP9jpXTnxC
         dQNEoNDmTrxjq9s6qEdtYFuJiPdFL4bn7m0lM/1udw50yrCi5Gd9j37KowTRm2P98YFj
         lccyii34v664YcgXY+u1QTw6xogSO8bqaRnZs/8o6KTUxTIlvv1qnvzW65jpxDK9hV1y
         eJpqWZu7mbY3Iz2wlWFAOPQSNQK9tTLmoT9Hw4jxDuHhTHVcabrTVlo8g+lDAZzC4wTh
         r0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EmJIcSrhgHZB6EYG6MgoPdTSdR8vkLX46oI3PCyezTo=;
        b=Y4U70mxcqtGzfS8xhRVKlErS/EUEteK7WBWfCVA1b/JI82Eq4G4KpNGBhvw4UqAx31
         FPFZ/2U9DKQzQMNxMn5uYwtUE2geTZyyu390ye+iI/DSu9Qa2aNTlyZTrbfCJI9uKrsx
         tL744VKKdCihJ2BZwCo92bP6os5zlSpa3pT/7pUjCZrpLKUd1D5DYZq7SBOhJ67Kgq9I
         qeaaKkEzZZCBOW3YUOMmlTiyZRtMttHLnZwLlz5w3IiuSzwboOG6vDJiaDwz9S9yEHjn
         5tj6azwq7Z5ZQmnEmhOygTONS8PbTDF3VdYUauBeO7zOixID4XIQ8Wl6s6vunFZI5zy2
         ie4Q==
X-Gm-Message-State: ANoB5pkgmaXdlyXUqz6A8AXqi9BqzhFyhX733RdLgXKwNRL/m+FZW85E
        mmu31+WeUr3NMdWWqWPvFKCRKc5qCaJcDnqPfqQ=
X-Google-Smtp-Source: AA0mqf7q/8fGTczlXYZTYm7mLu8m42zJCVwKEc/sziSiZR7N2ztyxKPaYyTJy/bKxupFB9cfGv7+6yQ7MU44/BDl70M=
X-Received: by 2002:a63:c51:0:b0:470:4522:f64a with SMTP id
 17-20020a630c51000000b004704522f64amr12321338pgm.348.1669293177197; Thu, 24
 Nov 2022 04:32:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1423.v3.git.1669033620.gitgitgadget@gmail.com>
 <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com> <2f0bffb484beccf58f2440ed5e2c04a1ba26e6c3.1669126703.git.gitgitgadget@gmail.com>
 <Y30a0ulfxyE7dnYi@coredump.intra.peff.net> <CAF5D8-vSsBsdiA8SiDgqUFkL9_3N-v+psVxj-AcibOB88gxWfA@mail.gmail.com>
 <Y37EPdUkBhsSPmRD@coredump.intra.peff.net>
In-Reply-To: <Y37EPdUkBhsSPmRD@coredump.intra.peff.net>
From:   Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date:   Thu, 24 Nov 2022 21:32:45 +0900
Message-ID: <CAF5D8-u14grTa9cUo=ge8TVRKNYtVHWhFHDW8yYD9gD8=f0Byg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] git-jump: invoke emacs/emacsclient
To:     Jeff King <peff@peff.net>
Cc:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 24, 2022 at 10:09 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Nov 23, 2022 at 02:33:50PM +0900, Yoichi Nakayama wrote:
>
> > On Wed, Nov 23, 2022 at 3:54 AM Jeff King <peff@peff.net> wrote:
> > > Hmm, I know I suggested using a temporary file since "cat $tmpfile"
> > > should be pretty safe. But it does still have problems if your tmp
> > > directory has spaces. Or even other metacharacters, which I think will
> > > be interpreted by the eval, since $@ is expanded in the outermost level
> > > of the shell.
> >
> > Right. But the problem is not specific to emacs (it happens in vim too).
> > Let's fix it another time (as you noted, that's pretty unlikely, and we may
> > not even need to fix it).
>
> Good point. The vim version is easier to fix (we just need to
> double-quote \$1 inside the eval), but the fact that nobody has
> complained is an indication that it does not really matter.

I've confirmed the vim version is fixed by
    eval "$editor -q \"\$1\""

With your hint, I found the emacs version can be fixed
by single-quoting the variable (I found a mistake in the
emacs version. Since there is only one argument, I
should use $1 instead of $@. I'll fix it.), and the vim
version can be also in the similar form with single quote:
    eval "$editor -q '$1'"

The original vim version used the notation \$1 instead of $1.
I'm worried that the emacs version might need the backslash.
What does the backslash mean? Is it necessary?
-- 
Yoichi NAKAYAMA
