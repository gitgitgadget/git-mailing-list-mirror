Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B555A926
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315300; cv=none; b=XEsyKyCYeMDwr587mESZwtmsrvxIv9UlIaLCyLYvaTKDoDTmUKY1JqhO0LsoBcU5Vf+IKiAoFX4IXjgXgWN2m7wUYn96R/GSgrLTwsOcrbZylLHag/2mDZAEqyhw3/0Y5kpW16tsYlg7z3/169tV28fl+sWQDMkqV8UQpdYsGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315300; c=relaxed/simple;
	bh=3/W03U7HfXWMesL8ls8FJQQ7/0jf07Ofnlm0CXsMzTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cni0zifgeQUl/CAF/n+H2LhMaRbkuAzaqn3yf1VtPsWxraJ4xakhsTQ4u5cgeS0pGiB+UasGXtlGzIhJ2lyUKdqQrRGAnmv0+T6Y8DGsUK5Tjw/LeJQY5IjbBu1xDeN2M+WBL8eJOoPpN4hUo3ZGzAKdEFiklSVH8zA058qh5ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kiyH9qNP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kiyH9qNP"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3f25a1713so4997071fa.2
        for <git@vger.kernel.org>; Thu, 22 Aug 2024 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724315297; x=1724920097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS4J/Z7gyLfJeghEYgSnfwMblPCzxHNpCZPquMKOUKQ=;
        b=kiyH9qNPC+OCW+1DvaloWiKzL6tirNX8bLQSXXnrjBrJt4LNRDdmKu2orxgFPxt5Bk
         PGC9EOUDMwdoW3mzu6A8LuJoyb1/4s+uGmyYmLUwyHVoQqnv1huWSpahPccUs2ZaPBfh
         PwwiuYJW2dApKggkuQpLM8zYGnVDDmFKf0iKAGYYb/W7mwFP/1jxwJfkB70J+xpzVLRn
         OzvaOsE6Lt7PWHCZNr6dLOFJnbXwt40JkATA+8tjMn7UEtsWa+m/4C1J9YdTc/dI9wx6
         VCCYdzOWxQS7s98mTOoIFqrQH7P9e+Fa0s75II4tDfGyrYA4oaV1BdinpvzNK/tInt12
         ziDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724315297; x=1724920097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xS4J/Z7gyLfJeghEYgSnfwMblPCzxHNpCZPquMKOUKQ=;
        b=tFgK1j8v8BefvIVUA2QvZUgtdI+rqsElryydBKAqGDhK68OY+edGtbhwMrD+MVTkGS
         lMoqCTAZW2vT6DSkDndLtv+hi0Fp5Y8xWFMxsXVBS24CzvbqkiGkksPdHJfsKD/OhiZU
         /LL7yai4bGhM+f2+pbhFUvzZSUHAFmGeVwrAizzQfalc/kLlP216he6l42rBkwrhSxRZ
         7MCJpyMLLbrfsBbGH3s+mboMdyCFsH4Th+UVTjG15uQb8We/K7F9+7ERTX0RqvKpw1QJ
         zJVL0EWBxNDDJYiJ5+MXycRH5a74Xx94ouMNchR1u7ZdjGJzM3j3Kwg4LghTEXPhli66
         ZkZQ==
X-Gm-Message-State: AOJu0YyNkMeXmgc8EyTLL7WebVxWvVy/HhqV0NacwegnMNcuffnmT7cS
	I1VYLgazI3v+iIxpD2wnyI4mYcJd2fSKLYR2P8+PQgve3fM/k6jSIB7xMen3Y/7PDPk7S9R9ULh
	clFTtiwBy1cLC0zTDnHFRF/FQJefAVH3twBWcOhLp2WqshT+4jv8=
X-Google-Smtp-Source: AGHT+IF6NtU3z8La2mOD6XsM54CrzLUgwOyMhY3DKPTdm7LSKpTqVYVU2JakuKOxrbFoVSIrJhkQ3ziTUtVQd7t4fpc=
X-Received: by 2002:a2e:a550:0:b0:2ee:d5c3:388b with SMTP id
 38308e7fff4ca-2f3f8953025mr29585681fa.39.1724315296451; Thu, 22 Aug 2024
 01:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20240802073143.56731-2-hanyang.tony@bytedance.com> <xmqq4j82euvr.fsf@gitster.g>
 <CAG1j3zEQh3xujrU3tGOftwvCZ+d9RjvMHw8v4W3dqd3DsiGCUQ@mail.gmail.com> <xmqqo75x67v7.fsf@gitster.g>
In-Reply-To: <xmqqo75x67v7.fsf@gitster.g>
From: =?UTF-8?B?6Z+p5Luw?= <hanyang.tony@bytedance.com>
Date: Thu, 22 Aug 2024 16:28:02 +0800
Message-ID: <CAG1j3zHKic1DQr-M2nS6Qjp=DV5B90guNbP-PgQkxY2e3XtK8g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/1] revision: don't set parents as
 uninteresting if exclude promisor objects
To: Junio C Hamano <gitster@pobox.com>, Jonathan Tan <jonathantanmy@google.com>
Cc: git <git@vger.kernel.org>, Jeff Hostetler <jeffhostetler@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 12:09=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
> Perhaps another simpler approach may be to use is_promisor_object()
> function and get rid of this initial marking of these objects in
> prepare_revision_walk() with the for_each_packed_object() loop,
> which abuses the UNINTERESTING bit.  The feature wants to exclude
> objects contained in these packs, but does not want to exclude
> objects that are referred to and outside of these packs, so
> UNINTERESTING bit whose natural behaviour is to propagate down the
> history is a very bad fit for it.  We may be able to lose a lot of
> existing code paths that say "if exclude_promisor_objects then do
> this", and filter objects out with "is_promisor_object()" at the
> output phase near get_revision().

I tried to go down this route. I removed the for_each_packed_object()
loop and filter promisor commits in get_revision_1() instead.
However, this only filtered promisor commits, not promisor trees and
objects. A combined approach would be keeping the
for_each_packed_object() loop, but only mark non-commit objects
as UNINTERESTING there, and filter promisor commits in
get_revision()?
