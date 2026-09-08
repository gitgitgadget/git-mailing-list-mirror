Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4194C6808
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875249; cv=none; b=VhphDdVDDxW8BGt6bmMXVyL5X15yDm+d3yfW/5n2ZrXLvHAlxssgJETIR3Z2MirSQazHBThpCmXNyR9TuEbnSGnZwC3lazJzPt/VUAXxrVqjKwnEttxOppXFvoNs8QlVXcD/Iz6DPhwIVdVt1LKk4eTED3x8sHNh+bMex+8u/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875249; c=relaxed/simple;
	bh=Br+yoACV3XBKi6nn8Q0QxrJo0Mt0U86YrW6JVo4MGl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gq7BS4b9V9+r42ngyrychDSK4VWkd8wXJOOsTyPLrK07z9nMkt7oEsbrc0IIeuPasr3/Y4EgIfCdEHltwaXgbzvNlPG8yK584UcuaA4+MCiJFCNq0/997mO5t0+dNjYufoKuOV7pSjvWsjq44f7NhHzo8PNnqwXIGPX2efimnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMT64Dp/; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMT64Dp/"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-4b2ff8ca537so3310016b6e.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 06:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788875231; x=1789480031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fYOsVdMpUZdFwgVvOWV/KE2VYVz9DL+ormPW7sEDfVM=;
        b=gMT64Dp/DF15focTJp8adu7YL1WuGYskGwtpGto0Qs7fQqdJ7yt823RD8Ej37LaREs
         o6D97a/luu9ph/7MV72VSbdERIgXQ3WYojLKAAFlMqGdpoKr/WGqBYg+mCrGtd1TB2G3
         5jKhk1NYjH9f40JmTVAqIfoMjOyHahraawuUuJ60MPD22YdqhuwVym/FIoIxpvDbaxd6
         3OusZzM3p4z8rLM5VqoJZrV70LrOv2IQmuYwuf4X3hWiC0em6+lazmrYiXxPq+TKacFO
         hDp//XBQGlByFKM2tP+FJViRhDFcA8FEbVLo0IgpX9CF8pcPiEWH0KVAcx9z6+x5/tlJ
         cgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788875231; x=1789480031;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fYOsVdMpUZdFwgVvOWV/KE2VYVz9DL+ormPW7sEDfVM=;
        b=da/wcO4YknxJ+9okXOEGmz5/CCQCCyCQTuD9Lt2//2Wg7H/94slUmX0Teo0yrP4Wpj
         /MkcR86wbpZNv8h3yqEKXmQO7wscHcy/MUApcVOGX0Gc6qgc6Dq44APbycAOQ7MLUe2E
         DzUgXnX5eccTAcTiUEGftSsh6ldMs7CLgqHWGO1FuoDW3rkCm+OcshW12LjKxPNOqJAC
         KIHZZFQmwiuJG5s0AkrhtqXydi4B1csRiQcJUvX8DviRG38iBCkzOwsb92H3FN7ylJSm
         37MblWLgFQVZW6BVcgOIpUuVfWaM1bzIMsN4TudM28cQBK0NizNCvIfxZf1I28BqgqWi
         kgwA==
X-Forwarded-Encrypted: i=1; AKwUvBxwaKfZfj5jcAytrbN8sDuQr5lSBxY4jy80k/5yimJH0f4UTWI8oukoVSXb3pHOvkm80nE=@vger.kernel.org
X-Gm-Message-State: AFuF++mBDOj+89PNW0RweR9Ace9NxfnuExMbckX1p/pvW4KODN1ELwsq
	7GS8aR4FYzYHJ2sXlNVE3250KpV7QO/TA+/o4QEnchLFI62y2eSm25G00DqdPsGO
