Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E8C26159D
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135666; cv=none; b=DwmK7+qdWv089uI2uPfwk5cZ+Zn2xwX0+hGT+GkqpPs3OpOM2UZuWtvSLhyJeT10/KMMGfkrv3M7rkg2MBMGBFU26Z4NoS0Mlm0060xLm9p3CRhVwDZv9TebyH7U3V2mbGbsxZqu9iLQO3X/13LrMHvBbrt7BAQrtSDVwN5x2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135666; c=relaxed/simple;
	bh=zyO0o18JHZ9ky/kxsrfG1NE8/40vBk+wUpAUAHYsNSU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g11yB+tQg8jhvipbYlJOisfolIUHwUuKptw3vPe59P00iXS/TKWhHVylhxS/DhorvznWLMLz+c/itLPm6rCC5Y7p43ciIc9Iu5eO+lp8ipG3BjYtkADvCKFROwB7jU1oHTxORlb9DXoXp0eay756vwphhI5a4iSy3nf5STuqNu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cXXM7Mxd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KVhPx3cL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cXXM7Mxd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVhPx3cL"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 01D051380FC2;
	Thu,  1 May 2025 17:41:04 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 01 May 2025 17:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1746135663; x=
	1746222063; bh=sKqZxJA6I5VzpmUrSz4NYQP9j42uHvif1HD+phUcya8=; b=c
	XXM7Mxd1EqsOO/SSHybPYWrByxxfMhRk9ETNn0dVBBo96VP01s7onUeXy7mgKQU9
	fV+tzN8vFSCxbZno4ogrMhRcsQJyQ25B9fBjztIToix7pypsK9MLwplV0BcfkxKv
	6CHgookt5R96uCAmXATLIU8zfy+Nb/O/owNkCshdz6/XP4NIgj9ghnEpP9k/OzW5
	ZmOyzWhMtDhrVAk0EkHRM1RVmPh7rgjga/D2Bu727SvGThH/+GMCQdXtKGJo0BVc
	2uyF71cLvXLcbZe+x1h5y1R2i5OCtxnlhRTzQ4DfSrF26L+/HsSzQyMsC0RH5bH4
	gNM4cYYSG8l4VtZJjKWzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1746135663; x=1746222063; bh=sKqZxJA6I5VzpmUrSz4NYQP9j42u
	Hvif1HD+phUcya8=; b=KVhPx3cL1ZWLCW89BaOe1NsbDd6K5GyUoJ+SkY9ECcfc
	XMOoDnRWmP0Rqd2NyRPNvszlVhresIv+/hi0beIQgMKgjmon7/ANA+fMrsE7/wDp
	qhFQ+MlEKy26VXeBvLNO+/vwWjFQFEpsw6AgNVl3lNTyMsQ9Wy0mhyuZMv9NyMvZ
	WEYlBix2R+b2bZpWlgCDfGr5uL8i2LbZcdCTlphgciToziwTQEYaok0AEqIgWd3/
	IaiYxxFREaxpZx/kFtB1bmibSBM206gvXJJP/dJGsqGd0TAuTO2d+0EfD/5RxX1d
	dFYhKu6ZTR6C9doVFhAdgwRwrgT0+9VRuuwWZOaN/A==
X-ME-Sender: <xms:b-oTaJZ7RY-xV9r5mX2Hy2tDlcbi19-92Eem54yTIY1fUeCN7UEhNQ>
    <xme:b-oTaAZ_3LfiJHp3gsgGX_Eh5yaZ9HiJPbj0yZDpp1uy6D8fN8WE2Ju5SkXU2Ibjg
    shJhqNIjOe211JKXg>
