Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170E220F2A
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346609; cv=none; b=CaqGe02IGyo+WbqVHYmch9sAck2mKPN7UozxxwOHqhkvDFyYZ2peTamrlYV8zGBJqxn1i9HzVpxxjEYcosFehOvT5jJTAXfoLHkKwgi9Hu6ui0Z50HpQ1JLPbMy6CJODrQr4GnpIgPJ3SV8Qb3RpfEfgXXLn4OCj1soFL7vysU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346609; c=relaxed/simple;
	bh=1YAWsSIMPMYAbIMhsNPR3W1GbeHjH0HV8MyO65J65Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ryXnwUQACTzbPofrMm1vpREr8XW6V2yK/xsxttROlgTpGzdSoWhyhmo/yv7LzBH01U2ydhzOnrNoPqLIdgg3GWa2iitXL9ehNXXnpLxa3zmSMvFfaEPVvnUW6XNg5DxUH+TYL5YUpO9JrC5Wp9++u0gO5msr9uBwdD4pIXze0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZ1EYu/A; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZ1EYu/A"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so719831966b.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 02:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760346602; x=1760951402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YAWsSIMPMYAbIMhsNPR3W1GbeHjH0HV8MyO65J65Vc=;
        b=DZ1EYu/A+wmtZ0H+kRMGxINKH0CbkuIo72kgogVhlqKqJDSGEZ3oPw8MtyjTBZyliI
         sTHFh5e0hWDVakajYXfGsSKvKTLlvhSY8pLw9DM4qZ0iCcDgCzTh9EKyXirCbx73I0n4
         S047z4dsmkpn3R2cLkIUCpOqm7ylkbsDGs6rxaFzYiND5Aur5an0t/+X4r56GGmcNjJx
         3BGtAyTPOWEVNFi7d1Niw63AMEbs9SHpF2GzOKsjlNrfCZEXsw+CLu2uEfixRZP++Uqv
         oRHv3pTysR2K9FK6iwqioXgPEhorp8qLdPyWkeSYou2qZ0YNFTf1yM4hELqAe5zkucyt
         0KeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760346602; x=1760951402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YAWsSIMPMYAbIMhsNPR3W1GbeHjH0HV8MyO65J65Vc=;
        b=RMhrZVOh9qk7xGLfZvBeUpcmZwloM59Nk4FqtH7vyRu3e+Ok/Eqe/EkjwFA3YNhS03
         ixtz715qkvBd0DZyAl5+dM/9Z48XNo2x5O2HFLZBLE2pEwlIyRNO+ZpsATsi2EZVl5Ra
         zqXHJDzZQeD6dK3w9W+8mpbfNEclcrxJeS+48E4aqToWmZKJJmt0ULXXrQKFei9xFEQM
         lir4Y8vYxMBpDiaC7T/J2XmRTfocGCsUmZnu7+otBF9v3Pundo9D5S4o4r1c8JGhR7Fy
         rHJEW1+dWId+KuV7MbRSDCG2suOwody5GtnYTPsWu8K9vrcfAde4oA+Ec6DkL00I0xb4
         cRrQ==
X-Gm-Message-State: AOJu0YzCndbnZp7E/t2VS26QzQZZPBN1vc5okuxwjQIi/B+OotUEKfpV
	Imcb9Fpu6hfY+sfO6qBHdztMMnuW/I6KwqtEihqNnvyH/Nn7/BIlL4i8ly637bB8czUIfh0JwB9
	CN1rz2mjyJgaW3PkAyKF16kM1A5R4LYiYlAVLWsc=
X-Gm-Gg: ASbGncvnx9I000zuZZB2887OBlCzZJCcmBER0Drk8ppju3W2lgQELXLXF+rcs1ZoiEy
	lq/PC086wmMngBc6G2i7FpLfd+wT0ToyEvXdum57nViE+Yp6zol/PimInCh2W84CrYi/zL+uesf
	m3L6I5lG1GKVP/IoK1E7jx52nhYzEiFRSsO4eqmsuDhueyvAMSk5Fks7sfTvh1IEB0kxGVUF+sF
	B1oIzrdsCggWUL+Qk4GfwyGNAukucc2hteH/10qR7aOL1s=
X-Google-Smtp-Source: AGHT+IG4+5pOWEEQ7oP9Jh+JG2CvE16pm192qUOWa1z/kL+RWgmQnaqS0Ch0kEVgzinUEyTgyABnqDNDke2EwniGzhw=
X-Received: by 2002:a17:907:3e8c:b0:b3e:3c1c:d301 with SMTP id
 a640c23a62f3a-b50acd2d796mr2060171066b.61.1760346602456; Mon, 13 Oct 2025
 02:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007122958.1089680-1-christian.couder@gmail.com> <20251013084857.1646783-1-christian.couder@gmail.com>
In-Reply-To: <20251013084857.1646783-1-christian.couder@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 13 Oct 2025 11:09:49 +0200
X-Gm-Features: AS18NWASBQMuYypbpnjE1h4gY_24ChIvfty1DsTFw1pkC9Z-HPyxOItlM_gD808
Message-ID: <CAP8UFD0Jdb2Q5dpspUOnKBJuupikJ21mJmzRyYsNOhem-JP-9g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] fast-import: start controlling how tag signatures
 are handled
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Todd Zullinger <tmz@pobox.com>, 
	Collin Funk <collin.funk1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:49=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:

>
> Changes since v2
> ----------------
>
> Thanks to Patrick Steinhardt, Todd Zullinger and Collin Funk who
> reviewed or commented on the v1 and v2.
>
> There is a single change in the first patch (doc: git-tag: stop
> focusing on GPG signed tags) where the description of the
> `-v | --verify` option of `git tag` has been improved.

Sorry, this should have been sent in reply to the v2
(https://lore.kernel.org/git/20251009122457.1273701-1-christian.couder@gmai=
l.com/)
instead of the v1.
