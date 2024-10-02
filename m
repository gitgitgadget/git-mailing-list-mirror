Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F31957F9
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905764; cv=none; b=CUP+aTabavBIBojjXZE5boxEJKhMrSYh1s3WvkeeoEdAPHBcfka4fpA5bbFsV2o2lLhUaNM9+CImM+tX8aOGB7q827YT5zBpC3mE39cnDbriEA3bEHi5JfuRoRhNVeNSv80e2hIbHT7ppaYORsVumtLuJZ9EBipWk5gec1zeynk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905764; c=relaxed/simple;
	bh=JlOCQhvCB+3GGt0wSFdJ/ptp8eoTu0X9S0jOZ7hAuJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8PDR1iUiIILp92heYd2NtM8dEhP3j3tScPK1cHvXYcARGuEAZ+tsIyreFlmJOYEZLJlS7TaG4GZ3GbMxplYQ1oPmV9AR6oxeSxCEZm1oSt/biu4Zp2/scBLCtuo8Ux/MZd12uDyrlkGlEw/JNcYKwdAYFzL92bn4BVJzQqSHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a99f576d6eso3054585a.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 14:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727905761; x=1728510561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlOCQhvCB+3GGt0wSFdJ/ptp8eoTu0X9S0jOZ7hAuJk=;
        b=IaQnrXJ/1K9ldM/BPsdNArOJ0NeKxs0snfS/Uyf+/RwsraYOmA9tqUSmm54/s8842e
         J2t6As1UBtfG7FpN7n8fvbZ5YcgDCaWc7vro2ov4bOY4qBP0B/luaQaM/Qs4EP+LLq1o
         5+oKfPOAAuV5PtgZEEuuyepx/EebiV74wasqjcd8Kcs49n7ygqb1L0wssvln5lwh3SWL
         /IaRwVPFiPr5NgMvJfL3GsmhUOUrILYFESpv1FbNUz3Gcji94oRs405GmzuLglvKNx93
         9nhWYpHStivKXLoAkHaEf+7SsK+ZKZyEpseCLB08PbWzkkg6qs4e2tipg7Dfe1TMqnO+
         S4KQ==
X-Gm-Message-State: AOJu0Yy5vckZ4YSLEiojvgC6Zd/ABXF4vxlZtrpjw8SvwuKDaFit3RPO
	6WvxSwg+50caeNOxx23iBxmTchtaK0e1nKRxjQepHXk0LbFShsdoo56BTqUGl3Jws4N8CKB7TBj
	Co91YNyo1THvgAXJ0akdyud5HS3TLTWUK
X-Google-Smtp-Source: AGHT+IGk24wRUwzUWoheUe+Qgs7eb+EAK096zp1I1oL2cBO4flCFXEh/oFYGN9H+UTCUeG2xXtv6QB9Nlio6Z4pDJ/g=
X-Received: by 2002:a05:6214:f0b:b0:6cb:2d1d:348d with SMTP id
 6a1803df08f44-6cb819f3bdfmr32583856d6.4.1727905761065; Wed, 02 Oct 2024
 14:49:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727881164.git.ps@pks.im> <b5c116396da61f44057fbb5a8abcefe7ab1b67f4.1727881164.git.ps@pks.im>
In-Reply-To: <b5c116396da61f44057fbb5a8abcefe7ab1b67f4.1727881164.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 2 Oct 2024 17:49:10 -0400
Message-ID: <CAPig+cRNPmbAY=HAkxnioXeq=gDSaYQzytE8Yj0DLanYMT7rxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/21] t/lib-gpg: fix setup of GNUPGHOME in MinGW
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> In "t/lib-gpg.sh" we set up the "GNUPGHOME" environment variable to
> point to a test-specific diretcory. This is done by using "$PWD/gpghome"

s/diretcory/directory/

> as value, where "$PWD" is the current test's trash directory.
>
> This is broken for MinGW though because "$PWD" will use Windows-style
> paths that contain drive letters. What we really want in this context is
> a Unix-style path, which we can get by using `$(pwd)` instead.

It's not clear from this description why Windows- vs. Unix-style paths
only now become a problem but have not been a problem up to this
point. Is it because PGP testing has always been disabled on Windows
until now? Or some other reason?

> Adapt the code accordingly to fix tests using this library.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
