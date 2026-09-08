Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408FE4CB8D0
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864940; cv=none; b=VVrYDAY52Lm2BXdpZsPYeNfRXSX9Zqwv6Vr1Mp235TbOOau3uDQf+iyNGtMvH0OM3UK4S3oqQfYRvhjZ4G20FCSn5EZJ+3r8C7mbi5tLCp/scBTWjcXu64AMR22FkGCk3tDrY2UimGoxGQZu4MF8YqghdUye6eRaxYyukxK0oys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864940; c=relaxed/simple;
	bh=WvSJS47ThuIwx8h5K9U5y5Grs6LsJdo4sYW5ZCu6axg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rEPcln9tOBF0A330qwcf1isWKNQg4+WsqeS2fwq+gXot0FjhsjexffjXK0KA0+0GOlWI7m2Ygs8mkNIT8A/Cpf7OWw84AxmsKvyvM2FON5L7UKQ4M4y+NNSU+Kjkq4bbcxQsxsAe6hFuDBurHdUQMUUON7rPpfVrt6VUy62nwxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qVaj0Rjw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qVaj0Rjw"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3964e480f76so5159697a91.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788864938; x=1789469738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4yrtv4IwsW8LpyJhnH4/RVmA3jubWYnxbrpdEDEM+s=;
        b=qVaj0RjwIJloOZ0mqQLZ1mnTeIiX8nliYV6ufQ0pZ8pGWH8DPt/l9YM/nnio2aFCqd
         G+evLmX7RwNUC7GOyJPoGe9eCUjurf7iL6dPGx7PweYxyGxjZQKp4U0WJCC6mWt1bxSa
         nPB74V44T2VkVdTSvuT4NKE+64AOt3Py5RMEahvWZSypQLBU5805M3KWF3yOYicpcQ8w
         Nq7ZObGxZc3q3PEgCELTcIUo/c8i8M82iTqktNswZV1hiSLv3lUTJFS5C1I6r5ETaeRE
         aJ8UN3xbU4xPQcsIchnW2xMNxEYUW2sRF9VzrR3PonDhZOVqy3VOTSRvJtezUqf+Ts+d
         4O/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788864938; x=1789469738;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i4yrtv4IwsW8LpyJhnH4/RVmA3jubWYnxbrpdEDEM+s=;
        b=kuSj2N+pm7uKeSlPcS003yjRRj/fiE9MCAHHFoE242ffajuEqudjiN3O9EIJ9eO2WG
         z8HM7vE6drSoDazLxeQ7nNpm5pPJUsHwOS59igHVhFq6ncmtGDqWNtjg93YrPEh1xnqN
         syH+hSv/BNSftPqiCahj2ezjFZGBa1nWGKqGqgjJCIrn2h9swIYq35jfNwf8ieK61Z5+
         5bLf1YZK5qB/fAwGcYmzalOmurMASfuls+cqPc1ePzhmWbIfwAEwaykqi7gtERDARnDO
         Nd1SlZgJAvgWpoZE5T9UOHAaf6ZVnfjwcF6NzCQSaG8yGfwQzmRTFxh/XxEUPbesTkZZ
         9iFw==
X-Forwarded-Encrypted: i=1; AKwUvBwl5rI1I4yAKknCcuyT4WNfdkkec5maPvQuRF/5/1oNnP6rkPqoOFiJlbjXbh4LOYaikQQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kkTAPEJaFkqbUfIoF9sU7sTkNqnmAAjaRMVeTxxkqR2GZRll37
	Id5uiRXgGTr8TvFsPT50flDm203M6l+/Tdnp9Cl3Nb9sb33uS5OIezxPx9vsXC9A
X-Gm-Gg: AYBFou2M2rKxyJuOmIbJcDVZw5xHAewbxyvYUErtC5dwxN7kymvkAL4g/o/VQo4H6g1
	OGhaBCYubEo/e77YEPw+EoaZx63XhuKBjjSRSEbrLAmHLg6NdhrA6GCO7VR878Sby4ztFHASb5p
	n8czZdhgHx1NPC0K0kpFnhu7XDHdISmovWjKhVAtdFj+1B/fOVPgfv9kx6wgw33N2Cg18/Z2yQk
	9Qob1ATpWU9sQE7/P8GiMWfaGtS4zzPKJ3Yr+8G2cvP1iXVHPkD0BKpLfnXmG9V1BBytMMgnenI
	B3n+oVxKB9PgMV63fgHpkCLJyRRVYDgcRGCAf/8eH97QFn/bJpXKw0ikdaHj3bBAVKJ/HBy5oqU
	eAN4xdwaIZkGle+LwQBuVGdERMOc0SqyfKl8ruNEOqqxz46dtNw7e4iK7mOJ/IHoKTqD8Oe30i0
	R/mykldvgG1rix1fgvThX024wCAnwXGm4/xJrdFVu4AtM9uQXTDcKpQQkO9wCGywXe/SB3dCA+t
	2ll
X-Received: by 2002:a17:90b:440e:b0:380:fead:448d with SMTP id 98e67ed59e1d1-39b261e1011mr40315169a91.13.1788864938495;
        Tue, 08 Sep 2026 03:55:38 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm31508562c88.0.2026.09.08.03.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 03:55:38 -0700 (PDT)
Message-ID: <53eac227-1034-4dd5-9f4d-416537dcdd1e@gmail.com>
Date: Tue, 8 Sep 2026 16:25:35 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] builtin/refs: rename "--ref-format=" to
 "--ref-storage-format="
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
 <20260907-b4-pks-unify-ref-storage-format-v2-3-6733c90ca5b0@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-3-6733c90ca5b0@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/7/26 16:48, Patrick Steinhardt wrote:
> index 5cd21c25fe..53b12accaf 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -10,7 +10,7 @@
>   #include "refs/refs-internal.h"
>   
>   #define REFS_MIGRATE_USAGE \
> -	N_("git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]")
> +	N_("git refs migrate --ref-storage-format=<format> [--no-reflog] [--dry-run]")
>   
>   #define REFS_VERIFY_USAGE \
>   	N_("git refs verify [--strict] [--verbose]")
> @@ -44,9 +44,12 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
>   	enum ref_storage_format format;
>   	unsigned int flags = 0;
>   	struct option options[] = {
> -		OPT_STRING_F(0, "ref-format", &format_str, N_("format"),
> -			N_("specify the reference format to convert to"),
> +		OPT_STRING_F(0, "ref-storage-format", &format_str, N_("format"),
> +			N_("specify the reference storage format to convert to"),
>   			PARSE_OPT_NONEG),

This is a bit of a tangent to the change that the patch aims for.

The `PARSE_OPT_NONEG` flag made me wonder if we needed the same in other 
commands that accept this argument too. I tried to take a quick look at 
the series that introduced the `git refs` command and I could not find 
any specific rationale behind why the argument to this specific command 
should have the PARSE_OPT_NONEG flag. May be we could drop the flag for 
`git refs` command to make it consistent with how the argument is 
supported in other commands?

Either way not a show-stopper for this series, of course.

Rest of the patch looks good to me.

--
Sivaraam

