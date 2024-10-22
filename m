Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F07C1E51D
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561135; cv=none; b=EFH3thOWHG+aLUVyPBNLTMPF1euNH6yxIYGLAt1DuCOsLXYdWJdD4xazCBdilB0LHPD8lFiCUEvmf305ifNb9TMsSQVO1TOdyZViXf6zo01lnrIvcnSELmj39qK3RjFfho78IK5ec+2DSC1g/YpMtScwzxSWeGivDKwRudLfW84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561135; c=relaxed/simple;
	bh=dtTRXL9w7w3T1JWgXhPe1GJa+vSjXjurDjhvHX/oJ8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s669mDgJzDI9aww2eRT2YWMmHBR/9mxBVFAtABR3DyW+YPmdtxnXt4F0ADrSttAvqpvqCCzOwv/7wweOf0WKA9UfyJx0ZoeYgTDtraI6Puijb8FkYK2lWhpFc1gdDVBOWPu23sLZ4S5f2u605cX7UK2ZL1CwiWv5vLLAdXcyi68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXRoOFmV; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXRoOFmV"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbe68f787dso30666556d6.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 18:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729561133; x=1730165933; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dtTRXL9w7w3T1JWgXhPe1GJa+vSjXjurDjhvHX/oJ8U=;
        b=BXRoOFmV2WxFYSbEERBAuAV44G8vIT2pgnUEwPgmEnNrTLcUXsRZxFE58ehSwuvYeI
         8hR+gwiDVslgnrq9HlMmJaPo+173MXaiUYRzzCHnlkUP5dtLpatSUCuHYxrOrNMmhMlo
         O7hLn30qnfV4LDWlRUtHyvgrhEgbzRPQyw9fYZY3gECPoDVh2ernhoJneFo3zfm10pJ5
         a8X8dR60eQmdmTpdJIurUBhW9w99rHHQMYbDN2FU7Yf7Kkzq2b9i97jklXASxS7k3jYk
         dLPRE/gn24Op8bxPswrC7A/NRn9CSN2wCCGAPyy1HkItvFB4aUWtsj8u//L2aK1KS1CA
         xT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729561133; x=1730165933;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dtTRXL9w7w3T1JWgXhPe1GJa+vSjXjurDjhvHX/oJ8U=;
        b=fwmXeEz2gs0+lt1VpdzDp6eDYXg9SLV7XgpUdlooj+9Jvs//+v6IhQSsnRCZnHzOJo
         rv0YVwsQLFAIlPxCoUfhdSZ8m14D3iIfZqIPu78LNLfFDLFxN8TGatnYmkgGiKp0CkPD
         +3Rpcb8jfh/MBWn/SkPDpfJ4Tf1btzqznHeeSeRdRnM8aRbLfJCbZM0fPoZsurl/lr1M
         MkqMyXlSpxMS04D8UXqzbP5Q2KVjcy7wl3wy2f4Syhg2yPnthqOsYSQEh8e6YADiyxBi
         KDi26O/MXz4+xlnpjHutcKqDcI90os+1zcEzHAlN/G75vCcK1PLrwgAIEE09Vvw4afyw
         UbKw==
X-Forwarded-Encrypted: i=1; AJvYcCWhrBQSw8k8C+9yJ7jCy5gObLs5hvJtR0HGo1mldV8Ec1dLYRsug9VJrO/ppS9HuVxd9Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGBJcxkgs4Kii3HpoMLzbO2jcHa7INUfrIyuM+lSdW7qjgzDDY
	bV8iMSvGhamGlAJVmmV6fFpmkv6UslJr1u+NxTFrKkyNO5gc8groUaMViWPn
X-Google-Smtp-Source: AGHT+IGeMVazqiLOPs0+bXI4YfUGdinZeUx2fdum1xW9ayOx0kIZH+boKOXWCQkq8STW4ampOBnuTw==
X-Received: by 2002:a05:6214:3c8a:b0:6cb:a616:7c7e with SMTP id 6a1803df08f44-6ce23d3c599mr11191896d6.2.1729561133134;
        Mon, 21 Oct 2024 18:38:53 -0700 (PDT)
