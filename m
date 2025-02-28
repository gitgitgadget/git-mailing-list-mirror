Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43EF41C63
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 03:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740714449; cv=none; b=O8eZx0vrpoLKKDI/s4wck+T7jcOcGueUMtgyTqKe1quyOmaJjcgncD4pHxrCDS3peKXubniGUU8JdwWugs/Arn2UScweZMkXv7p1tGd1AVG9grR7E+RMnLpbGNtX7xdR760uiCo11bo0PO4EW8gqUJgLZdBawTJTkm7XfhpJ10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740714449; c=relaxed/simple;
	bh=W2FbcEvkEZp47a8dzHAVCyS+I8/m9ceTGbELLFiz7ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PE0kG2eQ/QxDwdCl3EF/tm1gunapstfpfe8SuwOoRdzrdO7O69R1F/oKATEOHQ7/9FVYQ5+nLq2Fw0uIokVh7YFfIuT4EMoZ88nZP0fHJac+cGvsFVANi6eWEURdg2zWz3PtL2yiQ1z7ueF5Y0GqL48XtZzVUMY+tDtJFlAJXqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rhNvxubw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nfSm2F3S; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rhNvxubw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nfSm2F3S"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E31C8254012B;
	Thu, 27 Feb 2025 22:47:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 27 Feb 2025 22:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1740714446; x=
	1740800846; bh=5XT6cc2UDzNKZmhDBS6Z6UfHNcgxbQ3QidXui2y0qcs=; b=r
	hNvxubw2hymtlCJdLNhr/L8wfxjHHLOoVmJ4Seg2BXqdLLFaA9sOWthL44YMGjmA
	42Rz7AuREpiy1lkkmFFIZShZCWSISyBp2A0FEbMkFewupqAVqqOKBx33U5vhmgJh
	t6FXMcEOB1ffe08/GHNVqwo00noU6NypzE8t+7c1XcPthMiPBB1yL/UfwqjfMVJx
	O5LKMrg3X9ha06BaLpLPJenxi0KqZQKotfp6+4Gm8NyVkbv69lsBZ0mwRL5iJHLR
	tL7MiWAinugPkKOkPcr+l9IGjgv5zhxN3Fn2zNTCNLH5d/RfyfHGdfuBlpTA2NJJ
	+KrRltsRYBvIrL1OVXoVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1740714446; x=1740800846; bh=5
	XT6cc2UDzNKZmhDBS6Z6UfHNcgxbQ3QidXui2y0qcs=; b=nfSm2F3SvpxQdCwg+
	ZD5AjRUhyK9sXSbTTE0HCWw4wdhbzyU6iKX4BhnaX4l4MMkF6dIK/fZ2oV2fbcAu
	lX1m5YJyFM+WXO8eoifTdwIX+dw4vcSjujh23uC5f7H/A3epYliKkddQyDENitvG
	JJAlKyIIqzR7WvXCZZCvHlDl7cKV8pvw3eYrewSYXRHNIo4/5ZtJcF+fuiTJlfGx
	MyAdFWaa8CRadOzHyALps3zmKBx3pqguVMuo8/9fnnC6XHxl2hN6qMHZeesBVaqc
	9MDbXpQ8G2eN2N1fwOJhig553AJVAhk0CdlFLZ7l8L5O35oxEK9qIZXacIUo5txS
	89dxQ==
X-ME-Sender: <xms:zjHBZ2B7SLUvgT_aPOaCz7m9X_07dKAs4IJjPzGYIy8eET2f0wi2AQ>
    <xme:zjHBZwjkKpP6iwEtkq1l0GNBmxJc7vEJ8aqUoeFinV99_FC4D7zRI9y8EGRTxy2v3
    StZUwybpwiPKDZUvQ>
X-ME-Received: <xmr:zjHBZ5mf4lDlLJ7CUfs807yhYp6gGPMFoGyXt3hMYFD6raXfehf1zMCIa68UqzWrnkGiqrOdgEhXrFcyrSqrLHpo4DA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeejuefggfehieeugeeuheevgfegudetheetuedvveeu
    ueeileeuhfeigeefkeekieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:zjHBZ0zW0B-Wj3AuWTqtvYBZku7C38XdADmwaP2SBXClhhLBG1cNdQ>
    <xmx:zjHBZ7RKx97uXvgotFjzcTQk8rxY-9ou07tvqWYmBttP7nL2yqpp4w>
    <xmx:zjHBZ_Yiz1664CRXxYrtUBgHQgJszP-kEz5lh0x0HR5ig5M3WgtJ_g>
    <xmx:zjHBZ0R4AHlaWKqy7ksW_UKQEm4Nw-Q6ML4kGx6GihMUmt_cUPvEDA>
    <xmx:zjHBZ1exoJw3rfY7yUAe5NyX1Tf5akiPvIp9roo5Q1YZZQFH-Y0tzRP7>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Feb 2025 22:47:26 -0500 (EST)
From: Todd Zullinger <tmz@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/3] contrib/contacts: rename .txt to .adoc
Date: Thu, 27 Feb 2025 22:47:05 -0500
Message-ID: <20250228034713.203461-3-tmz@pobox.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250228034713.203461-1-tmz@pobox.com>
References: <20250228034713.203461-1-tmz@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The .txt extensions were changed to .adoc in 1f010d6bdf (doc: use .adoc
extension for AsciiDoc files, 2025-01-20).

Do the same for contrib/contacts.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 contrib/contacts/Makefile                                | 2 +-
 contrib/contacts/{git-contacts.txt => git-contacts.adoc} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename contrib/contacts/{git-contacts.txt => git-contacts.adoc} (100%)

diff --git a/contrib/contacts/Makefile b/contrib/contacts/Makefile
index a2990f0dcb..9c4ca4f3bc 100644
--- a/contrib/contacts/Makefile
+++ b/contrib/contacts/Makefile
@@ -34,7 +34,7 @@ GIT_CONTACTS := git-contacts
 
 GIT_CONTACTS_DOC := git-contacts.1
 GIT_CONTACTS_XML := git-contacts.xml
-GIT_CONTACTS_TXT := git-contacts.txt
+GIT_CONTACTS_TXT := git-contacts.adoc
 GIT_CONTACTS_HTML := git-contacts.html
 
 doc: $(GIT_CONTACTS_DOC) $(GIT_CONTACTS_HTML)
diff --git a/contrib/contacts/git-contacts.txt b/contrib/contacts/git-contacts.adoc
similarity index 100%
rename from contrib/contacts/git-contacts.txt
rename to contrib/contacts/git-contacts.adoc
-- 
2.49.0.rc0

