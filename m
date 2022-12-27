Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E5BC4167B
	for <git@archiver.kernel.org>; Tue, 27 Dec 2022 16:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiL0QrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Dec 2022 11:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiL0QrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2022 11:47:03 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2895E393
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 08:47:02 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l26so8099620wme.5
        for <git@vger.kernel.org>; Tue, 27 Dec 2022 08:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tD/BndObqcMomes6KrpXiXnjKVkbcdRSOLr9ZHtNozQ=;
        b=VjS+lpiN9ReylXL4EfjqdlvOIYO+T5IRnlJl9RVs5aFZPY943w1+0nqqyEcZdwWLx+
         2MGppWMG04ld011LJev3E1FP4j8NCGCw/cZLH2f5HFss6OgewEhDXnLU0gU3+rG3ysP6
         GhCXuf5etTRp01i805xu/SuEbr1fiPnyi/gyIZKq3UrPBZaf2olQZO1rg9rZKvUwIXUO
         +CelT1O9/MGFvkrOX0f1Pb9PHSYC5DvdJeQ1O7h99UuwVpQevl0J/GSi+sCK7YsKLg3d
         nWZIfh1XSpL8i2vGv+qj9lIYFyIo3Hzp/Yy6G2LEmrVFTJ5/ixEHy45a9C68p7ybyIAB
         cgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tD/BndObqcMomes6KrpXiXnjKVkbcdRSOLr9ZHtNozQ=;
        b=gTJ/jcf3jLAxqM5ayURxlYPE9YubXAAf9X60174C4nqiMIj+qgjLUsp1YNEoSN7zcb
         QwgPyMRy1mgjofZRhteQwmjowAaAcE5OZcJdvkfzhVHuKdu1Qqs/ef4EoqcmDbyqvfCJ
         Zur3FvBDo2RNOyRwU2/yYFEbH260XQWdzkHotYGNADagY4A9rVdCwgwSrWjjnYopRGCF
         NmWIOEYI5GkxyqaM4ou7IoAkf5o/mPhvBMR75On5pZoRq3K8EFsyRRLk2BAh7uXt9fpp
         ZSVAgMycdIIFZx/0MVfW8ojTgbhVr3PY4c9+xfnZlWn6Wl7NC0EW/33f7v0NrfJNCiZ7
         678A==
X-Gm-Message-State: AFqh2krRdDqsyaDZGWDCGh7Z93PaANlw4NlKOPzojMqbul8okFPG9RuK
        kK35+tz3worjUPAGDOiQWl4=
X-Google-Smtp-Source: AMrXdXsUVJsMCH2uiEm/jAKJ3TrZaq5tgUMB/N02q9J5ID20ChAsHcSqNkOmW1cvLCQ72wxIl2O9SQ==
X-Received: by 2002:a05:600c:3789:b0:3d1:f234:12cc with SMTP id o9-20020a05600c378900b003d1f23412ccmr16257113wmr.33.1672159620758;
        Tue, 27 Dec 2022 08:47:00 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c35c900b003d96bdddd3dsm18250217wmq.15.2022.12.27.08.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 08:47:00 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <6efe13ea-8782-2337-1626-9687e2219680@dunelm.org.uk>
Date:   Tue, 27 Dec 2022 16:46:59 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 6/6] tests: don't lose misc "git" exit codes
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <cover-v3-0.8-00000000000-20221202T114733Z-avarab@gmail.com>
 <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>
 <patch-v4-6.6-94df7a1764e-20221219T101240Z-avarab@gmail.com>
In-Reply-To: <patch-v4-6.6-94df7a1764e-20221219T101240Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 19/12/2022 10:19, Ævar Arnfjörð Bjarmason wrote:
> Fix a few miscellaneous cases where:
> 
> - We lost the "git" exit code via "git ... | grep"
> - Likewise by having a $(git) argument to git itself
> - Used "test -z" to check that a command emitted no output, we can use
>    "test_must_be_empty" and &&-chaining instead.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> [...]
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 5841f280fb2..f1fe5d60677 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -296,9 +296,11 @@ test_expect_success FILEMODE 'stage mode and hunk' '
>   	echo content >>file &&
>   	chmod +x file &&
>   	printf "y\\ny\\n" | git add -p &&
> -	git diff --cached file | grep "new mode" &&
> -	git diff --cached file | grep "+content" &&
> -	test -z "$(git diff file)"
> +	git diff --cached file >out &&
> +	grep "new mode" out &&
> +	grep "+content" out &&
> +	git diff file >out &&
> +	test_must_be_empty out

"git diff --exit-code file" would suffice here, we don't need to 
redirect the output and check that it is empty.

Best Wishes

Phillip
