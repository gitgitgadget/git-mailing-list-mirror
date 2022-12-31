Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D96C3DA7A
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 14:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiLaOuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 09:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLaOuO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 09:50:14 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB49FFA
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:50:13 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z16so6071595wrw.1
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwKfInM+ZiSHJNwg5d9fYOmkqMboeA6X/pXWqfYYedM=;
        b=DeH1KySrKS9WTxOp+ZCNAGL+tbJALMt9xjQeEgTJ1U3j3OBUESSx1peAsPDjBDNlSF
         aW3sTZ7Gh3/Htyi5RQJNXiQ6TUPdzmREfw2A/Gb0BBULrWy1UR9pSZx7FPSe0R843FR5
         hAzJzLkkTw354dDofexzb9VTcCef0UK2W4V/cCglLGvhVVIt6AxtzVNM2A1T881mzJ80
         yh9cUmeCCXlavzrarsG+9Swcy1mzuGKkk+2YBm8T97OYFH/z0TkExvjdHeLl/MjD28bz
         9Mo0pcUkGG/Ki6bIQ2Cab9fgoP+Erha2meB4hiZ3wAbBsWeeNXm372RWCIjcgbTuk5dG
         6PhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwKfInM+ZiSHJNwg5d9fYOmkqMboeA6X/pXWqfYYedM=;
        b=t2NFOVil72hkPIUjPpX8Y/IylaKwYAE/ZXwdmQTgbccrMzICEJOJC1Jq87nLH/U7qV
         H1L2QrSzc1wyFjqMVrvYFUI8m1Qs5s0IhPmTzoWGtYUjZxq8XrjxxZxUi/DfBG7JGY0T
         kzjI3DU5y548YoSjykothlVP8EZTeXWbhLGjQ5Mdu0Esovv2UO/oRAkq+QKeiay1g/U+
         weKaCg3R+5MubIvHwXjoIKK7EDfHwzGz8+0OqUAlzyQ7VvwIXq+x5USReCeQkytSXvYt
         wqsn0j1V0T+zm0pK3rOIiL008wvg+LYzOC8rZ58+YGi1AzttyzVwu24hoF7QpFHaLIAh
         D4Tw==
X-Gm-Message-State: AFqh2ko/Ckhml7A5+xsdo/Zb66ren2lLm6SjRQNwdAmG6QLCrypeHmlQ
        dshHxpvDe6ESimabgQlv/wE=
X-Google-Smtp-Source: AMrXdXtI3Zo3a4s+kdvY1vTlIGbpPc6Wrncelbot5Rj0k72pRJKNPIshoEbkV4Y7dvnq+naQD4wPBg==
X-Received: by 2002:adf:f882:0:b0:28e:875a:f660 with SMTP id u2-20020adff882000000b0028e875af660mr3736571wrp.28.1672498211563;
        Sat, 31 Dec 2022 06:50:11 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id t15-20020a5d534f000000b002365254ea42sm23590019wrv.1.2022.12.31.06.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 06:50:11 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <5a562613-eae7-599c-c548-540faa60e3aa@dunelm.org.uk>
Date:   Sat, 31 Dec 2022 14:50:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 01/10] rebase: use "cleanup" pattern in
 do_interactive_rebase()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <patch-01.10-f3a4ed79c7d-20221230T071741Z-avarab@gmail.com>
Content-Language: en-US
In-Reply-To: <patch-01.10-f3a4ed79c7d-20221230T071741Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 30/12/2022 07:28, Ævar Arnfjörð Bjarmason wrote:
> Use a "goto cleanup" pattern in do_interactive_rebase(). This
> eliminates some duplicated free() code added in 0609b741a43 (rebase
> -i: combine rebase--interactive.c with rebase.c, 2019-04-17),

I read this as meaning that commit added some code to this function, but 
it fact it just copied the function unchanged from another file.

> and sets
> us up for a subsequent commit which'll make further use of the
> "cleanup" label.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/rebase.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 1481c5b6a5b..7141fd5e0c1 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -256,7 +256,7 @@ static void split_exec_commands(const char *cmd, struct string_list *commands)
>   
>   static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>   {
> -	int ret;
> +	int ret = -1;
>   	char *revisions = NULL, *shortrevisions = NULL;
>   	struct strvec make_script_args = STRVEC_INIT;
>   	struct todo_list todo_list = TODO_LIST_INIT;
> @@ -265,16 +265,12 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>   
>   	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head->object.oid,
>   				&revisions, &shortrevisions))
> -		return -1;
> +		goto cleanup;

This sort of change potentially problematic as we're free()ing things 
that were not previously free()d but revisions and shortrevisions are 
initialized to NULL before passing them to get_revision_ranges() so it 
is safe.

Looks good

Phillip

>   	if (init_basic_state(&replay,
>   			     opts->head_name ? opts->head_name : "detached HEAD",
> -			     opts->onto, &opts->orig_head->object.oid)) {
> -		free(revisions);
> -		free(shortrevisions);
> -
> -		return -1;
> -	}
> +			     opts->onto, &opts->orig_head->object.oid))
> +		goto cleanup;
>   
>   	if (!opts->upstream && opts->squash_onto)
>   		write_file(path_squash_onto(), "%s\n",
> @@ -304,6 +300,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>   			opts->autosquash, opts->update_refs, &todo_list);
>   	}
>   
> +cleanup:
>   	string_list_clear(&commands, 0);
>   	free(revisions);
>   	free(shortrevisions);
