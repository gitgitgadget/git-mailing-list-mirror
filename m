Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A642C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF28A206B6
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY8Y9LSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEOKa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgEOKa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:30:26 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C9C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:30:26 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f83so1908704qke.13
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pisBB2Z4+Twkq+CWaTmTFGLkIQOdYX3zDV2VjrSXEFo=;
        b=PY8Y9LSaycbC0bdodY7uTiKqQ6jtzmLRdHYVn0j21GY43uLrmvytVkrb10pmunK+kz
         RwtbMjQvYD04sKCwaEO/RmEmzPdefqY0ZLVWmvsVW42KyB28xYa0UXNmeBCP4oR9sxo/
         iQw2dzykboQME6tVfGmfxCTHeDbHOqk3KGPas7wb9Xo95ihvsVOfW2UTvWt9HPhv6545
         vpXcQO68qVKPcLmI5PlH5eHXJ+mERvvHuQjjVwFDG2imaK/+u/wfRVyToEqVaFQqsu9j
         tAqGL7Kw6pIq5NW7oAggVF3GFkBwLDOc7hRLBh789lPaMcpGKJHIt/ZzOiDe400a02Be
         jTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pisBB2Z4+Twkq+CWaTmTFGLkIQOdYX3zDV2VjrSXEFo=;
        b=X9uCnUhrpb8shtouT8UnaeE94cuN+wz6jTpvKlLEYfW1E/rU7tE5SYIsvt+Vuxj/Il
         yeYVWAhlUMjhvWSlK+SxDcCcgd92iN/BNJtoCf3OrAd+2euMRatq/y2R/T+vr2BPzPD6
         BdWWO3/gOAyXSL6qa5afH6BuZU+FW+6arZpB0IZwWa5NFOE4l3ZDoZUmkj9/KCBCsLiY
         cw4g5JLEA6+FIxIs01/4Nw0DyXMMgjeN5wDADNa3cULdiAKw0CZLduc1ELXtlT8n0RUp
         ucYCl3qZJojUPqsU0spJr7VNh3w1yxAmsMYmZiXpOdQVweb45/sw4+eWxeCI1/lualFt
         ImXQ==
X-Gm-Message-State: AOAM533E7Kzw4f9xdSWzW6FSAlXf0bHYLABVmJcfl1doDI9FN2Lji4q7
        TjL9c1wGhTFHK4vbMtwXTHg=
X-Google-Smtp-Source: ABdhPJypWACIJ4tfkmnETkb3w9tBZzauRxcU25gl/Ddk0OTAr9EiAN7+qzIjWNO6zQi4ssBA6FsVJA==
X-Received: by 2002:a37:9a48:: with SMTP id c69mr2524061qke.282.1589538625387;
        Fri, 15 May 2020 03:30:25 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id z60sm1643201qtc.30.2020.05.15.03.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:30:24 -0700 (PDT)
Subject: Re: [PATCH 04/13] upload-pack: use 'struct upload_pack_data' in
 upload_pack()
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200515100454.14486-5-chriscool@tuxfamily.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fac9a9f1-7ee6-5138-9a9e-94e742b69f2c@gmail.com>
Date:   Fri, 15 May 2020 06:30:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200515100454.14486-5-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/15/2020 6:04 AM, Christian Couder wrote:
> As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
> more thoroughly, let's use 'struct upload_pack_data' in
> upload_pack().
> 
> This will make it possible in followup commits to remove a lot
> of static variables and local variables that have the same name
> and purpose as fields in 'struct upload_pack_data'. This will
> also make upload_pack() work in a more similar way as
> upload_pack_v2().
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  upload-pack.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/upload-pack.c b/upload-pack.c
> index 9aeb3477c9..cb336c5713 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1144,18 +1144,17 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
>  void upload_pack(struct upload_pack_options *options)
>  {
>  	struct string_list symref = STRING_LIST_INIT_DUP;
> -	struct object_array want_obj = OBJECT_ARRAY_INIT;
>  	struct packet_reader reader;
> -	struct list_objects_filter_options filter_options;
> +	struct upload_pack_data data;
>  
>  	stateless_rpc = options->stateless_rpc;
>  	timeout = options->timeout;
>  	daemon_mode = options->daemon_mode;
>  
> -	memset(&filter_options, 0, sizeof(filter_options));
> -

I checked that upload_pack_data_init() runs memset(), which
initializes the memory for data.filter_options. Thanks.

>  	git_config(upload_pack_config, NULL);
>  
> +	upload_pack_data_init(&data);
> +
>  	head_ref_namespaced(find_symref, &symref);
>  
>  	if (options->advertise_refs || !stateless_rpc) {
> @@ -1169,21 +1168,24 @@ void upload_pack(struct upload_pack_options *options)


The control flow below was hard to parse from the diff because
a whitespace line split up the "-" lines and the "+" lines.
I reorder them here:

Old code:

> -	if (options->advertise_refs)
> -		return;
>  
> -	packet_reader_init(&reader, 0, NULL, 0,
> -			   PACKET_READ_CHOMP_NEWLINE |
> -			   PACKET_READ_DIE_ON_ERR_PACKET);
>  
> -	receive_needs(&reader, &want_obj, &filter_options);
> -	if (want_obj.nr) {
> -		struct object_array have_obj = OBJECT_ARRAY_INIT;
> -		get_common_commits(&reader, &have_obj, &want_obj);
> -		create_pack_file(&have_obj, &want_obj, &filter_options);
>	}
> -	list_objects_filter_release(&filter_options);
>  }

New code:

> +	if (!options->advertise_refs) {
> +		packet_reader_init(&reader, 0, NULL, 0,
> +				   PACKET_READ_CHOMP_NEWLINE |
> +				   PACKET_READ_DIE_ON_ERR_PACKET);
>  
> +		receive_needs(&reader, &data.want_obj, &data.filter_options);
> +		if (data.want_obj.nr) {
> +			get_common_commits(&reader,
> +					   &data.have_obj,
> +					   &data.want_obj);
> +			create_pack_file(&data.have_obj,
> +					 &data.want_obj,
> +					 &data.filter_options);
> +		}
>  	}
>  
> +	upload_pack_data_clear(&data);
>  }

The major change is that the "options->advertise_refs" case
now clears the data when before it did not. This seems like
a good change to make.

Also, the code that has now been surrounded by an if block
isn't so large as to justify a "goto cleanup" case.

Thanks,
-Stolee

