Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EEA2B9D4
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720433353; cv=none; b=IO12Yh3m5SDPNeTclQAQelsIBZwHcamGizcUKgriq3+BdkhJmAiXB6c/7ZPiFxhpUb5OYCggdn+cOUNHMCMnO2wB1SfyaO6VsjgQOW73z6w/me4RGjxa0e+4W51uGa8DAwVr+XtQewGvCpA/miJIs1mKPnH4/M9smsQ8dql8SNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720433353; c=relaxed/simple;
	bh=1t5YSt8kw/WRTBf0ZhmxamUCJY/e55Ong3gAum3Abyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/02Q0gZN8V6PkCzZQtdhcW/twMwXZUS9m915o0B21IYyH1o6cIaNNd34E98LPEQXrMEpTeXiHf2u0wrJAwwEptmIR8WmjL77R/Ys5IZM+UxmbwtI56LZdBZR8+EIrIsDgaQ7y9wqbBD+8XJDELhROjX3JalGcr2xQJO+nRpuGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dID7qLYJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dID7qLYJ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58b5f7bf3edso2148192a12.0
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 03:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720433350; x=1721038150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t5YSt8kw/WRTBf0ZhmxamUCJY/e55Ong3gAum3Abyk=;
        b=dID7qLYJJKNGAypJxPo+AVS7U0b7Ub/7rYIxkwPlUiNR5sVYNCXGSRiri3D8bWzoit
         wzGCq1pQi4rtAv9dwj8sKmF/Gg1c5laUfKZhtxeQh0CDi5nb4pIItU2Xxbgjc1iro0CG
         s0WDL08qdh71ULX62dUbTHRglzwQyYntDLOO/O+KPErvAKRtg3faPTzFftSepwCrZYN0
         oRvXUesJ1v4ZXn9ueJz903r326w8Qc9kjCrmgEUUpvuzruxDC2840Lz+J7Et5XhGE2gF
         Xn++NOReMHEqzEbT6LtgAUhcsYK6XlznX0af9svpCZneKYhvo80QhasH8VisWdZ2CfFD
         5yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720433350; x=1721038150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1t5YSt8kw/WRTBf0ZhmxamUCJY/e55Ong3gAum3Abyk=;
        b=YCCeZIjvKBh7xOmWBAje2iwzvwAugEnNoGYt3N/2hewEdi6quJyDYURFtJrYHhPVtJ
         ZaVOnvtu8oze3Zxp7woBtBU/6UOd0z3QfjFWRVtm8uRKV8gjn7vY+GX+O+zMSmcF4xK7
         vKHc3kRtDx7ekuqh/tJz3/IvIgWiU1xBxX18bHhDthjc5kR+3RybbiUtUbu2jR5tnm4e
         ierw+jTpyUEmiNpLTgPFIo271YrNIUFKsvmmuJcepFOMyMWImSPxAe+vBBeZy66JBgL3
         q4YaQYo6ZejBtIJXHgXTqNzgTSQF1YsPiz6B/40vycCa6+Q4eM39N3mk2ViEqRUzEl+/
         14DA==
X-Gm-Message-State: AOJu0Yy4S+M0DcyYFp5nLDnpdwOi0Vu748oFd50cVB2XwEsafuwLhZSO
	x5jbKwwhAwCXNQ1wxLtKEuLMtyZ8eWtsRkoKhweK4z3peYX+F4dNMnRXkidkb+XJu+4S37yyerY
	Glp16fW0pKXH1BSb/l5AMj+UmXiE=
X-Google-Smtp-Source: AGHT+IEN9nQZGWTHCyTypg/bwdPNW3CDfjGVHTio1YLNsO8vuZg4ZtV2aifa2yveg1h8XjGxxYGgVlXw0H/FQnY7GHA=
X-Received: by 2002:a05:6402:50c6:b0:57d:1696:fd14 with SMTP id
 4fb4d7f45d1cf-58e5994e06bmr10389861a12.8.1720433349912; Mon, 08 Jul 2024
 03:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708092317.267915-1-karthik.188@gmail.com> <20240708092317.267915-2-karthik.188@gmail.com>
In-Reply-To: <20240708092317.267915-2-karthik.188@gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Mon, 8 Jul 2024 03:08:58 -0700
Message-ID: <CAPx1GvfExeYEwStqDDeyuTW02Yi_n9Php-t-T6waadTgyk-XSg@mail.gmail.com>
Subject: Re: [PATCH 1/8] clang-format: indent preprocessor directives after hash
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, chriscool@tuxfamily.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:23=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
> Let's pick the former and add 'IndentPPDirectives: AfterHash' value to
> our '.clang-format'. There is no clear reason to pick one over the
> other, but it would definitely be nicer to be consistent.

There is one extremely weak technical reason to pick "# in left column",
which is: some ancient C compilers required it. I don't think any modern
ones do.

Chris
