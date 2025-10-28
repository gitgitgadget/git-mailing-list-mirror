Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB125F96B
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761678730; cv=none; b=hHUzp3hjtXTwOgh5YnpOFNaDbfsTl35oACW0gWO7n56HrNS3sqYGSebZf6nzoxCEJizOYQOq7ba5cArvXUisiHJW3iQvStbONSOLIMUrdKavD03C0OTPdgZF6i3ComUycJ/jWfizNDu/eAD3RSysBH5Grp07qDqAIbhDX294PZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761678730; c=relaxed/simple;
	bh=9xDeqyNVjsPsVdJfaI8PAMs3PVM3oXNUYReQboSdRV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FgVK0dYT813Xt0xVwTfnWT5qyngRVBeMBnRLerSnPDFsGgZDalFIjQE11qZnjzs44ir0yLY8IjgX3TvxvcnLDtId9RntlOS8t+6cMJJc0eeO5ORn0fYtNcH9Eu9b7y6zBS7DBLKY8Mjz1acQli7HEq5np+cfkz2qBiDXpaTUsTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHOS3IWe; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHOS3IWe"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-362acd22c78so60122781fa.2
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761678726; x=1762283526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xDeqyNVjsPsVdJfaI8PAMs3PVM3oXNUYReQboSdRV0=;
        b=CHOS3IWeFh9rVktBK+u1T9eY5Fh4c82ZqpcpdkBWA61jgLqPl4dKxKnADwFVdbFg2w
         Cw6MNbSONakH/82QrqX7N3KZ6XvlvKl4xqoPVsZ8m3RexmLYGhxBtQ4Yh3mjX/+aQwwp
         Jd8J3oJrCgIOEMrRD5f+Zk5m7hPU2c+EIqq6pBPrA81NH0QinQrSzm8b7ink5PPvTBZF
         g38z24a/2pYvOPo0XSyX0qoqXl43yV7CxxsXB3ZCRbu0vYCgzPejRkp4VFWDfCktXTSJ
         BBuBXWR2TkbGvqUdo77eddcj+jOOpvtYs/SLanGx0uVEWe2Z395Lu3mmm/4QEh9PBkf/
         fBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761678726; x=1762283526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xDeqyNVjsPsVdJfaI8PAMs3PVM3oXNUYReQboSdRV0=;
        b=oNFWcvyAoyMF6pGeoGEwnmJOCmKN/bxWLZRJ2/kBEKZ03MibhJKnpGmocJ8fD5AxgL
         DfZm8jHFUr75npk8DV+rmbME8wx/my3Hdkj3/FJfkwt/O41OkQ5JhD463cIybuZZWJK0
         SHhydHsENFlC4wy7sgr74yDbbVyJvn+Sj6P3Pf8L/L5kEwz7dhqEakC4xMAh0G1FdZDi
         qTdHcNvQIA9bhOVmGuqgC0S/iHyb0nMIrCUBeJqZk6UsaXRMT6+h/OybzopM+0o4R8al
         rbzqBwQ7OWpkE8X+UF5rQ0CgOG6XyhQay6zs9kzni0JboCkJG9DuF0NpOYYTLSMxGseZ
         62Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWdYE+SfqvxClHWUxZ1i48O31+vU/5VwXVe0loZ9XUBHf5dtdKYjarfTMz+PDUOzEfJZsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0B7GHXF77TgPl2tDvPQtYcafblyk0dG3Ys2f3kCgkJSx9NmxF
	uCOaMB85lsIytoxx7C7ojqQPhMxAUme7t3KphraCDpag8go7zO8ytnPwEbpYJFJOCX73yntVwTH
	x2BkwVr6OHOeR7cLJbtmldtjjlS7QnPzzCA==
X-Gm-Gg: ASbGncuws2Tq5dkmGyoUg46C5s5LnMgW1Iy6LbxfSP1EfLMl80i1u2tkzjBgj+Oo3/B
	UAP7217KlnbgKOzw47AiPhpSrMbfiUR0WX6HQy0xxeQ6U7I3hOEEothMUVWmAOF51L2xsN3F3ZN
	uVOVGDpP3kCflNa8xiZYWJ33SPwOZf8Yxvq+iZ5OjxmCdfsjVmLQAXjnkn1zxFNE/JCrKeuu51g
	Wa+5rxSujPyoxzvoC4wN2ZsXldgXvMt552yMODT0FITLaJWbx3Kl0mxTil1rw==
X-Google-Smtp-Source: AGHT+IEmsGUZo2kZzVP335PKA/hErtjrVmxbkVY+yf70ntpWs5z+MVYyEAicf5TlgfYFyHHTH5sxQmy//cvUMv8CAe4=
X-Received: by 2002:a2e:a7cf:0:b0:335:44d4:161b with SMTP id
 38308e7fff4ca-37a023f626emr2035381fa.2.1761678726194; Tue, 28 Oct 2025
 12:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im> <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
 <aPsepOtUf92fqDL-@pks.im> <CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
 <aP_gy-Rj8MI7zAWd@fruit.crustytoothpaste.net> <xmqq8qgvfyq0.fsf@gitster.g>
In-Reply-To: <xmqq8qgvfyq0.fsf@gitster.g>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 13:11:53 -0600
X-Gm-Features: AWmQ_bn8I_-VVuj8_ciCmGfrqrcKdf4qURsHGC2L8GwNyYE3-d-lhzxc-XsaFI0
Message-ID: <CAH=ZcbDzkACjFsT+z9WJ8MXwivWQczMRhEnV2MOpJ8r3zDc-3Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 10:15=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Given that the stable/trixie was released on August 9th, 2025, we
> still need to go by oldstable/bookworm, which has Rust 1.63, if
> people agree that your rule to decide the floor version is sensible
> (which I would say is OK).

I think that 1.63 should be the minimum that Git supports. I think
1.49 is way too old. It was a bit of a struggle to get cbindgen to
work with 1.63, and I don't know if it will work at all with 1.49.
