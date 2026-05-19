Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135547F2E0
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184363; cv=none; b=SB4FqBAvh5VcVYL7b3/1GTl6GgxNEOpwna4Iq4IPyXCKQF4itPc2bcFl2I2R7yx3SSVOeC/mbMl558C63RJcCgo4bIY6pxWiPNnzYClJ/GoNf0vyjuZzd34zLM148I5rJdCt12UeOSrSmnc4f9TMe2DTghLampKxf7PJ0cOmGrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184363; c=relaxed/simple;
	bh=/pR0hNmnEFgi0fnLi1PEo6rfZod3niLhNCN103meCqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I11AeymUxKn4hBNWw9SSJjt4nLqSV83we+FAimTsVHO1Pkhei+BdikjyCP/ZjVBJU3YK6K4HEdm/mSvVbMQq0blFU9ZmJ2d5+7yGc6Q3tAxOUOJTj+BzUV53faPmlXrEoFAdFVxkeG2A5LhT+L9ouMw4N+n0CYHyu/1e1Nz1DPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QgQtmafZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JuTNFydA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QgQtmafZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JuTNFydA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F5407A00DA;
	Tue, 19 May 2026 05:52:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 19 May 2026 05:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184351;
	 x=1779270751; bh=Z0GYFFMtI6Sd2PXV2l/7CWxMahZlZwQRqMYDnyF/PhE=; b=
	QgQtmafZaefrNpHs9r5jEl48aVbwagO600pqB12VKo3XStw2D7r2136jH9Y5Sybw
	E+RNY8XhSZ3pE2ApK8pDZCh5u18lV2EGyHr87cuWV6EcjantYHK34ErJnhqa4IsO
	Mcz0xBT7EDltkegSqCSUDM36G2tsu51jKViyBTC3vCHzcG6DE9YsGNHhxXAdgkqE
	rKKOKQKpZWKgELPQIUgDk6CCb209XQiChfG0M5us9EN/0s2+1LiihKYOP4uYrsU8
	C/l5/0bWpUb94oP5YRrzeWKjSDFLGhiQTIwOi3YXa8/38I191PnNc0cppA9vMx18
	FpG2qKHAfSFS+65r1mIJZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184351; x=
	1779270751; bh=Z0GYFFMtI6Sd2PXV2l/7CWxMahZlZwQRqMYDnyF/PhE=; b=J
	uTNFydA2I1Db3+6NTOx9YEPtwAexuEol4vKaSwjZQyuLLI24P3/j/+qkT7n8vwlp
	A+EOhG0U/9dad1w1gXxliWsWi87pdMHyXqZrSNNCWvMJNcMMD1AR4IkkmloVBDjp
	4AwaMUXIyWrNiCaCSjxHYL/vZWYxfX2fdYxiJ59uoe6vaexn3uJD6xfGveKEoMnL
	n+Wl2t4KYP5tA+UgKMNuIFYXxQRB8atjPR340V1P5bhvXhs6Z7EwidzTjzvhgAP8
	qEFNdGXdTHMxlEJt1nTt9sOv9wbx+DZll7hkK8vc18As4hXxc/AZRnoWWdOYH/YH
	d/cvASLCQSg9IXMql/ajw==
X-ME-Sender: <xms:3zIMahhwBxGdzypmI3n047GpWVRnu_CKZIv11m5TiYzQUqviB0MMnw>
    <xme:3zIMas4wLTAjkUpHwbGfRkn5YXL5L7ypaWrei3lccGIL02MS_rmztF_v07cjf9l5g
    U0sBI_5_ojCZwBq720buipnLsjinLUvPf-Okfnnd9Dz8WTD85aP>
X-ME-Received: <xmr:3zIMapZuEWIdIfpQOr-7f6G2SBI8vB9kDG5GdmBkNzGfKZyxzaLIjt3uXCpiF4zm5frz1qa3LDv2tlr3lVweb8DrRPOasrmwfO5L5KKbs1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3zIMah4EsPYG6D4MsKV4piyg8a280-X9b_tRWxy9gkfQ1eQHyP0DOQ>
    <xmx:3zIMasBxYjFpySfxwK1nhRyDHWb62zMziq4BpBuFBfS5Y5l_yFW2sA>
    <xmx:3zIMandIGdrq_xrTcBIozzcPOyy6XECNs1npONaNOwMzi5tLuyDYHQ>
    <xmx:3zIMarIMzOkCCXXqVygnAoU8F1AfLdM3VFUEMmaOi3H2E7ZBQ5EPbw>
    <xmx:3zIMaqsxo9ilJOh8gHYocjLIXzDDNmfwshT8OWvFMVIGlGuaMBc2iIX7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3ed2c428 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:11 +0200
Subject: [PATCH v3 07/18] setup: stop using `the_repository` in
 `verify_non_filename()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-7-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
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

