Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A08318FC7B
	for <git@vger.kernel.org>; Sun, 16 Feb 2025 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710614; cv=none; b=hnHBanDtdcem1OuvagAN96A8FXpcfQ9xRdH94jSu+OVdbX2pSsHlkmIYX/L5j8R4rlxxMDICi18a2cqP4hxfiIwepYef7KKm83Cr2MDpo1rOmdE96oOE9/1Wur5px7Bv75j7QYOt512wUElwFBZJ/CFf353TSMkKApfH0XL3uwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710614; c=relaxed/simple;
	bh=PKdGoIZ343qAcmSwC2PLv9iL81pZ92ib5RdTs8n0iVU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=e6gq1mvW+VJICNsFOm7dTJYdXDfcz89khK1d0Q8H3oyDZIlh/3yupAsB5r+T2RL2FrhMTdS7hjreBFGsSBcGrBQi6xoie7fAViZfJCLWfK3EKm3q7n1omO3Ms55fY1lvcXhqIoGgs8ZwNIFoVoGLq1gbUhNuHTpG6NLVYVGQ3WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnHFD4tM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnHFD4tM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-220c92c857aso54848205ad.0
        for <git@vger.kernel.org>; Sun, 16 Feb 2025 04:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739710612; x=1740315412; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35TBZnb4lQ3mh+uNYcVJ616c4+IGcihbTAr2ig2jgo8=;
        b=cnHFD4tMIiFfjORzQSqb4WpzMd9Igu6EV1+au/H/uqZGBCd9J6HU0N/bKspmMgrfEs
         PB8Gcl9iD3qO423QgzIAa6avsEDn1kiJtwxUthK+L6rmYlZYmp02VbkJA/zqmN6E5HLF
         Uzlx8tHW87doNzAumgqsq4izER2DOu+v0uKcpYkDFImx0CW/01RO0yIOy3FOa28vb6QY
         cNB4j59O6MvZDAqDkG0MhuofwwtDrtA3ATra3v4N/Uc0gq4ex+mZ5W39hMivSUv64+n0
         TQYgKjFk2iJ+EWU/vnnCmAi97vRxsvwcAaZrEfBNKjJYQBgH17VEoOTbzvgqCHvlQ0PL
         9s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739710612; x=1740315412;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=35TBZnb4lQ3mh+uNYcVJ616c4+IGcihbTAr2ig2jgo8=;
        b=jxBC/9PvCbBAwLdcspVl0j/Vo4OOY1woU7gyPP/SsG4Spt5DHOqa9mss8Nskox5tnc
         H4b2s+20YUexOf26NTdHmTD+wd6YOrxJmVUE5piqBQBbQSZxpie03kYqtyPn1QLHCE9U
         e+xVSuZiuCjsIsYSc8P4rCXxuUYV4pTpwk9qV+rIsuZmdHswCjdxSXr1rcxV+lYTvIXf
         BWeMgINS+HPJtjJtDkBetpP44lDk20YviQ2N0KwFQfgh7cequPPqqRM9c6h1njHAoMuY
         VrLukeV9i4WSee0IL0ZPXVIyu1hfDBrwZzvd9jsfj5LzviqSZ430+rQFs6uboRI+khE/
         YfMw==
X-Forwarded-Encrypted: i=1; AJvYcCVbBeQusRZk7Cupz1DuE2ocP/xtZBKU0pKJwfyH6YzaAiAEzQ1l/2CByRb2c9M/JMRWQss=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWat9TicVZzKcWdVizthN+fhC49xfZLvIYTzw19dkdQOsQWd5Z
	Fhmv2bvGsXFz72oRM7IXPrETZy3RQSTq+W/ySA9V93PAR5ZUN6Xl
X-Gm-Gg: ASbGnctD0avJA59+8VXVQEQggiwnmul69ZQW6wTE1K36WdFPib8HW5jZQZRElUg0CEo
	KLP3/jwnmn2PTdq4Kh4eChwJP0nAtKj696aY4WffpM3tWMjt0J5cLCm5NWhXYivA41KxHF4RdDb
	bmhC+Qh7lfR4Ec1DTWXf/VBIYi5j1fB2L2Y/glbuOMkEBBcvVDNJBVGEmFXCRLe2sq4rPJ5ZyHP
	HykErWZJlEgyEhvplQCFuHqH/Z6Z6q4A67bc//NBOGcKeMK307MIdj6a8mV9fx37MYtrHOJKkb7
	bs9lRyJN58LMkH2TZ1G1GcExqfh2Wg==
X-Google-Smtp-Source: AGHT+IFs14GcMghBDiCiBwvPPPNeeUD70SlO8qwIrqvHMCtysuo+zr24LAIcrSu+QERKVnc0+Lihaw==
X-Received: by 2002:a17:902:ec92:b0:21f:6ce8:29df with SMTP id d9443c01a7336-220d33a5d29mr231995045ad.3.1739710612417;
        Sun, 16 Feb 2025 04:56:52 -0800 (PST)
Received: from localhost ([103.31.220.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add5a4cb306sm3104896a12.3.2025.02.16.04.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2025 04:56:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Feb 2025 18:26:46 +0530
Message-Id: <D7TVXVKVWRS8.S2BJN32QHZ0O@gmail.com>
Cc: "Karthik Nayak" <karthik.188@gmail.com>, "Jialuo She"
 <shejialuo@gmail.com>, "Git Mailing List" <git@vger.kernel.org>, "Junio C
 Hamano" <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Kaartic Sivaraam" <kaartic.sivaraam@gmail.com>, "Patrick Steinhardt"
 <ps@pks.im>, "Christian Couder" <christian.couder@gmail.com>
X-Mailer: aerc 0.18.2
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im> <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
 <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
 <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com> <Z6Xmrfut7jdsVAfg@pks.im>
 <fa9ad3c6-3b3c-4f3c-89c6-101ed1b51eb6@gmail.com>
In-Reply-To: <fa9ad3c6-3b3c-4f3c-89c6-101ed1b51eb6@gmail.com>

On Tue Feb 11, 2025 at 10:48 AM IST, Kaartic Sivaraam wrote:
> Hi Patrick, Christian and all,
>
> On 07/02/25 16:25, Patrick Steinhardt wrote:
> > One thought: From my point of view I'd strongly favor extending
> > git-refs(1) over reftable support in the dumb HTTP transport. So if I
> > had two applications, one for each topic, I'd lean towards applications
> > for the former topic. That might easily cause unfairness in case
> > students aren't aware of that.
> >=20
> > So unless somebody else wants to be main-mentor in that project, I thin=
k
> > we should either drop the HTTP transport tropic, or communicate our
> > priorities clearly.
>
> That makes sense. I've added a note to convey this clearly. Kindly check=
=20
> if the change in the following PR looks fine.
>
>    https://github.com/git/git.github.io/pull/750/files
>
>
> On 07/02/25 13:37, Christian Couder wrote:
>  > Yeah, but we have time to decide on this. It seems to me that we can
>  > still come up with new project ideas and possibly new mentors or
>  > co-mentors until it's time for applicants to send their.application.
>
> Indeed. More volunteer mentors and ideas are always welcome :-)

Hi,

I can co-mentor this summer. The 'Machine-Readable Repository Information
Query Tool' project seems interesting to me, although I'm up for co-mentori=
ng
in other projects as well. Let me know if you need any help with
anything else.

Thanks.
