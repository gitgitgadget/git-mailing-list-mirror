Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C237B03A
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655696; cv=none; b=J8+VivUaolTu2XmkXETlcbZ/QvWS4mSeLhhCdiarJBVIt/OyJ+8psdgya0rAsqJdjE7Wz9uyQgNPX/gg/Im42apyYaBvc+mXA88bJjHMJan59zZpYUwOk+HnDSo2Dr7uAmEx5wI8RGZA+5vYf9r4SGa6JIAGh/ly5jfmKEUTioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655696; c=relaxed/simple;
	bh=8WCwuAkPVP93QN118w/8trJDDjTKnN3AF8bplL20r/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qu3lYScbGMincJxpgr70Hq0Ot/3G7zpcLnVAOhn0FZLjH+r3VSh4T8xePUPM3o0e69Tf3usOCfStBVYfR+Y2xNZkj2z2XXzhwK6HtHeJpmJOtsiPW0tjgdwEJLGF32mR9PaFtjNXJ8+ViWibmzW3Ttl/NNRKLhgoxcQ5XqVvU5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lLkwtSct; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gm4NihqP; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lLkwtSct";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gm4NihqP"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 249B014001D5;
	Mon, 16 Mar 2026 06:08:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 16 Mar 2026 06:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773655694;
	 x=1773742094; bh=bI/ubNU8GighF2ALZ+Xij2wBywzz5SdN8vzErp2yx1E=; b=
	lLkwtSct1QnKZLDQA0la2B8n9TkHSNQN+PXDa3Od77f6b5TlHILXuI3VMaQuLR7t
	uJKGv8KOUl1MVT/OtKK0JRfqnESaREri5k9suuC+XvnJBOx+aehquzlAfnmDGqi5
	fsouXaAylU/WvoN7wnzwMqOu3ohFKqGY6EnWdNPTCGUDboytZY+v+LMPCTfHYr1c
	nZuLeRJxYT988zwp5RGnTr1RRsH58oCqv+zMo9coC7hrtG3bA5dR/q5hUb+0Su/Q
	FrRF4yZal/23CoeVa6RXvcGxzE2mvFnhyRLSV3P8Ss1aDPWQftuYP6i0r0vmvxeL
	93Ac7XRsgF0PjJwCIpaV2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773655694; x=
	1773742094; bh=bI/ubNU8GighF2ALZ+Xij2wBywzz5SdN8vzErp2yx1E=; b=G
	m4NihqPhnuzWCCuzT9ZOWRVacbqmYDoOs7Dg4Hrw4O0BuXPhVqkfH4CJfG2goTfh
	OQPEmttuKAMdLRFfwhnhh0aQLD5XZ/rPrqFsc4ELZERPOh5ZhEpZKLxZ4ii9e7yv
	XRw9/uyOFz2wR9WkI8ttaK0IzCClMaWyW0/ORMpLVtttrS+l3MPfMvxOVL5JNsD0
	bk2ajVc++QoQ6upHRuK8LvHXaixd1GbUflZ4bivFntqGrPguauUvOBrYqcQeYYHy
	uvgqn1VeL681NM0v8I6GqKOaKW+j47d4l4usRsYcAZI3EPJzHQ7ELe/AW9WfERlt
	+Il0IOYWdTBw2y8+Ob7tA==
X-ME-Sender: <xms:jta3aWW9oALco55LUzncfS2-U8tiLHZJnFLDlPDrCQhhQZ1pi-mfBQ>
    <xme:jta3aQZw1ZAWTPrhtHFnLeGKIpZnVErl85xDl-kQfGKRqhp_W6uL8TSQ3lwzRal1x
    fzX-LRKH1QWLq_V9Y_47IwPvteR5Y-WWLOthl1RKzjz9MrSZ5TZkBo>
X-ME-Received: <xmr:jta3aU1MT5Q82-VPmqFh1n-AqebMAoLqxp3XuVkwWau8ASBhQpDaB-N4LOev8erF-SNFQConUPXEbygk3aVppbHLn5VO9WLC87yTrCBgdBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtth
    hopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:jta3aaj44s_f6VYKTTVugE8-Cb9xhJKy2ndnKtEAcgSx-DBuYXa85A>
    <xmx:jta3aQbj1eGU4SwZW659YxNcaBr906SSy2f9AML4_l3oFqW2lWGMsA>
    <xmx:jta3aST0veqvO60IFlC-l-iNtu4vGVeTD7u_E0k5Pq749_OHIZu-CQ>
    <xmx:jta3aTTee4ivojvaJHoQCJK8rQYJmuQGyDzHEYf_NidJOJDi1EHjfw>
    <xmx:jta3aSxSvHGyqPvDrmxesU2BtghpWDrIn9NfxCg_m6DA9yLd7uTY92kq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 06:08:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 81fabd75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 10:08:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Mar 2026 11:07:56 +0100
Subject: [PATCH v2 1/8] Introduce new "tools/" directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-b4-pks-build-infra-improvements-v2-1-4b2c2c0c0425@pks.im>
References: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
In-Reply-To: <20260316-b4-pks-build-infra-improvements-v2-0-4b2c2c0c0425@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>
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
2.53.0.959.g497ff81fa9.dirty

