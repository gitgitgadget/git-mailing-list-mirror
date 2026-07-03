Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A9E1A267
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783100240; cv=pass; b=IQWmHXxcB1mZRuHLdhEmPKmg+pDeXDUscyWAd236h77nVQA4qtjAXQmS1cRkdRC1RuDh0WC97anzGWJE3VMjmAguV/ywd+rs4RTBxKAS5QPhrqfHC98oreqDnDINJnrl0/t+Yb5bTkI6r02RPj83WmaN/fuYHL6BCJ7zrDShD7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783100240; c=relaxed/simple;
	bh=tClpMOIQtUMfzQJ2UeTRBFI54T8jMGYoulmKWcm6UKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGz4lISQK0B0/gCC2ZScXIpo3hAL7SoZ+X/1KFXvDgx1PvflmjkTgILgDcKixYxOraJJiE2yacOU0VC1ZVHDjdT2QpmbIkB+fi8aTCBrwHlyZbumoJAYu8a3FdIIVEnG9d1yFxJmnmJteeWpzMrmeumvyXzTpuyWrgfG2TZSYkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vW/6u/Xl; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vW/6u/Xl"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cb59f6ba26so7735ad.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2026 10:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783100238; cv=none;
        d=google.com; s=arc-20260327;
        b=EC4zd2iNvn3xYA8JuAdaqSqU+3Exb4cGG3HD8moLwj7qYL81sboLQxi+LwTxPwbk9C
         AnWirY/f59xL0JrXshHRtPjuc2CuKUi+S8AwOMuZMSQ4T1nWq+Q4r4im5FCCVli74dY2
         q2hy5xUhEPD9+ue5VJ/TqC2ShzJF+TZMfjO+co+bDzjGVxL60XyYp//tXJZGB2sMHtOv
         5Cj25PMX6vwFeY3nEf/mXdn6UW02nLkQckVm9OTeeHdppNFqqyfJYqOB6hwSPfExWTpo
         JaouAzBeWqW2jK0G70w/7/72pjx4ijvGgvVM2OFLpyK6eyIJVa972JuRucHk9gRoWOUi
         vbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nOhdpk9VbsvF3Ase0VR4FTh65L+TVqIMxlWdXjJc2W0=;
        fh=arbRnJs+KH13DHuKTSAufhfXPDTY8z9YKNZ5rH7H1Eo=;
        b=iDCMFm4Z43/oTTlmdOVSmJDK2fEt/nJpApuD3HPJN7vZxFu3gI8Ft8jpRU5c9/I7Xt
         8Pu5hXrL2gE72JPPboUH8L+nQhBW+f2ffsAqgi0aqDZfz5cs4kT+MGmpIvnTJ+qfxkkZ
         oDtiFAqKJz8oVN95FO7GsXtvgJwHxPo/C4L8WHnFy46hODDdbJT21/tjY8LbGgDltBTM
         f1cG1OLLwfCOs94rmTstRjoEkKwuzgmLlxBre2h0VJ2V+lZTYAk9JWyIUBUnpt34fyEE
         5m4ongmoGGtALKQ2rjlqMMhQN5rwtYFE9nmcCgbkagiyznX2QEeD8MiIlcp+HvyM0aHZ
         09Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783100238; x=1783705038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nOhdpk9VbsvF3Ase0VR4FTh65L+TVqIMxlWdXjJc2W0=;
        b=vW/6u/Xl/DQYG++Mq9y5tPF+iE7TW7YcoPYcwYOnygZgI2hMnF0YQCWP02PnLyPdRr
         SM1wXkcVWB+8z09uGbT6QvY/RdMjVsyp8hBLWW+ymBKws5rFM4CUZVXKX5yaYv36K/ng
         i33D1duSy+J3cUlmvTw2xuMJrpQZHU3NwAxig9RM557mclKuNFhKM5FSNdwLQ+guis0M
         xg2nMXcgB6zL0sIcl+yET9cWL9XGymFJnaE/KoumOVrE7/lBC7VFB3hd8l4MOO94nM6j
         uLIVoVvnQJezS4pvFtU1rCg4RgLmh9ec/1c4xgD5DSYjwwCl0CM+zL6joChuI4FG1lUS
         BHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783100238; x=1783705038;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nOhdpk9VbsvF3Ase0VR4FTh65L+TVqIMxlWdXjJc2W0=;
        b=XigD6ZXHntkXGrhmHsO32WQGLpCF6ZEpWXtopdquIaNc/1i674DhcbF6kKkYyK7ENV
         exUNWrlNn7do/0hxCanHXpgOT1fcqilMo+CGbss8NN/jj2WxB05bqN2u/r1ApBIGhBFR
         xYPMlgMVaowBbd3pwjV77nmwc9rY3FTpUHTq2Ccu7nwLI0HMEcRiHwLgqVoLvpyJuS5n
         K3KvkqEs5KM4y7tfhtnzpt5tAdSZ+O/J2rRJENYHFXFIzUsfZRawaguvT7YiumWhS4oH
         qrNh9cM31Dp3yfWz6cOtht4wbZ1T6fEktIgUMDCIOILqjA4e+LH5/MNILeYIDmefLNJJ
         muqw==
