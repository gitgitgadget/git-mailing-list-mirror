Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170CA3E928B
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438379; cv=none; b=khjA1jV57r4O41lPnaAelDKXkBUKtsV252fqL4lNaZlsqZ0p/DzcVpjQQkXnFSKOXtv0+gNmSNfGySTUz6Az5fDGqmS6dn59zNX83GTHNionFniBxv8CJNBuLUzDnlVGf9kgv7o+Yo/tdGsjsED//oT4wzPdV4Bb8enwTW0EgTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438379; c=relaxed/simple;
	bh=cX5PdBTf+Fn8aZqStSBi4FgElgplXLWkmW7YjKA7yMc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qK+vzoo5VWp4wmQTNSj8mV/4TlzOjUB+C7XEAq69N9vg4jk9+i+gRTMH1NBJp0lmhkzVf3hnNWSNMg64PJJgCVmGP14SrglPku1GJEEAatDBfams3IMLBAIlrb1teKOK9joGi9bn/8GbPcLbyL4SATgJgGtkd8U6k3RK3KPwqn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ADngmwie; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SSd62u9h; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ADngmwie";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SSd62u9h"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3925A140003F
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:32:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 07 Jul 2026 11:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1783438377; x=1783524777; bh=hr+FOk0ESk
	zFeQLrfvZOHCl16brexSDTD3aTjsuXqaU=; b=ADngmwieAlY2bYTHzHYBFwbCwY
	OFacrvdeSczPN+PG760Kh2rg9OwwjlTiyRUjr+wP+CXMK6U4N7fwXaC4WhemA4LG
	bfKFxdP25qfeHui+6WnjDEciyh+AOZmC0k3wSgP04+El+poCGDExA7OWRIRV4u1L
	Q0dDdA52W8w/NDGiTazFwujQUwI+QWqVwFSqCdf8ZTO0CYNmE/DoUEPItq7lrf4y
	mnc2b+aZAAczbmtmIoBc5fUDkHzQ2TBOc7KPFJf3ASqS7a0QJCkIg5uwVdw2AK8n
	vAN2XgZQfeGU36/nElecb4XWXxbrmRhWxI/DKPc9BjUbY/lrAWrzVpKR64mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1783438377; x=1783524777; bh=hr+FOk0ESkzFeQLrfvZOHCl16bre
	xSDTD3aTjsuXqaU=; b=SSd62u9hR/VJyjuaakg6aVxLkmXuEMR39ixl/sJDdIPe
	ZwToOK0vi15wP6ORSltiGmeG2DxIuPOsdnOJacVwKoMmZQGnGKG5WJukL0cHf9tg
	vP4j8V5nKRRChBtipVJPBC/ErL4ARz/StSU61Ghz3J1K0R8Gs+PhUaa3NRITLAxy
	VOuinP0xoSfIKcKbVDdSU3nyKsae9ZknKY6rjo4a0SebODOys0LnOKW6wrPbTaHg
	keioDPFtVne3HlSxOb2mfer7UzdhnqunmTKp5JP+yPsKj+NCR+bM90uljSVBS7QG
	rDVUb0pL+froLlLsezZ9ALeVtkfESX60tY7BHsUGAA==
X-ME-Sender: <xms:KRxNajbrZcdGckaOyZY1KX1fnGt4QxKo7QTYrKFihkq2j4NSu10aeg>
    <xme:KRxNapW-H8iMUISZJKF2E7QBwsoXgQNRk7ih4SrgLe_ArvgtpczHHvLLRv8kFBhkl
    fyKkqV95_KvWZ5YjpERbsfv4rLoQdEoBv17_D6v_nGkDMdMB-ehiA>
