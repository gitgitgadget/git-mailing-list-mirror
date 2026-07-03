Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81F37C0F8
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070661; cv=none; b=H0ngX4E3dKT2tVi9b/IfexGHYjbOAKzYmZR1uyYaX5t6dWKUXZrAVFG6NLZexsOgDr2TV1CBQazUZxL26u8T3Z0kDHjwRzQVH4N5uiFyR84gr5eK1X5zhGgs2rMkzpWqNxelHeZOXHGMlsjO0uTHeMzUPW9Hd2hB/5+WSk891bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070661; c=relaxed/simple;
	bh=Pcrkxw0VLDxpjaxiayegtbpaNmbJUUeYU28rhmIQ8fM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=FOE2aGukPi1Aa5I1EQX7FkOKhHdHga1TVjPG5dlpCk08akYdQY8P3SB3GAr+vOfX45su+S69ri6dB3pkc779PTRFsLiFbDvsNScaEjn8DpzeMuwOnnyA9o96UodQB8+YansLUKL+RgV2/X9AQ0xZr6tD69YBNtMUbn5ZTAQPkQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UC0+SNkH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nL3tj9zS; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UC0+SNkH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nL3tj9zS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB7E17A00D9;
	Fri,  3 Jul 2026 05:24:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 05:24:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783070658;
	 x=1783157058; bh=MIMTwiYis1kdYzFxPfGQVK8wUurf6Z4ztFLpdWxGGsw=; b=
	UC0+SNkHNIsb1CYu9TpdMrCnunGjytdMH9eAiM/D1OBN+TEpAt2YAXXAmYIUWrlj
	qLzcAmz9kQB3vWqAr/l4ShwplGxEC1ai+9B6pP72eWs5BIENdpcxwHrZjXrFbh9C
	FJuX5mjACimKNERiVm9mOp4zz/cb45FLFAnBwCP3PMflRpvrRseJz/xKRPQP9Jc6
	503pG8wbW9hXUAjl7ZTrjm3XQELSRKyWZJN8BWCrliGcteoKnFoHBRTh9jbHrJk0
	2vz40XirsKTzIrk+g+1xK6Zv/gJuQJYw5LlveTUc7o9XjlmPhIfSRSPXlv5Ih5pL
	WvnpVZvD1eKrKrwWMLkl4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783070658; x=
	1783157058; bh=MIMTwiYis1kdYzFxPfGQVK8wUurf6Z4ztFLpdWxGGsw=; b=n
	L3tj9zSBTzyqbWV+lrh+hycJRGZzB1U8NgglZ2BwyfvKwLZT+xtk9HL/96/1PIzO
	Krccbn50lmteicNgEK6YjHdVR5Z5J81LBWqDy5aLim4yX/YOMKcSR84FadENAadM
	cq59JMST1tOcwMgxNReIjoHfM8pPRIi2T3Ub/A5fCd/bI3ddJrPW1CCWOLyf9qso
	X1vE9y3A7lmA4G9TZYP/jUDGPWNRIVVf6HW1jJQQCuNbkw3UN7N6d7RT69A/ZHkN
	leplKVCdAKD78vAG22ZiIKGJwwrjsRBl3wnb9uvKAg2QChTnotlHFD5RgR39vyvN
	hn4B905/5pyeu3VEF1Qww==
X-ME-Sender: <xms:wn9HarkTTt70afPWVrGmoRC7wZ7McyUOakxIVPW9sBptz06WuCSbtg>
    <xme:wn9HaluCr4RqHiBuRsIalHxAguPjH8uPPjANZ3jn0_uOCmIriGzt9gTeA1fga3IwX
    U_63i2ZkK_vfQ9YfZWtdOu4b96llp_kZnjzQFJ43Lyt49Zpgm-PZw>
