Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F74023312B
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757244; cv=none; b=Xp7TxwFEVnDb83eTlcU21cCpAyCuqvtOEGbfuBR8x9go9iI4gCLHAWCy/luraPaM2EDQwYAJ4CXHDFOgzbC1JFyviFlqI/QVXL+fA9xBuk3058rC/BoAtrTKospVlq/164Yz0TntyqlT/Kwvww7q8skolS9avZ9yAbHPCqiDfac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757244; c=relaxed/simple;
	bh=tZ9c3Ihxsz/uqtX0vJc73Magx9vZJeYlJGXD6o7uy5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKbR5ek07T/cQgjWRU53vBRCW1Cj5EvEOqzmEL3KEAgV2m+Au01URCoVz1Kq5M3n8v+awawoWaAWOkWkWLe4noWy3IEyDuu+Q6L7R6uZ3yhQmf5r7I75E600+ZQZbKz9WVYiW6pkI6VpYyV5B+8tRiwwQ6duA14aQDKqWotjSHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qe0xiblG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lvrwm0JA; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qe0xiblG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lvrwm0JA"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61DD7254018E;
	Mon, 13 Jan 2025 03:34:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jan 2025 03:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736757241;
	 x=1736843641; bh=BF5f7yyPmFalPFQl2+sHm0F7xvJc+32riwuroaNcLTg=; b=
	qe0xiblG5/owqP8pBjy6wYZ4E1XIAHD0Pmf+337oe9304InndtIks9XnBph7esXG
	Opq9cqJBRDiR6RX4wH1zGVIgWSL/suFaSDaqOACunKpRnJSmBTXn3t4ErRKy2/Ej
	IXj73MRFrvm494DVAUf+yZHuzIc5hEsaXrg1jTRBkLRHwxDi2/95Z5/ta0SbPZPJ
	4T1zKLXLzVHal1GluzhybMwQJxF8aOS525EKpeHdVYMmDiS0zOnUh9sXoL+1yEtw
	EN3j64KMBTDhjK690uEODMXPVSW/J5B0i4uu0HlJ+2ZsysZ2CcYpeE5n780+UKpx
	wZQ8Jbvu4IjbZI636Wuwtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736757241; x=
	1736843641; bh=BF5f7yyPmFalPFQl2+sHm0F7xvJc+32riwuroaNcLTg=; b=l
	vrwm0JACG4ym13wZ7YS1IRKl0E4ODvz3bm28ewqqcG3uXsmRxaisKOivDT/PbhQJ
	Lvb8kxG0R1EL8vYbIMqBVvZ2DGMwi4+V7azeO6atuvqesIiy1ukgIrrMIM1FmXUc
	O0ymN970/IlEJJRBrah6RkrD3Q5JraCYUy4pDTQvjzHrZZ7nihXj96MFNapvHP5/
	53U3914vGHYBg1UMA7nKmvGygTdf45RwqEF7CZwD1JBxrVoBYJrbgZnvQuyLCY8L
	lr7wbyzO4/OPgffD3TmplDcUVB0NGoiWBAR2kzbjLTjUb9YeNuZWBC8CkHoINnGX
	h0nKqfjmbgJttEJ1JwFHA==
X-ME-Sender: <xms:-c-EZ4cNDJ5s5vjNt9WmM8mMZwV3KdAdSEdOCcavcd7wtLvwGsl-tg>
    <xme:-c-EZ6Mos_FWgqclA7QKg4hegCXxdVcb2ojqUl5rE2l9F0AtW5A6wMzKLfXxshpXI
    n9Be-cKzicmwQcy3Q>
