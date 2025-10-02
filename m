Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0FD30B530
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759403090; cv=none; b=WiiYdHi1zs5LJUud2bzrCiAbpUKlfLc9sxDogi3Meq8pbDTq10vfQGPPZ1KGKcbVBhOFvPin7A9d/ex4yCemEKEGSa7QlTF/k06/wO98MQQqv/aCtB2rEugEShokx/dxqr0ARayW9Q8hzjwhhC8qb3DUVGVk+LlEWY6sxmUmH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759403090; c=relaxed/simple;
	bh=UbSogNnZ5LOaqUGzhxuST3FOy7ukb8POQyN5VUwH/3E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KyXkSyZO+96DpvPuJQnI6CMH8Yx1uQ260QNqu5prPnwLDnyG5c1HuXW1J6AWf+fG7YMqvBD/Ye7HB7NkivLYoyKmOytBfFW1TnBpCq5CwlcAl1+r2elWVd4Gn1aI0r9ZozgWfcSYpyb75tFu4mq53ZxDKoq6M80nAwRCmSlf4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CkPALn0Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QChNF2nG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CkPALn0Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QChNF2nG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92AD07A0152;
	Thu,  2 Oct 2025 07:04:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 02 Oct 2025 07:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1759403087; x=1759489487; bh=tO7DkU3+C5
	CwWTUA0rMyapFDWGSe0aEj7SLA+hXAKo8=; b=CkPALn0Ztf9olsfJkqi7rUCAq0
	8kWG/5zalN2ZJ5rl7DxiGs/4JNObwUlvsFOGunna6GlL8NOVOCKjBZJruP1PWMHj
	YZUCEWMuH0QbFfQEaxaZBr1xO+dxHI3gzeNYdiDNUjueb6RCQGTUQ351FoXPfgkp
	SOgYD/OvY7pJiGQJ2PInuIyKU8qBtZrUwK29o3ryaMVtitFasHbZlw3PUC6ojTaJ
	QSXnyNZWVzlCzYM4P3eZKIMq4PhkEgPWZM8UtcwPLoCDuQj+u/HVbF1QVx/lHRCY
	qokKLwKddSrVa+xJ569GB6KFA2z6n+9Gydp8t3Zja/3xkKJYlLvCoIkXf7zA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1759403087; x=1759489487; bh=tO7DkU3+C5CwWTUA0rMyapFDWGSe
	0aEj7SLA+hXAKo8=; b=QChNF2nGjTiBZarYHnQYRWjW1AAqukpMiSfyx0zTKe1p
	onReb7C/Hkq+1DoVg1DYwBX1+eXJa6ghYENoenwCSH3koOIoybSUbEVRyZtL8+E4
	PONnlVu67AgoYeL3ldXcOa7Dl4tb+uMgQlLBAfqsUXohmwcnNfhh3DRllteZSvZD
	VitKUdNYSlEec6b0aO9DLF71RfbMP4HB1V3nHhgNlgsxl37SCTNBIVJKXk/dbDwI
	pAym6LhhQkdYEdPySNLWSyywAK9mlyQ1Po+ZkCVWlLs2g+EimHrngnuvixjeVIo5
	pJnjK7K0XVQN2XcFF+goaWkPPR6hsd/qMbIqdQ+bug==
X-ME-Sender: <xms:TlzeaHTTgtz54oLVeiCXcUu2xx1FtkvWronGyLro3D2tbuWKppsWwA>
    <xme:TlzeaOzfMc0-5iGldQDERcfQlLIG7JsAPOZOdRX9gt8J6aD53XpjNThLbbUVxzDwo
    yEnjRodVDqYmrNW79Br0sWRvbBPY5hK8gP09kqRAMGyVyionQ_PYA>
X-ME-Received: <xmr:TlzeaKdVQ3c-2d4jD5yEskSQm5HjhFz3VwTagCuBtdnau9mNbz-VFpmqwOBZXPr678PczY8IEeBgo0p8zRXxj7KTFXRMRtDCSKsI8IpX8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfe
    ekledvgffgudefhffhudfglefhfeelheeufedtkefgffffvedtgeduveetheeinecuffho
    mhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TlzeaCLLbTbClJoaxwfsJxe_LY9-SudWb8DZnTTWaKd4765G6qXRzA>
    <xmx:TlzeaDGHXnpSoP1TG396qPodADCuPCJlNzmCtVya6vBLsCtt7vP-aQ>
    <xmx:TlzeaEqBecSf0LRe6GE1pu-CaBYo_F-f2obU18PrbGqUUiAAlyNvOA>
    <xmx:TlzeaEQ7sQm31FjFL9_qT4mY72ksoRh1c8oZdd4jJOWIboU7KAhhHg>
    <xmx:T1zeaKqrKkfZnOhior7ym1r8mQzu_7hWRbfzbZBkTv7iAq8WQAEI5SCx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 07:04:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f01419e7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 2 Oct 2025 11:04:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/5] gitlab-ci: some fixes for failures on Windows
Date: Thu, 02 Oct 2025 13:04:35 +0200
Message-Id: <20251002-pks-gitlab-ci-windows-improvements-v1-0-6a8b6b45d728@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAENc3mgC/x3NQQqDMBBG4avIrDuQsVRsr1K6sGa0P61JyIgK4
 t0NXX6b93YyzVCjR7VT1gWGGArkUlH/6cKoDF9Mtatv4pxw+hqPmH/dm3vwiuDjaowp5bjopGE
 2lsb763AXadqWSihlHbD9J8/XcZypCJ0adAAAAA==
X-Change-ID: 20251001-pks-gitlab-ci-windows-improvements-16dd3f911688
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series fixes some intermittent failures we have
observed with our Windows CI runners. Furthermore, it fixes one
persistent test failure in one of the Windows runners that was
introduced recently via tests for git-last-modified(1).

The pipeline at [1] shows that tests succeed now.

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/426

---
Patrick Steinhardt (5):
      gitlab-ci: dedup instructions to disable realtime monitoring
      gitlab-ci: ignore failures to disable realtime monitoring
      gitlab-ci: drop workaround for Python certificate store on Windows
      gitlab-ci: upload Meson test logs as JUnit reports
      t8020: fix test failure due to indeterministic tag sorting

 .gitlab-ci.yml           | 29 +++++++++++++++++------------
 t/t8020-last-modified.sh | 34 +++++++++++++++++++---------------
 2 files changed, 36 insertions(+), 27 deletions(-)


---
base-commit: 821f583da6d30a84249f75f33501504d597bc16b
change-id: 20251001-pks-gitlab-ci-windows-improvements-16dd3f911688

