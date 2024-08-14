Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068213D2A4
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618343; cv=none; b=a8uKZiWXElwC8bieYVDZqloA37Y7rD13AyhEvBYaTjUOrNnj8C451UGibX0WKVmbo7EdeLnAeD8NyCXTy6hY1+BMB9T/dXgP+1sRu5WMkqm+IyO9ZHq9/0ksUA2RghHZGpdgH6fE8MAFQXddWCIEHrO1UFwoZmxGYsK24pahcig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618343; c=relaxed/simple;
	bh=i+z0Ja1UQC9OBf3tk7CNnJA2y7Cbl+JFKmwwPYAvNuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6ODw9XPNQKGjm5l0Yb+mRktdrsj/57xKKRTV43wAnhjyRNz1zzEaJ+seKzPWjYiA3+gHRwvlKgQQF4mqhi8YUA781sqTOPBaaoVEavh/HEztneZztcBgMT4kEefhap9uh6nPutLVOo2e4UIUDLspmJY6eB153fV4YMg9bR5bHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g2L4Co45; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LWk4KXb1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g2L4Co45";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LWk4KXb1"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id BB6C9138946B;
	Wed, 14 Aug 2024 02:52:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 14 Aug 2024 02:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618340; x=1723704740; bh=BOqUsUHyb3
	BpG8+cATWFsGtJ7YKoNLA0txlZw8OisMA=; b=g2L4Co45/UhIclPq6sO9Rlp5SW
	4KVBR59533Sku8moIpwbaTwg0iecvuuJ/Iv9w7e1POrhylnmzCOnf7breRMCGveo
	ysqyruyOHrPr5GUcA8XitmKoeI17nR3jtYz1/T4lSFeoqNwpeYdaQ6WgalP4zg6+
	4FfEQRIXs9NnYdwoVRII3yvQeudRu+fOdltYqLKuIxLOTSqzI0a7fv33kLf0loUh
	NilLxddNJORN1n2Dp5hLWlLUlQhefJf6VjVGbNR7V3rnrQJQ2vCIciAtQACzaORW
	WG+xXk3kr2c2//jwkQRx2bbTKY6bg4bJqLJh03iy200EV1Tnc3snbRR6ZbVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618340; x=1723704740; bh=BOqUsUHyb3BpG8+cATWFsGtJ7YKo
	NLA0txlZw8OisMA=; b=LWk4KXb1xxgiAIlXqX3rXSlkc/6pWos+EOmuXK/ZSGR7
	ZRlCBglAO2CiY3xiaAJjBapWI2oZCkwQIRaL8IKykx0nKWRjZkEM+Uvo1/fUTcdt
	s0OIyNpNJaSMvfLszrbMCjTRdEuYP8vPzB2WuiGzZ4tZFzYdV4nl2ud5NpdXTCmS
	eDlMrpwotXtA5+xZuYYYFkjHOdYLeZxxvIi4Z+wKGtMW4cPGuS5K/vLSyhae7Pou
	g4/SYfflyC/CFpjz1TXPh2rbC7AvCLMtWqOjVOiiG7Tdae05wozLhBg2XXEycFL2
	wLSLaG9QaxwzFpcC9nKHXaFWroo3yPo8BFWVV+VHNQ==
X-ME-Sender: <xms:JFS8ZiJBIoxLolLoT2aJcLLS-DoZKEiPZVCSslVhQeP4lx7MYG_7LA>
    <xme:JFS8ZqJjaEB5zJFXu2cp18TvNclkv0YWIENJLM7k-RaRU6Qlwfshgx3T27nNomjGv
    a1jr9xfn_MGJAqZcw>
X-ME-Received: <xmr:JFS8ZitQroLN5W2BxpT70FG7rC6gDllkH5uiPNh-wsVRa4k8xQmwmBze9UtfoAedHKXg4A4UtkWua2W8ECHsHZCL_suDPKZf05RpFvPjOwSuQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtphhtthhopehmvges
    thhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JFS8ZnYwxrZA1ygQ6c1pMiSMWyCaz8TWArf-5KlRJtk4L-LzfzNdug>
    <xmx:JFS8ZpZq-B5VvYi3zXWfHdvmkHqSHOKB4YOCsKP5A1oCb8u0e9dYbA>
    <xmx:JFS8ZjDCtjYtUWR6vc5hYjdcfLSiQjlwKHs9WTC2KrTTL5ra7Mhm7Q>
    <xmx:JFS8ZvZfJZVTO4St_pOcRg8riSv0J9F9A0kkjk403E8kA4aZi92ItA>
    <xmx:JFS8ZuMyCsj0qvIC_WIO14w9HSERWH22AeEpX8h1121iFBJFYSrBB7b9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5eb8ed7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:00 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 09/22] builtin/rebase: fix leaking `commit.gpgsign` value
Message-ID: <1d3957a5ebb527d672a66f6f6226b6668924a2fa.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

In `get_replay_opts()`, we override the `gpg_sign` field that already
got populated by `sequencer_init_config()` in case the user has
"commit.gpgsign" set in their config. This creates a memory leak because
we overwrite the previously assigned value, which may have already
pointed to an allocated string.

Let's plug the memory leak by freeing the value before we overwrite it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c              | 1 +
 sequencer.c                   | 1 +
 t/t3404-rebase-interactive.sh | 1 +
 t/t3435-rebase-gpg-sign.sh    | 1 +
 t/t7030-verify-tag.sh         | 1 +
 5 files changed, 5 insertions(+)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e3a8e74cfc..2f01d5d3a6 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -186,6 +186,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.committer_date_is_author_date =
 					opts->committer_date_is_author_date;
 	replay.ignore_date = opts->ignore_date;
+	free(replay.gpg_sign);
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	replay.reflog_action = xstrdup(opts->reflog_action);
 	if (opts->strategy)
diff --git a/sequencer.c b/sequencer.c
index 0291920f0b..cade9b0ca8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -303,6 +303,7 @@ static int git_sequencer_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "commit.gpgsign")) {
+		free(opts->gpg_sign);
 		opts->gpg_sign = git_config_bool(k, v) ? xstrdup("") : NULL;
 		return 0;
 	}
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f92baad138..f171af3061 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -26,6 +26,7 @@ Initial setup:
  touch file "conflict".
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
index 6aa2aeb628..6e329fea7c 100755
--- a/t/t3435-rebase-gpg-sign.sh
+++ b/t/t3435-rebase-gpg-sign.sh
@@ -8,6 +8,7 @@ test_description='test rebase --[no-]gpg-sign'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-rebase.sh"
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t7030-verify-tag.sh b/t/t7030-verify-tag.sh
index 6f526c37c2..effa826744 100755
--- a/t/t7030-verify-tag.sh
+++ b/t/t7030-verify-tag.sh
@@ -4,6 +4,7 @@ test_description='signed tag tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
-- 
2.46.0.46.g406f326d27.dirty

