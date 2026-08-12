Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772240F74A
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786529523; cv=none; b=RRRgxJX/VZbmuutABjhuB+xxMJO+/RAWNIbSCl22Hs4dPP9/XUPRFYaRZUDcDsK/EqSnSBbj2BX9sk45MYF+SO4kN2s0nOzOzGxqPKXmnJ+HuloKkHFZhryKxPWsyN1bP6+HE5YNixTcrEYYdghGEEaLT+7PUiCs5GtEYe0wPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786529523; c=relaxed/simple;
	bh=9+/gIxsWq3HWPQNSQM4wypsjHtnJU9vd9iYpLpGBdRc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=VUk6ZWwkt+veFQwUmnTm3kEUkuMFPxxfpmDuYy93accMsBjiTxR/iYPN4mhS+GV+e7mxkH6jKkHjQ17jLJjDpEFOCIFV+njZUMCijdi779vJUgCUxfFiQSRLPtxA1u+rFcdPfvabe34zyqwyEGshS2t4Rp3sCdRLCU2347RYO4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QhBvw6EE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ScBOn/yG; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QhBvw6EE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ScBOn/yG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A4D9EEC008D;
	Wed, 12 Aug 2026 06:11:58 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 12 Aug 2026 06:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786529518;
	 x=1786615918; bh=KexKQi/ofvCkh8K+OqHT0JJnmJiZyq3POtm4xQSg2dU=; b=
	QhBvw6EEwyyuMjYv9G6LbA0hkLAyRJqXjOls1gqKlH7kNv9M26ddfFHYdDjOZ5QM
	VUSIBOROmnBFpK6s2OTV5NRVSt81rGfVIqgz2m1LlFTu90zl3vq77Ictc1XT8gao
	bshij3gCdG5I9GQtjkTYaqDaOYuXjbjiwtzVlWPxUf7dofMVW8IHzc9dbv+pYeXO
	N5xH9zFeAW0x9Hq+Kgxi/AXRse/PQnnyHXFq2Uylv9Bn3Ysp3AOdjis1ghQSNnBJ
	Zo1v6W2vv0xJaaBH5nNeLHeBYjzChY8L7XgihqBmeYdxkB3vwUwS80GhPyTN7/vP
	JT7RaP5ed6uXmQIJNmUeYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786529518; x=
	1786615918; bh=KexKQi/ofvCkh8K+OqHT0JJnmJiZyq3POtm4xQSg2dU=; b=S
	cBOn/yGTWw7ErJ9ERxdR0I0x3hsb8K04Av9X6N2sgwFo3lS+8d0/aowIhfPQI8k6
	eVqKZhYeUb0JTJstLMObWzuF48I7colfZx59aHUuI+vVv8/D41zhQmetIa8Jv3gI
	PRBvmfv4uGOO8sVwSOdpBP0OVx86GUU7oHhV7/Jy3qY6vrhf2TyLjYt3MFSEge6w
	zzSSin5H9k0MVTEDwaa6xJLtr4Rlic60DQ6u4dzm96VmKf+SqkJaMby5yj46nVK0
	+xUQBDdvIbYf1N8+sXWgv5ejA2SONSvUEbjltZOK3Jpgq7F/0xldYo16Vvp0ZyEO
	gocb6U+hPrjSATFN/dR7Q==
X-ME-Sender: <xms:7kZ8avxv1Ryh8lkoTjPg1H3NVCNDa4lOWDwNIt5Y0vwGCFMph-P1aA>
    <xme:7kZ8atS1YKa0gwOkLbX6aRW9unuAR1j8AAoJlWQdFY7IXAOq2tLc7Ot4Q8oyKZQIm
    6xO7uEetE_zOkBE9FdGjGYCAuCsh65Mky3pfLtXc2-FUlefSZhbWA>
X-ME-Received: <xmr:7kZ8am_ZQma97CcxW7CcdgtFFFVfDwt5VmEPvpM14omxVqv4SuKItgvluetrQDIBNpwLGFg2nj_7DgCGbe7vSOkJni6DDvGoIdvA1sorzA>
X-ME-Proxy-Cause: dmFkZTGUr+HC+aaKlVyItsQenhQHrYmtzwsWrErD06rMK0/4L5oc6vUrg6UlDiPGnjPoH+
    J8zOF8FILtrVNTCxh1MfFU5X6iQ3t/F2xMWJ4yvN7Ju2B8cOILbYSB/PNdprMjmJ65cyvf
    OtrZzlPrmGN/eLwoY4XmuMxydFRYPNkufUfSddHQ/xpH5toEiCoLFGLs8NnYA2DfTU7CRO
    oCBZvuuuaPZWAZlg/1YaYpE+GsbIh9x2y/JIOJbbRyQ46cRUsfe/kF5l/+62Inm6i19xc0
    CW5BJN31uAdZ9WJ5M8H9M/C+QtieTglthMXlNBkHlXGqfMTxTeb9My2zvYJWzTyQiNyicC
    dVSjyvoim+xFLcMqcKAbcW2b9P/fYW3hpCVSqT+3FhcwKvTXTOmF6h/HlIfcw0HbFegYHH
    qdHKLl4D0/QTc0xcSDDnLKD5l8dkl78sqGuXA/+Lqzq659649OoB6itgptDU1sq2Li3+hp
    cGze1eNxPSxwJS1ee0ObxU1yJCeJ9Ta9o/dHVepPD3DxVxy7j/CYDYwTI4L0NrKp/jzOTN
    HxC2M0mGMDH+eX9WRUEH7aIqnD6ACUSgVyy3Q4quDCEFBjnRbBwjK9UzILhGeisZuD8nmg
    a5snrLIz/qjhpJ3Db1/bv3t5BeNIGyLw7VR5hf/J58cuPddvd3rJM4QziGlQ
