Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6594F13D296
	for <git@vger.kernel.org>; Fri, 13 Sep 2024 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726208222; cv=none; b=DiHlBhwRHAq3zbItteWxKeCCv14uoAiAeVU7dVB66TY9UnTSieLPapnHAqo+E4MgkJCNIJ/gSQiwnzVWwt5VoTtynJPbGh2Tt6po32DM4EI75bZDS58gEA/H8iXje3p08+2NDsurzUJL/yfem2QTvrrqyWrn3GSPX/nctjZnTQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726208222; c=relaxed/simple;
	bh=KG20yupUn4N/2W/UYn3WQbw3oMeInsckGPfpHBTGUEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2ZBoi0h42f9C9q4BwZfrLeoUkni2uI5bibcTBisgtvF68yyLkX+2AgAa2amh8zP7t0p35OL4ywZ6SSS/z0Pe+utSpeU7SV2GLTc7UEs3UQVNLhHQI8r/t8RgkG0fNVq5zsZxAFbN0wqT5qR1JcgVJyE2L5PUcuCq0NKa+oK27w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSVmbbdm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSVmbbdm"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso1312392a91.1
        for <git@vger.kernel.org>; Thu, 12 Sep 2024 23:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726208221; x=1726813021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zny/Tkvksc0dxwHUmUwLDzPoEJmya1gv9g9rPy/T/9A=;
        b=SSVmbbdmXD3ys5N3nbI0BE6F1LQ3p90YVPndSdsuQm+nxVNixW6J6H8EoeRltEbDRl
         l428yE3fZYzu9WTUu0o4kB1L6y0h//aZ4GU7UyJuKlntwd4NKUOrvSNbcOUJANQIE1OO
         ZB7tQakcnV2B1ev8VXHiI6Iuo+o7ezf1CNQL9Cy216zNqosDWSp2CLv9UMJWNChPjRbz
         fQqm4kwrRGaCo0uihQ5EPssaXGMLZGIxaMh7cLFPUv5gxWiB7h54adlhOBes2b1XgfYf
         Tbb/JpklRwPdSIryF6F5sC507MLu4cUMJLUgV979tVfgURD5pfJsTUQ0KVx4jveo6bh9
         eDLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726208221; x=1726813021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zny/Tkvksc0dxwHUmUwLDzPoEJmya1gv9g9rPy/T/9A=;
        b=M2/iAuvuycAZPzD3QDm3IOlispNZltMu4THSrGv27Z/3s6XQ+GYj7OVzo+FRCpOmgh
         leCO/4zDWlm2JlAoQchfXv0FeStKdQVo/glCftF3qbeEfoM+g60m1ZT4iwCBJ6XnFBn0
         McvZpIMaOmzyVuTS+qf6Mvdwmr98ZQP+OpU8aIWm5VgpVU08KACNi9/fofAFJRQqI4qh
         VB3bL409omDpB5vanLei47Dah4VANFDYOUg2+GaJBcvq5SZXO/BYj9MDQEf0NyU2HOPf
         wFBHC5ufIgl6Ka8yN10ZQQyOAHw0i8K08pY+IIBShF3Pt/ZiwG3hjuCXWZlmsQBkIgHM
         NAgg==
X-Forwarded-Encrypted: i=1; AJvYcCXfsfpIHZ6dJnOLhWJzZcA6kA6Exgz/hkKrkzM+Wpi/qg3rZ/yY8PXaQ/lx4jIwrxAAtxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHLOclgrwkLXCd1T1qmRQYWmjuXuNAcoNaZJz+A14Iepzn5Aw
	mlvpA9SGzvw0mt7joLigQc4LstFyHS6tp8rO4ksIW4IFnNF9kCvpvmVxAurGh1BlPZFPqFmEeDa
	ooKj8lnzj/SuUr7rNGCDzslXopqo=
