Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6712F509
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752715187; cv=none; b=mMTFDiYV95YUZED6Ddt/qvYc3vBfTq9scm9BvXLQEf8RT52rnkd8wg/b6hWEj03Iu0UWQtlaG2MPtkdfABVkbyGOsC338xPcSQ8k1GlAE/JjtTSWvwVtzJLuyzWkFaI2QhuqBbrsaAyaipOt+B0j8JfQrqVR9tsaycnL32lA6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752715187; c=relaxed/simple;
	bh=so5y9Jk9QM+FPKdTI/HAZEAS9t35ojIokr8X4b0JwSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMBX/TvE2pCBBrCV936yoOQFUi2wNA5D//LcMaVxLai7ZHEvQY4QRz91NmNevZLN63bt3bwyeQwP5PwwoSw47Fsf38YuO6scftgHPj3tAKcOJDdfpVA5YwM7UPxUSrhgQOmA36qJFeRO5oNXq4lrkoOS6nvdtJhA1ePm+oZ90/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NeIGPs62; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NeIGPs62"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4aaaf1a63c1so3356031cf.3
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 18:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752715184; x=1753319984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VgTeQLeQkOekdsLGLSUkyMEjAKcSaE3eXBrt+m6uvnw=;
        b=NeIGPs62uTrEdRtrOAnKJOeqWVjNNW75HQC3Wql20AsdKykoPud0LVIDj4M0eMEDgF
         ZesIRAaGQ0Bq0YswDyorMUeUN6OiFSZ32KPSGXrODgM4RG5IXs9yyRAwQkDB0LTljBrL
         QB6fdb8b527jIWwdxtBGK3C9Vbb0BzoKIPBTATo4NK+ZIZVtoihmbWfFuA38qZWWpD1d
         WJqYCymMZxR0xjfxqYCJJd+3D/PEhGA1MA/u7VN4ELY0zuuI5Bu2qkdPC35v7BHJT/K4
         7ZnjBZk+r0+yIIPD0gYu6iyzFNTE1Ooit/0v0JUKY2G/S0lm4kVYqZwGS4mZJNNwteRW
         6NIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752715184; x=1753319984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VgTeQLeQkOekdsLGLSUkyMEjAKcSaE3eXBrt+m6uvnw=;
        b=f1KxS51vMtxGoANIzH+6iFoS6SkKMPmvjSRoNV5idw4wX8AWvUK28F/avhhdqMk7zZ
         BUq/QDtBGYxKpkvKTrSnGQhJoBVEhLBEnhD4abGg9XGGxPD1vl4oUjdo+/DqARBx1cPJ
         iobxwqbOPv77fsSaDM2t1hMalEvXd37aqd06ToMewC8nNw+Cnsp0hAdr6zbw1dTGHGxR
         5bpfCXs3Eom48BXhJGhB/9ynxZfo4eyRGdcaBTCNwUhqXcdA6lzLA1ccyOAMt/6ojCGS
         iUc2mm/c+tAsnFYLY1/h/Ywj1pJAa+WG2RZvJmsH70QCSkWrZX8F1vvrzX9PkSQ47RjT
         vQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCWwumpRyNdlAbgV3ag8FX+AoQ/4xTGg7JtP8PN+EtFjCGHjRq8yZ5FHVf1mZ09CohxAU7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ggW2rFJGtyMrPJwTIOTo0tN1lzuWQwgrNOUDcf0G4MGUNx5f
	fMkvYTS9//lWRPkOsm4U8GGilc3z4q1FnTLwKdzVVA7+q73PWWFE0mjmIx1sxBi/zZ4CZ8H7Z+X
	krkT4IJJpccWYZHYJVV/h5A07rx1K/d1acayE9fm0
