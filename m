Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEE751F42D
	for <e@80x24.org>; Wed, 30 May 2018 00:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968252AbeE3A57 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 20:57:59 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37726 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966740AbeE3A55 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 20:57:57 -0400
Received: by mail-qt0-f193.google.com with SMTP id q13-v6so21205296qtp.4
        for <git@vger.kernel.org>; Tue, 29 May 2018 17:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=WdtydPx8jLJabsGDTxIHjyo9uhD6/oKfZqB8yXIFqV8=;
        b=oJEcLYC/grXLKvfgCfSLiRdg6w3EFal9DB9HHhuYPwfCby3b4tKthlC9XNenRsBRbX
         IWCW3yM4MXMTzGiE5v2fKSPd+AI1mS4tFAlXOGilm1yLT70QSklhdF2kTlQ28rf5Hgjm
         qeGI77isxtkU8POueViBdjtZDBGqbVdpGpwWF/ZAbA48INJMlmpmLSoWtT8Rt7gMxXMp
         3T04b2M6qbUC0y9Qmcydi9AaejUiwMEreIjxwcPKzQYZHyXDnBt9d6kWQyetnZUOhC4l
         O37trvZ5GGoEtqYZrkh1nkH4pHchDSCwIWaPf4YOnywINrkWqZyPo76eK9TbSS+GduFP
         /BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=WdtydPx8jLJabsGDTxIHjyo9uhD6/oKfZqB8yXIFqV8=;
        b=er9uoex1rNiLA6Y8vOVpISLEra0RmHVDGV5rB5TXWLKENAg4k5BUSitMmX7ViOk7L6
         HUNvYohaQV23jUMIyZmPGgIE3yEWiuyXnj7cACQTZYHy90YOZpvcXVD9feF1IKO1BEdR
         MbxYUWCUEH1GFfAdKuWmKG4oub0a0WZ1ITsFc25KZECNkriq1hV1KJY0vtLxTjDsiirE
         oMgvqTuaoQ0RypZ6q8Oqelewh7tvY3OA+krjGvvxKgGpKc5Gg4GbgDFD/mJZFdXYLgjF
         LBDVnvhEdZyUPjQYBGB4Tjhv7Q8Wq2zp91rrfRFJ6smCwqBkVidhvOIdULwB05kud0N4
         kbrA==
X-Gm-Message-State: APt69E2AbEGGrN7o0STf+SYs0uZk9YIjZ44mzNgm28PzgjejTq17AY7n
        a6bj/AeybIM5h1LuybgUi0in4oFLUtY=
X-Google-Smtp-Source: ADUXVKLxDiozCqrQC3fGGWF7yLdgGhtNVDKD5w0Likp/2E9Pfvkoe4puWX1sRmoPIYhi8Ofgxlk8CA==
X-Received: by 2002:a0c:e485:: with SMTP id n5-v6mr648676qvl.74.1527641876928;
        Tue, 29 May 2018 17:57:56 -0700 (PDT)
Received: from [10.0.1.20] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id 10-v6sm402340qki.54.2018.05.29.17.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 May 2018 17:57:56 -0700 (PDT)
Subject: Re: [PATCH] commit-graph: fix a sparse 'integer as NULL pointer'
 warning
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <b22d20c2-f084-1727-cb98-06707e874ef1@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ba3b8e06-b5e1-99a1-0fe4-ff97d6da8f15@gmail.com>
Date:   Tue, 29 May 2018 20:57:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <b22d20c2-f084-1727-cb98-06707e874ef1@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

n 5/29/2018 4:01 PM, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Derrick,
>
> If you need to re-roll your 'ds/commit-graph-fsck' branch (pu@a84e06bc0f),
> could you please squash this into the relevant patch (commit 80453b4529,
> "commit-graph: add 'verify' subcommand", 2018-05-24).
>
> [No, No, that was the one in graph_read(). :-D ]

Thanks for helping rid me of my bad habits! I'll get this one in v4.

>
> Thanks!
>
> ATB,
> Ramsay Jones
>
>   builtin/commit-graph.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 20ce6437a..6abfde5e6 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -39,7 +39,7 @@ static struct opts_commit_graph {
>   
>   static int graph_verify(int argc, const char **argv)
>   {
> -	struct commit_graph *graph = 0;
> +	struct commit_graph *graph = NULL;
>   	char *graph_name;
>   
>   	static struct option builtin_commit_graph_verify_options[] = {
