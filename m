Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBAF393DF2
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755818520; cv=none; b=pG67Go5eV36ZrM1sGyq3KwSb1hgVJvDUMUzGZmJa27SMK4dEdz//MqnEndN5yjYB+MQ8KDR1PlVp9T5xHUQH1P1IuU8gD5UJt7Fe3TODP0qBfnh6N3niVU2I4IvzCNz6nuMXUBmKgreWEOt/B03hgtlPYhX/sE7onSaXgHiyhjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755818520; c=relaxed/simple;
	bh=LUNJ39kEiHqntK2I/OrZgm6jFfnFPdEon9AS1Iq2hfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhoeAK26P7siXRZ1LHm+nBZWAc6ikPxvT/iS238i4tMpFsAMYY+paMajD3oBB+zYFVZnvFxOt/mAmUB142SdYtMKOAtLYcqUVNClYekk2mb+uyqOQV9X1AzzVCAmzciuMdNiTGU6/lOPVU27lKwd5aanRKeNICgMFYHIuvvDjWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PPabLC8V; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PPabLC8V"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e669190697so7937035ab.2
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 16:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755818518; x=1756423318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ECLPnvjMI1c3JSvInlIltUtKEk2d1hbYUQRiYWJK28=;
        b=PPabLC8V0d0Z9/CzAr7ss7p5+egBzxHBnn46ptPbcqfFXn8dQJ+dLdNcsKrXOW0Xp9
         J4mfIjgcjwxpw6JhMKfibnpCVDiBSF9ePTmB4oOpD4zsTmkV0CcPTZLQ5Hj7zsBK7S9N
         KPohG0StOyDo/KfAMVtrKBrVt85R1FTyGFDBj0eJ9guF+VY1NCJUv1i1N7+HcFFAOVyb
         e8y07RjQpbYzXqsz8KgPbJz7d0UkY/JCvPaJvn0YO48cs5NOTMRYsg29HSq014c7z6vB
         x0hhepDPFtWDjBJvJyDSNtZ2yK1G6qaM42Y8GvLY/RFD5SE9grqMfNojl/XoDWrz9LGD
         opQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755818518; x=1756423318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ECLPnvjMI1c3JSvInlIltUtKEk2d1hbYUQRiYWJK28=;
        b=ak6dTwA6jywlAfZ4lUbPQhh4v2mHerFRS0ChOgT+D3Alcf2wk2fO273j/zouwmfVdR
         6TLtdIi4XEejStk5wjbcmzaHEoojft835KByadweBcrAzuSUbzO2kwfVAzWYLHoaBRPW
         OQRwUxHrecTyEadNvKW6Xk/E1PVgJLN93Qt0S07/nspRFibdy+uaK+lrGr6+qn96Ti+N
         Ti72Mk8anAlqMbm+KLkk+fDZArdgNO/G6MQKe7GzLreXzXG76evMCRC7faa2JzEtt1nQ
         tQVwdu8YnzCaidI4xAwwLB+GCZKsGxPR6JzhxbwAe3s2z+KeUQXWts3D0lBurDp9fC7w
         xyUQ==
X-Gm-Message-State: AOJu0YxCiMb5F3Xgm+RMSlhbjGD7AOxd4pQQgNzrTOb0X/v5Bul+lYbp
	P3zK2X5tz/CTDeVFGjkh5CghydfDn9IwzXOVcnRn5LGEK6lfu9sDHysev+iyYeo5T36TYmgKe/x
	U4pDTg5Vm8LoJ/g0QNFQXlCRgNuGfEM8=
X-Gm-Gg: ASbGncu1zisvuWPtpTL0t5BovyqIjsa6tCnQXcOi3STyKfe6dMMJfBNHCvT9+bpAaRF
	swTxAQeXJ6CSnIY2bfhUj3upPDwVzcX26Udbr32r06SFr82Y+YiNE01iqZnxGdZ7L1jIVvoyAf/
	hJMJj/QwhTjISnKhl+FkvDDlFeANKlY0Lof+Tq/D8ecD8GA7Qz6Iw2yUxdoCLzCdKPyadZeXrfm
	3f8tR4aO8yM5uGW9Pc/yOEgpktZa0O31DEneoVxv7K0139yAc4=
X-Google-Smtp-Source: AGHT+IFhbczBnFy6Ta2vX8lramwiYac6bGhPJaKwS5u9gaq6jIXUz64WQfrn9U7Bk0SdrIhgMbdzsH1ehSMLIQxmHEw=
X-Received: by 2002:a05:6e02:1a48:b0:3e5:29a3:b552 with SMTP id
 e9e14a558f8ab-3e91fe132ffmr25627845ab.3.1755818517903; Thu, 21 Aug 2025
 16:21:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com> <5b19173c03da676b3e1effda7ba6d2ef5666cad6.1755715196.git.gitgitgadget@gmail.com>
In-Reply-To: <5b19173c03da676b3e1effda7ba6d2ef5666cad6.1755715196.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 21 Aug 2025 16:21:46 -0700
X-Gm-Features: Ac12FXxPW5uE8jvPzuT_Hpun5hAwJJN6Xn93mhjyQEh_Po59rY1FfIbW5H943Yo
Message-ID: <CABPp-BH5OLfCcAgwtLfUdT6_=ZhiXYUBd+HwUgNzQ+LyRoA=jA@mail.gmail.com>
Subject: Re: [PATCH 1/3] t7700: add failing --path-walk test
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com, 
	johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com, 
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, 
	peff@peff.net, ps@pks.im, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:39=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> Users reported an issue where objects were missing from their local
> enlistments after a full repack using 'git repack -adf --path-walk'.

What is an enlistment?

> This was alarming, but took a while to create a reproducer.

but =3D> and ?

> The root cause is that certain objects existed in the index and had no
> second versions. These objects are usually blobs, though trees can be
> included if a cache-tree exists. The issue is that the revision walk
> adds these objects to the "pending" list and the path-walk API forgets
> to mark the lists it creates at this point as "maybe_interesting". If
> these paths only ever have a single version in the history of the repo
> (including the current staged version) then the parent directory never
> tries to add a new object to the list and mark the list as
> "maybe_interesting". Thus, when walking the list later, the group is
> skipped as it is expected that no objects are interesting. This happens
> even when there are actually no UNINTERESTING objects at all! This is
> based on the optimization enabled by the pack.useSparse=3Dtrue config
> option, which is the default.
>
> Thus, we create a test case that demonstrates the many cases of this
> issue for reproducibility:
>
>  1. File a/b/c has only one committed version.
>  2. Files a/i and x/y only exists as staged changes.

exists =3D> exist


I didn't have any questions or spot any issues on the rest of the patch.
