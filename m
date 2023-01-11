Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD8DC46467
	for <git@archiver.kernel.org>; Wed, 11 Jan 2023 14:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjAKOzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 09:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbjAKOzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 09:55:09 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50E719C13
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 06:55:08 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id e22so1440405qts.1
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 06:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mn6GNxNbSCyJdyGHp+JuWuYBBBLlvxnHGs9KANtRD5M=;
        b=j0iyn0ytO/f+Khod+/DzBtREBC+4/cx3Gtbel8e7MTw7qNNJcpYj+zeKASczzg4M01
         87eScqfGXpASNEUEkbNDG+otlvsuJCowgVyvnqGnHktS54amOISyZpJJYhLNgm4xZMni
         zDVMSvcVHcTbH7qPNLZMjs9reodO458oMmYjNNU08OMJXfY2nQrsxQUXzIGdgmVT9Jyu
         fXO3/XPce44NWlqG4/j3S1Vp13NtXapRBmkvfW26Cetgp0C684EUpeG9KnYE0W4VDsOa
         coDdv+S249Li4cFkRRlGOm6MVskTRREFqlc8R0GzRx/2wc4jwN7gu9r9u4jqDp5WdiGj
         loGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn6GNxNbSCyJdyGHp+JuWuYBBBLlvxnHGs9KANtRD5M=;
        b=5Lgag46AxNcz/FlfMjvp0jnkMwU9ou8cKHz2UZpJ7TXGvNHxgnZICXM4YKekAzwxya
         BMwVC7tmd/PT7Hsz8kkTEzdfv/HFXRQ+LHFwofwWEQD/BiFBjemM7emrqurs7xk0rBdH
         F8zDylvXa1BXrEBN5AYqblMRVSNveO428sYIgtjtfSVFoy6ReOHHBouGW73G3+RHBeaL
         Z1TXLwNPKs5WSsU4cvuW41N7w1bGxhy0rH/ZhmfnTfpPXHqWeD9jECXanfF2IKREmqPP
         OaWvbLjJ1k2lKTZqTfuGyCNth4YDeval7AAc91ku5rmsS8FMQX7/4QInvYiO8UIysSDY
         it9A==
X-Gm-Message-State: AFqh2kqRjnjapT1GjfQ/A0I9bGbdWDiBQ636e+5peuZesPJuKwIogxhE
        pTdrm3I1VhAk1kxO4Lg6pGed
X-Google-Smtp-Source: AMrXdXuf/giapIQzn9DetSD5UhoqdPCJ2gS+vuDZ9PZFKD3CBxcyXHC2xKXMN8MZTocSTAJsvmy0Sw==
X-Received: by 2002:ac8:774c:0:b0:3a5:f9f8:3ec4 with SMTP id g12-20020ac8774c000000b003a5f9f83ec4mr9089143qtu.30.1673448907943;
        Wed, 11 Jan 2023 06:55:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:88e6:17dd:15a5:edd9? ([2600:1700:e72:80a0:88e6:17dd:15a5:edd9])
        by smtp.gmail.com with ESMTPSA id i14-20020ac871ce000000b003a4f22c6507sm7681801qtp.48.2023.01.11.06.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 06:55:07 -0800 (PST)
Message-ID: <9d8e38fd-f001-5aa5-ab78-cc6d314df09a@github.com>
Date:   Wed, 11 Jan 2023 09:55:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] scalar: show progress if stderr refer to a terminal
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1441.v2.git.1671974986363.gitgitgadget@gmail.com>
 <pull.1441.v3.git.1673442860379.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1441.v3.git.1673442860379.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/11/2023 8:14 AM, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>

> Range-diff vs v2:

>      -+test_expect_success 'progress without tty' '
>      ++test_expect_success TTY 'progress without tty' '

I think this addition of the TTY prerequisite is not necessary...

> +test_expect_success TTY 'progress without tty' '
> +	enlistment=progress2 &&
> +
> +	test_config -C to-clone uploadpack.allowfilter true &&
> +	test_config -C to-clone uploadpack.allowanysha1inwant true &&
> +
> +	GIT_PROGRESS_DELAY=0 scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
> +	! grep "Enumerating objects" stderr &&
> +	! grep "Updating files" stderr &&
> +	cleanup_clone $enlistment
> +'

...because the test doesn't use the environment details for
mimicing a TTY. The point is that stderr is redirected to a
file and isatty(2) would report false.

I don't think this is worth a re-roll, though, so I'm happy
with this version.

Thanks,
-Stolee
