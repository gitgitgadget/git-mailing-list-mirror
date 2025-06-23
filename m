Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E712D12F4
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750709968; cv=none; b=YAnWB+hWDYssRPnOlSD6SejXOINEVjgw1S5U4xgBr/o1IWby7MjdJic7nIPjrKQW0agBp3HeXmOrKYUAGXvjNSFBxyzPlyRii1NeZZRlyigbWHD73KFWMCAEzHlj0gNBs6UAB1VtqzmRbWhqPQMUuToSoqmUNF413H6ivtjKbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750709968; c=relaxed/simple;
	bh=GzPeNwnr1+COmZz2tYfQ6EYjYxzd+n85Ab/c+5WqvX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHUyGDMV0AL6sGxcaerrnOJd4XF344CnuVc0Y0fSvU6M3rbDGoAXBbTiha++gmngjBUPGH3lRgWeocvZNdIwUTjdpFb81s7r4N9fNZI+SUu8YNO/4MmwV7DtqehpO3+UmCXxTHJQzBI/7T5OEoH1e4MyFlveoQnGjgyWUU8EJaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjoSo0Xa; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjoSo0Xa"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a58ef58a38so36221cf.0
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750709966; x=1751314766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUW5+BP3UlhwUy+617Hcur+xZ1Bw80q3nKLtxiStRUA=;
        b=sjoSo0XakLOpUfPCA7nChAA+nEQovCJcuwgGLA1usVdlwjqrrVYe62Vs6bpFbL3OSg
         2JZdLg1XMVb763eAseeYGwCSDyH3zEDw2ScUsY8k+rvMIO7dRgVH2ITLAtUVoHQvzPGq
         WfeVRtVJoAO3+cOLYlDK33BxgTJj2CuX1F91CeXR+zjGZBwerXi79dNubIfjhOnt5Cqy
         GjGM3Feo01rKL5GNjVzW9c8xNkiFX+Rkr5hJJjScBagouX9avI9reiGsUKURtfD3xeQS
         5bPTzYBDduX36YRcfl5hok2CTYVlaUfOGc/nto6jknLA77jHk8e/bk7kE/kzzxWGV2Nh
         JAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750709966; x=1751314766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUW5+BP3UlhwUy+617Hcur+xZ1Bw80q3nKLtxiStRUA=;
        b=mhC8dSAxX90vIXb6cM1hT4nXdcinUp4fjjmZRAKe7WVXWelvcDMo6cAEeulJ7xp07a
         MDqiX0Z3ebwkTBp2WI3IXIUAd6OfYQ3JIbbgwVj8Xei+OGRQkUpAPuistd2MJL/Hif2+
         PKcAyPtZkNrCwBCHEdB4iSPHh+9E0eWQ97LzNlUbn2su5JebDao7KrxlTsDXr/8auQ+n
         iSuw9cSOHzoIPt41coe9RsFq/0PA8OO30RpfnfrZXthuTKxg9bNbcvq1r8XvbhVY0sqO
         F9f/rDeCi+ae5YeGX1AMV7QmUof45v+bKrb2xYYeC1KoBsa12lx+m3S0NMRTpm9WnqRA
         AewQ==
X-Gm-Message-State: AOJu0Yxr5y20u7Nlc6BXThswLn1wOnkcFeU4UHRHuDzQpARzNyS+QwWo
	HLkUBkDw+HC8zyWs0YQd5e16WtT9gyIl1X+QlywD2kShU2PInM14LX+dsn1ImRsRES+5/1Q7SFY
	3karLCQZHKfKNy1W+c9xoC54Onu+eeM4cHcsqvu8n
X-Gm-Gg: ASbGnctpLDfou684Gb8cA5vT3PTo55oYnC5x+lyXJgi2NiXUvCwczaCmtg9V8eVvpuT
	gbtGMoU7j1HODLaGCY1q3wfSCzf+6ljoM8a7sK0DqfVuHpQ/brOfLv1Ff8wDxm87kyYFttyaFGt
	jtXV259EKFR/bwToqJej8aHMbxnQYHBmiEDH5HVAeS2xjOz3yON4+sYbC02w2KZqzXcfoioFRcq
	A==
X-Google-Smtp-Source: AGHT+IGV44vbCg80XxLaVTfScsLEfwR0vwifylYIwn4X0NwnsjCrnmDsWmf4xRuVYCzKbXQwKdce8Y4SoQkPJPwUe5Q=
X-Received: by 2002:a05:622a:1925:b0:4a4:3099:60fe with SMTP id
 d75a77b69052e-4a7afac0551mr737561cf.21.1750709965503; Mon, 23 Jun 2025
 13:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com>
 <xmqq8qli5jyi.fsf@gitster.g>
In-Reply-To: <xmqq8qli5jyi.fsf@gitster.g>
From: Kai Koponen <kaikoponen@google.com>
Date: Mon, 23 Jun 2025 16:19:13 -0400
X-Gm-Features: Ac12FXynKiviw0S21EMrHZhG1Lod7KWRt3ZPT4SPoE7zr6Fi4jCA9oC_Lb5Us2o
Message-ID: <CADYQcGrR0mKLEWSYZCrL6b7NYLGfdsZsuKCCFQ_ptpMJ8mofmQ@mail.gmail.com>
Subject: Re: Perf bug: rev-list w/ 2+ paths relatively slow with commit-graph
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see, more of a perf FR than a bug then.
I don't have much expertise here, but on the surface of it, it doesn't
seem to me like there would be any reason the algorithm couldn't check
each path's bloom filter in turn while searching, other than that this
would be a large and annoying change.

On Mon, Jun 23, 2025 at 3:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Kai Koponen <kaikoponen@google.com> writes:
>
> > Reproduce steps:
> > ```
> > git clone https://github.com/golang/go.git
> > cd go
> > git config core.commitGraph true
> > git commit-graph write --split --reachable --changed-paths  # Without
> > this, all calls equally slow (~1s)
> > time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
> > src/clean.bash > /dev/null  # ~90ms
> > time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
> > src/Make.dist > /dev/null  # ~100ms
> > time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
> > src/clean.bash src/Make.dist > /dev/null  # ~650ms
> > ```
> >
> > The rev-list call with multiple paths takes over 3x longer than the
> > sum of individual calls to it for the same files.
> >
> > Expectation: rev-list with multiple paths should take <=3D the sum of
> > the time it takes to call it with each path individually (ideally <,
> > since with the count limit it should be able to early-exit and search
> > less commits for either path).
> >
> > Also reproduces without the -10 arg, or with a lower count (double
> > instead of triple w/ -1), but these results are perhaps most
> > surprising with a count present.
>
> I asked
>
>     How does "git log -- path" use the changed-paths bloom filter
>     stored in the commit-graph file?
>
> to https://deepwiki.com/git/git (there is a text field in the bottom
> of the page), and an early part of its answer explains why in a
> fairly convincing way ;-)
>
>     When you run git log -- path, Git first prepares to use bloom
>     filters in the prepare_to_use_bloom_filter function. This function:
>
>      1. Validates the pathspec - It calls forbid_bloom_filters to check
>         if bloom filters can be used revision.c:674-686 . Bloom filters
>         are disabled for wildcards, multiple paths, or complex pathspec
>         magic.
>
>      ...
>
> In short, the changed-path filter is used only when following
> pathspec with a single element that is not a wildcard.  So the
> observed result is (unfortunately) quite expected.
>
