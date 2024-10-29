Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6443234
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730218063; cv=none; b=FuQKmJtkQuLYzfX/Hhx36aEz3SJPRQ3B8arM/SoDtfinxDLkZE0/tQTC95SbhqbqiMlL0X++/XQskp7xcSEOB3ROKNC1r1FSZI0jmXQ16x4g18G2QKBNw8SvTkytuPWn0/6S/YsPYiu5irPrrI58HdPK913ssS+6VhgB2OhXIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730218063; c=relaxed/simple;
	bh=fGARtvnfOQJlN5vDHMmInbxytwgJtl3/06+Ub1OdJro=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DpzsieSkiVkHXeZSreFCG0+AFLk/KV1jCopY59NVtPzLGD9BGLXe/HWhG5KLWNjyxxHZWW+flRbsCHou9K7uwISODecC7j3hbFwMINBrp90MDNc6kn1icKo2p7L3FL4k9EyE2S7LdgL2SmSK6L3qeurQ0jKGaoe8k7h3eYmQolM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIJXMJvP; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIJXMJvP"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5101bd018ceso938955e0c.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730218061; x=1730822861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IupSm3yg8xwSAa5l23rVM6B5fVOSNw4oJ5zB+EbEpSs=;
        b=aIJXMJvP+kDoMlMt2WcEORmuj57lAdx5v/1SdfCiwAw5qXNQ7RqBAIyKqxvGdw7sVt
         tL99rmu4te509vhmR92YJndPJ6r1eR2h6UuY+qj+tKs/5nTCggSbF1LHF4uvFwmXS+yY
         3RiQRG6xKneHfPdu60Y0T+9cObWOwwt3wuIETnbqXDiCgwmnceFV0deKItepDw2QL3ob
         6lV/p/K684pFWEQEm4k5dofSmuPxT1GskhF5ZdRicB6PETszuktxt1qI84vuzEORBPJD
         75gUs6hjDsen6hZh39K6gtQvtd6+S3AgppcbWBCtDif7xz8NAaqNZM++LQxViHE7CoJi
         Bv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730218061; x=1730822861;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IupSm3yg8xwSAa5l23rVM6B5fVOSNw4oJ5zB+EbEpSs=;
        b=dWLsWtlqtSzspYBV/8RolC8SAblvNr2KIvUx5ISZ45rLgDL5iqGGgp1CFdT2g0Qs2Y
         jfQi+bV0DPX0UYLrzkV359cDj4m0mG6EehTg7TapccLEgycNQgjWlOtjezOpU+fWZ0t0
         yXmwVtoo9x7a+0hAbxcpK5lNlWYnvusB/rjVrx6SHWFlkainacLYpSUkFRKzL4fhUqwl
         QwPBg51K1XXcCrDYXULGPrtlp+g4L3K4KKOjw+FTD8uEMKEdWHWJSFnzW+QR9uBaI8OX
         f8UFBiHbjOlba0nViRcjE3xa0nv0VGZG6FzwFVlSf7dMR5itGRVv2XAEA3FsxSIc8uHV
         Yg4A==
X-Gm-Message-State: AOJu0YxKyC3V4TrEtIRuUjq5BIfjI8CYpWv0K/ZBB14Xep9D9w4fyRsl
	Qsxmuwh/mcFfXWLS2HLlpP61juZnl8eQnH7JzaCd6tfikysKnQ2w0SefdepaZeSglP61sqEbec3
	5FYWzGvdpc97Dj6KYUgKd8NIiJ6I=
X-Google-Smtp-Source: AGHT+IGdGrSeiIc+mLhAo3LaEj/FmAoUKQgHRtCNLY46rlVdLGAGnkqCllXXkhR7sNAOaupPr/wGgq80zbOWLCOSwxM=
X-Received: by 2002:a05:6122:179c:b0:50d:4a9b:8f74 with SMTP id
 71dfb90a1353d-5101538df17mr9731187e0c.13.1730218060460; Tue, 29 Oct 2024
 09:07:40 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Oct 2024 12:07:39 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zx+98PYOONmoA4A7@nand.local>
References: <cover.1730122499.git.karthik.188@gmail.com> <89ee3f48ce982236dd7841fa1a5cb15aa256b901.1730122499.git.karthik.188@gmail.com>
 <Zx+98PYOONmoA4A7@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Oct 2024 12:07:39 -0400
Message-ID: <CAOLa=ZRO9-ob6QrstLJJTrvnbJGpQAymYvLQh8Z5bFxGYJgiHw@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] config: make `delta_base_cache_limit` a non-global variable
To: me@ttaylorr.com
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e0fabd06259fc823"

--000000000000e0fabd06259fc823
Content-Type: text/plain; charset="UTF-8"

me@ttaylorr.com writes:

