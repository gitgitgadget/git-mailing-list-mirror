Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C693183CD1
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318293; cv=none; b=Tm9+rQyrDSPIUqmVhOESJKP6ge0/UIrpgkq61IaghxUFfnAcIhd3Z7WzZXKdeLg1jTAUwSEkFOL85TFH2JajAK/R1EpDsqks9Wdff8Cp/QNfQWKfAOW3A72ZlhrmOam+4IvoDRDlY0fGlVlimvBQ4l20fnUUmcZG/nEol/beaq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318293; c=relaxed/simple;
	bh=KGTrF1nVZqe0T4wrRT9oC8ZfdyUCevGPeGA/nLh1AOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGgmN/f29NrkUYpJYpkRFsdd66qayHZRaZnWUAhV1iHFTwvRrnWvgP0eUgiY4FOQ8SPizLxYH/VuM6PYtj0uWgv83nqAPbjyDF0icrkKrB3hM3db7balAsmt2EJXfCmEGSgvwO763FsQGRiqFrmX+MP0QgbsDDDFm5mBgUFT+R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l+FjFwS6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G5Khqy+u; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l+FjFwS6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G5Khqy+u"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id DC598138FF98;
	Thu, 22 Aug 2024 05:18:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 22 Aug 2024 05:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318290; x=1724404690; bh=/TZfNtkh/g
	qpjSQj9MHYC9i3YyUq1cTJJ2xITw17alM=; b=l+FjFwS6DR2K1H1TOErz9HRxPy
	zOGDWt9BlDpMyUFUc3k+szQMvCbgpvzo+ZAk29lHpFcwN0w3ZWljCSYx0eP+cHW4
	pdyMmU9ZwmCmnpPwMdyIp8/899ZXL6jqU1x8G/T0ePv/7ztEIZ/nOrwBUaZKzj3H
	Vt5Orke2A+cUXocY6t6mF5KFZTcdviGGm9/RcNicf1UPgJmwaoCa+tgL9jZd93dy
	+sRnFwB1yqe58m2xcBL+tCbz3YspxqQMHLZ/RsRTxLgpE8Gnkqx0an3lhwAhqR0i
	0EsT+JSnbVUcHp+6BGISHLhk5qMOD3UPPxw8FW0ouCtH1pMXW9EkreV+jzZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318290; x=1724404690; bh=/TZfNtkh/gqpjSQj9MHYC9i3YyUq
	1cTJJ2xITw17alM=; b=G5Khqy+u016k762VteNlFsT+ULBKxay099Z+QjRQ898H
	vJQpIn5dk5fKmooAwo63ScpHZMnS1UIORYUuPNxSGfj0HBm6NR0E6SluMLyAiwys
	lIYaMH8Nkpx7TVcA8kytrQmKqdYGWCX0+pgqnRH93RjTdLdXcXgGlqsy2xy2Pz7R
	ul9thsJ+p3VgMZljWu/sul7e4nZRbUG8L2TGIq6vH/wG++NrgxI6S/Sspy5vTAMu
	d3fkmJNqW4kku1aAwsIifWYyMt9azRy6QQF+6asOxIM0ykdt8mVn4+InXPc06wXc
	b4N03gF31g1Kutxd9/A/rrbQ9RdUnKcria7P3qr2TA==
X-ME-Sender: <xms:UgLHZljT9Gip4n-YUzbaRtsNxyj6r13mggm04-V4NNF99fnJgx8eqg>
    <xme:UgLHZqAoNRMBVupdsvRGwgboUPdyiEJ2wK3GgQAawlbC8E3Wi84QSE0HFNCxCGkKx
    4Q6dgGlxvf7Fv6Uhg>
X-ME-Received: <xmr:UgLHZlFkAhsSeaCjDT0XLkCVMwXOM3Lxu0KYKdoERXwbTPh4gYb_PitevG6nPv4pvjmq0oReGVamrpIxZyAxd_diAzSvD8wB0qsSw1x7l6rVPlU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:UgLHZqTotKO1TpC_Joe4wZS27c5Um2z9yUufeNR6Q_SbMlxZUAhWOA>
    <xmx:UgLHZiwqfii2l9tgdryMyJMhNCEaerHnIx2OlmgFFg5LkxNXH2G_Ag>
    <xmx:UgLHZg4ZEiGOK-f6bkSgQxU7IGBRL66UBcYLWQtZl2OfJq3om0HPcA>
    <xmx:UgLHZnzQvAYY05iPPRXjqvQHarKzb0jx2xh9VcKEyh-Xr__a2TnnQQ>
    <xmx:UgLHZt_Qm72GRO9dq5lldOgtxJbEtYsggHiACtGclzF0PSC4JwLfO_Jy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:18:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 03b96ae9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:35 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:18:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 19/20] transport: fix leaking arguments when fetching from
 bundle
Message-ID: <4c5740afe43c3bb619a9cba0c1634097c27ed33f.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

In `fetch_refs_from_bundle()` we assemble a vector of arguments to pass
to `unbundle()`, but never free it. And in theory we wouldn't have to
because `unbundle()` already knows to free the vector for us. But it
fails to do so when it exits early due to `verify_bundle()` failing.

The calling convention that the arguments are freed by the callee and
not the caller feels somewhat weird. Refactor the code such that it is
instead the responsibility of the caller to free the vector, adapting
the only two callsites where we pass extra arguments. This also fixes
the memory leak.

This memory leak gets hit in t5510, but fixing it isn't sufficient to
make the whole test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bundle.c | 2 ++
 bundle.c         | 4 +---
 transport.c      | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index d5d41a8f672..df97f399019 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -220,7 +220,9 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
 			 &extra_index_pack_args, 0) ||
 		list_bundle_refs(&header, argc, argv);
 	bundle_header_release(&header);
+
 cleanup:
+	strvec_clear(&extra_index_pack_args);
 	free(bundle_file);
 	return ret;
 }
diff --git a/bundle.c b/bundle.c
index ce164c37bc8..0f6c7a71ef1 100644
--- a/bundle.c
+++ b/bundle.c
@@ -639,10 +639,8 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	if (flags & VERIFY_BUNDLE_FSCK)
 		strvec_push(&ip.args, "--fsck-objects");
 
-	if (extra_index_pack_args) {
+	if (extra_index_pack_args)
 		strvec_pushv(&ip.args, extra_index_pack_args->v);
-		strvec_clear(extra_index_pack_args);
-	}
 
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
diff --git a/transport.c b/transport.c
index f0672fdc505..da639d3bff0 100644
--- a/transport.c
+++ b/transport.c
@@ -189,6 +189,8 @@ static int fetch_refs_from_bundle(struct transport *transport,
 		       &extra_index_pack_args,
 		       fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0);
 	transport->hash_algo = data->header.hash_algo;
+
+	strvec_clear(&extra_index_pack_args);
 	return ret;
 }
 
-- 
2.46.0.164.g477ce5ccd6.dirty

