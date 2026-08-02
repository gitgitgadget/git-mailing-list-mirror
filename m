Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B649F3803DC
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785670156; cv=pass; b=akaEMT/G5MVmjJwbGWznC0yBXIdBa+yqOQwJkPR2xMfKfkF//grsF+5M5xzwP4R9WpqvoFTUaTy9bKyf3A8aZ3SB8fpCkFaOwjAB9BTL1aqj5jL0NG3H92HOI2YkQw7bJyJW0DWfCVJPR2SjAJdlaeD1BpXPVBf19saTE48X9Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785670156; c=relaxed/simple;
	bh=SJ57KHby0HOHtJWHT+WYxnpT+PX0JX65Iof+YHQZYJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGiKYRaJGDQUh4YTkvIpzyEdcReCHhuRaEsFXsDhrBSEitDaA1Xn/8HHPzUxfm4ElpxgqBybsd0pK34oVGCri+rBrg1Tw3I0KKEIi92wQUCql6Zl4/1jZFXhw5UVq+esj6bvORe+51pfFKSGIomhCY1BNoYKj62jOL8VusBbZD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DW20KLkP; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DW20KLkP"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84847482584so1540711b3a.0
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 04:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785670154; cv=none;
        d=google.com; s=arc-20260327;
        b=SxvBcgB8Yv5XeLD3LXDzBHQL8LAfmcfSrBsdwiU61cqYlplSQuzUK/z6Q0hBWTyRu0
         qNKXfGg4emolSaeZLatpK8Ah7PpJRVYdxzcbLax1aMn+WSDwgEMnGP4+r8zu0oqfEbGw
         eL2j9z+Qb0Ne1mAd0HnxXHlwpOlPzz2nXV1dkaN3hfjTJvdVFsdMEc/VXQkGqMAFv3rI
         WpAivuc/4DXlz7SScec5zGEtZaYICMpQ5kH8mLVXarTv0vw2qLC2WzCB167x1cQQRc63
         Ka1Dzamp7IavZhXcpdD2H7MF9iwzrNB0JDFlAJcfjyZNgJvQ2zOGq1rZ9VqxqiNhkWFj
         NJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6m+wjABtwg5nwMAGxZxxulZLJfLSfEG6F4fx0CC+Y4g=;
        fh=HHKzRUEEhCWVwkOWbqkww05igjo5i1Yfo3ZxdByB8iU=;
        b=pLWJaOS9pX4PrYzcZeOrLVGPCmbQfsNhLKxYb8B0UVuaCp5gsDPsQFFe7sP/zm1RTV
         yu2WtshalAY5dAftXM066KMTFDK6rbyTBBGOg+9Mx38b5D3f0180azJUzhUwQwszjK8C
         +T8QxHPIbgD0/VIs/SaYRawYhowHCQkQxCuxGJkjiZrEyF9aFt2+cjzCKDvzuXLs3G/z
         XT9JU374+UmLEuyLmatgJ58+erll3FMci1YNZhK7bHP8/T757wTTtKa3qwbdSQc7NXni
         4KtBq3+z5TotHg1zmrOgoXY8OPAkDAZpeYsqNi2dg0B9dM6vrv7TtpJ7iaEQTbDX2ARU
         BYLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785670154; x=1786274954; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6m+wjABtwg5nwMAGxZxxulZLJfLSfEG6F4fx0CC+Y4g=;
        b=DW20KLkPGzXksMMDqrlt3R6jnZfZ4HU/qBCykkkWcJlai02iBowSjIfLnDvagUm2+X
         pg5eEauiF0eJOF0CMAaP60Tnwzat2+ZM3Xx84rFtQQqWwVy4jvmsqgZl3FnTsDKUxB18
         aNhLw1p63xN99JwZKlXM3oTrWrnHffK74ZNhiXF++zoS+gwGSmE5ZUp82TzBECWkYJDP
         D63VSTh1fRbVeUQpy56kK9S48hS2Q1zV72o1gQMIhg/4tVogAglUNoBaXe+WsjqEzy+Y
         uB4SR6RvPVZENRrsUCJyN0EvMUeVIEB3KSNv4cgfy/rqWQ5d1Ug0ulM7p3QmwvpPV4U0
         Q5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785670154; x=1786274954;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6m+wjABtwg5nwMAGxZxxulZLJfLSfEG6F4fx0CC+Y4g=;
        b=DbzsTKr/qv6SgXVvK4tB+aLvQ6tPaBD580sM6e2ER0sQ7amRnTzG3Do7MGh0ezHItV
         Uwf34bgZLUVWaTT4cMwepw4UGPI9g5qX5kse/uMcj18Rw9yQD3HBPSZEqia20eJZu2Dz
         FZ4y+UUdao2UOgRmYJ7yh8JjeVriwCKzerXIrvr8n+EtMHYbop1MCSdrp6THUtRaehf6
         hX+v8jTlE2Bbo80AMNLaakxI9BRshSwH3s1hlejMvZ/xeGoyDrj0ThLd4yWt8h7G48a5
         Ox1WnATjDL5G9iP1ANyRwrqaxtSqZ+Wa/nepmpr51otvyl116DuCI9aELmtqtKRmMsAO
         6Fag==
