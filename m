Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFF4A1A
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749031788; cv=none; b=RrHIvWCkWkCSzes6lhSZyS1kCa4Uk39HT6HcfFpvdNhIGTICiaoUjc9nx9MefU1u+mZT/furdP1zISs9OORHAg1ThxsPkZiWuyenZEn86pQJVH3nXuaqFX6w/Zopta6vwBAsvdDOWiNh+fHLlHceW42/VFkvDuxnYTH6qzlG4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749031788; c=relaxed/simple;
	bh=+vTdL0bGbrTlVE0/o3ge83j7GZsc36R3gMsU9oPsoNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4qupYTLCiwwJlUeaywBSv2P0Sb07edy2WFHrEZ9aw1znHGYwwzgqDcV+IXVjyuDGRBggAAtizh306RKPk6KpcR03KMSeph60hop7vnJWJ/681vdFVaVbQ7dSSDLzGeDBxGVToCBNx5zwYFmK+6o7mh7Gy6Bsewttoc6gQqfjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmYncnIg; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmYncnIg"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70e1d8c2dc2so58764387b3.3
        for <git@vger.kernel.org>; Wed, 04 Jun 2025 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749031786; x=1749636586; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nAxmcoW1GYNE9PEHakxo81QGB22Sj/mWqNIn1qebDes=;
        b=PmYncnIgFxuieQnxojjNENXBvEmSdnGR8+biD1eiz9z1O9TDTR2mIVXQ+9w6vxbqMi
         g679SlixH/DBJSt0wmz5rRjG2p2PjxVeu7vZ7VIf7FuwfEehsrNoicGo1NXqekfBGGJf
         kUkAIt5llIv+yD5oEWnSDgT/sBPMdJUdmS5MG4rSL3DlfzpEAwjWLVPhiq7Gfcx4ysW8
         UHk14pMcDN4mYMJQ21JH7/5PrVPaIVYZU9CSxpeTQITNKcQ4EhJ6TLeBTeoo4/cMWlS+
         hjKeKgS5X1tTXlnEcQKgoHxcfMASPR5PZ8NSCt/IA5zb49GqRUoNc1TuCtlpbu3cxo6n
         +wzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749031786; x=1749636586;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nAxmcoW1GYNE9PEHakxo81QGB22Sj/mWqNIn1qebDes=;
        b=VCw2yEGI1l/aSzJ8BHQtWzz1JDyz35lBGjqJS09pZb+axYh7Y15jK+TjhIZixtVzWi
         sWJzh+nrkbocVbUZX4CH6nDg0jDBz2VmwTTYXBno03Ehxspo7I03K8ZKKdN/BoJiG4Cb
         kunjPy/bd3gDljGdHdwYhOQrvhyb4FOW8VskvIGlg+wVeIqXIt0jYVyHGYxHk1QieSxX
         ChT927fwbMFZA5hX3Tm/EzRmGHM37FY8yw7ybgRHKH7zhlcpvabFNBKaZtv2pK/iAvVb
         bWBnTnUkA+I+D2a/MJyXNSih73P96KJXrrqP45oNS/WWazHs+/foRyLrIl/odfDOobIR
         XCZw==
X-Gm-Message-State: AOJu0Yzjt9McBise/24jCm4+fo9kwkvSA2NNzrr3DgHZhvERhFlkAy6I
	vrXs7/2fzj9CBEN3BqAOXSexJwK1MF5wqhB2jltxReufv5EEtkaBw6UYkBP/yF2otKubg6PvL5o
	KvMryh56UapN99Magy8kxleyRGVv9AS8=
X-Gm-Gg: ASbGncsZ1oqTMR4OiAEO6bDTcUmTPUt+z57Etktm8WNqPyVSNaC5MPcvx6KETuWDH8U
	vJ/FxG2HBBDWUjnk+F1wOhwIG5yEDqOTj0SMBIfXdSdij2+PeJry/7MRpAkynr9IVyqJoNNz6L+
	G4GhZBSrLmLvy/sqzn78NgOXSimzvkIo2pYBg=
X-Google-Smtp-Source: AGHT+IE34lN85A51ygDXBOe4KrWojnM5FM0FpDEZanJDV0Hrmblgd4N+IGmZ05P7/HdXukp6G7OhMitGDTZiKjC6DAY=
X-Received: by 2002:a05:690c:28b:b0:70e:326:6aef with SMTP id
 00721157ae682-710d9da69bemr28652577b3.18.1749031786145; Wed, 04 Jun 2025
 03:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602122559.208780-1-kuforiji98@gmail.com> <xmqqldq8is69.fsf@gitster.g>
In-Reply-To: <xmqqldq8is69.fsf@gitster.g>
From: Seyi Kuforiji <kuforiji98@gmail.com>
Date: Wed, 4 Jun 2025 11:09:34 +0100
X-Gm-Features: AX0GCFtI6A_dKARVkH22e3G2AxLNgm569sQWAF5U7QPyVah_KXcRr_QDoKXVyxQ
Message-ID: <CAGedMtcdTDYON5sPh6n6JXkzBVFDzoLPcCNWBGZwYF5K6Ufeqg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] t/unit-tests: convert unit-tests to use clar
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Jun 2025 at 19:41, Junio C Hamano <gitster@pobox.com> wrote:
>
> Seyi Kuforiji <kuforiji98@gmail.com> writes:
>
> > This small patch series marks the final batch of our existing unit test
> > files transitioned to the Clar testing framework. It covers all the
> > reftable-related test files, and is part of our ongoing effort to
> > standardize our testing framework to enhance its maintainability.
> >
> > Changes in v3:
> >  - some code refactoring based on review, which includes initial creation
> >  of reftable helper functions to
> >  t/unit-tests/lib-reftable-clar-test.{c,h} files in the initial commit
>
> I guess this is no longer a "small patch series" ;-)
>
> Are we done iterating, or will there be a small and final finishing
> touch interation?
>
> No need to rush, as we won't be merging things down to 'master'
> until the 2.50 final gets tagged, but preparing a reasonably well
> cooked topic in 'next' for the next cycle is always a good idea.
>
> Thanks.

Hi Junio,

I'll make a v4 patch to clean up and finalize the series :)

Thanks
Seyi
