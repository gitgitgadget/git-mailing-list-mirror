Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B219E7F7
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447316; cv=none; b=WHHHdDshi0mRfINaPV/jV7OiaZqSBqHmGX4WgYoHLA8SgiQN+O0DZfjJGkxUQvW9uSrG4a1B71mK4G5B33FCx+eMxNqi4k7F6MiS2TPVv0rtpcFR2hKpsO54dYvABKayvxK1Z/c0eKDiAafGCFKgoydc8mafx3OqDsEOZfQ0Z88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447316; c=relaxed/simple;
	bh=fHG1fSDNj9pEk07Zwt/08ZM8l45/LPoz6cMbB8NgcTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGuxzgbTr739ZvazxCE3WRIBXVREXIftO7uli3QxNSFZr5679Rz7fke8r+bLu4u2X8wxKx72xv9zu0NS9wf2RgZkvVFOkdUqAo0fMmDb/8tczRKy6rVSFqAFgI1dQ7tKmf5yFtOV+iIiPbxNmf2sqi1+hAXmkh8wtAhFumAzH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q6AisY1J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lw08XYOj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q6AisY1J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lw08XYOj"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AEF6E140009C;
	Tue,  9 Sep 2025 15:48:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 09 Sep 2025 15:48:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757447313; x=
	1757533713; bh=BJ8pgPuYFh04N/uSN3OPxGh2IBHkwwZIOUCEKG+BeM8=; b=Q
	6AisY1Jmu32H2ShwXPuKYUoM3zK0DwGHpfRLWqabOQ6RpaJCThKmopwUBsv/TTzB
	qd6ZgihlGzLD6RI2pxIGjgas3V0KAWQiC76vFF00lRq5sj0Vd0qDP9Tgcr1lAHIv
	bguxgJog+Ma4S3Lq1BouvyiCfDS2YQ7VKEwSacYYB72qDCA8uiqLdgvChbS++PsD
	Q6LlTZb4MWi38dU2D8qSPpSWjIof3U3GiPPYlUK0s0+31nQ7gyMaYjJSYmLgeG7Z
	c6/r9tRKVzf/C62JT+dEvysiEo+lq9XgbVQRR4V9/t7D/7jHT4KZYSk4L+jXu5rE
	P8qQu/QvKwTWjCas2TXog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757447313; x=1757533713; bh=B
	J8pgPuYFh04N/uSN3OPxGh2IBHkwwZIOUCEKG+BeM8=; b=Lw08XYOjhKCLNJ5/V
	+S4T5IIlfyPjxvSk5OXvuFHXBunkNhrKl/U5SZyQ09cIXg6t7goUmgeIwsxxRUC4
	eGkHVmokSnGFcs0Ed926/gLD6cG2XuKedpEG2pFEFLf3izPDIkYDGiKKvhyHYtIE
	Z4oLPs4sAnTf8qyciMioSLqb01Dbe1f5IUxrSq+RdiEMR7H9sgKJ8pCYYOVSKq3U
	U/F9nHY0+LbVQJcYpa1md11wYWWqKqjSRZLa7ShGxcc7bOyy6j58ho1+/++k3Fym
	I7UJz6JPvn1WNwtkLzvvgwJw0en3Xn1DjtWGLuiioYfLSSRBFmjow/2nSTEu2ELv
	+AefA==
X-ME-Sender: <xms:kYTAaAPfjFU3MrDPcLlqn5uImoyLDn9Ra8d-4Ze2kd8WJEYBL0-YaYE>
    <xme:kYTAaCc5LtFw9L4jIZaI5ayAsOV_NRP0JRstJshSm61kRt0rsiTBRdZuN3xGUfVTs
    4Q9SVMVSoO8GhnjiQ>
X-ME-Received: <xmr:kYTAaNuJnJ-hzB0uEqvX9QxPyKyzKrQbPqkZrnxuX1TehZ9q5tR084LIc1BnbGjVmiFiWYmCcTfxNm6F-FcBk52SeaYgp2wBCK9EORnyzjMpAjLr6W3fxeYsaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvuddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrh
    hnpeefheetkeeftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhn
    rghmvgdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdr
    ihhm
X-ME-Proxy: <xmx:kYTAaDkxe84v0KYjB25eQFGbj2BH4Z6b8I1KOqb_-Dvqpk7CFKDKcQ>
    <xmx:kYTAaPyENWuWC69XtZABRDFAIGkadpeIXplElA2eY9XVlYgXMP1v-g>
    <xmx:kYTAaFNPzTGNeK8tKppxWgaimKXhmwT_9NpQMGH-DcmIxxOLyOcdBw>
    <xmx:kYTAaLqZpLvURO-0oyQL79FT17Wma4DrAGvxeJMgss10EPazUxuy1w>
    <xmx:kYTAaBUPO50oztT-Zo1nD_Dh8bLvRooSn9oaIO3hg33VN3W1jgYsjI9T>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 15:48:32 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 7/7] BreakingChanges: remove claim about whatchanged reports
Date: Tue,  9 Sep 2025 21:45:57 +0200
Message-ID: <fee752d2fb0a8702683d94e76b6ee54e7fad8c92.1757446619.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757446619.git.code@khaugsbakk.name>
References: <cover.1757345711.git.code@khaugsbakk.name> <cover.1757446619.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

This was written in e836757e14b (whatschanged: list it in
BreakingChanges document, 2025-05-12) which was on the same
topic that added the `--i-still-use-this` requirement.[1]

Maybe it was a work-in-progress comment/status.

[1]: jc/you-still-use-whatchanged

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    Footnote solely to avoid awkward paragraph wrapping...

 Documentation/BreakingChanges.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061c..c4985163c3c 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -235,7 +235,7 @@ These features will be removed.
   equivalent `git log --raw`.  We have nominated the command for
   removal, have changed the command to refuse to work unless the
   `--i-still-use-this` option is given, and asked the users to report
-  when they do so.  So far there hasn't been a single complaint.
+  when they do so.
 +
 The command will be removed.
 
-- 
2.51.0.16.gcd94ab5bf81

