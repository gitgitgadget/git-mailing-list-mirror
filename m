Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00F4C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 17:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390768AbiDURbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 13:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiDURbb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 13:31:31 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BD7443CB
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:28:41 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q75so4083180qke.6
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6L9/KzwhDGrwt5Qgx5xNI7zsNvad84ta+bCcWWtuFt4=;
        b=iup+cbZaZ21xSzNHntzUby+ZqxPrrftCLnfeBIrpnnFHRtBHxNZghg6B2/IDvj+3Xv
         /LKacK3lAX9bbSVR7JlzegxAdy0pMK+1SL72EV5gm77bG1MYq3yu4eSax6XH8Vihnknf
         0xkA2qkXN3iewWapstnpulzwXVPKPp3bjUu6vOFqUWbFkSIOOlAqrXbvXE1LNa7kbiCL
         ZaccnOuTYxEQ9Ji2ebAduLKVkaNz00VtgaDd/AKOexvRT3X7BBETi9N2PDU0acHuKs87
         X13Oiwy1abaVTYM9MStucKZUU7DtYFyyVx8kcTF2WEdAVI8Gr8nAFfKNCA7p3zEEdi0O
         BZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6L9/KzwhDGrwt5Qgx5xNI7zsNvad84ta+bCcWWtuFt4=;
        b=0qvjykWz5Dg8OUQ+Oc9d9VUjhudvqLsXgR22VY93cc1JzET5iU9N+FuPf8mxn6aWs1
         dvLM/jrM+G+xJkijN8hLpV5yrO1PxVtRC/Ug3CzSUn7HyimL4zdGGaUfQgzlEUjgR6iq
         wGZQ2UkeYVGNeN8YK+yVfB6s+a2B49lDQqIGDmFDyY7oRo3CcrK+Cbd48LIFsD8RGbTi
         DLyYHAeRiS8nKj9lBWx1xv4FVy2RZ+3bXzh6sBLen18BUU05zZLrRvCd5X2Hj/nf/uOO
         i7pU++4X7dsKEpO34BkzlPDWNbfz87fNrDq02Hu7y076e9QFEtd4KeXfeWKXA3eXx2Vf
         IZ9g==
X-Gm-Message-State: AOAM532hw7q26kLZKhBPHKd28JKMwKPX5u/K719ySmofLC0vwcRI2M4C
        rz5GeaHHg0N79Y/KjLj5xWUp
X-Google-Smtp-Source: ABdhPJxXWjuWxXxTda/ZRStTPWjjYc1f/zbkyPJu/QSrUGmAUv8F21sraDdYJ4Mh6ePdQPuiec1GLw==
X-Received: by 2002:a05:620a:2905:b0:69f:1362:2f02 with SMTP id m5-20020a05620a290500b0069f13622f02mr242777qkp.351.1650562120763;
        Thu, 21 Apr 2022 10:28:40 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e15-20020a05622a110f00b002f33d65b065sm3680732qty.73.2022.04.21.10.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 10:28:40 -0700 (PDT)
Message-ID: <de4a440c-3358-6756-f7fd-144a90fa476a@github.com>
Date:   Thu, 21 Apr 2022 13:28:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH v2 03/36] fetch-pack: add a
 deref_without_lazy_fetch_extended()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
 <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
 <RFC-patch-v2-03.36-7823a177fd7-20220418T165545Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <RFC-patch-v2-03.36-7823a177fd7-20220418T165545Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2022 1:23 PM, Ævar Arnfjörð Bjarmason wrote:
> -static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
> -					       int mark_tags_complete)
> +static struct commit *deref_without_lazy_fetch_extended(const struct object_id *oid,
> +							int mark_tags_complete,
> +							enum object_type *type,
> +							unsigned int oi_flags)
>  {
> -	enum object_type type;
> -	struct object_info info = { .typep = &type };
> +	struct object_info info = { .typep = type };
>  	struct commit *commit;

Since we now dereference 'type', should we have a BUG() statement here
if type is NULL?

>  
>  	commit = lookup_commit_in_graph(the_repository, oid);
> @@ -128,9 +129,9 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
>  
>  	while (1) {
>  		if (oid_object_info_extended(the_repository, oid, &info,
> -					     OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK))
> +					     oi_flags))
>  			return NULL;
> -		if (type == OBJ_TAG) {
> +		if (*type == OBJ_TAG) {
>  			struct tag *tag = (struct tag *)
>  				parse_object(the_repository, oid);
>  
> @@ -144,7 +145,7 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
>  		}
>  	}
>  
> -	if (type == OBJ_COMMIT) {
> +	if (*type == OBJ_COMMIT) {
>  		struct commit *commit = lookup_commit(the_repository, oid);
>  		if (!commit || repo_parse_commit(the_repository, commit))
>  			return NULL;
> @@ -154,6 +155,16 @@ static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
>  	return NULL;
>  }
>  
> +

nit: extraneous newline.

> +static struct commit *deref_without_lazy_fetch(const struct object_id *oid,
> +					       int mark_tags_complete)

Thanks,
-Stolee
