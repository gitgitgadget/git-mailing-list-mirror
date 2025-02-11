Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B341F3FCB
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739276652; cv=none; b=fkLgRYovEeW81X3hLJoSdXD+t0TZ6OrGPBshL8pIInQGWNBwhkxe00nqsCkyehtLALDyaqmkj9XmUdVH9vA/qqG15J9MkFRMJz5k7UXpAvUrmHQVwe+YDmX6tzaiR+gVeCqNP6SLNWTCUmxjmx/dTs2m+xhHXBXUUM+DEL6CeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739276652; c=relaxed/simple;
	bh=uXAFJ/LwzYRrcDtUQE209CGj2/5uQ8Eys/gwI2mdgVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkDfVmawbWYCAFpmOs/HPxBOuaMVVxPNshidCFxl/5hxwN+pyXumigRYQL9h2dYZ9k4T2DMmT3qHi4N2j/jpwVpr2kdD2YOMgbQ7IhCut132xkDSNcxKmEIyC4xZPT85dYWJ3/uUMX7/wdiy61NcHzuXPo5Js0shcAN2aqZNjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eal9mzv8; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eal9mzv8"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e4505134c4so47452176d6.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 04:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739276650; x=1739881450; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B3oNWs2MiL26yq/YqypcX7QGm4I/zgQmYWtPVT/9vUk=;
        b=eal9mzv851F/m0hx1t14xlb0q9bZ9dpHjyUrjLqBNBCENurTl48mYVWALBzsSZAt87
         2mRMXORSbDsLz0w+hAeH13QIVLh+wyZjMSt2WJMK+ZeIT+m0KbqXbqJEh63sdaA8NrND
         tMeR3K7IT6BnLdFrqR2X7DJ8mcimZ2xbr+zcoZ8DhAhMU6/onTwDVRZY2P+qJ4k3wRdC
         TZAYNeKKWZN5QQMpPeJi0c63lKXedmVJRyJykTwJqJaGDKlqh/ApT2OKcOLfponZmSfc
         l0LU/DK+W3W2M7h7d6vZeUEyM4i08gaqXA2fz6yLci9APvQ1a7Y/j0eGQrDdYABhG/es
         t5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739276650; x=1739881450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B3oNWs2MiL26yq/YqypcX7QGm4I/zgQmYWtPVT/9vUk=;
        b=QZv0SaJibmYnnsQAeCQfGZazon19VjsiFFniYxIdzNquJLUpkIVAvDSm93/T/g94dP
         GGbFAN0ay0u/WmRFaV1E0MA8CyBDioL0PYhSeDe+LIDwA7oq36zQUQk6jOHXr26rlllY
         XjRGrAh4GjuJy6Sa83A9l+qb3XaH59DYUn/8wImFbSohU/oL4522fhLeQBFKYoHV2es2
         K7A55RSmGmIyzjK08Iwu+ImBLRT8wB3QdQaM5/hDiu8bsOYGBLk3a9RRddXG3Gp73IM3
         t689N1jGy2c131xRj+vFgh81DCWUMaEGxM3GccTsjsLczzOytQE91fhyVI5sIYEchz5N
         bKww==
X-Gm-Message-State: AOJu0YwyB5iSYxWHdJTtjC7blWYA4kPpEP2pCIjSVsTQR7my5aEXfihX
	MadyG+feTGxuNOgOk+Z/teZPiWwnKzcz8NGntcIitImEm3WQu6M/8UV9HBUNOIhzSt8lDYg+3GI
	s62hMVLriabrxss3mhTTVOELnRojt9ihcBkpM0A==
X-Gm-Gg: ASbGncu769QNGogzdhsxw9BKid24OLZDBRp7nM8zZPQqL07SBNpqnuamwXbBeZkhN1h
	ZTkVeI4oZp9Z2VLsXq0SU/rATvmkugG2JdGi2i6nQDPQqV3D44foc+O55737gIRWg8nNxIBFrbQ
	==
X-Google-Smtp-Source: AGHT+IHr/8KmuFzQI8BNHSGyUzghh2qcSqQhxSBu7iLH6SW3IG9yH6/McXb2Tqr9JNylxVzGFxQd/SMUXVXbDIXrZp8=
X-Received: by 2002:a05:6214:1c09:b0:6d8:b3a7:75ba with SMTP id
 6a1803df08f44-6e4457776bdmr270984976d6.45.1739276649741; Tue, 11 Feb 2025
 04:24:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210074623.136599-1-ayu.chandekar@gmail.com>
 <20250210074623.136599-2-ayu.chandekar@gmail.com> <xmqqzfitbuy1.fsf@gitster.g>
In-Reply-To: <xmqqzfitbuy1.fsf@gitster.g>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Tue, 11 Feb 2025 17:53:58 +0530
X-Gm-Features: AWEUYZmhCMNfzjtHLf0dFBfyGB37779LiA-05bkErsCiCMXsHc8kAkW2iVs7uiY
Message-ID: <CAE7as+YPKuBd+ztBerim6e1kZXZwUHdb_qjcMfZSBa4LkiyJow@mail.gmail.com>
Subject: Re: [PATCH 1/2] midx: show progress during QSORT operation
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hmph.  If the implementation is correct (which I cannot tell), this
> needs to explain why it is a bit better than saying nothing.
While going through the code, I noticed the TODO comment: "Measure
QSORT() progress", and I thought it might be interesting to explore.
For big codebases, being stuck at zero would make it feel like there's
no progress happening and that is why putting a progress might be
better.

> >  static int compare_pair_pos_vs_id(const void *_a, const void *_b)
> >  {
> >       struct pair_pos_vs_id *a = (struct pair_pos_vs_id *)_a;
> >       struct pair_pos_vs_id *b = (struct pair_pos_vs_id *)_b;
>
> This is a compar callback function used by the sorting machinery,
> which is called QSORT but system-provided qsort() implementations
> are not necessarily quick-sort [*].
Oh.

Initially, I was unsure how to approach it, but I believed that
tracking the highest pos value seen in comparisons could give a rough
estimate of progress.
However, as you pointed out, this assumes that qsort() processes
elements in a structured way where the highest-indexed element isn't
compared until later in the sort.
I now see that this isn't a safe assumption Since there's no guarantee
that progress would be reflected meaningfully, this approach isn't
good.

Let me know if you have any suggestions/comments:)

Thanks,
Ayush
