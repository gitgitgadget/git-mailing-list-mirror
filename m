Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B862DC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350543AbiCHWrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbiCHWq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:46:59 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26865593BA
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:46:02 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qt6so1029250ejb.11
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=ALoGEN2Z4R31dZ+Sp1l6l3iMDOPmKcl71C1eSjxsNAE=;
        b=CAMRFkDwGLUJwNqx1Ok/QmVWtbl25oPXCGe1a+IvYB9N/u9MCK3BbEtD+xfMYo5Kcx
         /3DgZ0qT+4tBXOg01P9o03xWMOcAZGxLBdxK9Trc2ZUmwOkCRvGcO4NEzcCdwvRZVOMK
         CNtf7p3cE3t5XYf7H5rXUnUaeMqxzD71lzcrnSFZFL4NpS4eG2CJtlUed5Vp80eC4RQ9
         paVrKpilrrwJhYVNW+BRPJfqJkxUR9v8aIx1blFnUUJZLA9SJ+aY+wH0FukwTCTjbGTw
         AzQeL0AvcbEEAE4FozLLjoPnhef0PCMWm7rwf81RPlkmhvLhVJc0LAREOWUuNmiHaAxc
         GhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=ALoGEN2Z4R31dZ+Sp1l6l3iMDOPmKcl71C1eSjxsNAE=;
        b=IL+kQ1pd4gCb/qfNTz/gt0pcndYOe7mhemkjhpvJK5XH411/1fp8og2GX5xHODVL/N
         kCZox9yXItOodELhL6axNO8+KNhUoEOB+9k5fAaJHXMLNMfnV/DSvcvgZbnj22ertPWA
         A1j7UWHHO5Mzgtf15+WdJLxlHZQTCsWeedyy8R3WoEk1sVimMyjtAfQaacNW78HCXmsa
         f0SVlLIUlrUmw5t/ABx9OUWwnC0zjDeox1JNWWiPWQp0IErDswAzz0bn/B7i9Janho6D
         9bagQnocPq+1YLuehsRs1bcss+ZGNFQzNcx93Oi0UdviZJdgRi+vfd5dnCT7JmINLi2r
         uQtQ==
X-Gm-Message-State: AOAM532/XzStU2jQB13qaStcxqIX3idNAnd2euQf16bscN4ujc5DmsY1
        CiwOuWsavhQS3frYFIAtuUvAfDn9Us8=
X-Google-Smtp-Source: ABdhPJzMfx9pF0/L1Z/I8wuafun7ByWK9Rjz1BCvA6GulYIqlII+n0siS20GPCtpo5tJe1EIx5a2TA==
X-Received: by 2002:a17:906:434e:b0:6d0:ed9c:68bc with SMTP id z14-20020a170906434e00b006d0ed9c68bcmr14610629ejm.70.1646779560645;
        Tue, 08 Mar 2022 14:46:00 -0800 (PST)
Received: from [10.37.129.2] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id f7-20020a17090631c700b006b293ddbca1sm40937ejf.35.2022.03.08.14.45.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 14:46:00 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] cat-file: skip expanding default format
Date:   Tue, 08 Mar 2022 17:45:58 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <269C7493-3DE5-4D37-AD43-C2E8442ACEF3@gmail.com>
In-Reply-To: <YifXjuN27U53c46c@nand.local>
References: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
 <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
 <YifSFQ8zEZimCkHl@nand.local> <YifXjuN27U53c46c@nand.local>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On 8 Mar 2022, at 17:24, Taylor Blau wrote:

> On Tue, Mar 08, 2022 at 05:00:53PM -0500, Taylor Blau wrote:
>> On my copy of git.git., it shaves off around ~7ms that we're spending
>> just copying type names back and forth.
>
> ...while we're at it, I think we could go a little further and avoid
> doing the mark_query phase altogether, by doing something like:
>
> --- 8< ---
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index ab9a49e13a..4b3cfb9e68 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -542,24 +542,30 @@ static int batch_objects(struct batch_options *opt)
>  	int save_warning;
>  	int retval = 0;
>
> -	/*
> -	 * Expand once with our special mark_query flag, which will prime the
> -	 * object_info to be handed to oid_object_info_extended for each
> -	 * object.
> -	 */
> -	memset(&data, 0, sizeof(data));
> -	data.mark_query = 1;
> -	strbuf_expand(&output,
> -		      opt->format ? opt->format : DEFAULT_FORMAT,
> -		      expand_format,
> -		      &data);
> -	data.mark_query = 0;
> -	strbuf_release(&output);
>  	if (opt->cmdmode)
>  		data.split_on_whitespace = 1;
>
> -	if (opt->format && !strcmp(opt->format, DEFAULT_FORMAT))
> +	memset(&data, 0, sizeof(data));
> +	if (!opt->format || !strcmp(opt->format, DEFAULT_FORMAT)) {
> +		data.info.sizep = &data.size;
> +		data.info.typep = &data.type;
> +
>  		opt->format = NULL;
> +	} else {
> +		/*
> +		 * Expand once with our special mark_query flag, which will prime the
> +		 * object_info to be handed to oid_object_info_extended for each
> +		 * object.
> +		 */
> +		data.mark_query = 1;
> +		strbuf_expand(&output,
> +			      opt->format ? opt->format : DEFAULT_FORMAT,
> +			      expand_format,
> +			      &data);
> +		data.mark_query = 0;
> +		strbuf_release(&output);
> +	}
> +
>  	/*
>  	 * If we are printing out the object, then always fill in the type,
>  	 * since we will want to decide whether or not to stream.
>
> --- >8 ---
>
> ...but in my experiments it doesn't seem to help much. Or, at least, it
> doesn't obviously help, there's too much noise from run to run for me to
> see a worthwhile speed-up here.

Yeah I had the same thought. I also didn't see a noticeable difference so I'm on the fence
regarding whether or not it's worth it. I'm kind of leaning towards no, since it adds some
one-off logic without a clear performance gain.

>
> Thanks,
> Taylor
