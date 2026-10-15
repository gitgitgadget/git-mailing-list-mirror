Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0837106E
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042086; cv=none; b=llgDGe6O7VrAWLQrUoMhfVFWnWUNR26oaHzeheVBBGztwNIqpxHMFbqgq+kLzqQQKZXt4j+a49yQnRrS64CyunbBn8Xz3m5sFOEvogPLGXoRvtxm4MJQs/mlD9gLUffd7kQ8xq3fGAyaInf7EJiYsZIr40Gkmk04GiFr5cnnThM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042086; c=relaxed/simple;
	bh=julKVejhJNeH9GgFFEjtcdcehUo/uCjdcS39lPrdUEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XyglXNLudP8GgiAT1nStIhXByv+DwyX3ykLaWx+GlBXLxKNzhBk8DGrk0ySQlboDGQp3ejHPweugxOv5FmEVY2SdYnGZYcvVwT7/XKIrAYjinchRlRvm4f6dEQYXRNcnz9aBT4wNTI6Xi7bdrYA5Eqr5EMoIdbBCSjf/xP/VBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qW0q+0WJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ct3B73Eu; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qW0q+0WJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ct3B73Eu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 02B417A018F
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:28:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 01:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792042083;
	 x=1792128483; bh=014gMUuIWCZCKDGIJHk/Y7exXH2dOJ9AJWJbcmvmbPA=; b=
	qW0q+0WJ/PG4XWBkCZG9s5VAvSDLyexUqIwzoOGExEERJUoZVvkjy7G5pnuQYYtK
	4HyU4fkZXlJwsXACxULiUzG3bRKxviltTHR39OEjjzo5LlzxsReTVsOvnFIW+3m5
	zIAcIElIrQVmrmo5kCscWFL9LfD+gLmNdX8lCCcpizvYqne7KgZNjxlirexC1g7m
	QUgdByRj9FrX37M6jv8Ts3xy3LXUSGoGFzLQUjetnl+DSNEaNFCI6z5IFU09Q8Cu
	CxopKfuew904LCGZW1AI1iwtkyn4HRWMzKZ3FTJSvaHH2Wo20RDvyGFA71niC7pT
	ybOxFoslHQbTgbj8X/Ai+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792042083; x=
	1792128483; bh=014gMUuIWCZCKDGIJHk/Y7exXH2dOJ9AJWJbcmvmbPA=; b=C
	t3B73EuvOn1lSqykWBWUt/5cVy49cxvgfhua0g4H5DSQHDYpIlqMC1222gSgdi5Y
	BV0St6028dGemPijIq4v747u6IAnrYaZ+absv0FLNCRjMAIecMQhk7txaJk2MTZt
	iFIn6r2vX6z4kpKAXBknlRLDh7r2I7r+org70tFZWcu1GaPJAlzdlu1HpDAvuVD6
	oVpXqijPcA+r/NOa5H0NksL6BhWdZq16KBHIoR7FGrGW8hNtpjGuVzsGSj2s12lN
	MH5yEKnasDeQX7PwxVdm/3BW+V692+IPmqXIWhAlHA3nAUPDlkfLOlxZbSg61RiJ
	ksGIc8fSc+i73KH57V70g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792042083; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:T+aCzUtaVQnJ4LKGotjZKkmPsiyqBAPGazbZf2uoXN0bxUD
	+4ropZNKcDkXpka4nYvdD3sJ+H8AMsu+rpI8vkBHHseX4y1KBahiQ8CfCSYMiyA1
	5RHVvBqwJ0bMNq49eoUwkuTwm/d2xV69x+Euk9Z1qd2dH7y/PFXnyOGsFslhGa+O
	H5DWqS6Y/BO6Rc2w3dlcpEqOOxUwb/b0lZBOjd70XiOulJ1QxcD0OZ3OasiH4ib8
	uplnvKrGCThKTI0yIK0xfFRYAEns5Hst6jSFk98nBObcFSbrEFVwgvZr+nD+z9wI
	/DoHWHf2DIZoox1tFSXkokcfB31UjLjmzDuXAmA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GpOKIZifefuU8hj4r+wVP4v3AY9n/KLsdtc5cYBhGpI=:julKVejhJNeH9GgFFEjtcdcehUo/uCjdcS39lPrdUEY=;
X-ME-Sender: <xms:Y2TQajXTjivTzYGY0taOreiDwjw2CmXxmocLv0wP6X04Qg5nuKS5aw>
    <xme:Y2TQaidymqO64LUwSG009nHfHLDg5eXgCan6au2yRPgkLxnfDe0WZnT_2ZNnpVG16
    dKtrt2natFVsgPVFYQK8sc0SP7Mpb0Q_V7vS5IRjQMJG2MNjmEFI8A>
