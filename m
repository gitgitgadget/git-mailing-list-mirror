Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B64134BE
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 04:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452333; cv=none; b=XBO28nYgleuvI3KvXnjZFqSrON0R1XQWbS3at+zoUlu7jaiAndknfMSwkeG0izcDVeKYNhZQYyRkpvtdfYJKC2mkm8xvluFgTAo8iJbq16ILBgy9lxXpUXDoapqTwhyYLoRBBCSqK4ZHPle9u9duf0wCM0OCWSjAgP3a8jFoxeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452333; c=relaxed/simple;
	bh=+x7wxIchHDHZ5O2Cu0qVvE1GLlgspB8o6T+vbaPmeAc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=eynaozQ8lS+QuoqShWOgU+wkmvTo8cmag/r8ydL/jbouV0wgVGN3AHBrmAtYuLhl7cW++PtA4aGMCmDWt4TvB9M6jkxdVsI+3D63hhj2GMslqv/LC1nBEkQ3ODW0fHWsOAfS2tmQhmUGKlhxpfhjMG5Gye2MtEUwTUEvTSgKBlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVmLZB3e; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVmLZB3e"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a2d248a2e1so4503405a91.0
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 21:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714452331; x=1715057131; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RJAppH57oo2ZzyGqHyTuHxl6IjWY2uJaErdRythsCc=;
        b=QVmLZB3eKG2ehe+UaNkXDBMiGklSXl54kEWEFOZ5C7AeW8l0fui/iSG60gwA9U4dLS
         1zu+YB05Hp017MVCR9rdhr2shcpwKl39VBrxBPexBfgzb22tlfIZz8drCa3qepYS20Zb
         uthsucgEWui2OCM2mKwF4mSoT3z7Ujz6HVxDfN5qdVaW/1whxbLBRHa7NuFBmBsQQcdU
         QBJpRiSK8nrAv4F33FJ8efSkECG93UINuULtPyuwFkWhTQ3RxQXcd76xXHg1ILf1VnrD
         Q+uVOK/BTpUAMpPX53l8n+ZiSyzZLDbjGgtQ6jb/SpqL6hBuBO8qVEu+OLb4PQC0MzaP
         8r9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714452331; x=1715057131;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2RJAppH57oo2ZzyGqHyTuHxl6IjWY2uJaErdRythsCc=;
        b=DxIfw+icbU8p0f81yci+bUUHF7t5s4NQdzzOS74n4xqT/mX3J1rHWYxbE+u6Va2rha
         hBLjBocG2Y4m4E9kdYgZGuxIG4jP22U9KmXFD6p4BUVUYEjGjeEwnMU2PI8n1qT+Q9GA
         ySz6WlD08MitJJiC4qo9YpHZxK0fitGiiAxIbSU0Jsv2kqVrrdvtCL4bR/b1r+es1HC/
         lvFmrDBxuyugjulDSd+AcWmPqll4o2b72LXeIoIY0E0/up7Vr8JQmoOo4zxTDF+uKFgk
         FuHj/NAZYj3/62D0AZBSBWSz5giDvAGawJSsxB4TdGyBFMLrY9eHBCfdH2eJJYVcKZza
         1qRA==
X-Forwarded-Encrypted: i=1; AJvYcCXaEpaCUR9z4SiZy1yjuqwrGx7kAtY2r4yrn/VLjRSUPXgjh1nrKI9Roxeor0N4Mx4BQfIkWKvS12qaud2o1xif12WR
X-Gm-Message-State: AOJu0YwgBEMYGG5qU+DeMW/wLcyjBcxcHtVFR/NdGp/Fazhsp4idwox3
	QP/LE/owDVZJmw3TcJuQGkkDBJ+aH88fIADN5gK6csnRveDmOrqSPI9GEAZ/J2FJADbctsSQMza
	FQ9lFStkR4K8RpNvymfQJPBZUBJzp2Q==
X-Google-Smtp-Source: AGHT+IF9DeTsoG4hj5AkL1pUdtxqDaH1besY5g63adFA3wS5P377M3WhvdufTmWv9rMWDnVRWxCEr+JLKndk43fh5Ag=
X-Received: by 2002:a17:90a:af94:b0:2b1:314a:ea26 with SMTP id
 w20-20020a17090aaf9400b002b1314aea26mr2441332pjq.7.1714452331262; Mon, 29 Apr
 2024 21:45:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Apr 2024 21:45:30 -0700
From: Linus Arver <linusarver@gmail.com>
In-Reply-To: <xmqqplu8ulra.fsf@gitster.g>
References: <xmqqplu8ulra.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 29 Apr 2024 21:45:30 -0700
Message-ID: <CAMo6p=EPuyfdFb4dkAC4Z5mejE_uB2MeJKfkg7CQ8NN3P6KYSQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2024, #10; Mon, 29)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * la/hide-trailer-info (2024-04-26) 11 commits
>  - trailer unit tests: inspect iterator contents
>  - trailer: document parse_trailers() usage
>  - trailer: retire trailer_info_get() from API
>  - trailer: make trailer_info struct private
>  - trailer: make parse_trailers() return trailer_info pointer
>  - interpret-trailers: access trailer_info with new helpers
>  - sequencer: use the trailer iterator
>  - trailer: teach iterator about non-trailer lines
>  - trailer: add unit tests for trailer iterator
>  - Makefile: sort UNIT_TEST_PROGRAMS
>  + Merge branch 'la/format-trailer-info' into la/hide-trailer-info
>
>  The trailer API has been reshuffled a bit.
>
>  Will merge to 'next'?
>  cf. <CAP8UFD0ZHpo7US6dx_WK6F_1JYsBdHunBaW86qM1CzOKaPC-aA@mail.gmail.com>
>  source: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>

I should be able to send a reroll to address Christian's comments
sometime later this week. Thanks
