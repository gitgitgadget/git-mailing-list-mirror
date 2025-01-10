Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3EB24B234
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 19:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736537638; cv=none; b=HxQGXY5ZbpN5KGVn+1kQc6a8/goezLXBHwE1vZxyJ53OELygpd4ME/+LGeX59xoOQYiW7OHyEtkY9ifNG6F0zpduudDEVrV4xefRplyEaRq6tilatbtFNIIh+0RBqCKHZbqeZwe8QM2IvhcTlvcSmyqPy8MCBvzyn9HNB30kyFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736537638; c=relaxed/simple;
	bh=fCHjL+SBGmK6xDDf70jEY00kxeudtr3KbpPbdSRyWfU=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=eWMtdcc/1//rs1cb3TRjnjtY2TsIg86hXPKebPuM4Ebf54CRjHMeFGnRh0xeQCAnCCtpRd0/0o20gzfcaQtdpNtXZMyIk436ivyvachQjfcvzvrW36Dfa0YedJ4vGOJGm43/Km8Q6c9SlIxisHWB65gimzOUM4LHk+h6gXXHy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hF7GoRD6; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hF7GoRD6"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2162259a5dcso66157955ad.3
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 11:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736537636; x=1737142436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+JBPqMPe0pmRsUn1vAW/81oWQGVkqn91uL+RpkhLxMg=;
        b=hF7GoRD6lCjpWK9PemBQWhG/JaYB9U8J8RpYyIycBoNkqNkAMpRabEkIIB6mQoeuVM
         ZXjYMms3PJdaFibxGcm0JiQ6NaE/dHGqN9F/ze0QryIsfvj9tucHozjngQAKQWv4TYGw
         8cEiRWj/ClLgo/FHPuAv6eMeIgxj8C+Zf2vvKXTySdKkPN2CJbOLZ6/dW/xN9oT1ytYB
         b2brH454p6pqX/shGHtzMbLjDgkzZ7+WQLfEntXIEypAegO4kgINAW5ZOOjM8DZTncOo
         wuCVkqTa+KsuQt4D3CSyfX8SNkl1yXSFAycMHQx7abiVfzhkzcPW2fV9VgPfCHqj6J3s
         kdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736537636; x=1737142436;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JBPqMPe0pmRsUn1vAW/81oWQGVkqn91uL+RpkhLxMg=;
        b=tnEXBpoLUUpKK3E8bIzmIe64ZA4CjNJfQHX0cwzeWTjBnYJb8ubc391lzKywnPKwCO
         48VAtLUSFPi7CD7iZd05jqFPVPikIeSd0tBBT3OZvP2w3L8qFlPu7Myk9TDSggzJDHbF
         9N7sxUy84b9CTTcwfLFzVyxN7F2msyQ2yYeZxjhvD16twNtsEgAFuG7vJ27geXVFLrCC
         +gfM2ag3JK0/BWQSRz3YIOr3Y55i6WLW2vS1PmR2RHHgJ4VieARjM2N6pA8D/q4PuVxP
         iZXEaJ2hWwyJU7poji+p7bgNa4xwTQDzMbHurynq2C4nFtDv5K0stu2Mfzn/T1A4VSGg
         16+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6GtgzLs5+9eo3ZVNTJ7CQM91GMRJTTRBrsce40ygO/L5rlACNxTf8wXDmKoaQ/pJt0+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSZABU0SUnqIJMMCcwd/pGA30b5kr1Pd+oGoX0kmvovAaIUnvB
	1F8ZzULiKVPpaR0YTfa3gg/rKBARtiabxNU21Mp5dCX0viL5mLmh5nJfnnEEB5Hm0Bc2aY9JAxR
	IHScPCenylaNQfWTEsPNR0UUA3GiJyQ==
X-Google-Smtp-Source: AGHT+IEOwfSSlsvxaGOn0qTTmNrabwwICtzaD6Q+OZdMLO71OcjHpEP1DcfRz2ABkvL2gq1uP+vtKNJhlj5CKN5BEpDK
X-Received: from pgdo23.prod.google.com ([2002:a63:9217:0:b0:7fd:4bf0:25fa])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:158c:b0:1e1:aba4:209c with SMTP id adf61e73a8af0-1e88d361a70mr20155065637.29.1736537636020;
 Fri, 10 Jan 2025 11:33:56 -0800 (PST)
