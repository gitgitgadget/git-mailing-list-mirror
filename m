Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73F57FF
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 04:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721880118; cv=none; b=Nswbt/0Y/DU8ZuTEaYwEDKfICVmxqd3NUThCKC7mLsWbA48J9WWsQ9WU3Hl8uMaoJqrPx8rSV/Gq3Mu9iowJwPJasP5dIaQo+Gtb4YUFXUFcTMoBrM1juIuIVVvXrV3Sv9EGx0PO5nLG4FL4UmpAfCp7kAGvWRtpzzoWEyg7DNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721880118; c=relaxed/simple;
	bh=YbaA/h/1dwCUOhwX5uxsVonUzaJ0YPLvYqH96Qp3wK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=j6LQBqr1TC2t4dnp5Kd8TC2dJ0MDz7IdJM0gDTp4R12AKCjRVF84ql6n/x/T7kYeXOOnVVGi62c6kq9U8n3BHECJmQKj8xfTUtDGfQYd5Zjo4qezNcWi1ZIwiGJEzxPLhKgb/e87E6W6UrY5uOdnMccjx3hC3VIEsBMSCzSUCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGv/6i0w; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGv/6i0w"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2cb57e25387so427848a91.3
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 21:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721880116; x=1722484916; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRTxr5FOw4+54nJOQcCaOa26nksdjlN4cfqXfyUQZv4=;
        b=gGv/6i0wrCjd3mQGzFgFEKTNJc4RA3uMZfIMqResY7DZaw9SeJ+pyzcbMVOeo7QQi9
         1dzSdWcqD+SxO/ycb9RJwNkOB9Dg+2L40+3SIeW+0+kOuP6J2cr9Ob0uAHDwhQZp77t4
         OarWBnAsp8aYZS+zPiuupkp43K8lmDjFYwpmh8781+KNR14Cz+edgATJ3/L5JAjO8xtF
         MnKeb1hD6nUakRLRufFy2DLbsxSs1gRKOiU6Ls0z3g/lwywAxqz0/LY4fudYcgowvJ4c
         UL5y5DlVarbWuipgTPUVIuS81HqrCNcl7eNNSki5RzevixIj85Tfn+VeWvDYxGH7DMQe
         b+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721880116; x=1722484916;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRTxr5FOw4+54nJOQcCaOa26nksdjlN4cfqXfyUQZv4=;
        b=M45t4fb1ZxwAKbQBgd8I/Te14lOeQYESCvwPjkftYfeM5qdiVIPeeSRVvBXjfikihO
         O2tq7PGVxNq0RPglfh91uETwfIG+BfICjiVC+v3X8bpQTKPB8E5PIxjJShvvPoTvBYki
         2NnVyStMd5F0xcwd6kuWPh+kdoL916l1O7jjSWafIxhrzDLDxney61fNoUN12ZElA8ZO
         sY6sKIHfDKKlyZE2ecSXL0UZAk9bzXFol/hzmFXZCx/rnJBcbfopinq3NgT1SNMYvpS5
         ITgCbl+jOTkH+Gqd8bUjRsz+Fmnt3H4QY+vIb8VMTp2MdlxFuXpTWvXgTrkBcqxQqFws
         Bl/g==
X-Gm-Message-State: AOJu0YyP85qN5ZgdBvpS7YlLEB7OxL9dpuBEKZ5+o/9xrz2KkOi/O6s1
	ATGM4+xAw/Iw9yylr1SgUW+JnhXrscG8b7WFLnVG04g5MM7fl7hct09/E/q9nKopolyfKx/gCJ1
	7Rr5UY74yIZ3hS0yn89YM/0nXtTgW+XqT
X-Google-Smtp-Source: AGHT+IF3nYhrkN0GrKQbh+J5omIywTmv0skTt/52K34AsPksAOsim4i6WWNldHn6/AQ35fF47Ej8tcnPlufI0vOOeqU=
X-Received: by 2002:a17:90a:5e4e:b0:2c9:1012:b323 with SMTP id
 98e67ed59e1d1-2cf2eb6afb5mr701193a91.27.1721880115695; Wed, 24 Jul 2024
 21:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADLV-7+fX7jrC8e_nPBHZfg8yXKpjLfPL3MgxS8peUrr8pqQoA@mail.gmail.com>
In-Reply-To: <CADLV-7+fX7jrC8e_nPBHZfg8yXKpjLfPL3MgxS8peUrr8pqQoA@mail.gmail.com>
From: KwonHyun Kim <kwonhyun.kim@gmail.com>
Date: Thu, 25 Jul 2024 13:01:45 +0900
Message-ID: <CADLV-7JN-x8+Y+sVO=O-f4Ur7jw8Bs+z0BzQy5y9GbPTJ9eE_g@mail.gmail.com>
Subject: Re: Possible bug in .gitignore
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I am experimenting with git and I found there is something not working
as explain in the document

When I place `text_[=EA=B0=80=EB=82=98].txt` in `.gitignore` it does not ig=
nore
text_=EA=B0=80.txt nor text_=EB=82=98.txt

I experimented with `text_[ab].txt` and it works fine.

So I thought it might work bytewise so I put
`text_[\200-\352][\200-\352][\200-\352].txt` with no effect. (=EA=B0=80 is
"\352\260\200" when core.quotepath is set to true)

So I think it must be a bug that is that pattern [abc] or [a-z] does
not incorporate non-ascii characters. but I am not sure.

Thank you for  reading and hope to hear from you guys soon

KwH Kim.

# =3D=3D=3D=3D
Here is my spec

PRETTY_NAME=3D"Ubuntu 24.04 LTS"
NAME=3D"Ubuntu"
VERSION_ID=3D"24.04"
VERSION=3D"24.04 LTS (Noble Numbat)"
VERSION_CODENAME=3Dnoble
ID=3Dubuntu
ID_LIKE=3Ddebian
HOME_URL=3D"https://www.ubuntu.com/"
SUPPORT_URL=3D"https://help.ubuntu.com/"
BUG_REPORT_URL=3D"https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL=3D"https://www.ubuntu.com/legal/terms-and-policies/priva=
cy-policy"
UBUNTU_CODENAME=3Dnoble
LOGO=3Dubuntu-logo

git version
git version 2.43.0

LANG=3Dko_KR.UTF-8
LANGUAGE=3Dko:en
LC_CTYPE=3D"ko_KR.UTF-8"
LC_NUMERIC=3Dko_KR.UTF-8
LC_TIME=3Dko_KR.UTF-8
LC_COLLATE=3D"ko_KR.UTF-8"
LC_MONETARY=3Dko_KR.UTF-8
LC_MESSAGES=3D"ko_KR.UTF-8"
LC_PAPER=3Dko_KR.UTF-8
LC_NAME=3Dko_KR.UTF-8
LC_ADDRESS=3Dko_KR.UTF-8
LC_TELEPHONE=3Dko_KR.UTF-8
LC_MEASUREMENT=3Dko_KR.UTF-8
LC_IDENTIFICATION=3Dko_KR.UTF-8
LC_ALL=3D