X-ME-Received: <xmr:b-oTaL_R6aegLRUJJXSQdbi55XtoOjFLBpSa0IoWSBR7idF4_zrmbPTZk5-2nPgKzU-6ExHr35sHLWR9n8KB4AYh7E8ClJte2Azg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheple
    evieefieeuffeugefhveeugefgfeevvdefleevuedvfedvudefkeehtdeftdegnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:b-oTaHpU99M6ePP5dUcbvxcTI_DHIDAruBTgouFQEpBMAGe00Ui3sw>
    <xmx:b-oTaEpY8F6G7O-U-r8vetfitzhgF6rFYRfb2Q1xlIVyjILgwkzuRQ>
    <xmx:b-oTaNSvxmz09BqSkScTYb02RdBkfv6HG0P-vwhJvVn4iu_uvZv7hg>
    <xmx:b-oTaMrmnjTrG0w5VhDUMjTGh5HLIFtoxZ8BigBWZRs_RPPh6jbOPQ>
    <xmx:b-oTaNYYfvE9OpbuaSnii_qMy4qidrBxbeQPuFN0MpB0B0K7xifsaeId>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:41:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/3] parseopt: values of pathname type can be prefixed with :(optional)
Date: Thu,  1 May 2025 14:40:57 -0700
Message-ID: <20250501214057.371711-4-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
In-Reply-To: <20250501214057.371711-1-gitster@pobox.com>
References: <CAPig+cQUycUyto6=cDadaCahzDBQ_GDngAEEtK0bshLr15ok8g@mail.gmail.com>
 <20250501214057.371711-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous step, we introduced an optional filename that can be
given to a configuration variable, and nullify the fact that such a
configuration setting even existed if the named path is missing or
empty.

Let's do the same for command line options that name a pathname.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c                           | 31 +++++++++++++++--------
 t/t7500-commit-template-squash-signoff.sh | 12 ++++++++-
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 33bfba0ed4..7a2a3b1f08 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -75,7 +75,6 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 {
 	const char *s, *arg;
 	const int unset = flags & OPT_UNSET;
-	int err;
 
 	if (unset && p->opt)
 		return error(_("%s takes no value"), optname(opt, flags));
@@ -131,21 +130,31 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 	case OPTION_FILENAME:
 	{
 		const char *value;
-
-		FREE_AND_NULL(*(char **)opt->value);
-
-		err = 0;
+		int is_optional;
 
 		if (unset)
 			value = NULL;
 		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
-			value = (const char *) opt->defval;
-		else
-			err = get_arg(p, opt, flags, &value);
+			value = (char *)opt->defval;
+		else {
+			int err = get_arg(p, opt, flags, &value);
+			if (err)
+				return err;
+		}
+		if (!value)
+			return 0;
 
-		if (!err)
-			*(char **)opt->value = fix_filename(p->prefix, value);
-		return err;
+		is_optional = skip_prefix(value, ":(optional)", &value);
+		if (!value)
+			is_optional = 0;
+		value = fix_filename(p->prefix, value);
+		if (is_optional && is_empty_or_missing_file(value)) {
+			free((char *)value);
+		} else {
+			FREE_AND_NULL(*(char **)opt->value);
+			*(const char **)opt->value = value;
+		}
+		return 0;
 	}
 	case OPTION_CALLBACK:
 	{
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index e28a79987d..c065f12baf 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -37,12 +37,22 @@ test_expect_success 'nonexistent template file should return error' '
 	)
 '
 
+test_expect_success 'nonexistent optional template file on command line' '
+	echo changes >> foo &&
+	git add foo &&
+	(
+		GIT_EDITOR="echo hello >\"\$1\"" &&
+		export GIT_EDITOR &&
+		git commit --template ":(optional)$PWD/notexist"
+	)
+'
+
 test_expect_success 'nonexistent template file in config should return error' '
 	test_config commit.template "$PWD"/notexist &&
 	(
 		GIT_EDITOR="echo hello >\"\$1\"" &&
 		export GIT_EDITOR &&
-		test_must_fail git commit
+		test_must_fail git commit --allow-empty
 	)
 '
 
-- 
2.47.0-148-g19c85929c5

