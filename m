Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28D41A01B7
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775752; cv=none; b=KuM9VCtjMA1gLQ2jl7avVPlxInwow06KFk/fkF44cnaDZIn4itEEZbgDJQPujmFYAGWo6uPy9uJCRKXPed4YZrlEjJobOFe8VOdt7MiPS/mSCsEuTWxH1S186rYx972lC53KymH1LEopD2j27VlXOC8uklhONsjLiR6bDOatva4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775752; c=relaxed/simple;
	bh=rCPp3mmeI9gScA9HsXOPA2dfgstO2NnDkNHyDkLDeu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vso91o4TB85gF3h15yovLoLR/Td/qMXSeVceqeLJU1wn/t/hJtcvHPlVabLWpeDWnQYd4YO+CzsKM++WxhDNpXHnKMqbVX21PSG9jfUdbInN8JQPz+EIF2nyp/gpcAKyxYG0Vov6wW0rn5a7v9j/5x68Cjd7id1S3LOVh35QtIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fV8Nag88; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eTUGTi+f; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fV8Nag88";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eTUGTi+f"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A2A81140EDC;
	Tue,  1 Oct 2024 05:42:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 01 Oct 2024 05:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775750; x=1727862150; bh=wm7DXu2+fV
	PTxnBAEUkleoF1q3gPUSwhWEs6ZpuxEHA=; b=fV8Nag88uCT9EPnIwGHk6NycDL
	Wc4QYoq/wUXcps66bpd8gT7+YEOKOnO+ZLF9RPKR+nbRvIhVxck3Err6ol2ke/Tk
	3MtQIVAac74mqioA0vT91EB7W/T0W7b/Ydbz7pZ+7wzYeJCCqbmhqgQQVweX8CN8
	QWtSP2qBZMMf+eSPw4QARAS5qc03MDvUPpZ9vwtmySfVRwwNYeLrsiSu5hpYAgNk
	r4dPGQ8kJEN8DWfEwwUTtLgUMY6ttX8xhlsZvBvVMPvy6meXL6XQNQN1ImISSFbw
	pVSF+AiOjBrPYyU/QrXd4WA/EjOSmXNi8Arxtgh/kBzIyi/JdPexMbfGeJrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775750; x=1727862150; bh=wm7DXu2+fVPTxnBAEUkleoF1q3gP
	USwhWEs6ZpuxEHA=; b=eTUGTi+fATYGDvLoeyHoAkOZBnHnAmSClH3DgNtY4eUI
	AINCXcU6pHP3dZvCKHMPL1j2QSQuL/8QNSM9rxNiyLdYU4o1qrUkamPpoxEnkjra
	6DxB/y4mcoJje7wP1QUabSC41s1V7+CAwo2ib+pgv5ZjEvQedX0bEkVz9uvWMRj6
	oWQP3PnfKCEVR+OPLXEH2herSiRZ7TVxXM14YyO0JV3oMEA3w5GkolnQcUkDxk5N
	b5TI3KhQRe9puvvixQuRYfEHVCYfobxgMc4wXKTiv2Aie87X4gU8OFHdbowsCPc2
	Nn7BmKk/h+NrmhiVgEQMBml9A7hBuT02qI4Lsob+Fw==
X-ME-Sender: <xms:BcT7Zhg3oSaA6Dt5XrDPLQeY8jN5OU_d1llYR-GXW1sDwAVXfodL-Q>
    <xme:BcT7ZmAhOiy9NEPrDoThRVi15N8b0b41rnqXUAN3iJK9tuFR4skCVOJsqfSp_o3Vv
    Y5QHRKLL-cHz6gEVg>
X-ME-Received: <xmr:BcT7ZhHOnAo2j_2Cmn_L7_ejeRQq5m7xbkjr02kZea28vPH3MiS2mQfwri9dONLLgj3KdAY5ZbqU6eptf7oX2choPbNAMwJAQSWv7Ik_o2xFDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhm
X-ME-Proxy: <xmx:BcT7ZmRvdmBOrAgJQCwnHPN5s0zeJhvUi3Hw3GVnr7PpAzf8SMWflg>
    <xmx:BsT7ZuwJ9R6lWk7yxQT7Gbf_LBLHQDrhkEe6J2DHru-vychWBHbV8Q>
    <xmx:BsT7Zs7dtaMeZA42rBCh1c3pX3lOAOfPktyqwH9qC5TFmomqjUc_OQ>
    <xmx:BsT7ZjwWPKodL_YrvXMCR1qkk5q9SDlYSwrW4mPBWZLwzACIh-7qxg>
    <xmx:BsT7ZouwKxN87VOss-cl7WJRv-avEjxi1JSMdn71nLhwtcv5ITLlz_pV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 765cf786 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:41 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 14/25] reftable/stack: handle allocation failures in
 `reftable_new_stack()`
Message-ID: <40d4d81378dbeffa0a916aca7d747ee9a045e045.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

Handle allocation failures in `reftable_new_stack()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 060b2c1b90..1b77c9d014 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -56,10 +56,16 @@ static int reftable_fd_flush(void *arg)
 int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 		       const struct reftable_write_options *_opts)
 {
-	struct reftable_stack *p = reftable_calloc(1, sizeof(*p));
 	struct strbuf list_file_name = STRBUF_INIT;
-	struct reftable_write_options opts = {0};
-	int err = 0;
+	struct reftable_write_options opts = { 0 };
+	struct reftable_stack *p;
+	int err;
+
+	p = reftable_calloc(1, sizeof(*p));
+	if (!p) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
 
 	if (_opts)
 		opts = *_opts;
@@ -74,15 +80,23 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 	p->list_file = strbuf_detach(&list_file_name, NULL);
 	p->list_fd = -1;
-	p->reftable_dir = xstrdup(dir);
 	p->opts = opts;
+	p->reftable_dir = reftable_strdup(dir);
+	if (!p->reftable_dir) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
 
 	err = reftable_stack_reload_maybe_reuse(p, 1);
-	if (err < 0) {
+	if (err < 0)
+		goto out;
+
+	*dest = p;
+	err = 0;
+
+out:
+	if (err < 0)
 		reftable_stack_destroy(p);
-	} else {
-		*dest = p;
-	}
 	return err;
 }
 
@@ -171,6 +185,10 @@ void reftable_stack_destroy(struct reftable_stack *st)
 {
 	char **names = NULL;
 	int err = 0;
+
+	if (!st)
+		return;
+
 	if (st->merged) {
 		reftable_merged_table_free(st->merged);
 		st->merged = NULL;
-- 
2.47.0.rc0.dirty

