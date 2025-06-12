Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B6215573F
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749767147; cv=none; b=kr54nQuYeRwcZJPekA/K5NXnnJwG1KH+PQUL7Q+Ecu3xIUKtwdSO2q2DhFXY38IBJU/QHL0ZzcddKu1L9aMzuVR4O2N9ijHVbjgaw7HEJh0p7DqWK3OTGeIGQgKYLzYoyYTfxQ+bgiuk5Dv1KgkJpPPZSVR52hGZPDlAS/n8CZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749767147; c=relaxed/simple;
	bh=UaJREZqgIgQ5R1Z3qU9c17OqEVFvFJw8WnHqEdYwKqo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU7uVKMDhh2auQylbwCGov0GIEEgg8OpALn9AmBg/CTek17YXkZVgrHAc6EMUoOM0NBzpeJCCrVt66hTzlFF3sdiCtHC06IMjUAMv1JDM269AnNIQdMLUIE1w4go05Qe9zFKj422Ppu8JloVcViivB4xEVRtEV5fC8J6ZLAb+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=w1g11a9d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ydz5IERZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="w1g11a9d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ydz5IERZ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B1AE225400D7;
	Thu, 12 Jun 2025 18:25:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 12 Jun 2025 18:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1749767144; x=
	1749853544; bh=RYaaoL+zZZ4wPE3w2wtTqI7pmMEEi21xj09yh4G3G6c=; b=w
	1g11a9dx4wU+PLOwiVjJbR6kRNxxtTiD/cN7S+RNsTV6jl1rjiy/gWBBmpyfvH+h
	jo+G2gljldTo9xvVl9e1GEZhH+Z9+1jZ97rPIYbLkbiXjgTZUzFLfIx2eE6KebSi
	eG4pfzrQ83KPlfmzwhZZ1KuWeg+oSHMYKSIk0Q+yevZB3gIBR/GxgdkbMXQffywj
	cYoQrkPYbPRIj20c45ZkxTu4XO/ryTVRP2bNq0Js5xdnb2g9x82KxhmyxJSqPn7k
	E0W4HFgpSM/4yU5y8pgnDaZqfWdwSL9EcTXDiHqjvJ9czEObgERxmFeJvAGcfEK6
	vYSLksfuayCSi4BfUNusQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1749767144; x=1749853544; bh=RYaaoL+zZZ4wPE3w2wtTqI7pmMEE
	i21xj09yh4G3G6c=; b=Ydz5IERZ8ZMVveIOB34Dc0ebs7CMIiOdo6QckQDcioXI
	HCpaRAhhjfSKnnAXsGxe2oVCWOZ1mIYOvnSoVIzMU09OqufkZlovc7raxomAoxsn
	8TzFuKSlT6lP8147RVW07COUjbFr/ysOt4uzNEHlGDES/WYCtjfgTJmh9WJT9MkE
	XIkoUxWHms0HbgTCAq15NFo36OMVJcwI9XdGsHoC8tWGOPmjYV9OM9HPO97dzkCl
	U7jaran7TCh0CTkJAKxn6vnwP1+yCZIplmoeU2IvzOtk2rPbrDL2yS+Bu4zCVU9a
	hN4wNChAktb22PPCVuOKFxAWJVGialMhaFhrNaOTEQ==
X-ME-Sender: <xms:6FNLaOZn7YhKGaYleGn333NE9Uf1rZHQmL-zbbbLWTPhfhfll74GTg>
    <xme:6FNLaBb9axwmbRzkC9AIOKIi97QofmGjTIy7Uiqbgc-ifc1VQAvFa1tkIsHLwKkhz
    qxWSvSnSa6YaL4uPg>
X-ME-Received: <xmr:6FNLaI_eBHv754Ic0XFbvDXZvo2ByfxW3NMJTJtqEnQfs8s5n8yrzEtDFu2qYcAftOyYQ-VeZIYJrp2gWN99oP1Y_ULpApKAnAiX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduiedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeelve
    eifeeiueffueeghfevueeggfefvedvfeelveeuvdefvddufeekhedtfedtgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6FNLaAqpvjP3c-_KXXuWfjDKJx4Bi--ku0RRho9ODFXc_Wl6tMgjMA>
    <xmx:6FNLaJq5iBEf0ZfTg32ZIwbxozxAmaf_Vsvm0qQhI074DHvuJWdv8w>
    <xmx:6FNLaOT-1XS0JOv4eKpkiqUNLg9Z5r5-SxpR8nqlZbRHAgMFsIebJA>
    <xmx:6FNLaJrw6yZTWkBS6PPFiEXMss3WrYHLXgpfcRvZ_EeuVKrysKHmPA>
    <xmx:6FNLaCZtosNVVC2qSsTZHsTtCK-JANFgG8f_kjJFsxR6ytlbuBqTm6Ns>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jun 2025 18:25:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 2/2] merge/pull: extend merge.stat configuration variable to cover --compact-summary
