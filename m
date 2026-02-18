Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EB51C3C1F
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 20:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771446419; cv=none; b=PdRuombMfgaWa+Ie2j/EA3nAGBkhJ9KuzZATzCqIwnk/w+paZVrOrAS45mQUuHxTi6Lgy/l8H612kMUXNBKgufqz5fXpDtsuYSWV0XL2+5Gpze+zt7NMK3TfEXa/actoC0+JCWBPx5giMVtE7zhsAogUcSSjquVqahACq7eEaS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771446419; c=relaxed/simple;
	bh=HYTGhvAvpFemNxLNg9cM1L/vwBpx/FGVX59MEkJEj5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RzugbuylDMAy+p6xwo7BqHL8IwfokuHdzMqqdDSBYC4IB195/OtTLwWCPDKFgEuEMJHdUyuJGtVZ6mdSUi3nTAPSYJaywAacbjlSUxLtmD68JVTzowRavnzZCBdcEOEoZJSPaxpcd0kfpdr40j3auus11JSzswqmYG41pQDzc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YFyXIW2t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZkdJkAG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YFyXIW2t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZkdJkAG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 79FE11400058;
	Wed, 18 Feb 2026 15:26:57 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 18 Feb 2026 15:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771446417;
	 x=1771532817; bh=9G6hrDAzynNtE7GSOHUwvOvmDnGCIgkJAW/tHeX9at4=; b=
	YFyXIW2teneQZbGHfZYaU8+Tzgt66v/J3Egjk2sCMo72ysNAvq5/f8YXyyo+gkm4
	+qy2k6yg78No2paUX9NEVwF3c2rT+Q595YW4YXNuCi+8gr0uENMTaE7tpM2HdFqZ
	AGtP9R0l8+snoWZAy9WdIjFV/remgmGyVKh1GaB1GT9Bi/GZrGdcA6USNcl5BSrB
	4gq/z2IX/7459pYA4W5wVI65ewF8RHEcfp66i2oOrMmbJ7n+FQXywGH3xza9dQVD
	EqgRZDY1kAu0kQiLdmwc1eeTG6cTQLMxXINfuXrKVan70NNYdoc6t9Wx/1ogVghy
	jzbfcvRq3+gocppHxP+kow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771446417; x=
	1771532817; bh=9G6hrDAzynNtE7GSOHUwvOvmDnGCIgkJAW/tHeX9at4=; b=Z
	ZkdJkAGZF57MwuBlu18DXfqG5jnu1V8Meg+h48dkn8xbEbPAeu0CjC0whsM1+iYw
	oQhUBSWIGqOn5cxZmWi7srrRU73y1yNXQNe1k1+GMCockjmsUEuarE8MUfJHMZkG
	MZUXlSOfMhlIPfdLtiHofIq/xypHtWbu2ZtYWhErnWPzBQ0mT/exMUY5dv75CoeM
	06nSXdcCnzC0cJA9Wn3KL/7yX2H3aBzOgNvsi4VxGcnttVLOVYzYJhsbpqaFUtSe
	3OF10S3bkV0SKxwnTueYofFcYMviu1DAIWc6V6dsi032wxaAzKofq4J7f+nyNyeN
	mbdnqhd5+GnpwpJMZ/InQ==
X-ME-Sender: <xms:kSCWaS2adlqTQoQ_coiFZ13LMRbdyVjHBJM8j4RfevSOIfzrsGRmZ7g>
    <xme:kSCWacgKUuyZ6dsFKbQf7xGQ1AIPsOFg52IsT3H5LaxBwCQIZG-VUuuLvgEm2mMmM
    bPauYQe1nHZlEJjNB_Bf81i9SGHT1PaIwi860v3E3xYVFwfb6Xc>
X-ME-Received: <xmr:kSCWaYRPfOlF06iLAryX4d789O8eV4j0x7Hrf6By3Sjv_KHV5zij20p_WklQSXSr4IXqo_n1-9SIp3ACZow2VdfuGAI9ysy6d9Bt1ERVz__rlY1aCWN3qBlPtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlvdefmdenucfjughrpefhvfevuf
    ffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepudelgf
    euieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffgnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhm
    rghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvght
