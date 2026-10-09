Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3B4A1E03
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545543; cv=none; b=A0YN17Zd+tjixwhy9aPIkpakqKBuVYW7WgxCX2CrOKuyhqKF8EWvWxv7pqPLK+NuaaZ6vfFGh64MUIjYRHNDu1oj/oaIYKn0BGgTO90hxu1VCOw/tiscAtkXxEN2R3ozizWcgT4PB12VIZdqVmUjhcmi9lpXaMO9xH0iG1AWe9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545543; c=relaxed/simple;
	bh=PbGwyVI5uPezwYD7qCE7SPyxuCO3sFTb3njMhJUyCe0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=KF8od1oouqdVmBxfkkGtQKIGz4s0QnTHmN3rPsOO9EKxTT5yihoHdlvNM3AtPUCMKNvTELHv+8BO9c9Ty6FkBGIIz0sYLLMo7P4HpCntJNshuL6PDB8Jr9MA2JUgTAyYzbsNqoTdpemLB0Lntyw/57D6mNCCzdZlj11b0mm0YFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BpbGsquy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T0FJVA2u; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BpbGsquy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T0FJVA2u"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D42FB1400081
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:32:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 07:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791545528;
	 x=1791631928; bh=y9aJnHNFmk2fTcaiFdxM8Y8lsIlfMI2wVcahQGjgwDk=; b=
	BpbGsquynEPrQG+/BvSKFmBH/m2dd9vkWAY3NMGe+NVlVAbKMy37Z6ntFE6CqMI1
	Rgl8kW8Uj5bne8ex7JzUbw8SiE7AosEiDAf+iQBBxR9GuoTy5MqS24fm+cF2yXxR
	0wzseFpwVI3AP+mGhO/u5B3GTeLTYXKU4eVO5QI3IsXmSAohcQSp0DA9hSN5Vk9O
	PUQbU/7uwYGhkgPK/L/lfFSy/A0D27I632U2jsT5FZ/bVHNnCipaZRmUsuJiQBss
	RSVH64HC8m7/aTNeBwGqnuMth96ajZC0fIaNZLytIAXqmg8mUJvZLnPIIocZN5TT
	Sr3LsLoto3ta4ZbRTcdzzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791545528; x=
	1791631928; bh=y9aJnHNFmk2fTcaiFdxM8Y8lsIlfMI2wVcahQGjgwDk=; b=T
	0FJVA2uPd20ckUKn2s8ifchdxNPYLyBOMkWWqnqQFPvsOIQ4X7KMUwlps2revZKK
	SLpRMVVfU/mRglHnuEgylgZZ/Bks1+BAeSXTu0lqDwrCuKW0NAqRpvUHwGOx4258
	M7ANJcKPbiv0F5tOKs1DJSh/QwKmen6sGzQ5tFVvOB2NqzMO1FNIqGe7V2ip986z
	YlC42NjhZMygNmx3BTAzN+qlA3XCsisq7Af+Pcfuo6V10m8ZmDTkf64RUq3coZKf
	QNSYaGpSkndcKw1sNgCi7M1Y2Mf+ArkUw+aF6dSrDR8exlFXVG6aJcu+Pps/L7bf
	Orh8Oqo43Baw11dEEQBvA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791545528; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:i8GY+dQpLj3RPKQGj/r8ZmtYxfmtRSWosMyf0l9VIkPCYnN
	smbhDd6LBI5DpEp6UlfH1tLdp6AXU2zLIpMGWbJmi5ytR+IuihA/uzbLoKX0ffXE
	l+fBJ02xQBsSMUmYu/B3f6+ATkaJiNQTLNMiSafKimAmjEOqTwmS/YcDBU1qR0uL
	y6Mckfa53t6yl9vj9OAumuwGG+3Dd2XOhRuLnmoHyuomJgsUxIt9makC2PRzQuzq
	mGPDtvXODVXchAhJllGmTpt7Ff+2crRB3M7NXSz5A+sjyCXCp812YceZWco8ipD6
	2om7h+ShPkLHFQfdyG9hfKPzgRrzrwaIzq58A8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8rnM+JeDhobCTmvSwWL2UCebVbjc7WdMgu0WfehSL04=:PbGwyVI5uPezwYD7qCE7SPyxuCO3sFTb3njMhJUyCe0=;