X-ME-Received: <xmr:KRxNarluPB6kqQf8oyNDCcm8I4l6HrfGNDPmKwyvFSNr8SOz51kPuuQeNcc1jDDPF8-MKSeMSi19FB1-OEZ1b-wRk74BzEcw3mFl-e13rg>
X-ME-Proxy-Cause: dmFkZTGv/+rafY/GYZCo9dvFUwJlDkiRNKnSDlKPF6yUb8FzhbbRYFgC49bx1yh8RCe2CG
    Mc2VwdeVsQ4dzsD9x+XtSj5bVeWoayaJfqjz58Kbsu2gYz+do4y6f8ZvODi3DPBdxXB7AQ
    +6yGbGVqGhfWXn5BX2a5kdOq4Q3SO8QQ8ezlWKGb3JUOJE7S0p1LHk8rBIfl04a0+ik8MH
    AWIl+ey9TFd4e7Jt53Yu3FTapVvZysY8VFz2XtUzzxXFcIb4YbBFMG2AdKix3G1CRWuuM+
    GWRiGgUhyx3RpiQkj6mapO5oDDhyYqFQo3wpQDurlN57cD1+DB6oc1IJtcL2XBhVcNKEUV
    Wko4YRZK31BRzxg8/EMG/YWOISliKMu4bVjUKF2v7obN0GIwHfDoc7MeVk6usXaiO+Eq4S
    t+L1sBl76GHkCOavuJziOytyhyFTLUTNLbJT2sIxx3YDrcMW2qkEvYZY38sLsQNdFdVukS
    i/VyVQXInxxps0O6/32JTFhnEoeebW1APut/xs+pFXrFRxGoX+NqkcPHXfgU79/RQhUIN7
    A1I2aosOlvCB0qqHdguLKV7cwXXlImYOSz2HDsT9NpcGM77roZVuptbTE+lbu5KxngUTnc
    7al4pbujJAbzfmIZpHaijPYffPsEoyXm3r/Aw0a9sxnATOXbKh6wrvJhgVrw
X-ME-Proxy: <xmx:KRxNauzbNhSP8Y9Zeu07mOikC4mu-Tl8rlH1gAHOizLtOU3oTbL3tw>
    <xmx:KRxNauigpus3y1LyUjxaEUDBJLoA-XoO8WUKPVbFmccIAGji7EaxGQ>
    <xmx:KRxNarXfDVLRH2x0YTottH7ae4vqB9EnfNyMqs972P8Wd4tucxkzcw>
    <xmx:KRxNao3nv6awgHEpbE1NQgDz7n0iCXJK-CqVQFqQ1IGwUqDaA5VNvw>
    <xmx:KRxNal7-iRjuYd11sovZhR-SD7HRhWbY7qldmGod5S-DOBbruu-m5pgs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:32:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 20dd0a3c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:32:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/11] odb: make optimizations pluggable
Date: Tue, 07 Jul 2026 17:32:32 +0200
Message-Id: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABAcTWoC/yXMQQqDMBBA0avIrDsQo6bQq5QuTBx1LDUhoyKKd
 zfV5Vv8v4NQZBJ4ZTtEWljYjwn5IwPX12NHyE0yaKWNMrlGW2L4CvrGog8T/3gjLEptXPWkyhU
 KUhkitbxe1/fntsx2IDf9V3AcJ6apxiN3AAAA
X-Change-ID: 20260612-b4-pks-odb-optimize-3426c57e5c30
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series converts object housekeeping to become pluggable.
There isn't really anything else to say about this.

The series is built on top of f85a7e6620 (Start Git 2.56 cycle,
2026-07-06).

Thanks!

Patrick

---
Patrick Steinhardt (11):
      odb: run "pre-auto-gc" hook for all maintenance tasks
      builtin/gc: move worktree and rerere tasks before object optimizations
      builtin/gc: extract object database optimizations into separate function
      builtin/gc: make repack arguments self-contained
      builtin/gc: inline config values specific to the "files" backend
      builtin/gc: introduce object database optimization options
      builtin/gc: move geometric repacking into `odb_optimize()`
      builtin/gc: introduce `odb_optimize_required()`
      builtin/gc: refactor ODB optimizations to operate on "files" source
      builtin/gc: fix signedness issues in ODB-related functionality
      odb: make optimizations pluggable

 builtin/gc.c           | 534 ++++++++-----------------------------------------
 odb.c                  |  12 ++
 odb.h                  |  45 +++++
 odb/source-files.c     | 470 +++++++++++++++++++++++++++++++++++++++++++
 odb/source-files.h     |  15 ++
 odb/source.h           |  36 ++++
 t/t7900-maintenance.sh | 143 ++++++++++++-
 7 files changed, 789 insertions(+), 466 deletions(-)


---
base-commit: f85a7e662054a7b0d9070e432508831afa214b47
change-id: 20260612-b4-pks-odb-optimize-3426c57e5c30