X-ME-Received: <xmr:wn9Hap_VzubpVy2uDbTxPPN4UvAmpl3Dmjk2DEIbHeVeOm1x0pKcxQui0w3OeMI2UmJa-TZm_QUkApv_-lgRX_6_neRwWxUkZ2bKl-T0wQ>
X-ME-Proxy-Cause: dmFkZTFRM0A9tU8hjPK+PqpQ/edVIL2ou0+79xZ0fIdrro6yJkmljz6eKPD2AuOJQiRWZi
    jw6IH9+J4EKZwAn8PMd24fBVEuSePsVswPe36gko3wJvTCfpbnfFeX2Eq7aiNMraeGkBcO
    U3V1H4z2Xb1fhFc126uq6SA1xb5AL2BZjbByUDirrOKEYmUMRVsk/0b8wrRcRXfHxX0bOh
    t3hDci1pANx/CZ2LyuLcZWE4WSK5I2qp8QCZqYO6RlRH7JeNGSuGTiqQaKpf3qylOeF7Mf
    eUVmNIQ+GvjlWoiyjLHNOarcGHX3MTKI8BlAgjbS5Z+kZSVVGlVo0xZ06kBG4rrGappFIf
    uFIr0szbljdIGgRfqxs5B4iTMplw10c6jX3hsDy/KkDBF/BOIotmFBs4kx5n3XSZNftz7K
    4imhCdBKxXPiFkaodsZ6tSHincIv0TcQZfNZF//OjoPo6WmMHQB2EdkvmLL8NJGqmDetYQ
    begfxvo/+OWQOB45MIXIZtdpgfE7PSp7QOnkqC8diQhiLwKuT15rtlM0Aq+xHmFzcEEkkc
    tBbneFy27HNlKCYEh9uhBuWSqLDRACUkTypKGlsEpQPhEEHlP9J5gXxoKTyU6Hb2ns4Cd6
    b4zaDdYJjxPsVF8EO2Q5CNE8y4X9ObTwoZXvWL1aB8+uPink9TX5Rwr0K8XA
X-ME-Proxy: <xmx:wn9HavP4MnBhplhscWuZT_Vff6aRKkXTLZErPQKwwpxyi42BivEjYA>
    <xmx:wn9HanEOeAA39lf9-M7zvquJiNPtUFYZsUZuPOIz910U7L6cz9VF_Q>
    <xmx:wn9HatQFQGKPMZYif2sD-ug9plzIllo5VWRX_JWLsaCehfS5u2u-wA>
    <xmx:wn9Haks7KOgthLIYZM0mIMjbCCa7mQ_dXppHHwQ4O4b3Xcbcd5KcOQ>
    <xmx:wn9HaoqRnN5DH_3erW3Q9ok1QIeWVFg_ilUVvJSdI6Finh6XlKG24D90>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 05:24:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78f604ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 09:24:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/9] t: fixes and improvements for GIT_TEST_LONG
Date: Fri, 03 Jul 2026 11:24:03 +0200
Message-Id: <20260703-b4-pks-t-fixes-for-GIT-TEST-LONG-v2-0-79076a7e0c62@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALN/R2oC/4WOwQqCQBRFf0XeuhfjaI60ahMSRC1yFy6cfOYrU
 pkxKcR/bzRatzxwOPcOYMkwWVh7Axjq2XJTO5ALDy5VXl8JuXAMUshIKOGjDrG9W+yw5BdZLBu
 DyS7FdHtKcX88JKhiWgWxLgWJCFymNTSrrnLOvmyf+kaXbupORsW2a8x7/tD7k/ebk//neh8Fq
 kiHhdK5Dgqxcf6SH5CN4/gB4URZG98AAAA=
X-Change-ID: 20260701-b4-pks-t-fixes-for-GIT-TEST-LONG-78e538bf0e06
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

Hi,

this series started out as a simple two-patch series that wired up the
GitLab CI badge in our README and GIT_TEST_LONG for GitLab CI. But as it
typically goes, tests broke on GitLab CI, which made me realize that
they are broken even on GitHub's master branch right now. Some tests are
failing in the linux32 job, and we only didn't notice because the whole
pipeline hangs.

So I had to go down the rabbit hole a bit, the result of which is this
patch series.

