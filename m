Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7A57888
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700297; cv=none; b=hJxMoDu3D0IpugnORoe4uzR2q/EUYgnPDYXEk8TvIJZXGLBi0xmRAffHkTYUPipxrIHN8td4pzVhZ8ZvS8lvr4s61Pp9uU4A5u7cg4SOaqzeJeF4V2x7tjT3z6rMA/ch4FRD5rUqnkaZRiEEv96vPfX1p7JvUJWM1dV76pdntYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700297; c=relaxed/simple;
	bh=GNDWU3+7+uTaprADE1MMLGvHX/AQmuvG3KjcDlOpVWc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=mjZldplVvKiOq+Lce/V5AyhVE1SazQEOuaYvLL9Bs5RAKWShG46RnO3gfYD58R6oWbeUYDwCJj+5edoa4Y+6NM/xe1CldVw4pVAjwmVD2ooPbXQFS8ko7DP8X3dJgCtSWo0MbZ2HKYpiP7d3Omz6h3HY50w5h6PDIgZttCe1y0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYFjfira; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYFjfira"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5eba564eb3fso22078277b3.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 13:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705700295; x=1706305095; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c6YLsLh6SFfKIaxP9FiJyJ4INEdqodJALWSXMmuqIC4=;
        b=rYFjfira6PME+TEvj+o9Q4QYvqTyWzRRF6uWiIu29I9F8JBiz7pOPjXARaCCeTfKet
         XFGAr95UK9GW65GanNZybTNr9QNoaziJBvycS2W45uBuqVLkPL7jL4KIEvk3x8ci5Itx
         2aX1LZgUQafIFMsXboioxQEUZdHEYHpHw+ZQq7LyXHS0Y7nEqgw/rJBiX/bHRvbDPvus
         mySn+PLswcJs4gc20eGdBKd6KhD1ZMiSqo/kJiVLDej554dT1ekhT+e3kpO6dBscTVtD
         8X+V2T6Fl63vLvuccyA/YUXkuHDw02lG7ep0+Q41uZ9ks4WfDtZD6uO4fv9zBgDdixt4
         PrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705700295; x=1706305095;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6YLsLh6SFfKIaxP9FiJyJ4INEdqodJALWSXMmuqIC4=;
        b=Eqm+2DVzZOvhsduzRDUzH2e/9s5K6DJyHVQee1MNfMFk4hh7R5IZzLOOsP8ToQ75KW
         vQRwB5AETW+GDwsw7F4t0xV51rImKiJHp8wFD/kyBaY5dQwnXlui867aGciMc1cAHVDA
         ygwiHEdMT65sDtCMCudOBXTDiN6wV5yOnb4qUayCpqoj/bTvz03AZpA648rhdJDqB29b
         7qtgrWiLDT43Q8mqpsPF6RGUz/ctyxtk+b4d2GmNz/Ms8QAiqvib6nluJcijODTuQiFg
         1v2mktOmb6EgN/V1mwEPSW7jGuRI58y8qeaOpdzsxT6YnfFNiSnSaRuB76xy6gwvn8xh
         NxZw==
X-Gm-Message-State: AOJu0YyI8Kx8ut6YIL0y40aHwVJey6jf0UeIVn0nwmP551ECg4oCa4ce
	dwBDde0a+t/La4In9gRN/U3IU1DSfSt2jexXwoKAKlMsTsMoiHt3J4hAJO93/9FAoSSKpeMeh7v
	WYuiivXRAFYhRpBfsHW7UuiFuU/7y+Uk3bL+7dl+zDLqkFYKSreF9h+IXLbMqL/w4tpc8CpFCNe
	R3z2JdGukShBeUyYNocWPdh8sQd59PPNXBw1Ny0kQ=
X-Google-Smtp-Source: AGHT+IF5sEHOMKZMz5kamZMKNgl5hW2/2pML7j7XCSKTJVRIad5TwUk7qD2c78JvLpnNW8TH+g2GkL3gc3B79g==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:3aa6:e329:52e1:bd8c])
 (user=steadmon job=sendgmr) by 2002:a05:690c:ec5:b0:5ff:780b:f3d8 with SMTP
 id cs5-20020a05690c0ec500b005ff780bf3d8mr253701ywb.8.1705700294881; Fri, 19
 Jan 2024 13:38:14 -0800 (PST)
Date: Fri, 19 Jan 2024 13:38:11 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <cover.1705700054.git.steadmon@google.com>
Subject: [PATCH 0/2] Run limited fuzz tests in GitHub CI
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a simple smoke test in CI to make sure that the fuzz tests can build
and execute properly. While we already compile the fuzz-test objects in
the default make target, we don't link the executables due to these
requiring clang-specific support. However, this means that the fuzz
tests have been vulnerable to unnoticed build breakages as the code that
they link against has changed over time.

Adding this CI test should make such build breakages more visible more
quickly.


Josh Steadmon (2):
  fuzz: fix fuzz test build rules
  ci: build and run minimal fuzzers in GitHub CI

 .github/workflows/main.yml          | 11 +++++++++++
 Makefile                            | 17 +++++++++++------
 ci/run-build-and-minimal-fuzzers.sh | 19 +++++++++++++++++++
 oss-fuzz/dummy-cmd-main.c           | 14 ++++++++++++++
 4 files changed, 55 insertions(+), 6 deletions(-)
 create mode 100755 ci/run-build-and-minimal-fuzzers.sh
 create mode 100644 oss-fuzz/dummy-cmd-main.c


base-commit: 186b115d3062e6230ee296d1ddaa0c4b72a464b5
-- 
2.43.0.429.g432eaa2c6b-goog

