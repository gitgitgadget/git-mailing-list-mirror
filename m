Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817B1F4615
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968862; cv=none; b=LqrWfHEC0oX3GQrNB43YQejFuuoO8OVXvHhDi2I3tM/FnMNlkSx16Pfl8lHZUMQ6VVoqyG99je8V4U724zZt2LAyVu3GZwx1ZoiotBhf9bZsW2VmLXX32xuD3+fXw5VrmSW8WyQ4ZSlv4pFzdci7XPCFgWEyFYlNFtckWIEUVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968862; c=relaxed/simple;
	bh=qnF9MkOz8Fgs/sHzc3vkcPvmLXc6lIKZYubblbWfZ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPiMjTsk2EnKtW67xMyeievTXHrEYyjcaKNczojqEhrbEchRdOO4cJk5gt1/jFkAvffOLfh18Sw0AZ8/pbv0ByOKqZ1OwYnUQ/vFs8KovwNBKuW/uw/pcnCK/rFXwIXChrU0c1Q11emG4BwYlfpGJEa7mxlzYrgohUtjJhJ7sNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=peJP2ehV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=w7eT1H1R; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="peJP2ehV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="w7eT1H1R"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 69D587A00B5;
	Fri,  9 Jan 2026 09:27:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 09:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767968860;
	 x=1768055260; bh=5IOlX4nxKm/Ki+dwzvLxGUdd5bxj9yjzUxaK1DKwfGQ=; b=
	peJP2ehV7EOIwOhnokBxAvGVMn4z1EmP9hONvKH7fNOMpxxQJ4xFBzd2cSePb6dx
	Ibn9ZN7NRXUksyffI/pCluft0q7UOhS1p6g9yvo60NldurrM4I1wa2lNOXSlIBiS
	TQ1yWA95uE143PYYtA+fojxNjXuQc4+Zov9E+6TmkwJ9T90fjE/g2i96wNw51/+K
	UO3cWm9pmC1S4BKj51ooEYckDwU6QL21mjpozbHb2R41Isx8F9t9qp99fTSjB8Xs
	p8hL/SWN00YoJjvRQ3WNVijkKUqGtK0eWytnfuqCrUCmJDPa9RxGZ76h/yEZsZNs
	VvuhhvOanWEUXkXKFWxkYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767968860; x=
	1768055260; bh=5IOlX4nxKm/Ki+dwzvLxGUdd5bxj9yjzUxaK1DKwfGQ=; b=w
	7eT1H1RCSFGw77g4WwoUXKzcfKYSW2BV1prgBu/jPe9O6ryE49lLe9LIEXcOu/5N
	0gkGZAgdO+gFWouUcIQvkgVJPpcCw1q6bsgD85kTdyMKP1oTu7M+vaTQV/kyyN7A
	hd9LsM2DYe+7fLyvjIXE8grh0rEEYaJ/PVfNv3RInx8EvU4jYcIpxTxMo8BqnMZJ
	eHBfoe+sOiZAiOG6rDigv7QA9TjwM2ztjS5tbJfaPEjfpa4gkqFBMFJFVQm6PvGe
	UDHewvelkeii2FO/A36uPb/8LeAxdJdvcInm9PNknoPbrGxmpuQWGhRS4tZ8GD1X
	4V/8FszIfQzx08x/hEqrw==
X-ME-Sender: <xms:XBBhacJpH2jzqErq-gKw_LFpNKRNDbFU9n7F57LoK7-wbH42BeLHcr0>
    <xme:XBBhaTIUa6xgxxmpI05gaYxNRUVNOCC2BhFZ9FFc1ETQkClqMBfdZeUTOppkY3ENa
    _oALKPcOKmDaCHtGXYrrAHRK4-5G3gwkH69jv5H8RXk3A9taZiARw>
X-ME-Received: <xmr:XBBhaRuTvgXUTAgfSnqfupHTgJKPp59j3eFGS8LrmKmdNyMPWdjMKPQ6uaLQWNdCyjO1gJYQw91YpNnW2R4P4XQvIYZOFpApVbQTvzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeltdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephffggeelhfejkefgteelteejhfetieehgeef
    tdduudffgeejhfektedugefghfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshht
    mhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhushhhkhgrrhhkuh
    hmrghrshhinhhghhduleejtdesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhk
    shdrihhm
X-ME-Proxy: <xmx:XBBhaYTyUop3JQKsuLPSDr1wv-xGl1gaa4lSd-vOTpxTR0BZlv9dRQ>
    <xmx:XBBhafMPJSKnKjWPjTJHRWhXysts8sM6NUpZ-YAMzb9WiRhsof85GQ>
    <xmx:XBBhaVZqtpLHi-hnSds5Vm8O7eOyIsubEsPj7OOsmQm5ln9Zh1AzLQ>
    <xmx:XBBhaRyeZ36OMoLDBp1Z_icHcjTqFKufxA-OZCiZbpbA_FXBZjOgPQ>
    <xmx:XBBhaROJM6-9zJIcnWLDfbU6t68YcD36318TdStaTWANhfvWJOFXq00H>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 09:27:38 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 3/6] =?UTF-8?q?patch-id:=20use=20=E2=80=9Cpatch=20ID?= =?UTF-8?q?=E2=80=9D=20throughout?=
Date: Fri,  9 Jan 2026 15:25:59 +0100
Message-ID: <V2_patch_ID_term.1b5@msgid.xyz>
X-Mailer: git-send-email 2.52.0.421.gc32ead4fc78
In-Reply-To: <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
References: <CV_doc_patch-id_3.1ab@msgid.xyz> <V2_CV_doc_patch-id_3.1b2@msgid.xyz>
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

