Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0931C286438
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 06:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753944002; cv=none; b=NfglH8Pzqi6nHWjU+nzGK1qzT2vLubRYWWYEWgl31B62+ndtwCpXRVBU9gB+NcC2xyrHguduKtDFxZOkeCh5tSkdGoBa3kv4E7tLx5zqK5qMWu/E6YMUpg+FCRt0dH2ta1e3ctlSU4RAkea4s3pOUBfGFs94dAuZUJRvjLQrgU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753944002; c=relaxed/simple;
	bh=IiQPvoBsX2segOgXWwZBBv3MwY3CHdA3/GVzp3kBhwQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLKrBlEeV9K5FrH00lGzCWxEEF+AM9vprlphAeN7XPT1aMF+amBnMq3nbCz0WkslcSZNoBWhrH1zSTN7wlV6okOqALFJU05ng+5gT6zB294JtTQE0tZXzVapSBC6YmSbjOMmIA6g04+dNR23h9icuwIHlBmx632R92dHQaOLo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q2XsDYd5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fsjv39ln; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q2XsDYd5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fsjv39ln"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1026D1D00C0D;
	Thu, 31 Jul 2025 02:40:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 02:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753943999; x=
	1754030399; bh=ogxpMhRCiMilZJpEwQ7ruKeLkI3aM3PmkLXHCuGz/L0=; b=Q
	2XsDYd5OwK5t9Ymp0KcNkEJ8FBYsEWaKouKRf0SmIvzCTnjt/VYb1E0Aq9EwUvhT
	JgoP0TmpbAzW1fYllCR+k1hR0mctHCXH56c+ekqECd8s8C/H2Li8ooCZVwn6Uxtk
	3oHmCbDU6n8hU2gSGZGVK9EMvI5uhOHfjMjPBNa+8PfQiaOnIo5vXtAP2Xh6vjqz
	c1AOlOHV190XXv8CVEDIew/aSuMsFtmpswYKg3c8QH7iACVy3USC8UKny7lG8BQP
	VCRGzLQiMDEMJvYsHU8kRmlaDOllRoMVkIfIthEddg/jo2E1VQL7tNP5fGbKTjQw
	+1ZZkBlIr0dZw857AjiJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753943999; x=1754030399; bh=ogxpMhRCiMilZJpEwQ7ruKeLkI3a
	M3PmkLXHCuGz/L0=; b=Fsjv39ln1lb/vgG+G4fO2KnFMp9e2dWc2wfWF/lrGjbL
	pgP/evx92FM9dkN6dPw2zl7n3dodyPsWwCAnSsVaqD5TWcOtzoxwWli8wT5HAqzv
	6duMdXOLUWnYAgbn+vzJaxFSHzK67IkTYt+9s+XM+2Nc2rbepS2SMx801sGJb56y
	AQyW1s6OyjjuLtwVRrzQt4mEGroiCtGsPiP5xTcMkeJk12kOHW/a9N+qdzvl5aC8
	aXEPaK9DL/fqdit3C2Jck1y4Bw1vfrkA85JVdQ0KMnjvsrAi+4BZ8eBbI1HRDOiT
	mdbewCyTnlyPgTGnKF0zNZOpagrAoFQFV98g5IQ2Aw==
X-ME-Sender: <xms:vw-LaLHaERcxTlJP7RKKWAsI_I-fBiItvNtY2iD1Nj8DoxXDKaGFOA>
    <xme:vw-LaIgZiipyL75EfV9OP5-hzbVe7u067t8boXtQpaIBHz-Pq3sLADJetnzWrxdnw
    MIWWKCdCGyZ18LNxA>
X-ME-Received: <xmr:vw-LaO9X99BKbjOj7ajvBuvcLPYdsw7NyGYPXDq3vxv9jcfAZmi7_1hZv1iUAp8tUyCRAOyX2iiqfq6X_ggPBP4VjA87nNQC0gBvqZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:vw-LaHqoa242_PcSQ6Ba62lugoHtzAz7sxWwh07B6LOIIAXB2UtJFA>
    <xmx:vw-LaF9DRHdzi11q-yeRYnyHPhcs9ZvzPpwqQific6qLiksXKtLH8Q>
    <xmx:vw-LaDW8wHVTs2TUv7qGxzoJ0svqkcjiLgSuW3DaRcSD30g153K1iA>
    <xmx:vw-LaDC41XRMRl13ksjiCaPXj3p6_Ol98kQB6h3Sc_yrE8cV5rpdKg>
    <xmx:vw-LaNoCozK70rq-RsiaLPgz2pXx75Bs_U6YGwgL5QQVFD5ak3sl6lnS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 02:39:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 5/5] diff: simplify parsing of diff.colormovedws
Date: Wed, 30 Jul 2025 23:39:49 -0700
Message-ID: <20250731063949.1601669-6-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-612-g4756c59422
In-Reply-To: <20250731063949.1601669-1-gitster@pobox.com>
References: <20250731063949.1601669-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code to parse this configuration variable, whose value is a
comma separated known tokens like "ignore-space-change" and
"ignore-all-space", uses string_list_split() to split the value int
pieces, and then places each piece of string in a strbuf to trim,
before comparing the result with the list of known tokens.

Thanks to the previous steps, now string_list_split() knows to trim
the resulting pieces in the string list.  Use it to simplify the
code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index a81949a422..70666ad2cd 100644
--- a/diff.c
+++ b/diff.c
@@ -327,29 +327,23 @@ static unsigned parse_color_moved_ws(const char *arg)
 	struct string_list l = STRING_LIST_INIT_DUP;
 	struct string_list_item *i;
 
-	string_list_split(&l, arg, ",", -1);
+	string_list_split_f(&l, arg, ",", -1, STRING_LIST_SPLIT_TRIM);
 
 	for_each_string_list_item(i, &l) {
-		struct strbuf sb = STRBUF_INIT;
-		strbuf_addstr(&sb, i->string);
-		strbuf_trim(&sb);
-
-		if (!strcmp(sb.buf, "no"))
+		if (!strcmp(i->string, "no"))
 			ret = 0;
-		else if (!strcmp(sb.buf, "ignore-space-change"))
+		else if (!strcmp(i->string, "ignore-space-change"))
 			ret |= XDF_IGNORE_WHITESPACE_CHANGE;
-		else if (!strcmp(sb.buf, "ignore-space-at-eol"))
+		else if (!strcmp(i->string, "ignore-space-at-eol"))
 			ret |= XDF_IGNORE_WHITESPACE_AT_EOL;
-		else if (!strcmp(sb.buf, "ignore-all-space"))
+		else if (!strcmp(i->string, "ignore-all-space"))
 			ret |= XDF_IGNORE_WHITESPACE;
-		else if (!strcmp(sb.buf, "allow-indentation-change"))
+		else if (!strcmp(i->string, "allow-indentation-change"))
 			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
 		else {
 			ret |= COLOR_MOVED_WS_ERROR;
-			error(_("unknown color-moved-ws mode '%s', possible values are 'ignore-space-change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-indentation-change'"), sb.buf);
+			error(_("unknown color-moved-ws mode '%s', possible values are 'ignore-space-change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-indentation-change'"), i->string);
 		}
-
-		strbuf_release(&sb);
 	}
 
 	if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
-- 
2.50.1-612-g4756c59422

