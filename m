Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C59B155C94
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733483434; cv=none; b=QPsi/CMzxOjJjFEvteUsbEwyMOR/aOLyqFkLMeLjUlZ0aTG4eEMfL5gEsP7jKggar0Uz+d70fNGt9ZhnZOBNLmoxwSvMfmVBfiD6RcJc0G5YQh9jMQ3mDyAIOW63Z7JCzW34EXSLcaiqG3QIpfsL6uffLp05emxkaXCblR7BII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733483434; c=relaxed/simple;
	bh=oaYKOACkSP40yahSdlcMLm8OuSI6HLUau6Hr9SYBSoI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TDq9gY99ugFSRfBBgSNXQEan5Hv4peIptMBB+SI5PkGtRsmyfIaule/q2fNSSjIGaQ/z6D9/lSyWU3ktDfeU+uxqpeXO8UcqcJ5S78tcWmusf+/B01/MHU2qmeaYt6+mIw0+aXE2HbFKjLjtgnwVEj+6pJ0ede4JDG3xNcKnXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uZgSSeMF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wTRs43Wg; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uZgSSeMF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wTRs43Wg"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B4EB1140185
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 06:10:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 06 Dec 2024 06:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1733483432; x=1733569832; bh=/PnY0fWwKm
	ySlprcXxu+IBC910qLitujqUgl+weHUD4=; b=uZgSSeMF4euZZ9NuJlUHG6V9jq
	r6QbbD4yozXPwKAWNbXRHpkZYqrXLTBzAdK//KYIIUDAllgWbxXq4gsh8CbjuQ1A
	yB3VYKPyZigxTlMGfnwW5YHKZPcEOYZ1GKHIJQdhtcNlOplQIq+Gov8UQL5zNN6Q
	RCtIe5CFoAdwOwZrToRfjCk1FFq5ezFX9uIS4qe6P6VRDaFGAEiXsi/WEjlvZQsc
	aP22meYXiCdncf9El5AG6mP73zxzxBO8+wE1+n4KT2v8D0g9luBR/k6RLkP7WJ/6
	TmwmwsHAWzrS9PqYZjDFxvpAkjWTiaYXHAF2hxDqkU1+eJp0O5Zaq1C0UKlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1733483432; x=1733569832; bh=/PnY0fWwKmySlprcXxu+IBC910qL
	itujqUgl+weHUD4=; b=wTRs43WgItx88rsz+Ng1XZbziDmEGJX7XUYYQVD0Zywb
	Dpoc7cPvZfRHupFun2D0n0MKHyZ6OOxJZwKYteOWCUKkRD7juQ0iWLuzSmhM1Zsa
	qzx4sGxA1i528bHsSAXgPa+ilhHjkPBWoMsxIPNd5kBfdz9zY6Q1M+TDbY+x67pp
	RlHwnpOdjqV8ieJhWUtsGHdVAFpGtr4n1QQKF/8w5wHLoEjHL5idPEyvumHNl50C
	gEJ0srYTZPdxjfxyWKfS1PTrsUbasJp8NXptriqm6H2NHogdPDXdVaRHnpu//B79
	g0/YfJUUQm6XjAUVt2yNUO9m4OGNkpSuzX9qoHbkPA==
X-ME-Sender: <xms:p9tSZw8ck4fH8RL85qOsg_vxDXoXbQdyT0eaZeTnZTRa4xnkyENLdw>
    <xme:p9tSZ4uIogw0_AwBk54hDLGnwcMaTPAQtj2ZdR7s_06vT91B1VXLkWb9JFaA5CiIl
    0LYfhCPSxtAIl0FKg>
X-ME-Received: <xmr:p9tSZ2BdZcm46tIhSoQItMBZShjlZX81jDDixxnGTTnjmT69Od0yOpotZglId9M_cYM34tF3XFVhuoaNlTBZHK4NqHJVb4G-bNFOJRWC5Bv_VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffufffkgg
    gtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevueegkedtteeige
    ejueehuedugfevleefveehueehgfetffffvefhuefhueekveenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:p9tSZwducGvtSewHtKZ49CwpBo82SW2wIRHeIp3neTEyaQIR0OHocg>
    <xmx:p9tSZ1PncH6WjG-yoUnytpQ4oYQQW6Ujd0frNr4wSn-rcJa3_C5oZA>
    <xmx:p9tSZ6msUQEYDZw7mkIZy-U3ac8pIaYE8yOpyI84M0QPofDSIeMjeA>
    <xmx:p9tSZ3vrTx3kPE6t3xuDX3qnpjZniu-u5qmVpZqKSvhmdL36u8BBRQ>
    <xmx:qNtSZz2TLgnCg6pK6PNhoHYZrQWqXcMs-y1cTGJxPOjUYbqyARnSIKDf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 6 Dec 2024 06:10:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e8db636 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 6 Dec 2024 11:09:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] Random improvements to GitLab CI
Date: Fri, 06 Dec 2024 12:10:12 +0100
Message-Id: <20241206-pks-ci-section-fixes-v1-0-7ab1b69e3648@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJTbUmcC/x2LQQqAMAzAviI9W9iGivoV8eBm1SLMsYoI4t8tH
 kOSB4Qyk0BfPJDpYuEjKtiygLBNcSXkWRmccZV1psG0CwZGoXBqigvfJGi972wgXxvfgq4p0y/
 0HMb3/QAZtYHMZgAAAA==
X-Change-ID: 20241206-pks-ci-section-fixes-1bb91ceb50b8
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this small patch series includes a couple of more-or-less random
improvements to GitLab CI.

Thanks!

Patrick

---
Patrick Steinhardt (4):
      gitlab-ci: update macOS images to Sonoma
      ci/lib: remove duplicate trap to end "CI setup" group
      ci/lib: use echo instead of printf to set up sections
      ci/lib: fix "CI setup" sections with GitLab CI

 .gitlab-ci.yml | 4 ++--
 ci/lib.sh      | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)


---
base-commit: e66fd72e972df760a53c3d6da023c17adfc426d6
change-id: 20241206-pks-ci-section-fixes-1bb91ceb50b8

