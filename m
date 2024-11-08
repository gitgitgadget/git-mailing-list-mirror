Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654191DED5A
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058088; cv=none; b=mnVbaeJJtz0CsUEFBe3Den2vlm3bkxiIZRJPTTWUg0aecFthTNBN6bFjkvKk+TTTLski5w145Gb7Gdx9XDtvhC6yFm8rswRuOJgCsT7MJHh8PwCm8aX18sdGk12ldYKrydcekVbAKap9A4aArqYjaozpkN4vdZ7y4d1oPnMZnVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058088; c=relaxed/simple;
	bh=L97lvKDLxBf6ooTrtisC5/U9tyOlfWollrnS9Dd+9ec=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7/wBcRzBJ+SWwORz+et13zGN5OgMHRAdJhovsFgx7vDep+5honaovToYCsRBzPpg8gQe03zAo+pge2MoNAhyeMps+43MCc0RV70ImK1+GLXxCb+GPfxODAQ2/FvtZVoPjpuLXGXlUGozr3eZIeBt5jRGk5ykA2+sj5DMoMsdQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Te66W87A; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Te66W87A"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-84fd50f2117so848680241.1
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 01:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731058086; x=1731662886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=47sun8Jay7p5vPbpHRkZisxINMwt1HbR1UtaaQejtD0=;
        b=Te66W87AryaInuJ1lS6ONQzHjqWrKd+18dCYR7YKxZfTW5WvTXkC4TkI7ocvhyLx/A
         ujyZbUs8pAGOiIIHeqmkrZ9VYKcXgVwTl6ghwt4H03IybWsnyu0ajD7DBqmZLxFiBW7B
         4aEupEESXba327njyepI3jb8VNNitJF9XsTCmX43aDbOv8wcPMu3iIiePvw78rZGLV1a
         oLmkHduKyjKCw40y9rXGO7p1ltgyr/nTN3Z3fYtjecIaC516I7dwtQ6ZTLrZvydc18Rn
         zZ4LBudBE4eOEOU4gHo0Sh/gX2tOE0Ek3O6lqWAXjAdEfci7EexBwcCZvcX3V0lYWNOQ
         pqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731058086; x=1731662886;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47sun8Jay7p5vPbpHRkZisxINMwt1HbR1UtaaQejtD0=;
        b=eO4prxapDnC93Ke3QE6QMD729FicieaO8Tl/sRT8eIbgmFRyLeMnOF4uq5aHmRY9ZO
         z0Y1DP4fdPc9Szdp+Icx+AbIPxbl8omR2yzrfyFVCSnhy3NVjaAjP8Y3bY5P46sAXh9u
         eGWd+DQsHmueMguMp7t/aewEjFLz58SXjDR0K89/eIj7oH0cMcxK/urbQ9JP/h84qLKp
         H8CCjLzlkv2igv/593CAv3ltvQUbQz+ufy4nV8ND0Vh/dlfJUVar0aNxjCu2GVgBp486
         xqmDQcqNAKjX4xRWQ98Wqrdp21DtqoUuHsb12CifE/VJxpNc1qcldJipApOvw1RtcMGD
         RtcQ==
X-Gm-Message-State: AOJu0YwHtXlxAL5BKAxRM6Mkcm9Ewq1C5dqo3pw6Y7Wnn5BIU8Um/9GA
	GjSsUdJU8jYF5DSr0o3FkfBA3jx/4cTP8LrIL0EdtWLhgvnx6N0cb/OJR3gtsur0/xgyjM8uzAT
	7FSxyo/s+b1pctB93EgZbpNkZZ29+LQ9i
X-Google-Smtp-Source: AGHT+IGYa58Ddkvwaew88aibDcENSpVRA7nGA7MdLxyirdulnAo+ShaaTpGWAuhYf4rPMWz/HNPeN0MjTXWb7+atyEk=
X-Received: by 2002:a05:6102:b07:b0:4a4:93d0:df13 with SMTP id
 ada2fe7eead31-4aae13b3c22mr2455760137.16.1731058086255; Fri, 08 Nov 2024
 01:28:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 8 Nov 2024 04:28:04 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo72qnp1o.fsf@gitster.g>
References: <cover.1729504640.git.karthik.188@gmail.com> <cover.1730976185.git.karthik.188@gmail.com>
 <xmqqo72qnp1o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 8 Nov 2024 04:28:04 -0500
Message-ID: <CAOLa=ZRoiG=CTxkCV2TZ6Ko22Fh+KMiVmubWsaU-WLdGGjZEZA@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] packfile: avoid using the 'the_repository' global variable
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Content-Type: multipart/mixed; boundary="0000000000005149890626635e04"

