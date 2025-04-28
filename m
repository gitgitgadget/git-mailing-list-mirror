Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459D28F51C
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745832743; cv=none; b=gsUwYxAf+Mojj752NTPZbNkoqKOFWVCOvfd6QTMaczvN6ZCIVewT9/lRYcQ7XPjcF/aUB2QWNMtuRxgu1ZgTGEwkRqDUntMPGUcU7JZKko18RPPdLFT2uwU3RXgTaDPkPbekBYHa1a2kO8kNXke0B0kcGDKFaArb4FpdSLvo4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745832743; c=relaxed/simple;
	bh=ppjN8j0xOF+6d3SSo/oHXYhaySZn1x8XtbrEBVlqXmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L/AcQ+Bvm2GOQCZ0dAK8i+aUfLZ9QjdUnw6zkmUZqo0WozgVN+66SO62vdcsZBr0h0SRhcIL1CpMQL+utAK53am8K2Phoe4P8cy0q9F6SV6Z0FVuUymtjgm65fyMvqf0hd2KTSB7KAhGGj+2E8lE+Infej6dGDeTWL/FNbl8NWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mJLctmD3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZOFZNOur; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mJLctmD3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZOFZNOur"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 81F831140101;
	Mon, 28 Apr 2025 05:32:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 28 Apr 2025 05:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1745832739; x=1745919139; bh=/YqhCeKuH6
	7g6YyX5ljGwOOb1xjSNy3bPgTHJPerBg4=; b=mJLctmD3LgXP2EHNqt5eZrWO5m
	UZanqFGdr4fvpBnO/K7cP3QmzYoS1R9VbKeLsxLPumQkZTGo51xgMJyFDmxUxaUd
	f8z8loVS9y013Hn7LE2XaeV6eVQAJ4tZWbXG+7gfQLkYO64mZWN6mHiKJBbdN4is
	a4Lw0K8h+a6FEdPzr0uXh+elpl+xmHD96eW2p8oTx8SjfC/TRSVrgOomMsYVjY7c
	j2PzeS+kPkp3o2Lni5vdMpxlw/aPJJa00e6symPIMMbhsBlQX0poMlRQ1n0gffED
	KFERWaUvXTWyg1U66rt893lwiuH2t9HIkkQYlCDK97LJQ4cQAVxtaTIc3HYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1745832739; x=1745919139; bh=/YqhCeKuH67g6YyX5ljGwOOb1xjS
	Ny3bPgTHJPerBg4=; b=ZOFZNOurC+2q8YmWGVMUMEeP9hXr5uc3j+oUGJeQeohw
	OMA0oyIMWAIwiahsApVBFd/cl0BpyCHZqDzCulChpDZixRx7VMp9VTMwpVatm2aP
	4MNVDA3OyahglXBRzwW7tAYSEkq0rQmqGUsVMZIVYWd6R5H9ZQK0OafWe2yZ60nn
	4No27oLpicJ7P1RwIdRsvt7YI6UrwciToco7wl+dnRkRjA2riPjW7zVsYWb0sNB0
	Qxj1GXPy5dnQcvM3Y99uathwuZnt7dHS8xcpQQI/vZZeFO6WovzR7/4InJbv9w5D
	1Ct6Azm8fWfas3PD6AIHdvD+9Sj/NVOj/4xv5581XA==
X-ME-Sender: <xms:I0sPaBmih_2fyp0Nt5vC_urENDA_yseT5re3MqT8m-BWOL7dg_dexw>
    <xme:I0sPaM2WZDNcaC0hS3rJDlYNeAmaV-dQy1UlcdhKtMpSKrdptBaEEftStjE0jwReF
    1tvdL3Seydsf_KO_w>
X-ME-Received: <xmr:I0sPaHq7rAMBI7uAnwfFghVfwzMSKVVK29qQaP79e-AzoQUhGCSTs4SKqA4fi-hf-SFNE-hNVl65pCAhV__sapKEM3a0T7R_inMPNAZW2SiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvgedvleejvdefkeetieejheelledtvefgteffffeu
    vddtvddtffeikefhvedvgfenucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggv
X-ME-Proxy: <xmx:I0sPaBnbVqZ-1kdnV8NgZhzms6Mj8N3CvEQsS7Udltk3FRYsJBS8CQ>
    <xmx:I0sPaP2DI8EDdeb4toUnkeCCstGDeAX4xN0Gl6jMrKoLjwiIEJ7R7g>
    <xmx:I0sPaAsd17gs39CzkweVD19BJ9hFEiEiWOrXAxFQnltXcC6I5hTfJg>
    <xmx:I0sPaDXRcLowzVC1JBXjhbB2qWL3Ileyj1DZIiKmo5fZfpV3vr1fNg>
    <xmx:I0sPaBWPBcGjkdFQngu0mnQWYMwr8fLlTHo2ivK0_MStZDQbwPi-RQXh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 05:32:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 29f2b862 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 28 Apr 2025 09:32:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 28 Apr 2025 11:32:12 +0200
Subject: [PATCH] gitlab-ci: always run MSVC-based Meson job
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-pks-gitlab-ci-execute-win-meson-v1-1-f68683552b9e@pks.im>
X-B4-Tracking: v=1; b=H4sIABtLD2gC/x3NQQqDMBBG4avIrDsQg9LoVaSLNP7qYBslY1tBv
 Luhy2/z3kGKJFBqi4MSvqKyxIzyVlCYfBzB0meTNbY2lXW8zsqjbC//5CCMHeGzgX8S+Q1dIqO
 umsYN/m5cSbmyJgyy/w/d4zwvRRcr7XEAAAA=
X-Change-ID: 20250428-pks-gitlab-ci-execute-win-meson-e54998fa7081
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

With 7304bd2bc39 (ci: wire up Visual Studio build with Meson,
2025-01-22) we have introduced a CI job that builds and tests Git with
Microsoft Visual Studio via Meson. This job is only being executed by
default on GitHub Workflows though -- on GitLab CI it is marked as a
"manual" job, so the developer has to actively trigger these jobs.

The consequence of this split is that any breakage specific to this job
is only noticed by developers who mainly work with GitHub. Let's improve
this situation by also running the job by default on GitLab CI.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
As proposed in [1]. A test run of this pipeline can be found at [2].
Thanks!

Patrick

[1]: <aA8ymUzWM2t0QkFP@pks.im>
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/349
---
 .gitlab-ci.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4798b283745..bb6d5b976cd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -173,7 +173,6 @@ build:msvc-meson:
 test:msvc-meson:
   extends: .msvc-meson
   stage: test
-  when: manual
   timeout: 6h
   needs:
     - job: "build:msvc-meson"

---
base-commit: f65182a99e545d2f2bc22e6c1c2da192133b16a3
change-id: 20250428-pks-gitlab-ci-execute-win-meson-e54998fa7081