> On Mon, Oct 28, 2024 at 02:43:45PM +0100, Karthik Nayak wrote:
>> The `delta_base_cache_limit` variable is a global config variable used
>> by multiple subsystems. Let's make this non-global, by adding this
>> variable to the stack of each of the subsystems where it is used.
>>
>> In `gc.c` we add it to the `gc_config` struct and also the constructor
>> function. In `index-pack.c` we add it to the `pack_idx_option` struct
>> and its constructor. Finally, in `packfile.c` we dynamically retrieve
>> this value from the repository config, since the value is only used once
>> in the entire subsystem.
>
> OK. Perhaps I am not quite following why this change is necessary, at
> least in the context of the rest of this series. But let's read on...
>

Ah, well, as you know by now, it is to cleanup the usage of the global
config state in packfile.c. I think I brief over it in the cover letter
but like you mentioned in the next patch, I'll amend and add some
details here too.

>> @@ -1604,6 +1604,10 @@ static int git_index_pack_config(const char *k, const char *v,
>>  		else
>>  			opts->flags &= ~WRITE_REV;
>
> Not a huge deal, and not the fault of your patch here, but the
> if(!strcmp(k, "pack.writereverseindex")) block should terminate with a
> "return 0".
>
>> +	if (!strcmp(k, "core.deltabasecachelimit")) {
>> +		opts->delta_base_cache_limit = git_config_ulong(k, v, ctx->kvi);
>> +		return 0;
>
> But here you do 'return 0;' at the end of handling the
> 'core.deltabasecachelimit' configuration value. Good.
>
>> diff --git a/config.c b/config.c
>> index a11bb85da3..728ef98e42 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1515,11 +1515,6 @@ static int git_default_core_config(const char *var, const char *value,
>>  		return 0;
>>  	}
>>
>> -	if (!strcmp(var, "core.deltabasecachelimit")) {
>> -		delta_base_cache_limit = git_config_ulong(var, value, ctx->kvi);
>> -		return 0;
>> -	}
>> -
>
> This is safe to drop from git_default_core_config() because the static
> variable from environment.h is gone, so nobody is accidentally reading
> an zero'd value.
>
>> diff --git a/pack-objects.h b/pack-objects.h
>> index b9898a4e64..3f6f504203 100644
>> --- a/pack-objects.h
>> +++ b/pack-objects.h
>> @@ -7,7 +7,8 @@
>>
>>  struct repository;
>>
>> -#define DEFAULT_DELTA_CACHE_SIZE (256 * 1024 * 1024)
>> +#define DEFAULT_DELTA_CACHE_SIZE       (256 * 1024 * 1024)
>> +#define DEFAULT_DELTA_BASE_CACHE_LIMIT (96 * 1024 * 1024)
>
> Adding DEFAULT_DELTA_BASE_CACHE_LIMIT makes sense, and I assume the
> diff on the line above is clang-format noise to keep the two
> declarations aligned or something?
>

Yup, indeed, that is the point.

> The rest looks good.
>
> Thanks,
> Taylor

--000000000000e0fabd06259fc823
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 40303db24b632e59_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jaENFb1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzdKQy80L2xPVGJ4RW81Ylpadmc5MXlTZTlWck5iZQptZG1vbTIwOGVZ
bU1qVmxEQldpT2MrSCs3VDFNc0NvUFdvWlEwdElpRkZYdG5iZFB3UDJTbDc1WlREQzBYUlM0Ck1p
R3U5L1VQTjIxb3dyRkxyRjdhZ0NLbzZDWlJTbVdCZy9tSEU0cjVLc2xORWJISlk0TStubUlNaGtS
MTFGSGQKWC9tZmNtMGttR3JEMlFkZjlRZ1ZFSmtXcWhhcjNoYVlxMStlMFpybkxxZGJzYU9tMlBU
QVBVenFGcXhDdUg4dQpqTlRSdTRuZ2Z3Y1ZiZFkvdVdGYmplKzA5dndHZEFVdENlNGRLanI2dmNC
blZlb3lBWlp3Z00xZDVsOWJrN3grCkY3M1ZuZXMrY3lQMnJzQWsrMnRPZEdCWWFINWlLZ3EzcHZ3
VWNseVMrMyt4aXBxT0xuUTM1amVzTVZGOUhkQzcKOVBxOG0vWjdNMlVTaTlvSGd3MzY5eWRRYzhl
YVlvb0tpdnhvemVPZFFsZFNpZXN1RkVMT1pOUEdUQi9QOGJFRwpzdEVVWXVaSTFzTVY5ZGdZQm5Q
eFdpTmg0Z1FPb2h0OUpZNGxMZ0Z4MkM1L1RHcG5xVE9lV09CSGE5c0dvWkRlCjNZdm5XK3YwWTk0
ME10NVZSNFJDQVhndFZvVURCUVVSRmxpL2piND0KPURsaGMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e0fabd06259fc823--
