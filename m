Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D392236437
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 20:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772396490; cv=none; b=DxzByjC1pDU8Ztv0lYgewZ1GGB1JD8EUT2hdWBh+Aa9BvNwHV7VL3zK4ZQnQm7zgsI/Oe2mtwq2p2/IjKcy57tNJTvnZHFs4xbgLd6HfWEvWuUjIs44KuRZur62Xm/NIVguWzvKA3iaNYQ8H5dXi8gOlD4xAOeYHv5lYYXfrlVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772396490; c=relaxed/simple;
	bh=JiDhXZ/xpWPRvT+zAVkiKt7lZN0n0P99UU8FUerBbGI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ela/M0PJNbSmAaLEjzR5yVpHtgqhne6DJvmIttLCfrb46ZP0pa5D6wSFrmtNxcSp/4HtS8UddeoHiC/3t72R4JnQfUL3jPOBLUgkvVYeXD4VOZrlzz3AWQjboZClV+SKYX2X8Xki+GAkDdkjcXAKx81OBG7O1omu1KlCb6C4AQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGIil5FQ; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGIil5FQ"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5fdef6330bfso2874271137.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 12:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772396488; x=1773001288; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiDhXZ/xpWPRvT+zAVkiKt7lZN0n0P99UU8FUerBbGI=;
        b=MGIil5FQRvp9jiJ+FP2R/CBkXyUb1CN0fpsApWyQ9wWXGNdOTUN09fU4MySb5r4pgL
         Pu/Y0btJmpPtZ5cTxmCmPNbxiYDBqXBUGPV5x0knXlbdR+qP/mG9pnLs5P4DOv3nGBHZ
         z9K14Ij8tz6Dtfisd0natP67dBL7ZAzAPLaKNcHtY99w4Ly15mKfuWHfPtjU8iBzYj13
         2uub13AcBmxpHnBGYUo0Ymjz+vppbperJYpBvDqL6DlusxxsRvnIRGdbQA1uhKSWupTl
         rtZT8hrx1hRHgSn9Twt/TXf9LDMmtd3DkAldtQP29mxQg4wM/X1Y4E+MJeR15VzwhsPV
         2yTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772396488; x=1773001288;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JiDhXZ/xpWPRvT+zAVkiKt7lZN0n0P99UU8FUerBbGI=;
        b=I9pFD09c1GCXiFRPgfAnKvaw4NrzMOKyyifVp7tTLk2kbZqayEK7XeJsUo3J0rXStm
         MeFxtZ28FEJUHL7WJMP78xiP2grZqnpIHvkDqwppPNbZgyVn/LA0oQZsaMPDJyufgsLq
         HE/Llearsglrj/vS5yid+mnxhqZHFua2n5ZOGEr+ics/N6I3WKyqvtGIUVZ4YRZZSyz4
         eAzfzWsgO7/zZCzNeBUTtpR2pUjjWEsdwxqisK1HgXCBz13xxRL4N3u576/3HFKc7piI
         XyBASxK3sEUc9EKGAp6O9dl4LOJDzCIToB4dh0U8R7UHXooOKHRYVzJxKKgJAYIH6RBl
         xVkw==
X-Gm-Message-State: AOJu0YybTc2fUWAvQjMzzRBVob20u4IzOSFx05lnYmLPyxYyRtoECrYs
	zUWJNowXPZUwolDz6K6kF6qdtgEmF4kHHlWTRDFneLwklDoB4rusi97C
X-Gm-Gg: ATEYQzyd6xKl+yopz90D20VaCL9UT3e8KfsONFQyVfr+0XR46ZTVWnctZBtUpscYVso
	0FsvvhyjdKd4UXaAra/N/mcHN6Z7f2W0xKrW+8P+stVCllutgC3GF4P2c8fMCKMpCrDkJZftQNq
	eF3fUQILdYYidP/mFwF6HRaGWgr/PWxwGsBqCtAnKLl4J4SQaBkhGW+MFLvh7mbn/mWcngn6q+4
	zI9+hOkLqT8HGrORKIYtM+4mcW56eTVSRlDXODFikfUQt5p1wZ5OYLKt6A2pBi33zW23rYbHs/o
	T4nK8L29hNsBKLaR+j4ehz4ZqQTA37f5JCRvnnCnCwXW2JufqX9wmIycThUG8lblVrwTCuWtZis
	eTiIHh1LPZtKy3NYaHiw8sKQFN8TPv5j7qGqAwcBt62JCNXxTm9ZbtmOlSnMl/WVQiahfICaAE3
	/6YiKukJzQRVRo9ljOXesbUvISB/5Aw64tUWcYMUEQaDtHSjFgghBKFF65PPZy
X-Received: by 2002:a05:6102:cd0:b0:5db:23d0:65e7 with SMTP id ada2fe7eead31-5ff324f1f37mr5661505137.27.1772396488533;
        Sun, 01 Mar 2026 12:21:28 -0800 (PST)
Received: from smtpclient.apple ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df65a2a0esm9803322241.12.2026.03.01.12.21.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Mar 2026 12:21:28 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 4/4] repo: add the field path.toplevel
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <71e42a01-6077-48fc-876e-555431d1288f@gmail.com>
Date: Sun, 1 Mar 2026 17:21:13 -0300
Cc: git@vger.kernel.org,
 sandals@crustytoothpaste.net,
 kumarayushjha123@gmail.com,
 jayatheerthkulkarni2005@gmail.com,
 valusoutrik@gmail.com,
 pushkarkumarsingh1970@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9789E676-4DE0-4C4C-BCAC-5BD880A51CE1@gmail.com>
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <20260228224252.72788-5-lucasseikioshiro@gmail.com>
 <71e42a01-6077-48fc-876e-555431d1288f@gmail.com>
To: Tian Yuchen <a3205153416@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)


> Hi Lucas,

Hi, Tian!

> > +void strbuf_add_path(struct strbuf *sb, const char *path, const =
char > *prefix, enum path_format_type format, enum path_default_type =
def)
>=20
> Isn't it a bit inappropriate for a generic character concatenation
> function to know about format and def? I don't think this should be
> the responsibility of a low-level function, at least not
> str_buf_add_path().

I don't think it can be considered a low-level function, but I
agree that its name can be misleading.

> > + prefix =3D cwd =3D xgetcwd()
>=20
> Will there be a performance regression? Since xgetcwd() here is a
> system call, right?

In this case, no, it is defined in wrapper.h.

> I don't think we should add the two new parameters to all get_
> functions here. As changed in your patch, functions like
> get_object_format don't really, need to know about prefix or format,
> so the corresponding parameters are marked as UNUSED. Imagine if
> more and more data needs to be retrieved by these get_ series
> functions in the future =E2=80=94 is it really advisable to add =
unnecessary
> parameters to all remaining functions just for the sake of a few?

In this case, we need to add them to match the signature of
get_value_fn. Those values will be useful for all the path.*, but
if we start to add more than that I agree that we'll need to think
in a better solution.

> I'm not entirely sure about the above content either; I'm just
> throwing out ideas to spark discussion. (=C2=B4=EF=BD=9E`)

Thanks, it's also good to see more points of view. I'm also not
sure about it :-)
