Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21001246327
	for <git@vger.kernel.org>; Tue, 20 May 2025 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751827; cv=none; b=HtDTEC4CJqqtk+xLKGgEGgJ0ttANRE9zUgNpAGahygcooO/osLqwEBbFeiw9eoVuoCQUXpIfxG60TGNLM8N0WHcGLnt7SNrXvrIPHHSENB8VWpxMsmRQhWJu8IkJrm/ACI8JRsSlrF/0IIet2kysHEWVhgSf8/8SOjKeLV2DpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751827; c=relaxed/simple;
	bh=pJ+MP8nLXfemf7dhCYac+aE/Q480rX/9CQXpdMYC7aE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pVZL9B+VOeqF7XIZCazJDoKeVumn9Ad7b4FBTntdhh+spdjc/Cwy7tuib2QoG5mhdY37egtw+XNmTCqbblH1Bt53OArUgMxUaQr6y0i1toKJuTMLWN07N1feODhHhEW5EScUvU63RD+bnSszhaUL+ftjdK9UcJb87rEwSXel5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlAzQsUf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlAzQsUf"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso947160966b.3
        for <git@vger.kernel.org>; Tue, 20 May 2025 07:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747751824; x=1748356624; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjsJQju5to5PIJLOSxCrHEeJszejbpPKBsLlOOqloNw=;
        b=mlAzQsUf5vk91CK14WQTL/LfWOpPfT7+oTprZ8rMm6waC03WBemXoNfe4/t08dhFi2
         u7dTWqGaOaac6GRYeccRTCtWZpmWBRKNevORjMKKACqdl91n0C6BKZChIsy0yv/3naZz
         JGlzT4/6R95DQ09L5c0x3o8gLIPeqWstTk9f+1KH9P27nmMQUZYzsI9R0Oxat6+jLD/i
         /MHeDTs/aDZtduudlmD3Uk8HC5GzwODz38cG41Z8pSDkkYdLcGc4PrnvdFWI2YTtZdf4
         qpVmO6hiwS/k78XkmlbypgYC9le8qwegXo7CemE3KzHsKGz443cUCUxIjmJuf97QYimK
         HNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747751824; x=1748356624;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjsJQju5to5PIJLOSxCrHEeJszejbpPKBsLlOOqloNw=;
        b=fbk/43V05Je/SnV7xdFNNXymc2bbV7PuPQEkvM/XrQMK3/jUAAvV0tMV0NSKcxhxox
         HEyr/UaXSVoWcNi2V3E+RlAeonhDZ3gggurJbT9FImeqouF/Hrsn9qW4FPaNN2I6k9Z9
         ZmgXrQjVPrdjYMZGg1IJ5i0iZKg1ea4qxdtYEIsDjteTSD1lMuY5E654wTMlJOp0qt+b
         TSN2yiXbe4HLZbHqpjQ+zZP+sC6rVdkypHnL2Dffw6fLZgPBxyAbdLQwswW1T17fiIny
         OaFnqZHJIi4OZwJ6DoBAMAAaCdobUxH63AzVU/wEVwmWd+jRnYYjuhJXptQMoHqFQT6s
         VLfQ==
X-Gm-Message-State: AOJu0YzkxbUDGyZl4xY9701s+U8XoBdRBYG/xS0ptgdeIWoAR9syM4ew
	bUapbms26SBYFH1rFfxsqU5KJS7gTvEXsYxn/Y1FAiMsw+RfMPqd/fk4jejga1CEhzaxR/5PZ5l
	sSag5L+v/okKmeYuov0Ih9poE6tMJGD+0Dg==
X-Gm-Gg: ASbGncvX7gD0C/cF45n2uA6jV69uZmvhNn6pvAkbx/KhO59i3IuEjZnK1d/RdpFzLvc
	eaVgrTJPV6AHG0ztIVV4UMOQWTiMoKYVuRO/fTq1vCMjf90t8/cketsY6ie5TEzAHji2urJhNQc
	gK/VybE9njpePiML6QFa178c1cD/AHCUdhCi2oyQL+i1fm95JHqak+qmuNm9m3XTshhok=
X-Google-Smtp-Source: AGHT+IH1VOwoZWztp/+UfP+N64wWK2gPquNkptTwTX5wyXS69F+OlrM1ZE5pAFAEIlC05g8qB56mLlv7yWgtBUlhRHE=
X-Received: by 2002:a17:907:6d06:b0:ad5:7732:675b with SMTP id
 a640c23a62f3a-ad5773276demr655358166b.40.1747751813797; Tue, 20 May 2025
 07:36:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
In-Reply-To: <20250510183358.36806-1-ben.knoble+github@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 20 May 2025 10:36:42 -0400
X-Gm-Features: AX0GCFs8FX2AYy9ZmNmMPpVs6nsNzDDarTc20LVzZEdAEHc6iEtwyb-kDdtSrm8
Message-ID: <CALnO6CA0S_54HjyNDWyTAhfmRFcTsFEMF67yWjMeL526O14aQg@mail.gmail.com>
Subject: Re: [PATCH 0/9] make stash apply with --index by default
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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
