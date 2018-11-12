Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C32391F97E
	for <e@80x24.org>; Mon, 12 Nov 2018 15:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbeKMBUb (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:20:31 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41790 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbeKMBUa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:20:30 -0500
Received: by mail-qk1-f194.google.com with SMTP id 189so13888578qkj.8
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 07:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Xfs3xzXQj1xJwBB+NlXJ/qoWSHq8w2cv4KF/yuwEjOE=;
        b=iYroJaKK7lDHPRQXPXw4iUfCSh6EIhjlhT8gvx3EvQF31Y58S+BnZZ4CsRc6EbqMVE
         Ct65HMELQ9Lp0REnEkin/jQli4Cvsl9W11j/0qe3oeqrXYEiK9nVSVcb3Q6sVRwp+QJS
         +C9bgSgxRIzR0nbZpM5QdZJEHkMHicIXB0Mp45E+QXV8wUobdH1W0nKrkbZkwwaRW1Ol
         Nh7TC/v3R/6GdcTfBt108H7gqI7121CFstIpGADbt3ldeyzrya6uyUS2vkv5r4DKWudu
         MAvlTXSBHUZF8Hjb2vU/GTrwmmozR0it0IXbuGHIqpcmRAsh2jLEy7QGqRJDV9nncLWj
         n9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xfs3xzXQj1xJwBB+NlXJ/qoWSHq8w2cv4KF/yuwEjOE=;
        b=Xo2k1iY4JTLwX8jYaxJKMcZhe7bYrL0ZLeo8+pWGI1Yqs2UU2ER6S/GbX2J6E4HL1V
         pz8S0+Pe4UG56b0ZJ71Zq52Z1IGKEKnS6jM506JwPt7siJ0wN+7Ca1LCRk1jrJYXlD0E
         pyYDd8u8IL3ONirl7YAl4/kLl/zfzkFqzc76GVLmUlLxmzNd+pUpw27je+jSCnwYZCvv
         Mqssqk5V/Rt9YpN3VSdD41yAgPqk7tMJPczDmaYVCfMVQNymNiPTrowcHiXd69fy3ERP
         dTHfEOuLgjifsOQUG+ZFy/1PUg0FtgdZnJupmvUJrmfBQ2JwBYxenN+aPe2swo5DEyt8
         BR9Q==
X-Gm-Message-State: AGRZ1gJ/9Lz7GpsFvCLANqXaaBMpwY7DPtygzkOGU9MTXGiEFjj1zFOd
        W26U1efTSq3OTCaXnUH5eQ4=
X-Google-Smtp-Source: AJdET5cSzbFFOpfHpAS7B9+QR0MvgBmnqKKpL5rmbsdZAwIIj76HdgHkp/d0Lev0JK7Pw5JVprK+tw==
X-Received: by 2002:ac8:65c7:: with SMTP id t7mr982291qto.143.1542036407523;
        Mon, 12 Nov 2018 07:26:47 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:705f:75d7:178c:fe1c? ([2001:4898:8010:0:5995:75d7:178c:fe1c])
        by smtp.gmail.com with ESMTPSA id w201sm10900982qkw.11.2018.11.12.07.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:26:47 -0800 (PST)
Subject: Re: [PATCH 1/9] fsck: do not reuse child_process structs
To:     Jeff King <peff@peff.net>, Geert Jansen <gerardu@amazon.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112144654.GA7400@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6b32adb9-60a9-5c05-48dc-fe90ef10277f@gmail.com>
Date:   Mon, 12 Nov 2018 10:26:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181112144654.GA7400@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/12/2018 9:46 AM, Jeff King wrote:
> The run-command API makes no promises about what is left in a struct
> child_process after a command finishes, and it's not safe to simply
> reuse it again for a similar command. In particular:
>
>   - if you use child->args or child->env_array, they are cleared after
>     finish_command()
>
>   - likewise, start_command() may point child->argv at child->args->argv;
>     reusing that would lead to accessing freed memory
>
>   - the in/out/err may hold pipe descriptors from the previous run

Thanks! This is helpful information.

> These two calls are _probably_ OK because they do not use any of those
> features. But it's only by chance, and may break in the future; let's
> reinitialize our struct for each program we run.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   builtin/fsck.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 06eb421720..b10f2b154c 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -841,6 +841,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>   
>   		prepare_alt_odb(the_repository);
>   		for (alt =  the_repository->objects->alt_odb_list; alt; alt = alt->next) {
> +			child_process_init(&commit_graph_verify);
> +			commit_graph_verify.argv = verify_argv;
> +			commit_graph_verify.git_cmd = 1;
>   			verify_argv[2] = "--object-dir";
>   			verify_argv[3] = alt->path;
>   			if (run_command(&commit_graph_verify))
> @@ -859,6 +862,9 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>   
>   		prepare_alt_odb(the_repository);
>   		for (alt =  the_repository->objects->alt_odb_list; alt; alt = alt->next) {
> +			child_process_init(&midx_verify);
> +			midx_verify.argv = midx_argv;
> +			midx_verify.git_cmd = 1;
>   			midx_argv[2] = "--object-dir";
>   			midx_argv[3] = alt->path;
>   			if (run_command(&midx_verify))

Looks good to me.

-Stolee