X-ME-Received: <xmr:Y2TQans3WBxX4wjjsMyOYEsb-9F1FFK4WKg0YjfQfPKiyHGCq3ISl1ciPPZ2GheU8kemQ2c>
X-ME-Proxy-Cause: dmFkZTGkGpJMBDCcG1wr+ofrkMvFu+2RZTSURrsHByrPfxcbwmNyWc/T4TvIKWSEaOUkYJ
    NLZUiVHcH9kaOktKxVBuELpghAE67RNhhOHGIIA7ihiG3swv46WzYRJ4aRs2IS3IgFMlia
    N/8vp6Z2BBlleCQcVQu669Y2GliZrRB4vx+y9ktr25/fg8dRAY2fMvfBcui1Qa32Us+R4w
    GwrSoE8thnfej94qujoBDM1sETyGznDUzsUKV4dDiKb8zDjPZK1/X7hpqcrJab+iiYuN1n
    /sLadIbtsv29dCQZDCKwiVus/Yjf/PsxS1Ty0BSTMDDirLXlPxrRlKzDBebbvO/T21q3q8
    3mRyuJdNMtvKZ952lHr+zjbhPiwu5ST185A6YJ+/wYHXgSH6UYfF9K6Mc1jMt6MyeUWpHy
    nhiBGIfmfy65Zzui8GD4oQHGSiX+GCM3HkdqYBj8wIeV6QFb1YbJPOj5baAf/ex7oMv0mM
    oiDlWXtnXYpI2RLffWZKXu1+4+696fro9xnCXWg9plJgcb/tYvhzyTaGKdUeislPn59NOr
    aZO5bgvVNV0ljztT22ezVN4kPiPDtZO+0xuOhDvI0/ke+3cd0rpo7dnyxpmm7ECj2s786I
    8Fmc8A1WHRpHnJ3Ku4IxKK0YmWjzB2/eodscE6kTYF4efxBJaxTe4XViMegA
X-ME-Proxy: <xmx:Y2TQap9LbahvkgRdaUOhpeGydQyGUVM2TuTyRWtyMM8fn3Jx5lJthA>
    <xmx:Y2TQaq3JI7ZUsbuJ9Mln2pzMGSICmeO7iGU-a9cKNuuUaslyRecVUQ>
    <xmx:Y2TQamCm5qnySnxvAtaA3az1t-r4poq6VToyCqBc-Q-xDlwdK09tkA>
    <xmx:Y2TQaudeaIfUxdw3NmPIjuJF5yTKNUMyLBL34PDLFZf0RIwC0kmuLg>
    <xmx:Y2TQasZdXoBxUbpKoUyUygwjAsHs8SBmtPRUhukgaDXr-paDjNL0TXRE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 01:28:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c20449ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 05:28:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 07:27:55 +0200
Subject: [PATCH v3 1/6] odb/source-files: fix performance when reading
 objects with alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261015-pks-odb-files-alternates-cleanups-v3-1-bfc62fd780eb@pks.im>
References: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
In-Reply-To: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>, Tyrie Vella <tyrielv@gmail.com>
X-Mailer: b4 0.15.2

With the move towards pluggable object databases we reorganized how we
access alternates. Before the introduction of pluggability, we were
reading objects by first scanning through packfiles from all alternates
before scanning through all loose object directories. With the change
though, we are now iterating through the sources one by one, checking
each of them for whether they contain the object either as a packed or
loose object.

Checking whether an object exists in packfiles is comparatively cheap
because the list of packs is cached, and the pack indices are likely to
be in the page cache. In contrast to that, checking whether an object
exists in loose format always incurs one stat(3p) syscall. So scanning
for objects one alternate at a time led to a performance regression in
in the case where most of the objects are contained in a packfile of an
alternate, as reported in [1].

We could fix that issue by introducing another flag that tells the
backends to only search the optimized storage backend. But that is
adding more complexity to the object database layers that is ultimately
only really required because of the way the "files" backend stores its
data. So for an alternate backend, such new infrastructure would not
really be a good fit.

But since then we have moved handling of alternates into the "files"
backend itself. One of the consequences of this is that this backend is
now having full control over all of its sub-sources, and that also makes
it way easier for us to optimize for this access pattern again.

Do so by first trying to read objects from packfiles located in any of
its object directories before trying to read loose objects.

