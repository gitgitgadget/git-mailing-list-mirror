Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924CF27468
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 03:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741835357; cv=none; b=ixlvhQfASJ/6pH/SBtknS075BLQbIcJ0bHRJhAeyKU6YLFgaPUR+boJzHYXUtMVgb/HVOaRP36SaiETVr6Hl+rsh/lVvFicT3wHbQv1/aDQtYwwDgx3g1sSIeSGt/dxIpLAuamZDHRVdejgFfylzn/Hp+YygTCihzP3/L9J16xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741835357; c=relaxed/simple;
	bh=FRR5ALzxfCMtgUKtqaefYyEgVpcirglhbt1VFTcc8Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWvFuWrsRYSHmPMgg7DLXPpM6hHPB2JxiFr1PlOfn9hOBwfcK7usklBtEMKRUGdtlX8JsMrrkQqROODbl0DCYANAhfRpS5AAzukVBUIMt8sp8solhiNj3C8veUqkye8vkgrL+bx9nk/+gSExalZnidNdqewx5LJTPtpAfnuTFfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bxDWCYqY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bxDWCYqY"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-300fefb8e06so953216a91.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 20:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741835355; x=1742440155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsBio417/MOA9zN8lbpusMdYvKerhN6GXkPbuJ3SIX4=;
        b=bxDWCYqYT3igtEiucll8cwA4jqoFreUbx/sOk/C2+fDtFclGJM0/qgSPNNIzgqpvyb
         ikC6yIjC1hW4l2Ab3ukczOfq9QgRzZFAnDDz2QbklbfFXbj+bjF5WCijwDL5B0wNRQRc
         pF4eIgFyHeS1vh4T20ty7Qs9No3NrkzGI7L+nQ1pKM2jhYVNH03LxjsfSzUSAE6JrHd+
         ITWaJio+fZ+VuGSXpBLqpP3nZEO5ydZuStM86+P9ihZR+kXNbRXcySNp49v8LpRsLx0c
         LJLApj6iAHDngtVqG2StxdpWGtX/9tB8R/lmOb9XoeCi0240D0ya64GYLO2qdyy2LIde
         rj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741835355; x=1742440155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsBio417/MOA9zN8lbpusMdYvKerhN6GXkPbuJ3SIX4=;
        b=qnvUPYbNwoog0/375broQqNBsWFL1wBcXkem0vM7iy9qhz0QwIJpVIpWrMCaV2fB7M
         7MmoK3G/HqBpC9iQgolGg5EOGUvzN7IXaHeTWvBBqnmmjHK+UVhNRmjWBmv3kbJUsK09
         jNfIhBaE7nFoTotPFKKJlrAw/TbaxOG3vcvGj9Ku5K35HRP07ALTzCH0sVp8ialEEXEo
         LtlIcn4TUDZIhEMuAwu0MWtULBQ0VO2K5mgMtS/0fnQBC6uN8arEC67lhVtUZY1uMOF0
         xVKHHeW/mSEkafqReAGqDYxJkurb49twlOXPuYEesqSevhMIzaWVLcN8vBy7nEJxZfLS
         /Jyw==
X-Gm-Message-State: AOJu0YzcTkhkkchcJK9j00jG86R3Jfbb2VhBHF2jxiq9J0DeHgJfgXt9
	Ov72AKi4Kl4dou5GRPQw5dsmcR0+Gay6N8cUwkLSBZebaXRzzM1PJGMnn3AXOJjunzup4tReBS3
	xXyuh88c41eEYIFdyDb9FGYRcWOiTVOihPvnNuhPQPEhlSLPq/w==
X-Gm-Gg: ASbGnctAxLDicXdgiboK08kDPO1+m/8+N8LhZQ3T52++E9+atKKdSfqwy4wN+n3xhNP
	57xe3OHudqgnFOBGy0boW+iwMQvhAEBmtam/jTyMb+MqlEgGlvUU87OWcUGHWS48U2WHyEpiXqP
	B3Y3QNw7XRNF3BGH6cbsfFQ3PPOV9HWUogQJOpeW73T8eDjO8VGzKn62IRRg==
X-Google-Smtp-Source: AGHT+IHYvgpB/yKGCvnGQOUqB5cOWWQGWWTsjuOXr50BTaKnDTDoMvBeKgG0IYyCgcFZl5hWv2Ya7vn/N+efTYvkNwA=
X-Received: by 2002:a17:90b:4c51:b0:2f9:c139:b61f with SMTP id
 98e67ed59e1d1-300ff0ca64cmr14873736a91.14.1741835354491; Wed, 12 Mar 2025
 20:09:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <871pv2jx4a.fsf@josefsson.org>
In-Reply-To: <871pv2jx4a.fsf@josefsson.org>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 12 Mar 2025 20:09:03 -0700
X-Gm-Features: AQ5f1JqnRUI4ympcIxCmhwD00R6Dew5qPbzEEzkQE3wE4Zet3BjHy4mYqMrVSAQ
Message-ID: <CAO_smViryqTa1LfQSsPbBYcSvijs-UkYkHaot3CK1j=uiuEppQ@mail.gmail.com>
Subject: Re: Making bit-by-bit reproducible Git Bundles?
To: Simon Josefsson <simon@josefsson.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 4:59=E2=80=AFAM Simon Josefsson <simon@josefsson.or=
g> wrote:
>
> Hi.
>
> Thank you for the "git-archive" and "git-bundle" features, making it
> easier to do source-based builds in a no-Internet environment.
>
> I have published a Git bundle of Gnulib:
>
> https://www.gnu.org/software/gnulib/manual/html_node/Gnulib-Git-Bundle.ht=
ml
>
> As you can see at the end, I struggle to come up with a recipe to allow
> others to reproduce the git bundle that I created.
>
> If I run the recipe above twice (including the clone), I get different
> checksums.  This even if nothing was committed in the remote repository
> meanwhile.
>
> Is it possible to create a bit-by-bit reproducible git bundle using some
> other set of commands?  If so, how?  I'm using git 2.48.1 from Guix.
>
> Can anyone explain what is causing the irreproducibility?  Running
> diffoscope is not helpful, since the bundle is compressed and diffoscope
> doesn't seem to know how to untangle it.

Spent some time on this, and when I followed the instructions, the
diffs were in the pack file portion of the bundle file, different
"tree" objects were produced at different points in the pack file. But
it produces identical bundles if I run `git bundle create` multiple
times in the same clone. My guess is that the non-determinism is
coming from the clone process being multi-threaded, meaning that the
order things are created in the filesystem during the clone,
presumably due to multithreading happening during the clone process,
or maybe during gc? The contents of .git/objects/pack have different
hashes across my two clones, and I haven't investigated why.

>
> If this is not possible today, what do you think about changes to make
> this work?

What is your end goal with being able to reproduce the bundles?
Bundles are just a list of refs and a pack file, I think. Reproducing
the bundle doesn't provide any more security than git provides when it
writes the pack file to disk - if you end up with commits with the
same hashes, the bundle has to be *effectively* the same as a git
clone of the repository.

Producing an identical bit-for-bit bundle might be doable by doing
some form of sorting of the objects in the pack file, but this would
only get us closer to bit-for-bit reproducibility *on the same machine
and versions of everything*. There could be some changes to git, zlib,
machine architecture, etc. that causes deterministic but different
values to be produced. As an example, maybe future versions of zlib
compress better, producing an equal result when decompressed, but a
different compressed result.

>
> Thanks,
> /Simon
