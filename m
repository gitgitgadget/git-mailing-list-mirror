Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA47C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782A022207
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 18:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVYuyGkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgIKS5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 14:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgIKS5O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 14:57:14 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F12C061573
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:57:14 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w12so10905577qki.6
        for <git@vger.kernel.org>; Fri, 11 Sep 2020 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YrtusjFzyz7ojQOW3HRtkG0En4quk4tFk+TcW7vkXGI=;
        b=AVYuyGknOLphTkw4sSIgBdBd4aJq3VM0+i3XmExl1WDqz4qiwIDLoQO37//VxAWNHz
         Ih/ttSyVrjh1VE0xSd2voIrPVh3W9O++v6q/SIUMTyVOu291ykUH9NPLMtqBgFXqPiiT
         Lv9tM3FKm9S/1XXhPcsgPH2OMtG3uEyK3zi/759zMmS6keiyEo2VsKsEeTX7hvtXCzgJ
         LOeR7p49utj3ja47ZMg7fVS5/dWj3dW/x1hw9YAvpARc/f0lE7Cz/y5jNBVfJ7XU2BsM
         Yj3d5p7YNuiihOJwUlJ3MmSnZnSpiy/j4hjObAqbz+OVNbhHs2U39f1Sza/QvEj7c7NG
         1c5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YrtusjFzyz7ojQOW3HRtkG0En4quk4tFk+TcW7vkXGI=;
        b=ENMvmTs1jQuF2TioJ0Q/w/Tb3Va9pVxKH7sfvwy6G78o7TrFBn8XaOEXI7hzeJNeSP
         U6dQKKTjAHPtkOJnKf7LJKQ4Mr9BzdOwUV8ZeZWevmP1uL3JXC8NytDmZTA2Le2tLmq6
         vUK2avop1FpEikm6xQ8kmGdGCt+kuhfH0UYjqHQiqTBEAs3vZdficFXwMiVQ5Qm4fixH
         9DTyDtT4wTP13nMFZrmuUg3HPrHrqcfvBDOqytlh/n2nwM2ZfJMXvOCkVqTRce3Qz7Ei
         cc1LK6gam9gXGRiMuGb2SNbR1+nfkYni+ywuW/Zb4R29bM4m1ueNEqPtOFdlzR0PzF22
         XzTw==
X-Gm-Message-State: AOAM530QoT3ZhAoSQ1htlAfq48zVWaVA2CMkKZIIZzNB52Dn8VAZg//3
        +xbyq/vciIELWfnNAqDRsGM=
X-Google-Smtp-Source: ABdhPJwiy8wocT8OMnicqjikE+Z5tpq8C+pOmlnqQijxnf5p2G1yFfJ+nFSgR6FxOTUnDwa3IBP9Ng==
X-Received: by 2002:a37:6786:: with SMTP id b128mr2913258qkc.396.1599850633500;
        Fri, 11 Sep 2020 11:57:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3846:6663:b768:1725? ([2600:1700:e72:80a0:3846:6663:b768:1725])
        by smtp.gmail.com with ESMTPSA id z3sm3763858qkj.0.2020.09.11.11.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 11:57:12 -0700 (PDT)
Subject: Re: [PATCH 1/4] clone: add tests for --template and some disallowed
 option pairs
To:     Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sean Barag <sean@barag.org>
References: <pull.727.git.1599848727.gitgitgadget@gmail.com>
 <4cdcedff313751da8c91d701c095f1051e759ce2.1599848727.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8f864b6c-4b05-a9d6-b649-5f7c50697730@gmail.com>
Date:   Fri, 11 Sep 2020 14:57:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <4cdcedff313751da8c91d701c095f1051e759ce2.1599848727.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2020 2:25 PM, Sean Barag via GitGitGadget wrote:
> From: Sean Barag <sean@barag.org>
> 
> Some combinations of command-line options to `git clone` are invalid,
> but there were previously no tests ensuring those combinations reported
> errors.  Similarly, `git clone --template` didn't appear to have any
> tests.
> 
> Signed-off-by: Sean Barag <sean@barag.org>
> ---
>  t/t5606-clone-options.sh | 44 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
> index e69427f881..d20a78f84b 100755
> --- a/t/t5606-clone-options.sh
> +++ b/t/t5606-clone-options.sh
> @@ -19,6 +19,50 @@ test_expect_success 'clone -o' '
>  
>  '
>  
> +test_expect_success 'disallows --bare with --origin' '
> +
> +	test_expect_code 128 git clone -o foo --bare parent clone-bare-o 2>err &&
> +	test_debug "cat err" &&
> +	test_i18ngrep "\-\-bare and --origin foo options are incompatible" err
> +
> +'

It seems that all of your tests have an extraneous newline
at the end.

Thanks,
-Stolee
