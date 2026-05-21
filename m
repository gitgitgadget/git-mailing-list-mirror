Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429B232E134
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353973; cv=none; b=CPSP6DQzxCmRh6P+W3GgpIyfCSz69fGtStHrkAteqT0LJmxi0Cbi870XvA9iq44k8UGzHSTQZk/oy+TfAFXo5vC2BCc22JgG14WrKbJCnuuiFeqFUBnsHm9UYCavgfH1K8yHsFiFVKAI2iuBzc6Q9vIm3CzHyrIuvTrnb8mcFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353973; c=relaxed/simple;
	bh=8Ij3D9sEbNjPWY3/q7JsUk1uhUfAK/7mzD3FUUkV7+o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R/X0xfuC7lN/+7Xr9bbsp9xOG5g4h/XPa840jr87uBHtZSpi/efcX03K3eJf3Nzgx6vzc+TF35gM+9ZbMj4OKlC5rs1FOl9n8AwCj1Rwr0p+ohOmW1sN3dMm5jYsr+VuzZGGSv/ltflX9Wds3bB2mvaY0DgqAtblZY9z4n960eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oaAP+BeY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUF328hG; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oaAP+BeY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUF328hG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8B8A8EC00A4
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:59:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 May 2026 04:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1779353971; x=1779440371; bh=lXY1kqSxgG
	1VzcQV+Wg3/WY9AHnEh0Oftj3rDoBJmS0=; b=oaAP+BeYqTQrjHFtRn1fBQVf5K
	tTOqPWrj/nVagKaBHgvM8ULa9hxArGJOYROhQP50agsRXgD7uokudUJ7eivBExAu
	YmFStL537HIbr96ko3e/lfP0WKlGlyLKJH195HVqTfbxYWKC8EePCan8IxatObc1
	iN/hoaD6S1t9+tPz9fVcKzzZukbJlfQg80H23EdhzwFf2pl1YOSxYPKZW3ql+Sal
	Bx7yhRTtKI9eNeYqPVssOSJVPJ5n7sCWyKgTxXU2yBVSjv2parR1IWo/LaVVP7k8
	L1iz8x6gBFAXdBgKAGS5KkEHPxG4EkK9t/CCL/7CjuI5VgXORyGDhNim6qog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1779353971; x=1779440371; bh=lXY1kqSxgG1VzcQV+Wg3/WY9AHnE
	h0Oftj3rDoBJmS0=; b=WUF328hG0C7uLUu+GmoLdjqLCfahDbIU+MRopfyRPVfP
	VgqKWtTtxlvWZwgMgqe4vFIgCDMrNztYck3hRJk4HXwwGvqSmeyF7998QSfME+a4
	4TdLW7U9cIIcqTSWnM38/zscfl/vOZEFsr1KbIeMhQTxZIW/RUBxWIEz4FOL+ANg
	UY2Hiwig29vemgTO8H8kh5X+Phi5R0H3ZixEu8x+7wnXrP/nY3vjpFMGkHuLrrnO
	fPiiat9xTT3tYMOoPE1ywr+kQ7uEsR2Z9PMuLUlDdPF2hnPqfU5/Y2a6fU1Xl4Cv
	6xf4lZ7QWCJPfNCtMv/SjBc201007bpDWjADJqWFzg==
X-ME-Sender: <xms:c8kOarzhlZE7QTpaGDJr85K7XN2mEHfAPIAOxBASH9D1YI94gM1Bag>
    <xme:c8kOaqMZkG1Rqyw6O2Y9QT3bbVLHV-HBGWMLvh-CZjpU4pFtK2aIUmgGSpsMFTfSC
    sCFgHYEaIvE6bs0XMh2KnDxbXWBzcKO7R5B_ce0d5jrOqLS-gGJEA>
X-ME-Received: <xmr:c8kOaq_HyZUm0kfKEgDWytCNEjSbkAo-AV_Xl7vlwKQPqUXW9GOEyfwHEtItNd7F6GAa0UemudlZ0DCAUs4uHjcmzVgUjxlsGxDiHAK2pMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeefkeelvdfggfdufefhhfdugfelhfefleehueeftdekgfffffevtdegudevteeh
    ieenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:c8kOaqrAGlDRZv7qDle_PlppUIIWD6643Uvz78nbE1Lkjs8ZHGIKHg>
    <xmx:c8kOas65Wc4u-J7bruc61jvgmCIU8GCv3W7-ernPs1ptJFkUBuYaxQ>
    <xmx:c8kOaqMdtigkqa_W9v5NU9RPXakl2riheYKv3ZjHEeOLbNkxp2qxJQ>
    <xmx:c8kOauMZbq8kEqdhiT3BdtkBuiCKTyce9pc9F9yxeub1tZTxWBj4qQ>
    <xmx:c8kOapyOSPvH7n6oVL4k8Im8zuirz5IwNOgBvnSIwzgWlpwA0LisB4Z2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:59:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 504fc70d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:59:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] gitlab-ci: some smallish updates for macOS jobs
Date: Thu, 21 May 2026 10:59:23 +0200
Message-Id: <20260521-b4-pks-gitlab-ci-updates-v1-0-53bb46ed33e0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGvJDmoC/yXMQQqDMBBA0avIrDsQU5Xaq5QukjjqVLEhE0UQ7
 27U5Vv8v4FQYBJ4ZxsEWlj4PyXkjwxcb6aOkJtk0EpXqtQ52gL9INhxHI1Fxzj7xkQSfNrC1GX
 dvkg5SLkP1PJ6rT/f2zLbH7l4/mDfD12LefV8AAAA
X-Change-ID: 20260521-b4-pks-gitlab-ci-updates-3b4a959f8e0c
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series does some smallish updates for GitLab's CI jobs that
exercise macOS. A test run of this can be found at [1].

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/576

---
Patrick Steinhardt (2):
      gitlab-ci: upgrade macOS runners
      gitlab-ci: update macOS image

 .gitlab-ci.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


---
base-commit: aec3f587505a472db67e9462d0702e7d463a449d
change-id: 20260521-b4-pks-gitlab-ci-updates-3b4a959f8e0c

