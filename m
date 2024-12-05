Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD511D47C6
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 10:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394864; cv=none; b=niyDSFMzb+fKPIbXpfIWSg2kaA/tAwAfLyOEBiIixn/Ot3cnW1jdOif2SwVtgFQU1vB6ve7R/urHBEYKXF0ztm4zblN4cYLI9ZXbxIMGWSUKj+qZUsj1fXPZTjCe/zjDUqwKEvcxnqP/LoKUM86vXPkpVqJOVaMwrSrSvb3YnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394864; c=relaxed/simple;
	bh=3793Lwq5ue6N3iJ6QeCE0ZH2kNMf3P5oQxf9wortLKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wen44HDGJe/71uK+iRT+wv8GvL8Mx2RPbpnkd9csPGvKN8xgtRRmoZ4gKmHkcFZTWXuM5ghYL7NL5/VZ+XsnqU8rfkIjbOW1THJbak9uyojjQQxhWe4Q2grBaZ+JTxFeApsTe6lOHv/Co15AE+m8rC7O6raVuYXX6Y3jKut0tVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHRaVsiO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHRaVsiO"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d0d71d7f00so1098892a12.3
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 02:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733394861; x=1733999661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3793Lwq5ue6N3iJ6QeCE0ZH2kNMf3P5oQxf9wortLKQ=;
        b=hHRaVsiOte8UXiy3ZroKi6XE7hqEiGZAFYqcCYwQovKsCfq+e1fZZcUGisc3oKAV4V
         ZfS907hx593MpVfWatnOB+GNbdWJuQId3/alG8C+cDsub1uYLNKjOJdCWXoI5y3fjgg4
         2HjYbcPQ/Mtozho4CyeNLPtN9WQdjYCf5CruBryrqJ26qUzyG6B68yunpVwJ9TzmYwgD
         jqypIoBtd4Fv/ifpVwv6JycDwxpIc9j1S3/YWlnrnQWhvLiW5aK9fUKDzTFEG0K4ahyX
         2iaLzMOJ1UCcdOsYB3iNmdwUmmp2/6yyObeaXwk5IzNIQLoE0I6xhawfZpSW7vSvOijE
         ce7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733394861; x=1733999661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3793Lwq5ue6N3iJ6QeCE0ZH2kNMf3P5oQxf9wortLKQ=;
        b=s2Cf2o6oH2hgXwsQCOQ4C4WbV0WE4+KGC6tTqLf1vHDwU3j0RHn70YGxfI7MSwYac2
         CzCpRlnuc14F/dW6wpYZKtelh5rcLO55e3TSEZ3qnf3lYM9vk3AeyWafCUxbOjyz2KT9
         sQKBzhyaVNGaIHiXlPWbr2AJxIwzY6KRexVsBqSJ+uD3Tku7uNjygVFvElJoRGjLpT81
         stBhKcp8WdAZ1SWhEyedqpTFGw2zWhtZzMKxF6M9uyxYnHYz+CEk5nSa61Vz1MoipN6u
         vSgwcU1SQ0d/jKpQUG80taBImRvdRSAqQXCQcPj/nT39bFCzbkApGDDcNLoMkiR3w55n
         es2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW0HWmIVXzn5VZaKdAJwL06x3DGURtfAktbmzju5ZYUH4ioMngMQh9jjSAHE5x0AgacpzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7gfZWRwYCGzgVisqLitxtuXn7+Ahsxuz3maxRckig4vLxWmsP
	W3APxzJMPrszxHmDI88K+xwWYYwgFkdlu5I5uuJb49OZgWMZgCG5cEGZbxRmbuD2tlyFFuQg1Wc
	VuC+KbCmnr3m3lbX06sroIiTNXbE=
X-Gm-Gg: ASbGncsHxy7Zi6AJSXTNh6MNyO/Tl/svfydVtn6OteD4YPd5v2s4Yn1KCVxkMC3P5kk
	l+s7FHezK2oQe1VUc2ZMExnO7N9oc8kIngw==
X-Google-Smtp-Source: AGHT+IHt5+To6aRx++IAolVXW6/IdflGUNyNWT+bdzE5Dij9jqSGKDjns/lUnCpsNVwefmPI6vMPaXtoDnqG87lNdA4=
X-Received: by 2002:aa7:da01:0:b0:5d1:22c2:6c56 with SMTP id
 4fb4d7f45d1cf-5d122c26db8mr3150621a12.17.1733394860265; Thu, 05 Dec 2024
 02:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20241125053616.25170-1-eric.peijian@gmail.com> <20241125053616.25170-7-eric.peijian@gmail.com>
 <Z0RIrw2PszaY2Way@pks.im> <CAN2LT1C6mZrhWiK8x27yOPjRt=v8f_jnYwc6g_LtxhVGy3bQaQ@mail.gmail.com>
 <Z1F3STEa_bsE82Cc@pks.im>
In-Reply-To: <Z1F3STEa_bsE82Cc@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 5 Dec 2024 11:34:08 +0100
Message-ID: <CAP8UFD1BprG24AmZH2Y9pRJRpwBbq3qJ+qZR4-kFyHn5rRCGnw@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] cat-file: add remote-object-info to batch-command
To: Patrick Steinhardt <ps@pks.im>
Cc: Peijian Ju <eric.peijian@gmail.com>, git@vger.kernel.org, calvinwan@google.com, 
	jonathantanmy@google.com, chriscool@tuxfamily.org, karthik.188@gmail.com, 
	toon@iotcl.com, jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 10:52=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Tue, Dec 03, 2024 at 02:23:01PM -0500, Peijian Ju wrote:
> > No, this isn=E2=80=99t stale. As I mentioned in my response to Junio in
> > https://lore.kernel.org/git/CAN2LT1Cmsw3RB1kbRBvoeLs8WaQeZWqrG96EQfMkMe=
_jdKaO4g@mail.gmail.com/,
> > adding type support is planned for the next patch series. Based on the
> > documentation at https://git-scm.com/docs/protocol-v2#_object_info, it
> > seems type isn=E2=80=99t yet supported on the server side either. My pl=
an is
> > to implement the logic for both server and client in the next series.
> >
> > Unless the reviewers feel strongly that this must be included now, I=E2=
=80=99d
> > prefer to stick to the original plan.
>
> The problem is that you cannot introduce a different format first and
> then change it in a subsequent patch series because that would be a
> backwards-incompatible change. So if the follow-up patch series would
> implement that you cannot revert back to the default format, and
> consequently the behaviour would now be inconsistent with the non-remote
> case without a good reason.

The doc added with this patch clearly says that the default format is
very likely to change in the future and that users should not rely on
it. Also there are very simple ways for users (who are likely to be
very advanced users) to use a custom format instead of the default
format.

If we always reject any backward-incompatible change, even on features
we have clearly marked as experimental or temporary, then it means
there is no point in marking features as experimental or temporary in
the docs, and it will make developing new features more difficult as
we will likely have to spend a lot of time to get it right the first
time instead developing them organically. As we will likely fail in
some cases to get it right the first time, it will mean more things we
will have to redo in other ways and more things we will have to
deprecate and eventually remove, which will be bad for backward
compatibility anyway.