X-ME-Sender: <xms:uNDIatmNXw7jHJADdOfpo1Yedu04afpmBvHDIRyrP7fK8b6KN7KiLA>
    <xme:uNDIav0bW01eLv_a2eEnuFEt947042NvHMI2IGAwIQJshlciMPfFi7Uw-AsvQTDL1
    ui8Jeg3h9rNbsDHwGfdMoQJi_kkO3GH8Mz2WphJZXxpCaqrLqsOOPwZ>
X-ME-Received: <xmr:uNDIaopGFmzFo5LppHOgOSuwamolVw7apzNj3-tQM4axETJrlmpACFtmVaPnd9nbMXS66A>
X-ME-Proxy-Cause: dmFkZTE6wyWerhL9A/cGN6kpCRu75rHsvytPy/lWqDQKiRfQnclSVVHElbuyhWJXhkFFLH
    +EErGVYHPl8QeqmYeoaq4pYmDWm+LjnhR4kj5axfe9yIOW1sVydHww7v4JLAGUqXxfCPHE
    JCNwT2CoY0tu/TDXQ2GOaTKse4B1O3Geoc3ZxXm3fuREOR0cy1jCCibRSMNyiNpq+spt6I
    swto2Ms3/5wFmrkKXBxsvndkzj3JrlTFuX2+ZEAFQOmLLiw3DfRt5kPq0cXjTYbYfz11Zs
    Q4ahR44Xh5jUSIbFiVHWSLbC95ZLAs80qevrlolAEwBXlf19fAXg0G0hNhRHU0iJoY4YPG
    qN0SzmeNJC6HjdICO8ubJoeb6iVJESpY/D4Najt58x01+YvPpMsbFdvgY1KLQ8JZt6cBpl
    gxCWGnVFwwrov2KiFd+iYYi9quCOQlkvi0baxAoJqrT83xbpYxH+FK6d/+aRQvr4Lz1f+m
    0/BBuIMCD58kCeATVAWSkWoKedtiTH5S0ycBKvELuKIu6CHdzF/65bEtQUeEF467OU00wm
    PGjmV6VLAyi+ww47LHQKlgv9KqBItsOOgMoLt6i0hvyRLKG29ekVY818VzDOg3+IjowSFB
    9mALNgO6giX7M23orJUPxwBq8PclJ4grWLkmg8MLZgPVXOHlzBpoD+CsgM6g
X-ME-Proxy: <xmx:uNDIascSNJVXzpLgiNQDmyHzDcT44Rfj9slrIspzZ6IVvdC-zVPHyA>
    <xmx:uNDIanr-v94bB1X1naaiMbyuBjIrM1hePf5_N6Gb4NTwNjJbelc_Hg>
    <xmx:uNDIatFDbwnIlq2SR-XAMxfNMTSvW_WtL4CJijGcWkTbGu3ucnyZ-A>
    <xmx:uNDIanu55EUoskT9YMohA-yOYsWmHwrNCV9ypldNN5m9j_aWCx_kwg>
    <xmx:uNDIahld-KXIWJGDkbkG1veZfD0V6AIBD3s8kWdsH7T24I1ycP_yRpSt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:32:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7a2424a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:32:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] ci: some housekeeping and modernizations
Date: Fri, 09 Oct 2026 13:31:57 +0200
Message-Id: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CQAxFr0K6tmYGRZGV9zAsoHSgEoFMgWgId
 3fAvcuXvP/+AspeWCGLFvA8i0rfBYgPEVBTdDWjVIEhNvHFGpPi0CqSYNNPyi3zIF2NZ3JXV9C
 pNJWDsBw8O3nv1Uf+Y53KJ9O4pTajER17/9lvZ7t5/x9miwbLwhmbUJLeyNyDdZQX5Ou6fgFy9
 R4axQAAAA==
