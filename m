Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536D1586CE
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 21:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706563909; cv=none; b=YUnT2sqjKo+2Y7NfkabRAr48FdepPf/TsPHyMO8OCpileSkTSkq4hFqOtAd94EirD09ug2L7M13WVvoplPflSuEAVAT4C+pfXTqfjgEMaNzYAj7no5GXyk5Lb+e0KC/C+F32gYHER4Bdf4H7nndzILewJj4jrnqJKLk7+Aluxq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706563909; c=relaxed/simple;
	bh=FWMNrtJwpxcd75k49UMDeuPQTiLmLLQxh75e9InTtfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ch7t5HVd8iv07JVfVr4FprENytFN7H+Xh2Y4mxsCB+qZPCffBY1yUwtbD6e65x3/za/mZGjRSoSaxsvT45XdbEyorvE6BCQtnS+LN1Tbx5je/K3kulKY4BpLZLLEc9XFKpZ1j3H7MYpyZL/YF6pgcFC1+Xky3WYrv7j03XrqvSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org; spf=pass smtp.mailfrom=dinwoodie.org; dkim=pass (2048-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b=WG89fu1R; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dinwoodie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dinwoodie.org header.i=@dinwoodie.org header.b="WG89fu1R"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3be65b20d92so69890b6e.1
        for <git@vger.kernel.org>; Mon, 29 Jan 2024 13:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google; t=1706563905; x=1707168705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FWMNrtJwpxcd75k49UMDeuPQTiLmLLQxh75e9InTtfk=;
        b=WG89fu1RaFqWC6oRZS0cQDbD1/qtRhSuMYp3tRSvNigLXwv7Up9w/uUNupHPNTRoMk
         BtRWpBFVY9270cXXcDZTnqhjHVtSpbOxrJgrtf0OV1euGW+MLJeX30qRGL8dwXPFDwsF
         VRlFJTslmsJ9bL75ELdqlJr92n8bL4RjE7nL672qhATeOlo43GZQk7qlQkDnuPXKWk5u
         QL5RpWyLAVTRFpAQ/JoHfzMc5HsXqqvuCvFRUVTzYLoqSwCVwk5fSuo+NKMe65ZpvbC6
         2xLAK6+PtWd2HhYB901eZ7NqcUBJh+mS/fHAI5J+sh84onAb0E7MDbXVdXTwuOuPKrhv
         5UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706563905; x=1707168705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWMNrtJwpxcd75k49UMDeuPQTiLmLLQxh75e9InTtfk=;
        b=a47FwvZthW62HYoIQxm3cSIxRgBvSjbT5Wi9PGK8sSl3hRQqTrK33auXIhVU4Si6P1
         GZ0CpwiE2CeTLZeKcPqxyHqJYV/xG7bT+nmJF1Bi+sZe9tHl4MNhtsor7UnJHecfJjbW
         KkcUFvtpUKpn2yIMKEjPgD2Uroi4RJYL+poePTZWRJs1u48HZO4fv1xmD+H6dKaW3uob
         Cg4KS9v8QCurHsacNYe1F/o2iCjrifpw/tVKJtmFW/l9hHBiCQLbOhi4eiDI6pODnFGT
         NirvJXBvkyQLI+tpZXN8nlPXLcvQAoWQ9viqbruCfrw79W9tDIetAnmt5747FVmyTtAq
         QDRw==
X-Gm-Message-State: AOJu0YzpuvnNeHI92Y0YpIsld077iUu8bpzuTiPWTmn8puEtOVq+zhlH
	sUkhyeNaidHkP6PKQpCWXredTv+vkeszFQbrdaMIUWIcYGsSyLrJ9kQ+jRCOVMdKIiUUPx8q2kM
	DGFYDMGgcjhy7sEI6MblPKWNAIsYzTCitq6KHWBNY2R0g24A=
X-Google-Smtp-Source: AGHT+IGZdYKCzwb/8X6JRR1ISGI/Ssv26YSTeHCY7+2d8skRUPC+u26lJXVb2xyriewmxwmAEn5UVTNwlqODlu9Hf3c=
X-Received: by 2002:a05:6871:b1e:b0:214:b796:73c with SMTP id
 fq30-20020a0568710b1e00b00214b796073cmr8597255oab.5.1706563905733; Mon, 29
 Jan 2024 13:31:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129031540.GA2433764@coredump.intra.peff.net>
 <20240129031933.GB2433899@coredump.intra.peff.net> <ZbeLcrjIYd4d7PaB@tanuki> <20240129174918.GA3765717@coredump.intra.peff.net>
In-Reply-To: <20240129174918.GA3765717@coredump.intra.peff.net>
From: Adam Dinwoodie <adam@dinwoodie.org>
Date: Mon, 29 Jan 2024 21:31:11 +0000
Message-ID: <CA+kUOanDydgCEax9RFu_xVXkx_LeiSPOoWiUpwAg=EVQxSDJRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] t/Makefile: get UNIT_TESTS list from C sources
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 17:49, Jeff King wrote:
>
> On Mon, Jan 29, 2024 at 12:26:42PM +0100, Patrick Steinhardt wrote:
>
> > > -UNIT_TESTS = $(sort $(filter-out %.pdb unit-tests/bin/t-basic%,$(wildcard unit-tests/bin/t-*)))
> > > +UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
> > > +UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%,$(UNIT_TEST_SOURCES))
> > > +UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
> >
> > Wouldn't we have to honor `$X` on Windows systems so that the unit tests
> > have the expected ".exe" suffix here?
>
> Hmm, good point. It seems like the answer should obviously be "yes", but
> Windows CI seemed to pass all the same (and I checked that it indeed ran
> the unit tests). Do we only get the $X suffix for MSVC builds or
> something? Looks like maybe cygwin, as well.

Cygwin will automatically append ".exe" when doing directory listings;
a check if the file "a" exists will return true on Cygwin if "a" or
"a.exe" exists; a glob for "a*" in a directory containing files "a1"
and "a2.exe" will return "a1" and "a2". This causes problems in some
edge cases, but it means *nix scripts and applications are much more
likely to work without any Cygwin-specific handling. I *think* this
logic is carried downstream to MSYS2 and thence to Git for Windows.

As a result, I'm not surprised this worked without handling $X, but I
don't think there's any harm in adding it either.
