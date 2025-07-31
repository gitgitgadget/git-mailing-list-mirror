Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04BE27F759
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002485; cv=none; b=T/AF+XVwycDc4G0NA//wZL0r0DkmzAq9CQYhKtrPZUuigECZ9zbvCSt4H4l8CeytFg9AgR9CVyLlV0zCVxf1hqUiWdxI4OwlGWv9nvXGANa/p1SwZGsz7EkAOQLfo5bcz0H2nBfnCPP9jZKZCH+huQ+aA2fnxnhu09yk7Ocd4io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002485; c=relaxed/simple;
	bh=RBRpxqDskas5EvR0gvH+u8iGM2igcsbql1/sP8FzWIs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exxtD1b2C5bdCQda9HdHx3kHUcurFmqMvHcCwiNhh5RikCMih6ntjXogrvy2NQMw7cPC8sS8WyLj+zDGuKeld7oJN62h4T3fWQADha+foVYxJ3XL5qPRICmD5e5+fBxnREP/ReT17OQth0cOejBn/DOOun+g+GUwNrs61h7mMJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LS68RIV8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ERqCvG0K; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LS68RIV8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ERqCvG0K"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B83271400059;
	Thu, 31 Jul 2025 18:54:42 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 18:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002482; x=
	1754088882; bh=gKGpIUEu7K2g8863P1N8Hgt4BaawkBvrYQZubPRW9fI=; b=L
	S68RIV8TtQQJUzRioUZ6J2UBmq5J3RB8/PdWrAaeiYtdsc8YvGFUNgKT/OVv58yq
	cFwUjZ0KzLBkM3uDbmvmOVLqvRlj6iPNFru1a4q0c4MO/wVDmUpmnCPCiFSk/aSX
	DMEtTTPvQpsjl6UjrAYGaWZyAw81v9ayGKjMOQS540G08jkN9BPk1P6aM4NLW/XV
	gt0gIW4r7o2SvVVKERt2Xbz9YhElzVqHUA8hTLa2X7FZlcV2z0KB7G6WEjMC5nHk
	QY5rRA8F2EPWNRmt6jz8zGCWAxy+T462M9d6A37Zj3VjKxmshA0dCr4wYKJf7ka9
	hnrnZ2DcpFQwM4B7ZdZsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002482; x=1754088882; bh=gKGpIUEu7K2g8863P1N8Hgt4Baaw
	kBvrYQZubPRW9fI=; b=ERqCvG0KE0ybCsx2JqRN4jgUDUJJ/12yMQIN8+avUrOb
	HQbHVnQQ+/fZ1k80yBpnV0HcbBCl83Oe7AgoDD3mmmalt3eYvU+phO39S9ojhnqi
	vtWb8N7DqFTdrYuRyQkaXWx0FC/BVuH7c10CuDAPKFKEt0QxoHge+W+MVosbbUtq
	n49tYIn1UitsSu8pOkPe5mClgYZ+pSA7na+Fl5TQ+Vy1uXBlsIoJ8ZxzLCBDqrzI
	nA4x5D89MEEX9I1n7fGK81nyPBvUXsqSaR/KaWYSp1DrFdgQQfOxo+8zfHj10Kt2
	mo58n22bwER2IHVk+jJ6rPZymMp3HAa6qNoAhayqzw==
X-ME-Sender: <xms:MvSLaPmO-pVmFWkCgy-YLcZpB2lI8fr7mKdAwUVEYgTHbtl5OlGdrg>
    <xme:MvSLaDCM9-dDeR0yQ9BlHGD1-DTtzPa7jl4_I3DWY19sCPXOiySkRJmnrCOwWHNTM
    _TxXCPfpEko85_fJw>
X-ME-Received: <xmr:MvSLaHcZdDAOAPKpTJS0L2bIRJtyLXJ4N2DlbJGrZp8gxRCrETHlMuALGDXZMEjDHRtEQjyW36uYxzvrYfElwx0kRITxc1FflVc1WT4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepgeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:MvSLaGI_yoW2WF0Ebm1JVfWKn-C2I1jPz83L1SrJ1A_cN538gOnQ6A>
    <xmx:MvSLaCf0_rOvb9RWW7ohUysuVPVv_8c0STZKGRNQYkEbzaj815zI4w>
    <xmx:MvSLaF2xcXSgzBOWRqnPy1IYIaKAhlegi1lHBRSTgf6zx7mn5EQuXw>
    <xmx:MvSLaDgKUJNJzrn0M25ISiulHhQ1pW2-21KLKe2BZYQD1xZYgwwd1g>
    <xmx:MvSLaCJ7owpClw0Ig3zpQcBb14oqSVTKqmSpp85iZ870JiWiizsp77E_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 05/11] merge-tree: do not use strbuf_split*()
Date: Thu, 31 Jul 2025 15:54:27 -0700
Message-ID: <20250731225433.4028872-6-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731225433.4028872-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading merge instructions from the standard input, the program
reads from the standard input, splits the line into tokens at
whitespace, and trims each of them before using.  We no longer need
to use strbuf just for trimming, as string_list_split*() family can
trim while splitting a string.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-tree.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index cf8b06cadc..70235856d7 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -618,32 +618,34 @@ int cmd_merge_tree(int argc,
 			    "--merge-base", "--stdin");
 		line_termination = '\0';
 		while (strbuf_getline_lf(&buf, stdin) != EOF) {
-			struct strbuf **split;
+			struct string_list split = STRING_LIST_INIT_NODUP;
 			const char *input_merge_base = NULL;
 
-			split = strbuf_split(&buf, ' ');
-			if (!split[0] || !split[1])
+			string_list_split_in_place_f(&split, buf.buf, " ", -1,
+						     STRING_LIST_SPLIT_TRIM);
+
+			if (split.nr < 2)
 				die(_("malformed input line: '%s'."), buf.buf);
-			strbuf_rtrim(split[0]);
-			strbuf_rtrim(split[1]);
 
 			/* parse the merge-base */
-			if (!strcmp(split[1]->buf, "--")) {
-				input_merge_base = split[0]->buf;
+			if (!strcmp(split.items[1].string, "--")) {
+				input_merge_base = split.items[0].string;
 			}
 
-			if (input_merge_base && split[2] && split[3] && !split[4]) {
-				strbuf_rtrim(split[2]);
-				strbuf_rtrim(split[3]);
-				real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
-			} else if (!input_merge_base && !split[2]) {
-				real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
+			if (input_merge_base && split.nr == 4) {
+				real_merge(&o, input_merge_base,
+					   split.items[2].string, split.items[3].string,
+					   prefix);
+			} else if (!input_merge_base && split.nr == 2) {
+				real_merge(&o, NULL,
+					   split.items[0].string, split.items[1].string,
+					   prefix);
 			} else {
 				die(_("malformed input line: '%s'."), buf.buf);
 			}
 			maybe_flush_or_die(stdout, "stdout");
 
-			strbuf_list_free(split);
+			string_list_clear(&split, 0);
 		}
 		strbuf_release(&buf);
 
-- 
2.50.1-618-g45d530d26b

