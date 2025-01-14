Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66AA20F999
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855783; cv=none; b=OlaCqCb9SNozwBgvJ8REglMy6nSUqPnaf+eKLsn4nFo3ZR9QCkpHHPRL9c1a3IedHZhR8V7COOcuOjlUpPy9LDDQiMlbywp1GPRYVsibBYOw7dwr7z0LiTzQnRHC2B/xTbzgith8GvjdPnq+z3vSVYL+p0j8lB3Yi/APGNSxtd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855783; c=relaxed/simple;
	bh=ZM+WzAGpkE0oovaS89+C4vmVLlw1GZudC7zMuujq1vQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/rErDyeJg89aSh6hr7m6fWC+enPh/q9H3/hBoZiKPxTeXYg3NwIPeAMt/ISCksCxBCKYwom0CBehhUx3PHynxG4S6kqyWCrXwxk7sHpD8QO4LgJfoQsKQObFsLR/N5q+sNs7CbGlUuBO26DrZ1AaKjwH/QDGNdtmH2hcl2Jor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jHoaKwTZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vf25u4to; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jHoaKwTZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vf25u4to"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A941813801BC;
	Tue, 14 Jan 2025 06:56:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 14 Jan 2025 06:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855780;
	 x=1736942180; bh=TgWqotxr6U9LactNVCZwwk7xHzcbzpMddPUeaMWcDjU=; b=
	jHoaKwTZbTc6LJvmRll5AIM0UIZFpdbSQYe8hNNeEPPTxYaL4u9pXUl5Cq9YRmla
	7YEEaFPSiNf0JM4F1HViLUwbj5RCShza7/bCfo9AeNDT2SfK5qskQ9+jsgooJCKx
	5PVYtap9GfltZFzunDbvhz73ab4YXx4U9dl9GQhMYqTeSZs/Onfwn66LBADPcE0Z
	n621U7fHDd+aREuItERAFJcCh09s9G7NZbx44o8W3WnRcOCGyR4KzAeTEzVRYNQO
	bTbVWLRLg13iQIVHMXw+x4tsj5EEHtUl5CjAshlLZVoxZkopPxGhNACGvJ3STPkr
	2Q0cSniLMyfdp1LPhhRb2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855780; x=
	1736942180; bh=TgWqotxr6U9LactNVCZwwk7xHzcbzpMddPUeaMWcDjU=; b=V
	f25u4tozTjoRT0X3nJLvyOiZXKxarA5OBHvPWIp+tP91leHd0w6lXT/JOnLP97Lq
	2lOzNpuuLgUx9BBSbVaDt2O/kWZGh/+WT5ePp4nrGyTV4ShxWzzpWuSarNKCvGCx
	z/ICMlfQUtyFD5sFRIUotaQVWk1TLbYGblh6QMqvKpgLZCz0I31zWaAnDgPV0StV
	+2BkJeStciFIhN0f/NkZv6rRbIV6yL5pKexh3mOsytyBLLVlIBATWk283ndm1CyQ
	kGT8pWnHKD6Dk9jBnFn1E8NBnaHmejRTIkreCZ/uVknCVYL1vDk8puI699WlFA0g
	YZsB90+9yUgoTTe7fGh4g==
X-ME-Sender: <xms:5FCGZykdn48zEIpH3t8jUZrBuJ4-DmDmD3Y_xsZYfq0ua1Iz0kZAdg>
    <xme:5FCGZ51ctNIKl8UG-xIRjTjyFX1aBCllg5lSbvDiGTmgQYxwB6T_fzaZ0UG9ubEBN
    Q16yXwKD843skyCgQ>
X-ME-Received: <xmr:5FCGZwrVHEDwPkonIXH24wsoEizjbbWGGny5H4nlVq7dpU10XFar_R8Ebzm0jM-E4rHRNS25FRkjAMz4ZLmznkRIqN-eARLcR4Cbg5DEAhnKmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohep
    vghvrghnrdhmrghrthhinhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5FCGZ2kdyYl4kpnhHzELFWjF83PXgXc2jKOYkHX-4sW-7lX4fueaMA>
    <xmx:5FCGZw2gHcKmIf3ihtwVBqyc3Hg07tYyueAGukFOPEqkqVVZx4uvTA>
    <xmx:5FCGZ9tvS5fYeVQO-hizvV1af7JfZyDzoiBTYD7a7X2visZ8LK6Ncw>
    <xmx:5FCGZ8XzHqxfARrnOHrVYzykkKM5FthMXfd_4S4STZZ-P-F_BCr49w>
    <xmx:5FCGZ09i8yfQkHOHUz9DAE6a49-5cHB2V4Qco0YoyGBMHkskuTr8rHoy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c85c0d0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:56:14 +0100
Subject: [PATCH v2 04/11] meson: fix dependencies for generated headers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-meson-additions-v2-4-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

We generate a couple of headers from our documentation. These headers
are added to the libgit sources, but two of them aren't used by the
library, but instead by our builtins. This can cause parallel builds to
fail because the builtin object may be compiled before the header was
generated.

Fix the issue by adding both "config-list.h" and "hook-list.h" to the
list of builtin sources. While "command-list.h" is generated similarly,
it is used by "help.c" and thus part of the libgit sources indeed.

Reported-by: Evan Martin <evan.martin@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 meson.build | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 213998986e8942cee080fc5b9b675860cf429ecc..4053024dadeb0aafc067784b976ed3bd96171181 100644
--- a/meson.build
+++ b/meson.build
@@ -487,6 +487,13 @@ libgit_sources = [
   'xdiff/xutils.c',
 ]
 
+libgit_sources += custom_target(
+  input: 'command-list.txt',
+  output: 'command-list.h',
+  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
+  env: script_environment,
+)
+
 builtin_sources = [
   'builtin/add.c',
   'builtin/am.c',
@@ -614,14 +621,7 @@ builtin_sources = [
   'builtin/write-tree.c',
 ]
 
-libgit_sources += custom_target(
-  input: 'command-list.txt',
-  output: 'command-list.h',
-  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
-  env: script_environment,
-)
-
-libgit_sources += custom_target(
+builtin_sources += custom_target(
   output: 'config-list.h',
   command: [
     shell,
@@ -632,7 +632,7 @@ libgit_sources += custom_target(
   env: script_environment,
 )
 
-libgit_sources += custom_target(
+builtin_sources += custom_target(
   input: 'Documentation/githooks.txt',
   output: 'hook-list.h',
   command: [

-- 
2.48.0.257.gd3603152ad.dirty

