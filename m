Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00823FBA5
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298981; cv=none; b=gHLWxuEhGGxZz013CVgg9Lbx7dXpm+9F7hr/ji6IQkXnQLmLiELGJmMVQHot4O72p9lwFzmiZg47InxFSHk03s5999+6F8NGl6BeJgo8kt7puYu8YXRCMmbPGiOBIESYr7nB6s5RnKGJWqWVQ5KJ0QPSe0Oi9Mm23RzTgS9iqXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298981; c=relaxed/simple;
	bh=h5n6+mwAJsuUMnRLIsGQEnbYtaNGHZpYVWwz3+GHkPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gkLVoeiuO6hzfbpRlAfjhV6T6wOt8+SFri2BpNvZW1hsZo63/h/sd39As/xoufY+a7stUWoFZzbA0uyIMJ3sqPU8jYGunINWiobsPFWu2J5oDt+cI+4tHYdqaSStWNM/0hm8Zy4N5cuUriAtrhHi/gJjE1eEKBIBeKJahHTl8JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2qQnQul; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2qQnQul"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so37490485e9.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728298978; x=1728903778; darn=vger.kernel.org;
        h=mime-version:user-agent:disposition-notification-to:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h5n6+mwAJsuUMnRLIsGQEnbYtaNGHZpYVWwz3+GHkPM=;
        b=M2qQnQulG0expnRfr6qrpN9bARoOQsE6Xd2sQ1Xzg+nIfcbBdA6LpSRTrqHPVAkyQo
         C0DbecIMdEbnVcbQ9GYHBEm2kI21su18LaiNBF/AsHnPYfD1Sv+e9Qx+gQ+ZMFjL/HB6
         6gkAP7GDGfipDlEtG16gfWBWgB+EVE12nIpQiLJMLqzQLxUThiqTXustsNpjP+eHyPIJ
         SAeZexXQNvkSxGLajh07EWkpLvqDQO6nvdJ7sBhfiHGcsiu6yyOptziDQrnRYxUpAjL4
         v2H0zdboUpyh5b7ssZkFRRmPgi86uQRpP8m2S7I2MTZ9eII5jLHHSchk5/vYrus1EF4F
         t/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728298978; x=1728903778;
        h=mime-version:user-agent:disposition-notification-to:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h5n6+mwAJsuUMnRLIsGQEnbYtaNGHZpYVWwz3+GHkPM=;
        b=lyhrstldFQQhq4Q3Rw+G5nYTh9kr4tk9BG6xPAPG22iqZAATOX0QrmeSNz7izDrLMR
         tnyMuy71XzO8gMQmYL6paEFYnNkdDDvCrptrqdYALsHre/UAWwznRb/Ssy3UQsO2IXJj
         l5jNk6r+70m4vOFBTSeSx1O0FLGw+wPR1U93t/hxAT5gIcWhW6fiJhCPMBrC4K5oGZ2i
         aUzmjasVuIRqDZp+W6xn/Sowr2/uEKmJVBuZTHf8Og+WgI4s/vyZCnZCanrA5Cxtus0a
         TkoEWCi9YgIE8j5+GHi5wy/Y71igzxgph2EjJSWMYYDBahT3vi2InBsf4QxctnMRJlXd
         6E0g==
X-Gm-Message-State: AOJu0Ywgk6WWYYoKYDtdGYyho1K6vyquvhQFte2mNWywQS8T0ApKvEdM
	TGxAvSlZMZm1JDinG8qY4qA2XYcqkQ5cqul718QEqkpk8k6WCb4=
X-Google-Smtp-Source: AGHT+IHsqS5HXz8+ox163PEeh+2vXR7rdig/PnWb255arwPdre6nY3AOiHPx6gOjIBNTC/mHNBIE6A==
X-Received: by 2002:a05:600c:548a:b0:425:7bbf:fd07 with SMTP id 5b1f17b1804b1-42f85aa3c1dmr89248195e9.5.1728298977708;
        Mon, 07 Oct 2024 04:02:57 -0700 (PDT)