--0000000000005149890626635e04
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Changes in v6:
>> - Lazy load repository settings in packfile.c. This ensures that the settings are
>> available for sure and we do not rely on callees setting it.
>> - Use `size_t` for `delta_base_cache_limit`.
>
> I'll trust the reviews made while I was gone and will comment only
> on the differences between the last iteration.
>
>> diff --git c/builtin/gc.c w/builtin/gc.c
>> index 9a10eb58bc..ad80c3aed2 100644
>> --- c/builtin/gc.c
>> +++ w/builtin/gc.c
>> @@ -138,7 +138,7 @@ struct gc_config {
>>  	char *repack_filter_to;
>>  	unsigned long big_pack_threshold;
>>  	unsigned long max_delta_cache_size;
>> -	unsigned long delta_base_cache_limit;
>> +	size_t delta_base_cache_limit;
>>  };
>
> Makes sense.
>
>> @@ -170,6 +170,7 @@ static void gc_config(struct gc_config *cfg)
>>  {
>>  	const char *value;
>>  	char *owned = NULL;
>> +	unsigned long longval;
>>
>>  	if (!git_config_get_value("gc.packrefs", &value)) {
>>  		if (value && !strcmp(value, "notbare"))
>> @@ -207,7 +208,9 @@ static void gc_config(struct gc_config *cfg)
>>
>>  	git_config_get_ulong("gc.bigpackthreshold", &cfg->big_pack_threshold);
>>  	git_config_get_ulong("pack.deltacachesize", &cfg->max_delta_cache_size);
>> -	git_config_get_ulong("core.deltabasecachelimit", &cfg->delta_base_cache_limit);
>> +
>> +	if(!git_config_get_ulong("core.deltabasecachelimit", &longval))
>> +		cfg->delta_base_cache_limit = longval;
>
> And this is a sensible way to fill size_t member with the value read
> into a ulong.  Should "longval" be named after "unsigned long" instead
> of "long", by the way?
>
> There is a required SP missing inside "if(!".
>

Agreed, will fix both and send in a new version.

>> diff --git c/packfile.c w/packfile.c
>> index e1b04a2a6a..46f5369173 100644
>> --- c/packfile.c
>> +++ w/packfile.c
>> @@ -653,7 +653,11 @@ unsigned char *use_pack(struct packed_git *p,
>>  		if (!win) {
>>  			size_t window_align;
>>  			off_t len;
>> -			struct repo_settings *settings = &p->repo->settings;
>> +			struct repo_settings *settings;
>> +
>> +			/* lazy load the settings incase it hasn't been setup */
>> +			prepare_repo_settings(p->repo);
>> +			settings = &p->repo->settings;
>
> This is a bit curious.  I'll read the individual patch that has this
> change before commenting on it.

--0000000000005149890626635e04
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 80f5cca7cf20d1d7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jdDJhTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0xrQy85V2JDYjVoSUpiZlBqQW5LNCtFak50UU83TQoyYTdWU2x6SCsy
UDdJVkE4U1RPOWFWeDZ2cExYQ3NpcmsyRFB0dCtwbE5oOGtqUTNSYkdpK25lb3NINlZYNFcvCjR5
dy8vNTNoSjhYTWJBVGMxbmlZN1NKZzlWR0VSemFqL1N1Y2NaKzh4aXpQUmJJd1ZobXFhRnNib1Yz
cVEyNysKaCsySlJTaG9JQzdaeFNOdTc5SnVhWW1WQS9kamlnUTA3UjFIbzZCbVMrWUMyTGN3RE5N
clZ4UjJtSGVJTW9sbwpReFM4QWZiRERzbzZuQ2RteEh4bnZvdk01eHU3N0hpUm1rWUFXOGoyRnFY
NytZRW40Yk80RU5JR3ZYcU5lZnRVCkNlYllGUVJNSWRyVFF1emd3NDZZcktxL0o2S3IwT1piZ1d2
TmdEUzF0SU5RTTdkYk41Z2dQUkVOVHY5QUh0Y1QKVWN2M2xFbjR1dzEzVFhoOVJqbHRiUlQrdDZU
eTRuUHl4VmJvMllJMStqKzRRWUEwVnU1a1V1S2U4eTY0V3g5MwpUYVJ4dlhHRHpXdU93Z0NiM0Y0
cWV0OXdBYnpmTmt0eGFTNW9QVU9VUVpNK21ISUU4ckx6TVpvSmRmM01ETVFuCjJSS3k2cHlhU20x
L3gya3FPY3dYK1FYWDhmdWVqUUw3ZVIvV3V2MD0KPWtzbm8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005149890626635e04--