Received: from ?IPV6:2603:6011:3f0:6f00::12ac? ([2603:6011:3f0:6f00::12ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce008fbbdbsm24076086d6.37.2024.10.21.18.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 18:38:52 -0700 (PDT)
Message-ID: <9820a7a6-c9c0-44eb-9c04-9445a5061c14@gmail.com>
Date: Mon, 21 Oct 2024 21:38:50 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t/meson.build: fix up tests for 'seen' branch
To: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 GIT Mailing-list <git@vger.kernel.org>
References: <8b08b64a-aa5a-422d-9815-e67911a703e0@ramsayjones.plus.com>
 <ZxXu2rG1ls8UcXug@pks.im> <ZxbEJbigarbklNJq@nand.local>
Content-Language: en-US
From: Eli Schwartz <eschwartz93@gmail.com>
Autocrypt: addr=eschwartz93@gmail.com; keydata=
 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
In-Reply-To: <ZxbEJbigarbklNJq@nand.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------gUf0WhPYWub129XRq0mSSZxL"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------gUf0WhPYWub129XRq0mSSZxL
Content-Type: multipart/mixed; boundary="------------UOqmQLpgbycvEOwxiIMLAboz";
 protected-headers="v1"
From: Eli Schwartz <eschwartz93@gmail.com>
To: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
 GIT Mailing-list <git@vger.kernel.org>
Message-ID: <9820a7a6-c9c0-44eb-9c04-9445a5061c14@gmail.com>
Subject: Re: [PATCH] t/meson.build: fix up tests for 'seen' branch
References: <8b08b64a-aa5a-422d-9815-e67911a703e0@ramsayjones.plus.com>
 <ZxXu2rG1ls8UcXug@pks.im> <ZxbEJbigarbklNJq@nand.local>
In-Reply-To: <ZxbEJbigarbklNJq@nand.local>

--------------UOqmQLpgbycvEOwxiIMLAboz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/21/24 5:14 PM, Taylor Blau wrote:
> On Mon, Oct 21, 2024 at 08:04:16AM +0200, Patrick Steinhardt wrote:
>> For our integration-style tests I'd be okay with not listing the files=

>> individually, such that we instead use e.g. prove(1) to run all tests
>> via a single test target. It would be a regression in functionality as=

>> we now cannot easily run e.g. "meson test t0000*", but at least we wou=
ld
>> not have to maintain the list of test scripts anymore.
>=20
> I quite like the ability to run tNNNN-*.sh individually when spelled
> like that (i.e. including the test number, but not the full script
> name).
>=20
> I find that for the areas that I have worked on most over the years tha=
t
> I have the relevant test numbers committed by heart, but often don't
> know the full script name. So it is nice to be able to refer to them by=

> number only.
>=20
> Am I reading it write that this suggests that Meson would lose that
> ability?


If "meson test" simply ran the prove(1) utility then it would still be
possible to do:

```
meson test --test-args "--args --to --prove"
```

This would not actually do what you want, since prove(1) doesn't
implement "t0000*" style globbing, does it?

So your reading is correct -- meson's own globbing support relies on
meson knowing the list of all test names, which means you do have to
maintain that list somehow (and have that list update when you do "git
pull" and new tests materialize).


--=20
Eli Schwartz

--------------UOqmQLpgbycvEOwxiIMLAboz--

--------------gUf0WhPYWub129XRq0mSSZxL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQKTBAEBCgB9FiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmcXAitfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDYw
NDExMzA0QzA5RDM2NjI4MzQwRUVGRkNFQjE2N0VGQjU3MjJCRDYACgkQzrFn77Vy
K9a8wA//fCtkZ7V5w/kYPAFA1QAXyXd7MjbfiotBO4Y3xgIKx72gcEzNfNVhDNMV
X5957b9Hyiaq/FbLuz3p/8KrmTR3Y+rFIm1CPpRjx2KDqfwOqw+aVWn5nnBSUoJV
+GheLyDRu8JiVKhSOk/0mXEAzyzs3/rQOBAF73Li7nNlPzgfGeFMA+xhcMq1IOYo
WE5Ue+o00JBec/t0+TdgVhhechYpZWDCVPQLGd1fTfZwvYNxuhXFjpbeeRZzsZQk
zvoT0tIe0TAZ2PWO1qCi4DKJ7FpfnPUn8f40p8LRAjKMqyS+AlAkWlsM3r6CNkag
h6N3u/+nfEf3Z5OR6VPZ1lXYMO7wV6g4EITEWWpBbTpXH6ZZoKJ4VUmfEYUrHQ+J
OjDfeZiQjVqmZS4rmHte4UOJCQPIyYTfPvuQahHmKZhDcjponBe+Ttx7ruaOuWOA
/E4+ISH42wVJiTy8VjRFzFbHwv/+IDkYdF+I13a00SFpKAXgcHWyxqMdumm7jmEC
aTK4xworCkBVT1Qw7+BuBLUY3DqJY0axTqZ8YLxWFp9zb5d/LG+QpWvIqIAGafhu
nG9JOfSQ2TL+nspPeyH061GzIuPnKuZZbJnl373cB/MPinfAGYxib14tRtVkWf9n
/JXeCJ9//fEP2cFgUUogUxYSiC+/UzGWq2YGfbs45Y9Ic9mPnHA=
=uieO
-----END PGP SIGNATURE-----

--------------gUf0WhPYWub129XRq0mSSZxL--