Received: from ?IPv6:2001:8e0:3bcd:3801:111f:310d:9548:6f88? (2001-8e0-3bcd-3801-111f-310d-9548-6f88.bbcs.ip6.as8758.net. [2001:8e0:3bcd:3801:111f:310d:9548:6f88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ec6202sm71539505e9.35.2024.10.07.04.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:02:57 -0700 (PDT)
Message-ID: <a8807b44026458097267932f429ef61d5b77aa4c.camel@gmail.com>
Subject: Re: Bug: `git init` with hook `reference-transaction` running `git
 rev-parse --git-dir` fails
From: Gabriel =?ISO-8859-1?Q?N=FCtzi?= <gnuetzi@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 07 Oct 2024 13:02:56 +0200
In-Reply-To: <ZwO-j0C59vuYsEnt@pks.im>
References: <0084cc18b6d90ba14849a7f788939f4a1d0d61c9.camel@gmail.com>
	 <ZwOVy4FltrEjxHn_@pks.im>
	 <867f42bea10de470532d2f30eacceafa2b03d8de.camel@gmail.com>
	 <ZwO-j0C59vuYsEnt@pks.im>
Autocrypt: addr=gnuetzi@gmail.com; prefer-encrypt=mutual;
 keydata=mDMEZkXiuBYJKwYBBAHaRw8BAQdAGuoC79ZXUA/zkkAgeLEElUIBjYsvKXPlkbWqF5RcZ
 q+0N0dhYnJpZWwgTsO8dHppIChFZDI1NTE5L0N1cnZlMjU1MTkpIDxnbnVldHppQGdtYWlsLmNvbT
 6IkwQTFgoAOxYhBPJPUqh3/IpkCoNuHfnjsP+dTnqBBQJmReK4AhsDBQsJCAcCAiICBhUKCQgLAgQ
 WAgMBAh4HAheAAAoJEPnjsP+dTnqBOsoBAMzBqtykviO+gsSRXCRLsoy2qtxZbZjR/ES9zZLTobhn
 AQDZJiTrILQTFNHNJ26NLVDM+Av+cjgeOezlCEcAa/N0Aw==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-tOt7xm6/8n9SLNI2u+5f"
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-tOt7xm6/8n9SLNI2u+5f
Content-Type: multipart/alternative; boundary="=-hBmJIOmqXyEgaSBhoLFn"

--=-hBmJIOmqXyEgaSBhoLFn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, jeah thats true:

The command in question which is `git rev-parse --git-dir` to find the actu=
al GIT_DIR is actually the issue here:
It relies on having a proper HEAD despite the docs saying it only reports G=
IT_DIR if set etc...

Could we maybe make these commands more agnostic?=20
Making an empty HEAD probably directly also resolves these commands to work=
 correctly.

Gabriel


-----Original Message----- =20
**From**: Patrick Steinhardt <[ps@pks.im](mailto:Patrick%20Steinhardt%20%3c=
ps@pks.im%3e)> =20
**To**: Gabriel N=C3=BCtzi <[gnuetzi@gmail.com](mailto:Gabriel%20%3d%3fISO-=
8859-1%3fQ%3fN%3dFCtzi%3f%3d%20%3cgnuetzi@gmail.com%3e)> =20
**Cc**: [git@vger.kernel.org](mailto:git@vger.kernel.org), Karthik Nayak <[=
karthik.188@gmail.com](mailto:Karthik%20Nayak%20%3ckarthik.188@gmail.com%3e=
)> =20
**Subject**: Re: Bug: `git init` with hook `reference-transaction` running =
`git rev-parse --git-dir` fails =20
**Date**: 10/07/2024 12:57:19 PM

git rev-parse --git-dir

--=-hBmJIOmqXyEgaSBhoLFn
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<p>Ah, jeah thats true:</p>
<p>The command in question which is <code>git rev-parse --git-dir</code> to=
 find the actual GIT_DIR is actually the issue here:
It relies on having a proper HEAD despite the docs saying it only reports G=
IT_DIR if set etc...</p>
<p>Could we maybe make these commands more agnostic?
Making an empty HEAD probably directly also resolves these commands to work=
 correctly.</p>
<p>Gabriel</p>
<p>-----Original Message-----<br />
<strong>From</strong>: Patrick Steinhardt &lt;<a href=3D"mailto:Patrick%20S=
teinhardt%20%3cps@pks.im%3e">ps@pks.im</a>&gt;<br />
<strong>To</strong>: Gabriel N=C3=BCtzi &lt;<a href=3D"mailto:Gabriel%20%3d=
%3fISO-8859-1%3fQ%3fN%3dFCtzi%3f%3d%20%3cgnuetzi@gmail.com%3e">gnuetzi@gmai=
l.com</a>&gt;<br />
<strong>Cc</strong>: <a href=3D"mailto:git@vger.kernel.org">git@vger.kernel=
.org</a>, Karthik Nayak &lt;<a href=3D"mailto:Karthik%20Nayak%20%3ckarthik.=
188@gmail.com%3e">karthik.188@gmail.com</a>&gt;<br />
<strong>Subject</strong>: Re: Bug: <code>git init</code> with hook <code>re=
ference-transaction</code> running <code>git rev-parse --git-dir</code> fai=
ls<br />
<strong>Date</strong>: 10/07/2024 12:57:19 PM</p>
<p>git rev-parse --git-dir</p>

--=-hBmJIOmqXyEgaSBhoLFn--

--=-tOt7xm6/8n9SLNI2u+5f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTyT1Kod/yKZAqDbh3547D/nU56gQUCZwO/4AAKCRD547D/nU56
gRlKAP44HVbJu+EE46ABkgO6cT2JzLW3XHPXPRdCU1l5Sx213gEAwxLOlXLjrsg+
iq1/Fq3hRp5L1zVYZciZ3JjHAOaKuAc=
=cbxC
-----END PGP SIGNATURE-----

--=-tOt7xm6/8n9SLNI2u+5f--
