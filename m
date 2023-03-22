Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF38EC6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCVQqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCVQqj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:46:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267ED637E9
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:46:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ek18so75548695edb.6
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679503583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tfk1tSjhB0s8YqYENPIDTk6Dv5X3uHixukpEi9Iqu3Q=;
        b=h23yDUcDFM8hc9FS8ujaZS+8JoSh2VVFIOhQL8/+XNxZHIsW+GM1y1j0QJLFDQF9QQ
         8mItc6trnt0gr8zDWJm0XutXUXfnggufjF8WaBjwpu0VPqEYPI1KLnilyWwCVNjPrznE
         5dHNshq02zdPG7gJOJ7eQ4JgkHSHE0KmzjuqzYbcbaCle6KilOnnPP+nL8tMI3HWmv7Y
         YGas+kxX1T1CZroWP6y0vi3vPFHmuOXJf598dUZeCC3GkIak/IQalbALI+yumvpmqupn
         wX+vz8cgcJgvAawRkeFuBWYjTcA0+pk1SFcMRHb2A1bwPLykwUF5DUoAHKO7PxtTb70z
         GqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679503583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tfk1tSjhB0s8YqYENPIDTk6Dv5X3uHixukpEi9Iqu3Q=;
        b=zFutenL6fWlgWEfsOBGQ+vQWpmAJOt5PfsvW+Qi1rCvZonk4cB5BOHTw+hLkdBtDVU
         g/HLxjyXJKZGrkjawYiJ3lH5vj9GYpraWe2qERM1EdVFBG+5b7Z8piuT7yOLne8lyNOn
         q10hgTyMitgFdufesmZQndg5aGE6f8OSvLXs6dArimRvRK8hE2WGv2qD5updjCoReQi1
         CxSOYoTXALgLPV35mtODLJEyKL4ZDKKE2phytAh3s4glGrIE2TVfAiYSGbGQX5D/wEu0
         KtH4t4148A5fjLJajSqKuJZTtSZwByjcwv/e7D3a8e2BLkVD1baxIPI2J+fB7zUbKAf5
         ykOA==
X-Gm-Message-State: AO0yUKVFrQ0TWbw38Yy3VIGF57yLlfm6DZt6eBlwmD6CKhIFYdGgwfq3
        gLP+GtEpQvHs3RZU7wgkpSEKa4nuBK4l/OL4WzZ2Yg==
X-Google-Smtp-Source: AK7set+7hCNAPEq+wg9nJVGnCbrzhxwkAqvL/dcrZ/+zWT7bAgXZFnJmzUgsCBLFfOZIsqT5NBj944O+5enQZjCdgZs=
X-Received: by 2002:a50:9990:0:b0:4fb:7e7a:ebf1 with SMTP id
 m16-20020a509990000000b004fb7e7aebf1mr3764803edb.6.1679503583507; Wed, 22 Mar
 2023 09:46:23 -0700 (PDT)
MIME-Version: 1.0
References: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
In-Reply-To: <593742E7-F0FC-471C-AFF5-1E855A3788B0@mac.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Wed, 22 Mar 2023 09:46:11 -0700
Message-ID: <CAJoAoZkKTGzgVyL2wM9a4VcFObx4YpjMSatH9Bpqcgyi=zzBrQ@mail.gmail.com>
Subject: Re: BUGREPORT: Modified files on a fresh clone on M2 MacBook Pro
To:     Sjur Moshagen <sjurnm@mac.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2023 at 9:38=E2=80=AFAM Sjur Moshagen <sjurnm@mac.com> wrot=
e:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> git clone https://github.com/giellalt/lang-sma
>
> What did you expect to happen? (Expected behavior)
> Clone to be clean, as reported by git status
>
> What happened instead? (Actual behavior)
> git status reported four changed files

It would help to know which files, or what the difference was, so we
have a chance to figure out what happens without having to go and buy
a Macbook :)

>
> What's different between what you expected and what actually happened?
> Nothing except those four files
>
> Anything else you want to add:
> This only happens on an M2 Macbook Pro. With Apple's git (1.37.1), a huge=
 number of files were reported as modified.
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.40.0
> cpu: arm64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Darwin 22.3.0 Darwin Kernel Version 22.3.0: Mon Jan 30 20:39:46 PS=
T 2023; root:xnu-8792.81.3~2/RELEASE_ARM64_T6020 arm64
> compiler info: clang: 14.0.0 (clang-1400.0.29.202)
> libc info: no libc information available
> $SHELL (typically, interactive shell): /bin/zsh
>
>
> [Enabled Hooks]
>