X-Google-Smtp-Source: AGHT+IF+1i5OIUS7JtnytpxKAJlRrqMXlw2NgRodzBEoWjSVvN8JMkKVKsW4ULtQ076CQ3d0HSEhuptVMEEygJG88+g=
X-Received: by 2002:a17:90a:6fa6:b0:2d8:7804:b3a with SMTP id
 98e67ed59e1d1-2dba0052486mr5360540a91.26.1726208220367; Thu, 12 Sep 2024
 23:17:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1782.git.1725875232922.gitgitgadget@gmail.com>
 <xmqqzfogsrqo.fsf@gitster.g> <CAG=Um+0GvFzdAZrCgoS52xh9DF2pntQ+7i+vqYMFQf-MWr3H5A@mail.gmail.com>
 <xmqq5xr4r818.fsf@gitster.g>
In-Reply-To: <xmqq5xr4r818.fsf@gitster.g>
From: Shubham Kanodia <shubham.kanodia10@gmail.com>
Date: Fri, 13 Sep 2024 11:46:24 +0530
Message-ID: <CAG=Um+3WSckyZ2P2o2igQr4hbMyMNTDZ_kqjrfdufvL6hUhMjA@mail.gmail.com>
Subject: Re: [PATCH] remote: introduce config to set prefetch refs
To: Junio C Hamano <gitster@pobox.com>
Cc: Shubham Kanodia via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	"Patrick Steinhardt [ ]" <ps@pks.im>, "Derrick Stolee [ ]" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 12:03=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Shubham Kanodia <shubham.kanodia10@gmail.com> writes:
>
> > How should we handle the related `remote.<remote-name>.fetch` config?
>
> The get_ref_map() helper is what the rest of the code interacts with
> configured refspec.  remote->fetch is handled there and goes through
> the same filter_prefetch_refspec().
>
> > In an earlier discussion, it was discussed that =E2=80=94
> > `.prefetchref` should override `.fetch` completely (instead of
> > patching it) which makes sense to me.
>
> Maybe it made sense to you back when it was discussed, but after
> seeing the current code (before applying this patch), specifically
> what happens in filter_prefetch_refspec(), it no longer makes much
> sense to me.
>
> Especially it is nonsense to allow .prefetchref to widen the set of
> refs that are being prefetched beyond what is normally fetched, so
> we should look at a design that easily allows such a configuration
> with strong suspicion, I would think.

Ideally, a repository should be able to specify (say):

remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
remote.origin.prefetchref=3Drefs/heads/main

This configuration would maintain the normal behavior for fetches, but
only prefetch the main branch.
The rationale for this is that the main branch typically serves as the
HEAD from which future branches will be forked in an active
repository.

Regarding:

> If prefetch_refs contains only positive patterns, then a refspec whose so=
urce
> doesn't match any of these patterns is rejected.

Simply rejecting a source refspec pattern in `remote.<remote>.fetch`
wouldn't achieve our goal here.
Ideally, we'd need to create a subset of it.

What we're looking for is essentially a pattern intersection between
the (fetch) `refs/heads/*` and the (prefetchref) `refs/heads/main`,
which in this case would result in `refs/heads/main`.
However, if I understand correctly, performing such pattern
intersections isn't straightforward in the `filter_prefetch_refspec`
function (let me know if there' prior art for pattern intersection)

I also believe that allowing negative refs might complicate things
without providing a clear use case.
For instance, how would we handle the intersection of `fetch` and
`prefetchref` if `prefetchref` contained both positive and negative
patterns?

Given that both `fetch` and `prefetchref` could have multiple
patterns, it might be simpler and more intuitive for users if we adopt
an "A wins over B" approach.
However, I'm interested in hearing your thoughts on this matter.

Perhaps I should link to the earlier discussion here  =E2=80=94
Message ID (CAG=3DUm+1wTbXn_RN+LOCrpZpSNR_QF582PszxNyhz5anVHtBp+w@mail.gmai=
l.com)
