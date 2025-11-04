Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEBE322537
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762274883; cv=none; b=U91jsyC4MIXUc0ZWjre+eCNt/Np1JwgKLXewfexlVyGiOpoM63OtdcQaAizMwBv2rqAvqS3pUtqqdkbbH3gce6O8g8INsJ3CLcRUn6pFIFHxplwArvO92AFFstuVA4Yv5WjuEhr5EQx265QMVTIV4/ieJMRolijKJL8D20zevTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762274883; c=relaxed/simple;
	bh=InPvMZJXVdFC7PwfYleX9gik7jGys3IpMf3zhJ//hzk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=ZhfaDYXBQWQFFDsccVDv9rN9ju3PmufZyOcdc6DGW5SndfzRDOdjTveQ61Qq2MYq4h7MKeramgk4pm78WbQEwCHM5cTtAaTHD9Gr0LLi9B/efUa3xePqSkS9TKYPJsLILmTKIy1l/SECqBhkucrKI1JAvwWradr4SkWq7PFz2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy2gQfpm; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy2gQfpm"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63f9beb2730so3413558d50.0
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 08:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762274881; x=1762879681; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8RjZLWoHithqbST7WvFz3QYZ6BN+dmKH3g07FqJYBks=;
        b=Jy2gQfpme51qxjUuHBS8mBadCoUrVoZdKBRlnQAhcOOIo/Ypla3vRf8Bb91LsiIolT
         nKWPMU/IFhfzCZgS0OWZhKdjhIZPdW85WJNeM43FJRekIPiebpD5QrXIXWU5yj51xDjA
         VxUV9Ij9Y8j19RYVyrDLY1u6sXI+fC+yWxgP326jKA1XxDDqDvjtMU5WqXjiLRVf2K4z
         6ywht0bJKMvnnpuWCXVdoj9+4x/VvzahxqgQbrdSEsN/vYo0ZMRSxgk5A8OfHO9+DJsn
         irwA5JL6Xrs87ypXcQZZ5VynEyfZJYmfp+KY2PRw91gMSXs1qOJuJ0ia+TReDc0IWCon
         wmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762274881; x=1762879681;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RjZLWoHithqbST7WvFz3QYZ6BN+dmKH3g07FqJYBks=;
        b=Ck6C3w9sj22FuLzSN0LGv/L+9LsWT0/gOtWUnR/BAporrlVZ+M+h7pnx9RDADQneeD
         CwjQB6dcmjksGs6WXmxsUiZimV/1BHp4SMZ1BN3J6QR3p15CdW+Bp9YUKs6FY5a1uzh5
         LwBwPKB3f2KvXwAowNMHO3Sh7M5ImqGPKIb4O1of/xEsaPd7qHltJsXNKpzcYebW90tL
         IaoN8AmWKcI1D8igOPtSHBbTSDA4sPU+FDJ+iS8eaB9vf2IAL2cJxv8u/VLTeP40TtPF
         MAmkjqfb7+BFKf2Tzy435fNJ9ZamGfVVrugxBVNMId613AJ7xxvmsT32GcDq6ic9uugN
         +2Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWfE+rYZ9HIeOv7UPh+XqKy59b/dpNs5E7h6Y9zCBqGXcvTm62XgNo7muRHxrXR0totVjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHYHQl6dJopRyxTdqsh6FVK2JT6ppB+X6vn0rsexs7VPHKl1CV
	TyHTnvIOeU0+7/KKGmb8XJpvtqx7rh2QzdaAPxB5uTdp310u1mRh2Qrf
X-Gm-Gg: ASbGnctAu5LYo2rj2lbSPv/ON/kt8lmiwxP4RqMP5PtyFenRqTU7gjT/jop/JSUSFM5
	vkKMnL+fb4i6k0Vct1JZiv38kD1gHm56EJhuiEQ88kdDW7THrmuPTPq2Zl3zhJM7bDwBfRBZxz/
	oyp0MtUz+hZKD7q8+/1jg02sfm87jAf7DzUQqmkNaCycYvPgKn+GIegUkiVzWACVwOYcstIt/pi
	xTeZ4OcrOQFUjwB+lUZVyJsRTVvQXDLwAqYAYICqPXMAjtzYmzkSCs6X4ksBORCcPn2F7HhdIIR
	hvCQ1OwwyMAZnt8ehbR54gnJvXIC9B3HcpemI9PR9LveTseIe1FhbgJlaR//n73TA/VIV5T1aNO
	tmyT9rY97pcdd9z+RNVFmOCZskKu/yOWpEflYAExES7UN4wYc/jaaEP60/kDpnYepcyW8sbRNpq
	F2LXCHQ9ZioQebHeARdWM+Xw4QahvI
X-Google-Smtp-Source: AGHT+IHgWLlxmdfhX0+eMaSsgrDI+yNfW1cIqumpbpyAg0DWVvbUCr5h6Cz81/GaeV6c4OMhHRZX2g==
X-Received: by 2002:a05:690e:4258:b0:63f:ba88:e8f7 with SMTP id 956f58d0204a3-63fd34cf84amr95308d50.27.1762274881125;
        Tue, 04 Nov 2025 08:48:01 -0800 (PST)
Received: from smtpclient.apple ([2600:1005:b003:f0e5:b1c3:2fb7:5212:36a5])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63fc95de673sm865827d50.23.2025.11.04.08.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 08:48:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] meson: make GIT_HTML_PATH configurable
Date: Tue, 4 Nov 2025 11:47:49 -0500
Message-Id: <0423F0C4-D0AD-471D-9315-FB208A8171B4@gmail.com>
References: <xmqqms51rhbx.fsf@gitster.g>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Todd Zullinger <tmz@pobox.com>
In-Reply-To: <xmqqms51rhbx.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)



> Le 4 nov. 2025 =C3=A0 09:41, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BF"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>=20
>> Makefile-based builds can configure Git's internal HTML_PATH by defining
>> htmldir, which is useful for packagers that put documentation in
>> different locations. Gentoo, for example, uses version-suffixed
>> directories like ${prefix}/share/doc/git-2.51 and puts the HTML
>> documentation in an 'html' subdirectory of the same.
>>=20
>> Propagate the same configuration knob to Meson-based builds so that
>> "git --html-path" on such systems can be configured to output the
>> correct directory.
>>=20
>> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>> ---
>=20
> Makes sense (a more meson-minded person needs to double check my
> knee-jerk reaction, though).  It is surprising that
>=20
>    $ git grep "dir', " meson_options.txt
>    meson_options.txt:option('perllibdir', type: 'string', value: '',
>=20
> has only a single hit (now two), though.  I thought we have a lot
> more flexibility in our build process.

I learned just enough Meson to write this; many of the other =E2=80=9Cdir=E2=
=80=9D options are builtin for it. Try =E2=80=9Cmeson configure=E2=80=9D

>=20
> I am also a bit surprised that these things are of type 'string'; I
> somehow was expecting that more modern build system would offer
> richer (relative to Makefile, that is) types like 'filename' or
> 'path'.

Yea. At least there is a / operator to concatenate paths, but it looks like t=
hey are just strings on either side. =20

>=20
>> I've tested this with a modified live Gentoo ebuild [1] and had good resu=
lts.
>=20
> Thanks.  Will queue and wait for others to chime in.

Looking forward to it.=20
