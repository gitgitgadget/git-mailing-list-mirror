Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0B38947A
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055197; cv=none; b=ttPIIL+HR48Q75ebVAqhbYc0DfedtAzY7xMGCT/Fz7j4AQI3PBGV5j5HM5/4J6DAjh2pL+mfJ7qreUJchUsz+dCO7McJGW5+YJqyRz1ERbEHE8AIZt2rkA9fHi41TgnLz7Okzc4NPdaWAQj+ih0Sc1WwBp2wPJ/OB2evHMzuI7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055197; c=relaxed/simple;
	bh=L3YnSQSJ7eigB6kyc10h6kfclX7HerC/aXABnkwJims=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SrupX8xt0ro9cda2UHQW3/PgEcwsUaINx5NUigeE2xZNrMVkmwu4A4P/21VK/W9guHclf7/q/UXEQodTNhoCwTYxRcrE+qSU7Wos/JHGx93bRTMKVD6fkL6ejcAI5X7W1NUYb5ZBBCHMwftpfPvkcS1OYl3UL55OMU6LuWOcVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=etO4OfCl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z8mIKuNu; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="etO4OfCl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z8mIKuNu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C93E1D0006A;
	Mon,  2 Feb 2026 12:59:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 12:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1770055194; x=1770141594; bh=MJ
	sxehivOw2n/rFTLSf/EEB7ckhxjQw0TCyeQeORfrw=; b=etO4OfClDKZKUeh6nF
	K+k3pn81OiiXRYK5uNRQhJZ7ms8OiwEE3aCOEwqSqjl4zDyr958DsHZ/S5pgo3Sa
	gNQIHMIjBY82ezJAhVVpf3uyQRtEn7qHF+WTJ2vo8RxovH/PRJPWyUr0RDno+dCZ
	G1VDHvr+eFCMXUo7yRjI+ys7mMPnmrLK8W4dbjzfaUvj6PfvX+zD3gLs4KGnbL54
	TnJVdk78x6ja6mj8P9+xjWYWIXv39Qpzrf+mPzLUcx6V9UxdSW/z8fDDQOqf+a3C
	Hww0IySQc0rhnSQdY+5gAiE9fbhsUOTlBAa7xSMZDYN8/LzZA5Uvz4N6bm0MTUDP
	tj7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1770055194; x=1770141594; bh=MJsxehivOw2n/rFTLSf/EEB7ckhx
	jQw0TCyeQeORfrw=; b=Z8mIKuNuKIX4GzoV+/DGCcuCz5Q/y9FwSRgJbkfaXltr
	RJ40JHnoVAyMoAr4VKNRIMNh0GOS6BMu7FOTUnKC51z+PM2j7spkyl73aE4jkEVO
	kmmdopp/CehOPnsvtfToghuamQO5y73JxUADICppbysoNNJQKmaTUeEm6HUTERZ9
	5aCJdEK2gNrUTI+XjTUHvWPCQVxllyxk7qN9hT7C8xqHJ8EMFfjN/xCJu7kSKm/Y
	4Ich3adPZDFKO+k3udherttkkjpoZxJSDF6vYTwe1EQhMaI1e1DSF+u+QMUb2R9P
	L5Cw7dLzJAhlkZdC68CmUczN/GhSs4vEQgNRRy5/sw==
X-ME-Sender: <xms:GuaAafczYPxyOf3c0qwHF9WF3imUVSJ-eR0yX-_zgsgtCKLXzyp7qhc>
    <xme:GuaAacPKiGB9bkBr8wCUZr2-9RwN3qrxvWPojD7jrd-MvXBR6J5VP0pe7bFLsL4Lg
    uJr5FJo-ryj3yEXPaW0uxBEAwuDYa7pxv2-a4pcvpP8uDX_Fikzxw>
X-ME-Received: <xmr:GuaAadiUF3QUTxDZpghgn8cRpycbqJHLBb3fQOhxuYgfM1n0_PA6flinxbyUkTy8ZLjS9hN_NI1DR2leauiCuXCgld1Lh6xNshK2GwE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffogggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnheptefgkeejff
    dufeefffegkeevgfevvdegffeujeejleegudfhtdffieekleefhffgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghp
    thhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhm
X-ME-Proxy: <xmx:GuaAaf19BP4nR-Gl0F3wo4QTtWHQyOMN01TO-neIo-KUIq04sb3JRw>
    <xmx:GuaAaXgomGlcUgcjl6yN1g6SvkZ2LUnRrJIIpk1eLuWG2MFUdQd83w>
    <xmx:GuaAafdYW1esdeXl94StOnZL52FJEELRV0IjCCuc0ZeDfIhkj7uOAA>
    <xmx:GuaAaanecQHbE5GPPs3YPRXgG5OCZYgpnyVBufAmOxXYEnRG8NmnqA>
    <xmx:GuaAaRA5XLTAO4Luw3URhM3pdAXub2-epQmsY4xdGvBI3hDC4bomh70n>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 12:59:53 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] doc: shortlog: put back trailer paragraphs
Date: Mon,  2 Feb 2026 18:59:42 +0100
Message-ID: <shortlog_trailers.253@msgid.xyz>
X-Mailer: git-send-email 2.53.0.13.gc85a2adbf80
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

47beb37b (shortlog: match commit trailers with --group, 2020-09-27)
added the `trailer` bullet point with three paragraphs.[1] Later,
3dc95e09 (shortlog: support arbitrary commit format `--group`s,
2022-10-24) put the single-paragraph bullet point about `format` right
after the first paragraph about `trailer`. That meant that the second
and third paragraphs for `trailer` got moved to `format`.

Move the two paragraphs back to `trailer`. We now also need one blank
line before the final bullet point so that it does not get joined with
the second bullet point.

† 1: Technically the bullet list formatting was immediately fixed to
     include all three paragraphs in 63d24fa0 (shortlog: allow multiple
     groups to be specified, 2020-09-27)

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/git-shortlog.adoc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-shortlog.adoc b/Documentation/git-shortlog.adoc
index aa92800c69c..a11b57c1cd7 100644
--- a/Documentation/git-shortlog.adoc
+++ b/Documentation/git-shortlog.adoc
@@ -64,9 +64,6 @@ Each pretty-printed commit will be rewrapped before it is shown.
    example, if your project uses `Reviewed-by` trailers, you might want
    to see who has been reviewing with
    `git shortlog -ns --group=trailer:reviewed-by`.
- - `format:<format>`, any string accepted by the `--format` option of
-   'git log'. (See the "PRETTY FORMATS" section of
-   linkgit:git-log[1].)
 +
 Note that commits that do not include the trailer will not be counted.
 Likewise, commits with multiple trailers (e.g., multiple signoffs) may
@@ -77,6 +74,10 @@ Shortlog will attempt to parse each trailer value as a `name <email>`
 identity. If successful, the mailmap is applied and the email is omitted
 unless the `--email` option is specified. If the value cannot be parsed
 as an identity, it will be taken literally and completely.
+
+ - `format:<format>`, any string accepted by the `--format` option of
+   'git log'. (See the "PRETTY FORMATS" section of
+   linkgit:git-log[1].)
 --
 +
 If `--group` is specified multiple times, commits are counted under each

base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.53.0.13.gc85a2adbf80

