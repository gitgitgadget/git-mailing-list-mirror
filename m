Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03BA15853B
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 03:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762312897; cv=none; b=gZXEZvbwbGxq8ySeI1k336o2AtoaK1Wk62dHT5Nr1cE9YN4ObzRLkWJzKiZZhCk6+tj/QEr1ifFUbpuukyGRUwqoPsguvi7gJ7yZ77vi3yWWNKH4Fl8rThGNjWh+YQavz+OLZ7XMVX/QgjwQkNjnQglzJlUGpwwzFUwf0GaEFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762312897; c=relaxed/simple;
	bh=fwAw950mJlr7EcYxf3+sW3va/BBf6Qqv05IjdPQ7CFc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=bRhZRV4eiD8+kdUb3F3+/sgucCFgs/LLGg4wM9X4ADRTQDLmzevttRTpwCD9fJLlV0SXaSE24RyF/cV1Dxx5hb3KIsBRjciA/ZUbx5iceWuolejSTdNSjkt8ywFWxbDOXff84xZEtgyaejRr3/fOT0MYgll80UtBgc+OUIBizas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsfIwnCs; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsfIwnCs"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-786a85a68c6so1956637b3.3
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 19:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762312894; x=1762917694; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbxSoMI8vPuKqtmQRdm5h1VbBFJrgdqwxzFnffMEcas=;
        b=SsfIwnCsdQxIJ6nYyTh5Ne1mYSLeSVzQEHBkVqWqPROclipBOc2V3va3brcSkfkn3p
         KMDk23lxjo04MC1k5TK8ZBTnxpCiG74xnNfyYz0sk2RS0rWExvIS4kA9cSjAah+pSgFi
         tOrXqmAFvweAPpM3dMFtfbPRSJCvZSBps2Uss3fmgLmBtKuFwcRt5vUZRF7OUNAYVrUv
         uyKREthKeINmCzP/iRhemyj7/wqposfZzQ9PkKArpWQvtelXYjihgJft0GpRXcD0Ofq4
         vnh5sEq+b0o+zEKC7Ftrmy4IrIxU9y6i3xuI3YNJiZTt1UIhRDw1xOP5RCb0t1byUOFV
         DSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762312894; x=1762917694;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SbxSoMI8vPuKqtmQRdm5h1VbBFJrgdqwxzFnffMEcas=;
        b=WD82uYeIpxOwqO4P4NjClJAisQ5yC8F5EtueKaBw3X+sXJqzcgc/wWvzQKi8N/aRiT
         EU6zZmJFwPlTNtHlljpA8TQy8XIOdAC/WiMo4gu0UCksC8ELvPztsRa+ETJ64NDft7FH
         J3yyEqNxRmGROqv7l6oj//FSiTVHHSMZbWXuWztYWYFyeHK3yS7SoZvWOmlaeCdyHzJj
         SmWYAS4CcjbIdgaHUrBJ5ZYr3I+E0dkqy5MK57I/IKqF28+WHhN9wb4N0oWhHRLqzjF2
         BHp7iEkIjAKO9uztIZ6a5XDFgBnUVrkiqeRH/wNrcb45SFT3jno+DTXchu63xwvnTTsN
         TRXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEUzuMsf7i/hHf5/t+fIT1pHZpSrp4gEqf2B8IJU0S5yPji4WRyYD0PiBg75J5lECvzls=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRJc4PAnP0qBLKhHyvm9IM9z2MS+JDCR5JD49aBAnXYcZFEvh
	AyYEi/ADSLi8bYMTJXeTnkeJgHiu1jUUrTgRJjCPrNiWWwTS7krBZFEr
