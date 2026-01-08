Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3627145B3F
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853777; cv=none; b=OvrjDOjdm9K7PnKUztjHupQsDTPiXs1cbQGlEg8gFYHjb6oovpUfArfCgNV/oMwc6ac+j1kH8LPbUy3FIai795qQUwsk5XJ0dVepox6HTK4zAFQZX8tLbe5312xtgNxSgMH8pymPGidY9HyEJwrRkHxgmrXMH2Fj98vkLa+K8BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853777; c=relaxed/simple;
	bh=qnF9MkOz8Fgs/sHzc3vkcPvmLXc6lIKZYubblbWfZ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kICNU835r6ErcJUr9Bj2eDomBRRkPVogdMWBGBcwrch0aAN1bSgjD4tZvvrzwPAe4RG6fTAyjVXoWWcv2eT2a0edp/Sphvb8Uz4m+ciY3i53ZH4H9DmTSJfUjip5wiwaM8PR2xPNnnKcq7ijBI5IjfhGE+qit8ImBbpFlvhgnhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=c1s28m73; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BB4xvWbx; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="c1s28m73";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BB4xvWbx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 278691D000B4;
	Thu,  8 Jan 2026 01:29:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 08 Jan 2026 01:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767853775;
	 x=1767940175; bh=5IOlX4nxKm/Ki+dwzvLxGUdd5bxj9yjzUxaK1DKwfGQ=; b=
	c1s28m73JKfu3s0QT/x2Q021GCzN5EZDyk7akItqjjjSnxT+g0i+hto6MIqFS7CW
	304auJgLWGuwdDTYrX1Ek6HhD8htVv91s0VEHPxLBHLw6D2PITa+KpWhgG1lOurS
	2I9PzDCIHsuzMIda7V+rRohJsGl/TwYzzGhpwyz/x1G2IoIX7QhOKEDYjJ8q5ML2
	0+tyBupaAjvIDEYCZAH5S7fdyHduM07xkEcv7Yhr/nMYjUPBAijI5RQUgtEd54io
	HjV9upo4XUVnviSwCzusWUoWT/oki7Xyv/QSzp2oHtHGDoE9um32dYKLIA158bZT
	GPDD9h5oc67U6QWy6KeM9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767853775; x=
	1767940175; bh=5IOlX4nxKm/Ki+dwzvLxGUdd5bxj9yjzUxaK1DKwfGQ=; b=B
	B4xvWbxv8fEyl222YF/HYykEQ5zi6vbjX6MvwcSpAQ//dcJ2uqaPk5XceGkuZ5bP
	G0iPLSoknhDr7HjfeaiXfcjqXjYNZ1FVMNbTziMC43p6nblZBLzK/U3KZEL0mwX4
	7ewWIIKdMru5paaSlLIB+NXWjePY8JAf3uKcKXwfraZx5xNtX1Fla+AkAZ4ummtF
	pJSZ6U6F6LOe5M4PgAM1Mngzssrpajjw4mgn7YTAQf8bM/Jx8zcTbPVGKYj9Y30L
	fL4NRDHS8+CcrI++81dwQ6/a4oZ/EkWcvVHwgT1VlgYHKRQMt7fze+Ogu9SXhsiM
	U95V+eeLA1z2jDyM2sWRw==
X-ME-Sender: <xms:zk5fabcpx-JEkIDDWjijrHoXEKPyPn658D-Mcgb0X6Qr9tlrT8OsU0k>
    <xme:zk5faXPMjn1Ap-oiOvi-ExmEJC8-RZpFyW3ZOb1PsDkaxGwhNDrwXwF6RUiuuHt7N
    7LZZkehM88p_EvKXc0ia5NK0YOZ8MNvhsR6tdMKDE3GuqILRRlOzw>