X-Change-ID: 20261008-pks-ci-housekeeping-4cf7fac3b0df
In-Reply-To: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.15.2

Hi,

this patch series is a result from the discussions in [1]. It fixes a
couple of smaller issues in our CI and bumps jobs that use EOL Docker
images to instead use supported ones.

Passing test runs can be found at [2] and [3] for GitLab and GitHub,
respectively.

Note that I've also merged the Meson changes (ps/meson-improvements at
ce4a600322 (gitlab-ci: fix hanging MSVC jobs, 2026-09-24)) in there so
that GitLab passes, but those are not strictly required as a dependency.

Changes in v2:
  - Improve commit messages.
  - Rework the "linux-reftable" job to be more useful instead of
    dropping it.
  - Link to v1: https://patch.msgid.link/20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im

Thanks!

Patrick

[1]: <20260906151137.GA328152@coredump.intra.peff.net>
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/687
[3]: https://github.com/git/git/pull/2445

---
Patrick Steinhardt (8):
      t5004: skip SHA-1-only test in SHA-256 repository
      ci: fix "fedora-breaking-changes-meson" job
      ci: drop unused "linux-clang" logic
      ci: switch away from unsupported i386/ubuntu image
      ci: rename linux-TEST-vars job
      ci: switch away from EOL'd Ubuntu version in linux-exotic
      ci: drop now-dead Python 2 coverage
      ci: improve reftable test coverage

 .github/workflows/main.yml      | 11 ++++-------
 .gitlab-ci.yml                  | 11 ++++-------
 ci/install-dependencies.sh      |  8 ++------
 ci/lib.sh                       | 13 ++-----------
 ci/run-build-and-tests.sh       | 14 +++++++-------
 t/t5004-archive-corner-cases.sh |  2 +-
 6 files changed, 20 insertions(+), 39 deletions(-)

Range-diff versus v1:

1:  654fa99d33 ! 1:  61d0ab3180 t5004: skip SHA-1-only test in SHA-256 repository
    @@ Commit message
         bit `long`, unzip with 64-bit support and it only runs when EXPENSIVE is
         enabled. Consequently, not a lot of jobs even exercise this.
     
    -    One of the jobs that does run it though our Fedora-based job, as it
    +    One of the jobs that does run it though is our Fedora-based job, as it
         ticks all the necessary boxes. But that job was silently broken: while
         the intent was to run on Fedora with breaking changes enabled, they are
         in fact disabled due to a typo.
2:  c75705d4c3 = 2:  d3bef5a21e ci: fix "fedora-breaking-changes-meson" job
3:  1d74ddf095 = 3:  e6d5135719 ci: drop unused "linux-clang" logic
4:  8c1d17e976 ! 4:  21a32d6f33 ci: switch away from unsupported i386/ubuntu image
    @@ Commit message
     
         The linux32 job is used to exercise Git on a 32 bit platform. That job
         uses i386/ubuntu:20.04 though, and that version of Ubuntu is end of life
    -    nowadays. Furthermore, Ubuntu has dropped support for 32 bit entirely
    -    with the 20.04 release, so we cannot easily upgrade it to a more recent
    -    image anymore.
    +    nowadays. Furthermore, Ubuntu 20.04 is the last release that has support
    +    for 32 bit, so we cannot upgrade the image to a later version, either.
     
         Switch the job over to use i386/debian instead. Note that starting with
         Debian 13, support for i386 has been reduced [1]. But Debian still
5:  4b919ad40e = 5:  01496b2238 ci: rename linux-TEST-vars job
6:  ab371f734c = 6:  f248065fb5 ci: switch away from EOL'd Ubuntu version in linux-exotic
7:  d0ff091832 = 7:  1148ebcab3 ci: drop now-dead Python 2 coverage
8:  2b0df6d4a2 < -:  ---------- ci: drop redundant linux-reftable job
-:  ---------- > 8:  71c2422b22 ci: improve reftable test coverage

---
base-commit: 8e383dedc6bbc4fd7bbb203512fbf2eafc151e04
change-id: 20261008-pks-ci-housekeeping-4cf7fac3b0df

