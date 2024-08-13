Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B633D19470
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544076; cv=none; b=PqkZHGCtIbL7mic2rup1Cqdy4jcxLUOtHVQ2lE3gBnknThUZIU98uSKOMfaaLRgecFmiYx4YxeC309uUZmnNT2oGJWreMD4FohGHUhRBeu2pXzBBcJ7kPa6+m1Mch77ShNpDV5WFvMndDtrWCp4nTkuoCcCzgQp5FRgp0Sj0nhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544076; c=relaxed/simple;
	bh=s+loSDG1Xyt7gHpglcSb0Q/vqBeTr+d085QFaCyV28s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=bFNhfTNtFx7dFP7dReqTAOz5FqaPURYDgdsVi7wJrS3sURn31IZU+dX9A1dTYpn89L96b782plpXATxK0fJQTy7Cmm8d3mW4sYRYvDtJUFpcCGhengEbZFqr6PbGBFThdCvQ+pkhO3Ef1UPAUKVSTOPq7iW1yXFMbFQ7JQ/wIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKzm+yUL; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKzm+yUL"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5af743b8fso2780124eaf.3
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 03:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723544074; x=1724148874; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgsHPhSBqxnBYpytIZcG8m0uBn50zofJ+qttYjGnxxw=;
        b=LKzm+yUL700jZSD9poNEz3FcMvssYCSlV82y4woxc+Aws7sp5/6L15giDGvjqCZ8IB
         8DlnNJKejZHHqOc9Gg6D1HK5+W3D2l4vnlach2QR60HJv1S/VYxVAAn7arOovHFLzi+B
         O6+VzAR2wO+aTOwRzkRAD8iq+Qsu903Qr4sCb3nJy6roVDiaG7yOdq/UXG3r+5/DA+QV
         1zezSRdh/shAUYtygou6/7ZqMIk2Z8+5uPZNlehKz0+OiHOaqDzsGrCFlwc3EgPM50FU
         eiOcu5cjbPlVC41wzZmzq2g49sASEOQsJMlmiyOdCit6PKeXY5bAnTiNoqKSp1fQNZUy
         AN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723544074; x=1724148874;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgsHPhSBqxnBYpytIZcG8m0uBn50zofJ+qttYjGnxxw=;
        b=nq+q1nFzgiekt90ubYu0u7c5wLA99LRJsr6ZzrZUvOgcidDI5H2qxq2+233ov+7EDy
         8elbtJmKzkt4UQo+ctrAgJ1AFmpPxogUyNjLAxNizgfnXxcpLNVUNEsmBqqhqhiEObSP
         dvPndRM7moJcignW8T8ERmHsAeWiOI8OdEFEbrw2a3Rr/aAYiRAXcEFLBGT+2CJCqFVH
         ejNNmwyK/xyNqHXCa3HrDRog/tPXjJqf96eAjPAq1zo5wSkPMFp97LnsWmlTp+Szy7ay
         ZMT2rLqPr4XhK1um46Ej4PZQQA3l8gVwqC4CS81XbZoziGHt3BxxzYHO3TaXs/q1bLKA
         D6uw==
X-Forwarded-Encrypted: i=1; AJvYcCWamEF+cWN3Q5JRHKNprK6dB4a84TLMTr0VhWckQ2sX/7c3E6RDxr53v3ijOcMwq3mCq3Z6DMfrL1ALtOoBD8PLRrHQ
X-Gm-Message-State: AOJu0Yylc5/ZcXJPAAUrYRvEYk8n94x6T7dwrLmuW/HHKCE37DmpzF2d
	jAu6LfUMC0GNau//03C6KWRwd8c/ImR3iT3Y69Z2wp5FmLt1CJ8H5Mn2CBnrMPK+sbafBje46am
	2FmR5GGGma1vy4EjQiapTGxbwMBU=
X-Google-Smtp-Source: AGHT+IH8VGse1rB+LemPPG5koNimEIroyc+Q3igigp/Sn5iVczyT0v3p7CeLLZ3e3PnzgX3SIrUl2B6ydYJIqsTTEvw=
X-Received: by 2002:a05:6820:2283:b0:5d8:10cb:c336 with SMTP id
 006d021491bc7-5da6868cb03mr3932479eaf.1.1723544073666; Tue, 13 Aug 2024
 03:14:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Aug 2024 06:14:33 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <1f211e514d049379ada609e6a4e8cf985e721271.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im> <1f211e514d049379ada609e6a4e8cf985e721271.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Aug 2024 06:14:33 -0400
Message-ID: <CAOLa=ZScKRvAWsa4D+_BCyAbxQ9580RBnJ+==DfCvrGV6C2ETg@mail.gmail.com>
Subject: Re: [PATCH 08/10] reftable/dump: drop unused printing functionality
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000044708e061f8de0fe"

