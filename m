Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7889428312F
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648877; cv=none; b=NESeQKomMoZCszKc7PdiSaTo1PZyNik4mOWb2ZR1sb7YIMwzsGEn6NBoldHdBNdJS8jLwGIcrSvou3+E4YRkNalbh6mAwxe8hnVW7Id8uX+gYeB2jT2600Pkv3WNYBfRjEzEsf6ZSFj5KCu8NXfD/lNkTewxcCWNh55Jc1Swv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648877; c=relaxed/simple;
	bh=C10vwTPQbnppePhvc0fSj3iakDES+LXPjo9M4nFie7Y=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=TzpU3SLCUPgq2UZfFl7bW6DFZa3GFWpzvV49V5TdjLBqRZdAlGVtE+L/4+aB1uYivnxYCfUnWW2g5H5JOQZ/aHH0iluYg47TsqeuBoVB4EwCLiBnKQEv3dv3xt4H5Dr/mHJBCkGSoHpCkVwkPz3J+GlucnsQ+0lo1sF4NLf3YCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOlzh7bV; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOlzh7bV"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649e456e8a2so4345810d50.0
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770648876; x=1771253676; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C10vwTPQbnppePhvc0fSj3iakDES+LXPjo9M4nFie7Y=;
        b=JOlzh7bV3zLyjQTC5NeiQhBnqbu4sTCL32nypaJP80YmjwRbLtTn9mQI1DsqDollym
         4PvnXw9oMgeVRQRQrE9r54WBmWlaM2nyRE/50a+U1me3hjNu4V61VGBZeDtgiz8tdvOq
         XdJ21VENHcZdkQTMkLZlBBTcxcVXB0kOIzELt5xRUUrXvuxepxvv2/65JGEbhm1w3QnV
         wsGHktTsoj4hj4U0YogWUaGT9E6ZK9Ex/qJUeEeWCgm5zcSp12yjSUtBKDChvs1zx1NF
         l21pJLuHucHsthQPssH+DkMYCbmxJi6Iir4wc2q45sHvGnUSLNMeX4Es7TM9Ifodnskm
         /jNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770648876; x=1771253676;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C10vwTPQbnppePhvc0fSj3iakDES+LXPjo9M4nFie7Y=;
        b=FuiBWUgfTmBrpbD1oQsKvQlwNIv8dKMqbJJlk0ps3PqsYx0TJXcGBl9WxjhJkqvqna
         Py4WQWbEA0JfS+HjyqD0V/BkvHFPcIMYQMzr+kncR2gzD2sX6HPWFiAVu9N9NeMSOFmk
         KQfqzfAOTDS+zXSkB9kZVDuoNZXFkwel/52a2V4EVSkqyAzArCXZW9KBk2xTKo7+i1A+
         /bobGcKRmdNcWTXgJDOnOfKd19vpAgcdKAcOIbTaTGOaSS5Hjr8ZexrPOAAOqqwGFisK
         cXUw5Jt+ki6mAToDcVnCBCDJVZeoa0Wp3cS/D8MSpRHqhWtXD1jYAo5zwSOu0j1JRvsJ
         E77w==
X-Gm-Message-State: AOJu0YwSwegkhg4/m/NBUbNSgkHHtnV0p7Y/2IGPgKhoZq6LmwKcf3gt
	MIalKrYXAj2c0UNNEGEFLDLxDs8NACSdTnC50qfcR3aLvcsosMwOXECLKeiIWQ==
X-Gm-Gg: AZuq6aJcwtq/LeWVSWmxF1uCe03xJVp4ztZj4p5dh3e8s6e4UslbznvqFpLMld9v+NI
	r/SlXrnx44RDUZE+npv8FF+fNBpiroR8zjZgZRDfTLuwGLkgQPFc/ulpXxFPDShms8Uddts91no
	aszkAsYaNUgr9ccYo6h8uBDS7BwWnKttqEcK9vlvGyANm+y0emtyNTKQCfeQhIcTUSsXV2eZoYJ
	ywTMhSjkDbpRQAFCgrQgPyQ237r43fx7oxTnYv1BaFTlFIFZT/BxKqRSsh5xVxC/uvoZNpHFVSX
	qbWMqpCvKIbtGjUwz9EUE8X22RNI6XLA8Mxl1LcRXDqFEKsuEIgr1hhUTigMawYWiss3EbA3V8/
	XEgh/KSeRe4I+e9QZ6CPd2eCT9AUpJ/dClqm7ZazNxG8s+zmXHH87QS4n06hB60Vidx+zpjxGCo
	GjXTckKzCCzyFvIsJ7IE8friOP0C0ACI51pLDxV6BeTOLCUszm7gAodvnoaq6y96Gtd+DJXSEdj
	jPlOq16dyr4e7S8KDANfh9vMr48
X-Received: by 2002:a05:690c:498f:b0:796:3124:6565 with SMTP id 00721157ae682-796312469e8mr136943497b3.1.1770648876326;
        Mon, 09 Feb 2026 06:54:36 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:d598:9978:ccbb:b958])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7964239b728sm33566057b3.40.2026.02.09.06.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 06:54:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: git branch behavior after git init needs fixing
Date: Mon, 9 Feb 2026 09:54:25 -0500
Message-Id: <D1CA4E13-B279-4931-81EF-364169564612@gmail.com>
References: <DS0PR03MB72900848B03D2B87A6846DCAA365A@DS0PR03MB7290.namprd03.prod.outlook.com>
Cc: git@vger.kernel.org
In-Reply-To: <DS0PR03MB72900848B03D2B87A6846DCAA365A@DS0PR03MB7290.namprd03.prod.outlook.com>
To: Ryan Johnson <ryan.johnson.code@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 9 f=C3=A9vr. 2026 =C3=A0 04:43, Ryan Johnson <ryan.johnson.code@gmail.c=
om> a =C3=A9crit :
>=20
> =EF=BB=BFImmediately after running `git init`, Git's `git branch` output i=
s empty.
>=20
> This is problematic because this implies that there is no default branch. I=
 am told that there is a subtle distinction between an already-created branc=
h and a "promise" to create a branch upon git init. The "promise" of a branc=
h is not exposed, when it should be in the `git branch`command.

I believe this is called an =C2=AB unborn =C2=BB or =C2=AB orphan =C2=BB bra=
nch (see =C2=AB git help switch =C2=BB for example).

> Hiding the default branch name from git branch is inconsistent with the in=
formation reported by other commands like `git status` and clashes with the a=
vailability of branch operations. `git status` reports that the repository i=
s "On branch master".

[no comment from me]

> A typical user will need to rename their branch from master to main to con=
form with modern standards, so having no branch shown is confusing and quite=
 frankly wrong.

You are probably looking for init.defaultBranch and the 3.0 breaking changes=
 plan (which will make main the default).=
