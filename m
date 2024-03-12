Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152CB7A730
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281637; cv=none; b=rCLmRlp+epBHDlLj/yGXcXGL598kxMVkXUC6OcyPYxBRv9CQeI3iTlTG/hKMn2SP3Abs0IdMsHJRpdwlYG0sH5PcF1QXYPkQvCPaoBkhtYzAyAcoWgQ41VNRGl4rWUmfczMtWzJW7pXw9bJc3oReC4tA1GfT6A23SQ5uP8sBTGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281637; c=relaxed/simple;
	bh=7wkO+IFSjNQHEoYgTaWhj5M6ZzFpPJkEdGbS77j10ZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hntPeIib8NAHqsenclXH2mZrEujXogBirJTgvnoPgZHEJ3/GhxO0h40M0/sncjrSC0GZvNAW/vMNWE3pC5tlCkPcVp4w7QfWVIv8vhOEEtdNLWs2stIDC5nxSUh08BO0iOeaiRQGhl9iFNEbLMYmYu5kv+DwOnNB3gntxIV8lUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkQdGhoR; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkQdGhoR"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d24a727f78so5487731fa.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 15:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710281634; x=1710886434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDvyY09bC9TN+mUtKrGSfSGwMWz7fVCvzQbDPUeSbt8=;
        b=dkQdGhoRu/Zp52QgBOqrPT5CBi2UY8XLPoiQYPQ2IsszGw47yXQp91+HmKJOANDfH6
         YY1J7+zPAToC97zrqxIqv6j7aRujw/X6xW4d8IRQMk0PnxPI2U8HvKiIEeGYpmRd+NJc
         EgZmX2dEu7uNQ1hpOQ4EEyv0tE8q/SEMTBY8+d7SJTeCzlUfjJ2xhJ0X9hggVWU+0qD4
         3VYfD88d81syxNrPKFNTKeS7hSm0cNsiL9lq811lxdJ4oAGnKxSs6EKbrVEPSwJndXF0
         uSq/VHkVBfJUSkMny2lrmez76EfERBIvtwdwgjAbAvf+hOUQydx1dYq5Arns/1TI6+Zo
         3Rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710281634; x=1710886434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDvyY09bC9TN+mUtKrGSfSGwMWz7fVCvzQbDPUeSbt8=;
        b=MJrLjhqENoxf7qBvcRRsuRra5/DCq7KgFYeaarX9vvt4ItCX++sKgWUxgbHTfV/7Jz
         YBOKYLM0NRvPiqbify5EgbhH5344LdXKCK5Pf56VlHPxNJ/7VHi95oUEd+r7dATC8XZH
         uYKmyJRf/RMzj4ma2GO2ERiGN3iuvi2CgbYr57LkvErsmyj7ZpO4qbW5yXWM7c+kK3ac
         s4gtuDIu1XhJze+3Z1t9mjyTkcVzBKzbp3C7DoEEKC9WL46GPmtEiZpeLQK0zCqLHRB0
         3qdbCU5s1h1JPVrmNklqNgF4DzVa5XaDzb5GlLgbPXbbH+rSihQWybnoxymvd+U7QHff
         AsLg==
X-Forwarded-Encrypted: i=1; AJvYcCUh03bXrlKvaEY8PoXQqwcWon2vWF1Qd1S+bkaIT2CHW1FCX02Gv8U2CKojq9UiSyYS5aHP5VZDr+J0d8Qamdxe0D2f
X-Gm-Message-State: AOJu0YxDzP/dfkBV3K7aGNzvNl4/n6fQ3e293DQFOt3ca7ihxArxsYCA
	0pXQoHlcOzvL7jSSg5HdO6YGu9Qm3GB+4WyZoIDe2vFasXDrNDbY09W0Kn06YhTnS/cGOrhKM/u
	jT0JmikvMh4N1KPIiCc96VO3Es1GIeVqYyPe20ksYu9htQnr+tA==
X-Google-Smtp-Source: AGHT+IE1fjqy4Nku8h9N5FouipVC1K/qPy63U5vS5jng8VrCDfl8QxdX5CSHEt7LOOvl2krNqC7+vw+T8ToKZPkS7g0=
X-Received: by 2002:a19:ad45:0:b0:513:c327:212f with SMTP id
 s5-20020a19ad45000000b00513c327212fmr1453927lfd.19.1710281634037; Tue, 12 Mar
 2024 15:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305012112.1598053-2-atneya@google.com> <20240305012112.1598053-4-atneya@google.com>
 <xmqqwmqg38u2.fsf@gitster.g> <xmqqsf141pf5.fsf@gitster.g> <20240306012323.GA3817803@coredump.intra.peff.net>
In-Reply-To: <20240306012323.GA3817803@coredump.intra.peff.net>
From: Atneya Nair <atneya@google.com>
Date: Tue, 12 Mar 2024 15:13:16 -0700
Message-ID: <CA+D9mTEyYshL5e_G9AN=6s_zhbtjQNh+_=a9+Y2J2iLQACFeHQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] Make ce_compare_gitlink thread-safe
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, jeffhost@microsoft.com, 
	me@ttaylorr.com, nasamuffin@google.com, Tanay Abhra <tanayabh@gmail.com>, 
	Glen Choo <glencbz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 5:23=E2=80=AFPM Jeff King <peff@peff.net> wrote:

> And I think that may be the case here. The "kvi" struct itself is local
> to do_config_from(). But when we load the caching configset, we do so in
> configset_add_value() which makes a shallow copy of the kvi struct. And
> then that shallow copy may live on and be accessed with further calls to
> git_config().

I missed the shallow copy of kvi in do_config_from. Unfortunately, we also
pass this back into a callback function, and although it is often not used,
changing the code to be more precise about string ownership here seems
non-trivial.

>
> though probably an actual kvi_copy() function would be less horrible.
>
> A few other things to note, looking at this code:
>
>   - isn't kvi->path in the same boat? We do not duplicate it at all, so
>     it seems like the shallow copy made in the configset could cause a
>     user-after-free.

The situation with path seems to indicate that indeed ownership is correctl=
y
handled up the call-stack (i.e. the config_source owns the file/path string=
s),
and these strings are valid for the duration of the shallow copies through =
the
call-graph. But, the fact that filename in particular is interned may indic=
ate
that the behavior of leaking the string to static lifetime is used by
a caller at
some point.

>     But it possibly could make sense to have the configset own a single
>     duplicate string, and then let the kvi structs it holds point to
>     that string. But IMHO all of this should be details of the configset
>     code, and the main config-iteration code should not have to worry
>     about this at all. I.e., I think kvi_from_source() should not be
>     duplicating anything in the first place.
>
> -Peff

Based on this discussion, I think the cleanest solution is a lock on
the strintern hashmap. I originally wanted to avoid adding locking, since m=
ost
call-paths are single threaded, and I thought we were only using the
string locally.
However, copying the string is more expensive and potentially intrusive to =
many
call-sites, and it is much more difficult to reason about the correctness o=
f the
change, so I think adding a lock is preferable. I'll switch to that in
v2 along with the
more descriptive commit message.