X-ME-Proxy: <xmx:7kZ8akqX_nXDBCZMX3AerBFssILXOU2xfm7jzM32zaBz2yF5hxqtFg>
    <xmx:7kZ8ajlkUYdwFW2ZTI3I6r8u-3iRxJUFqkbU956T426IoxF_4y53pg>
    <xmx:7kZ8arLN1i1FE2xMfCV4IN61v8a2eqRbEPTGAPodGuyszelgjwGeQQ>
    <xmx:7kZ8aowz8Fgu9Q3DR8ZnDStg_Z1saYXAoPVorH-3uMPSOXiWv0tPlA>
    <xmx:7kZ8argKotHk4VFCJQNehUarp1KGE3DWRx_HGhBSYnlNimIoRA4f5fPA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 06:11:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 588de98b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Aug 2026 10:11:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] t7900: fix flaky "maintenance.strategy" test
Date: Wed, 12 Aug 2026 12:11:45 +0200
Message-Id: <20260812-pks-t7900-fix-flaky-test-v2-0-9ea0e1ac0edd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBBGr0K6dsxAwo+uvAdh0ZapjCiQTiUSw
 t0teAGXL3nf+1Yl5JlEXZNVeZpZeBwiZKdE2U4PdwJuI6sMswIrLGHqBUJ5QQTHH3BP3S8QSAK
 kBWrjLLki1yrOJ0/RONJ182N5mwfZsPd2o2MJo1+O7zndvT9u5hQQsGqRNDpjbH6L6plfqtm27
 QvWBoKxzwAAAA==
X-Change-ID: 20260807-pks-t7900-fix-flaky-test-160abfcef65a
In-Reply-To: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im>
References: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Hi,

I've recently noticed that t7900 is flaky, see for example [1].
The root cause of the flake is the auto-detaching logic of
git-maintenance(1), which sometimes causes us to skip maintenance
altogether when the foreground process is racing with background
maintenance.

Changes in v2:
  - Perform some word smithing on commit messages.
  - Link to v1: https://patch.msgid.link/20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/jobs/15762975482

---
Patrick Steinhardt (2):
      t7900: adapt some tests to use a throwaway repository
      t7900: fix flaky "maintenance.strategy" test

 t/t7900-maintenance.sh | 76 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

Range-diff versus v1:

1:  10521f07ad ! 1:  1f3f8aa538 t7900: adapt some tests to use a throwaway repository
    @@ Commit message
         tests more neatly self-contained and allows us to trivially modify the
         environment in the next commit.
     
    +    Note that we adapt calls to `test_config ()` to use git-config(1)
    +    instead. This is because on the one hand we don't need the auto-revert
    +    logic of `test_config ()` as we're using a throwaway repository anyway.
    +    On the other hand it's not possible to use `test_config ()` as it uses
    +    `test_when_finished ()`, which errors out when we run it in a subshell.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## t/t7900-maintenance.sh ##
2:  71cb84a4a7 ! 2:  ba1fbb27f9 t7900: fix flaky "maintenance.strategy" test
    @@ Commit message
     
         But there's a second condition that may cause us to not execute tasks,
         namely when the "maintenance.lock" file exists due to a concurrently
    -    running tasks. We usually disable auto-maintenance from detaching in our
    -    test suite to avoid exactly these kinds of race conditions, but in t7900
    +    running git-maintenance(1) process. We usually disable auto-maintenance
    +    from detaching in our test suite to avoid exactly these kinds of race
    +    conditions by exporting `GIT_TEST_MAINT_AUTO_DETACH=false`. But in t7900
         we unset "GIT_TEST_MAINT_AUTO_DETACH" and thus enable the auto-detach
         logic. The intent of this is to exercise git-maintenance(1) closer to
         how it would run in a real-world scenario, but it does cause us to race

---
base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
change-id: 20260807-pks-t7900-fix-flaky-test-160abfcef65a

