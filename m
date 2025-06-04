Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C78256D
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 02:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749004361; cv=none; b=ZycnTzK85Ou7s2l+Tut7ryCoNwpdY0LElBiy4OrRGVMsHMMdaA78y1OE6jzry8EPCgE8ngF+jNGTDOkaaeHbW9DqtrBTiZNQcLMyMeN9PYATvnFXzA4sCobzM6M1zC7/zmMEUwNsCaZqUQGeDeUqJtJ9qS87P5Y0F1E12eg1bgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749004361; c=relaxed/simple;
	bh=Dd1mg5hE0YeEErFj4qDhOYBXGLrM1b0AeTP2wtS0rbI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=LUAzQlJe1TtRTSyTjCmEpO1THu5holXpDwIi7S/cf4/pwcXwiPdmc8y2bn/CI7XEg5XVfNAnP6lQKd/fI2x4TLnQBu0PIPf91NyKJ3hKmPKleZDkISDlMINH/sSP3A5UC8ZEjILdsEtlKVpzL1V3pKf5TNMGAkqyvKLT1iVaRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPN+Alvq; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPN+Alvq"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e7f6c5978d2so4663503276.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 19:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749004358; x=1749609158; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5njpH/KfNdVA8935SDLjtVb/adhkCEnx8dnFIvVr7d4=;
        b=SPN+Alvq/m573rB+5C1S7CPdaV+uVDcHZ19wKHq0A1N3ZPt+z+/7Q0coT3ldWBQ5cY
         hjg7XNjJ3LoR4v1O4SkBBdBSZrgYmu8dJdZO3zmGqP61aYVVSy1BORUnCYNwUw6qdOtw
         4/wnR4VfOL0KxZO4Eqba2MUdsgiB8aVVEWcDS43ARAwlPvhEvUc/b/8VpYbmdssgPW8o
         aUjCIjlH61VNYXAVU5M7jAXvzPxy4I+K+AIojp54IDnMq/XmIWP2vfQsWh9MbzL7H97/
         f0YKBMs8lCufeirxEAzduEQmGrX4WN5P1ulAKvCJOS7+5aUXYL/PcGUpCge21MPKUHVh
         rhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749004358; x=1749609158;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5njpH/KfNdVA8935SDLjtVb/adhkCEnx8dnFIvVr7d4=;
        b=gNcyy5IVMltyAyslN2PDPvPCqSTc8kleALerOL2DMHcQONWj5uenigxGfadgDDotqW
         jhDAEDjnd540XH5b2elVfzIw4VUqyd2zCuV4wQd5902t8/NtWgZAZ/AM7YW/6sS1zxnG
         bmR3DOe+nt5YO7MXEk2rYPa+JH0hQ6rMaZ5N/Zzp/Wjvnl5i9oJVQP8YlaALKmra8mz/
         KTYVQilvBlX5dU4QJ8lPQVTB0i1KGT3L5ZlW5lBHefczrvXpIvnACrPR3p9L24gFZNiU
         w0Mu37TV8Rz/+S0agenBVmtUB2QPyQANYHykG2mvCr3eKNrnHGnIy9mez0k8+ADA3f7m
         8tVw==
X-Forwarded-Encrypted: i=1; AJvYcCXy7X3wkt57fcrxS3zyb/Ph2MqJ6IAXbouHfHrf3aoh59AtWbLq2Gi1Sycijf1SR9nLbVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp24Htmsm2TaMy9zGCadm9APAa2+gIQ/UBmdOMpD1+vlyDGy9I
	3bgVSVFuOW4NSojrGVJMMC93bij9mZivF9BOvZZoePSZKJZei8Wvu67y
X-Gm-Gg: ASbGncsV9p7AV4HjdhPw6nNE6uwEnnG8YKF+yQ/eAJNNjSR15sqyQbpBN1QxLcWmbnC
	uW9xcxGdria0iXHENygWXLRai4ZRqgseOyGXtnAv3TgiHYth18BP2jaYI+vdKIbvNCtnc0BmT7x
	4IOfs28q1dPwtPsOBfBzv+oO7rKwQOC1Bw6Cyay5rKap1aY3v3FHGQ9r08HfqOoSEQTKmtOERpT
	f9b6LTlccGFelE2qu6wg0TcV2PIWF6tcaadNNJ64ulLmNiwEMPlXpNVjsCJmsJ6ms7NHqDv3xQF
	80dJ9eq8cWCVihxSwGHVJrXjdoiPswFfMWLYw9lzMVJpuynLo9rpV2mRQ4Fv+zKp6p2YLbHaL3+
	CLQVEmMbHTMc1K/I=
X-Google-Smtp-Source: AGHT+IHjh/loCt1viFqgDO8aZVxPldOmZhB6LkxozWrwxmCT7EmfY9EYRXoxFNiagnKwJZFMTsRDsA==
X-Received: by 2002:a05:6902:f84:b0:e81:29bf:2da with SMTP id 3f1490d57ef6-e817b3c2b16mr1099264276.5.1749004358530;
        Tue, 03 Jun 2025 19:32:38 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a6:1600:9ca7:9478:f3c6:e1eb])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7f733ec598sm2959286276.27.2025.06.03.19.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 19:32:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 0/3] diff: add pathspec support to --no-index
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <xmqq1ps0il6k.fsf@gitster.g>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
 Jacob Keller <jacob.keller@gmail.com>
Date: Tue, 3 Jun 2025 22:32:27 -0400
Message-Id: <CC5E400F-F354-44F7-8252-B4F5873E832D@gmail.com>
References: <xmqq1ps0il6k.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 3 juin 2025 =C3=A0 17:12, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BFJacob Keller <jacob.e.keller@intel.com> writes:
>=20
>> From: Jacob Keller <jacob.keller@gmail.com>
>> This series adds support for using pathspecs to limit the comparison when=

>> using git diff --no-index. This is similar to how you can limit what is
>> included with pathspecs when comparing inside a repository.
>> This version uses only one set of pathspecs and instead uses some logic t=
o
>> skip past the root of each directory tree being scanned. This avoids need=
ing
>> to parse pathspecs multiple times, and is overall a simpler approach.
>> I also opted to add a match_leading_pathspec() instead of exposing the
>> match_pathspec_with_flags(), since I didn't how DO_MATCH_EXCLUDES wasn't
>> exposed. It felt messy.
>> I tried a couple of different methods for skipping past the leading porti=
on
>> of a path, including skip_prefix. Ultimately just the index to skip to
>> seemed like the simplest solution. I like that it means we only need a
>> single pathspec array now, and that we no longer have to worry about
>> changing prefix_path_gently.
>> Changes since v3:
>> * Drop the patch modifying prefix_path(_gently).
>> * Instead of exposing the do_match_pathspec flags, create a
>> match_leading_pathspec() variant that sets both flags when is_dir is true=
.
>> * Use some simple logic to skip past the starting portions of each path
>> before calling match_leading_pathspec
>> * Re-write the commit message for the final patch
>> * Add a couple more test cases
>> * Simplify existing test cases to use --name-status
>> * Drop remaining TODOs
>=20
> Anybody, other than Jacob and I, interested in this series?  We
> haven't seen any support or review and I am considering merging it
> down for the next cycle sometime in coming weeks.
>=20
> Thanks.

I have no code review, and the docs look good. I probably would lean more to=
wards other tools for diffing (non-Git) directories, but I don=E2=80=99t kno=
w which offhand, so I don=E2=80=99t mind extending Git=E2=80=99s existing me=
chanism this way. It certainly allows some interesting commands that I can s=
ee myself taking advantage of, and it feels overall like a natural extension=
 of the interface.
