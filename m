Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01558234973
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878992; cv=none; b=VB6jtzs7tmGZELYbITQx0VNLfxh4uX5Iq8OKlP+bhHTHI36EAD3bleHw2U9X2KQ1+U57R0xYRK1BmdJmWIkYu+/B7fSREZb2ndvO2qSGeB9DKapnnewWSMaE1o2IN0MU9U33NGg+2xuJRarMrcE3iCYiztevo1VsDnG0dw7Xt10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878992; c=relaxed/simple;
	bh=B1SWjPoV7uZmd2Ozc2DzuGudPOAf0i0wQk7KC4P1uJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GdeHGhzq1JcaGGFzvRss38medG76Qh5F1vVR+dZHnic9I6NR9a0wOvjs+vNTEJ0X3l390frHmo8xqu6nno+YnHZLn3YItvKHkzhBfXGX4dlbgCkqZeRbj48GH494aw2WViqcZowTaQlIqK9IkXbSFUj5Bi5pdeTYksnOz7R3H30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxqXzmH6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxqXzmH6"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso7525456a12.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 03:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739878988; x=1740483788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRhTl8XJg06NbEkYpVEhGCXb5Fy0PG/py621b5hud1o=;
        b=RxqXzmH6AUI3P21Hwua7s1YQiG7lDouTpkfqqjOLJok1MfEu9WBnTeBq/jAQhZXhC1
         MI6wbmRSwcIlGzTOTUVt5K6BN26lQrgoeA9xTQ9j3XpFDklcV6Yw7gwxC3NpLQucdg8Y
         mt34Q8Hk0vzT1mklCbAWBwr2hHCgNxwzSnfR+HAddjV3U0odzOnLoUzLLDUkle4vuJwx
         3h9BEpA2zcWYoNcNacBlIRZhEh9Xe51sWlbl13a+wqTAHU5lVtYO7UAKBWexbpp8PXpN
         Pwx0a7/9nHhSwS7s/cP0jv/FB5/cSk9HTe5gLAnqx860yknt1EKt9RGzLuD6J1ULjwEt
         spNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739878988; x=1740483788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRhTl8XJg06NbEkYpVEhGCXb5Fy0PG/py621b5hud1o=;
        b=nMe6XbXhQpBiOozGDuCg8kMuys8x/yKk8eeXoFuHVZa9rQGIyID07tMpejkUGgm+43
         sSMyI/uwcl4anbYOt/NH1mtDF4FvZo9ZXrPqXH02XfrTBQDwMg9TODV4h0c5mx2n1/cK
         RWPcyYi9rw+Yds5EfVXCUHA1X6Gby+xme8LZprOvA6otjAAI4/RDERDdvezudjIKKFfB
         XB257OcWyQIveFrLbpG9gDxdV2Ayzw5G8I2Hs/PIMeU47w3NmjIsLGtJ9D4l8nIt6utv
         +xOD9U81SC48fWlYV2uU9WuD4JeUMkjja7SCxT36IqNElaYQB3dX7bsN62V6aRFz2nn8
         fs/w==
X-Gm-Message-State: AOJu0YxlLQXhqpMhf8YMigDY7eXRGfLXcQMGF77XqxXMHjHcN1T4rRFv
	USxVRDf05dh4MdDQGJ5tD1LWaQYAlSzFGmY1GoLUz04WVN0T7h71x7zLuX6fmDASzniwSm8m/GQ
	kz2UTOtxGE7c4q4iPXcuEkoNN9cI=
X-Gm-Gg: ASbGncsOLjX+bWM3Gf/IYABPxgRhFKGrG3J/Ae0l0dVnmUGSGoBuTBBqEOo7T0WlzEl
	KVJd5sW9hI8EzokqkLPWsUktwzn4BvQJydqFNx7eSL1pBBwNpCbghCXSxV66jG4KcRgG1k459QU
	o=
