Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F10346E53
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208591; cv=none; b=QIunmQxuNI3E5NaodIZt1a+3lwWW9gHa7B4QzrCHBDtaQWzmQ0yzA4b3wLqL97Oy3XVfXO6fS306XQ2aj2BRKyvlfiXFKW+YCmVbfbf+3w/f90xV6yI289/IaZBf4tlsvhENeqYecfyo5itNCCZa598GdqR1NQNXFmR9NFn75WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208591; c=relaxed/simple;
	bh=JlqHXPOeeRMNkpDtocKXVXY5LlypYKZhxbV4sc8QRp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qVJGFzxWKmlnyKewXlUXdaxTQxSoYkvkIKRoK1ZCYzXjFCdKH8IwCDC2yIU0P7TeWcFUWD24a+g16xn+VTMFmcpqC/IRviAIlWfxcdZvRTWQOy49a/r+gjLJLXK2yxI6kbKkhLS+am1zuCQhUefbGqok0vifXCkDlNP5RMdyYpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=drMLn2EW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=erEnTJQH; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="drMLn2EW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="erEnTJQH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 211931D0009D;
	Mon, 12 Jan 2026 04:03:04 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 04:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208583;
	 x=1768294983; bh=Uk0UH18vYcGE3eIHSwsUAvmIUzzgslikqOaqwNIOrJ4=; b=
	drMLn2EWBwbNb4heAvCHhyiTDvVunzTrs5H1EXGpun6u383YSv/KGV+S7AvZS6H9
	po+a0BxWOrwsLXeA5kd23NcvpP1dJmnoFZRxHIrhEuy4fW/KdwndT+27ZiHaIS9J
	py1ucGVKe9isBIzRwfay967vsY3pv6gyhfRBXzcI5NE/DkwKuzZqYafCbB2rDkWV
	e0zAnV45YJ1XFuOYMvAshx/Uwxv/q2foCPLkIORXCbkX94STOGi2Hfy+Znee6bl+
	fPoZdtU02YX3QJnR/9viEMQMw1sONeDYj8dGsScTv0DG0CpE4y0+EkFru3pxa//A
	irxvIv0A0dCkv87yvIdMnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208583; x=
	1768294983; bh=Uk0UH18vYcGE3eIHSwsUAvmIUzzgslikqOaqwNIOrJ4=; b=e
	rEnTJQHBwaHqoVjbEhGOD95Hd0G9mLuubRBhDQv/1iOk6AJ67rbT+2dreIC8evmj
	vn+RUNap4MyLifbG5BujRyGAsKmMlEF5/1gIvDTBVGfn2UM5e04f7003VhG4s2VU
	izlbRup43YWHMJ6fYAHlp2XEQB1uNipYfqQVn91hFE70CK+YOq3J/GQnLZ3HMqnk
	5ViZH3PL+RrwnItnIIbb5+LKVYm530j0Yxv1CDvKG3kPBtPRXoO4L4EstTNjeq8C
	28WWdrDASnUB6DqKCboCA0FDhqoZbc4VHfJF2ambQFEsHSBjsV6HjWZDKMDryoyE
	4Q6BKczwhbs222w4nQWhA==
X-ME-Sender: <xms:x7hkafo-ip11rJqepMIWftg6zJiy17764OmuV77GCFette1mEo40kw>
    <xme:x7hkaRFku9SD5FDx9D7NnRW9qHdtGCbGWyMcZdQ7OvqnBXqk8UHXph6rQVoytUjY7
    -UMB1W2EP44EC6LW9-l091-6jDXmw0CGPyli6Lc0ifDV3qnDdYCPg>
X-ME-Received: <xmr:x7hkaZnp2iGqKc9Oqk8ah5UdWvcVXL1FxDDsBqnWJjhuIH4uupbBM3UFvRFuHRmQNoYJFmM8dB0RAxyzm1-zKmiVNqMp-32RMKBjgRfLzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjih
    grlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:x7hkaclv6wdWOoXiS_hE5IKNteT3lHwGTe0dkIZ8vQzV_rmZjwERUQ>
    <xmx:x7hkaSuqWqvjpNhBAqQxKrKu8tcrK-ZtrcguI1VSqHzHfckkO72MFA>
    <xmx:x7hkaXmXsp5QjORZkCV3WGYnSUe8tSkK8_qB-3LpZSEH-Sgvam1XlA>
    <xmx:x7hkaVs-gAXUxNh65Hl-6hAh_zGEZyttO7NmaE6O6xmPyNba5OQuSA>
    <xmx:x7hkaWhV79pFnhALIIn1NwdyEExskQYU4x3CZKikrwVrB3dPy9Pu-sgq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7c0dd7d0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:02:52 +0100
Subject: [PATCH v2 03/17] refs/files: remove `refs_check_dir` parameter
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-3-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The parameter `refs_check_dir` determines which directory we want to
check references for. But as we always want to check the complete
refs hierarchy, this parameter is always set to "refs".

Drop the parameter and hardcode it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index feba3ee58b..0a104c7bf6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3898,7 +3898,6 @@ static const files_fsck_refs_fn fsck_refs_fn[]= {
 
 static int files_fsck_refs_dir(struct ref_store *ref_store,
 			       struct fsck_options *o,
-			       const char *refs_check_dir,
 			       struct worktree *wt)
 {
 	struct strbuf refname = STRBUF_INIT;
@@ -3907,7 +3906,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 	int iter_status;
 	int ret = 0;
 
-	strbuf_addf(&sb, "%s/%s", ref_store->gitdir, refs_check_dir);
+	strbuf_addf(&sb, "%s/refs", ref_store->gitdir);
 
 	iter = dir_iterator_begin(sb.buf, 0);
 	if (!iter) {
@@ -3927,8 +3926,7 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 
 			if (!is_main_worktree(wt))
 				strbuf_addf(&refname, "worktrees/%s/", wt->id);
-			strbuf_addf(&refname, "%s/%s", refs_check_dir,
-				    iter->relative_path);
+			strbuf_addf(&refname, "refs/%s", iter->relative_path);
 
 			if (o->verbose)
 				fprintf_ln(stderr, "Checking %s", refname.buf);
@@ -3960,7 +3958,7 @@ static int files_fsck_refs(struct ref_store *ref_store,
 			   struct fsck_options *o,
 			   struct worktree *wt)
 {
-	return files_fsck_refs_dir(ref_store, o, "refs", wt);
+	return files_fsck_refs_dir(ref_store, o, wt);
 }
 
 static int files_fsck(struct ref_store *ref_store,

-- 
2.52.0.590.g1f87b77810.dirty

