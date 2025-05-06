Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F774B1E5D
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746517460; cv=none; b=URmEc2Nu1/Yr63NUPt5YIHdaI4fL8KKtRqJehr+dd6hzLkgSFK+skED5ukVY7uuSnbbzHYb/+Nf+cUQNn11qNIxrJjaCWdNJwfgZVv0HCR8TsgISFAFzEr/W4AfXReBn5jXgeIdBVqFlul8r4AG2mFKBkUuzh6eb/4T5SZrNrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746517460; c=relaxed/simple;
	bh=nCduZPrMg+bb1ua2zsSRTj6GT2BtuDqbNo1NaWkOWBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrmvPELEEODjxVMoOEQ2NCHhtqsVLKODOzcMMm6zu9tQTRVnbaIeZuZ5ragftZ7MWs9V3i/mg5BjFukYxW0N2pMAnZlI63925yT7yVN2Upm8Qwl7eQ48XrcOGxJFVzijvXuTmRbsj9NoDHoX7rpWwM6lAkp4Ir+FnzZF2CR2/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2Al/NCo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Al/NCo"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so963758666b.3
        for <git@vger.kernel.org>; Tue, 06 May 2025 00:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746517457; x=1747122257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCduZPrMg+bb1ua2zsSRTj6GT2BtuDqbNo1NaWkOWBE=;
        b=J2Al/NCoffLT8inest2Sbzs/yWplAKRX6Y/780zSHn8fpQ6Orr5fo8OwBRTm3pgxTq
         Btr7u/aoP8hZ2sXNN6yFiJQnbiPHanemuJ9ZtaskS0PMVgZEvBmWDRwlYbAYWE8HCfh+
         C58dYMGd9GByxcet2OgLI1PUsuUeaIA46va/OneNROD9cdXSUFAAIo3pX4zQ1PWWUFnI
         MNpGvyrAxqt6SoQRyeuQ3JxWTs3umAPL8A+6DaFoMEuDtQsqI12dcsfwCrzfpUv1P5W3
         u9xQSwj+wLVw3bx6KdONrPQ5czH6D3khoVZnEyRU1iBY0cRKs+SMt325pgDFSYUQiZtp
         gI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746517457; x=1747122257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCduZPrMg+bb1ua2zsSRTj6GT2BtuDqbNo1NaWkOWBE=;
        b=nBVJKFVxRyTs1iga1b7wO6S8ndJMrZrHkiS/LhqiOuErFzRUifOF4hUPtTJvGQhuT4
         e5lpW0N1LQEP7h7knXNr9Y/ptCByzWht6z7cEPvlZrmIObnipwzuX6JiK57ViG6pcTwl
         ggbRmn4jO3hke8jURwyeLJfbQK+16AcVWGyvvp0Du8TjnA4LNIfXqJLN9tbyP3VUTOXI
         8d+sHkBs8BY6hmONrv5TQMoecbzBbLyca3fqUUED2LBPhdYFmalxIOIQ45zme5ZXX+tG
         UhCIskrPCGP4n6bTqqXEv9uJ4HskxBxEkNRR4Eqz9UBrg7hHJkBOYQk7Htnfc5VFh822
         TqCQ==
X-Gm-Message-State: AOJu0Yz4wOmnHev69X891l0qUK5shk9/y+iledcD62o/1psZh9Mp9gbj
	v3pRgfbe22nbMwxO2MZdnU/Xh3i2ytA5lOwABPqarWG0S01weNcKC7DtEZJ+Mlgk0atUiR1n0cc
	lJ8WfgmYiv/r1+aiCiwuOzPj/+Qs=
X-Gm-Gg: ASbGncsUNg0n4TuSNb+Bjy4Wj1nyEQLRYZc+9CNZECBtnlMcHJ+pEuV4oYW9abN7foy
	XbggCDvo5L9ndIT0ZMiIKRrtceEuXJheZsUUXP6HRgPMoxHFxIgIor3FC0BDvcPeZlduZsg8crD
	hCnktryeGdVGl3WDZpKs651pTZI1uVbD9n9edKUhmcpbn9FvwKVwxzIw==
X-Google-Smtp-Source: AGHT+IEJTMwMu1JWv7E+Q+3KE1umIlhyqMNkH7RPxhxX6VXc7QmeUiW+Vfqciwb72c1SPyOI+4zt4otYzt/MjHESybA=
X-Received: by 2002:a17:907:da7:b0:ad1:825f:e326 with SMTP id
 a640c23a62f3a-ad1d355a5fcmr191459066b.52.1746517456439; Tue, 06 May 2025
 00:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250505-pks-maintenance-missing-tasks-v4-0-141f4df906a1@pks.im> <20250505-pks-maintenance-missing-tasks-v4-2-141f4df906a1@pks.im>
In-Reply-To: <20250505-pks-maintenance-missing-tasks-v4-2-141f4df906a1@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 6 May 2025 09:44:03 +0200
X-Gm-Features: ATxdqUFJNT2sECC9TovxIkgg1h8zpi2grh1dS8kbGldgXtua3Zj8QkLll6MwkSY
Message-ID: <CAP8UFD2BDv=kp7W6w=J00iRAj-Jqz_EjHGfH_YpNTEWC2a82QA@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] builtin/gc: remove global variables where it
 trivial to do
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 5, 2025 at 10:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> We use a couple of global variables to assemble command line arguments
> for subprocesses we execute in git-gc(1). All of these variables except
> the one for git-repack(1) are only used in a single place though, so
> they don't really add anything but confusion.
>
> Remove those variables.

About the commit message it seems to me that it's missing "is", so maybe:

"builtin/gc: remove global variables where it's trivial to do"

or just:

"builtin/gc: remove global variables where trivial to do"

?
