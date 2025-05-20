Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BAF248166
	for <git@vger.kernel.org>; Tue, 20 May 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751959; cv=none; b=uKrXHLxQCuc9Hzb6LRBxmbfBDCcs7jpwE5dIJRgWOpwoLZkcKeOIuufBERFbrUAdDWn3Iqzu0iskccRcpHj5zr7o4kRukbp1RnTvTZvpe6QZDrJGqppnUPRNPZsx7zXdh8QfnPvjg+JaUZG9m+QA/9JREGQSIptdaveOqOm7Prc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751959; c=relaxed/simple;
	bh=3BNad44s01WGP1oyKZdo9whx4nPvU1jZBEGwdV4Nm5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLWT6sJ20a//jhmBESDLi/0xNpjeYTdbdx5PI7ysk+TY+049uydkRHIhLqn8LBzqQBpYmtzCoXa5AStjx0b/oPwkNxCED/bWay4viixWejdncbSwm9mn5N7cxROVvbxyTam92+hPn1MXcSjQHlgQpex0kPzEdpal+OPPRKqMoAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRCFH2kI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRCFH2kI"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6020ff8d54bso1318297a12.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747751956; x=1748356756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=woTDtftsaBH0Rr+G34mrsCSDVGfzddCuj8vVrn5T6jk=;
        b=dRCFH2kIRTIF97rPPO9+vgeJVbPOhQNWlUUpFgca7F6oHbaKVCiNm1Szr7nt3v4tDj
         kXObU1IK+VNXCH1iLESnqsuRn+SnOQtHwdEF3bDkw9Ob6Zc2K8Zvno2L18co2oR7dPsQ
         jGZgBSz0DDsBeLCKDJ8NOSniiPscrOw50W9DCAXbQ+wcGO3ht5KqnMJD8p3IdJx8BmIY
         JNwZ5Jw2V5vxxWMum7kDfzmxV5OYqrrd6WI/Rjf5Vuyuv1Zb+RSCz8SFd6RGhvQ8awoh
         6OyUU8fs21WdgDIFi4qR1FAs9LJKs0pCk6oIlInbtM9iqzGTyHdEXbs3dzwi11CAz8QT
         E8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747751956; x=1748356756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=woTDtftsaBH0Rr+G34mrsCSDVGfzddCuj8vVrn5T6jk=;
        b=wBI316JMXFTCEYIGo2zaoKeXygs5ds8/1HCrNOSPBSb+nq/qXv4S00SdDUoHucxCkX
         HcP9SmZvx9EU/IKE+r5Uvt7xYmYRB4yHyfvjkzfYihprfFDck3MQwP4GYlcT4+i8CON+
         +l4PqO/Nbm48z74Jj7O2fyoejFrSzbpi9NaMaruOpz7X1viQyVeWkH4zlLEqGSn+Z2WA
         0sDHDyy9UCFLs7K64Qq3uEf+6O3NO71igpDAfR+uoboHOO++zZARokssg+9JD+YIQswI
         AXpVXsnRP5RpzHPrURR2SSyIpV+V8Ei9dATkpgVIbpevrEKcS4bgE3s+f5bG//RfcsAY
         2EaQ==
X-Gm-Message-State: AOJu0Yx5Uf9CTuFZYHNNSe6jJjl5lu8mjBb1OdANrm1pqfEElDVf54mY
	5J9qO7VVQANXPCcdhHuzS9hPqDnMc1oPAK5H/77f/0g2Y/XlXUERMhyTXOQmVEc/G2mTtj6jK7q
	pghI2FkMfLmnlFxnS9KVbjZyLZPZgEHAMVmxK
X-Gm-Gg: ASbGncu+X6lQT5PMJ4rGWTaQUM4unzAt2F98DsZuWZEllURLzAzXPSf90hyoCgDlXYH
	ASv3hgkSiifESYmmEXLedLEHNzh6MGlnz59Q2TKGHFmBiBXQA7+N9cDpbteiqBs/T9w8KMTxGyk
	ueg3qoMpbrRJV1pYs+UNZ/7O+Tqbg8SZTp3hGtvLIFI1NOmdsELN1ia6w5QyMhWLmpF+Y=