X-Forwarded-Encrypted: i=1; AHgh+RpLWY1zxouycJfnMo5XJ/vOQvk+eLNxRZaqf3hk66tY0o04mFnEtNybTFr0KYg+peEr45A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqkqruMfGd+fYVQijstdz+YbZEvJnjQj7atMRlO67d734VM3O
	rW0kPHAm/lXXit/Y6ZXB7e7X7R7cytTftvWjzvRYi8On4b9u3i0NUyZSeavqjrMFeWwMXHLLYy3
	Hp+MNSnSAn5rNg04A0KTRSVVJdZRSZVp9a37i
X-Gm-Gg: AR+sD10nmh4Abrp/VCmla9izUq5/WpU8zz0GEsYyxB3tHcRTwxFghv4Nlc2uxpAqwB1
	04l3983Z9eNq2bfWaWMNL1Cdq55yhZeajWSTeRCIIcei1Cp6qsNxnvCqJ+X2/WcktSVslJiQ5zl
	bNt/IhanXlI2CR6PqdrPbarfT4R20zpQssEQyCc6jizNnxfDMJg3UrOzat1WwYQ0vFMPh7/2H7o
	p4jjUD2k4YtO9Q3OOThoslwLMrLu/9JAV0cV3n9+bxn+pEryhhvT9kXqODmdyWT6tFg4pl+gvmi
	tf2KjuTvwIfgrlUj4JZj+HOQrjxOpWgWgHv2n9o5vni7CC2niEsQ+CZHFe3AQgLO8eTwYYi1+Xo
	bSayKdkThCVyIDOFkYpynYlM56Vv+dwhSC7jbUVBwdtO3T5ViLE2BKgus0aXpi/ID
X-Received: by 2002:a05:6a00:2ea6:b0:847:e2e4:a36b with SMTP id
 d2e1a72fcca58-84ee492fa1dmr5258782b3a.19.1785670153815; Sun, 02 Aug 2026
 04:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com> <xmqqcxw3dvh5.fsf@gitster.g>
 <CAGWgyh8EPSufBZrk0xCqTr4gz6MtJHkfCy6JQKxCqKSPZ3gEgw@mail.gmail.com> <xmqqa4r55kpl.fsf@gitster.g>
In-Reply-To: <xmqqa4r55kpl.fsf@gitster.g>
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sun, 2 Aug 2026 16:58:37 +0530
X-Gm-Features: AUfX_mzV833bNLUCThN98FTpYowf-0OblZXOILiGLcDdlSASQXqbgCfhCjyt2as
Message-ID: <CAGWgyh91Bh-YOs9WVdbq7cEVkM0guu255GmXqJy2PhydQpNetg@mail.gmail.com>
Subject: Re: [GSoC PATCH v2 0/7] repack: add --drop-filtered to reclaim space
 in partial clones
To: Junio C Hamano <gitster@pobox.com>
Cc: christian.couder@gmail.com, siddharthasthana31@gmail.com, 
	git@vger.kernel.org, me@ttaylorr.com, ps@pks.im, johannes.schindelin@gmx.de, 
	l.s.r@web.de, ttaylorr@openai.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 2 Aug 2026 at 07:48, Junio C Hamano <gitster@pobox.com> wrote:
>
> Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:
> Doesn't it suggest that the "cull anything refetchable" feature can
> gain a bit more smart?  Given an object you know you fetched from a
> promisor remote, are there cheap ways to determine how long you had
> it in your repository?

agreed,
I like this a lot, recency is what the index guard was reaching for: dont
drop something you are likely to want again right away.

the tricky part is that droppable objects are always in packs (a lazy fetch
produces a promisor pack, never a loose object, in every config i
tried), and packed objects dont carry a per-object timestamp on their
own.
The cheap signal available is the promisor packs own mtime: since
each lazy fetch writes its own pack, early on that mtime is a decent
proxy for "when did this object arrive". The catch is that once a repack
consolidates packs, that per-fetch granularity is lost and you only know
the age of the combined pack.

Git does already track per-object mtimes for cruft packs (via the
.mtimes file used for --cruft-expiration), so there is precedent for
age-based culling. whether something similar is worth doing for promisor
objects, so age survives repacking, would be a larger discussion

either way a "dont cull objects younger than <time>" rule fits the same
enumerate-then-select framework as just another predicate narrowing the
candidate set, so I'll note it as a promising follow-up criterion

Thanks,
Siddharth Shrimali

> "This large blob can be refetched if we
> wanted to, but we downloaded it just 20 minutes ago, so let's not
> cull it just yet", or something like that, perhaps?
