Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96B3E63BA
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096686; cv=none; b=l/xD/EQ7jL7qc9HlKhxgYFHcIV39m9kBU0BvsphqwXRddktNxLa1W8njUZn6fOxYDbqXTFR5EILJePl2E2bS+R06wRyJtPqDy3NnULwMnl1N3RlB4sxPLiNeJyjW8rV9Z9okCqXO/id6lMF4WMTi37JPk9BGuGyQhY/oCZMZ/DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096686; c=relaxed/simple;
	bh=/pR0hNmnEFgi0fnLi1PEo6rfZod3niLhNCN103meCqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nyC8Wc7zaVCUj+t8Rea3pKr4xI9YGpZ6GPoc2m+W48N+uHEbUWGS90FbsKHD19OuplrEuTpr339XX27RI5KOjS69DuvD38TNqE/4/TISsQJybq6t8SwZDUtxikptphcrKBpQmVx3SiPf3wnASnHC8wR6muKCOP+1CM8Ve95pLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FthIqM+d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rpCpky7Y; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FthIqM+d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rpCpky7Y"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6D3E97A0134;
	Mon, 18 May 2026 05:31:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 18 May 2026 05:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096684;
	 x=1779183084; bh=Z0GYFFMtI6Sd2PXV2l/7CWxMahZlZwQRqMYDnyF/PhE=; b=
	FthIqM+dyep6Uj+FP+hZD9igXZuw7xASRLy6BEf01xAhzqWlcoq3aoorqXcm7TFM
	7X0V/eRlrJgOOQfHZIoS5R9AOJFS0QC/71YgJzRkLcl/+g3Za5lBe9u9ew9I7Hat
	QGLq576dn9UKVIsFN+UCYCWExYWdCFSpBi0qUptAyJLBBPKQ5zcgpgPyXTvBTYzv
	DXuNhCgNcpEN2PalEtjdluWpVmiq7P/2qsPvFrVY7hdAizHQ4E9yFtxRcKUHUjB3
	VMuGs+LXY5XvBPKAHoVIjQaC8J60PeSGBYztBzJSGwTWAI1HswwHvCNrWH9GUfjr
	MzxGZLQtBOBUI0KId4LONA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096684; x=
	1779183084; bh=Z0GYFFMtI6Sd2PXV2l/7CWxMahZlZwQRqMYDnyF/PhE=; b=r
	pCpky7Y2E+MDQPYl8oR9q7tXGceauZMPBwlZdPVFVs6n99FSiiVvNgWQQtqMG+pr
	3K9fOxvdq1p5e7eNdYGtR4gQbvh+7Nkfaov6IhRQz7nqqJis1u7Rza/6dLY4cVx6
	9b+hou+tYmAcJ6Z5FF/DUkx3G/+1kZmpeGPTnpCDtkOIsetkGlH+RKaTdjtN36Ac
	+SsGvUNzEDrL3Rgian+qmGkqFWyzdA0HvlRSy+E4Z0XXjHf0rQ+XNHxoIgtRzy7y
	Ake5CqyfD2NMQeieYyTM2wi9fWmQfxRpPgu38sSfmgJBQSqoGz2bok8UAwjJWFA+
	/oL6Cq4rE5DiqGyVVxi6A==
X-ME-Sender: <xms:bNwKauUYNYZ9mp-BgB35ar3P3n_CNRJwwIG0L2DFpijsxY6D3FvlZQ>
    <xme:bNwKahc-Qn1hqkuuZRJK56cF1XMT7hpW7ixEjPHjgrcDTLjFuEIKNHZ2VCxMKPlf9
    848EjXwXMvi3NA-xvIUBXenlt8SkeIZY1zUhyBudw0gYk6n1GuomQ>
X-ME-Received: <xmr:bNwKaqusQ6vcTlRStz4_DgGOqD-lUBXihidej3o1ebsH8tSzssSJk1IWYdxPnHtDbCaybaiUmuJWzShkz_s2vel-g-xmcY4gEXvFgV7BiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bNwKag9RN7ZBnd4MrpeyBdsgBiOwJEwNVL9DR5DFPi4mIpbXmMfmDg>
    <xmx:bNwKal26SjlWjvjrwhW_zr7I5BCrDK3H-3k97mOGz12lr-QnVF1_eQ>
    <xmx:bNwKalBB-f_yMHNVHw4jpDihY4MVsIfjsDjN6jsGTWLoRM6NlDMHvw>
    <xmx:bNwKahf3x9meIaBj2-Z1JYHtg2zDe_LHUmBYuXk60psI7BYRyi3QCQ>
    <xmx:bNwKautKg-8sX5h7dz1QxAyPLPzcwBJsWeI_R8FA4qfwVP_ZoKCw9Z34>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1880960 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:30:58 +0200
Subject: [PATCH v2 07/18] setup: stop using `the_repository` in
 `verify_non_filename()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-7-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

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
index ac0186a33e..14cefa0199 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1492,7 +1492,7 @@ static int parse_branchname_arg(int argc, const char **argv,
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
index 5d53244379..b5fe3ef95d 100644
--- a/revision.c
+++ b/revision.c
@@ -2072,7 +2072,7 @@ static int handle_dotdot_1(const char *a_name, const char *b_name,
 		return -1;
 
 	if (!cant_be_filename) {
-		verify_non_filename(revs->prefix, full_name);
+		verify_non_filename(the_repository, revs->prefix, full_name);
 	}
 
 	a_obj = parse_object(revs->repo, &a_oid);
@@ -2225,7 +2225,7 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 		goto out;
 	}
 	if (!cant_be_filename)
-		verify_non_filename(revs->prefix, arg);
+		verify_non_filename(the_repository, revs->prefix, arg);
 	object = get_reference(revs, arg, &oid, flags ^ local_flags);
 	if (!object) {
 		ret = (revs->ignore_missing || revs->do_not_die_on_missing_objects) ? 0 : -1;
diff --git a/setup.c b/setup.c
index e673663cab..759aba4e2c 100644
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
2.54.0.771.g3ed373ac14.dirty

