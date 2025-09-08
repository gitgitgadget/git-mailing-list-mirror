Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB742235BE8
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346037; cv=none; b=NKMPttub8u3dVymUOAU2HOYP3r3wuil11ZYAw6JyHrYRaWyWQIfb9H+Re+atF4RJ+n0fmtKEu7ZmbJNIKff/E8Q0+5r/84RaJKWnNmr9oZgG6vqK23Ijf4yhfRjnIX3QgJDUDZoF7M/wsxFd4Bp1dBIxoRojflVy99cY4Cf4j+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346037; c=relaxed/simple;
	bh=fHG1fSDNj9pEk07Zwt/08ZM8l45/LPoz6cMbB8NgcTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i210ng0CcbYwLot4Ea3zXcG9VOtnB6OaxOwGqxTzeO+RI7YGCgYTrUxMsa7FsThliP8fa3jbbpkb2iSaele4t0Vp9btp4fbd3E7Pt9VmeqaWEl4C5r3kIdbngO2lGdRiqNmfijX9ZjwNXqqPm2gow9O2ZW5lRu3yk51G4MruSjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=iA7cKl9b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TAHbDSP7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="iA7cKl9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TAHbDSP7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 18D46EC00D6;
	Mon,  8 Sep 2025 11:40:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 11:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757346035; x=
	1757432435; bh=BJ8pgPuYFh04N/uSN3OPxGh2IBHkwwZIOUCEKG+BeM8=; b=i
	A7cKl9bNiUUzRk1Xj7uDoaohyx/TINMKw28JP9x0a2K5jlJTn7GW7SNtM/vxY5rh
	J19SWbtwrhbzBBSXEXu3n/JIw37drXc5dMxXLgennNMUcqTdi7wRxy6uJYqPv1j4
	QH/p6L5k0hYg4w8bSjhZn0PgeS2+6tIgvhmkTSpfIsO4SRraIXCP7agOzoUgO3NK
	fbwG1/kkxclgUPinFgG+CPwt9f6TOuPdWC3Si2xGtfn9JbpTg8uRZJwmYKi2U8Tk
	IzdMyFav1vq26rPEA/spDtiCL7qoohJVw9G2znWnYHiWdY9C+ZRpicKRPc3mXKFq
	xzAuoz/hJaTC69UBrxviQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757346035; x=1757432435; bh=B
	J8pgPuYFh04N/uSN3OPxGh2IBHkwwZIOUCEKG+BeM8=; b=TAHbDSP7gn3BJaUvs
	GzJbqf0bBy7SDN1wsbf49U/rbLXo282SiOKJ1MG+/hsKf8rtNWWoCbwJdVP+tokf
	xm3Ms+SHKSxpW1/7mDKu4na+LtLZQm4S4TkbaKVJapT4E2oC/XqTzPDpSLinNF5L
	hbVR3OASrGdo1U8F+G1WuCRgz9aT/hbnkc/EOwADgfOjJOpLFuJt5jdygvakphm0
	67rA/vKOXaK+1mbd+fEiYgL9nSc9LE5foeXOzZYbY6gREgRBSt92E9IqYV0RG5j8
	+rhuTEQvMnR4tE+e/5ediEEfyJVSb/GlbLuHZs5enbLmcQD9hcPqk1grphoGmM0A
	QRF9w==
X-ME-Sender: <xms:8vi-aMRLESBMP0r5aUuHgBMfiBo-M_xWjkFvUbHhhc7MkHR65o6OSTs>
    <xme:8vi-aEVoCXDRIL1PxwWB95nqNRYfzdZQ89iKsMvEx3s9MFf14QxMLzqVwCxDi8dpo
    GtA7e70cxo1FA93bA>
X-ME-Received: <xmr:8vi-aGZxa_aBk8vap583GWXEUqlVk6GAn7y1Smc6uVP_HXzDfzYnwiucIwlW5kHIKi5OIGuWm6Legxo7div5VqJOeravwDDWczVFtr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrh
    hnpeefheetkeeftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhn
    rghmvgdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:8vi-aC0i6h5yKEn1YF4vw5EFlJ6oetWhWaMk7ohqKzTzAlyJt0jqcw>
    <xmx:8vi-aAhJd1qpMXGBnsivEeW7Q0bucyaKKScq5cP_OVmUOvwwib_Uag>
    <xmx:8vi-aOZbsnsdM0AcUwjP_Et5fkz6dT0meiX8IJJmuUOVXUOGwlVo7w>
    <xmx:8vi-aISrtjDLJqrnZxWtkZq-cNA5a_mB_75WwsnGE9XjCAup3lYeyQ>
    <xmx:8_i-aJCcZDdiMh9yqGZJuR_WEB_NF0fNeJoukUZvt0r72Q2xufFRg-oD>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 11:40:33 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net
Subject: [PATCH v3 8/8] BreakingChanges: remove claim about whatchanged reports
Date: Mon,  8 Sep 2025 17:36:19 +0200
Message-ID: <0d23a4badf0c723cd633999d9ee4d9a94f38fe15.1757345711.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757345711.git.code@khaugsbakk.name>
References: <cover.1756480827.git.code@khaugsbakk.name> <cover.1757345711.git.code@khaugsbakk.name>
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

