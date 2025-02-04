Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1D14A0B5
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691464; cv=none; b=piezLsH9MTqD0Daptly0RboBjzURyKbwOUEayZ4XN2WKCC/vUTcRTFFdOgAHhRieCSkG9XT8uosWOFPtr1AD2jidfzOrH4nBQooT0bnFGXDyr9O0cr0N/RLc5K615jQrZkYEosctclmR2sCPH/9AFcOn/J6yUyb1sg92N4wVKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691464; c=relaxed/simple;
	bh=GCW4/664bvqYd/C6Xzx/0Qbk5JvSCP5elsdpslZTJ0k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qRnXlFU+BpRFr43vHVZtoICIxA7z06gVDPmujVwJJzyOSc05dDQ6cO8cM16QmkglZBhPmxwMGLcxhxS6CItB51VQkHoZNPfBTT8Vnok8i5Z6RWjm831/AA5ZbfvL+OACJR67t1Pb3RtTw16sGIOshSE3EV4U2/9DjCfBzTsuhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtRYYuJn; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtRYYuJn"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5dc7eba78e6so11212143a12.3
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 09:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738691461; x=1739296261; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xxCaiikUrW9YgDwjwQ21XkKrTQvhmJJF96qWcdNWkEg=;
        b=RtRYYuJn6NKnfaQM4+2u3P3rbQdgwIpzwDmb0LEm/qd5q1CQS+jdf1doOlVbl4Dkr1
         kQwgkRCfsSW6aNelOiCPElqSOF9DCtWA7k7cMMzz7D1EvIu+WTrbveYJUNjSXCRoCk0u
         zGu7anbFCUD/QcVdCe9NByT/8u6o6UXsM64o/pV0sFpFNH8PtyqOwI559KNPPpL+8ueN
         9GzIlyohz+4/hsKf8D27bj9Io1FsrwfQJ1fAHtx0JDUwtEaf99JTW4XxelyIl0JIHwrd
         uD4sUYEYX6mN22u4w5vsotcfTijTW84wjve8a2wOXhTEHblNm0Q7XH24rEU/gRnxZWHs
         Bdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738691461; x=1739296261;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxCaiikUrW9YgDwjwQ21XkKrTQvhmJJF96qWcdNWkEg=;
        b=h1Ql/sCIIMfF1EZEIqqXnMP+Sz3Z7XcU/wR8xpjc0ad+exDticmIIztoZNF+aEY19e
         5gXerdd5Yov2fMEiuP2/J3ti3XYcOxnXOSNOT8S9PKh6O+K/r1XI/jauS2sSRSmsIRpA
         cZEjWzmvAGys5bcKEqLnRqFMZelfaF9unchAI7/oNJbkMwL26icPZ3nuUmmhpxQmUms8
         a89giQt3NIrGWLwMJ/C8NU+ybQhQTM6oQwwPDtOz95u/o/8PysM0qBE8+QYAdgVPQGAM
         0HrHzvKqSrDRGbsRVblxROfx01mqlQmi3yTh65NS+5GNi5w23Xy46Ku32VxMf/9/B4OL
         85gA==
X-Gm-Message-State: AOJu0Yzw20zP6i8+gUstRIyMfX2vf7d9LcN3yRm4JsiyFMozQbzhX194
	8QfsUhmHwH5TnccI633E347C+CFOJ891rWHe+ToPu/dMNj7Oi1tngdlNl//1PKFYPj83q9ekX9q
	VwNtpKBq4L8GO8EItg4tZwgbInjfD+rpxIJITWwBUdrU=
X-Gm-Gg: ASbGnct1mQ0VzOA1XQCml6yt7HGjLZHe/mrBh3WJlh7hkF950CyGotrcYeoUbYg88Ez
	TPE4NHF7ReH6YEXr+AD8C5EvWOg5jnNlkj3ERwRoTxFzU/l82YoertxS84dA3QFoFwlZEnGT7DA
	==
X-Google-Smtp-Source: AGHT+IGqZ7Q/dp9kvVz8zh1v2fraCveA35XWLv6/+axoWxsg0c2/2bZXn5jeBD/pdIe2+fbRq/vjJY7rJUr/zvfAi3U=
X-Received: by 2002:a17:906:730b:b0:ab6:de39:c7d9 with SMTP id
 a640c23a62f3a-ab6de39ea32mr2803385166b.33.1738691460774; Tue, 04 Feb 2025
 09:51:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zejun Zhao <jelly.zhao.42@gmail.com>
Date: Wed, 5 Feb 2025 01:50:49 +0800
X-Gm-Features: AWEUYZnbYPLkjiGiZP_XyWNJVcKMMCEmN20muuOCrRDkB2UksZLt9C3qMzaNMkA
Message-ID: <CAKfgWeZ5GSySF1N2oxoKJLnzeXOjyBh_DbhdFywXiv9L-JaRgA@mail.gmail.com>
Subject: [GSOC] Introduction and microproject selection
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I'm Zejun Zhao, currently a first-year MSc student in Computer
Science. I love the idea of open source and have contributed to
several open source projects mostly about OS kernels.

I've been using Git for years and I'm familiar with Git's porcelain
commands. I'd like to dive into its internals now and contribute to
the project directly, which I believe will help me better understand
how Git works and what a well-organized open source community is like.

I have read this year's microprojects list and decided to go to the
"Fix Sign Comparison Warnings in Git's Codebase" idea. I'd like to
choose `apply.c` as my target of the idea. I followed the instructions
and found out that the `-Wsign-compare` warnings there are of
basically three types:

  1. comparing a `length` of `size_t` type with a result of pointer
      arithmetic of `int` type

  2. comparing a `length` of `size_t` type with a `length` of `int` type

  3. comparing a loop count `i` of `int` type with an unsigned loop bound

I think there can be three different strategies, one for each of the
above three types:

  1. cast the result of pointer arithmetic to `size_t` type

  2. try to change the type of the `length` to `size_t` (may fall back
      to Strategy 1 if the variable is not guaranteed to be unsigned)

  3. use a loop count `i` of `size_t` type

Please let me know if I had anything wrong or there is any other
point that I should look into to do better. Any feedback or guidance
is appreciated.

Best wishes,
Zejun Zhao