The following benchmark demonstrates that this significantly improves
performance in some cases. The benchmark uses the Git repository itself
and sets up its object directory as an alternate, while the primary
object directory is simply an empty object directory. It then reads all
commits enumerated via `git rev-list HEAD` with git-cat-file(1):

  Benchmark 1: git cat-file --batch-check --unordered (rev = HEAD~)
    Time (mean ± σ):     179.4 ms ±   2.6 ms    [User: 114.6 ms, System: 61.4 ms]
    Range (min … max):   177.1 ms … 187.7 ms    16 runs

  Benchmark 2: git cat-file --batch-check --unordered (rev = HEAD)
    Time (mean ± σ):      95.0 ms ±   1.5 ms    [User: 79.8 ms, System: 15.0 ms]
    Range (min … max):    93.0 ms …  97.9 ms    30 runs

  Summary
    git cat-file --batch-check --unordered (rev = HEAD) ran
      1.89 ± 0.04 times faster than git cat-file --batch-check --unordered (rev = HEAD~)

[1]: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>

Reported-by: Wolfgang Kritzinger <wkritzinger@atlassian.com>
Helped-by: Tyrie Vella <tyrielv@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c       |  5 +++--
 t/t5615-alternate-env.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 455f409db0..9268f5aa9a 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -426,6 +426,7 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	enum odb_read_status status = ODB_READ_NOT_FOUND;
+	enum odb_read_status ret;
 
 	/*
 	 * Reading an object may fail even though the object exists, for
@@ -434,15 +435,15 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 	 * prefer the first such error in case multiple reads have failed.
 	 */
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-		enum odb_read_status ret;
-
 		ret = odb_source_read_object_info(&dir->packed->base, oid, oi, flags,
 						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
 		if (!ret)
 			return 0;
 		if (ret != ODB_READ_NOT_FOUND && status == ODB_READ_NOT_FOUND)
 			status = ret;
+	}
 
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
 		ret = odb_source_read_object_info(&dir->loose->base, oid, oi, flags,
 						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
 		if (!ret)
diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index 9d6aa2187f..3259852a0f 100755
--- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -88,4 +88,47 @@ test_expect_success !MINGW 'broken quoting falls back to interpreting raw' '
 	EOF
 '
 
+test_expect_success 'packs across sources are checked before loose objects' '
+	# Regression test for a performance issue in which an object that
+	# resides in an alternate as a packed object caused a spurious loose
+	# object lookup (a filesystem stat) on the main object store before the
+	# alternate packfile was consulted. Reading such an object must resolve
+	# to the alternate packfile, never to a loose copy in the main store.
+	#
+	# Build an alternate whose object "B" is stored as a delta in a
+	# packfile. git deltifies successive versions of a tracked file, so the
+	# older, shorter blob "B" becomes a delta against the newer, longer
+	# blob "O". A loose object has no delta base, so %(deltabase) tells us
+	# which store answered the read: the alternate pack (O) or a loose copy
+	# (the zero oid).
+	git init alt-src &&
+	test_seq 1 200 >alt-src/file &&
+	git -C alt-src add file &&
+	git -C alt-src commit -q -m base &&
+	B=$(git -C alt-src rev-parse HEAD:file) &&
+	git -C alt-src cat-file blob "$B" >b-content &&
+	test_seq 1 210 >alt-src/file &&
+	git -C alt-src add file &&
+	git -C alt-src commit -q -m more &&
+	O=$(git -C alt-src rev-parse HEAD:file) &&
+	git -C alt-src repack -adf --window=10 --depth=50 &&
+
+	# Precondition: in the alternate, B is a delta based on O.
+	echo "$B" >in &&
+	echo "$O" >expect &&
+	git -C alt-src cat-file --batch-check="%(deltabase)" <in >actual &&
+	test_cmp expect actual &&
+
+	# Main repo: write B as a loose object, before any alternate is active.
+	git init main &&
+	git -C main hash-object -w --stdin <b-content >/dev/null &&
+	test_path_is_file "main/.git/objects/$(test_oid_to_path "$B")" &&
+
+	# With the alternate active, B must resolve to the alternate packfile
+	# (deltabase O), not to the main store loose copy (deltabase zero oid).
+	GIT_ALTERNATE_OBJECT_DIRECTORIES="$PWD/alt-src/.git/objects" \
+		git -C main cat-file --batch-check="%(deltabase)" <in >actual &&
+	test_cmp expect actual
+'
+
 test_done

-- 
2.56.0.212.g129ede20d9.dirty