X-Gm-Gg: AYBFou3ZTRUE4YcdcdJ7r77W72Gmpitpi0mYPQwTlr6bA2LZT1AphwtBEyE139UwaXk
	gof9D0yFuosJv+uLTmPaC2xsjvSCXSmNITXGLGWbcoV3VU5qR1zJhShL9lfUbGfcCd9dVxwG1AP
	jzmXGMOf91nXDKyeHKXq+R2+P4oMGNOrW9udlAW/7gdIvdyOwZnCmUmIxpn85yseFvz+QfT7Rp9
	KS5eRGm3DdnnhqI4e03+s1EC3Zd5D/c68kGhADwq8wSq0dccWYS/3PH+SaME2vq9GyHXV+tj3NZ
	ioAeuZY/R5rkyDhTl5UCcHgHrMPThJp5vRvU2Q50M79kEG3bzFMYBVF+uy+hX6qgL1B9lKUZako
	AyXQcn8Z1Hvm7gdGvNlyDMMBQRsQswTif/27XIx+0dfnTh/jBSZL/ZfPFhaXCo8iYN1NeiySWq3
	5V8zRD46q4rHPZZpkmJh/gsQN8Vpo3n6RRIqpq+NqLw/3ga/UN+u5rYcuRdn1Gcju1aFEl4MD3i
	jChhE3y46EY6ko=
X-Received: by 2002:a05:6820:f004:b0:6b0:5233:f69a with SMTP id 006d021491bc7-6b6fdbca26emr17186676eaf.30.1788875231347;
        Tue, 08 Sep 2026 06:47:11 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm41187069eec.1.2026.09.08.06.47.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 06:47:10 -0700 (PDT)
Message-ID: <54fc5f97-a8ed-4927-8b48-1b4c3c7b413a@gmail.com>
Date: Tue, 8 Sep 2026 19:17:06 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] refs: expose function to parse reference URIs
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-7-6733c90ca5b0@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-7-6733c90ca5b0@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 16:48, Patrick Steinhardt wrote:
> In the next commit we're about to add more sites that want to parse a
> reference backends URI into a format and payload. Expose a new function
> `ref_storage_format_by_uri()` that enables this.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

>   enum ref_transaction_error {
>   	/* Default error code */
>   	REF_TRANSACTION_ERROR_GENERIC = -1,
> diff --git a/setup.c b/setup.c
> index dfe05d9a03..3be7dac452 100644
> --- a/setup.c
> +++ b/setup.c
>
> @@ -2069,16 +2051,12 @@ const char *setup_git_directory_gently(struct repository *repo, int *nongit_ok)
>   			 */
>   			ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
>   			if (ref_backend_uri) {
> -				char *format;
> -
> -				free(discovery.format.ref_storage_payload);
> -
> -				parse_reference_uri(ref_backend_uri, &format, &discovery.format.ref_storage_payload);
> -				discovery.format.ref_storage_format = ref_storage_format_by_name(format);
> +				FREE_AND_NULL(discovery.format.ref_storage_payload);
> +				discovery.format.ref_storage_format =
> +					ref_storage_format_by_uri(ref_backend_uri,
> +								  &discovery.format.ref_storage_payload);
>   				if (discovery.format.ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
> -					die(_("unknown ref storage format: '%s'"), format);
> -
> -				free(format);
> +					die(_("unknown ref storage format: '%s'"), ref_backend_uri);

If I'm not mistaken, we have now started printing the whole ref storage 
backend configuration rather than just the name. I could see that we 
don't actually have any variable that returns just the name part after 
the refactor. I could also understand that we can't always expect a 
'://' in the GIT_REF_STORAGE_FORMAT configuration so printing the whole 
configuration may make sense. But could we possibly improve the error 
message a bit? May be phrase it as follows:

   $ GIT_REF_STORAGE_FORMAT=garbage://hello-world ./git status
   fatal: invalid ref storage format configuration: 'garbage://hello-world'

> @@ -2806,18 +2784,16 @@ static void repository_format_configure(struct repository_format *repo_fmt,
>   
>   	ref_backend_uri = getenv(GIT_REFERENCE_BACKEND_ENVIRONMENT);
>   	if (ref_backend_uri) {
> -		char *backend, *payload;
>   		enum ref_storage_format format;
> +		char *payload;
>   
> -		parse_reference_uri(ref_backend_uri, &backend, &payload);
> -		format = ref_storage_format_by_name(backend);
> +		format = ref_storage_format_by_uri(ref_backend_uri, &payload);
>   		if (format == REF_STORAGE_FORMAT_UNKNOWN)
> -			die(_("unknown ref storage format: '%s'"), backend);
> +			die(_("unknown ref storage format: '%s'"), ref_backend_uri);
>   

Ditto here.

--
Sivaraam

