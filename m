Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E6DC54EBE
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 10:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbjAMKjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 05:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241338AbjAMKiY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 05:38:24 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF1176AE9
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:37:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so18471728wmb.2
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EzG7vr8B/aynB0oI1V+ZkaFYaH5zH2vwZ1x0Ewp42fs=;
        b=ad0N4O9NXqO0d1ofcgkFzM+nZbe9QYEwmU1NUj8abU9A6ufd97W1nf5ZtjteqAKFHG
         fdLUNtv1GzpQqSooxZrGwGvd6k0i1ETLOY3suDMD3yo9uSCGpT7B+UlCD+OyrXItjptE
         kSzbBDOYdT+aTnRqakTsW/8qutzxqCvLgigvOH+A9xIkv+2Ten8+tCDEvg0pPlRHbVdu
         J+ubi6aIFGh5AA5aa38quByoZ3Mbt9fRNZfvGKOPon94uT/DFj/AVvi+RJlOnULPqcYW
         3Ypb9W1gstV+e+MGh9GvFk86Or1BkuJktvvgvHfy722Tb+RAxbDGAc70aMNGG+6OoQBd
         7Rsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzG7vr8B/aynB0oI1V+ZkaFYaH5zH2vwZ1x0Ewp42fs=;
        b=vkyE8tgvCFzS0GNjlnajdlDgFSvZkXAcv7NFa3aGPJRjr/hgyVg7cpoppTMG2WFIpU
         QrpHsD2muLLHqb+ICiamVCgd1oTSXSuVK/1AGOzoZc6OIxb2tlakQizugTdg/bmxPOg5
         6NhC0AzN6XJjVE75X1rgblkaaVJTTCQV3n6Y68In3FgpR+3VM5Xhx+G3o2pYS7BWxQ2g
         nOXP5MJ2VNzegVhiF+nLjxSvEXYz2hTluUe086EdEXyOyL5bpD+w465SY0BixnW9mnBu
         i4PC8ULrsg5yMTeEzVN1KxY12z3GwAUlsncImebEec/v5gdt6FPxDPoaNZ6KgsMbFQth
         nqqw==
X-Gm-Message-State: AFqh2kqaW/YI4B4aHM209dFy4e2kyMyoGrD6Jlj4pCqCN4/YjCEMPr2/
        XcuBnkjPRpPG/G0hBS2YdTg=
X-Google-Smtp-Source: AMrXdXsf6CSUB9MUugQmpZ235UMdO5VuphNYRo35dYK4WN7/MNZsEKoSA8+Ff2WIDa1fgcmCuc2C7w==
X-Received: by 2002:a05:600c:34d3:b0:3c6:e61e:ae74 with SMTP id d19-20020a05600c34d300b003c6e61eae74mr69539255wmq.4.1673606241946;
        Fri, 13 Jan 2023 02:37:21 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c358900b003cffd3c3d6csm26841817wmq.12.2023.01.13.02.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:37:21 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a16db697-1222-c0fd-b210-0eec3c181a5c@dunelm.org.uk>
Date:   Fri, 13 Jan 2023 10:37:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 5/9] builtin/rebase.c: rename "squash_onto_name" to
 "to_free"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
 <patch-v2-5.9-4fea2b77c6d-20230112T124201Z-avarab@gmail.com>
In-Reply-To: <patch-v2-5.9-4fea2b77c6d-20230112T124201Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01/2023 12:45, Ævar Arnfjörð Bjarmason wrote:
> The real use of the "squash_onto_name" added in [1] is to keep track
> of a value for later free()-ing, we don't subsequently use it for
> anything else.
> 
> Let's rename it in preparation for re-using it for free()-ing before
> another assignment to "options.onto_name", which is an outstanding
> leak that'll be fixed in a subsequent commit.

This is good

Thanks

Phillip

> 1. 9dba809a69a (builtin rebase: support --root, 2018-09-04)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/rebase.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 5859a5387d8..0d8c050f6b3 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1036,7 +1036,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	const char *rebase_merges = NULL;
>   	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
>   	struct object_id squash_onto;
> -	char *squash_onto_name = NULL;
> +	char *to_free = NULL;
>   	int reschedule_failed_exec = -1;
>   	int allow_preemptive_ff = 1;
>   	int preserve_merges_selected = 0;
> @@ -1589,7 +1589,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   					&squash_onto, NULL, NULL) < 0)
>   				die(_("Could not create new root commit"));
>   			options.squash_onto = &squash_onto;
> -			options.onto_name = squash_onto_name =
> +			options.onto_name = to_free =
>   				xstrdup(oid_to_hex(&squash_onto));
>   		} else
>   			options.root_with_onto = 1;
> @@ -1835,7 +1835,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	free(options.cmd);
>   	free(options.strategy);
>   	strbuf_release(&options.git_format_patch_opt);
> -	free(squash_onto_name);
> +	free(to_free);
>   	string_list_clear(&exec, 0);
>   	string_list_clear(&strategy_options, 0);
>   	return !!ret;
