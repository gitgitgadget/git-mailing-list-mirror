Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099BD1E98F3
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738248256; cv=none; b=WzVJFxEpj2Kp1aVKM8Z3fnPDEyrTLSL3KNFA27lstvH/Z79YWwshvG/2pzMe4pm4rHAWc/55ManGTunHuTl3Jrb9/4uHmNDzSMUIJN3B+MPrU047Vr2ntE2bLCqpRp7EsF7AYFVQ7DBUoHwKL/W5qjotd6McG0riPLXOg1rqzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738248256; c=relaxed/simple;
	bh=twG0zOUyOkp5wPsp8MJHpzVn2jkaa9lIzauw0i75rYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9qK3UuOTwIoj/2XV3fWNPHi0Cnbl4BRqA5/EOjopJE3WEHRAwHCkg9hTRzEi6PKUlyZaFP3tih8iyYbiG4FKu/U4lP+5JtgHs6PdyaOtWfHLwthg36/y//ND5X6XAcsGU35geI0pOqH/6AqxMQPQ1N1UGoDW17mUEiIA3+g/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QaWdUpg/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hh9fIbei; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QaWdUpg/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hh9fIbei"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EF341140106;
	Thu, 30 Jan 2025 09:44:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 30 Jan 2025 09:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738248254;
	 x=1738334654; bh=sSBDy2jsuUZ0ak/XFY8RFIKQmDYSF1uPQENNrSCho40=; b=
	QaWdUpg/VYLQ2hCm/80cLOJtceSX5f0mUakGQzFQS59WCBp0Vf5H+SdMpFDh2lcy
	Yb8hqL6lIUplvg/QtPlFtn5jdHbla7HYfwrEnchrPN6a4niXzINEBmwNZAl55ldJ
	MRIjiJfizBlO4i9txj6L8CbzMjj3V54Fs1qT3HL3op0CVYYh+LZDz6ppAQ37rw6x
	DusMuyK9DA18ARbQw9NvXWmK9XnjPwLf9pnkRDJjQ6wBJJzmdpCxYmTd6N+D0MTT
	PtWCZ1f+ca5PArkpCXuIYEjzdrZWOOhXo4dQhR8apezBsd3Vsp6fGYJIeMavoAuY
	kiLuGhh69FVM2xUEihvVHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738248254; x=
	1738334654; bh=sSBDy2jsuUZ0ak/XFY8RFIKQmDYSF1uPQENNrSCho40=; b=H
	h9fIbeilQZUI+sSAl2xOjtOxOJf7td9gkUiW0g8CHnkRp41ZbtLX4rXcDOMyS3T/
	hmZo8So7eCcVujmeAk9B5rK+l0C8bKMQgTFCM5RFxnAneUlBfKwufNaG0iWzcYuv
	50YO/Uk0ebyyQxLLJ+9P9EzUdLf/urCP1o+PA/VEjHOrE+rdusLIPfbN1e14DaeJ
	uW3YvbLjqryDPcJOHuOF+z5l6gLmzmu5/AvlKfzGHGDi/7nxkOAQ2S+3pI2ED2IH
	NCVv9RtQmcwgQ6tADu/qxPEAQIkdw9JapLjJGQAJk946W2TcGQoPSf3Dagr6DvOS
	mMtIiYNO9AOSTQ/TYyAFg==
X-ME-Sender: <xms:PpCbZ5z2sPFTSSjnZJ8bR4N-CJVxDtx5Jh7kv2ZgmAomrMl1U1nIPg>
    <xme:PpCbZ5REr81LoE0N3O5N0RUS2ruwAlcHputu_R0gmY2tS6z7NWKWX0x-iToQD1Oi5
    MhRB0m_Vy9cIvID6w>
X-ME-Received: <xmr:PpCbZzWDDZMozU0FNWh0Mu5phbEvDnoKRis6TcoJuR4WIaJ2VjPeNikh7sXfwORbtEB1yQslbXbibg1Q4uk7J8WObko7wkxsA06_seLuzeFS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:PpCbZ7jnYfC7voUKyeQC4WXc5j1HkUxbkoXujWbkqKsd67xlsPvjuA>
    <xmx:PpCbZ7C9wrlAfehPan6OABv6kNnHol7fxxV_k6-6n9iQPuXmi24KyQ>
    <xmx:PpCbZ0KAfQ1n4x4LQW-Likl-Q4eyfV7KVyv46Fs29fqW-41rUAG5nA>
    <xmx:PpCbZ6B5IGu3G1y9qSotkVpOE-FjoiKsHzt1uErn_89lbhCcS62TNg>
    <xmx:PpCbZ-PQJV2d5D65yEe51MSHzn_sl4OSS23RJBTlyaHN1DNuWd_vJ4Ln>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 09:44:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d9d540a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 14:44:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 15:43:55 +0100
Subject: [PATCH v2 03/13] meson: inline the static 'git' library
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-meson-improvements-v2-3-2f05581ffb44@pks.im>
References: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
In-Reply-To: <20250130-b4-pks-meson-improvements-v2-0-2f05581ffb44@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

When setting up `libgit.a` we first create the static library itself,
and then declare it as part of a dependency such that compile arguments,
include directories and transitive dependencies get propagated to the
users of that library. As such, the static library isn't expected to be
used by anything but the declared dependency.

Inline the static library so that we don't even use a separate variable
for it. This avoids any kind of confusion that may arise and clarifies
how the library is supposed to be used.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 83ed55c75c..a124101a73 100644
--- a/meson.build
+++ b/meson.build
@@ -1555,17 +1555,15 @@ libgit_version_library = static_library('git-version',
   include_directories: libgit_include_directories,
 )
 
-libgit_library = static_library('git',
-  sources: libgit_sources,
-  c_args: libgit_c_args,
-  link_with: libgit_version_library,
-  dependencies: libgit_dependencies,
-  include_directories: libgit_include_directories,
-)
-
 libgit = declare_dependency(
+  link_with: static_library('git',
+    sources: libgit_sources,
+    c_args: libgit_c_args,
+    link_with: libgit_version_library,
+    dependencies: libgit_dependencies,
+    include_directories: libgit_include_directories,
+  ),
   compile_args: libgit_c_args,
-  link_with: libgit_library,
   dependencies: libgit_dependencies,
   include_directories: libgit_include_directories,
 )

-- 
2.48.1.468.gbf5f394be8.dirty

