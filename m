Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B6F2820CB
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203956; cv=none; b=Mt0Hxx8N850jUJhBr1hqi0nfUSmEwBcHb+shonw9QRX926f8jY78//7JR3Yyf0S0wCv43NEV+QmlfJ1RMOyn/Gj49BNNH5QswVN+MOb8JVXBVXRYuqAKpRTacAqNc3OGjeLCSZKs/2nLntTHt811qyEgAqPJVZukJPIpa76Q/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203956; c=relaxed/simple;
	bh=Au1C2f943e+l3BUiHKwtTgLdT9TUBGfpoXQ+blUCQkk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6SSHmHz1A/zvuqido4IY0MjI5n00A+MnzE1Ois9UcFuiOxOQt7kuxBGmwPHLyTLzekwuhMJNlTAyALBRdr3lIOi7FwxDaA4Zs2M6wFJxuetzIOqmgxHw9yhbtaKsyzshFKlqcQC72hkshvzbFG5YHGhGst9s7yX/L/3sNeN48A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F8pBoIvu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g/PhbBqc; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F8pBoIvu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/PhbBqc"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E8CD3EC1517;
	Sun,  3 Aug 2025 02:52:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 03 Aug 2025 02:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203953; x=
	1754290353; bh=TGzH4rf1FEXpU1qTwUWEt7Wr2N+Y4nPB/TCDDId3/8E=; b=F
	8pBoIvuICdVYj5AsWa4tzcBHl1lkyyAnskooB8jX6CjmMtbDeWH8hfEb7F3rw0bs
	kGp1NkA1MwU/C8WRJx/R8NZFU9P8fdQqwBoOQzDuPgTM6dnSsvPxvr6sI/F0mngb
	2hFbKBdv3LXDSxPa366bWjvz/J22kkCO7/E/jZJ0Iz/VfuSGTXOwg9dIaA3JfzH7
	1gwsrollIlXJUlUzHxQiS53+NA6NeFPNXjSp5vTImX7S1xKtqEOWL/UnzV0GQ3Zx
	w11RRWfDU779UV7ZBS26cntJ9znbZlqjqOz4bGZ2EovKaeRPmhzZgzXLNc0vKNfN
	6n5w9te+JhVfhav5I2ZfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203953; x=1754290353; bh=TGzH4rf1FEXpU1qTwUWEt7Wr2N+Y
	4nPB/TCDDId3/8E=; b=g/PhbBqcAMCY2XNDjAv84jeapKR87O60R2UGiNF/5Vig
	rPUoRJXripMFEi4ixtfBe1zrNiEPTBW15jBsF0YdtBQhlReIh7w7POYsmSP24W2Q
	EWcTk1Z8G9NvtsOoUHwpcEac4WaBvmXikie23Kdy0LsE1PoYbp4m3mwK0R/ehN1o
	zvJ+q1TsRy/sNN+CnyDl+MV8zdIO9mdtFhbEG5EFGsoRBQ6QdFen0HBjBHgbY0Ut
	87D6t4LUGmzOjviG2V2mm8YYgYRM+AnuO09EtfS+fxJfboCcKIHr2zdiEWkpvSBD
	2+irhPTSE2k3DDvwFvpIyGQoAgPuPc7AuLX1togLmw==
X-ME-Sender: <xms:MQePaPm5fzzkdFuGmlmDeuXleACRe_PuubRprGOrfnrhSM3Ezlyl9Q>
    <xme:MQePaDDbTBdGmZPuYDxFUuivHPfEjZyyE3e45L7J_dJ82DZhq4wvkG5BX8a2RKl4C
    dR4ezeQPXfRikq-dg>
