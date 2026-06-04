Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D4383986
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567667; cv=none; b=V/DMX60pl27YfIbo8rE9VSuA+z34tj6n7cw2GIvKecDdaAMtwV6OjxgHyDg9eDftvIgDoc/hwhKilEzWErdK8Di+1Jyq9zlNOOGVqtHvxFIs/YTq0m6IpLMNfetm4JSbslxNV2C1SdFtQmCeWEYWrb7HOOCwgV8B1qF2qTi7qvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567667; c=relaxed/simple;
	bh=N7qSspW3y48gsWQUg+Gjh46hPMEovAjiiXz8IIqP10c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KyeisYLtN32KvQG+kxLYsiopcZDEwu8Qja8jAKxF8Xr+Fjz+HOQWOcfh6VaxX0j9sG/o/GfyJ22o8Yv4wrAyxiUynjmtPGXRKRbCWg2BlLZrGQtxVhKjJzoM6d8hJQ1/TjlqKKJQ2fcfftMRAwRI95FjAHL4Om1BMT+Xc3UzghA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sgznWcYB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hs7MNl7j; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sgznWcYB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hs7MNl7j"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CDDCEC01AE;
	Thu,  4 Jun 2026 06:07:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 04 Jun 2026 06:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780567664;
	 x=1780654064; bh=3sE78lPXrSRAm4/DitATkEiXQDC+52JH70VgufH37SA=; b=
	sgznWcYByazgqLarNS0ye+nqrT6ht5anWYNvguwSV3x68OZ0RkflmJyKI6eaMyBC
	rUEeOjs8x7nYPzDvXTA8EAaZQ2hAistVFoy2K3rwawvmzndWXS+vW+w2l5qaSsHV
	yzg56rkkkNfJodDKzUWLEECNVFJS05w1WJEqajitpp4IjPpcq/m+z4UxhpqDofRE
	Zm6BOeDxK8jaIN/mNU3G7VUCN0r3+I6N9jyqknuW8RAnBtXNJy1Wdi3He5MsuYCO
	aGkX0vIuER3dlaMhDTn45TKv/b3XqXJcA5/gHvqkN7cCqiM3hE84jtVfx/E++ozv
	wl8AZ8zuCZYI0lovwR/qPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780567664; x=
	1780654064; bh=3sE78lPXrSRAm4/DitATkEiXQDC+52JH70VgufH37SA=; b=h
	s7MNl7jecJlBeZaIrrmRwVgtCPRehFMik5efZSRCqpasb+j/H6QU/evn+yfW5zEH
	jWa//z/9K3FvN+Kn+Yck6QudpPLqcfRNhjsKcOphcIogQaP9O0vaD8flSfPmVcj8
	DGC36eOXHsPkjAo/LQSMN/+FdejsLcfYXex7rSmwKZtf60/EluCshrSG8jl+qAa6
	BHUzR3cmeXUE5AtXoPyupZVZMZdX+vz+8WbdUJtWYcejEkK7lPys0ZvxOxy7TsYc
	px0JIvawRK+dk0j4aQ6meaIy/McvBTloDLYm13yoA1zGH0EIog/joCs6t8MT8Ffe
	SmO1rav/39ymYahL15C5w==
X-ME-Sender: <xms:cE4hap81N1wRoPvPTcDdUreDSreOf_O0aFzwNc2rfK-D6DM1ecx83w>
    <xme:cE4halKmFOBPp4Xtbtv3XmgaiIRh9wn8ZNWs6ez6Xxjc8omDpsZ72vGW_I2Vi05dF
    MuNCQRqKGuSqoGy8rRseb8wDKs0L1qhnOolElPrcRhQ1jCzdHXcjw>
