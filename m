Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092985675F
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 18:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389686; cv=none; b=O2djCO0bRi9gjy74aRriNC09etAxceU417F96gn5WlZYY7M9QNCGXa0t8gyp8kDC5N66znHcLlomWsn5vh8rElAF/IpJR5JRiLbA8aq74NqC6Jqqgy4k7uNd3dyzyTkLsXmw9DykejIKV7VB8JU919BHqHkt9WwKsNxZPcWwOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389686; c=relaxed/simple;
	bh=t/mWWBqlN20Gr9eu9EYsATykHkEr8EqnJpkVfmVGCdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B91Wh7+iXCpuwtvhpS+FBz3hj7rH5j1AYj/s69YtMlZjM038tYoVz2Cco7fJO/fRckqtsVRaFKPPjo8hLuPd8+pdXoaxxwEFfrE+Et3PruguBDBEOFl5mGLnMmObJ7OkjQEQyXnvpLJYiOtxDLQP7mntoBoJzZIIrgBkBn3Ba/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P2B01mz4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P2B01mz4"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46d0a8399aso948440766b.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 11:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711389683; x=1711994483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wkIUu9uGpTzip2AcYQXgAGM2WosJftWAFFPuVNiUa/Q=;
        b=P2B01mz4W/1GMQEXgcZF0TfHp4bcRz4tFNI0h7WVOBvE9HRICP/NLAOOWghxwjs+wp
         WtXGkpj0Sv1OBFX4dc4YIpybUwuYb5sEqeZZNzNLb9t84b6YL620gh8wn3cNvATJIlC0
         C0CTDZfZtootNakenh1InZocT/2es9VVDvhaIekau8qbON5J80ZfPiw/YKKHVsqiTuK9
         +YjfShy3fdkpOb+NRZAjwxuVR/2w+bvccnG8dQNU0uvin3AgFSKQxIjQMLItG8JkeJ1H
         4jHYm2G2MyBHRwWD0ih3cdxsgJ4saOuBqK+MF1HUUC09T4ypORp0xDgp1an8yEXUEvWs
         S1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711389683; x=1711994483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wkIUu9uGpTzip2AcYQXgAGM2WosJftWAFFPuVNiUa/Q=;
        b=EJtFOYHvmfLBKn52MElA47O4mUMZDWhXZZ6aZW+0hkq4Ek1X9WWr5HbpLKs404yDzX
         HC93CTcur9xL0mqwQ+jlgG/NzuLbdtOmtA5fMftNEMukXpHi+31rGUKAZ3I1H7Wi91SQ
         twwQdlbRNZwt+Rko0AbEsNb8/3xlmHb5+6c0hUNIE10wb/dzACfErrUYP6T3COB6iSi7
         34eHNhJvP80yLQYcuqTebFPVQ8REgbSrG0F3TyXbp4Tw9e3eng7MCFQh8CcSFRfGhN5W
         oMaTdLXSUCe/cgnG6wPOAYCoOooRhHSoB6E9Lj8+YvFG8FllUZSIESK2K0FTOUV3GH4E
         3wOA==
X-Forwarded-Encrypted: i=1; AJvYcCWxxjDKQXOV335Eff5epR1lPf7iAbtOaABWCi498R0oysWHrCXH8hU4YvNSKrcVVPtDn74yLJdiK8UFTjVkd4g17BR5
X-Gm-Message-State: AOJu0YyAsoLzXG3O1k/mcaPnaVX860BupYiYKOBfgn2s+PaT3T/sC6UL
	HNvqkq4gHuO+E1WiQ9uFgR27Nknko1XKF8t5JKtNrSkR62NZ9XlLOBY6gVkv1g6G9NPtiQBfjpC
	Z34nt5mVfPn9dsAHOfTB9g5AyAxhf078UAqVa
X-Google-Smtp-Source: AGHT+IHhQ1GTKvsQFesur8ssWNbtCFnS0vrBusSAWNEUXOoDtgsFKsXjYInnYs1b80lLBz5oIi74/BU5x8yNA5dLRQs=
X-Received: by 2002:a17:906:2687:b0:a46:bdfe:225b with SMTP id
 t7-20020a170906268700b00a46bdfe225bmr5918395ejc.11.1711389682807; Mon, 25 Mar
 2024 11:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710840596.git.dirk@gouders.net> <cover.1711368498.git.dirk@gouders.net>
 <xmqqsf0ekxpu.fsf@gitster.g>
In-Reply-To: <xmqqsf0ekxpu.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 25 Mar 2024 11:01:07 -0700
Message-ID: <CAO_smVh9TBiJivDrB6wFhAS6adKRqFiu7FE=H5ui5yQ5ssiuqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Fixes for Documentation/MyFirstObjectWalk.txt
To: Junio C Hamano <gitster@pobox.com>
Cc: Dirk Gouders <dirk@gouders.net>, git@vger.kernel.org, 
	Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:50=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Dirk Gouders <dirk@gouders.net> writes:
>
> > The 3rd iteration for this series.
> >
> > I tried to credit Kyle's suggestions for 4 and 5 with Helped-by tags an=
d
> > hope it was adequate to do so.  Actually, at least #4 was a lot more
> > than a Helped-by, I would say...
>
> It seemed adequate, at least to me, but I'll leave the final say up
> to Kyle.
>
> I left a few comments but overall the series is looking much nicer.
> Thanks for working on it (and thanks for reviewing and helping,
> Kyle).
>
> This is an unrelated tangent, but I wonder if we can come up with a
> way to find breakages coming from API updates to these "tutorial"
> documents.  The original "user-manual" also shares the same issue,
> and the issue may be deeper there as it also needs to catch up with
> end-user facing UI updates.  In any case, we somehow ended up with
> two more "tutorial"-ish documents (MyFirstContribution.txt is the
> other one) that somebody needs to keep an eye on.
>
> Ideally if we can have automated tests, it would be nice.  Perhaps
> sprinkling some special instruction in comments that is hidden from
> AsciiDoc mark-up to help our custom program to assemble the bits
> into the state of the tutorial program that the readers should be
> arriving at at different points in the tutorial document, and make
> sure they compile, link, and test well?

On another project, I've had a (separate) test file that just does
what the tutorial says to do, and there's an automatic notice for
"you're touching tutorial-test.sh, make sure you make any required
changes to tutorial.txt as well". I don't know if we have that second
part available to us here, though.

> Or "follow one of our three
> tutorial documents to the letter to see if they need adjusting, and
> come up with a set of patches to adjust them" can be listed as one
> of the microproject ideas?  I'll leave a #leftoverbits mark here, but
> what I want to see discussed (and eventually implemented) is not the
> clean-up itself (which can go stale over time) but the strategy to
> keep the "tutorial" material up-to-date.
>
> THanks.
>
