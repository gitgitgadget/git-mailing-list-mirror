Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCD02CA4
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711270850; cv=none; b=Wt9nFl3C1rejEmWBvNA3gEICHvNf4ObouyNgaueYLyoapBNh9C4AbACsZ8Vu9UaQFUxyFnKjriylsckQ/T7WGw3Ba6YrhHkH8XY162iCUzjURTR0MofmqGr7xoLC2j0cgmcmxn8lIJM5ACbkFMAiMg2P1qFp5082gSATH6CC1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711270850; c=relaxed/simple;
	bh=g/vNqrp+x3kDiKTwjDiIyy1ygBA6/fNTWLcQabxN0V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e5Buo9spD9AMDuLpR33eSHK094n2PxoPaL59hpyKhjvYEKE4h75Q1Er1zuUlADjh5b96rYHFza8TZpvRg2qN1YnARLeaBWHkZKz9xYuEDMNmB2rSfi6suhR/Z3H0o/1Yi5rOI0i8iMILFkFZU5/J5GHTQGdQZGtTCapPGYy6dnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im502W6O; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im502W6O"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46ba938de0so467260266b.3
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711270847; x=1711875647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3wgowMHgNBtzqP4SVavD0cVJxmOWWZpIqqfwjws/II=;
        b=im502W6OSd1ZhTuk6ta6SK9dlAlI0nyI939LJ3eR7ZJw3LN+TmlK0K0P9AVsrc+7Xj
         KLSY0yOfQ/s/OcdTfITYt8AnAXHFwoDfQ0r+Yz/tAy7snmC/wxa4MOMgbs+3W0ZVdLyO
         AivX80I846Ls2ObniIPn3/14AlUKrVV4bA1OmNHiQdh4bP9VkyZ2IpcJ/BUDTgMngKFx
         l3dWxSIrWDYpjJGYMCmt3Tt4pYAI+rfui9aDcJsMslsIVk27BIdvGCTfigGpSmPy3HO0
         i2uCuxkwoX/bxJ71UO8guvEq6+OETZAh2P2xkOoolnTg7MjX8sKwS/9izPLLkEnVXvAo
         KdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711270847; x=1711875647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3wgowMHgNBtzqP4SVavD0cVJxmOWWZpIqqfwjws/II=;
        b=WeNIuSXPaCAbZb01S2e7dPLIn2Yf1PqvAxrEqFJvMR1f+jv1dYU7jyg9F1z+CzhbHu
         AtWVUFooos4iXoH2kriMvJGaqJOjAr41tTJxirlNjuNM3WTq2ol6Fn9csplK53dgBrtS
         XuGFFU2zllqyV5zwZN7xpapOpdxSxz18sueCi8Fmk79WKz+rjc7AQ8kM4VCCrsT9ydRd
         uFLRckx6xKGIGJ2xZYHP7cY2NjmJDJZXWUQq6sjyr4s3ZxsyBa2tXNQOXV/GSq1Pdx83
         fvhsq4c4twSAn6MEE6s2SRam7TCNsmgc+7a7dvCOXbuFkQVnVRVDRpBYzGI3WugDrzwi
         DsMQ==
X-Gm-Message-State: AOJu0YxMLMtULp22eTAhyg9oEdjtAuwjvt4rqxP8LI8xKshHrFyzMChS
	NSvgZ5IjeEGR86x5ytXqQvWTcgO/NLUUg6r2l4XYDxREUxxv1xuSXJhw8D3ADLhCLmItbc8uWOz
	iv+069HFjsWOpPI8nBl8MhoQU1TjRWqcD
X-Google-Smtp-Source: AGHT+IEl2B8XRui45ABjN8GNKfCo103IeJqzeSe+kgm7xfXv7R3OLmUMjFVTv9URK1bvNi2KxMZNNKALyTPftqiz82A=
X-Received: by 2002:a17:906:53da:b0:a46:181f:c1c3 with SMTP id
 p26-20020a17090653da00b00a46181fc1c3mr2590545ejo.70.1711270847190; Sun, 24
 Mar 2024 02:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>
In-Reply-To: <27cdcde7-74bc-4ee8-bc84-9a6046292cae@web.de>
From: Chris Torek <chris.torek@gmail.com>
Date: Sun, 24 Mar 2024 02:00:35 -0700
Message-ID: <CAPx1GveKUL1nexRQDYueAVU7G0vp+JzB=5yUf4r4eoRjU49Jcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] factor out strbuf_expand_bad_format()
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Minor:

On Sun, Mar 24, 2024 at 1:00=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
> @@ -308,8 +301,7 @@ static void show_ce_fmt(struct repository *repo, cons=
t struct cache_entry *ce,
>                 else if (skip_prefix(format, "(path)", &format))
>                         write_name_to_buf(&sb, fullname);
>                 else
> -                       die(_("bad ls-files format: %%%.*s"),
> -                           (int)(end - format + 1), format);
> +                       strbuf_expand_bad_format(format, "ls-format");

This last string constant is clearly supposed to be "ls-files".

Chris
