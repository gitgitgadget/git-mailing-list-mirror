Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA4B1D3560
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 21:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732053212; cv=none; b=KwEO8Zctr4aUXZO4BvlXF0opEc/ng+Z9k03aBKYzUj40bkOn20JhqS0Wvt0PSC3SqIWkM+qRY1vl+J03TCW2nDNNLEHQMsPvZm3ZrF6dvX8o6JC98D7SsqdUNrqN6+bsMu+d0mk1pd0CGCMJai1vfEPjEB+K070vJo2qkXmMhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732053212; c=relaxed/simple;
	bh=oR0L3lREtHBFVxj+yFST25CVFkxZDZOUaSWv4/5dFOM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IljHuvQy7xy4qS5HUiH7QbJHl9pnewkYgxnGfvICkbP/MIDvLuZ0J2Fiamzxxgb3okLhcVmX6BUHRFyhVK36Mf0aoxAqa6YI2qieV5odXtettfNyD8pvfPRfgpjaVkk736shUjADoNGb4GO4IO65e1Bc04qWP4yhUPRtqEwUmiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rsHt+4wS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsHt+4wS"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cfc264b8b6so17172a12.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 13:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732053208; x=1732658008; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OEsAHgc90dH31VEllaCoY3eQ6HtLpczfUKi0J00/Kw4=;
        b=rsHt+4wSxXql6epxn2AXl5j3TG5N4p5w3c/JClkgiV8Ry6gzQTrP6Wkvbd5s66ly6P
         bHRuqE8wPELW1mkBs6eCZ64XUz/FEYjLCfhl97PSNKr+1+/wha15DwJmOatix9gJUQ4K
         n3zuWYur77GW+Vs8lG1CuiG5Woj0R3Y9S7Uc54Hyrea/XW61xIc/FvNBiYXJttU5clWW
         IsW74gsebNl8gF01X8QJd9CjEwK+bZf34Hd2A8dHdBAiMutq1ERvs5IrBNNlCgeFJR9i
         dUnnp7KTi4Ak1QCycix1CVgs98yACtjPNWrmgnTy9rSt0ilp7LzCA5oMXqYSmIe0+Kou
         g1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732053208; x=1732658008;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEsAHgc90dH31VEllaCoY3eQ6HtLpczfUKi0J00/Kw4=;
        b=J8MO04bMPJwOIABZMLUVw/N5mKzeX8FUFDprmaU+F4LDGQnbsOMlrFTP9Uyqt8snFU
         6lOVoJ+D2fiGY3Ju6DPr0zXyb4eq6+gSrjh70ABEPKOGLNGcbYW/5V7hvkLJ9yr7t2vk
         BzWOFNGgWvMsi0dEBaPMCy1sHaR8GVGNIG6bqhur+PbRS9uqEMxU78ebXxv4AautkIPc
         vCz0NUqQnB0E1UNdG/AJvaqDNHGkeu5kuJh2C+k4hUgnh6qrW/fhFDhWhM7jXVve+Jhb
         LwHLFqLXeuCw6BAe2iYUOU8YUeHOt5J7RcirXdCwQz+bSPkt3SMzqeAq3W2K/VK78J7a
         ealQ==
X-Gm-Message-State: AOJu0YyhX2br4Gm45+WkaxuaXq97jUVs5m0nmJK+39BbjAJRqTYlDHUu
	6jNmdhBJDhjgMi3dKJxks01dsZFFZVILeenk3pd0MOgHbFexbbuohGAPx/65n+ND8exma/VYuqq
	NDDKlarPKoC9EKpWxUg4153XB2XOb4t83ifaomRf02nu3tn3I4dbvah0=
X-Gm-Gg: ASbGnct5ZNgj/SfajHcNE9f1I6OdMzGXYv1h/OT+66tDanN9kxpBGPTJwGxicaF8N+c
	Xezaetw7g9eNhJRE7PRNeqKtP83zGk6q7EFJkkqD62RdnS8c5SDhk93eHda6x
X-Google-Smtp-Source: AGHT+IGgjt6zdZ7dJU7tfCEtCbBSc5HNiG0rWxIoCkhaG5N5inzyEZ3720lTTVaPssbjw3aeont+0eHtiOadC0TUGGY=
X-Received: by 2002:a50:ed07:0:b0:5cf:c23c:2bee with SMTP id
 4fb4d7f45d1cf-5cff3aa1cbemr21045a12.0.1732053207914; Tue, 19 Nov 2024
 13:53:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kai Koponen <kaikoponen@google.com>
Date: Tue, 19 Nov 2024 16:53:16 -0500
Message-ID: <CADYQcGpXm=RTEYyxqdSowQ4Vg9jmXuCzOOpd-TgDX8U814BReg@mail.gmail.com>
Subject: rev-list --ancestry-path with arg - bug or undocumented requirement
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
Create a toy repo with commits in the following structure:
A - B - C
     \
      D

Run `git rev-list --ancestry-path=D A..C`.

What did you expect to happen? (Expected behavior)
Commits A and B should be listed.

What happened instead? (Actual behavior)
No commits listed.

What's different between what you expected and what actually happened?
--ancestry-path with a commit arg seems to return 0 results unless the
specified commit is itself part of the range. The rev-list documentation
does not mention that this is a requirement.


[System Info]
git version:
git version 2.47.0.338.g60cca15819-goog
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.8.0
OpenSSL: OpenSSL 3.3.2 3 Sep 2024
zlib: 1.3
compiler info: gnuc: 13.2
libc info: glibc: 2.38
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
commit-msg
pre-commit
prepare-commit-msg
