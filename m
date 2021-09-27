Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BD8C433F5
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 09:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE56D6058D
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 09:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbhI0JHr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhI0JHp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 05:07:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50F0C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 02:06:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r23so24982326wra.6
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 02:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N0rYr/hVtFLjHnyi7aFVSQcO9smXMM8QxKqG2Kfnf2o=;
        b=bJjJIaimoHQtDVA5YlTklXqxCb08s/r+rwy6Ddy4lBzQ7VHS3fmNbi8iNBIM1PSlnd
         VM2UlvKY06JkgrUjq02g7mOoTNx7TosWsQha1P5GORAYRK4EMU4BCXA2aRxLy4Xa82lW
         70nmVks5665tDp70AuQs46kc+kEECyWKHkPokHuTnVb9aED/MGslAEn9hXrdlohn/vMU
         3XYVAUnglbT8I428CzgBEMCMgbM4N6n2+saQT78sttOs/QVLP+ejkm4ELw0K0HBL3070
         XnNstUMYTdE1o7CmDV7wMXVLT5mSu4H/BPlDKitvSDVGOmGazS/2M62+2ZzwziSRcjEy
         vD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=N0rYr/hVtFLjHnyi7aFVSQcO9smXMM8QxKqG2Kfnf2o=;
        b=MPf6GkswXySbYlAPwhDIPG4FRZ4vZxv/nXiYAMOF0JCWOA3v8mMEmh9lFX9O0WNj3q
         V1nJxXgreRlSOxvyHYsOvTsWKXRhGcbXOc5I+u3QhKoxr9z7FBGJUNvtQgxJEGubBIEF
         bTqgLbcpecFKTWWtsiSepDz1jHpPrrtVO9nIgqfvbKVdzJ6oJNdHm9AwMKeJqcIHQfMF
         6792RBDY/wbBr+Ex0ZbkEFNS4UT2T3kiJon8T8PqDKpNawGbUDj9vLeZPTDRrXsEfcjU
         2BUlcm5GIKTDq9Q6oV2wFZ9KthkEm0l6a7lHIbdzcpM2rHwR0DVN3GkgYxknfa3y5BQ2
         AzAA==
X-Gm-Message-State: AOAM533C+Q667hObQp/pdqmND0pQZINo4PXYOwZYUdWhQ5X+EHV/uZrm
        sdU0zNknp2AaHRcea4aRuq/aMmwaMZ8=
X-Google-Smtp-Source: ABdhPJwIUvcJifoHpJp7WRvGsKdA0Ctj+Avu6rOAiBbInGyuh0eq5UU4PpQYOtpIufAXmsv0CDsiGQ==
X-Received: by 2002:adf:fb89:: with SMTP id a9mr26476934wrr.164.1632733566536;
        Mon, 27 Sep 2021 02:06:06 -0700 (PDT)
Received: from [192.168.1.240] (178.2.7.51.dyn.plus.net. [51.7.2.178])
        by smtp.gmail.com with ESMTPSA id v17sm6317999wro.34.2021.09.27.02.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 02:06:05 -0700 (PDT)
Message-ID: <94842a94-d168-2b61-4a44-0059ecbe1b36@gmail.com>
Date:   Mon, 27 Sep 2021 10:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/6] shortlog: use designated initializer for "struct
 shortlog"
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
References: <cover-0.6-00000000000-20210927T004920Z-avarab@gmail.com>
 <patch-3.6-c9db107fcb1-20210927T004920Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-3.6-c9db107fcb1-20210927T004920Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 27/09/2021 01:53, Ævar Arnfjörð Bjarmason wrote:
> Change code added in 64093fc06a (blame,shortlog: don't make local
> option variables static, 2016-06-13) to use a designated initializer
> via a typical *_INIT macro pattern.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   builtin/shortlog.c | 2 +-
>   shortlog.h         | 4 ++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 3e7ab1ca821..fa1f76cc51e 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -342,7 +342,7 @@ void shortlog_init(struct shortlog *log)
>   
>   int cmd_shortlog(int argc, const char **argv, const char *prefix)
>   {
> -	struct shortlog log = { STRING_LIST_INIT_NODUP };
> +	struct shortlog log = SHORTLOG_INIT;
>   	struct rev_info rev;
>   	int nongit = !startup_info->have_repository;
>   
> diff --git a/shortlog.h b/shortlog.h
> index 3f7e9aabcae..47892d6d604 100644
> --- a/shortlog.h
> +++ b/shortlog.h
> @@ -28,6 +28,10 @@ struct shortlog {
>   	FILE *file;
>   };
>   
> +#define SHORTLOG_INIT { \
> +	.list = STRING_LIST_INIT_NODUP, \
> +}
> +
>   void shortlog_init(struct shortlog *log);

looking at this wouldn't it be better follow the pattern in the first 
patch in this series and replace shortlog_init() with a designated 
initializer?

Best Wishes

Phillip

>   void shortlog_add_commit(struct shortlog *log, struct commit *commit);
> 
