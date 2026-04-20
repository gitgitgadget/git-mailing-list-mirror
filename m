Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F8388393
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673390; cv=none; b=MY7KzBUKaeRss8g0D+xMUboZcQbHpRQ9lpOt/3iJWoLqSeYif0wtaDVASMa/3tzDtTcOE7iMqxvd50WBDHGd9R3zZPox8igg4NNxKMvfSIMt/AFuN2Z7yKBuHopIxtjUVzXT/JKmCGRs8mAzA4mqQw6e8bH7nz7uNl9ssJuhCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673390; c=relaxed/simple;
	bh=nLJqcmp2SBUjaECvUnHy98ijjojbk/WIBuHFXIhta14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGdzLLTuhoKMSSiDfDMfIwE78lWnbkxGGuNFjfw3cRvXtwoEzTc5iWZdj5EpbmJeWjHXaKHLX2Dv3AOTqQS5PfwXJ5YwU4SAeZWA1olzi0r78cwc3JqeyvOrxU9daNCsEa9PR5mjEpqzBZO28UrvGqi8Rp4E5d3wpOZzmwRTec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p7g7U9Jc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r/1ngnoV; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p7g7U9Jc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r/1ngnoV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C4094EC03F2;
	Mon, 20 Apr 2026 04:23:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 20 Apr 2026 04:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673386;
	 x=1776759786; bh=kNWc61g+W9dWaHnYvaN7kagX7t6aXtrnXId5HzHz1zI=; b=
	p7g7U9Jc0SowP8mxVZbj+4ZTZKsun/EUfuryS8ttF/xLY8EzCt8rXZ3XnmxeZl9Z
	jZJtVCu1Jr5W3B6ty924k9EBb0V7UU5YLtJRHVHlU9k4C+HAkyApTsgY40+nplHt
	8y6JkpfSnhpspugT3ZxLp1t1iu8m7UMMxmEfZaS4IB/RjwU8/9g+gLf6Y9xX5ZAu
	BXpJBitVJR7zTtjDldRTqfs422GsbZH0S3hGXFdAQnSLh31mTjOAixmaATrRvh5c
	1xgBtnvvE2r0dIiJ1ghtfRFPlV2UR/DsQDu+t7F77HVgkHe/y6NB0/jf+GBR/nb3
	SORyVcAhy6Q8Bv8Qjrx1+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673386; x=
	1776759786; bh=kNWc61g+W9dWaHnYvaN7kagX7t6aXtrnXId5HzHz1zI=; b=r
	/1ngnoVFHJPXwh/owc8K9bQAV6YumJeRQEoTFhonoWX3kdUdoNe6s+OKsEveBit4
	nCL66zFZwOzBn6DFukhcnWZUEQsIih6YDTtnC5f5HijUVRkY0UpdXfNE7et/z3cd
	VclOVahwzwzt9HszQBtlo8sZ7TtsZjwVxAgisB++Bdghyda3+S1o4ZZG5YIpS+7/
	dX2HV5aU5WpBdHmevcm5oOzgvYeOvMXxKACSjC/iJQ2pSsBsKva+nWIJNN4SJKKJ
	2u5KhHeNyZ1j5xAynJVZEpaTQzCckMUzbM/cLo8M7G5Uc7+CN3yLZytZzjCUBaDd
	HhbNP0PgJgRmqxP8i7E9Q==
X-ME-Sender: <xms:auLlaYBidQZCnTS5zNMmfNgALHhnAQRkg-HIo_ufqwL4LvjOBlGsJQ>
    <xme:auLlaRixqGfZGK_AAz6j7ZowJbmMTXldEx6LSrSCvzCng3EzBZU8YAx3GZ8aKThT2
    6aRudinIdOlMSCl9K5jVCKHnxd6WmYZvlzIS7xfEU9rf-nVjnf4>
X-ME-Received: <xmr:auLlaQkF-TH4bWYacra7ksv2FeHBpW1-7q_qR-r6JZTh1SRnpYbKSfePRZniCJHSgkV8KUcV19_jSk6YkcPgZ5r3xVxJgxFqFbn-TRV3BKfa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:auLladpI-Uyr6Fvtoy_6sqytnSep9cmwAbMn3fJip4gvC-H6Z4omeA>
    <xmx:auLlaZEW0Z-zmbBPrTlSwzdgOelSHojvQCDcbVIhtqFbg9bMnuDf2A>
    <xmx:auLlaZwvj8BgAiKTMlmoXpY7fbtcripm_wUzX9xV_srcewngRNexXQ>
    <xmx:auLlaeqAeFV-JTb01hZRLvFa5Q16yzOlN7hDw5t0XRczmOJdU61-3Q>
    <xmx:auLlaYFwiL8CfvLkIwtbacRK2SBWOfjmUWqkYLXS2m0V1TAwFO_zQ1K5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:23:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2bd92916 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:23:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:37 +0200
