Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0151FCDE
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788879616; cv=none; b=o1b//AarUrgD5EWW5X0kKBY2veoz9vl7r469IwfDKLSFg3b1W3Ojpqx5/perkVO1RYy96n3gD+D6kgb5XZ5WjLJJi7kFUw4bYQEk88M8B7IqUebSQM1r0jItiAxUxN5vsslxyqG3mRUlPQne9rKr4gi76NgIM0z+9KTbBdYw2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788879616; c=relaxed/simple;
	bh=csPTt3VKTvtTWBncdtw1zeZmE/d5yYPaZFO54pEf1k0=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=gZxGIYtA15HoRn/H4+3XF0B3hG3eDehy3yEUfkW1TJLQefpbTuEwt7ZSa4r88UcVej9wI5b+zh0Qf/u5utUTPkEqkw0dLctbEvn1HUeJzOxJZt+6D+V7wHyNkZMUm8CuSsaUIUpIjOjfMIcdpDQXfqgrJx+XXtbBn71JIZvnaw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejdXiiBg; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejdXiiBg"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66fcf87897fso3016198d50.3
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788879604; x=1789484404; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hT1d3xe/Ij6hu4oYomBDKapQq5WRwRAr04Rktd8oRfM=;
        b=ejdXiiBg9vLhqLYCNby66XPw26VUqa8Ib31XcyP6uoeYHGNPiXjzi2jI/rh/CImgbF
         YpNP4ReGRh0Pc9Mop8TJxsgH13ZApqEk0KMOSSFF4wIWK7Ek+PNiW6UmnPC/K9O+vGpP
         uzfZQvV2zt5hwn3nSRT6ZWYjJFlOW7+0CvNjMEydYzpH3bxiIORrAxZ5kTbQnzLbHfUf
         PkfexWoztbEOONftgc9pGrChQw8HYZ2T8R8yfT8xQhoL2JGX2AXGXY/IVKTjSNX/l2LS
         K1vf0N573kRUv5vMzE5vX0CJT3d6anWQeSnNFCxdju9HjPR/W+gGc9e47mfyyX1Xx6zq
         WBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788879604; x=1789484404;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hT1d3xe/Ij6hu4oYomBDKapQq5WRwRAr04Rktd8oRfM=;
        b=PaRkkQgngDA5Wx+jOV+lBUCTKZzD/1L0a/flFk3bKv0ThXE6/CyAsv6046RIV1IuLX
         PJeVRUTi0piUyQgqkZXPQcRkzb3FrU7SbWfLhuIZG0TgxxAFG3p+kFqIxf9MX0m6tqr1
         tB99jC+/7gARBHj6tEveIAD1PGQXGLY96YXerVuMUEdvIKU3tKCyfiEeIjhno0RWgXTQ
         K2tiERSs4ZsWnYMnXLDEh/KwwXo2TCqv1Xb0LxoQxVO/4wsmmgMmL83LpFvFxBRnS5MY
         afZKVza9ZeEjnbOoS30nBHwS+2PayLmY4M9geoigbXHPB1Tr7+PXGwySnzphvXZzTP9D
         IyCA==
X-Gm-Message-State: AFuF++lI2XL7sP6ejkoDUUJewkRMaTRoK/GJO4qpyT8i9InPb5ZH6xGA
	qidZwjdnUmKidYC9xxxtQ/TSoKmjbJn4xSvmCOcORWs64aaeA/qYQghji/+l2A==
X-Gm-Gg: AYBFou1dzgjyh3FDwj65+KuGWOz3UScLw0poucx9895kyKilf6GlpYViJ3xOJYGz4Wl
	sYkwr/G5rMT8gDYMfCP5RBuwcgOCb59nE4PZm+LTV5pTnMrmkTjRsgrQl1ck3Hfg1ZTqJMS9iXQ
	cEl/qzkdX3IBBCoXXztTXSJPGN3CVj9SMZCjGcj8X62/eSOQSiOVKSpmZUPEq7TSTKjpuARQVL8
	9Ae6HTH+LFZPhdGIsL8l+GTEcMBRunjDn9GYBX3ObxSWvQedv5eexB4tqzXjLpzJLQP1aWEGX6X
	k6Affpa0KY6S0wNNSY20OOieW/dVRrN61IYyNSRPv5rir/q9nZhwwyyEYh2caWM4XlYa3wyrpVS
	GmuySe5MCsKUAItcS3B1EmK3zNwcbxjKdbggNDKGPNMOxddGe23PefJedU7dkncHVd5bdnMLJOi
	OkTCB0OFdzbkHt7UdQ3HIgIGgzJKdhSKqs+9NxVTAse4hn/VY/BkJE9E3O8hxEBnXKF2ibm0Bg0
	zQL/rI9qCCdjoL+glRoPXWWLCasqc1CaFgZN7O9IgMsqji24tvk68US3etXou1RhQawiU4ns1uk
	dY7HNsB1iBhAq8zwWzY4Oe1OGnMUfZM3bwC1Hg==
X-Received: by 2002:a53:490f:0:b0:66f:c1bc:4094 with SMTP id 956f58d0204a3-66fc1bc485dmr5567057d50.87.1788879604372;
        Tue, 08 Sep 2026 08:00:04 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:1c52:19a0:db94:1863])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb497cf0dsm10473501d50.21.2026.09.08.08.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:00:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] advice: use global config for default branch name
Date: Tue, 8 Sep 2026 10:59:53 -0400
Message-Id: <7D54AA3C-0724-4C8A-9CB8-64150CD3A051@gmail.com>
References: <20260908185653.34702-1-ub4nal@mail.ru>
Cc: git@vger.kernel.org, ub4nal@mail.ru
In-Reply-To: <20260908185653.34702-1-ub4nal@mail.ru>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
X-Mailer: iPhone Mail (23D8133)


> Le 8 sept. 2026 =C3=A0 10:43, Vsevolod Myalitsin <ub4nal@mail.ru> a =C3=A9=
crit :
>=20
> =EF=BB=BF
> I considered using an "is_global(key)" helper, but I think adding a field t=
o "advice_setting" is cleaner.
>=20
> The change is quite small:
>=20
> struct advice_setting {
>     const char *key;
> +    int global_hint;
>     enum advice_level level;
> };
>=20
> Then the scope is specified directly for the relevant advice:
>=20
>    -[ADVICE_DEFAULT_BRANCH_NAME] =3D { "defaultBranchName" },
>    +[ADVICE_DEFAULT_BRANCH_NAME] =3D { "defaultBranchName", 1 },
>=20
> And used when building the hint:
>=20
>     static void vadvise(const char *advice, int display_instructions,
>    -                    const char *key, va_list params)
>    +                    const char *key, int global, va_list params)
>     {
>         ...
>=20
>         if (display_instructions)
>    -        strbuf_addf(&buf, turn_off_instructions, key);
>    +        strbuf_addf(&buf, turn_off_instructions,
>    +                    global ? "--global" : "", key);
>     }
>=20
> This keeps the information about the intended config scope in "advice_sett=
ing", rather than making "vadvise()" depend on specific advice keys.

That also seems good to me. I think I prefer it.=20

PS it is normal here to bottom-post and quote at least the
relevant parts of the message to which you reply ;)=
