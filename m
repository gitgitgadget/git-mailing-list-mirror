Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD40D264F8A
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728316; cv=none; b=H1IGdjnc6C5Dm904vJTeXIOtEEftlWUJa98KhqRHJyFBCRALEPAn/NdbMkSLybL5SwB9QlLNNvPWvredXGIsgBxar+IXwvW7FnAuB7AaRUQQmjFiCMSKfMsa69e04rf74i8jJGC+0ybdqB3Ol/G6O5AWHrNMNHkJIPF2VW714z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728316; c=relaxed/simple;
	bh=TnvfCKpcldMX/tO/rfhcFqqP7pZwKMwAS9N0TZ1e+Rk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJFPY0kyOefZ2YFSDS4H5wx+7axq6pwy8kTKLI2Xr7iGctlU2ekTbtfcbqNGN5uibtSPRKsc749oHA1zZ7NjnyHltJOiyPYqBtZ+3KErrMFwelBlClM88p84c18Fuaiapt1mRsYRFr9U0b6uOOm1mMiwoKGqtmmL4Jn57TfqYoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=q4wgZSQ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4PUUn+pb; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="q4wgZSQ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4PUUn+pb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACADD1140152;
	Tue, 11 Mar 2025 17:25:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 11 Mar 2025 17:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1741728313; x=
	1741814713; bh=JX85Ajk66zvSqDwxfktO4Qe+mhC2o7VQcB9SsWldkwo=; b=q
	4wgZSQ3CwNFBygCxbZp3oytLEiL2VG5iKs0J4NcJjaxZ3kWnkJtSoURGZJ/K4bUZ
	nMkpOoXiOJxQaLG9rQUvC6D+oYDEC0QE5Np1N73cUMmSfiJw+b4bVxq4X0fyRlqB
	rCkzWDcrUqxPp2tiUf9qmdfcy2HLdz64rAGJbshuvN6zhLmuiiCatbUunqrp09k4
	M7LueCEXk2MXL7dVyaZd0LOb3kT3qcpfidR9fnUm86+o+5viGeGc7rpkeazqxARj
	fiz0G4ol/e+1BqGI24K2+zGdUTCyum94UMreQPDkC1xVUy+CgkExMPLylWNeSl9l
	ndAcvHzVOOygzmZ0jupfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741728313; x=1741814713; bh=JX85Ajk66zvSqDwxfktO4Qe+mhC2
	o7VQcB9SsWldkwo=; b=4PUUn+pb4CsqDvBK+zdDfQSd1AbQlywKlR7ViNymFK7E
	4FayGaGx/pKEEi95e3fnA3mQOAoGlJMZc9+AcBr0NfQ/AJYYoc6mzgUHj2mw0CzQ
	ODJG36JP7V0mIcyDwfE2Yu7x/4QCk4YojC/Al6uLZEoNh6MLvbYmKMtQBG7V2r5j
	yxRmyyFlL4dO2n3SbHP3fc2pYeNBYBKDmzrj3Qxt4JHGrzu0dJ2Q1iX+hDTZZxQS
	A7abJ4b1elziTSKDEJB58VKTvCcgcAgp91MbHWqQSmtOd0hZZ53OTAg9vahu5W5v
	qNC/phDFlR3aC0nBYgY9SFkbJIq8Q23XwlLwk+EDgg==
X-ME-Sender: <xms:OarQZ70zk27kg2r_OI0UkLE3yJ-t5LAelW0wRh9ySFv6MG3f7zvQ0g>
    <xme:OarQZ6HxWjVkSXhvSzNn6KPWIr2LpOvZlWHTH_HD_ei9lUBJS6A9DJZVDjBz554M6
    CBS8cKPYGuPgV6czQ>
X-ME-Received: <xmr:OarQZ77fm8LyFRDKA1_naZkqcyru_76BngTdYiJFE2DTokv1Jy2AJBcKP7_GKekHIGEVw1RJi01h8a3wxOjC90qdp1OMKeVesryV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OarQZw1kbjO-46QDM35XhU7Pjxcq_LA2u1j-4YVGSOFmiLrmiNe63A>
    <xmx:OarQZ-ELJNJ82DuaFnwPI9QF7lrPfki_m9mWbAc645DQf9Zz5wGXDQ>
    <xmx:OarQZx_RV24X_w28cpoEPH92FFdWKOCGE7TIDzKxux6jsU2H6BPF9g>
    <xmx:OarQZ7l1d_6Jo-tKy78EiJjHpGHma_ZnPx7Yk6LpG1fCyPRHzXrlig>
    <xmx:OarQZzRUVq1m6xhUeDEfRbk1u9e2JPOSTou7M-C9ywi8luN9uxkPQ2JL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 17:25:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 4/6] t6120: avoid hiding "git" exit status
Date: Tue, 11 Mar 2025 14:25:03 -0700
Message-ID: <20250311212505.2920181-5-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-rc2-181-g28e223d67e
In-Reply-To: <20250311212505.2920181-1-gitster@pobox.com>
References: <20250310231652.3742490-1-gitster@pobox.com>
 <20250311212505.2920181-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A handful of tests invoke "git" on the upstream side of a pipe,
hiding its exit status.  Correct them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6120-describe.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 76843a6169..dcb526e37d 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -292,13 +292,15 @@ test_expect_success 'name-rev --annotate-stdin' '
 		echo "$rev ($name)" >>expect.unsorted || return 1
 	done &&
 	sort <expect.unsorted >expect &&
-	git rev-list --all | git name-rev --annotate-stdin >actual.unsorted &&
+	git rev-list --all >list &&
+	git name-rev --annotate-stdin <list >actual.unsorted &&
 	sort <actual.unsorted >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'name-rev --stdin deprecated' "
-	git rev-list --all | git name-rev --stdin 2>actual &&
+	git rev-list --all >list &&
+	git name-rev --stdin <list 2>actual &&
 	grep -E 'warning: --stdin is deprecated' actual
 "
 
-- 
2.49.0-rc2-181-g28e223d67e

