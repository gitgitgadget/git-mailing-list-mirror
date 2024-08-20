Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17F5191F93
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162754; cv=none; b=QlhlY/oB2QE0I62pT2otedJamZyFnJnlhuJ/I7XLwZMR4oSXrgAgxQTfIEVBL7oTVoGRRMyMTGcURXwWSr6/rozt7RXTHHLaROu/PV5R7MYAlLBlovZPOT0iFQjFarTv4UsNBkmaJUYY0g8PbZc+BUJmi4jznTeWCtNp8GjOEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162754; c=relaxed/simple;
	bh=4YaLenxutTXDO0GCcmYYXKk6xmPIl3FeLf+uCZ1skqs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFrpgEbz004vuRY4SXdliB01uDY2y/yI3TRs0RvKSfoMA9ESYeadC8nWBK4VUyYvEPqpsKQ8Jo5to/TJKbiHqsCUAJ4dhHSryl6vbyNKN98hf/EoOc6ojNhu03ZcqLIc4JhGCEZz9YC9QUpqadd+PkO3B47neajw4BAH34ftpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xig7HsoZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o2+wDXha; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xig7HsoZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o2+wDXha"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EDBB21151A9D
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Aug 2024 10:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162751; x=1724249151; bh=7UCTuFodKX
	kWAuhrHXXY0naJs4oghahZmaAFfSNs6QM=; b=Xig7HsoZJD5Gkak8LHLk2FWZ+x
	ewCkq5STbmO+iNCZmQV56JyfjhyirhYXARbt9TOLsWf1+shtx61QqCU0sUG8P8/v
	15hzwasphu5bomfjPNxtBcQbyZp3P0CMm2Gafel4mJRZ0jZpVQ2dfc1gIHRCPLBj
	4+FAw2nETDvNHMV1J6e3aScwAXziEDkpS5bC8xJqLTQJ0eUJtRv0c47wHxKhChCq
	EzDnooZW0IlfpJG5Nh0aWEhqBnV69lkBUsz4HVWcnoNi05YZM0OdJHCxWzCA2AuA
	0lWVUJk7YsnGf40zzfSHfh2ho8nx2G0VqmiNzCEqAdoLk0do2tO4S4OqgBkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162751; x=1724249151; bh=7UCTuFodKXkWAuhrHXXY0naJs4og
	hahZmaAFfSNs6QM=; b=o2+wDXhaw5QaSwfwovZcF3jOOyib2n+o3tYfw4oFO+us
	h/aFuj3hdAtB/tfxAdcy/WRYKGvaEa5nyge1i0UURqFGtPWaY8iRTRREMjs862iH
	T4g/kFcb0m9zzY3DVfRqBSv/LtPszacepFBOuCeiU5oQ+Zag/GYbdgHCWVv6V4v7
	6fGl7vIBsQiXgNNWGVAbSNOcJcDMu3n9g4gz6nFX12gvJeLb2lWvmz0DF2PfjfNA
	Gg6T916YV3Htdv5xoopTkJ2Q9gyqB0LCJFzM8DxcjgcLEsFTCx81XaLCCz0EHm/R
	iyjqb/z8LQJEJy2AewlIpjvE87cTfecNcLx8NY1nWQ==
X-ME-Sender: <xms:v6LEZnmuYEIt1KSj3PG_n-747P-5QqLkZfWgkMPNTXnXLlJZri1kUQ>
    <xme:v6LEZq0bbS28packAQD2-oD5XHMKXc7E8Q65vfrE2lviZPHkOrq6Is1_YBOH7CvN5
    qylfZp2TMZaowqCzA>
X-ME-Received: <xmr:v6LEZtqOLt-gNEN9rerchSgnhO92orBYGdioHPlgufdXmB5BGmHHCeKlG6vtr570zKnsqb5pCNawschGBhAdmzPB4_XGLRs0kE2bwo8pxcWqdOLnaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepkeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:v6LEZvkaBt3LL6BGSjIYVGWU7A38nY1Ct0qNvuWgsfXNlhj5tTdb5w>
    <xmx:v6LEZl32pJ8LkptYju8vesjzSX2ZPLQbCn0BSISDvw_gjDgrS3nZ4Q>
    <xmx:v6LEZusPN3MiMzhVyxJ8e_Ph8eoeN8Lrqc5lYI6AXUYhLSUUrm_s-A>
    <xmx:v6LEZpV6AHCub5JVRJJpcNmTXZrhuWL9NtOZrdUvtCa8uq057qdF5w>
    <xmx:v6LEZm8s3vDUWtQLEgenQPZoA8l831hGO8SRVAVDIA--bJ9BOi6KAWve>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b04fdac8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:05:20 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 16/20] remote: fix leaks when matching refspecs
Message-ID: <e1d0be37636a1ec46b4fe52613582ba71a47868b.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

In `match_explicit()`, we try to match a source ref with a destination
ref according to a refspec item. This matching sometimes requires us to
allocate a new source spec so that it looks like we expect. And while we
in some end up assigning this allocated ref as `peer_ref`, which hands
over ownership of it to the caller, in other cases we don't. We neither
free it though, causing a memory leak.

Fix the leak by creating a common exit path where we can easily free the
source ref in case it is allocated and hasn't been handed over to the
caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c          | 43 +++++++++++++++++++++++++++++--------------
 t/t5505-remote.sh |  1 +
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/remote.c b/remote.c
index 3087437bc61..892a47086db 100644
--- a/remote.c
+++ b/remote.c
@@ -1325,18 +1325,21 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
 			  struct refspec_item *rs)
 {
-	struct ref *matched_src, *matched_dst;
-	int allocated_src;
+	struct ref *matched_src = NULL, *matched_dst = NULL;
+	int allocated_src = 0, ret;
 
 	const char *dst_value = rs->dst;
 	char *dst_guess;
 
-	if (rs->pattern || rs->matching || rs->negative)
-		return 0;
+	if (rs->pattern || rs->matching || rs->negative) {
+		ret = 0;
+		goto out;
+	}
 
-	matched_src = matched_dst = NULL;
-	if (match_explicit_lhs(src, rs, &matched_src, &allocated_src) < 0)
-		return -1;
+	if (match_explicit_lhs(src, rs, &matched_src, &allocated_src) < 0) {
+		ret = -1;
+		goto out;
+	}
 
 	if (!dst_value) {
 		int flag;
@@ -1375,18 +1378,30 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		      dst_value);
 		break;
 	}
-	if (!matched_dst)
-		return -1;
-	if (matched_dst->peer_ref)
-		return error(_("dst ref %s receives from more than one src"),
-			     matched_dst->name);
-	else {
+
+	if (!matched_dst) {
+		ret = -1;
+		goto out;
+	}
+
+	if (matched_dst->peer_ref) {
+		ret = error(_("dst ref %s receives from more than one src"),
+			    matched_dst->name);
+		goto out;
+	} else {
 		matched_dst->peer_ref = allocated_src ?
 					matched_src :
 					copy_ref(matched_src);
 		matched_dst->force = rs->force;
+		matched_src = NULL;
 	}
-	return 0;
+
+	ret = 0;
+
+out:
+	if (allocated_src)
+		free_one_ref(matched_src);
+	return ret;
 }
 
 static int match_explicit_refs(struct ref *src, struct ref *dst,
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 08424e878e1..532035933f3 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -2,6 +2,7 @@
 
 test_description='git remote porcelain-ish'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_repository () {
-- 
2.46.0.164.g477ce5ccd6.dirty

