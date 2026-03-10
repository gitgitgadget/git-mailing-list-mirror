Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8E13CFF7E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165178; cv=none; b=TQiyaJXIV3WQOoZyWfp0rwgH869nmlt4OgX3hGzO3Q/Qu9IunYhX0AmUAcnO+BLQDv/gOmiowA+6scNg2LNYcIbDgPnzTThnvb9k9snuKJVeaqcF2ttNJMyVmvqzu2NrCp5ishNIISKCl2ke2ndl4RneK0tBJomAGZnRrMHmjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165178; c=relaxed/simple;
	bh=a23ctZBt6mNmF1P4u+Xx6UXxArdsouxg9g8EGGTRBTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VRUH0bFARCsVS9zWQiDxFnrOhFcHSKn3HdNZsUmwHgDT9Qh81pENvlqBAzCp+rEjDFWG2Y31Z8mUMEUQFD4iXF/27yEGMSHZrzQoIi0kaI/TMUXC+t3lDh8qDeeQBVagJA14rOryNAFAQEQ4fVt7sS+zFpVFEKFZIM+m8UH1OrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NfCo0umn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZeWfxA7C; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NfCo0umn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeWfxA7C"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id DE682EC0FC6
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:52:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 10 Mar 2026 13:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773165176;
	 x=1773251576; bh=u7SAVPN32r3KLQAo7dXHYHMnHaDE5AbTqFP6diGU9hs=; b=
	NfCo0umn3Wy26PQrX/zQgs6XtM6N9W3vNpPyE7fV77ylNUV/wz4KirzcQslLAfHf
	oRNvOBteafymMA4fDJ2FslTv9gVPgEnX4+2TVtDeRJ6tokUNz76/nqDLSZvZZRsT
	bKDdgA3/qtC9feRY6SNec5nEIvR6pISXbReQct9yH6SLUAd0kUdCEKxnYyg33MrO
	78bmngyat1cddjlj0lW50/ZcXliQVaHaT6HxzCT3kLFIgc0weRclli0F4nWzep4D
	UvOZ7Sz6aL8jrbzE6cIheUl5QNXbBXSRqLH0cSMmXioe30z4s2G/aYnPc56/998s
	kUU/UiMZi4P5Ps0bPQXeVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773165176; x=
	1773251576; bh=u7SAVPN32r3KLQAo7dXHYHMnHaDE5AbTqFP6diGU9hs=; b=Z
	eWfxA7CSHYZpmB9xEkDaHGGcQgCpy56L1EsKKiuDU/bgg/0FHwyX5oM66yX5ACbL
	sla5fP8VMs+G7tESi/0yg8dQ8FvlbBsVoN/o0nA0qLi7ebYT6XXsXV3IL6YPdfnt
	CimMPUQAxYWGxFJCR6WU4pCDH1EdtMgvN2RCVHR0LPi1V7f/5Q/bdCiw1pj3+TOU
	5uvaG5uYufMw4NbybnjnZ/eCpNqMjLSvsaqBpdpTbf0jCGTWuGD62iv8WyGFyvFj
	yVKgl17vyrp3xNSDEEWfWZWbSpcMUYUvt2kZiHxbwZ2luuSqVSXXkXLE1JUoPSPb
	X8AHA8eIP3WH9nOa433DQ==
X-ME-Sender: <xms:eFqwaboC80eV1pm2yg9KG0ihwSHGXpR2oBUMVbSgoZIr5wD5wmfk6g>
    <xme:eFqwaclZA21zHXnqdwTuaVVpJBNMZYsL-c2te5M9XaUXic4ieIxdi_Vb7IC4zgASD
    6j3DoHrFxx24SQDI2WBBQplByG8bwNcE2mTUAZEUubgKmJDKzr1cA>