Changes in v2:
  - Reinstate the EXPENSIVE prerequisite on t4141, as we still end up
    reading 1GB of data into memory.
  - Improve a rather hand-wavy commit message.
  - Link to v1: https://patch.msgid.link/20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im

Thanks!

Patrick

[1]: <akIfsaVMB_S6kfJQ@pks.im>

---
Patrick Steinhardt (9):
      README: add GitLab CI badge to make it more discoverable
      t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
      t4141: fix inefficient use of dd(1)
      t5608: reduce maximum disk usage
      t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
      t7900: clean up large EXPENSIVE repository
      t: use `test_bool_env` to parse GIT_TEST_LONG
      gitlab-ci: disable RAM disk on macOS jobs
      gitlab-ci: enable "GIT_TEST_LONG"

 .gitlab-ci.yml             | 13 ++++-----
 README.md                  |  3 ++-
 ci/lib.sh                  | 12 +++++++--
 t/t0021-conversion.sh      |  2 +-
 t/t4141-apply-too-large.sh |  5 ++--
 t/t5608-clone-2gb.sh       | 66 ++++++++++++++++++++++++----------------------
 t/t7508-status.sh          |  2 +-
 t/t7900-maintenance.sh     | 56 +++++++++++++++++++++------------------
 t/test-lib.sh              |  4 +--
 9 files changed, 91 insertions(+), 72 deletions(-)

Range-diff versus v1:

 1:  1f445b2106 =  1:  a348e70b40 README: add GitLab CI badge to make it more discoverable
 2:  f2d21ef6f7 =  2:  c7444bddf3 t0021: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
 3:  656d6b9ada !  3:  aea7f61bbb t4141: fix inefficient use of dd(1)
    @@ Commit message
         been optimized to generate the data fast.
     
         And indeed, doing this conversion drops the test execution to less than
    -    a second on my machine, so that we can drop the EXPENSIVE prerequisite.
    +    a second on my machine. That means that in theory it becomes feasible to
    +    drop the EXPENSIVE prerequisite now. But git-apply(1) still soaks up 1GB
    +    of data into memory, which may count as being expensive. Consequently,
    +    we keep the prerequisite intact.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## t/t4141-apply-too-large.sh ##
     @@ t/t4141-apply-too-large.sh: test_description='git apply with too-large patch'
    - 
      . ./test-lib.sh
      
    --test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
    + test_expect_success EXPENSIVE 'git apply rejects patches that are too large' '
     -	sz=$((1024 * 1024 * 1023)) &&
    -+test_expect_success 'git apply rejects patches that are too large' '
      	{
      		cat <<-\EOF &&
      		diff --git a/file b/file
 4:  91ea8610ad =  4:  30b618259e t5608: reduce maximum disk usage
 5:  5d1f630617 =  5:  23898a60be t7508: skip EXPENSIVE test that is broken without SIZE_T_IS_32BIT
 6:  4938e39e47 !  6:  835fa0f8e1 t7900: clean up large EXPENSIVE repository
    @@ Commit message
         One of the tests in t7900 is marked with EXPENSIVE because we create a
         repository with 2GB of data that we end up repacking. We never clean up
         that repository though, so we occupy the full 2GB of data until the end
    -    of the test suite. Besides clogging our disk, it also means that all
    -    subsequent tests may have to repack this data multiple times.
    +    of the test suite.
    +
    +    Besides clogging our disk, having an EXPENSIVE test that alters the
    +    repository's state used by subsequent tests is also a bad idea, as it
    +    can easily have an impact on the heuristics used by other maintenance
    +    tasks.
     
         Adapt the test so that we create the data in a standalone repository
         that we clean up at the end of the test. While at it, also disable
 7:  3a19541964 =  7:  13fa3db8cd t: use `test_bool_env` to parse GIT_TEST_LONG
 8:  7d33694504 =  8:  d8f94cb564 gitlab-ci: disable RAM disk on macOS jobs
 9:  56c0239056 =  9:  d4792b76a0 gitlab-ci: enable "GIT_TEST_LONG"

---
base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
change-id: 20260701-b4-pks-t-fixes-for-GIT-TEST-LONG-78e538bf0e06

