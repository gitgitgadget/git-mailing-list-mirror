Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC002AD21
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219336; cv=none; b=Otyi9SgWqtmNKek9LK+TaZ9RXonp1X9IeZ6IoYXZ88CqD30P1O0o6ID/uq1XZIKjPJd1/wiGMUtBBh3XEF3y972YECNfae7Y68dafKm/MORB7cNVxemEmwlw5a43XGQo4y6aZImHtRGiw7FgO3zCmBLF+f0d3tO+eFdt73Isfao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219336; c=relaxed/simple;
	bh=ziZJxrV0V1j1xVmUIn+vlYSnNJEj441l4gnX5dShj/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsY15wFce/ftVmiBWnAN/HRj+KadwiQjARFwaXWvyDQjbfkO/8o3zhp0Sn/6SW1PxqzMQb/WFOJ/OszIUObNDzBArb+3qAZakuH9Mf9t0GMl+ugHB2ly80p0d3qbOhQpti/Kv+uYDZJVEFGBb0IVfkUZlm3JoVQwViDNRK2tWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgpxjBP1; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgpxjBP1"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-214d30f1889so557808fac.1
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 13:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706219334; x=1706824134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytUgPLmeIuB5Sp6P4uyDedAImcD/GHUR8CUsc5KEv6c=;
        b=WgpxjBP1YRdFF9qtjbpLh4ATl5pIcbk0ZNT2UPtjxcj212fYjTTcj8b5JOohZGXCbJ
         b9pknRL4JppqI+jD5l28VueAPeSe0CHxnEITE1CPz73Q0e0/twK7GnYVw3gHg9ZRJFb/
         k9hMEYMqCp3kadwapAW+KmgZptRX+Gv1H/P/vyApFMgwcDn2kDBBHsrnf1aMyxWFucu9
         KknQJ/UJ7Inr4SfVIT6CxSHqVbsD/7RXvJsGWA8P3Hjfj6zRhbiPwQVobe/6Hc3/WHi1
         zkznDer57RgDDkd+ilbJCW6q1RxnYRnUsC2Tn7oQxJKVQjHBlbx/VdNZSOnOdjBbaZts
         4cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219334; x=1706824134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytUgPLmeIuB5Sp6P4uyDedAImcD/GHUR8CUsc5KEv6c=;
        b=Ac5XroWnt1+IyDTHamxG2luruH5gRIF+zpITEmNM3NFjJZAtfTq5o0YPxnRt1ToKqP
         e1pGxuQBBbv/nW/OQSR/R5hJJV1TIB2uGG9Zrt5P91rl1SNG7Cgn7sBdprevSRt0qcsv
         6uTzG0y0HM/vuuP0v/uw047ECpiO6OqD63IaNL9S81ExVBBtX4MOzjlzXt6kWP3xc7Nx
         kq4yoLuOfx2mmqP4O8xI0iEf+KRDraDcUUv7YWB2hrhrQ3JNdSsdcG6UGMKAziaLZIPL
         NgsfNF11kdZBZnClOUbmWga1vp/ETQ8Rrby833aUZKt+v7ItxNRpIfJQTLFSrb+EgvpM
         sk1g==
X-Gm-Message-State: AOJu0YxQ5mUkOYRJuTjxaXFboF5M0cQ0dPQEfkglwjPtWrGikIVxXIUZ
	iy8kTJ0cvGXkDDQp7WNJPGt94ncJPgpEFOmKE2TNXdxKX5uozaPaxhEzOslau+0f7uALaP1FvoJ
	Zj1D8Z/tf9JKvb1PRiCCSwDRCuDHH6cVi
X-Google-Smtp-Source: AGHT+IG75cxGbsgXwrXQhmPeHKOkj2y3cPR280NJTxzxLyLO/Pi4XlomFPqGwfO5rYYk8XQZ/SWKHnlX9Edh/MGR5jA=
X-Received: by 2002:a05:6871:4143:b0:214:8734:1345 with SMTP id
 lb3-20020a056871414300b0021487341345mr94160oab.7.1706219333863; Thu, 25 Jan
 2024 13:48:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240124152726.124873-1-karthik.188@gmail.com> <20240124152726.124873-2-karthik.188@gmail.com>
 <xmqqfrymeega.fsf@gitster.g> <CAOLa=ZQxMZo2Y6x6GmVw=df_xS4tkF4D1_tZOeLb7jL5d5bKXA@mail.gmail.com>
 <xmqqa5otxtqy.fsf@gitster.g>
In-Reply-To: <xmqqa5otxtqy.fsf@gitster.g>
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 25 Jan 2024 22:48:27 +0100
Message-ID: <CAOLa=ZSTY+YQ1a5U6Q=RQNg5VMjP0wOLS4t5obua8_==BfbdhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] refs: introduce `is_pseudoref()` and `is_headref()`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> >>> +int is_headref(struct ref_store *refs, const char *refname)
> >>> +{
> >>> +   if (!strcmp(refname, "HEAD"))
> >>> +           return refs_ref_exists(refs, refname);
> >>
> >> Given that "git for-each-ref refs/remotes" does not show
> >> "refs/remotes/origin/HEAD" in the output when we do not have the
> >> remote-tracking branch that symref points at, we probably do want
> >> to omit "HEAD" from the output when the HEAD symref points at an
> >> unborn branch.  If refs_ref_exists() says "no, it does not exist"
> >> in such a case, we are perfectly fine with this code.
> >>
> >> We do not have to worry about the unborn state for pseudorefs
> >> because they would never be symbolic.  But that in turn makes me
> >> suspect that the check done with refs_ref_exists() in the
> >> is_pseudoref() helper is a bit too lenient by allowing it to be a
> >> symbolic ref.  Shouldn't we be using a check based on
> >> read_ref_full(), like we did in another topic recently [*]?
> >>
> >>
> >> [Reference]
> >>
> >>  * https://lore.kernel.org/git/xmqqzfxa9usx.fsf@gitster.g/
> >>
> >
> > Thanks, this makes sense and the link is helpful. I'll do something
> > similar, but since HEAD can be a symref, I'll drop the
> > `RESOLVE_REF_NO_RECURSE` flag and only use `RESOLVE_REF_READING`.
>
> Just to make sure there is no misunderstanding, I think how
> is_headref() does what it does in the patch is perfectly fine,
> including its use of refs_ref_exists().  The side I was referring to
> with "in turn makes me suspect" is the other helper function that
> will never have to deal with a symref.  Use of refs_ref_exists() in
> that function is too loose.
>

AH! Totally misunderstood, thanks for reiterating.
