Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B044C0015E
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 14:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237487AbjHOOCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237476AbjHOOBl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 10:01:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE39199A
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 07:01:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31956020336so2728627f8f.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692108097; x=1692712897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f4sMRN1Z5on9wwMXCMmgo/qYoMXdNoLucHoq3z36LvY=;
        b=ay9z//70TCxJ0dehgz8mXvJECittzx4CU9Qc2+ssdPESkWM9xpa8aqQRSisg/MlKYi
         vKx3yDNlZSV+1V4Eeu1wd2S65KW0ddvP5QE+nc7MmV48hGTle28wlb45iVxKlRzOXKpS
         70jkITUglVsy0w0+QyjBmO+jp6JkUCJAmsE7eaZLcfqHTr0Y6MUOTdq/mLGZyfKgxG2f
         8KupxCyOmUsKYQ3BX82ZQZPLTqtYZNun+aXbY7OyNYDXnSwZWYjZYB36ITIZpLylKt2x
         JE5xnI+b73wmYW270ySMg5IT4H9oqQlv+ikhoxXOt/2Gf1BYOLC3kI8Tj/EdZjZ3slA0
         DCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692108097; x=1692712897;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f4sMRN1Z5on9wwMXCMmgo/qYoMXdNoLucHoq3z36LvY=;
        b=OBPAlgUL5oSR+fpEEw4wjxV/pu8hYcNbqlP34VfbmqIkt843tGHPOlfSZowWhiIYm1
         Q5dI6w1BtHudGrVga/5ccPzieEA3dbh4DjOv8A+boxPYqJCwI+UxpW7eHtlCjzOn3380
         GzoToLUPPm7VpXV8yyQlWBB9D3s/H4St/Guan6/iRyEk5Wj1Lsl9V9H97MzH4UxTyoXf
         U1azr0NwtMSxK8yWv+hdPMe61WjINccKmDFBXwZKSoyhhxajconkjAifvwM7T06X3xqG
         J2JtmkyyTYRgI9zVOSgF4v5I4jhB9iY3VQFCMu8yv0O0KNZaIURHPLt98rVW43fFruuk
         GltA==
X-Gm-Message-State: AOJu0YxDMH+BnWwqwUUzTYqN2ZM81tMb9K0heSGAOjLVqegp1PWY5J8Z
        YIoaRLMGxMH/DmqctIISeg0=
X-Google-Smtp-Source: AGHT+IFConkEEh73WylaAEHe3UhDYc97kHryjsEMN+9aZaza7Ze9SeCyeQIo5VWVPyZs7NjNeheL5w==
X-Received: by 2002:adf:e90e:0:b0:317:59a6:6f68 with SMTP id f14-20020adfe90e000000b0031759a66f68mr1999968wrm.0.1692108097228;
        Tue, 15 Aug 2023 07:01:37 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id j4-20020adfff84000000b003142ea7a661sm18106438wrr.21.2023.08.15.07.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 07:01:36 -0700 (PDT)
Message-ID: <8b629666-ca43-4a38-ba70-1c017d547984@gmail.com>
Date:   Tue, 15 Aug 2023 15:01:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] rebase: move parse_opt_keep_empty() down
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <xmqqiler8cga.fsf@gitster.g>
 <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564844-4-oswald.buddenhagen@gmx.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230809171531.2564844-4-oswald.buddenhagen@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald

On 09/08/2023 18:15, Oswald Buddenhagen wrote:
> This moves it right next to parse_opt_empty(), which is a much more
> logical place. As a side effect, this removes the need for a forward
> declaration of imply_merge().
> 
> Acked-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> 
> ---
> i'm not sure how to "translate" phillip's informal approval; the
> acked-by doesn't seem quite right. please adjust as necessary.

I think we should just delete that trailer, I don't approve of this 
change any more strongly than I do the rest of the series - they all 
look like useful improvements to me, thanks for working on them.

Best Wishes

Phillip

> Cc: Junio C Hamano <gitster@pobox.com>
> ---
>   builtin/rebase.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 4a093bb125..13ca5a644b 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -376,19 +376,6 @@ static int run_sequencer_rebase(struct rebase_options *opts)
>   	return ret;
>   }
>   
> -static void imply_merge(struct rebase_options *opts, const char *option);
> -static int parse_opt_keep_empty(const struct option *opt, const char *arg,
> -				int unset)
> -{
> -	struct rebase_options *opts = opt->value;
> -
> -	BUG_ON_OPT_ARG(arg);
> -
> -	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
> -	opts->keep_empty = !unset;
> -	return 0;
> -}
> -
>   static int is_merge(struct rebase_options *opts)
>   {
>   	return opts->type == REBASE_MERGE;
> @@ -982,6 +969,18 @@ static enum empty_type parse_empty_value(const char *value)
>   	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
>   }
>   
> +static int parse_opt_keep_empty(const struct option *opt, const char *arg,
> +				int unset)
> +{
> +	struct rebase_options *opts = opt->value;
> +
> +	BUG_ON_OPT_ARG(arg);
> +
> +	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
> +	opts->keep_empty = !unset;
> +	return 0;
> +}
> +
>   static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
>   {
>   	struct rebase_options *options = opt->value;