X-ME-Proxy: <xmx:kSCWadj22MdZOte0VruB0MHxaeH3tMsWHG4D9EehKal3499Ba_OGmg>
    <xmx:kSCWaY6lqE6-B9tOFkNL54VkC72uNjk8EeKbUG7SNwsDHIHNHBmCJQ>
    <xmx:kSCWaaCSBdBkVF-lNELX2ohDQuN3aBPzPpWyoljdE_3RiCialR_Zbg>
    <xmx:kSCWafY3bu1vDb-bE8SkVHka-Q7S2YoiPdD-jJULgMvGIGTVjQ-kqA>
    <xmx:kSCWaRTgRUEGrSR2AYeussvlGOePXmmdtj5ObrJx8QL6znXmNlI_D7tF>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 15:26:56 -0500 (EST)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	peff@peff.net
Subject: [PATCH 1/2] format-patch: make format.noprefix a boolean
Date: Wed, 18 Feb 2026 21:26:17 +0100
Message-ID: <format.noprefix_boolean.39d@msgid.xyz>
X-Mailer: git-send-email 2.53.0.26.g2afa8602a26
In-Reply-To: <CV_format.noprefix_boolean.39c@msgid.xyz>
References: <CV_format.noprefix_boolean.39c@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

The config `format.noprefix` was added in 8d5213de (format-patch: add
format.noprefix option, 2023-03-09) to support no-prefix on paths.
That was immediately after making git-format-patch(1) not respect
`diff.noprefix`.[1]

The intent was to mirror `diff.noprefix`. But this config was
unintentionally[2] implemented by enabling no-prefix if any kind of
value is set.

† 1: c169af8f (format-patch: do not respect diff.noprefix, 2023-03-09)
† 2: https://lore.kernel.org/all/20260211073553.GA1867915@coredump.intra.peff.net/

Let’s indeed mirror `diff.noprefix` by treating it as a boolean.

This is a breaking change. And as far as breaking changes go it is
pretty benign:

• The documentation claims that this config is equivalent to
  `diff.noprefix`; this is just a bug fix if the documentation is
  what defines the application interface
• Only users with non-boolean values will run into problems when we
  try to parse it as a boolean. But what would (1) make them suspect
  they could do that in the first place, and (2) have motivated them to
  do it?
• Users who have set this to `false` and expect that to mean *enable
  format.noprefix* (current behavior) will now have the opposite
  experience. Which is not a reasonable setup.

Let’s only offer a breaking change fig leaf by hinting about the
previous behavior before dying.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 builtin/log.c           | 13 ++++++++++++-
 t/t4014-format-patch.sh | 16 ++++++++++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5c9a8ef3632..e56af7465ae 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1096,7 +1096,18 @@ static int git_format_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "format.noprefix")) {
-		format_no_prefix = 1;
+		format_no_prefix = git_parse_maybe_bool(value);
+		if (format_no_prefix < 0) {
+			int status = die_message(
+				_("bad boolean config value '%s' for '%s'"),
+				value, var);
+			fprintf(stderr,
+				_("hint: '%s' used to accept any value but "
+				  "now only\n"
+				  "hint: accepts boolean values, like '%s'\n"),
+				var, "diff.noprefix");
+			exit(status);
+		}
 		return 0;
 	}
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 21d6d0cd9ef..645ac402a19 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2541,10 +2541,26 @@ test_expect_success 'format-patch respects format.noprefix' '
 	grep "^--- blorp" actual
 '
 
+test_expect_success 'format.noprefix=false' '
+	git -c format.noprefix=false format-patch -1 --stdout >actual &&
+	grep "^--- a/blorp" actual
+'
+
 test_expect_success 'format-patch --default-prefix overrides format.noprefix' '
 	git -c format.noprefix \
 		format-patch -1 --default-prefix --stdout >actual &&
 	grep "^--- a/blorp" actual
 '
 
+test_expect_success 'errors on format.noprefix which is not boolean' '
+	cat >expect <<-EOF &&
+	fatal: bad boolean config value ${SQ}not-a-bool${SQ} for ${SQ}format.noprefix${SQ}
+	hint: ${SQ}format.noprefix${SQ} used to accept any value but now only
+	hint: accepts boolean values, like ${SQ}diff.noprefix${SQ}
+	EOF
+	test_must_fail git -c format.noprefix=not-a-bool \
+		format-patch -1 --stdout 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.53.0.26.g2afa8602a26