X-Google-Smtp-Source: AGHT+IGdl1G1UGE1tpr8DOVVS/gdv+cyCCRzuPtRvMM1VcVTgggoPJgi0NFvnTKZxll9bRWRR00gHTZSnFuLTkS5E5c=
X-Received: by 2002:a05:6402:2385:b0:5e0:49e4:2180 with SMTP id
 4fb4d7f45d1cf-5e049e4233bmr18566369a12.25.1739878988131; Tue, 18 Feb 2025
 03:43:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910163000.1985723-1-christian.couder@gmail.com>
 <20241206124248.160494-1-christian.couder@gmail.com> <20241206124248.160494-6-christian.couder@gmail.com>
 <xmqqjzc7lq60.fsf@gitster.g> <CAP8UFD2Pehtk2=GkjrXga0bqsrUFauYKkPYPWgdRHsoaDvQQDA@mail.gmail.com>
 <xmqqplk8rv85.fsf@gitster.g>
In-Reply-To: <xmqqplk8rv85.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 18 Feb 2025 12:42:55 +0100
X-Gm-Features: AWEUYZneZjpkAraDw--IaztNHBKsz2tElIevMDzQp78BnSxFcG_WtR-VpyIlpBs
Message-ID: <CAP8UFD17H+0nerdYkLB3VROgmU+Wnb6G=Lrd-3f4tM6z=Wv-vw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] doc: add technical design doc for large object promisors
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 7:02=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >> > +In other words, the goal of this document is not to talk about all =
the
> >> > +possible ways to optimize how Git could handle large blobs, but to
> >> > +describe how a LOP based solution could work well and alleviate a
> >> > +number of current issues in the context of Git clients and servers
> >> > +sharing Git objects.
> >>
> >> But if you do not discuss even a single way, and handwave "we'll
> >> have this magical object storage that would solve all the problems
> >> for us", then we cannot really tell if the problem is solved by us,
> >> or by handwaved away by assuming the magical object storage.
> >> We'd need at least one working example.
> >
> > It's not magical object storage. Amazon S3, GCP Bucket and MinIO
> > (which is open source), for example, already exist and are used a lot
> > in the industry.
>
> That's just "we can store bunch of bytes and ask them to be
> retrieved".  What I said about handwaving the presence of magical
> "object storage" is exactly the "optimize how to handle large blobs"
> part.  I agree that we do not need to discuss _ALL_ the possible
> ways.  But without telling what our thoughts on _how_ to use these
> "lower cost and safe by duplication but with high latency" services
> to store our objects efficiently enough to make it practical, I'd
> have to call what we see in the document "magical object storage".

I have added the following:

Even if LOPs are used not very efficiently, they can still be useful
and worth using in some cases because, as we will see in more details
later in this document:

  - they can make it simpler for clients to use promisor remotes and
    therefore avoid fetching a lot of large blobs they might not need
    locally,

  - they can make it significantly cheaper or easier for servers to
    host a significant part of the current repository content, and
    even more to host content with larger blobs or more large blobs
    than currently.

I hope this addresses some of your concerns. I could also talk about
remote helpers and object storage here, but this would be duplicating
the "2) LOPs can use object storage" section. If you think that we
should tell our thoughts about how to improve remote helpers and
object storage performance, I think this should go into that section
rather than here.

> >> > +7) A client can offload to a LOP
> >> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> > +
> >> > +When a client is using a LOP that is also a LOP of its main remote,
> >> > +the client should be able to offload some large blobs it has fetche=
d,
> >> > +but might not need anymore, to the LOP.
> >>
> >> For a client that _creates_ a large object, the situation would be
> >> the same, right?  After it creates several versions of the opening
> >> segment of, say, a movie, the latest version may be still wanted,
> >> but the creating client may want to offload earlier versions.
> >
> > Yeah, but it's not clear if the versions of the opening segment should
> > be sent directly to the LOP without the main remote checking them in
> > some ways (hooks might be configured only on the main remote) and/or
> > checking that they are connected to the repo. I guess it depends on
> > the context if it would be OK or not.
>
> If it is not clear to us or whoever writes this document, the users
> would have a hard time to make effective use of it, which is why I
> am worried about the current design in this feature.

Yeah, but this feature doesn't exist at all yet, and it might not even
be a priority, so I prefer not to promise too much.

For now, I have added:

"This should be discussed and refined when we get closer to
implementing this feature."

just after:

"It might depend on the context if it should be OK or not for clients
to offload large blobs they have created, instead of fetched, directly
to the LOP without the main remote checking them in some ways
(possibly using hooks or other tools)."