X-ME-Received: <xmr:eFqwad07hvxIcgHvnfUT314ju1XJjjyE-ccWCuzxeN9IGx0ZeJT3NkQBplsOL6jjf5UGcjumxZ4t7y9QtNUyX4h1b6xwmxtORwC0bFha>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:eFqwaUCMIV2c2xIEiS5NIKrmWY_E-JIn0vWh1yt-lYvl89OF6xlyBA>
    <xmx:eFqwaawsbzeBM1UqFgT9r_VLP4V64O1cyMVwUx8-0YIkFYvsdHEP8A>
    <xmx:eFqwaSl6s5Rg0zRUjbKdb2tWOPXHkMIJ4I1CpzBjTfJHLbKvPYQXKw>
    <xmx:eFqwafHi9srPXE8kHuIkp70eOiavSVtydzr1N75PlkegAyve0s3GQQ>
    <xmx:eFqwabJrkdc_Cnqr5Nd5Ka-p1g-jftnn0OQAB4YVjwmeRbAT7NXxqtmm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 10 Mar 2026 13:52:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7f03d7c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 10 Mar 2026 17:52:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 18:52:34 +0100
Subject: [PATCH 1/8] Introduce new "tools/" directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-pks-build-infra-improvements-v1-1-ec75d0710d6a@pks.im>
References: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
In-Reply-To: <20260310-b4-pks-build-infra-improvements-v1-0-ec75d0710d6a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

According to its readme, the "contrib/" directory's main intent is to
collect stuff that is not an official part of Git, either because it is
too specialized or because it is still considered experimental. The
reality tells a bit of a different story though: while it _does_ contain
such things, it also contains other things:

  - Our credential helpers, which are being distributed by many
    packagers nowadays and which can be considered "stable".

  - A bunch of tooling that relates to our build and test
    infrastructure.

Especially the second category is somewhat of a sore spot. You really
wouldn't expect build-related tooling to be considered an optional part
of Git. Quite the opposite.

Create a new top-level "tools/" directory to fix this discrepancy. This
directory will contain all kind of tools that are related to our build
infrastructure and that Git developers are likely to use day to day.

For now, this directory doesn't contain anything yet except for a
readme and a Meson skeleton. This will change in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile          | 2 ++
 meson.build       | 1 +
 tools/README.md   | 7 +++++++
 tools/meson.build | 0
 4 files changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index f3264d0a37..c7cedbcd7c 100644
--- a/Makefile
+++ b/Makefile
@@ -1066,11 +1066,13 @@ SOURCES_CMD = ( \
 		'*.sh' \
 		':!*[tp][0-9][0-9][0-9][0-9]*' \
 		':!contrib' \
+		':!tools' \
 		2>/dev/null || \
 	$(FIND) . \
 		\( -name .git -type d -prune \) \
 		-o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
 		-o \( -name contrib -type d -prune \) \
+		-o \( -name tools -type d -prune \) \
 		-o \( -name build -type d -prune \) \
 		-o \( -name .build -type d -prune \) \
 		-o \( -name 'trash*' -type d -prune \) \
diff --git a/meson.build b/meson.build
index 4b536e0124..1d66b5181e 100644
--- a/meson.build
+++ b/meson.build
@@ -2149,6 +2149,7 @@ else
 endif
 
 subdir('contrib')
+subdir('tools')
 
 # Note that the target is intentionally configured after including the
 # 'contrib' directory, as some tool there also have their own manpages.
diff --git a/tools/README.md b/tools/README.md
new file mode 100644
index 0000000000..d732997136
--- /dev/null
+++ b/tools/README.md
@@ -0,0 +1,7 @@
+Developer Tooling
+-----------------
+
+This directory is expected to contain all sorts of tooling that
+relates to our build infrastructure. This includes scripts and
+inputs required by our build systems, but also scripts that
+developers are expected to run manually.
diff --git a/tools/meson.build b/tools/meson.build
new file mode 100644
index 0000000000..e69de29bb2

-- 
2.53.0.880.g73c4285caa.dirty