X-ME-Received: <xmr:MQePaHe8wNAFL5y3aUGOCQvgP4faFty7ABc5I7COJL8f5ihQ6qA18mWs3GpR-ePYcKPsWKtc-jd3ufGMifAQoUhytLjqkcd7NSLc6LU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:MQePaGKm3eQTEZ91VNNYaRx5ts4FqvcHfGunoI7ce_U_NggFsQ9sqg>
    <xmx:MQePaCfPy5F-SVcI9heTykflNzEip5qs0kdmt8qOp7PBOQwQ0YKMJw>
    <xmx:MQePaF3wbNUIBXLL4MiiSnUuLI9SXVQ21tIR1NSkdTspbrRSqRXYxg>
    <xmx:MQePaDjd46zcJ2gcdH9JOnNwNdyGWwu1q_wpcQHzte9jENJynINcug>
    <xmx:MQePaCImGirz7uXYSJqlPleJn6AWmm3RQLF1WeIOhuwZIotDXYhREXk6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:52:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 6/7] string-list: optionally omit empty string pieces in string_list_split*()
Date: Sat,  2 Aug 2025 23:52:22 -0700
Message-ID: <20250803065223.3325111-7-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065223.3325111-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065223.3325111-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the unified split_string() machinery a new flag bit,
STRING_LIST_SPLIT_NONEMPTY, to cause empty split pieces to be
omitted from the resulting string list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 string-list.c                |  3 +++
 string-list.h                |  2 ++
 t/unit-tests/u-string-list.c | 15 +++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/string-list.c b/string-list.c
index 86a309f8fb..343cf1ca90 100644
--- a/string-list.c
+++ b/string-list.c
@@ -294,6 +294,9 @@ static int append_one(struct string_list *list,
 				break;
 	}
 
+	if ((flags & STRING_LIST_SPLIT_NONEMPTY) && (end <= p))
+		return 0;
+
 	if (in_place) {
 		*((char *)end) = '\0';
 		string_list_append(list, p);
diff --git a/string-list.h b/string-list.h
index 40e148712d..2b438c7733 100644
--- a/string-list.h
+++ b/string-list.h
@@ -289,6 +289,8 @@ enum {
 	 * it to the list
 	 */
 	STRING_LIST_SPLIT_TRIM = (1 << 0),
+	/* omit adding empty string piece to the resulting list */
+	STRING_LIST_SPLIT_NONEMPTY = (1 << 1),
 };
 
 int string_list_split_f(struct string_list *, const char *string,
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index daa9307e45..a2457d7b1e 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -92,6 +92,13 @@ void test_string_list__split_f(void)
 			      "foo", "bar", "baz", NULL);
 	t_string_list_split_f("  a  b c  ", " ", 1, STRING_LIST_SPLIT_TRIM,
 			      "a", "b c", NULL);
+	t_string_list_split_f("::foo::bar:baz:", ":", -1, STRING_LIST_SPLIT_NONEMPTY,
+			      "foo", "bar", "baz", NULL);
+	t_string_list_split_f("foo:baz", ":", -1, STRING_LIST_SPLIT_NONEMPTY,
+			      "foo", "baz", NULL);
+	t_string_list_split_f("foo :: : baz", ":", -1,
+			      STRING_LIST_SPLIT_NONEMPTY | STRING_LIST_SPLIT_TRIM,
+			      "foo", "baz", NULL);
 }
 
 static void t_string_list_split_in_place_f(const char *data_, const char *delim,
@@ -125,6 +132,14 @@ void test_string_list__split_in_place_f(void)
 				       "foo", "bar", "baz", NULL);
 	t_string_list_split_in_place_f("  a  b c  ", " ", 1, STRING_LIST_SPLIT_TRIM,
 				       "a", "b c", NULL);
+	t_string_list_split_in_place_f("::foo::bar:baz:", ":", -1,
+				       STRING_LIST_SPLIT_NONEMPTY,
+				       "foo", "bar", "baz", NULL);
+	t_string_list_split_in_place_f("foo:baz", ":", -1, STRING_LIST_SPLIT_NONEMPTY,
+				       "foo", "baz", NULL);
+	t_string_list_split_in_place_f("foo :: : baz", ":", -1,
+				       STRING_LIST_SPLIT_NONEMPTY | STRING_LIST_SPLIT_TRIM,
+				       "foo", "baz", NULL);
 }
 
 void test_string_list__split(void)
-- 
2.50.1-633-g69dfdd50af

