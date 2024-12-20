Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513192210C0
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 19:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723890; cv=none; b=DkObTks5VR3wT/y4tHrW0aThqqcz/QPhOJRrNUlTlR3+qoK1pOuN1gx7h12v1IvZ9d5MWi0CV5Ex/uMKmxvTDQ69rQhlvGiG3dv/NzY2cAHP7Fz0qirAP1/yxhTLKVJZyC9BAJXvK6z4yGVeR9DMhBG+X/26rHNNhSVcmcNpvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723890; c=relaxed/simple;
	bh=zlz8TQoeinzR6zxpnWEVUk38ytVA47Nwr1b9uG2pkrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dc6t9BlV3gWPYqBtDY8G8yRWHeCDRM1ZhQCfXKOXX+lI9g7RKbNrf2USqg3Xav7/AS2cQL9uA51976r7lKoykQb/Qjj9tR9+YSBoav4+CmRWxYTo9NfCrRdPAsf/IB2LIsJiS5GJ3T68ASXFXdr4TZJ1n5qHtt6GLrinfy8msTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K6Hkk8MP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yHF4zX0C; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K6Hkk8MP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yHF4zX0C"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4ACAD25401F0;
	Fri, 20 Dec 2024 14:44:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 20 Dec 2024 14:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734723887;
	 x=1734810287; bh=eoP7AntFmEPS9NxDjnc4l6eW2QrwKFZBEtIQFwDAGsg=; b=
	K6Hkk8MPsnSP5v96YdTKbwQXSRxBd5v6OckGvLDkVIR/dDrCdJrExqHkT8nNpb+E
	QilMtp+qOaUiM8Fsw1lpf/ZZmWve5rGxQnMcG5sV6C+WNSI70rtCpXOaVUc3x0Yg
	NZ/YQ3jTBOCOjBj1kCLEYv9UTSNsU8S7+QxAdVTuA05CyzcrQHrrr/qzXdNCvi/I
	l7uZCGcHlVzDAtYefcWQU6TUshgykzEkJ9tW0WNbnnNSvVMPH262kyV61mCRmnG2
	+vuY558o89HzJ/9COOKleJ9EXyacOkCe7unpaDrqs2WjB5OOBdNOPwjdGStujayl
	O9sExYZ6ZyIndzUHWucMCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734723887; x=
	1734810287; bh=eoP7AntFmEPS9NxDjnc4l6eW2QrwKFZBEtIQFwDAGsg=; b=y
	HF4zX0CA/QaSCwOm+vkeAdX988KzePH7FSqOD3Kvt8pSBH6fMwQr+8vll2E4vSjV
	G+wAsWpd/amFUDiOE+zG/2IZMMU3tnMA2OjSj0mxkLz3lrHGc+VX3FJ5eQxSFZNR
	Ag3vJABnxoY+y/Kjf4oE6rSM2l09iEW+5eD/PT5x4amzDO4IcugprvBhjJ5nogJh
	GddYqilZqfBTC7niLpFuh4+C86CZMhRs6ljiLvv3eJ8FXlV2+f8jOkqz/w+ePI2+
	E6mjzBh637szKlMrQPwEryi5fsAK/DDvNCNhaxmeLo1iGyliXM6zz4rhLxVOE2qQ
	ZPI1adT+GDb9mihvjlb+w==
X-ME-Sender: <xms:LsllZwDWf7CQz9ddAI0G4D6aE7InJQCKdG3SpfOGx2WeaQ7bCWKgMg>
    <xme:LsllZyg6qJBjnHyfFyu7KTkH6MeV0Ds8QbAD5U2R9d-D9vLjsRsQfGRhR2hITwDts
    WHWgQ-wMqNLJACSaw>
X-ME-Received: <xmr:LsllZzkLIQB0h3e_7Gdcc8bMBZjPifcMOJmrDSox47pWKpp4NETWrmaMkHPSnUK3QFJMAsf2G-1e0URPtiJ4BN4nfSkDsfhPh3lcxpUB1NgIgIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhpvggtthhrrghlsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:LsllZ2xplsk77uOwG06SVwrOP1V6zFDdkpevIdz3yy4l1PzAOa9sQA>
    <xmx:L8llZ1SvlQuFJ0MBKWdQVhuYpwHIoGIQKOdJpcMQrSB2CWdxmKmNnw>
    <xmx:L8llZxa7l2RpDiCvCPwuYNefG-qP_jlP496YXnkpFbbDbuB4t805DA>
    <xmx:L8llZ-T9lSUCzme2pQVakkP03nnRjEcdRP6E3iogMEGTgrQKHgqC0Q>
    <xmx:L8llZzPl66Nx_UvdphQ1OdsLQpCQuL-FB7uf3AvMmBa-q97jD8q9Ryej>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 14:44:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 813d257b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 19:42:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Dec 2024 20:44:21 +0100
Subject: [PATCH v3 1/6] Makefile: stop including "GIT-VERSION-FILE" in docs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-b4-pks-git-version-via-environment-v3-1-1fd79b52a5fb@pks.im>
References: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
In-Reply-To: <20241220-b4-pks-git-version-via-environment-v3-0-1fd79b52a5fb@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kyle Lippincott <spectral@google.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.14.2

We include "GIT-VERSION-FILE" in our docs Makefile, but don't actually
use the "GIT_VERSION" variable that it provides. This is a leftover from
the conversion to make "GIT-VERSION-GEN" generate version information
in-place by substituting placeholders in 4838deab65 (Makefile: refactor
GIT-VERSION-GEN to be reusable, 2024-12-06) and subsequent commits,
where all usages of the variable were removed.

Stop including the file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3392e1ce7ebc540784912476847380d9c1775ac8..44c9e9369a11a6a5091079b7221a085b2f08e6cd 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -276,13 +276,6 @@ install-pdf: pdf
 install-html: html
 	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
-../GIT-VERSION-FILE: FORCE
-	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
-
-ifneq ($(filter-out lint-docs clean,$(MAKECMDGOALS)),)
--include ../GIT-VERSION-FILE
-endif
-
 mergetools_txt = mergetools-diff.txt mergetools-merge.txt
 
 #

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

