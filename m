Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D6A2C21FA
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089305; cv=none; b=i7LcFv+ihr/yctyHCt36bSXwS0THSezfsosB8CJisnfGG0zn8yL5QagpeKTc4C19hkXi4+pmsLF4HCyaAX9jYIUKDi+t/pkMxXO/ToTpu2LvlOgSLMYAWJJelh/HYmXf4fIgetn8mnEbir8fpxD/QDFPWr0tS5ZK6YsCabzb5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089305; c=relaxed/simple;
	bh=1BD+O4jb6rpl27NSClSpv0TL4kAQPahHzBUdN8Vk1/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tZaGVVheEThBVwgSMicguDSCq2E1Vfrdi9SifSJwDzVDfbAogoXSuRjXB9CVM0Fpuyx+7ZZf8sOiSaZD/gNg9gvyyJNqs174eHvZgqhxxQf+l0CPqg7/6vwWjwZF9SWOLSit7RZiffBfvD5PoTbaG+3t0YBPNZHCfT0Aa3nbNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T/a8yVIq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DAAqftET; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T/a8yVIq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DAAqftET"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 77B3CEC0085;
	Fri, 10 Oct 2025 05:41:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 10 Oct 2025 05:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1760089297; x=1760175697; bh=H2o+ZxUN9H
	/QM8xnuLvPxWWuWSMndsWbrZI17wDgXl0=; b=T/a8yVIqOVnutbpnX0H9bFYA+b
	6qhMJufsjRF0AcwelhJAUSVwoboOCsH+nhpBRO2Y2/brq/SeYs1u/SmU7JYviT6i
	6JpOCTbyuyEcrmUWThVE+IDNcCzLXgi3nr+m/tsqDmweecc7t4WMaaog+oGRT2RC
	CsLCG76U3ID2WsgPb5TKDbuTo2vgVEFDR5GbLAfrU2Mw44x9VMye0KK/dxcgvriE
	2U/WhUNz4vhBJ9eWftUWNjXX6Gv9aWyBLBr9olry3zEJdrjkfFEeyTZADIWgBMVq
	NTjViXpWuAcT6oV+uZjM5IfEz20S683lDzXidfmX4Pj/j/YQ1nefhxggzMOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1760089297; x=1760175697; bh=H2o+ZxUN9H/QM8xnuLvPxWWuWSMn
	dsWbrZI17wDgXl0=; b=DAAqftET34mMdZJxYiXqLla8Iwwd8ihQzDUHeFMsSxSb
	IJgr2BXFra1gmmFiMJX6vMGwtm5FHXmvU/2vhQ0BV9edCYkSCvK72n7RIUGkxC2Y
	u32uV/3YdsyYGGTxSQotzzbbFjmwd46BGk2a+Vz1/P9OFwkpejNcAIjKv2ps4zKG
	KBZJmilWYe+piv3GlRF9lIR4ijP2FhI0NA2oYNAFMu80OdsoYaBismlzypEv3N+f
	58kaw9jppz9CFVI42LiRLVO63gHor35fF28b9c5mDfCPZEXSdfDKdOhU73qHwUO2
	85YIeAgw7R6/5DaPF1931JsClf7jbk5uC0JJ+enjWw==
X-ME-Sender: <xms:0dToaOwbjBfLtAxyIIT47VbiWLETjdfBpdo1uN40Wu9fl3VzXozESQ>
    <xme:0dToaASL4SWCcrMnFrOW-dw_JSmeogd8w5OSOStXFSWZHzJyhVwnvuQlnLE6G5vq8
    YyM_jjIeCpw2kdgUQ0xzot3x14OM7k6Heba6Kq7GGby1o1NOXPDbzY>
X-ME-Received: <xmr:0dToaN--5pfs4Us5QE0x7nJoab05RZkpf0qBIPj7ZtsbnoHg0iqrEMQnug-dS7BaN9Rx1nqU4TCg2690tJ3BczLs89I635q4lH6P_GhZaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdekjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepiefgiedtffffvddvueehheejheehleduudfhhe
    ekkeeggefgueffheevgeetjeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:0dToaPrnKXwyuJPo9fzuoVlt1BdhAsLYEDgLhgCaSZHGhnUduxttGA>
    <xmx:0dToaCnfgBQDqXdvlMNFcIXBjTdi5ugI5WXvQGM_IV65jhC3I930ig>
    <xmx:0dToaOLFwWg5u80gTm54jyLZowBZISOQ_atHd-SPe1J5NWbzz84rXw>
    <xmx:0dToaPz_NvaBoX405VcNtaCM-IRwM62g34xT1iMeqnxHunz_A-LHDw>
    <xmx:0dToaCKQmYcrCwyJIR3QK0j9YRxN7BuN1wex2UktBXwiPt5CxH_HLuKW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 05:41:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6267821f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 10 Oct 2025 09:41:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Oct 2025 11:41:14 +0200
Subject: [PATCH] ci: fix broken jobs on Ubuntu 25.10 caused by switch to
 sudo-rs(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-b4-pks-ci-ubuntu-sudo-rs-v1-1-88cc846d251c@pks.im>
X-B4-Tracking: v=1; b=H4sIALnU6GgC/x3MTQqAIBBA4avErBtQKfq5SrTInGoILJyMQLp70
 vJbvJdAKDAJ9EWCQDcLHz5DlwXM2+RXQnbZYJSptdIKbYXnLjgzRhv9FVGiOzAIttR1xraNc4u
 CnJ+BFn7+9TC+7wcoinbzagAAAA==
X-Change-ID: 20251010-b4-pks-ci-ubuntu-sudo-rs-8e992b87ddf0
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Ubuntu 25.10 has been released. One prominent change in this version of
Ubuntu is the switch to some Rust-based utilities. Part of this switch
is also that Ubuntu now defaults to sudo-rs(1).

Unfortunately, this breaks our CI because sudo-rs(1) does not support
the `--preserve-env` flag. Let's revert back to the C-based sudo(1)
implementation to fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this breaks a bunch of our CI jobs, both for GitHub and GitLab. It would
probably make sense to fast-track the fix.

Thanks!

Patrick
---
 ci/install-dependencies.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 0d3aa496fc..a8dcd9b9bc 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -65,6 +65,15 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 		libsecret-1-dev libpcre2-dev meson ninja-build pkg-config cargo \
 		${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE
 
+	# Starting with Ubuntu 25.10, sudo can now be provided via either
+	# sudo(1) or sudo-rs(1), with the latter being the default. The problem
+	# is that it does not support `--preserve-env` though, which we rely on
+	# in our CI. We thus revert back to the C implementation.
+	if test -f /etc/alternatives/sudo
+	then
+		sudo update-alternatives --set sudo /usr/bin/sudo.ws
+	fi
+
 	case "$distro" in
 	ubuntu-*)
 		mkdir --parents "$CUSTOM_PATH"

---
base-commit: 60f3f52f17cceefa5299709b189ce6fe2d181e7b
change-id: 20251010-b4-pks-ci-ubuntu-sudo-rs-8e992b87ddf0