X-ME-Received: <xmr:zk5faSJVySntYdjLXNDSoNITmkuT44B498vD04ntx01MhIDLNOU5SK5YCEO_s3zRjPKbeC7YfQnrmgZ8WrQbM6M8nQ6GxcSXeNykR8hskaKTJEE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhephffgge
    elhfejkefgteelteejhfetieehgeeftdduudffgeejhfektedugefghfeknecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvg
    hrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:zk5faYEUaMyxoqNalt_9FfKQ_Ey9Xh9_cCggrIwQKskh8yOLMBTuiw>
    <xmx:zk5faaQebzmhX7xNWqLnL6K7fN4VXxgqPZAEpsqU5lzZuGWBaiGMlA>
    <xmx:zk5faUFPn15ndX82JX82gWrquLWEx3ASsNw3jYC3yHodJJjzPsn4sQ>
    <xmx:zk5faW_XibQYsDZ9cTU03Mm2wTwuGLrIH5mT0Bq1Q8_aWRqGpZNcMA>
    <xmx:z05faW1fXoCsoWNCXFIQ364vasAN8roShSf1Xbg9rzwr9nIkmSfepVhB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 01:29:33 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 3/6] =?UTF-8?q?patch-id:=20use=20=E2=80=9Cpatch=20ID?= =?UTF-8?q?=E2=80=9D=20throughout?=
Date: Thu,  8 Jan 2026 07:28:17 +0100
Message-ID: <patch_ID_term.1ae@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
In-Reply-To: <CV_doc_patch-id_3.1ab@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The “Description” section decided to introduce and use the term “patch
ID” for the ID value itself.  Let’s use the same term on the options as
well.

Also make to sure to use bare “ID” instead of “id”.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-patch-id.adoc | 10 +++++-----
 builtin/patch-id.c              |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-patch-id.adoc b/Documentation/git-patch-id.adoc
index 82992e35fc1..9999f164b58 100644
--- a/Documentation/git-patch-id.adoc
+++ b/Documentation/git-patch-id.adoc
@@ -31,7 +31,7 @@ OPTIONS
 -------
 
 `--verbatim`::
-	Calculate the patch-id of the input as it is given, do not strip
+	Calculate the patch ID of the input as it is given, do not strip
 	any whitespace.
 +
 This is the default if `patchid.verbatim` is `true`.
@@ -51,18 +51,18 @@ This is the default if `patchid.verbatim` is `true`.
   or produced when an "unstable" hash (see `--unstable` below) is
   configured - even when used on a diff output taken without any use
   of `-O<orderfile>`, thereby making existing databases storing such
-  "unstable" or historical patch-ids unusable.
+  "unstable" or historical patch IDs unusable.
 
-- All whitespace within the patch is ignored and does not affect the id.
+- All whitespace within the patch is ignored and does not affect the ID.
 --
 +
 This is the default if `patchid.stable` is set to `true`.
 
 `--unstable`::
 	Use an "unstable" hash as the patch ID. With this option,
-	the result produced is compatible with the patch-id value produced
+	the result produced is compatible with the patch ID value produced
 	by Git 1.9 and older and whitespace is ignored.  Users with pre-existing
-	databases storing patch-ids produced by Git 1.9 and older (who do not deal
+	databases storing patch IDs produced by Git 1.9 and older (who do not deal
 	with reordered patches) may want to use this option.
 +
 This is the default.
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index d26e9d0c1ea..2781598ede6 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -228,9 +228,9 @@ int cmd_patch_id(int argc,
 	int opts = 0;
 	struct option builtin_patch_id_options[] = {
 		OPT_CMDMODE(0, "unstable", &opts,
-		    N_("use the unstable patch-id algorithm"), 1),
+		    N_("use the unstable patch ID algorithm"), 1),
 		OPT_CMDMODE(0, "stable", &opts,
-		    N_("use the stable patch-id algorithm"), 2),
+		    N_("use the stable patch ID algorithm"), 2),
 		OPT_CMDMODE(0, "verbatim", &opts,
 			N_("don't strip whitespace from the patch"), 3),
 		OPT_END()
-- 
2.52.0.421.gc32ead4fc78