Subject: [PATCH 07/18] setup: stop using `the_repository` in
 `verify_non_filename()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-pks-setup-wo-the-repository-v1-7-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

Stop using `the_repository` in `verify_non_filename()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/checkout.c | 2 +-
 builtin/grep.c     | 2 +-
 builtin/reset.c    | 2 +-
 revision.c         | 4 ++--
 setup.c            | 4 ++--
 setup.h            | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e031e61886..d7069765e7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1485,7 +1485,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 		 * it would be extremely annoying.
 		 */
 		if (argc)
-			verify_non_filename(opts->prefix, arg);
+			verify_non_filename(the_repository, opts->prefix, arg);
 	} else if (opts->accept_pathspec) {
 		argcount++;
 		argv++;
diff --git a/builtin/grep.c b/builtin/grep.c
index b0e350cf89..4ec0c016b1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1151,7 +1151,7 @@ int cmd_grep(int argc,
 
 		object = parse_object_or_die(the_repository, &oid, arg);
 		if (!seen_dashdash)
-			verify_non_filename(prefix, arg);
+			verify_non_filename(the_repository, prefix, arg);
 		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
 		object_context_release(&oc);
 	}
diff --git a/builtin/reset.c b/builtin/reset.c
index 1ac374d31b..11f57605b5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -281,7 +281,7 @@ static void parse_args(struct pathspec *pathspec,
 			 * Ok, argv[0] looks like a commit/tree; it should not
 			 * be a filename.
 			 */
-			verify_non_filename(prefix, argv[0]);
+			verify_non_filename(the_repository, prefix, argv[0]);
 			rev = *argv++;
 		} else {
 			/* Otherwise we treat this as a filename */
diff --git a/revision.c b/revision.c
index 57cf00ae6b..9071a38b85 100644
--- a/revision.c
+++ b/revision.c
@@ -2082,7 +2082,7 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 
 	if (!cant_be_filename) {
 		*dotdot = '.';
-		verify_non_filename(revs->prefix, arg);
+		verify_non_filename(the_repository, revs->prefix, arg);
 		*dotdot = '\0';
 	}
 
@@ -2227,7 +2227,7 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 		goto out;
 	}
 	if (!cant_be_filename)
-		verify_non_filename(revs->prefix, arg);
+		verify_non_filename(the_repository, revs->prefix, arg);
 	object = get_reference(revs, arg, &oid, flags ^ local_flags);
 	if (!object) {
 		ret = (revs->ignore_missing || revs->do_not_die_on_missing_objects) ? 0 : -1;
diff --git a/setup.c b/setup.c
index 736f950bd0..c6b5b85f3a 100644
--- a/setup.c
+++ b/setup.c
@@ -297,9 +297,9 @@ void verify_filename(struct repository *repo,
  * and we parsed the arg as a refname.  It should not be interpretable
  * as a filename.
  */
-void verify_non_filename(const char *prefix, const char *arg)
+void verify_non_filename(struct repository *repo, const char *prefix, const char *arg)
 {
-	if (!is_inside_work_tree(the_repository) || is_inside_git_dir(the_repository))
+	if (!is_inside_work_tree(repo) || is_inside_git_dir(repo))
 		return;
 	if (*arg == '-')
 		return; /* flag */
diff --git a/setup.h b/setup.h
index 24a6f66629..364c2c728a 100644
--- a/setup.h
+++ b/setup.h
@@ -146,7 +146,7 @@ void verify_filename(struct repository *repo,
 		     const char *prefix,
 		     const char *name,
 		     int diagnose_misspelt_rev);
-void verify_non_filename(const char *prefix, const char *name);
+void verify_non_filename(struct repository *repo, const char *prefix, const char *name);
 int path_inside_repo(struct repository *repo, const char *prefix, const char *path);
 
 void sanitize_stdfds(void);

-- 
2.54.0.rc2.529.gd9106f7525.dirty

