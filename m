Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB881CE7A88
	for <git@archiver.kernel.org>; Sun, 24 Sep 2023 13:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjIXNlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 09:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjIXNlS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 09:41:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E050383
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 06:41:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-317c3ac7339so4600253f8f.0
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 06:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695562870; x=1696167670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gWI5mN46yiPGzNjeNqXNsOFah9MWTWPNF2xEGblzAhQ=;
        b=a0GJQ9Vm7XsZvf6WShMaI603Pr+nGN8E7+N3GdtU+b6M+COcvnBQezml/LevOkD8DZ
         828QVlv3JBkN3m4ZCnNzA8jy1frHrRFND0H/2+ZtkMlsX8eCX4SlzwCK9idKViqsHaUb
         SdiK12hboV1Jz4PVjSEzlXWrRLsvWCdZgJGsQPgwFG4SskJXPmGL+mMRLlsZcKe/x4v3
         wYmCwEtze/k19wAnC1P1D9YaNdfElmG9egASGtqDujCwbcMoFjcjHDZ1iINB+jLX+tQI
         9RsOL6BEmtUss0NygfuQBZnSJQNV0g/tPNDFm8R1yg+781Mn+W1yE/IVX8UrTxEypGOj
         ELWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695562870; x=1696167670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWI5mN46yiPGzNjeNqXNsOFah9MWTWPNF2xEGblzAhQ=;
        b=v9vqPuv+c5I96nY96UC+88FxK7o3Ikm4+nI/ZLDAw8RmZ1LIt6WKuDQmnT1YtOo9SY
         xSuUTe+1EccemCT5odV3n6jVthPMjhoAG7Djav0wF+1nbbrBROeMHgc2gCcVAUt7EFb6
         vEAiRtH32nkSDlcmz9TgYmTHhrrbAWwx/EW9IGT/+ZrOQObMqfr4lY+3czP1Vd4FwVCe
         OzOGfZfP0m2ftKKNraHNWJfPkRjO16040VGErLy8nOUVduFYE0avO/CX77mqKq3KrsxX
         hgXA6rYChtdB5Fhh0ecReuIrZicr0pJT9EYMoUlBtecPV+r3e3SACKrX9U/9jct5RqMl
         LzVg==
X-Gm-Message-State: AOJu0YxvHh+k53wORzBbNs/IFJx8arxji+isk9W0lrGRiPWWGnQXOOlY
        ftzdzXiLg/POK/cumwMkmBY9PO5RVZGaYg==
X-Google-Smtp-Source: AGHT+IHxrHDhq3fVVWi0Dl4p3XB2MRqbam6sOTpV9Mfcj7E5qvNCxpRPP3TFohhlv4B1voKQW/DtHQ==
X-Received: by 2002:a5d:4f04:0:b0:31f:f9fe:e739 with SMTP id c4-20020a5d4f04000000b0031ff9fee739mr3502544wru.59.1695562870140;
        Sun, 24 Sep 2023 06:41:10 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id r17-20020a5d4951000000b0031f8a59dbeasm9267905wrs.62.2023.09.24.06.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 06:41:09 -0700 (PDT)
Message-ID: <f4877c36-ff26-4f81-b5dd-63c929ba30c9@gmail.com>
Date:   Sun, 24 Sep 2023 14:41:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/3] archive: support remote archive from stateless
 transport
Content-Language: en-US
To:     Jiang Xin <worldhello.net@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
References: <xmqqy1h2f5dv.fsf@gitster.g>
 <20230923152201.14741-4-worldhello.net@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230923152201.14741-4-worldhello.net@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/09/2023 16:22, Jiang Xin wrote:
> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> 
> Even though we can establish a stateless connection, we still cannot
> archive the remote repository using a stateless HTTP protocol. Try the
> following steps to make it work.
> 
>   1. Add support for "git-upload-archive" service in "http-backend".
> 
>   2. Use the URL ".../info/refs?service=git-upload-pack" to detect the
>      protocol version, instead of use the "git-upload-archive" service.
> 
>   3. "git-archive" does not expect to see protocol version and
>      capabilities when connecting to remote-helper, so do not send them
>      in "remote-curl.c" for the "git-upload-archive" service.

I'm not familiar enough with the server side of git to comment on 
whether this patch is a good idea, but I did notice one C language issue 
below.

>   static struct string_list *get_parameters(void)
> @@ -639,10 +640,19 @@ static void check_content_type(struct strbuf *hdr, const char *accepted_type)
>   
>   static void service_rpc(struct strbuf *hdr, char *service_name)
>   {
> -	const char *argv[] = {NULL, "--stateless-rpc", ".", NULL};

In the pre-image argv[0] is initialized to NULL

> +	const char *argv[4];

In the post-image argv is not initialized and the first element is not 
set in the code below.

>   	struct rpc_service *svc = select_service(hdr, service_name);
>   	struct strbuf buf = STRBUF_INIT;
>   
> +	if (!strcmp(service_name, "git-upload-archive")) {
> +		argv[1] = ".";
> +		argv[2] = NULL;
> +	} else {
> +		argv[1] = "--stateless-rpc";
> +		argv[2] = ".";
> +		argv[3] = NULL;
> +	}

Best Wishes

Phillip

