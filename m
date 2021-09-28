Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C8EC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E479611CE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 07:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239424AbhI1Hz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 03:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbhI1Hz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 03:55:59 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249DBC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:54:20 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id u1-20020a17090ae00100b0019ec31d3ba2so1129027pjy.1
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 00:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JwmHUAxkDxCbSn+qL7D5vJMDPvRL7bBvg39UhwiWUZ4=;
        b=fm3f0vPw2/MfK7cAve+oEnknhbIpU/adU3AhFjSADOHYaX4vK/7z2d2zNxz9wPlC4A
         CssbKvR+NScjM0mGyxmCR1PBTgTrAA/G1uhYmQFmzejutLo+lbFUIWEeZ+TH54+ErdBU
         5HzYwziq8OkjuILbissAhEa/dTM8meSRwFEIWy3ByqRKrIM1IxgPnRv7pHo95kASYboK
         ZeiV6L5v9rF+sSss1l/DsyZscQxLIzknxqfW5a9d33S0IAA9dDZuWQ0c1E5jFFuESET/
         w1aGThCeODGTH25q/CONXMYyBFKmZuW9GeNOzp2K2NPDby60LSYqlMRCPWyjo/yhwSo8
         7d9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JwmHUAxkDxCbSn+qL7D5vJMDPvRL7bBvg39UhwiWUZ4=;
        b=DzKDoYvMqeGWTvro7YuPZPNrYjrCvP4mCEBl6Kzm3biT8mjcRKwxIOJ8rHtVcRWZV8
         x7girJ3W2jqKwitbZhQM1WFW41QcD6vgLR82KLKIf7bSKKmnUbS5P9Vz8XEGBWxUL2wI
         /G1QNSQdTfRSZI+RoMgTUF/5I9dPV+k4YEI0y8Lfkd1mi4lF42UExaxsMh3ahgALBSMm
         QdoATdnrkdFDJ14m/YkTy4Xij39Uwac/+cKSwwyXLk5CksWUovXutNpgzDWH+4F4L7V9
         fTJ7JHuOSoJUZfjELTjBpWQ5zDlHR5jy/0KeOcY2gfMkEQmkkQLkxDkX0ElgPEYm9FhM
         Qa3w==
X-Gm-Message-State: AOAM530OPTQdGq1WLfMaHtgDS7hzjtC0Q2IqYXKQePL6eWsAFmxNKWmL
        GTzoi8jzjvF82vtQV922PCpZzOwT+u0Img==
X-Google-Smtp-Source: ABdhPJyyMigPkZdwNgt3ltUS8zxA9x86JvqHfa2b+iuOyzwd5ALX980fx2qpHED+BtrYj2q+0S8tqw==
X-Received: by 2002:a17:90a:1a11:: with SMTP id 17mr3939535pjk.234.1632815659408;
        Tue, 28 Sep 2021 00:54:19 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-54.three.co.id. [116.206.28.54])
        by smtp.gmail.com with ESMTPSA id x9sm20253078pfo.172.2021.09.28.00.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 00:54:19 -0700 (PDT)
Subject: Re: Issues with newest version of openssh 8.8p1-1
To:     Kevin Kendzia <kevin.kendzia@googlemail.com>, git@vger.kernel.org
References: <CAKcQ8=cyq46=eF8NZtUifmfHgWUphmHPYh4s3oQrHjiX2nqEmQ@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <6a47ba98-46f2-59fb-20b3-b9b507aac243@gmail.com>
Date:   Tue, 28 Sep 2021 14:54:16 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKcQ8=cyq46=eF8NZtUifmfHgWUphmHPYh4s3oQrHjiX2nqEmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/09/21 13.40, Kevin Kendzia wrote:
> Updated to openssh (8.8p1-1) and git didn't get the keys anymore.
> Couldn't pull or push. After reverting back to 8.7p1-2 it works as
> intended.
> 
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> Updated system packages (openssh)
> What did you expect to happen? (Expected behavior)
> Can git pull without issues
> What happened instead? (Actual behavior)
> Permission Denied due to key error
> What's different between what you expected and what actually happened?
> I couldn't push pull whatever because the keys haven't been recognized somehow
> Anything else you want to add:
> I reverted from openssh 8.8p1-1 to 8.7p1-2 to make it work again
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version 2.33.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 5.14.8-arch1-1 #1 SMP PREEMPT Sun, 26 Sep 2021 19:36:15
> +0000 x86_64
> compiler info: gnuc: 11.1
> libc info: glibc: 2.33
> $SHELL (typically, interactive shell): /bin/bash
> 
> 
> [Enabled Hooks]
> 

What remote you tried to push or pull from? What key do you use? If 
you're connecting to GitHub, see [1].

[1]: https://github.blog/2021-09-01-improving-git-protocol-security-github/

-- 
An old man doll... just what I always wanted! - Clara
