Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA1539C
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707558503; cv=none; b=dZxZ5zF4GiZuIrxmlrwoXRqbsb/F7VJkvWoVY4PZOFWaGkmkZdTV8zPnSvxDD+uAamHwziduy7nkMKZTKJSvOOs7So/toyf6rjBfbl99SXxklYrJM2J1hJE05xJeI/6xZ7uGLsfTtLGq/Yq3E/JLIL+r1u4EEiEPRkV+AA7Xrwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707558503; c=relaxed/simple;
	bh=EoxxQDgG1dxZBw2skSPYnLe/3GgwbTcGhgXX56o0+Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcpOPRVubHlGVy0suDTrQy1/ng3yIpr2jYQjSREKDEfT09NsGPd/Gz6kGahHs+su+BPMl766QFLb6cA4b5V5X/Wbe7T3gfqLONbtqELtxlcFQTUzZ8nTiTEg+Zw6W0vn7ovK+xDjVr3r3Ce3v+wDwHYoOt3JeIWSZJNLUQk8inQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLHcEMLu; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLHcEMLu"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-558f523c072so2593413a12.2
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 01:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707558500; x=1708163300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NULxlQyu0yeN92lyqITRFmKJ8NGtgTErqyCJwSnrT0=;
        b=ZLHcEMLu3DJOL6jpn8a8AGmgaIXEEmLXBK36/9S7mzSmgt8oKtkKUz9c/kp5xW96P/
         +b146eXY3E+rwdB1w/DS/K4YePnmXtpJbirJ+6ysuJV7ASTc0IzBHA9cj/sWclYVm8Mt
         aatYwWNFbE80KedS9+xQfBPz79GiqSivvvBtq2x/74iv0tyfcUUKX55RfL2NUlvGnjcM
         dRHBtB9sKLCXQB1r1079hm2rlOEfVf54JbSjyNNOzSPUqW9YTJPLQp575aNO/rlfsfw/
         Fysdb1BndPXhyGlFh4hKdRj8leCHQM641J1JiA4QuPN5ALlKukOlFAUkrn/7hE2Jlkl/
         PfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707558500; x=1708163300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NULxlQyu0yeN92lyqITRFmKJ8NGtgTErqyCJwSnrT0=;
        b=VTilDkvWEN+h7wwEMTTkEGQl+2y9kRii1x3V0v7GoWnp+WZ6955f9omyDShxABHwvU
         rqEMlhtS5yeBPubclfYOzIBKOWm7u9nF4cztCKCZHie4nmB/uLj14ZsDZn9VTF1kkaqe
         lkk5hm4DkXSN+JVH/Z7ZYKVYGNzkgE4o86z1z3NhsaTz/eN5W/3tpCW4HhVGBPA2wRvr
         lzTZMaZbFsw+++Fp72u+AopO6aFqKhLfY+Bg+ww4dRgCDlbm1hQ8i0FPUzICkT653VWo
         UmUdGvfi01t2Cp/JR73tQ6zAIo286bmOQUWuEUEku6ERo0dUe7IpegafTE6kCGurRHZ+
         4vvw==
X-Gm-Message-State: AOJu0YwyKFTrJf8sG5HlCjp/e0GoUhp7JmNB6XRbt8ARmamP5vj/N7wg
	WYPdeDqBf+bBlbWuFRkCabt5FkWS9QYoDkN/wBWe0aWNoUbvFbX6PHMcCJ8KQ4KkPwWv48ZrhIE
	/yyRuNbmV+Ydk86UhT63NU3ItpPQQytgQlPc=
X-Google-Smtp-Source: AGHT+IEGBj5dP+QvPUW2vBSxz62jtNYHxWH2dyf8tIG5ZJJXGkhWp/oE/aBB+MybEa9q0ZgjfkpK2Fjh8Kr8yg109vY=
X-Received: by 2002:a17:906:d96f:b0:a35:b808:8f1d with SMTP id
 rp15-20020a170906d96f00b00a35b8088f1dmr1247355ejb.67.1707558499632; Sat, 10
 Feb 2024 01:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8P189MB21977ACC4866D9836DA29082BC4B2@AS8P189MB2197.EURP189.PROD.OUTLOOK.COM>
 <76688ed2cc20031d70823d9f5d214f42b3bd1409.1707501064.git.code@khaugsbakk.name>
 <19119aa6-9a8c-44c6-af79-0ea6a8bcb181@app.fastmail.com>
In-Reply-To: <19119aa6-9a8c-44c6-af79-0ea6a8bcb181@app.fastmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Sat, 10 Feb 2024 01:48:08 -0800
Message-ID: <CAPx1GvdDvmBmvoktd7onB4mSzikKf4eWVWnrzrn8c8Y1RcRgsA@mail.gmail.com>
Subject: Re: [PATCH] column: disallow negative padding
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, Tiago Pascoal <tiago@pascoal.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 1:46=E2=80=AFAM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
> I forgot tests.

You presumably also wanted the `_` here for gettext-ing:

> +               die("%s: argument must be a non-negative integer", "paddi=
ng");

Chris
