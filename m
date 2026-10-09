Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C314D4867
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545558; cv=none; b=C2/INcGhKJOZuj3laErznQKKORTZR9Sr/pMO9LlGJGbF/oxf+KeKnLF6rRMLk3NOzV4KOoulLYZfOg5rWfNFKGSeGiz1ZYK6ZKslEjLcTxovleDeQ42Skp8ETXN/QJU/Tya62H73DfRuIVll07ntm+4TyxG2yJ5qOButFHYX3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545558; c=relaxed/simple;
	bh=kFbUjixQA+PTsa0WLMgx7uHyG4jlOEjXkjX9DUJuAI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llc0b5dsV5/RH6lsCUbgZXPRFCry4wXFETl5GMOSAk6IIQoLmqBAHtGsG1GU1HMnGaMrVseA3tv6vcAKbLjpxtrRqWMSNCHVEo3hcLNHDu4bYu/33ShOqPfMiLmXY+BpA6HykqYIjo7x24i7aqcQpqN1Bcf8PM0elaljZKJAlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ney9WQmb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lmqBd8eU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ney9WQmb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lmqBd8eU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B3356EC0192
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 07:32:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 09 Oct 2026 07:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791545545;
	 x=1791631945; bh=6iAcHnluRVMZp8EajEGDbni3tS553Fg4dlsiVKu1Xxc=; b=
	Ney9WQmbDBUkm8cx7OOLBQbRiP6sR8oAl8esPSUIz6eIv5+qJM3j4dxm0rV5A7A4
	qnwL0SNJWbRFQs64e5M60uMvzWGchHHQOHURHXwpeNgWlyK3+SRhl4vlYM6ZTtpk
	JG/+BMSVG+PSpcnwM/Nbvx/dJBiKNvuS1JqftMujb3d6/Jz0EYf1ek756qzZGDuB
	BMATzmGm4cZg12DlQaAGrgTMb6bQW9Lcu/+EktrU5abb+m8hJkMzIlnQ7oD3thN3
	aOBW3LC3xph2zaC8V9JttZuCHFrsaV4wJQT7Kz1wN1nhngWf7Bvv+trujNCg/nWI
	Cy+EaspPOY64bPVUjf7TmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791545545; x=
	1791631945; bh=6iAcHnluRVMZp8EajEGDbni3tS553Fg4dlsiVKu1Xxc=; b=l
	mqBd8eUg+cvgdA5TzLzNSj610cJjfa9jSCkkERouHa87TFmQJ91rCed/GvtGzy8z
	MSNgoGXnltXVRs649AzKaafE4mE9XeY4JK6XDRom1wNSZMLI3IqDZeywatM2ckxG
	stVsu8fEA3DKyZBdotsDIeRTqu8a/ORmbgvTBYKR3KXuejFDqpaY1KEv073DR5TW
	5tsVEgRrOE+bCl3WXTGztjvFoGa5Cw3O2DS9g60Gv63rOeiKKo6qUgG3CxuLrFrz
	pzw7ws4yOMfOT8XKNYpMciCfQw2owiiTkPro1AzYpZu0YfT2iCiwevtulbEt+YED
	eMhZ7lZzrWS07hmYZT0DQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791545545; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:TmyN+HcAffFsDybLErUyf669li78Sls1zV1GCS+95n1A0VR
	221155MUKzzx4xKEXdan51rEPspcboCn/9cMfjLEq2HWAR2q+u0BS4VLm3f3eWHf
	5tdXI0wisdjxAmGtP6pcy+CVo8OYlOAZylOMatpaW9twMlHEk+a+zQBf5wmMaK+g
	RkJ5wGQpLjRNi9crhE2qNkM6dlbhywLfHgGRCWmlWD+Gl1ACfxNfXr3QE6g9E6bD
	ohNPUFHCKsjKvBkWki8w5LfXeSBL6A/UhG+APGaQ5ppHaO+YbsykotqFp7+gT6kF
	Zn+SNzpV3DAdQD6tmtSMgv4u6b3P3Snn+pBOmzw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1wpovpumAdbjxC6rABw4ujW0xJ8KNluSJUL2r4I+er4=:kFbUjixQA+PTsa0WLMgx7uHyG4jlOEjXkjX9DUJuAI8=;
X-ME-Sender: <xms:ydDIai6UqzKTuHpj25riHkPOcHzBvx0oiJZx-0Snms5MHIGMu_llKA>
    <xme:ydDIai4sxpv4WCOBBEJruGiGb6wNUWjUj5H4l0fTkc1UttCGG_djwOCKKy5dOqC1N
    uTwKELNZ4REuSHS5B-y89stZS5a917RxWXAwwZ3SQ5-o3FopM2c>