X-Forwarded-Encrypted: i=1; AHgh+RpaPS6oenKbdj+U0KFvoxWyON67iqyR/ghYnOmfOM0KKqS615BEwxch9WpB/28RG8ohCjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJ2L0LGiluHLndMWAf9PnBw4itTFcW0gAGO+KTQZMcW+NskFj
	67q/JMOqhtkfLn54+x9RBq0BIPveJtmXmbeFCNQ/NLs6VR66U9pAlyJdfY5xka6k7ixjC1FRfzf
	l/QV9quMwuqM4c7Ueg88mSWDsYMSIEhWMXKKjTppm
X-Gm-Gg: AfdE7ckvlaikcmaoooZX/VeUffK7Gkx4QG43JAFh6lE0RJAMnV6vtNGS0Z4taXc9gb9
	7DLvH2itWvEHiCPhy4XXfNOmN4ISBCePo3hFbj8+yhlILTmu1FNMi9Eas8rEukXlPN6Sl5SlIpY
	ZkK8Ix68NDSMznusttIaxirjkdVyJGaDXFD+cbW4hmgcDjrvrtv7QoDYsXNh+jltIgXXxJUoimM
	0AAe1NzviggvzPyd6ibwuazsxJ9SSoltlJNOHa9sfWVjwFBPbTVkmVkWyoSObj5/jKoo78EUpWH
	tWHK4mTVbZMa0NCUDH9EKTj2gP8CkA==
X-Received: by 2002:a17:903:ac8:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2cb2b650951mr255925ad.2.1783100237351; Fri, 03 Jul 2026
 10:37:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com>
 <pull.2288.v3.git.git.1783030971.gitgitgadget@gmail.com> <257f5ef42fbb2841036591657e740872635df49b.1783030971.git.gitgitgadget@gmail.com>
 <xmqqldbsk51t.fsf@gitster.g>
In-Reply-To: <xmqqldbsk51t.fsf@gitster.g>
From: Shardul Natu <snatu@google.com>
Date: Fri, 3 Jul 2026 10:37:05 -0700
X-Gm-Features: AVVi8CeHWP1gSRG2gyz2y8jJ6fsLf1pFkkfaC3jMXPpJUr4z6RRdsc8Ue2QTfUQ
Message-ID: <CABaQWZey-7FKd7FDTKZ5v7jjuRdTXm5cqJUpL8JKAL+Pom1iWw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Makefile: support universal macOS builds via RUST_TARGETS
To: Junio C Hamano <gitster@pobox.com>
Cc: Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Koji Nakamaru <koji.nakamaru@gree.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +$(RUST_LIB): $(RUST_MEMBER_LIBS)
> > + @$(call mkdir_p_parent_template)
>
> The leading @ is a bit curious because among ~20 existing use of
> this pattern, nobody adds it to squelch "mkdir -p". In fact, the
> macro uses the standard pattern to define $(QUIET_MKDIR_P_PARENT)
> that does the squelching when $(V) is unset.

Done!

> Recipe parts in our Makefile that are written in bourne shell, the
> CodingGuidelines apply.
>
> $ git grep -n -e 'if \[' ':(glob)**/Makefile'
>
> gives empty. Probably,
>
> if test $(words $(RUST_TARGETS)) -gt 1; \
> then \
>
> would fit better.

Thank you for pointing out the CodingGuidelines rule for Bourne shell
snippets in Makefiles. I have updated the condition from "if [" to "if
test".

Thanks,
Shardul


On Thu, Jul 2, 2026 at 10:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Shardul Natu <snatu@google.com>
> >
> > On macOS, Universal Binaries contain native executable code for
> > multiple architectures (such as Intel x86_64 and Apple Silicon arm64)
> > bundled into a single file. This is standard practice for macOS
> > distribution and CI packaging (such as internal distribution packages
> > or tooling like Burrito/Homebrew), allowing a single build artifact
> > to run natively across all Macs without Rosetta emulation or
> > maintaining separate packages.
> >
> > When building Git C code for multiple architectures on macOS, the
> > Apple toolchain (clang) natively supports universal builds via
> > CFLAGS/LDFLAGS. When "-arch x86_64 -arch arm64" is passed, clang
> > automatically compiles and links universal binaries for all C object
> > files and executables out of the box.
> >
> > Cargo and rustc, however, do not support multiple "-arch" flags or
> > emitting universal binaries in a single invocation. Instead, Cargo
> > requires invoking each target triple independently (e.g., passing
> > "--target x86_64-apple-darwin" and "--target aarch64-apple-darwin").
>
> This is much easier to understand for those of us unfamiliar with
> the macOS ecosystem.  Very much appreciated.
>
> > +$(RUST_LIB): $(RUST_MEMBER_LIBS)
> > +     @$(call mkdir_p_parent_template)
>
> The leading @ is a bit curious because among ~20 existing use of
> this pattern, nobody adds it to squelch "mkdir -p".  In fact, the
> macro uses the standard pattern to define $(QUIET_MKDIR_P_PARENT)
> that does the squelching when $(V) is unset.
>
> > +     $(QUIET_GEN)\
> > +     if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
>
> Recipe parts in our Makefile that are written in bourne shell, the
> CodingGuidelines apply.
>
>     $ git grep -n -e 'if \[' ':(glob)**/Makefile'
>
> gives empty.  Probably,
>
>         if test $(words $(RUST_TARGETS)) -gt 1; \
>         then \
>
> would fit better.
>
> > +             lipo -create $^ -output $@; \
> > +     else \
> > +             cp $< $@; \
> > +     fi
> > +endif
> >
> >  .PHONY: rust
> >  rust: $(RUST_LIB)
>
> Other than that, looking good.
>
> Thanks.
