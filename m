Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E891E7080E
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661211; cv=none; b=C0rj2hkWXJtqjNZJ5GRtw9vHdKkriRRDsqS4VB5HejNUDUBa549Wdv/xCI13MMDALg7Jy9AYv6hcUpV7VBH7V1Pqfqa+4sne4tJ7MnxxvYCLUK9i36DX/KPvX5qoT+Xokh89Z7IpwCgOMfn/TuCMZnWMcKBSrddJd+LG7BT5iFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661211; c=relaxed/simple;
	bh=mSCCTVEpY+f28IJUs4iq5xXkP+bb2jHAztdT5tcuaNg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GHNBn4ZMnhzwzVdzyaQTxAKO8sIEKg0hcaPmCSIG/DFGHzJIzYupdWehSALusW6iGvnqDphDc1VW0+LfBwHH00RaiHjdQ0def/7phLwxJmKsYYkramYoAyNuQ6DOqI/OoCkDdr3OMV9UxMyARx7UA5VHYJnY2Z3vcV2mqkKRG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pfGBPyJ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gAjfWvjU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pfGBPyJ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gAjfWvjU"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 151EC13808F7;
	Wed, 11 Jun 2025 13:00:08 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 11 Jun 2025 13:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749661208; x=1749747608; bh=yLMUxLRG0R
	e7ZCQnjlwDhPZKaKGcgra3i4Dsa8tYyU0=; b=pfGBPyJ+gaOlHdQKMRoYwtzEXR
	7jCYXTSIr6ZhHtoj9XcQ3MYGBBge5Y63Lq7gPmbYsMBDuBEqDSdO6DytLmaDkjns
	Hl39U42dZnslKHSs5R9yysPubiGYiU5r/DmRql6Ic2zNjH5xjMWgph02HyS32bcX
	Rd86IcePftKODq7eFP5SUDbAxlNqxdA07m3TDM5a2krrHuWvw1CeILRM7a34rpj0
	d9wNidkLX25zuDSjiN7tHw9xjkIZ/HHdYqc32ZeYA59hDQLPOXF+JfdKavB4DB0e
	GKMOi/uATEpMMXwd+EtLGWpIHWdy4qLjkf3Bn5uWy6chRsR+BXsH4+uSJQWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749661208; x=1749747608; bh=yLMUxLRG0Re7ZCQnjlwDhPZKaKGcgra3i4D
	sa8tYyU0=; b=gAjfWvjUlMpJTKccORidaQczn/HpknIpkvtz/f8Yb7kj++dFKZk
	NPV+fjM7oK1Ir7sbIuQwpHXFNKwW47MtvKMUbJ//KtUeqoMmt8KLVoXD6wK4SPIy
	4/mllY2s7T1nzhSv6IV9KprnS1viFWMDzSkyMJ4tqU/Bz+0Eceln4ZZscEybYe60
	Ni4ivue+AUBesce1QU0CMtIjN+djxE9LrltRQ6Vf1ykWV+wuN5wbNNTcd03/CZ4z
	l2i34N/vK0hOM/TJET0MFb75PfN4Hx5ZWOgBLmLgKAOpsTn25BVR2T8JgIwddzGV
	SO/D/oBlYr7qCKzxA+z5WFRORr9BI4BAitw==
X-ME-Sender: <xms:F7ZJaAkTpvSwbdnP0BYYyols62Q5XcJfOzRMXqEEueJ3Dk9HoP1nxQ>
    <xme:F7ZJaP1MEgLtsIQnaOPzNAt0aB5MKE9pfiiV4giuaPGk3QiGBtacqWUWFXwu1Re6K
    m8WAWyrvYTcY4FzHA>
X-ME-Received: <xmr:F7ZJaOptkqkKou0tylCXWJ0ogSBwLmcUudkI8VVNcwFL38rfDKqq55Oy7InI4shA8Ky-eNsXIRBxNx-aHm_0X_YVpvrPApmlHFgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekhf
    euudetkefgtdeugedvgfeuieeuvdelgffgfeekvdffuddvvdekuefhieefjeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:F7ZJaMl0tEbfExfa4iT5H9mEFZgi4EpDBvAFLmtVZjXLsSUKK9RjgA>
    <xmx:F7ZJaO0TUm9s8T1fbLedshn3-rFGRXSvPv2t8YvFnOpsHj3R5VAQrQ>
    <xmx:F7ZJaDsGPIkIbHzdAo83cOlMyq1sFZtqg2qOr_Mf1MSls-CjakxdFg>
    <xmx:F7ZJaKU6Kbd8qDAR0s5O6lOzkemqN1PNQosyGc92mc2wSUm3JLwekQ>
    <xmx:GLZJaMlldoa0U68AXSYSpvUqGA6FRc_SdXf5lV7Ok2X4UGZwLVdKBw9N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 13:00:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 2/1] merge/pull: extend merge.stat configuration variable to
 cover --compact-summary
In-Reply-To: <xmqq5xh6xlpm.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	08 Jun 2025 09:05:41 -0700")
References: <xmqq5xh6xlpm.fsf@gitster.g>
Date: Wed, 11 Jun 2025 10:00:06 -0700
Message-ID: <xmqqfrg6i57t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Existing `merge.stat` configuration variable is a Boolean that
defaults to `true` to control `git merge --[no-]stat` behaviour.

Extend it to be "Boolean or text", that takes false, true, or
"compact", with the last one triggering the --compact-summary
option introduced earlier.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * "git merge --(summary|stat)[=true/false/compact]" is a
   possibility on the command line options side, but options with
   optional values are generally frowned upon, so [1/1] is unchanged
   and introduces a new --compact-summary option.

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
index ce666efbcc..95842188e3 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -231,6 +231,21 @@ test_expect_success 'the same merge with compact summary' '
 	test_cmp expect actual
 '
 
+test_expect_success 'the same merge with merge.stat=compact' '
+	cat >expect <<-EOF &&
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
2.50.0-rc2-207-gc448ca4963