X-ME-Received: <xmr:cE4hakaFTppxS2V3Q0qWL_yKQnzg-VC8KaWJgIlilzrJNYr7Xiy2IFG3y75sJwsaqU9uZWo_7cdIZfSWm3hYIZCRWH-haeJ2xuVfuxKqIXU>
X-ME-Proxy-Cause: dmFkZTGMbu7/w/ZaywpulTbV6q029k+4CRvBefE38zDB+oDDpe7/ZuzFboKkGddDMpC6H8
    Q65cMH2hqNVIApiwywAi1d3oCMuupua5C6XrHnnITffKfmMRVwTdI5GHkudmJ7ZKEZrrYX
    CKOmv9t1NwRbtoOICGlQGTcGJ1FFYgaEdOYRqLfZqhIlP1ZWNMKv3dVVS2jOfp6CH85ck+
    X+GJZjSuAt4gnXgZR2jlgA8pvi0autxCCmFsaQ4hwO4cz1AmajGgQcBQ3nWLBS5d6EXh4c
    RYSw2h7nb13kcCW4tZMqTZU+tBdbJ81eaW33xVcSzp0LPE+7+IuXs8Di5knqCnrNht8gOH
    gCut7js3q2lvo/CrZLWPmLNQv2GSTRcnpnKYHMm4jPmlLrqtxvxSZmlwYcQ14j3JdjxXne
    3tPQYPycqLhEs2WgqniHvT8JjHE6NjrgtURy2jGU0Cs+HgDR6hBa6e9YGtwz0YQCAeQxrk
    EJxyRTWr1s+WxupbczcxnJ0O8AXLAigDdTUrH2sALGqvmLDC3kO5IdlDUoBJ9N/tSgfz0C
    KLMz/IRXJ/wnrsBbiy/ri9+To+8CcxgHgo1VGtnsbybKGOElAcNeeCaHFY3wz/IFZvUMvA
    Bpl/BKcJ1yG47XXL25PbHT8cmZ/a2owbW2sdFlRwigFQu295ormq8+/vM+tw
X-ME-Proxy: <xmx:cE4hanImfrj7tf_EmPU8ssd2N41MFGQVN5KGKpw7CgiCbBrrCCg0Ng>
    <xmx:cE4haiBGuptp0bhR7A4rVDZXliuVv48l-JV1srpH7Hh9IzL0aPTtVw>
    <xmx:cE4hasocYhndkgo3pVZKFJciRxO--MDUyn6UADfwYHixe3IQqh3Diw>
    <xmx:cE4hatjHrhhVt9dugd9ynqe4z2oUKizgjlR_D3R-VkRBYIvg5SFriw>
    <xmx:cE4hat7Pg_4kjUu4IZYYjHGZPSrdDp5bnHr5TsPUPR1aLCIqUwp6XoA1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 06:07:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5adaad75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 10:07:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 12:07:33 +0200
Subject: [PATCH v3 3/8] ci: unify Linux images across GitLab and GitHub
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-t7527-fix-tap-output-v3-3-7d766ed481e4@pks.im>
References: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
In-Reply-To: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.2

The image for the "linux-breaking-changes" job has drifted apart across
GitHub and GitLab. Adapt it to use "ubuntu:rolling" on both systems.

With this change there's only one difference remaining: GitHub uses
"ubuntu:focal" for the "linux32" job while GitLab uses "ubuntu:20.04".
These are different names for the same image, so there is no actual
difference here. Adjust GitHub to use the "20.04" tag -- this matches
all the other jobs which use version numbers, and you don't have to
learn Ubuntu's release names by heart.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .github/workflows/main.yml | 2 +-
 .gitlab-ci.yml             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 3da5326f0b..cf341d74db 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -407,7 +407,7 @@ jobs:
           image: alpine:latest
         # Supported until 2025-04-02.
         - jobname: linux32
-          image: i386/ubuntu:focal
+          image: i386/ubuntu:20.04
         # A RHEL 8 compatible distro.  Supported until 2029-05-31.
         - jobname: almalinux-8
           image: almalinux:8
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a5bdec5159..49f3689b6a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -47,7 +47,7 @@ test:linux:
         CC: gcc
         CC_PACKAGE: gcc-8
       - jobname: linux-breaking-changes
-        image: ubuntu:20.04
+        image: ubuntu:rolling
         CC: gcc
       - jobname: fedora-breaking-changes-meson
         image: fedora:latest

-- 
2.54.0.1064.gd145956f57.dirty

