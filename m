Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6235E1386BF
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793778; cv=none; b=DYZ8Ulph9zgRv4p/IQjpVms+rRp/n6+mGd/qR2bdXLY4kMDa6RrmfPakhp2dMbi8Qzu8aFtzCDzdeXAOFi33JynBZgfYt6DIxJSySFnA74e50TCsBXBq7Aj8ZRSsrd8O4kFj/SrFD3C2LB0rpNjlcHM49TnNQswh2uTmH+0OjLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793778; c=relaxed/simple;
	bh=QUfVicw0PIhBaOd4v4o0G0egL9SKzKHY7qJuj337zsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tU2fGz0gKtEpJVVrK3uIRRpMgOzWGsdg8wY39TK4n0Esuvxc3NmQ9yUDCZjEie1glafZxjtTbWz6MuLcuYlvCeVyKe1SiRisVTmf/NqK8O9z/dTPO+RxwMOJv2uX1WJdIY9UUDTG1cBJf92uveg2HZwj7EEkKS6OCL2k/D8bOhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pE7i5BM7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XV0zhxEm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pE7i5BM7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XV0zhxEm"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7DC69138C92C;
	Fri, 16 Aug 2024 03:04:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 03:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723791886; x=1723878286; bh=qR+S9S13TB
	//xUp6XJigqCj5mklobo+Hv6D0rts6nOg=; b=pE7i5BM7HaUks3Xzpraqh5x78a
	AHR+Hpa9nmJmxO2SrAXMyQvLkwBZa79+noYz196l01ksH+7su9BiKScEJRSqHyA9
	/h5ZnTtKqpJRQqh5aU8x8JduQLYy9Wvxj3AyLOKSu/Jm3YhV0Hvc8/9IxJKTa8lK
	MFkclmaPZWTheikdV+vWLX3xCPcJRqsD1DCamfykX1CRp5hZrs8hWNbQ+EoK7UhG
	igwOrQ45GA58jT3SiBmIX2Kf4/DOiyEWkiolZrLADfHSlB1VgqkF7AKoVOj3lxET
	CSvshpqLU3Yff8bmR9q9ZH+wDvjBWvBmYY80HR4qqAfOBsQn1pnY+GvxFIbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723791886; x=1723878286; bh=qR+S9S13TB//xUp6XJigqCj5mklo
	bo+Hv6D0rts6nOg=; b=XV0zhxEmRkUeckM4C9bhvUi9iiIi9tPJLLiOEcPSK5cC
	u6xaXMYFmf+Ik2FyQVpCczMBpy+4jiZl1Si6EWWW7CZDMYfI5s7/L6fYMiDCD+n8
	bcC4ZIEr76Z6DcNlEAttm/9EUZekbU0pRpW46IOLBJzI757zFa2cOHVUCzXkRf73
	o9+HYHsnjFWvhd9yp0eFO/El+Pfk+uZxgoGx3fZKjZrBS9/YVku6qUfNhm3kPG/x
	+h+2JmFNou5iAx+GlTLYD+rth3W1dilpODOYE5gucs5znbhkkZZYS4slLyzN9UvT
	8WbLIrbUGWJExHUv2dCe9VHGjH8vgqgCgeynWCHing==
X-ME-Sender: <xms:Dvq-ZhLG1W4S7TLCrlTBac5QCT4LXAbt6hmawrPOsOQJlH4qqAJloA>
    <xme:Dvq-ZtKdh71sM1RYH0eJX1w2rQ3gwmm_8goXrBlk39Aj6btwcXTaxoGlDTmtcGoxu
    d7Z55YfBdoBH7IbtQ>
X-ME-Received: <xmr:Dvq-Zps2gRstn9BYTyHhkmg0k-5ELQlOroLoAoMtSdQVElP3NaM7xJBCSfFLVq8TAU-WuFLwfhacuzY2Mt0ePifVceN7PAXPsvXZSfpLAJbCB_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfg
    heetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplh
    drshdrrhesfigvsgdruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhn
    vghlmhdrohhrghdruhhkpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthh
    homhhsohhnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtth
    hopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhpvggtthhr
    rghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:Dvq-Zibu2tJVM3Ps_k0CXcQdmROTcJY92Vr8WkQ3f3TGr_dLfOQt1Q>
    <xmx:Dvq-ZoZOeTTYUfS6iEUAOUV1iF_VvsriXhkN3vbws-lscuOMtzl-QA>
    <xmx:Dvq-ZmBvoWx9SjNjG-bJ2JcTatzJ9UoyAc6S3DpvXIkxB0BSNH-lBw>
    <xmx:Dvq-ZmY96qlBFMXPm4xfA-EH0eDDT7RLbD8RBqpPsNEt9zIyM74CJQ>
    <xmx:Dvq-ZuP7JhSqmvxrzHNn6xqe08PMSsl3YTHKYuq8YY5aLk-4nnL22eqv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 03:04:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a144a918 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 07:04:21 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:04:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v5 3/9] t/clar: fix compatibility with NonStop
Message-ID: <db53673294e6b1aee7e095eb57b571b9e17e5757.1723791831.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723791831.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723791831.git.ps@pks.im>

The NonStop platform does not have `mkdtemp()` available, which we rely
on in `build_sandbox_path()`. Fix this issue by using `mktemp()` and
`mkdir()` instead on this platform.

This has been cherry-picked from the upstream pull request at [1].

[1]: https://github.com/clar-test/clar/pull/96

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/unit-tests/clar/clar/sandbox.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/unit-tests/clar/clar/sandbox.h b/t/unit-tests/clar/clar/sandbox.h
index 7c177f3525..e25057b7c4 100644
--- a/t/unit-tests/clar/clar/sandbox.h
+++ b/t/unit-tests/clar/clar/sandbox.h
@@ -120,6 +120,12 @@ static int build_sandbox_path(void)
 	if (_mktemp(_clar_path) == NULL)
 		return -1;
 
+	if (mkdir(_clar_path, 0700) != 0)
+		return -1;
+#elif defined(__TANDEM)
+	if (mktemp(_clar_path) == NULL)
+		return -1;
+
 	if (mkdir(_clar_path, 0700) != 0)
 		return -1;
 #elif defined(_WIN32)
-- 
2.46.0.46.g406f326d27.dirty

