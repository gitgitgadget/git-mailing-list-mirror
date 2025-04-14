Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E02BE7C1
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744634262; cv=none; b=MWJMrQ/+fOGD9cySVEcxKXY0AmQqygIkWT7ryoeRn/KwvYb1b7SwlafEQ8uieVQvRPeJihytdnxpa5aWjbkogFHDpdn7SXrylFph/dTcRNVUBhgqiyQ9U/5NGmDvnFwv5+B/l0wQ9HeZtYn1fQTmC3CjtWU83hcK/UL/MRfUonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744634262; c=relaxed/simple;
	bh=G+aJ7D+hhGyppGmrNUmztWZCnQ3yjL0e5klkXWyCgz8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=sQr18eUwlLE1YawSW9/mtpjcdlXN62qBHLdHy9zxBPaJudZlMrlLlOiJDoy38hOsq7gpkGJn3AQ7IoPB3jcJoSHYb9DSluinfGtA7Y4jLfYLbGJO+0CT0r0et+qGBq51b09RMV42vj4VIircwSdU95UrWcO2+Zp67cZ5kt+B+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSmlLnWy; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSmlLnWy"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac289147833so855499766b.2
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 05:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744634258; x=1745239058; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AyFrU5al3X74xufQJ7Prd8MNtSlx2dXF2fSXlBC1DeU=;
        b=bSmlLnWy9JdASkeKAH2NSsiAnoAJq6S/u7wh/7UNJDdgQsm2wuA0CvlG2xM7UnbjVH
         0XXVdx0T4x5TLYw/63gYBBk4spXSLfO2UVuF97nQrR2iZbrB+48IkxCKH44dGPrq4vps
         6k75FdelfqXyXF52Nt2XeQfwGlsKG/bZNufH1cZO7Jk32VLAcJfl6Wrb5PGMp+LScJBW
         luKlbv7hl/nBMO98b3mhwsnHKlBYRwERhqsAY6OtfVcxRi6t83oF+2OHPHSfJCfCtl6J
         JaLHiodIo3iyE7WvykjYvje17srENGqONi7YcNprLkWUNeg5cblx6skW5rFNOt9EWo2+
         ztHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744634258; x=1745239058;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AyFrU5al3X74xufQJ7Prd8MNtSlx2dXF2fSXlBC1DeU=;
        b=XcbM79zfW5dPAMz04r1SLs0vi8Opsqzh5Emy5tJEJ89hf4A7TTefkyWAzGkVXyB35Z
         PIgv5jHgMk9cNfIavCTPcwwkqtYbXbPnjPOe7t06zYdA4NFae1/Dv+23lH6mvMzVLDGD
         Pk+kIlsWdIDmBIKkMaYrpG/0QthKd1wzDQKgUpAUYNjwnh3YZ1HZ57gSBrB8X7ONn4dJ
         xvYpCvEAP3eTM+hox44SdHhgKgRYb2jtNSR8rRKpx6USPvMe97S4C90WCHQncXlNu8GU
         K7w0MXj1bsGWw/xz8iX0I+Y5y19kP/y9I7xKzmYw603xyvV2uS8DB7fRlzTUyc0kxhjp
         ny9w==
X-Gm-Message-State: AOJu0YyHt9Zu+D7sGX2GqBm25s28OqM8juGT73mVG8/7oRfNJ3JFDj5V
	R5DlBSJaw4c2XwSBJ/s9Ws2eOIVLLGI3waiPhJTCC2bXXfEtkgNHrb3g5EZZTN8=
X-Gm-Gg: ASbGncvGUbyX2M4dgekTXxcd3b4A6otJw3wGXDzdVieGPcZ4k79fpg/3R8Be32hUI92
	BMrvDWWuPi7ysaOv1jTRZd7SeVGm/DtyQvcSFOD54WTDYRv1695xNc8dadizKyALtrci1CVB3kR
	SKbh8kzX0/GwJzb6vwalKWoZ5IrdNczNWApsM8D3LH6oOqdCh176iYLboCMJVTu+d6sbKx8PPk2
	Gb4vnLsAFLihSM0gdfAxPrvIul33AQ1LobOcf247C7FbMQeQhk3+0LZN0hmrmvLho/SGLqddy2m
	Bx1hv0xoq+6BkRYI2kwdRNNeVsvyk8f6Egz2ktr1TNzkkeYHnWOhMaCo4HFNdDs=
X-Google-Smtp-Source: AGHT+IHa0geO+d5YLGmT9NrqHMuBB7XaGf1smM1NdGYDOx/+Y4Ducuza6ks2SNQWf8HgHUI08DlrDA==
X-Received: by 2002:a17:906:4889:b0:acb:e1:6503 with SMTP id a640c23a62f3a-acb00e1666emr213258266b.50.1744634258202;
        Mon, 14 Apr 2025 05:37:38 -0700 (PDT)
Received: from smtpclient.apple ([212.36.34.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1cb425csm907673666b.104.2025.04.14.05.37.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Apr 2025 05:37:37 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: Collaborative community interview for Git's 20th anniversary
From: Luca Milanesio <luca.milanesio@gmail.com>
In-Reply-To: <85ea4aa0-c595-4f0b-a2ac-d0113aca464a@gmail.com>
Date: Mon, 14 Apr 2025 13:37:27 +0100
Cc: Luca Milanesio <luca.milanesio@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Markus Jansen <mja@jansen-preisler.de>,
 =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <04A328E9-1146-4D4A-84E7-456FFEB66A5A@gmail.com>
References: <85ea4aa0-c595-4f0b-a2ac-d0113aca464a@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)



> On 14 Apr 2025, at 13:31, Kaartic Sivaraam =
<kaartic.sivaraam@gmail.com> wrote:
>=20
> Hello all,
>=20
> As part of the Git's 20th year anniversary, we from the Git Rev News =
team are thinking of doing a community interview where we would share a =
list of questions that we've prepared and we would like to welcome =
answers from anyone in the community for them. We could gather the =
answers for them upto a particular time (like 25/April or so) and begin =
curating the answers into a special interview for this month's edition. =
The questions are below. Feel free to respond with your answers to this =
mail thread. Let me know if I've missed to include any particularly =
compelling question.
>=20
>  - What's your favorite Git trick or workflow that you wish more =
people
>    knew about?
>=20
>  - What was your worst Git disaster, and how did you recover from it?

I suspect to be one of the worst offenders :-)
https://www.infoq.com/news/2013/11/use-the-force/

Thankfully I was using Gerrit Code Review and the replication plugin: =
the refs were not lost but just rewind and we could reset all the =
correct SHA1s for all of them.

>=20
>  - If you could go back in time and change one design decision in Git,
>    what would it be?

Use SHA-256 straight away, as it was published 24 years ago and already =
existed at the time Git was designed.

Luca.

>=20
>  - Which Git feature or improvement over the past 20 years do you =
think
>    had the biggest impact on your workflow?
>=20
>  - What Git problem that existed 10 years ago has been most
>    successfully solved?
>=20
>  - Which Git commands or workflows do you think are still =
misunderstood
>    or underutilized today?
>=20
>  - What's one Git based project, tool, or extension you think deserves
>    more recognition from the community?
>=20
>  - What Git feature or capability surprised you most when you first
>    discovered it?
>=20
>  - What's your boldest prediction about how version control might look
>    in another 20 years?
>=20
>=20
> Looking forward to see interesting answers. :-)
>=20
> --
> Sivaraam for the Git Rev News team.
>=20
>=20

