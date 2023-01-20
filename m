Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A13C25B50
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 09:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjATJ4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 04:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjATJ4U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 04:56:20 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6083E8BA8F
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 01:55:37 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z31so459468pfw.4
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 01:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iX1LTF8GuiGfs/s7oTe/jbCzIlgmnwmhMVNMEpiXjwY=;
        b=ao9pgR0nf90d1P6FgdxKtTHoFYAi56dV3jf6m+ScxdMGUoLbGv208AdKQQxHf5+vzm
         ypv3tbSmgGLkWAyowqpMD2temRXTg2gcyQATzLEHyGWrZcFt6kUKe5d/Wro5u/UGsWVW
         UjolPTQTmm+6p+3K2A2glswd5qaj+iGQuuOQgG1mtEIJA+uK5T1+lESUgZ4kLlQUkjv9
         RNfx5Rahfj1FX6hT7fBLKfuDuWaqg8HKVM0FdIIew9tJbLDIoZhN3tKXqV1+hEniZ4y2
         3/NthhTGP/fB1ntF+Fdwsw+ouGHyWlrV1OFwuzAAWPeJ/LG47WNJ1DCHGA+6H6Jj5PUE
         v9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iX1LTF8GuiGfs/s7oTe/jbCzIlgmnwmhMVNMEpiXjwY=;
        b=p1hn3AEx1j1bNPsFKa/MtnLyxfRuRWuYwr9WUKTP2CfQQVJo7k4O0Qe+/fHA1EE6/+
         qMjyYDN7R9jhF+FnIWiRA47rTpjifZnIO8raJJoRqHea+ir5WddpCzF/maKuOXscPiEM
         JWw5/gZveutRaRquOTZXRUxNn2cWifiZ6SYmLa70r7HvuI3+SDdOg/QywgxI9UNBey4a
         BhmrU2dSnD62Gh9qh4E10BCp7kq0S79Gis5xlANrulLM0GMgfM7fcAT6ENDI98Njkv6R
         P7CaTD0mCyksrHwelYRm2xLTQt3tAzBokNaNE4a31EBAh+14F2dk40+ynDRn/slIf/a/
         jhog==
X-Gm-Message-State: AFqh2koULkYU2Vte8pACGDFJd38qF9AG++ocrZQ3QjCn3BAqAiExjl4Z
        LmufV4Q9N/n58+ygSiRuHO5aoOpMRHOWSIZMR3JC2K1+fSjaFw==
X-Google-Smtp-Source: AMrXdXsTD186DGKJ5PVw4dz5d127tFjKM2EQ29wmqYZYahEHuHxylZ+pG1lIqroYovNoRVftw78umRS1Gj+mblS2HZA=
X-Received: by 2002:a62:7b58:0:b0:583:3c8d:266a with SMTP id
 w85-20020a627b58000000b005833c8d266amr1556063pfc.72.1674208536747; Fri, 20
 Jan 2023 01:55:36 -0800 (PST)
MIME-Version: 1.0
References: <pull.1466.git.1674106587550.gitgitgadget@gmail.com>
 <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com> <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
In-Reply-To: <a0f8f5fac1c3f79cd46b943e95636728677dffef.1674190573.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 20 Jan 2023 10:55:25 +0100
Message-ID: <CAN0heSo8cqNqhx9+AJZJS2rwJxBG_HZjhgxQZf8nw5t82NDXBg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rebase: remove completely useless -C option
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 20 Jan 2023 at 06:27, Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> As per the git-apply documentation for the `-C` option:
>     Ensure at least <n> lines of surrounding context match...When fewer
>     lines of surrounding context exist they all must match.
>
> The fact that format-patch was not passed a -U option to increase the
> number of context lines meant that there would still only be 3 lines of
> context to match on.  So, anyone attempting to use this option in
> git-rebase would just be spinning their wheels and wasting time.  I was
> one such user a number of years ago.

I suppose someone might have something like GIT_DIFF_OPTS="--unified=20"
meaning they would actually have more context for their `-C` to act on.
So I guess there is a chance that someone somewhere has actually been
able to make use of `git rebase -C` after all? I'm not really arguing
either way -- just noting the possibility, as remote as it may be.

Martin