--00000000000044708e061f8de0fe
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> We have a bunch of infrastructure wired up that allows us to print
> reftable records, tables and stacks. While this functionality is wired
> up via various "test-tool reftable" options, it is never used. It also
> feels kind of dubious whether any other eventual user of the reftable
> library should use it as it very much feels like a debugging aid rather
> than something sensible. The format itself is somewhat inscrutable and
> the infrastructure is non-extensible.
>
> Drop this code. The only remaining function in this context is
> `reftable_reader_print_blocks()`, which we do use in our tests.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/dump.c             |  16 +----
>  reftable/generic.c          |  47 -------------
>  reftable/reader.c           |  21 ------
>  reftable/record.c           | 127 ------------------------------------
>  reftable/record.h           |   4 --
>  reftable/reftable-generic.h |   3 -
>  reftable/reftable-reader.h  |   2 -
>  reftable/reftable-record.h  |   8 ---
>  reftable/reftable-stack.h   |   3 -
>  reftable/stack.c            |  20 ------
>  reftable/stack_test.c       |   7 --
>  11 files changed, 1 insertion(+), 257 deletions(-)
>
> diff --git a/reftable/dump.c b/reftable/dump.c
> index 2953e0a83a..35a1731da9 100644
> --- a/reftable/dump.c
> +++ b/reftable/dump.c
> @@ -41,9 +41,6 @@ int reftable_dump_main(int argc, char *const *argv)
>  {
>  	int err = 0;
>  	int opt_dump_blocks = 0;
> -	int opt_dump_table = 0;
> -	int opt_dump_stack = 0;
> -	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
>  	const char *arg = NULL, *argv0 = argv[0];
>
>  	for (; argc > 1; argv++, argc--)
> @@ -51,12 +48,6 @@ int reftable_dump_main(int argc, char *const *argv)
>  			break;
>  		else if (!strcmp("-b", argv[1]))
>  			opt_dump_blocks = 1;
> -		else if (!strcmp("-t", argv[1]))
> -			opt_dump_table = 1;
> -		else if (!strcmp("-6", argv[1]))
> -			opt_hash_id = GIT_SHA256_FORMAT_ID;
> -		else if (!strcmp("-s", argv[1]))
> -			opt_dump_stack = 1;
>  		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
>  			print_help();
>  			return 2;
> @@ -70,13 +61,8 @@ int reftable_dump_main(int argc, char *const *argv)

I'm a bit skeptical about this change because I definitely have used the
`-t` and `-s` options a bunch of times to understand what a table holds.
Since the reftable format is binary, this is the only tooling we have
which allows us to read this format from a plumbing point of view. I'd
keep them. I guess the stack printing just iterates over the tables and
prints them and could be removed, but I'd keep the option to dump a
table.

Also this patch misses cleaning up `print_help` if we go down this
route.

[snip]

--00000000000044708e061f8de0fe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3bf40ff1158dd148_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hN01nY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3RCQy8wWjhseTBFQ01id2ZPcXAyWHNmL0pGTFdpSwp3dE10VW9scDBy
a0ttSUsyTklaKytGbEJROXZTK3hDTlVDZDluTDRyb20zWFJoWFI0V3R4ZnM4QXFhRmo0MDJ4CjFu
TUhBVE1iSFZhUGlySWY5MFlsWjQwa2QySWRXbndsZmpMWlp5R1p5a1Z4cE51R0I0a28wZUFtOW5k
dkF5b0gKcEl2WEk5L0Y1ZjZSK0J0NVdoUVo5SENDSmhZQWZXNGJzU2d0MWJxNXJpQjVTOWZGQzVz
QmhQSnJCTDBaL3c4UQp0K0FrSmF3UG1wZHc2N25Nek0xb3Z3UFMxbjh4U2tES2ZLY2dTSmd1WG5C
SjNZNHNzSHlCRHlpcjRxSUlRS3JMCjlsWlhTL2NyVkhQbnJaZ3pZdlRFOXJiU1Fkd200aVZvM1dh
SHMyVE5wWlU1cE53VkhnWlFIRVR2aTFVWnlaR1IKK1NPVWxMYkR0bXBnVk5jTWlxcmN1c2pUT3Rl
cEY2NVd5bEk1RXpNdGdWNzdjMy9rSzdPbHV1NWphaGZ0aVRRaQpiUGh1MkM3ZU9ZOGFqWDU4VDZ1
aXJoS0p6cExmcmN4RnRCZW5SVHRMczl4SnBIL2l3dkNYR2FIZTBQQ0psdXh0CkUxeVo2UEVIUE5x
ZExITnVqM01pRVd5azFoNmNtMnh0SkMvVkEzST0KPXl3Ny8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000044708e061f8de0fe--
