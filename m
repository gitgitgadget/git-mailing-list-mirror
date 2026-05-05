Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B845280309
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010411; cv=none; b=qsGTGhz/YCDnwX8WVLAmzNPfHks0nDw3lsVo6doGRFZecfQcMlmRemMI+zEOhR2HBRs/59vhXGW4CfYuKJt/gQSrBuYqYhV+grUEmRLOEo1RJwrE1QG3vLTG8EV/CL9R+vOhSOCw2k/BQH1c6hj12lHAsppQT7hcEgPHbcZrVLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010411; c=relaxed/simple;
	bh=sI0iq/MXqlAA9i4uY1Q2H06c3kKYPJojnXYNQ7OHg8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJwtT9KcVNFyGi9Zd5U0x5nl94Zjmyara638C7a9isAQL7Fdd+0vzHVgYuXD9lVlEKeqO8A3KVDtlReWD42SEK5rWTCQaxlnlPH4k1Te//wafAxWzEZhTbP6++V6JWaBAS7xB4zbmodaIULmdR6EHq0C/usgsvakqf7mmIUGWkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kAgUmRyQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BH8n6azF; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kAgUmRyQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BH8n6azF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 449E61400079;
	Tue,  5 May 2026 15:46:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 05 May 2026 15:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1778010409; x=1778096809; bh=F5f7v4DXnQr5C/ArYLhHm
	qWhoyWXqyEJw4QhI0xJuaI=; b=kAgUmRyQjjecSKT1g0zEeAIYMnaVJ36rxW2Yi
	rxBAXf7MpR34CGxS+QzUO2JWUz6r8F02dEUdqZfj6oZ6SW1o4/oVx7cEbVJUQ/2p
	r9oCVCuZvSiPMOvGWpNiK9cN1SLmQCY5qJfO9UaPOovJLlzY8SFra3hTd1b7msLv
	EOS/2fSy1+W1ZXlLpC6ycSD23EzuptRwZA8s2rIAf7Wpj6Ramcwj2rV03VrhgmT8
	SsQFVKFo3wyoSzUHonheqMjjjSypVBTr2TV5tDPf+wOT4xqw2HOMXPZ0MsO7bhW+
	LfFRZ/iUZC0kzaVYNqSoT8cS4xVGoXXO1Pw9sZiiOfm5YJETg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778010409; x=1778096809; bh=F5f7v4DXnQr5C/ArYLhHmqWhoyWXqyEJw4Q
	hI0xJuaI=; b=BH8n6azFQK0pIUugDiRW+b0Hb744rWp6PyvH7+YqvlJ3+WPjjYO
	q5UqY5l+PrZCP3BnlUQnD9LOrwnKRJ9dHZol0KUD6v5m2n482p8f0eelRJy+sVyw
	p5lhxaQB1nnel0RjIrLT2/zG0EBgPdndsaflPfrnBH2zSCUn1iMYWAfQEREzmtSL
	aQvHPMBAUkMoWLw2zVSEwv4E+TexQ3eszTSy8jwgEx7hOCC+ls5L5/ff4ysXFYTb
	ugzLVT4UTc4BJDAVZji6zCdc4a7ARkGViSZ0VAYlZ9haX8GBUjc+AkL++GZVON7K
	5WitADJ52H6auyFs/CQP/ff22S11q8kNGog==
X-ME-Sender: <xms:KUn6aQ8WPrycCTGrUzSXfXYH9OTb6qFv2xk6vjUNOQCbSbxpTRYwWN4>
    <xme:KUn6aet9qB6Q_l2hBMZXSPqZ8UWugb7HtRG1M2MKdEMt4dcei_hqSXOq9GUc157-S
    KMqDumqOv12YyDs5aOs3Kf6wKAHsj-2v3J5Xi0ziQEbqOenZon_QQ>
X-ME-Received: <xmr:KUn6aTq1y4F1I3IbzMQgGduBZ0ulrSwQzkij-Kntjj5ckOe_SQv2dadeiME5JHb3fJ1HMSHPax8ga3TqMMuubxpiCdhJENjeSgEVo9JPqIDTICPIZsED-qbJsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpedvheelvdejhe
    ejjeehveettdejkefhhfffveettdffgfekuddvvdetfeejhfdutdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:KUn6abmO4M1VJWddMSACB5W6bnRJr46R2zUUt6uqZo4lEoSYeebwqA>
    <xmx:KUn6aXx4KVOeIp3vsSCWrFPo1CJUjnTmtFaCb0ffPFQeK-GrQ7jt8w>
    <xmx:KUn6aTmgz-ILyWo3_WsTidHcVCGMae4jwytH8RWK78Wm8kCSO3AtyQ>
    <xmx:KUn6aQchexp6MUNx2UW0191LQgvnjyE1ZFOCe91Q54hiR8e5lk06vA>
    <xmx:KUn6acVXOp2X_7f50u4KgsWBD4dVNlpnMUxvAcQPi-F02l16Gc9mF5EO>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 15:46:48 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] doc: restore: remove double underscore
Date: Tue,  5 May 2026 21:46:38 +0200
Message-ID: <double_underscore.670@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

69666e67 (doc: convert git-restore to new style format, 2025-01-10)
converted `A` to _<rev-A>__; the extra underscore was a mistake.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Topic name: kh/doc-restore-double-underscore

 Documentation/git-restore.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-restore.adoc b/Documentation/git-restore.adoc
index 961eef01373..7d194231651 100644
--- a/Documentation/git-restore.adoc
+++ b/Documentation/git-restore.adoc
@@ -41,7 +41,7 @@ given, otherwise from the index.
 +
 As a special case, you may use `"<rev-A>...<rev-B>"` as a shortcut for the
 merge base of _<rev-A>_ and _<rev-B>_ if there is exactly one merge base. You can
-leave out at most one of _<rev-A>__ and _<rev-B>_, in which case it defaults to `HEAD`.
+leave out at most one of _<rev-A>_ and _<rev-B>_, in which case it defaults to `HEAD`.
 
 `-p`::
 `--patch`::

base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.54.0.13.g9c7419e39f8

