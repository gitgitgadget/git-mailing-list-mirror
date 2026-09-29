Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8A13A873D
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668115; cv=pass; b=hH+RcxRoVmC/KwxIHhIX46wz+wuhWwInRHikNwGU3WOLRuneEDg9t1iOlxFZ2OFkjfIzfQGg4WxRLLafatQYRlCFYXweh5DfjglpAbN9xKULx0HTwphxA+d72FmVx3k7Nf5exPUQD4jGBeOmifP6jpM0QlDIWOkq3uTqTR0vkOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668115; c=relaxed/simple;
	bh=prtew9QHLBMa3ENIvfKjnk+1rsWLfQZC982KBgisBMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUIGyx6fMbbAO8S//CVgMEppYQXTWhX6kd+RZ1a6zYWVNbVkTpQdoQdHagiW2SYEDFRTD1tuZxVlZurx7q9pjNJEZxxyzLmAgyqmKhhGw7A9OaQ4KzHcoUle978gU+HzFAGByY3TABwZs4jdMchKmaEsthY/Dmoz1i9y2TExg6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXZoQks8; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXZoQks8"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac6fa788e6so3081322a12.1
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 00:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790668112; cv=none;
        d=google.com; s=arc-20260327;
        b=fPlX0vxeJGq63FH07eENgjwTeyrFgIAzfJ9l10zSV6ZmYN5OMtXx5UtIV/i/mSoyqK
         M3OPSPrmLIjA93kJLkN4rq13D+08NTD+pKR5n8Fi8Tl+eayTKr7mKVqgV0cAlQLxMF9O
         gYktYC5US+jEy9oDk0upbDRKxJ71qVA6CW9bEfT5nO843+1ftbXf36tWXVarlcZt+YqD
         hjCz3CDRsnmcdSA0Wngo7Ryw5N8iV9fPgmRtAemCBiNXds8WEIU7iIUCWcPHejQdYuIo
         4f8P4WKHEu36/j7C9XUpMYP3n31LN31Y795XzvLEdrsSHcB0iOzRWx5jJfRYtu3ISyQw
         dCYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UA8iBFrUHvFV78FcZDqVxT7V/nCZkf6DNDGAE38Ipus=;
        fh=A/H8zF5aN2sad7LJh2iOe02uwskCYCLLd0Csq0qIK7M=;
        b=YOi7hIiBH+SqdqnjtsdnSnVhaGD/kMCDKkmicvXD5d+wZLHFislm2kVOc+ioo6Ruww
         Rdy8HcSQ3aU/ibLqbgnO6Z4TVNML8IIAufPnMr04KZemA2kpzppLGgme7plLFIblDDGI
         2mjh3FD9JhOy9SJu46FHTOKqCwapE6Cb5JyXuch6NsREXKNhlR1MjbjRCgKmty53t10D
         /Fs42FcDh2A/uHQHOD5YLuWhN93F6LYgPkCD0bLN/Rh+1ZvnVOCfb0RYyssWzRaxZELd
         2icZhnui6fMvXzRZVg0ToQimOvFL2An4Eckuwct2nMmnQ4Vq6B/f3zfrn2t6uDVD0amI
         sdAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790668112; x=1791272912; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UA8iBFrUHvFV78FcZDqVxT7V/nCZkf6DNDGAE38Ipus=;
        b=LXZoQks8M1ch+zlflnT0FfJzp1P1pqLXoOFIxe2jQ/EXk3ObMvrVpDRbGofF7bKbwm
         /9Y10vTWimh4/WU4Q2p2aTbbaExAhrQCv1fxg95Gc2ykmO89eJJ83oda7JV3T7HsofDB
         7o/G/1bEQ1ISJgTqJTE2Zvz+EOF+kmc8pUeUIoK2QDfqf8uU+Fpl9LA+6Kiq56a+jnq9
         vzxrhJFPnsoArckK9Z12HEoIHSYUFdeangUhCMt95BIbte7RGTTTYtz8mA0qGvv0MghQ
         zowNTjNmJkdt1YBHZdUq4Aa1FKrFU6/PlbE00hSdnnh/nxQ1mPm2kNHWxNeweNbHVwL+
         Bfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790668112; x=1791272912;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UA8iBFrUHvFV78FcZDqVxT7V/nCZkf6DNDGAE38Ipus=;
        b=kwXQtmbPmAOs19S6G2KQB0hFilxWxx+6Gg3akH48X4u0xhm2kQoJi3ai2DkC9MuF2r
         s/59eWbb3nYOOtwdxAoE2/VNSvp/PfNcKsSBJIbo3ljFZbmnST1W7+vgwY+8JfCaWWJZ
         oCq1ypSNTRh6ANZ2q7bH0sATyO8vIcHUDO82r2oYiU7jrtSjBfUYkUfHX1F9OWwUcRSp
         4EwjlIal85RgxN10krBzw4jOHaHHeO9TVK3x0SizIQ9dz8oaXbrnsyxPUxu81WBUEQLs
         Wdzl6Sp2kFqV+ypsrbzUhr12/eeJbiN8hNXFUthzFoEQuh4wmtEgq4CZApZxtUV8wfIP
         QQKg==
