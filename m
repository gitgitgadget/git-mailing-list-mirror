Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79212EBE7
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731947112; cv=none; b=Ud0afkz+bXJLfoN7KyzSJlPvjjjE/PE/l7va9Jhs+gd96IT7qnogoc9uJDEnQp9MiwINxrei6WoXSxwUwXRbT1Bs/wgHG7LgaBXty/nr7Jv3NGoYliZdLkCo6+gtRZfrdNlVbh8RCHEVfZyyheRjgl82xIaIv4qDxoK0UY+VXaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731947112; c=relaxed/simple;
	bh=RaufVkaBJGMPc3R5jNlWBog8wzf1YHV68cJFG6bR+70=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ti40SF/Z70sQjbxi8bfko98NaN4XqNOLYYpaU/R3MU4m5BU3OieWjx4BbSiPcGZ2jLMoCKoA7vZb3yBDNaaQ3jYDB69Mdcd00WsZAUGBBbSQMAsiKsz9UFRPNuY6tINnpLn9UFWQjSIiV0EGbwE7gpxF1MTwkFV8S8YguRtahqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR90CBK/; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR90CBK/"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-50d525be53eso1224440e0c.0
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 08:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731947110; x=1732551910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JF8lbNskP/7L+sYUdZ+2ffuyNNM9/wfFQSbjEgAPpo4=;
        b=YR90CBK/Vkcn+iidBiZha7xuddy48AadEwUSfHZSdKkKG3RhVXIX7SXDURTkNYc/8W
         TJGBFQh+31+o8PXGk7T8D7bH6v07G3MIA3D6L83xVxxwzVyw8+DuTeJW5JfjnZk6X7AO
         zufa3lOpfkbwCNnuxNwFnLIfvLBzOvleleErpnTKxHn1uZOh4vTWfR3ArQRiKSeWz1vJ
         AmjlFDIVoN2Au2Gn/PDJPoo/xrPwv0bJomiFLhKd6jsqIHHoixlHOrT1Ir6rUuYh9L4p
         vpehXEsU7/fjCn45IfyP8E/2hYZnP3PYIycSwQCvgzXqjJGAEooGyTWPgUD8t3oJe31i
         fb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731947110; x=1732551910;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JF8lbNskP/7L+sYUdZ+2ffuyNNM9/wfFQSbjEgAPpo4=;
        b=FoSOj9saZBf61lnDaNqSIS4KNrCC5HU//xaETeidrFJPaPT6WMpUoiNkp7kiNlvyN9
         95j1LhZkGBNEM08+H/nuJ0zxADSuCnt+7S+D7ape4FoNQu27RCAnebAuwTQzWEL9Oisi
         V8vYR5I1i+Dyx99CO+n9++8rRmG1O5tN7RHkY4TRt7hGvI6W/o0eO8cDR4EJ/VoWD48q
         wMlewV1wqWvA7siG7MHcruo3pCignFVEjrIdAuxgN/0eWotXn2MSq6mCmC1jilLGuNQ5
         u2KhfCUbVVLbFy1T7PNqC52Tz9gMSRzIdVNddagvoHqqZHom7y0XnUqREvotmwh4T3Uk
         6V3w==
X-Gm-Message-State: AOJu0YxfeIlFDQ1LxqBR1DRtP7bv8BjIWtFWX5dBs9m2hVgoKQdKXRjd
	CIL3sQ0qMqOCm3WL/t1lbz0BWEVGTfmRLbCoiHZOMdR0NK30RHUk1p9uoSYEvcJzYrOrFIeiqH2
	4DwHjY5dvTQa8SMPTJ+QapE4lu4A=
X-Google-Smtp-Source: AGHT+IFFCjGPLZRcbm1f4oht+GNaX8p0NatWvy8gN8IkNFvtqQ0q9ABFNcvaHfWy5wzeKO7J/A17hNoLPKjsq5o6LFU=
X-Received: by 2002:a05:6122:8c07:b0:50d:8613:6830 with SMTP id
 71dfb90a1353d-51477f11b6fmr12264968e0c.5.1731947109995; Mon, 18 Nov 2024
 08:25:09 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Nov 2024 10:25:09 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZzibPPpDw518npNp@ArchLinux>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-6-761f8a2c7775@gmail.com>
 <ZzibPPpDw518npNp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 10:25:09 -0600
