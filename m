Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3C19341E
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422380; cv=none; b=oSmfRgzxIeFcZjGwtDrUjcXxsEeNoT+QUsjQREn606LuPAoqhg/OXDST9SEh33mVPY1Za1pKDnufd7IwMqFBSSDormYd7zMMrnm89YgxLR79wyqjtR4FyWHd1kkmnGez68Zy4Ocs0axzWCv14Gkm9HTOPeXclBWPHIeyHMvTe1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422380; c=relaxed/simple;
	bh=GardCaz1qqT1M8dmGQdW9t3ITLT/nprLJBrpkEANDDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pCpfJtfJiWaAp9hFuIiYRkvl2ljb7mRw0D+ivK2tRINxArEery8pGt6X0sVU+H4QV2WBXRNdcQ49nasZNMeNlmiGlCZufvUW3xofMydnlnPFZLNs6SBXMTBoMnjqJv23c029rchkb0o5z2NUxfHOp7XoG5RO+N6fjCKVUHPw1S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=boxqjA03; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A0JOaiyt; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="boxqjA03";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A0JOaiyt"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 08C2D11519ED;
	Fri, 23 Aug 2024 10:12:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 23 Aug 2024 10:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724422377; x=1724508777; bh=ELGASH7j6G
	b3d9xdzj01RfwRwbVPQlcS6jkM0X3Wqvw=; b=boxqjA03Dj5jk0iqeoJcV1tc8M
	4sWfG3fBM0I+/wBUrJRAkAFo2HKJSlWf7ggk8JHodc7Hl/U/28wCPM7znYNWebl8
	WYADSqV91tEjZD4Q7dsJygU2LYh3/SNG03nopChYQf+Kt59flSZmKeo1agxtc5H8
	HSgTSU+T54ppLIInapCknRWg+Mg39kaOTSMa6/oyWrKp5qwCyOJPZVPnLkpuGdPE
	+lN3hEBLLPe5g98jpeGkURI99iOKKrCcMAweJnPYyPkNVF+xfaiqDMGo6gB9x5uS
	Ctl6VtiKFWhbzAr1UJf6LZ1v0h5z8UVUxPRnWyZtX0tscvuOWehsXPWLZTkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724422377; x=1724508777; bh=ELGASH7j6Gb3d9xdzj01RfwRwbVP
	QlcS6jkM0X3Wqvw=; b=A0JOaiytokpvNdYMnIoBDaYp1acwSBcRfJGGywVGE3Qi
	9FWghyfpa9g52NdYsoCmqNvy1P4+8EaOpA7WZt8o5sh18NC6VWFsFRr2bfNfWZh3
	+Wj+08cF0ES0Bu2Of4lNuyCfXhjlDWJQ7SHgb+z5GUkj6fa7VxO6dRsJnVWVG4rM
	zppNajkW4ylva9lbpxaB6UE+7i2BAaM7jkyMYG8XPhT9j8+Ne68Hl5sUeiqYIPAM
	UJ28gmBJSPcj5F5UPq1ci+Y4l9YIPWWB50302tzBb54SMqtgMvagBMG/1dKj1BmK
	Kij+MZPeBSeJnELwyiH737Nic8yYgt/3Ie7YX/DJLg==
X-ME-Sender: <xms:6JjIZjiL2TNFw8IibPiuNn6kcV-uRPVLFc5FIxKhjjHV2_P3bZU--Q>
    <xme:6JjIZgCzSrabjSsfyXcJNqiznDkhLUx20z1-zK_p1tvnccPOy0dq5NQFG9eFBG-Zh
    qnJyCIqkOwSNWSonQ>
X-ME-Received: <xmr:6JjIZjGPALbpRVUsy2ePgoSDtw1iRonBm5AjNaZMTb06xh3sb-YRCxsRzJtbg3o4UB9Hycglx2tDJ4qWtpG09gBFypG96NxGUNHtxxowEu2YZLaoQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvght
X-ME-Proxy: <xmx:6JjIZgRq8sJPc7ENFnv1iKjLRw4VwDYPiyvoGrwJY0eHVNu_VcNOMQ>
    <xmx:6JjIZgyAajx5zqDIVFaGbbSQLLWP-_LT6rJ14ermh1Xeg8IdUsYzLw>
    <xmx:6JjIZm7pWVy1itddipuyImVWw33GQXgiGIsqCpr109GvlA_HRL3UTA>
    <xmx:6JjIZlzJBiKateVohGqdM-Y_6VRdiSf1bC8AnFHJ6a7GdRl0p8eTUg>
    <xmx:6ZjIZqunLS0NGlTSdTisqSbAVgOcfD9Kb7c0QQS56mMNPZEvXF62pf4M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Aug 2024 10:12:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ce018738 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Aug 2024 14:12:18 +0000 (UTC)
Date: Fri, 23 Aug 2024 16:12:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, karthik nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/10] reftable/stack: reorder swapping in the reloaded
 stack contents
Message-ID: <5aee91de25e5bd5198fef307549b58bb4625161f.1724420744.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
 <cover.1724420744.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724420744.git.ps@pks.im>

The code flow of how we swap in the reloaded stack contents is somewhat
convoluted because we switch back and forth between swapping in
different parts of the stack.

Reorder the code to simplify it. We now first close and unlink the old
tables which do not get reused before we update the stack to point to
the new stack.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 8e85f8b4d99..02472222589 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -273,30 +273,34 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 	if (err < 0)
 		goto done;
 
-	st->readers_len = new_readers_len;
-	if (st->merged)
-		reftable_merged_table_free(st->merged);
-	if (st->readers) {
-		reftable_free(st->readers);
-	}
-	st->readers = new_readers;
-	new_readers = NULL;
-	new_readers_len = 0;
-
-	new_merged->suppress_deletions = 1;
-	st->merged = new_merged;
+	/*
+	 * Close the old, non-reused readers and proactively try to unlink
+	 * them. This is done for systems like Windows, where the underlying
+	 * file of such an open reader wouldn't have been possible to be
+	 * unlinked by the compacting process.
+	 */
 	for (i = 0; i < cur_len; i++) {
 		if (cur[i]) {
 			const char *name = reader_name(cur[i]);
 			stack_filename(&table_path, st, name);
-
 			reftable_reader_decref(cur[i]);
-
-			/* On Windows, can only unlink after closing. */
 			unlink(table_path.buf);
 		}
 	}
 
+	/* Update the stack to point to the new tables. */
+	if (st->merged)
+		reftable_merged_table_free(st->merged);
+	new_merged->suppress_deletions = 1;
+	st->merged = new_merged;
+
+	if (st->readers)
+		reftable_free(st->readers);
+	st->readers = new_readers;
+	st->readers_len = new_readers_len;
+	new_readers = NULL;
+	new_readers_len = 0;
+
 done:
 	for (i = 0; i < new_readers_len; i++)
 		reftable_reader_decref(new_readers[i]);
-- 
2.46.0.164.g477ce5ccd6.dirty