X-Google-Smtp-Source: AGHT+IENkjMDR1TFM7WVfrOYJmIsdXJRF71KEJUnJ46wSIwCYQtkhUlJH83EDxsjunkNFZu6rv4/ndy8VVr0JPKfIpY=
X-Received: by 2002:a05:6402:2112:b0:602:266d:5865 with SMTP id
 4fb4d7f45d1cf-602266d5b7dmr725456a12.9.1747751955887; Tue, 20 May 2025
 07:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 20 May 2025 10:39:04 -0400
X-Gm-Features: AX0GCFsxi6qqBBM5oqbVauln3tOtvt64NcLO7fayRJSS1Nsb8aUZA-hfjxeLdQA
Message-ID: <CALnO6CB=2ih-_=VUth=PJZxGkz_GA_mUfWd6gQOFcd36eUpD4A@mail.gmail.com>
Subject: Re: [PATCH 0/9] make stash apply with --index by default
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Denton Liu <liu.denton@gmail.com>, Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Apologies for re-send; mis-clicked]

On Sat, May 10, 2025 at 2:34=E2=80=AFPM D. Ben Knoble
<ben.knoble+github@gmail.com> wrote:
>
> Since git-stash's inception, it has defaulted to stashing the index but n=
ot
> restoring it. This has caused some confusion: change the default as part =
of Git
> 3.0 to unstash the index, too.
>
> I ran into this myself a while back and did some digging; it appears that=
 other
> have been bit, too (see references in patch 3). Moreover, when git-stash =
was
> originally written, defaulting with --index was suggested but not impleme=
nted
> before the script merged. So this RFC should bring us back towards "less
> confusing," hopefully.
>
> The series is structured as follows:
>
> Patches 1-2: unrelated prep/style commits noticed while working on tests.
> Patch 3: update Documentation/BreakingChanges.adoc. This seems like a nat=
ural
>     place to discuss the proposal, so it contains no other changes.
> Patch 4: make it so in builtin/stash.c.
> Patches 5-9: update the impacted tests. Separated out for ease of review.=
 I used
>     a style more like "split the test into 2: one with, one without break=
ing
>     changes." In retrospect, the diff might be smaller (and the 2 version=
s of
>     the test easier to compare) if I used "test_has_prereq" in the tests=
=E2=80=A6 but at
>     the cost of making the tests harder to follow. Thoughts?
>
> D. Ben Knoble (9):
>   t3903: reduce dependencies on previous tests
>   t3905: remove unneeded blank line
>   BreakingChanges: announce stash {apply,pop} will imply --index
>   stash: restore the index by default when breaking changes are enabled
>   t0450: mark stash documentation as a known discrepancy
>   t3903: adjust stash test to account for --[no-]index with breaking
>     changes
>   t3904: adjust stash -p test to account for index states with breaking
>     changes
>   t3905: adjust stash -u tests for breaking changes
>   t3906: adjust stash submodule tests to account for breaking changes
>
>  Documentation/BreakingChanges.adoc |  11 ++
>  Documentation/git-stash.adoc       |   6 ++
>  builtin/stash.c                    |  38 +++++++
>  t/lib-submodule-update.sh          |  24 ++++-
>  t/t0450/adoc-help-mismatches       |   1 +
>  t/t3903-stash.sh                   | 161 +++++++++++++++++++++++++++--
>  t/t3904-stash-patch.sh             |  14 ++-
>  t/t3905-stash-include-untracked.sh |  40 ++++++-
>  8 files changed, 276 insertions(+), 19 deletions(-)
>
>
> base-commit: 1ee85f0e215f22b0878d0ad4b2445d12bbb63887
> --
> 2.48.1
>

Any comments from others? CC'd folks from individual patches on cover lette=
r.
