Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12443C25B4E
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 14:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjAXOkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjAXOkN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 09:40:13 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA549566
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:40:11 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w14so18512970edi.5
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UK4EU6f/TLUiZTJmkVmjrcUHZThGqH2xejJuAxq44wE=;
        b=H8uqU1PqW3EZf1iX8stDxQ3pM2NWyj3Jm6ONNPAp4h5mHp6IC+yfDUqkkG7aVDoN06
         u2qQ2lxOFwU9AQmPw4szndzSTTzmemOnPeskAK9mWTlKrqwpVynhkla1jmmserhy2IrO
         xGvRMny3gscbErAlZJiRjWZZvxE7/FqyTyGX5HPHv8CeYEh88Vu1Vd65nhwtNFHvC6cN
         MBYfw/eqcOiuUsdWFwRLd5kYm+kyPcBIIbJguLEHj3KJYXDiuGGWhC3jROzWtTyv76Ag
         97GgDH9Y7/MGh/Uj5Wxjbcsfp1dcNya0an9tN77diw/suPHQ/ufFVNT6+99qEUJ/s/q8
         K2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UK4EU6f/TLUiZTJmkVmjrcUHZThGqH2xejJuAxq44wE=;
        b=6GlGsDW0IRZ3ZszEt9GQEdIkh7dev0GwOdZYzc05NbRb7e6j8LP2RcimCKIkZ11Xrx
         7v9ldCozvjh1B3H/uCY6Q+Tx0mzM/dFr72gXo6FQ76/wnmxUCDGIbs0sFZlk7uRUndke
         s2NTfxhW5G1XGBc/hqhvlunED19Vveq7R+f/7tJCiXGGxgaifRm9CikSPXacOOcveeTU
         f9UWZlmwoXx7kI/oXh/XwYffSLBANe8gp9hc5p0Uco69+xqjV4Ld62dkbShEskL0ogF+
         APxfwEBqxf1ryZ+WlifcFASKNooJCsmE09Q63I+rStvcUefb3DmHfgo9rWLCgkITM4kY
         tIwg==
X-Gm-Message-State: AFqh2kpBJfxhf8yfyTmRiN+Uv3G6TkQ3y8n0bjUK1zXosAVN6C1xX2d+
        xJg8G05QeTi/5KvrEysMklQ=
X-Google-Smtp-Source: AMrXdXtRGSxc2rMvbKeDIRsLxcY5id6d/w43jlfm0N4w8E8axMkO9eHCXO2bh6qw7nbeaz0te/wOaQ==
X-Received: by 2002:a05:6402:4492:b0:499:b4e4:8a83 with SMTP id er18-20020a056402449200b00499b4e48a83mr31900560edb.21.1674571210082;
        Tue, 24 Jan 2023 06:40:10 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id em1-20020a056402364100b00483dd234ac6sm1093419edb.96.2023.01.24.06.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:40:09 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <3c836a15-f614-36f0-b0a4-efa1c3a496a0@dunelm.org.uk>
Date:   Tue, 24 Jan 2023 14:40:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/8] builtin/rebase.c: fix "options.onto_name" leak
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
 <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
 <patch-v3-5.8-3d5c3152f69-20230118T160600Z-avarab@gmail.com>
In-Reply-To: <patch-v3-5.8-3d5c3152f69-20230118T160600Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 18/01/2023 16:09, Ævar Arnfjörð Bjarmason wrote:
> Similar to the existing "squash_onto_name" added in [1] we need to
> free() the xstrdup()'d "options.onto.name" added for "--keep-base" in
> [2]..

Apart from the unnecessary free() I was quite happy with the previous 
implementation that renamed squash_onto_name and used that but this 
patch looks fine.

Best Wishes

Phillip

> 1. 9dba809a69a (builtin rebase: support --root, 2018-09-04)
> 2. 414d924beb4 (rebase: teach rebase --keep-base, 2019-08-27)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/rebase.c                 | 4 +++-
>   t/t3416-rebase-onto-threedots.sh | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 5859a5387d8..5c474fb6edd 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1037,6 +1037,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
>   	struct object_id squash_onto;
>   	char *squash_onto_name = NULL;
> +	char *keep_base_onto_name = NULL;
>   	int reschedule_failed_exec = -1;
>   	int allow_preemptive_ff = 1;
>   	int preserve_merges_selected = 0;
> @@ -1660,7 +1661,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		strbuf_addstr(&buf, options.upstream_name);
>   		strbuf_addstr(&buf, "...");
>   		strbuf_addstr(&buf, branch_name);
> -		options.onto_name = xstrdup(buf.buf);
> +		options.onto_name = keep_base_onto_name = xstrdup(buf.buf);
>   	} else if (!options.onto_name)
>   		options.onto_name = options.upstream_name;
>   	if (strstr(options.onto_name, "...")) {
> @@ -1836,6 +1837,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	free(options.strategy);
>   	strbuf_release(&options.git_format_patch_opt);
>   	free(squash_onto_name);
> +	free(keep_base_onto_name);
>   	string_list_clear(&exec, 0);
>   	string_list_clear(&strategy_options, 0);
>   	return !!ret;
> diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
> index ea501f2b42b..f8c4ed78c9e 100755
> --- a/t/t3416-rebase-onto-threedots.sh
> +++ b/t/t3416-rebase-onto-threedots.sh
> @@ -5,6 +5,7 @@ test_description='git rebase --onto A...B'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY/lib-rebase.sh"
>   