X-Gm-Gg: ASbGncv1YI9VbLDNlb6/okQnll1T55inEjE+Yt5LxjXc4mrBWrafogXRvnMoqt4PKVL
	zb+X49+kPoBrRpWDdcsRJ4x0K54Gt3ZL7MXQY3CUGXPvIDmTLQ2lVmLUfxrucSF/z2BLnjCuLbJ
	XtVxU2Tqa/XwQp6Eb/Qc1c8qDxSOS5GZj1Nbfak2rtKP1GH+SkDioR/wQeeSHtvCAUzeuAMt+yy
	A6B6MQGtlDg5s/ED0PkyEK9JPt4qIRygBln5nA91el1otQ=
X-Google-Smtp-Source: AGHT+IGaxSlbTrbJlz34iI/dnrcZmAO4WhJKc/VXsNfHU0aUTcmkIrlVYNxswUvd3sS/O6pEU3WTgkucuaVaYti0QhY=
X-Received: by 2002:a05:622a:14ce:b0:4ab:6d9c:8987 with SMTP id
 d75a77b69052e-4ab93dba371mr79190781cf.50.1752715184289; Wed, 16 Jul 2025
 18:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com> <xmqqple1gtyg.fsf@gitster.g>
In-Reply-To: <xmqqple1gtyg.fsf@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 16 Jul 2025 18:19:32 -0700
X-Gm-Features: Ac12FXyx3l9CkjOS_FXIhsCujF68MB73d8B0s4CwnXomQRQt1g17fs8vzcksT64
Message-ID: <CAO_smVg9TDakUnubepjPGmLyOzW6n8Z=MDbnZKvkwN2=kN2RRw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] for-each-ref: introduce seeking functionality via '--start-after'
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	schwab@linux-m68k.org, phillip.wood123@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

There's something in this series that's triggering an msan warning in
t/t6302-for-each-ref-filter:

==2147==WARNING: MemorySanitizer: use-of-uninitialized-value
    #0 0x562a64e923cc in cache_ref_iterator_advance refs/ref-cache.c:409:27
    #1 0x562a64e88dc0 in ref_iterator_advance refs/iterator.c:15:9
    #2 0x562a64e88dc0 in merge_ref_iterator_advance refs/iterator.c:164:13
    #3 0x562a64e8850b in ref_iterator_advance refs/iterator.c:15:9
    #4 0x562a64e85f5a in files_ref_iterator_advance refs/files-backend.c:902:15
    #5 0x562a64e88bb4 in ref_iterator_advance refs/iterator.c:15:9
    #6 0x562a64e88bb4 in do_for_each_ref_iterator refs/iterator.c:478:15
    #7 0x562a64e64593 in for_each_fullref_with_seek ref-filter.c:2718:9
    #8 0x562a64e5cfe8 in for_each_fullref_in_pattern ref-filter.c
    #9 0x562a64e5cfe8 in do_filter_refs ref-filter.c:3263:9
    #10 0x562a64e5d7fc in filter_and_format_refs ref-filter.c:3364:3
    #11 0x562a64af0235 in cmd_for_each_ref builtin/for-each-ref.c:115:2
    #12 0x562a64a3ebdc in run_builtin git.c:480:11
    #13 0x562a64a3d342 in handle_builtin git.c:746:9
    #14 0x562a64a3be33 in run_argv git.c:813:4
    #15 0x562a64a3be33 in cmd_main git.c:953:19
    #16 0x562a64c2f12f in main common-main.c:9:11

SUMMARY: MemorySanitizer: use-of-uninitialized-value
refs/ref-cache.c:409:27 in cache_ref_iterator_advance

Unfortunately I can't provide great instructions for reproducing this
locally, because it relies on our internal build stack (which uses
blaze). Getting MemorySanitizer running can be quite annoying, though
you might not have any issues if this test doesn't invoke any third
party libraries (like zlib).

I need to sign off for the night soon, but if this isn't sufficient
enough information to identify what's happening here, I can try to dig
deeper tomorrow. This run was executed on an import of upstream commit
4ea3c74afd42a503b3e0d60e1fec33bc0431e7bc (Junio's merge of this
series)
