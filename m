Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1C5664
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709601747; cv=none; b=KL5X7fKMfZOc/q/j3K3ScpPO53XbnNwRt09ttlke5oaeGQI4XWVYRgYNmeFHhQ4NUmZvAtfsgsnk4qHeBvqwyt2eJ3R1sGctq6RdMcuUivp5UR2C5XJo97tCXiZ5UFNRA+UQ9Q9gS7Aq1fYavw5u8dZaYI0UtSuHDwIdfDORKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709601747; c=relaxed/simple;
	bh=dNFC8h4hQiSyV6Eh6mAei+5CBK+/ENt2epQIoCiiLbc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rMfDKp55YRoZmchVDG65uO6EeuqAmt6paCLFEsBb4WfnxRafQOC8OBFgikFMAj3GwgAgPSjILjZJzR+4dowVXG9vEVcrKGnSgYrBfFHppCwYhRiESo3GCG1j41iAJaWlrHgmiItcaFC63XjiDoNMv6vDBxBN16Waqr0Eo3Knp+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--atneya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P06Zn6Ol; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--atneya.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P06Zn6Ol"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6dd65194396so5134064b3a.0
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 17:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709601745; x=1710206545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p9z8Fa6MCXtc4Zl1i/s51WCgvoA6mGF1U3HVXY1Oj64=;
        b=P06Zn6Ol0968LZibf1Y+nf25s11VrvooDo3jRTRdwnC7Kpchby+j0KFVhvffqEnlZi
         9K9BaKZCWkLgmkbYTol4hip+9qprrWIG1GKg0faKZK0ef2HBIDhQvJ8cf6knp5nrfa0k
         kQj7/86C3WwBQRj0ZoE3vHc9YOouJsqvNK5j8JTfLHedz7lZNwGZ9yF8ZKFV+Wv0ZF3Y
         18J3Mt4yUvuogo5KMNU+rfeGmVuGNCIGT6dr/0ZhDGyJuARwQulcph1tXU7UCG1TdL/Q
         TUitF6DvZmkeUcq4rlq8HQLQgTHOe+MSaOp2M0N850Da644Mvwp9vz/gfMKbb4rSpXSy
         XeFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709601745; x=1710206545;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9z8Fa6MCXtc4Zl1i/s51WCgvoA6mGF1U3HVXY1Oj64=;
        b=CHhoGDUoWJULhVvcrUe+LbLPfKTGjPSH1dRNxpHHF1VMRUSRoQkFg71jYVAFG2Y6Wb
         H8KyJ92m0QfWvAKL+VBGxB67nCbPWH7S3R1MnBzeJRhzWvRLVq4EJZPIhGAKBBoIhVjF
         Wlj92npqsiHreA2WJ5ohqiGY69Fiqy6dSacMvOrFNt1M9mm5QJt/z6WmDItspzyJni10
         +wPjgkEsRc+TGuJ+MtWuiZZzKQugycJPrBpqV8CLb+EijtePhPGF0sL6aOeNXNkCh4pH
         /NCmYCGbgEw3Iz2VEg3RH3uRJ9xhW/OvEeBMPLCThKNzJueWUD4APtQeNjUsdAN7mK2d
         RMpA==
X-Gm-Message-State: AOJu0YyE8OWytI1hqoOevCMLEDphKJrh6BzbyvzcwK6rIMmRV6t5owig
	4xhKRhp6kaolyWiQv3fnNglD33KLQNgyXQ0q+FH/x33iCT46ZrXPf/ief4p/yAeZaroaGCiJTgE
	0GFwuw5Osoq6439xPtodhv75pv2p1PliOjsR/kKc/lzLjLA5V92+ePt+psBX1c8pOegBhO/ESTE
	WiucqNawHpNece99SjtRRBMj7AENGR
X-Google-Smtp-Source: AGHT+IFlB/kcctG+UkU9U2VPBix/VO1XmlX/HMdC+iT3vA/YY1staoZKO3snWO3y6caNKn3HxdMxYi0oFM8=
X-Received: from capy.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:151e])
 (user=atneya job=sendgmr) by 2002:a05:6a00:8506:b0:6e5:6b0f:2e56 with SMTP id
 ha6-20020a056a00850600b006e56b0f2e56mr9564pfb.0.1709601744680; Mon, 04 Mar
 2024 17:22:24 -0800 (PST)
Date: Mon,  4 Mar 2024 17:21:10 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240305012112.1598053-2-atneya@google.com>
Subject: [RFC PATCH 0/3] Parallel submodule status
From: Atneya Nair <atneya@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, jeffhost@microsoft.com, me@ttaylorr.com, 
	nasamuffin@google.com, Atneya Nair <atneya@google.com>
Content-Type: text/plain; charset="UTF-8"

This set tries to speed up git status (and other commands which examine
the tree state) for repositories with many submodules.

Currently, submodules, unlike regular files, are examined serially
despite the expense of this operation. Fsmonitor also doesn't support
submodules, so there isn't a great alternative here.

Atneya Nair (3):
  Make read_gitfile and resolve_gitfile thread safe
  Make ce_compare_gitlink thread-safe
  Preload submodule state in refresh_index

 builtin/init-db.c   |  7 ++++---
 builtin/rev-parse.c |  4 +++-
 config.c            |  3 ++-
 config.h            |  2 +-
 preload-index.c     | 25 ++++++++++++++++++++++---
 read-cache-ll.h     |  1 +
 read-cache.c        |  3 +++
 refs.c              |  9 +++++++++
 repository.c        |  9 +++++----
 setup.c             | 36 +++++++++++++++++++++++++-----------
 setup.h             |  7 +++----
 submodule.c         | 32 +++++++++++++++++++++++---------
 worktree.c          | 27 +++++++++++++--------------
 13 files changed, 114 insertions(+), 51 deletions(-)


base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
-- 
2.44.0.rc1.240.g4c46232300-goog