X-Forwarded-Encrypted: i=1; AKwUvBxly2afoSiv8oZQ+vD0L2AoURU6F+bWcO16izlzFQASS8lUshe1relK9wnxn09RAac4vW4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0PbVizdRSyeJHPZcLw8kCyqBr9WHLpty/VUPvqHv1SUQ0X/E2
	kq37a/W98V4QRjCvQrEAkX3xERoviO4mi0n5+N4Ix15ql14aFxrrDVFM0xWe4+VXKcV4NcxMriB
	oNMJG/5K+H4PtyWjZxwqHOlgdcDuftXz9LQ4/
X-Gm-Gg: AYBFou2xRoPoPFMjYN8fj1btpOknYb/3KkCVSRJgF1BP4H3BYxvahPr7lYwMW4V02eo
	dbCJ5NsSgl2IpN7vFES0TgN9rpIsB3a2iXLK9D8npuapFjSRfK69/VQD8FZTTSAxKbpKUK5w52v
	3O1GPru/mACuUmNNXCsy/qj2BU5nC9PX0ExYSWRzDh7FfoOKtUICEv3U6qP/8ZEPUd9urmTzRfg
	apg3IAvgaFN4Q3qrIxdq5xJ1+nNalG9FDAbS3rx4MTtK9qTV6F876rgZMYO1i9S4Ws6eyfsVUCE
	1lx5DKrC95ctuGcEdPUZVrNr38729omiaYBIIOrLvYjZu6QJQnVxXH8=
X-Received: by 2002:a05:6402:510c:b0:6ac:a828:428d with SMTP id
 4fb4d7f45d1cf-6aca8284378mr1345988a12.26.1790668112069; Tue, 29 Sep 2026
 00:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v2.git.git.1790621693.gitgitgadget@gmail.com> <46e13a6e77f0c1c23a0dfe6183e8c3dac405da89.1790621693.git.gitgitgadget@gmail.com>
 <xmqqtsn9kssi.fsf@gitster.g>
In-Reply-To: <xmqqtsn9kssi.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 29 Sep 2026 09:47:55 +0200
X-Gm-Features: AclHuK-jv4WHNoEwlcGafEe32qck-_ZapIeRgftv3GI5zShfFRvnD9KPvg1uKLQ
Message-ID: <CAHwyqnXX-kxDmsE+uiVHZ3=6iKvNkWkd5VkK1tRmFBS7fGWmxQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ci: annotate leaks and stop a leak-sanitizer
 script at its first failure
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ben Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > Once a script has one leak, it keeps running: the sanitizer log
> > directory is never cleared between tests, so every later test in the
> > same script sees the same leftover log entries and also reports "not
> > ok", burying the one real failure in copies of itself. Stop a
> > leak-sanitizer script at its first failure with --immediate instead.
>
> OK.  So the idea is that we do not have sanitizer report per
> test_expect_* block but showing the single one over and over,
> whether the next test_expect_* block has leaks, is not helpful, so
> we just immediately kill the test script after the first leak?

Yes that's it, one leak makes continuing pointless since every later
test would just see the same accumulated log, so we stop there
instead.

> >       if test -n "$immediate"
> >       then
> >               say_color error "1..$test_count"
> > -             if test -n "$invert_exit_code"
> > -             then
> > -                     finalize_test_output
> > -                     _invert_exit_code_failure_end_blurb
> > -                     GIT_EXIT_OK=t
> > -                     exit 0
> > -             fi
> >               check_test_results_san_file_ "$test_failure"
> >               _error_exit
> >       fi
>
> The two-line comment in the middle made me puzzled to see "exit 0"
> just above it.  If "--immediate" is asked and we are checking leaks,
> shouldn't we be doing finalize_test_case_output regardless of the
> "invert" setting?

I'll take a look at that, it might be a problem.


Harald
