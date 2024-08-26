Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA512CDAE
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656927; cv=none; b=Z0YCOUmdjAp2hd12mfD6FSOEVfqDtNCZCX3ViOiD8lDJQ168+wtPfHM3VY97TeIyu50Lxn8W+qMQi5pu6npLpRrSyGM3OCAR+TMXgVaF0HnRPnYR/TBiH7jt0ybdEVMspZNb13h1DzSxOF5+fs31L2AwidYg280jAxq+Jd/60AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656927; c=relaxed/simple;
	bh=Ca7thyUXzijwfi+NzbAmTeywsRF2LlZEKoZ/IloDLkc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OdcOjej9eclMBewGD2zLE44P4CKIptV1QA3yTsdTC0VRq31r2DD28zb1hzD8dg7CniSsshXtr2b+9SgNFVKe/qPHQ8o6CRIi/Lkk7tr1tWOUuG6bBEXgwHbQ7ypyhdQ9wReD6VC0+DF1wlzXsadzWIdMcrnBS5WZVvFG6S9egUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dpyFvZUC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQpK8BUG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dpyFvZUC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQpK8BUG"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B5C4A1151ABE
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 26 Aug 2024 03:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656924; x=1724743324; bh=QLVaLWWRXD
	aVNnn9Q2AtRWqly7JD5co678AA+ifWH58=; b=dpyFvZUCNkHcqXwViEMGQKnE6m
	4edo8tHDCWElLkgiBA41RKEWDlnXbY8QscwSGW0zQfP6LnKQsQx+PpLKb4Ng6LoO
	AkaGvtOqLy35mPzzmvysEJL+vzK5ax1i/ahmJdsLnBNK1keqdHSqGtq96L609uqh
	/5PiweBkKWOBWyECGV6PMC+CYuMO6qKm9Lj6oEksWb1rBkSh98TyPm1Bu15sfwzl
	g+rMOPvTM06RcuO7ieb28hDNigodK4QM1Z6lMM/58hPD5SonGZLtxi68dyITKz+l
	TI9eIymkqgE/nERIQFZoOzA+r2QGp6aFdU72J6Ou8JruzTLcp1w1kpyeDoAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656924; x=1724743324; bh=QLVaLWWRXDaVNnn9Q2AtRWqly7JD
	5co678AA+ifWH58=; b=MQpK8BUGFJR9wr/4r1ElgSWkig4NmIiYlY3hiEyuNLvz
	0nJ4NeVLYktlON3vOwJJUv0FUZYFfhWEdGvaqBGSAIxDv31GynS6v1sJLadY4QOX
	zr0KHo8TIkMEyJSCxZNi5T2ZUjFSo2QzkR1boxFVRIEPmvqSi/iIsHgbqkFtgWui
	HthtFUrhBe2zfzT7sz81cXl2IqdxcXcRbxganTjGEmuOYHDEIBLAbAqRcO2zQAfa
	EIa1IZy8RFCTHk1Gc+B74anx2+ucVAsAPzuQuPLbevuZwpbv2c78l4i4I53HCv4/
	e1/cDH34suIsCj/fJHAo1zd96cWd6dOJAjryfz21cg==
X-ME-Sender: <xms:HC3MZuMBh9CB9pTPqzS1jiFec3I5AJouPjewvAnzoG9nyR6S4jM4mw>
    <xme:HC3MZs_bZ_Qut2PYvhGuq0amkZHdik--ZX7ljDGFVliyx7pU0h32mNjUZv-g_ZSmh
    Yaa803ZGq97bKPN8g>
X-ME-Received: <xmr:HC3MZlTp6HtYb8YZpPO9Gj2jjNFmtgQG7YIbiy1g3F2b5e9PVFP0xlwobhtlQ0tZ0MxQXyQkPKlwBjzBAYe20Zq7ss3ZUwxEA_AlvG5WLQjk7wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HC3MZus8IDp2N9g_zbjwviMW4LMbBJPppM42jmBRR4TmFZbAinLIJw>
    <xmx:HC3MZmfWXOVnJ4wz9WZKOJ-52XRhaEjv7r97qfR9mNAJcIkcVCBrcQ>
    <xmx:HC3MZi1wAoutCTKRDRphp_h0JW2TsJL9dcY3djZCoYdfWvoZM_kR4Q>
    <xmx:HC3MZq_C60IWsC6JGVkJqP66cBx9UIGS-HxFK7t-BqjcEaB8dnP1Kw>
    <xmx:HC3MZqHaS2I9nlYf06f3QT_LHGTnz_zpQ00SMjqXns_mrB6QK87EeSjX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id feaaee24 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:01 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:21:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/22] remote: fix leak in reachability check of a
 remote-tracking ref
Message-ID: <1446e42f0bab9b31768305283d51b0f6d1df9b48.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

In `check_if_includes_upstream()` we retrieve the local ref
corresponding to a remote-tracking ref we want to check reachability
for. We never free that local ref and thus cause a memory leak. Fix
this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c            | 1 +
 t/t5533-push-cas.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/remote.c b/remote.c
index 240311619ab..bff54046b2c 100644
--- a/remote.c
+++ b/remote.c
@@ -2774,6 +2774,7 @@ static void check_if_includes_upstream(struct ref *remote)
 
 	if (is_reachable_in_reflog(local->name, remote) <= 0)
 		remote->unreachable = 1;
+	free_one_ref(local);
 }
 
 static void apply_cas(struct push_cas_option *cas,
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index cba26a872dd..6365d99777e 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -5,6 +5,7 @@ test_description='compare & swap push force/delete safety'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_srcdst_basic () {
-- 
2.46.0.164.g477ce5ccd6.dirty