Date: Thu, 12 Jun 2025 15:25:37 -0700
Message-ID: <20250612222537.2426059-3-gitster@pobox.com>
X-Mailer: git-send-email 2.50.0-rc2-255-gd84100c98d
In-Reply-To: <20250612222537.2426059-1-gitster@pobox.com>
References: <20250612222537.2426059-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing `merge.stat` configuration variable is a Boolean that
defaults to `true` to control `git merge --[no-]stat` behaviour.

Extend it to be "Boolean or text", that takes false, true, or
"compact", with the last one triggering the --compact-summary
option introduced earlier.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/merge.adoc | 12 ++++++++++--
 builtin/merge.c                 | 18 ++++++++++++++++--
 t/t7600-merge.sh                | 15 +++++++++++++++
 3 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/merge.adoc b/Documentation/config/merge.adoc
index 86359f6dd2..251a48fdf8 100644
--- a/Documentation/config/merge.adoc
+++ b/Documentation/config/merge.adoc
@@ -81,8 +81,16 @@ as `false`. Defaults to `conflict`.
 	attributes" in linkgit:gitattributes[5].
 
 `merge.stat`::
-	Whether to print the diffstat between `ORIG_HEAD` and the merge result
-	at the end of the merge.  True by default.
+	What, if anything, to print between `ORIG_HEAD` and the merge result
+	at the end of the merge.  Possible values are:
++
+--
+`false`;; Show nothing.
+`true`;; Show `git diff --diffstat ORIG_HEAD`.
+`compact`;; Show `git diff --compact-summary ORIG_HEAD`.
+--
++
+If this variable is left unspecified, it defaults to `true`.
 
 `merge.autoStash`::
 	When set to `true`, automatically create a temporary stash entry
diff --git a/builtin/merge.c b/builtin/merge.c
index 736739d3a9..65fed4b687 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -673,8 +673,22 @@ static int git_merge_config(const char *k, const char *v,
 	}
 
 	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat")) {
-		show_diffstat = git_config_bool(k, v)
-			? MERGE_SHOW_DIFFSTAT : 0;
+		int val = git_parse_maybe_bool_text(v);
+		switch (val) {
+		case 0:
+			show_diffstat = 0;
+			break;
+		case 1:
+			show_diffstat = MERGE_SHOW_DIFFSTAT;
+			break;
+		default:
+			if (!strcmp(v, "compact"))
+				show_diffstat = MERGE_SHOW_COMPACTSUMMARY;
+			else
+				/* setting from the future -- use the default */
+				show_diffstat = MERGE_SHOW_DIFFSTAT;
+			break;
+		}
 	} else if (!strcmp(k, "merge.verifysignatures")) {
 		verify_signatures = git_config_bool(k, v);
 	} else if (!strcmp(k, "pull.twohead")) {
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 2972922b6a..8046c6bb54 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -231,6 +231,21 @@ test_expect_success 'the same merge with compact summary' '
 	test_cmp expect actual
 '
 
+test_expect_success 'the same merge with merge.stat=compact' '
+	cat >expect <<-\EOF &&
+	Updating FROM..TO
+	Fast-forward
+	 file        | 2 +-
+	 other (new) | 9 +++++++++
+	 2 files changed, 10 insertions(+), 1 deletion(-)
+	EOF
+
+	git reset --hard c0 &&
+	git -c merge.stat=compact merge c1 >out &&
+	sed -e "1s/^Updating [0-9a-f.]*/Updating FROM..TO/" out >actual &&
+	test_cmp expect actual
+'
+
 test_debug 'git log --graph --decorate --oneline --all'
 
 test_expect_success 'merge from unborn branch' '
-- 
2.50.0-rc2-255-gd84100c98d

