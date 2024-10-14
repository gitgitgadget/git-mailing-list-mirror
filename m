Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277C91D0F46
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728938676; cv=none; b=g9j9JheeY/4l3BJFAveDbC5ZmqTKCoUIqIvx/CMCCyw/BS8DCh0d19Il+FYpQi07l2eMLmaLWbjJXBgNoyN2f0MOJsMGa7K01HkZ4ldto8kPYTCIn79ODi9bKWa3JdOOQ03RO0/AQYbkeG16sjRAdDCB81GN4SW3oMRleqJPqpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728938676; c=relaxed/simple;
	bh=zyO0o18JHZ9ky/kxsrfG1NE8/40vBk+wUpAUAHYsNSU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpXNO+il/uCFWtnCIa5D1PDpdrnd0ExzKvZb5fHfOk9PyFZ0mO8EYGcJdlXeZF58DhYaPRruVq/FlzI21AA1GcpGuVcvAMvst+y11Y0wCjQxw3op2ERP9Qsio9BI9zk4P7Bsmpq8VMBOGGND1eZlEQqOCbRxowUHJQvonQk5ntQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ESgNV5j9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a84kSuZj; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ESgNV5j9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a84kSuZj"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 423D413805D8;
	Mon, 14 Oct 2024 16:44:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 14 Oct 2024 16:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728938673; x=
	1729025073; bh=sKqZxJA6I5VzpmUrSz4NYQP9j42uHvif1HD+phUcya8=; b=E
	SgNV5j986WKNO14EPx9gYa4Sb6VG2PJo+sM6O+HzNKD3jmm59eQKUQGhmcbsL8bH
	hd7OHk4d30LkLZWh7+S6cS6QqpBKv+4bmsLHM0gh97wuTAoX5oNhscCdX3W9vMKf
	5GUoi5Yv79sthCdK1ch8WE61cJ8ifmLIxlbmm+WBdZIlreWuugJBR+4ijNA12fyI
	1ohtxD4s9dEtbCbaMwt5Dyyv3id8r3FJocgp8IsHFlYkXzRtD3/0Dth91nCCYZ8w
	GKpJCH0foLdhth9T0vn03UQpZLCrm/N8rPZ/5Zw3r8XPeUmYPBDY/HdC4Dtc/1rA
	LGJdDJE4kwyOgvepniMyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1728938673; x=1729025073; bh=sKqZxJA6I5Vzp
	mUrSz4NYQP9j42uHvif1HD+phUcya8=; b=a84kSuZjXwL5KmU2NMlrC8jzH3d0J
	TB448T9Hf49Ie59VoTcVMdOJ6rWENnQAcWud7V1tlSr2dst/yBNriwBcW3aFotoz
	J7jlhL39y6AoWDTgqaydQZsa6UPfpmzyukHMqiV+QKKokPf9JH/QhyeAV2Kwm93y
	SJgjleGkemJnDxhcMQBsJnTmO6v5ZKt5Peaxh5/q6Ahomj2GLWTd860SMXOVNrnP
	YdLAFKIozY0a4yGz1O9iHYmdtoC7t4l06zmhHOp5Ph3IH4cbpehelF4EMgXrP3Wp
	fX7rklt1D9mdzgapTSOI0z07IDNCf4RhQHS4YicH/j0IPVutOQrdHzXfw==
X-ME-Sender: <xms:sYINZ7cLZQ4GGyyVuP3ylHT6IPwx7L0RvWJlLki4hQF57He9qHAVgA>
    <xme:sYINZxODNrDtO8gaUhOLnlnv0Zy57UD89aBqB1OpB6VX2_P46cGtRgCFBdPXHp14d
    3n9E5kkqHnL6PRXEQ>
X-ME-Received: <xmr:sYINZ0g53UdgA5XOzLSnLFZ7MjH9sqTOddN8UZnFfrxsSq3VTfACERPMbkZfwJwABfInY_ZyCgApPPCINVopldGeOzlsbrERTw2S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelve
    eifeeiueffueeghfevueeggfefvedvfeelveeuvdefvddufeekhedtfedtgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sYINZ89_693zyfBDucaXd5y1R40LmfFnKLD2Q0JPWhl4U7Q_4_znbg>
    <xmx:sYINZ3spMaOnQ53lgigC8bbkKh9zEmtw3dYRZD2_43E2S9sYXXo3Uw>
    <xmx:sYINZ7HHfQ_0hqYQLEuyqgYK0l6szPsN2JWX528hmXNsp49mAhLM9A>
    <xmx:sYINZ-OdwKENBduCw8tcIOtMKZZv4islU_Sy7NWBGPKVY1po24b36Q>
    <xmx:sYINZw7Lq7KJcQ6gAWo_A1w_1oa9fTxAEWBdL8pJyqG3HFWPhGz6H3lN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 16:44:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/3] parseopt: values of pathname type can be prefixed with :(optional)
Date: Mon, 14 Oct 2024 13:44:27 -0700
Message-ID: <20241014204427.1712182-4-gitster@pobox.com>
X-Mailer: git-send-email 2.47.0-148-g19c85929c5
In-Reply-To: <20241014204427.1712182-1-gitster@pobox.com>
References: <20241014204427.1712182-1-gitster@pobox.com>
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

