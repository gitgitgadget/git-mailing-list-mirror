Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47385C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiF0STL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbiF0STK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:19:10 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3080BE092
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:19:09 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i5-20020a170902c94500b0016a644a6008so5679583pla.1
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x2HPCDmuuIidWeMSUMX9HHOcr0X3/8+W8t0pzBQdqe8=;
        b=WAmyNuUv1f6anR/JJqnhWikRbUIBn+pzCxAJWsWqzybViW/9u/H2t0XhmA061xlW0d
         1KgG9vhKFbaUXtATMQkuxqpxJw/U4tPH9brJGdYsi3P9AaX0kLRMaDUPSRcbbMryOmwf
         lqUyMHQIdHlKQaXHZiRPNfKWnEeHcU1mY9t2IS5oOlEyMbmBG/7usrzi/9OJxT9OWDLe
         cl3dgjia9V9k7clwrvuCp8SC0gxMI5kzHXIYaDuhKPC2wr8258FMnqnxtYq14nMRuveK
         a2Mk4z+9NVSf2GCRuyVIkE0q9EazHHLgQo+6wDjNbl0VOczG0eHUE+oaFytl76n6T6AQ
         JSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x2HPCDmuuIidWeMSUMX9HHOcr0X3/8+W8t0pzBQdqe8=;
        b=wW7zeTXG8SVW4Hs8kf8VQN2mT8Kvjg+0E045V0XKhRX3MJTnaSpXSHbtMGAAi1iHof
         tUKdopHoUa9DFbpZjVOfPHbpRGfmVudwK8vLumyXw3nDqNQqMSO6uYELwzvqWIiM8xkJ
         zfaCGK8BDJJuKPFGdERNZnpC+moVFNAk+HZwK6l6ZUkbD/gWTjKMgQtDUEi/mlQkNjsE
         6lJNksra4CNpJCodDsDwxTr+d0voiOTen6rRrbBUndAfPh4eyV8JC2NUvJd5bi2LwqIm
         QBcz3Fh2P655Rof3ihBa+CAa0KJtwuB5CM4tMNoUNabl9ua3f5big4CRXSgwsdGNjmH0
         2xtw==
X-Gm-Message-State: AJIora8MTmT8WcAnrO/saiE9WD5OtP7ARu50nB6d1BaqRfML5vZR5Kds
        xumK6KJacjOyl9Rcp9rdDP/U7Bu1o2IrAw==
X-Google-Smtp-Source: AGRyM1s+7x2zIpR09Hurjf3JM516eotL8M+L84tRna6JvEGyy/Hjf+EG7OrJ2gEfz5M6JPmrlpn7/rcyIWgPaA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:2347:b0:16a:44fa:995b with SMTP
 id c7-20020a170903234700b0016a44fa995bmr737297plh.89.1656353948672; Mon, 27
 Jun 2022 11:19:08 -0700 (PDT)
Date:   Mon, 27 Jun 2022 11:19:07 -0700
In-Reply-To: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
Message-Id: <kl6l7d52hsv8.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com> <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
Subject: Re: [PATCH v4 0/5] config: introduce discovery.bare and protected config
From:   Glen Choo <chooglen@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This round doesn't introduce any major code changes. The most notable
> changes are:
>

[...]

>
>  * I added a test for "git config --show-scope" and the 'worktree' scope,
>    since 'worktree' wasn't listed in Documentation/git-config.txt (6/5).

Erratum: This patch was sent as gc/document-config-worktree-scope [1].
Patch 6/5 obviously doesn't exist.

[1] https://lore.kernel.org/git/pull.1274.git.git.1654637044966.gitgitgadget@gmail.com