X-Gm-Gg: ASbGnct7u+jkKwNDIVIwTjLiGYKAHhooakWbLWsku+EW3VTFQWkSkik1PYVmJGVQ0qZ
	rIChyRj9t87gqKSzbobGWLJjqXIR6IZ8U72psMRJWj4+zZn2DEXhQX1D2bVCYToqIlRXcMcEI0j
	WVF/CInT2AqGlX2nkKaDpHxFS3ocevAl4pYPPHCIAGdaEyO/9mqgWMH3nJkg1R0fn5lYseGVa9X
	5Z6AgSNBSPqjy4oTb8gseC3L7k8ip08l0szBtZTBK3I2ZI6DvTRrA1bCBcad7GQvaUeyM3iRBVf
	RUOEi4WY1p+bnPZZMvHQoH8BV32IUq25yt189iV314FQnwtwhjC/RP0cFYuFMXjENPlP0eQHsA7
	oCGNs4oQB44Q0jsQ2cRYonDsIffRzzjsgMAF8IZVntMBo3DuaR4bl32pQEShU+0UOM9JZEkz3wP
	cDoklOzHD9p1jVe+n/GNS7hpp6qEmd
X-Google-Smtp-Source: AGHT+IGX+NbRJCb/2zrx/9Mb3NBY8juNU4rJxXLq21EPIDhuNmwIXjAFz+J2uSgYSpvR0CWSVQM2lQ==
X-Received: by 2002:a05:690c:498d:b0:786:314f:849a with SMTP id 00721157ae682-786a410ba8amr17864927b3.17.1762312894179;
        Tue, 04 Nov 2025 19:21:34 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:eccb:aea8:c690:2cd8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78692035fc0sm15716127b3.60.2025.11.04.19.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 19:21:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5] doc: add an explanation of Git's data model
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <c268c98d-0a8d-48fe-99dd-b4a2fdcd0fb9@app.fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>
Date: Tue, 4 Nov 2025 22:21:23 -0500
Message-Id: <7E8706EF-6C15-43AD-A847-5C896D9235AA@gmail.com>
References: <c268c98d-0a8d-48fe-99dd-b4a2fdcd0fb9@app.fastmail.com>
To: Julia Evans <julia@jvns.ca>
X-Mailer: iPhone Mail (21F90)


> Le 4 nov. 2025 =C3=A0 19:02, Julia Evans <julia@jvns.ca> a =C3=A9crit :
>=20
> =EF=BB=BF
>=20
>> On Tue, Nov 4, 2025, at 6:45 PM, Junio C Hamano wrote:
>> "Julia Evans" <julia@jvns.ca> writes:
>>> I do not see the point of implying that the commit ID is not "special", o=
r that
>>> it's only one of many ways to find a commit because to me it seems very s=
pecial,
>>> since there is no way I know of to retrieve a commit that doesn't ultima=
tely
>>> end up using the commit ID at some point. (though that ID might not be e=
ncoded
>>> in hexadecimal)
>> That is not what I am trying to say.  The hexadecimal name is the
>> most neutral way to refer to a commit object, and in that sense it
>> is special.  It is the way ref subsystem uses to record the name of
>> objects, and that makes it special enough.
>> But that does not mean that the name _is_ the object.  The
>> hexadecimal name is a way you use to name the object, but is not the
>> object itself, and the special-ness of that name does not change it.
>=20
> Okay. I still do not understand at all why this is so important to you
> (for the reasons I mentioned before) but I'll see if there's anything I ca=
n do.

Perhaps one way to look at is, what diagram would I draw given different tex=
tual explanations?

The diagram we _want_ folks to draw (?) is the one where a branch points at a=
 commit [a circle, perhaps], which points to a tree [triangle] and recursive=
ly blobs [squares], like I=E2=80=99ve seen Stolee draw for GitHub blogs.

We might also want folks to label the arrows with names, or not.

One way to interpret the =E2=80=9Cbranch refers to a commit ID=E2=80=9D migh=
t be to draw a diagram where the branch points to an ID label, and to find t=
he circle you have to separately consult a different part of the diagram.

Both seem useful to me, though as the former has fewer moving pieces might b=
e better for the model this document describes? I dunno.=20=
