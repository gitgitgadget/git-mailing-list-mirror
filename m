Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0E63D
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738927052; cv=none; b=Sx65cv9ob7KPj0TnT5hflXKYUPIB6LNkpBxSQcZFbhOgPuEdLHENJeu2qxcneDLR3lg2Q6Hyq+1DncHgk+c6fekWU+3B71JQWxqs3qvYwefy0vAIUtJ5VUIonD3EEamgofSii4qjd31B0yQMMtI25fCJs1QSe4ZiB26sRdc8GLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738927052; c=relaxed/simple;
	bh=axxJ9Q37DrLwudJ7aELbMs4nqhBVtZfQOdrnHK6lXUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tC7DSnFUla/h5zIA5y8U+I9pf1XSZFQT6jM5qinUdRQgUxZ/ZyQ6ALZ9bXpR51e1TBQhiqE1QP7aU7At8Z3gGtTiaSgnG5z+unKCrYcCxLsGp/D783APLe6wOh9M15qO1QAMbuS5KINn8oOrprFWZiX7/HRyiQtcPYyBfaO7vIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4TrzSn5; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4TrzSn5"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-543cc81ddebso2228934e87.1
        for <git@vger.kernel.org>; Fri, 07 Feb 2025 03:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738927049; x=1739531849; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQ/OGpdB7/s6qfENYwyInecjLwf3kzCVyP8zUsX4wDw=;
        b=S4TrzSn51NEVqwMcm4tVBdxKX1biB8iy1MQUrmau0lD06aStdIdBfEk2GBBClzigIs
         dyljWP2bOLBWqB9Fl67qHi7koCJcE7NmmbDE9oOYNna1EFr7y4LNhVmNP9IZ2JnYvthK
         4N2lsnTT/TeIiGWmVVG3NBIOJC/y6K4Ly/kKq3Sqz+ySC7QG9iJKNorB+Iu+DPKBQl46
         tlGN6shtm30U3Zkc+cXhviduKNLDGXVR45D6V0mKjMsD2N38x4/dOJgP6/D5nkKihY8E
         F65//2EhExeVCQ3dJBr6pt+iaQMxHYSdVUY+ADx3nK8FAD3lXpPNqfow49G2ZgxH5T85
         o1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738927049; x=1739531849;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ/OGpdB7/s6qfENYwyInecjLwf3kzCVyP8zUsX4wDw=;
        b=ZKmE5XH8FiKUpiqDmItxfRfAJEjt4+1E7fZ6ISoPyL/ePDPxZBy6SVXU+mpIJfbLIf
         5Nq3cqbUCv5YCrie16dm78X0k6XmdcoIkWYql23hM0+MSgsB/HuWblcV+B8iL1vQ8St/
         IvdB36ClM9gsuS/HZAjbjD34CpZtd1gE3adRk4e2q0Z5jPr5CLXeXn33uL7odnynAQrd
         yXLRiItMLlLJTHeX8ZGEwtM732qq6WwIsBUPTS971NuKkc/b4CSrCI2RMINiD1fC8HWZ
         JSxMwDd7+DoibGbm4wF3w4mcVtZ1L9c2WPLG6J9UrnYf+ul9LioHYfX7YfKowKYNHxdT
         Uzmw==
X-Forwarded-Encrypted: i=1; AJvYcCUAcwsfO3Zl1MmoPpzMlhXRITC6glljZ3mOEcmqB/e1oIxUBuDfy0KIFsiNSBCiuSq1m4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOwUTfoRdRNZmE84AsoSt68kaaVzEsVjRt8AMxFemqWIaREzie
	dT4GFNzckPMOaBDRlOskkvyGc6bOohBcaBDxSFoABShwSiTENnha8bQJ/Lyj0SvVpw7TA0YsuJ4
	XPOfP/FEbxM1iVsGFBbN6hb63MMk=
X-Gm-Gg: ASbGnctitd5dZNU/xYKydLywhlsYiPd4tLxspSZ91XQUAMpY3qmMEBZuAjpZTlEhXtk
	zp5pwcz+VL/woI49UMM6MFR/MezNK5MPQzc1k6ECZh9YfyvwmYKDTFv9pNfp06OhHK5YG2372+w
	==
X-Google-Smtp-Source: AGHT+IFef2tvzKy0DdLVMdB6vs2Krc07RCL6OPfWyfMEVFjXaL7/zrsSJzIun4YNJbtXsQsx+Fdxf91iGwzZtfRylR4=
X-Received: by 2002:a05:6512:314a:b0:544:13cd:bf6 with SMTP id
 2adb3069b0e04-54414a9d084mr603381e87.18.1738927048951; Fri, 07 Feb 2025
 03:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205214726.GA30202@raven.inka.de> <Z6PsXGnxM3UBR3nM@tapette.crustytoothpaste.net>
 <20250205235931.GB30202@raven.inka.de> <Z6QCX1QZxxwC7RVQ@tapette.crustytoothpaste.net>
 <CABPp-BFZ3oyKiryKMPph+nfokC=sFa7wn1wdas863273bzy7pA@mail.gmail.com>
 <20250206134006.GC30202@raven.inka.de> <20250206200418.GD30202@raven.inka.de>
 <CAPx1Gvc2piLT=p+dvzcJPTMDQAAjQfz__O4KiRWs-fOMg8dpTw@mail.gmail.com>
 <20250207104510.GE30202@raven.inka.de> <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
In-Reply-To: <CAPx1GvcyaZqYK+SvgtfsajqtkMty1jOcVAtwfmam-LpOjyd0jw@mail.gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Fri, 7 Feb 2025 03:17:17 -0800
X-Gm-Features: AWEUYZmr-wGISaELZTUfABiP0V6vFqeb70GXUvVKON-yCRbDUVDvvvqaY8l9rWI
Message-ID: <CAPx1GvfYDRheWChrisUkZsLr4ucWO_o_k9Dh8wS3xcz2P-Pxig@mail.gmail.com>
Subject: Re: renormalize histroy with smudge/clean-filter
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Oops, I left something unfinished:

On Fri, Feb 7, 2025 at 3:12=E2=80=AFAM Chris Torek <chris.torek@gmail.com> =
wrote:
> Running with an explicit `--renormalize` turns off the efficiency trick.
> This is documented (indirectly) where

I forgot to fill in the "where" part.

It seems to be in both the FAQ and in `gitattributes`:

  Documentation/gitfaq.txt:You will need to run `git add
--renormalize` to have this take effect.  Note
  Documentation/gitattributes.txt:Note: Whenever the clean filter is
changed, the
repo should be renormalized:

Chris
