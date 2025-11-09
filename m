Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6BC26299
	for <git@vger.kernel.org>; Sun,  9 Nov 2025 00:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762649352; cv=none; b=c+XX/TL2irtlebX1JYZS+Scrl32lOHPKB3rUeOiDD5pXpeW7/aiCVdeao41S2GKbtn51Gdnovi8bD30jpq4X9Ute2+fnhLR5Vrkade/MEvZ6Jd4ElWrZnAqEclZtTvnU0SnQanxhNe9Z7YoXarmvovPcTpo5BHitygC9AVHKl7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762649352; c=relaxed/simple;
	bh=jJC2CZhma0fUBLvlcGf8nfitQmhYMLrIZFPG0ETTkEo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=ocqxTNADN4TxyUpnID/SXqhROz2maWQ85i0FiKfXzHTzQuixGEvuYFD+lQOroC7ilyAZ7yU1r72stVQHxjcvSohRJ967TEwvKiqqfWPq20CNAlqix/IyXvpRPH/TqcUGfnb1P4P43kinzeEPo5z+CerKrY/lBswapeJaTfvuTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK19Rtbf; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK19Rtbf"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63f97ab5cfcso1489252d50.0
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 16:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762649349; x=1763254149; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkyb2GX74bZxb66JUGBY14/rdPh30OnBjNOMy4HRW9Y=;
        b=lK19Rtbfrz1Mlph2tvAuLdUVfhSt6aYnJR60GtSkgnUC2wrV8E30Rv7WXHBY7oSrrr
         ntrvnWggS6qb2/2bDU9V1u2ijQVEnYdh27DzXHJD01jBp1sikt+16RkpHcnSbl8Mlbs+
         oLmRJvnlGJeZ7gQn1oBiZcoEg1dqTUT5kCBIexDensXX4nEOg6e/eZaL9qbiwZB2mEy7
         LozOOu6iAc/pC710/vsM88a4gOMhXu7017O9AHNyXPaZ/YvUqzv9JaEfw9cTuDu7QCjz
         eybOBQ5wiylaHu18piqOUASXJ7J5TGt3KDxThrljc1UCFi+gbGi2BU+Odt+BJEGTF4qw
         Pedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762649349; x=1763254149;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mkyb2GX74bZxb66JUGBY14/rdPh30OnBjNOMy4HRW9Y=;
        b=f4VodwKi9wd6BHWqISMBA2UA6w4zcPi/qHZqQc0MW05mToKvHZ1OAzJ5kIK8PBObgJ
         4bJrZW+VUVI8nPJY9nbwRuqLG+a1e0d6boOHqAUI4fHNQRztxa6rl6aNQmR3orDNBN7f
         IaBgfe2dNxuHaNCb7HAYYKk9iyU7TOPzsAbVXLYebEhgArstnhp0K+8FHXUfPjwrDhVu
         FM/C3ngE+ztj2V35TAc1Az1n+sQIQb7YpQ0UX5HE04yemsGhhnDgISs/oEs0qwQt+H8U
         mxlalkk/uQPxrbznDiYRmpfvPAl5uU46wxsAc/1ez1S/vvofrUqmkGHDPoGjgp1jdott
         EfBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx5PyHIXDLWG/IJ7NsBeUEo3wVYeQAiMJh2567rJ6kD5dXIwb73RlWgj3b3jPUIpPK6QY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wUub4FmFScRoRAaKY8CMbU4t0vs41P37vLKHkpYA01C1lZ9s
	qQnvjArh2Vw6Svu5vxsyBG9VlIwATw+nQ2eGJ0sj4NfW8Eby82n8V9fX
X-Gm-Gg: ASbGncuBfeWR1f/DgPZu+CBxdyk/YSbaiaxdqF/EB4xsll8S8qSrLLj3mAYdfnHKkpq
	+EynaXBhjfveYF6heHoYWj0lIYGQeZfgeghmis7lSZv3P+9fe7ZlZdNQGLaYLNvLmseabifaD1z
	H3bIfb2T3DpIApFdpgsKF2W9dHMv9ZZ+ebUDtTgg8kGBkIAePgRct3z2f0EQ+UTvqtJErTrKzvO
	OmYQAiSKOlgk3JeMHVDOhimj4OGt10suecpYlET1ahAqXJL+e/9jADkj6zG4X9PCe3yyU0JaykT
	RZI7FUp02BQOKgKQ7nmthZOM7ZNtmJTU8EqT1gs8TlLwLrdQ4iFghaAbpXPLOB+3ZkhSBrgrMnT
	7sp0b+E4tUCG+ATFr73q6clm/byfGX6JvzX2VL2YqHoQfRJv3ZLEwWHf07tR+4HnLVOOkonUbuq
	IW8hdhpKtelH4Yw+nw09BDWYQSp6s1EZefnmbXqt9E4kEw
X-Google-Smtp-Source: AGHT+IHtSiStNFCbux7uuzulniOYdDrrDU7llklp5byhjvirML3QFOUILxkZjfJ1tEOqMln60odayw==
X-Received: by 2002:a05:690e:1597:20b0:63e:1e80:99cb with SMTP id 956f58d0204a3-640d459d704mr2812506d50.34.1762649348674;
        Sat, 08 Nov 2025 16:49:08 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:c06e:706d:49b2:da56])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787d6808a58sm10531727b3.1.2025.11.08.16.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Nov 2025 16:49:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <xmqqo6pde90w.fsf@gitster.g>
Cc: Julia Evans <julia@jvns.ca>, Julia Evans <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>
Date: Sat, 8 Nov 2025 19:48:56 -0500
Message-Id: <D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com>
References: <xmqqo6pde90w.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 7 nov. 2025 =C3=A0 18:08, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BF"Julia Evans" <julia@jvns.ca> writes:
>=20
>> ... I do not understand in what way this rephrasing helps the
>> reader, or how you think the current phrasing might cause confusion for t=
he
>> reader.
>=20
> A branch (or any ref) does *not* *REFERENCE* an ID.  They refer to
> objects by *recording* an ID.  The distinction is not clear with
> your wording.

I concur with your later email that this is not worth delaying the rest of t=
he document for.

My only other opinion on the matter is: what does making this distinction cl=
ear do to benefit readers of this document? I cannot come up with one, and I=
 suspect Julia cannot either.=20

Clearly you feel strongly about it, though, given the shouty caps and =E2=80=
=9CI have no more words=E2=80=9D phrasing, which I find convey a tone that i=
s=E2=80=A6 less than welcoming. Perhaps it=E2=80=99s simply time to move on?=
 And someone motivated can propose improvements. =20=
