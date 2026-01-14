Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF9356A30
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425760; cv=none; b=DE5E+xtDa9n2zdkVt3tQYXV88lK/O5DBnyPNQeSwXFpQ9c5KwekDyTxYz5dNDY2Jx0rSmTy5tSA9iKRpL+p2Q9gMiPMSpq5PpSUb+vSbEyL0CReQ0bfwDHmvPstk10Cudj8bX+cMk+4fSVFUlLjo0aJcEzGk4vxw3vAVVPPDZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425760; c=relaxed/simple;
	bh=/NutRT4eI2PleEmzdudTO3wRr1+yG4ybMHzp/SpaYoQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=NPzyHA+uwEl31Dy6k+K63QBtwouKMwtXA5RY7pIM2rh8gplSwc0+6+8t4pdYiLpcT7Vzpi0HNt6i6tCb+ChLx3C3szCEbg60PT+2D6yVNrVcpMyjKHCSmwmbxuER08hUJzb6sIU5Kgq/63QNlqJs/Fm4tpwAsYjbQ4WKNTQr+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPsJBqZR; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPsJBqZR"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6420c0cf4abso157884d50.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2026 13:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768425759; x=1769030559; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NutRT4eI2PleEmzdudTO3wRr1+yG4ybMHzp/SpaYoQ=;
        b=SPsJBqZREhVitMFXV9RWvbbCyR24+gEQGmIY97dOmz5fboQ2DT6up9s9LSfxqU4M4O
         Gfh3GWRrf3//7idrmAI81CH5uFXHoitcKBAADp9nTqhZhINWEyS93jAjXAemv25dYMl6
         uflKtpDplHS5Js66wkwP/yxLb8lNTbSa5Q53owCiEjqPJ4kXfvvUSjm2uXIoUEj0MV7t
         NKBYSJAZxZsnUsAtMEb9rcA4Ub6rMdiNHI0/leTijkmsHCgwS7sX38CFoYcxGpwDztY8
         6YLSPrP/9EVq5YEWtpXi+imwbkIP61DgG7YXP8yEp+2ScFLxMXSGG8V7WvKr6z2rf3ak
         sNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768425759; x=1769030559;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/NutRT4eI2PleEmzdudTO3wRr1+yG4ybMHzp/SpaYoQ=;
        b=EZknu2MBDRD8k2Klmhoq64c4Fa6P0IQ9ob9xHoYhAnlLaLyrgjbZ86ReqjaSDUM2kV
         4jIkxurmNOHChBVWZODpU7kbUVJvt+ls4DKXWn6WKZqgCdE3iZepe0/57Amm/4SVbIC4
         xmG669BpX0MXO+cSUgIxdOu/u96fd+MId/5g4osoE6SeDrcF3zB6BJtIzmg0ufKivlSM
         gH07dTk9Ktqtzbnm1Y/9im2xWztwIb5zoqFBZjiGQc9B7MMdq4EmbnA5meLCGqwnxnRd
         ml9BZ08mGF5y7rCRXdVlkEsqaxgSSUrFj7naEKsPxDvnAwonhAeYTTUs7hDjEM8mnmd5
         WHag==
X-Forwarded-Encrypted: i=1; AJvYcCVRgxvS6XYtgDn5hDpJWdMw19a/FL7gOixynE71wKEx+a6lVWJoj5+t02YqU94NwaYAAlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhuYhqx9yDY7ugK5c79p/O/fkzGlciRkajPeqBANzNH/W6+ZyC
	9IH8H+CECrQbxYMvJHX8ctWGSMGlb23kdh9FNhvBUcp6u4+lmhO4y6GkG7XoPA==
X-Gm-Gg: AY/fxX4IeDmQv9qMjU7Mpopc5gV+diCy7Rc/uDCe3I8LTVOR6/n0z7GnQUg9NfhH0Ew
	38zfDbUPZD3bzhKfKlim6sZrHnr3TzzwwmpYRCAR20L3gy+QPk/vF4KLQ+FuKB/7Y9PU1ZWIOAS
	c+I2VtfniwTq9BpSswNjAcyBLaeaY6+TjSd4m4tuBhO4BZ1kbLotI7Mq9hDyM7ls+VrbrZOWLmQ
	fAvWN2u7RoSidMTJsCLzbmsMjUNlz5vsgLMlRGwEu/H/+uduqhczq0PyMwa0ysZyAJEw+gfCa6B
	AJnezt5jC9u+sK8M/eNlrDgBZuBu6QDkb+33C2tL4G7zJCkVrvu7kn9nycXbulB7HxyOm6E1lbk
	z7UwIg7XbBtjUpaavJBTmPbEoa8/woT1mn28OldA3QxRGTEfXVIl2INxmmskGCfh7tg15GCTXiv
	RSx1odOBufF25jnMguU1N/A97DSpiOVr9hTvTHFB5jqpeSmH5ifKYcEB0XOLTsJYrGJfhdcWlty
	rDAbIEULCTAQW0mHTWMgbuGjV+/
X-Received: by 2002:a53:d00a:0:b0:641:f5bc:695f with SMTP id 956f58d0204a3-64903b5179emr2459766d50.75.1768425758466;
        Wed, 14 Jan 2026 13:22:38 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:18f6:dd0a:cf21:e611])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6d93d1sm95188787b3.49.2026.01.14.13.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 13:22:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Fetch missing submodule objects from default remote
Date: Wed, 14 Jan 2026 16:22:27 -0500
Message-Id: <C3B42E7B-C98B-4A01-B4E4-C5106CD09C37@gmail.com>
References: <xmqqms2ggu8p.fsf@gitster.g>
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Jacob Keller <jacob.keller@gmail.com>
In-Reply-To: <xmqqms2ggu8p.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


>=20
> Le 14 janv. 2026 =C3=A0 09:10, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble@gmail.com> writes:
>=20
>> Thanks. That should be sufficient for Junio to correct it when
>> applying, ...
>=20
> I'd prefer not to see such recommendation to use the maintainer as a
> janitor, though, as the number of contributors well outweigh the
> number of maintainer(s).

Certainly. Thanks.=20=