Message-ID: <CAOLa=ZTU08VGeATHDwnREiYT=PMevrTvG3BzffLCc8DBcHy-tQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] midx: pass down `hash_algo` to `get_midx_filename[_ext]`
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Content-Type: multipart/mixed; boundary="000000000000431b050627325ca0"

--000000000000431b050627325ca0
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> On Fri, Nov 15, 2024 at 02:42:19PM +0100, Karthik Nayak wrote:
>
> [snip]
>
>> diff --git a/midx.h b/midx.h
>> index 78efa28d35371795fa33c68660278182debb60ab..7620820d4d0272926af9e4eeb68bfb73404c7ec2 100644
>> --- a/midx.h
>> +++ b/midx.h
>> @@ -7,6 +7,7 @@ struct object_id;
>>  struct pack_entry;
>>  struct repository;
>>  struct bitmapped_pack;
>> +struct git_hash_algo;
>>
>>  #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
>>  #define MIDX_VERSION 1
>> @@ -89,8 +90,10 @@ struct multi_pack_index {
>>  #define MIDX_EXT_MIDX "midx"
>>
>>  const unsigned char *get_midx_checksum(struct multi_pack_index *m);
>> -void get_midx_filename(struct strbuf *out, const char *object_dir);
>> -void get_midx_filename_ext(struct strbuf *out, const char *object_dir,
>> +void get_midx_filename(const struct git_hash_algo *hash_algo,
>> +		       struct strbuf *out, const char *object_dir);
>> +void get_midx_filename_ext(const struct git_hash_algo *hash_algo,
>> +			   struct strbuf *out, const char *object_dir,
>>  			   const unsigned char *hash, const char *ext);
>
> I don't think it's a good idea to put "hash_algo" in the first argument,
> we should put it at the last to align with the code style where we use
> "git_hash_algo".
>

Could you elaborate on why you think it is not a good idea?

I've mostly done this to stay consistent, because I see `struct
repository *repo` being passed as the first variable in our code base.

Roughly:

    $ grep -Iir "struct repository \*r" --include=\*.h | wc -l
    524

    $ grep -Iir "(struct repository \*r" --include=\*.h | wc -l
    327

Since `hash_algo` is similar, I thought it would be nicer to be
consistent.

>>  void get_midx_chain_dirname(struct strbuf *buf, const char *object_dir);
>>  void get_midx_chain_filename(struct strbuf *buf, const char *object_dir);

--000000000000431b050627325ca0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 88b8756596706a33_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jN2FtUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzRWQy80a1Q0WHVtNWVFUDUwbk40c2N0dlhscFlnMwoyUXZhdkdTOVd0
M01TclV2Y21MNXdOb2RmQlFrZ2txZ0lwekNCYityeE5sdVU1TURlUTlEcklxYXl0cklaTzBLCnIv
RUpUNlZtdUFoYmxlM0JmR0ZweGUvR1VhYlhRMDVPTE54Z3EwU3dJRGZrNk5RVDUzclRDcUZsbW91
eE1hRG8KUWgwWk9CZklkSzRFbHhCbFhzaUFiaUY1SFZpOUlVZ0FMOWZQbG1rVGdVTWRrRHFUR1Uy
QmJpdXFwY3A5RDM0SwpMWGJVd3ZCREpnLy9vbmx6Z0JEa2NYRnVHNTFCNUZ5cHF5LzVzdlpIaXNE
WWZ0SVBYTDdWZ2VLa1V2eTd1ZWhhCnNZajhDR1MrWHJoNDJkZmR1WVBkYTJSZHVKUi9CTHdlTW1P
K095aUFNQUU1OHVncmZ5d0pKU3VNc0Q2Z2tSMFEKUFNCeVhjdU5YTmZhbXhzRlJSNlVRcnBVTXQz
ZENyOUZmblBJdXFHV1VobFdCVlY4U0g1Z01JWTZhNk5ZcDYvQgoyMzBac0dxcDBCV2FaVlY1Sk1Q
a3MvZXc0Mkt4dm5rL0hOUzJRM0tBakVKZXhjQ3VrSDFoNm1pVzU4UlNERndrCnFLYUo4MFFhellZ
d2VoYWR0dHllUjBtSzFPS3FydUU0Skp1RVF2VT0KPUduOEUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000431b050627325ca0--