X-ME-Received: <xmr:ydDIamcxZGuJaAYBVtakMo_Rem_KYisEtSJTWbr4OCEcwRW7-1gr-bmVxdsYeSuGuKxXeQ>
X-ME-Proxy-Cause: dmFkZTGknl6yE3HW/NrGapr1Aop3MgtD47PMwCfDDugca7CWUXXky7q0FpYSBE05SXudfz
    LlIodzRAeTq8d92QYqKnPRvWufPbiv4kWYp5in6jgZJeabTHk0GqJNqanN2eiji0RnveoM
    4p7l9jUVVnBQzCu8/QFoF3VfEAwl1KbE3fdyOOnMU+YliNHKUthalN+v2maOY1D1N+P+ui
    7z2urcfnQC9A9F9zP2bDHRvHwS2EbkE2TlIhnF/RJLYK0gsaYf/TRild6oOCRlivQYpiGb
    k2nS7fqIi2LHePZtCqKFTZwlC841QJf9RKY1jkMyx0MdjKFa6DfLPA9HvLWWvarW6G8WiW
    Gsv090q3rxA4AddJu2rsptE53G224E08Kht9X4b3yn09w92dW6R/y2iNCdHNevPwgmBsE1
    C2fLvb53zQL60pY6LKTxQJD68tkOVr3/copBMT6BCDPKo1yz5dIdMhWB3QAzO1I4C+K+bH
    /g/+1KBzIuK14HJ3H0NOZC9AMcloHiXYDR8zu5fucV+EjFGvTiAAHpXCnrtrkYqppom86Q
    CkHlNgnheWmq34vhg6BadOEdT56myyrIhq9M0Rn9SB33QKZEl6ars00v5Mx+sjTYllg/cR
    0/tI968E40V7Q65N9dYCZSse2q2pf26x+vKb5pPEbuQGA//5aW8wrjIe8Ukg
X-ME-Proxy: <xmx:ydDIauCgH3Tvc27nnevW_-t51yWecuUiCx0QujPKdWGeNN9QII3LyA>
    <xmx:ydDIah_1wRcnUyjkykPsQVW1s1UhHUFi8W8BIKpW8E4ZY0PspaZ91A>
    <xmx:ydDIahKG-Yi6uB5nFssg__d2WPBekeRMs_AzZ-LbecnN1tNDmjRsoA>
    <xmx:ydDIaihVNT2d1yRnRBo_Xif1Ld8YdBo2GWFlAKhPbCGhIM4DO3pyJQ>
    <xmx:ydDIahZpD6idgg8kn3Rrob0JYAigNvCuBsCQFJqZQtitW7s7bkq6fzjw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 07:32:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a476fa82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Oct 2026 11:32:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Oct 2026 13:32:02 +0200
Subject: [PATCH v2 5/8] ci: rename linux-TEST-vars job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-pks-ci-housekeeping-v2-5-6863d58ef691@pks.im>
References: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
In-Reply-To: <20261009-pks-ci-housekeeping-v2-0-6863d58ef691@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>
X-Mailer: b4 0.15.2

The "linux-TEST-vars" job exercises Git with a bunch of non-default
options enabled. The name of that job makes you want to cry though due
to the weird upper-casing and because it doesn't really tell you what it
even intends to do.

Rename the job to "linux-exotic" instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 ci/run-build-and-tests.sh  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6d1e37c8f1..d7a301ec98 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -408,7 +408,7 @@ jobs:
         - jobname: linux-reftable
           image: ubuntu:rolling
           cc: clang
-        - jobname: linux-TEST-vars
+        - jobname: linux-exotic
           image: ubuntu:20.04
           cc: gcc
           cc_package: gcc-8
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7d972f0c8b..27a16ed086 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -42,7 +42,7 @@ test:linux:
       - jobname: linux-reftable
         image: ubuntu:rolling
         CC: clang
-      - jobname: linux-TEST-vars
+      - jobname: linux-exotic
         image: ubuntu:20.04
         CC: gcc
         CC_PACKAGE: gcc-8
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 23e87cbbd6..9381ff8893 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -22,7 +22,7 @@ fedora-breaking-changes-meson|linux-breaking-changes)
 	export WITH_BREAKING_CHANGES=YesPlease
 	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
 	;;
-linux-TEST-vars)
+linux-exotic)
 	export OPENSSL_SHA1_UNSAFE=YesPlease
 	export GIT_TEST_SPLIT_INDEX=yes
 	export GIT_TEST_FULL_IN_PACK_ARRAY=true

-- 
2.56.0.170.g584c36229d.dirty