X-ME-Received: <xmr:-c-EZ5gXb6c7UBsxFqCCw7sWv9L9AyJ2q0jlQH_MqPBMr8gI2giT-yaqdMmJJVwUtHWhchDDBCouxsnkHf_U27JO9yApFy_ZsetlI4OSy0kmuDes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehfedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:-c-EZ98Hg-7TnLSpW6K1FJLXX-pLvkaadnTTGzZ7VokzAf1ExhSOVQ>
    <xmx:-c-EZ0t4tCaxekX7N59TyRh71V5JxRBccvFW8YC8avTPLoXjALTkLA>
    <xmx:-c-EZ0E29Q7S8_-b3v0CFwbgKQuEl_nAy1GC9Tjko504jcHBS5LVpw>
    <xmx:-c-EZzMRsIEhOP3RJTU3drRSyVSFo4s_9SbA6lrNkUOhiRH1fG5xBw>
    <xmx:-c-EZwLDW1Y6SjVeQviJ_omuRGLecYMHLEwkYCrFsxEtDryHBrVkjGRm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 03:34:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 16b02d41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jan 2025 08:33:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jan 2025 09:33:35 +0100
Subject: [PATCH 2/9] GIT-VERSION-GEN: move default version into a separate
 file
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-pks-meson-additions-v1-2-97f6a93f691d@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
In-Reply-To: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>
X-Mailer: b4 0.14.2

The Git version for Meson is currently wired up manually. It can thus
grow (and alread has grown) stale quite easily, as having multiple
sources of truth is never a good idea. This issue is mostly of cosmetic
nature as we don't use the project version anywhere, and instead use the
GIT-VERSION-GEN script to propagate the correct version into our build.
But it is somewhat puzzling when `meson setup` announces to build an old
Git release.

There are a couple of alternatives for how to solve this:

  - We can keep the version undefined, but this makes Meson output
    "undefined" for the version, as well.

  - We can adapt GIT-VERSION-GEN so that it knows to print a version to
    stdout with a specific invocation and then use `run_command()`. At
    the point of configuring the project we haven't yet figured out host
    details though, and thus we didn't yet set up the shell environment.
    While not an issue for Unix-based systems, this would be an issue in
    Windows, where the shell typically gets provided via Git for Windows
    and thus requires some special setup.

  - We can pull the default version out of GIT-VERSION-GEN and move it
    into its own file. This likely requires some adjustments for scripts
    that bump the version, but allows Meson to read the version from
    that file trivially.

The last option is a proper solution and quite trivial to implement, and
adapting scripts should be a one-time event. Refactor GIT-VERSION-GEN
accordingly.

This refactoring also prepares for a planned consolidation of all build
scripts into a separate folder. This should reduce clutter and make it
easier to find all scripts part of the build process.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 GIT-VERSION     | 1 +
 GIT-VERSION-GEN | 4 ++--
 meson.build     | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/GIT-VERSION b/GIT-VERSION
new file mode 100644
index 0000000000000000000000000000000000000000..ed39430ff189488182bc6d651bdb88a531498baa
--- /dev/null
+++ b/GIT-VERSION
@@ -0,0 +1 @@
+v2.48.0
diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 754b8ca9eedaa2f7e3b61c83c1cc763538394fe6..95d7d41d233450774a6580c0de332e7b8f69eb4e 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,7 +1,5 @@
 #!/bin/sh
 
-DEF_VER=v2.48.0
-
 LF='
 '
 
@@ -21,6 +19,8 @@ then
 	exit 1
 fi
 
+DEF_VER=$(cat "$SOURCE_DIR"/GIT-VERSION)
+
 # Protect us from reading Git version information outside of the Git directory
 # in case it is not a repository itself, but embedded in an unrelated
 # repository.
diff --git a/meson.build b/meson.build
index 7361eb2eaad422e7a6c6ed95d275615836c21cdb..87755537d2aff84a9d8e86f0f5b025ef8dd23292 100644
--- a/meson.build
+++ b/meson.build
@@ -170,7 +170,7 @@
 
 project('git', 'c',
   meson_version: '>=0.61.0',
-  version: 'v2.47.GIT',
+  version: files('GIT-VERSION'),
 )
 
 fs = import('fs')

-- 
2.48.0.257.gd3603152ad.dirty