Date: Fri, 10 Jan 2025 11:33:53 -0800
In-Reply-To: <CANiSa6jtwizbR4K-DqdKjVeZqAkbswnPXCBZZrrfNy2CKBEQVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.688.g23fc6f90ad-goog
Message-ID: <20250110193353.493374-1-jonathantanmy@google.com>
Subject: Re: Histogram/patience diff matching lines with different counts
From: Jonathan Tan <jonathantanmy@google.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Martin von Zweigbergk <martinvonz@gmail.com> writes:
> After that, "c" is unique on the left side but has a different count
> (namely 2) on the right side, so I would have thought that it should
> not be considered matching. Does anyone know if it's implemented this
> way on purpose? 

The purpose, if any, might be lost to history. The implementation of
histogram diff in Git seems to be a port from JGit (8c912eea94 (teach
--histogram to diff, 2011-07-12)). The one in JGit [1] seems to be an
original extension of patience diff by Shawn Pearce, who has passed away
a few years ago.

The class documentation comment in [1] does not give any rationale for
or against rejecting lines with different counts, but quoting from it:

> * By always selecting a LCS position with the lowest occurrence count, this
> * algorithm behaves exactly like Bram Cohen's patience diff whenever there is a
> * unique common element available between the two sequences. When no unique
> * elements exist, the lowest occurrence element is chosen instead. This offers
> * more readable diffs than simply falling back on the standard Myers' O(ND)
> * algorithm would produce.

I think it makes sense to reject lines with different counts, just like
how jj does it today, since the original motivation for low-occurring
lines in both the patience diff and the histogram diff algorithms was
to keep high-signal lines (i.e. not lines such as "}" and "return;") as
context (instead of + or -), and if the count of a line differs, it is
probably not a high-signal line in the first place.

I don't think it's worth changing it now, though, especially in Git. In
the scenario you describe, even if we change Git to reject lines with
different counts, failing to find a matching line means we fall back to
Myers, which matches up the only "c" on the left and the first "c" on
the right anyway (so in the end, we still won't get the result that you
might want - reporting that the whole block has changed). (In jj's case,
in which there is no fall back to Myers, I think it's reasonable to make
histogram diff work only with non-different counts, since the lack of
a fall back will indeed mean that we report that the whole block has
changed. This sounds like the "highly ambiguous" case that Bram Cohen,
the inventor of patience diff, mentions in [3].)

To further complicate things, in both JGit and Git, a line with
different counts is not considered matching only if the count in
"A" (the left hand side) is greater than the count in "B" [2]. I can't
think of a reason for this asymmetry, and the class documentation
comment in [1] doesn't explain that either.

[1] https://eclipse.googlesource.com/jgit/jgit/+/refs/heads/master/org.eclipse.jgit/src/org/eclipse/jgit/diff/HistogramDiff.java
[2] https://eclipse.googlesource.com/jgit/jgit/+/refs/heads/master/org.eclipse.jgit/src/org/eclipse/jgit/diff/HistogramDiffIndex.java#206
[3] https://lore.kernel.org/git/alpine.DEB.1.00.0902052113590.7491@intel-tinevez-2-302/

> As some of you know, I work on the Jujutsu/jj VCS
> (https://github.com/jj-vcs/jj). We also use histogram diff (and only
> histogram diff) and actually allowed matching up lines with different
> counts a while ago, but I thought it seemed too arbitrary to line up
> the first matches if there were different counts, so we changed that.
> Then we got a report from a user that Git behaves differently. See
> https://github.com/jj-vcs/jj/issues/761#issuecomment-2581219294 for
> more details.
> 
> Thanks

I think that it is unavoidable that different VCSes may produce
different diffs. Even in Git itself, there are many options (including
which algorithm to use) that can change the nature of the diff produced.
