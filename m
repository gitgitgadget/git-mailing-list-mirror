Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1BE2C15A9
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894346; cv=none; b=XyBxU0H3J6InbQfvUcWrrkn64ZmjIMq2VHRJlUqNMvW4HeRYccGgNovvB675u+rCKhoHJtVMmAevRC2CmusgAClayIJ2kBNC3NV5nRxoui3yyv5dmYEfKbc0/j8/cb0eNC+mNW5VbjC8bKlDWjBpQy1TDAvLeVbngY3YG/nY1hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894346; c=relaxed/simple;
	bh=uQfhuQ675SszwH87COY483vmxTSybN8ZFcjhWTSyE3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rztNVyRd5x1FDuZE4Dg0dxCZI9WPOV8KLJGU6MYpr/87oacIiVYtdKxY+bpAVbHMsfUeil3pnQYxTwjEW7ls+r26Z0rUDzbIoQ/oj9ApSoL79QVYFw1Tc93lUgjIn+vUTyj12yNr83F6mjLXcHnhc0wNdIOkBCwmPbh+TZsCeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=AXpZkDC5; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="AXpZkDC5"
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776894342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FmOfTW/hWiEZGMebKAuRw/D+0Ktjeuf30gHcugM7jgo=;
	b=AXpZkDC5VDiEBKXUcxL2DX8fts2O1Pv7LV74S5WwJXN9O1pdU4wTuB/a/iAc52y/LrA+Kc
	Nvkd5AlIK8jbMOyqXacRrE3SqJ/wHeyBiruWKZ7byeWCMr6liaVayOqdNDChajyxKHch63
	iiXirnb7s5uXBkRpAfUMNvAyhoQRva8BXBcvN9kv3nA7poX9VWcbhXSc7kj4ooH90/xGzq
	o7YxW0cKBnZb2s5HPJZXkczv3W3aRn35LksY4J2YyM3TZg0HFrKait5Slfuo8QdPOMWubV
	ZIG+RNPRlQKJ72RbIRWLacyosGxa7vm9gwg07/93EQhqJoOCJb/DHvdQyfLTMA==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>
Subject: [PATCH] Fix docs for format.commitListFormat
Date: Wed, 22 Apr 2026 23:45:17 +0200
Message-ID: <576d29f15e016889e02c253713656cd8cbf1f04c.1776894255.git.mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=mroik@delayed.space; h=from:subject:message-id; bh=uQfhuQ675SszwH87COY483vmxTSybN8ZFcjhWTSyE3A=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBp6UFusaMzXJCk4JmmwXL1yu7dX9RuZ01Iuv0+W Rjnx+IW1siJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaelBbgAKCRBIeX6hnBm+ 0SHoD/wKpR9nl1kUTs0cKcohMviZ+4klNFWY9oV6PRisqxJfa1Z3eg3tsW/ee6NGOamdkLmzQAX R6RLg83OflaL2tXdZFhlPdxBP4NOQbPO4QlRb98S7YuH0nFna9y4YwMx5N18kqFhJqtYy2F6yzW Ioul2ElI9/qCTOvbZgwqDpRUD/Dzecml2N0u1iNLbOzGIpAoUBFKwFEb4rPU8V+BoZz5OCgBTTz 7nx7Edo23z+K9LD/G1ChWMW/Ssn7acOfBqVg3onzHezKUE19HMlX0WsLFu7uY/TpmebTtOU/nCy iw2U+uBekLXqCbB6bnK3SEMRqeU0++bUeL/3mxreDKC3Pwr25i8FAzuQZnFyn5nZ234s3+CXaKM 2+DMPRBPXn/2yOBlB4hO0WCTlR/LCcGrUW0zGUDP3kuj+6ASIZ+6hn8H8Gdn4mbddF3Q7Bu4zKX uR/qZENCB2Upw5F2yDSx7Aw8O2dPK8Jq0kOmP1RVlpCjVhJKCLZjzxPv5oMbhnroIBvfwPAGxQ6 cNYFv4tUfytwOnZ+eDAbnBAmSRNYdstYC303DmtEtiWPOkwHJrQ1dsVgZCTakaZAq1lcMy30mDu XL4s0AhfScBXrFCFyieQgedofHDBWWz4jlgd53KAErDkpiupaXEK1uDSJs5QzxurX3Sm6abEVHG 3faVsgzlnC
 WmbRQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -

When renaming the option --cover-letter-format to --commit-list-format
we forgot to rename the opton in the section too. Fix it.

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
Unfortunately we missed this one before 2.54.

 Documentation/config/format.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/format.adoc b/Documentation/config/format.adoc
index dbd186290b..95d19134b2 100644
--- a/Documentation/config/format.adoc
+++ b/Documentation/config/format.adoc
@@ -102,7 +102,7 @@ format.coverLetter::
 	Default is false.
 
 format.commitListFormat::
-	When the `--cover-letter-format` option is not given, `format-patch`
+	When the `--commit-list-format` option is not given, `format-patch`
 	uses the value of this variable to decide how to format the entry of
 	each commit. Defaults to `shortlog`.
 
-- 
2.54.0

