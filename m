Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82211209F35
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 06:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629675; cv=none; b=LBxfJD5WRtmqvLFEk1OsAAI7YKOsAA4bzkzC9dqFXvt/RK3UoJ+uMWg+V44KE1w5lb8r2GfnXC4d3gJP0/URevc5LfSPhxazYNjCxQHNiu0R+nUZyqcjwSDbOQ4YFd2ak8nPOjKpUimKEwD+CPnBZKARxTRyjRG5mI3Azm0CYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629675; c=relaxed/simple;
	bh=jJ7wKMWhn/cbe3mGH6jVc9x65MzJO6SSCf7suizBgxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJHilgm7j+IkSSf4ZrP5NHzJZoeX4gfq3mmTZ/NZxf9DwieihIrFNHYQPtPoiNGS/dlIRer559qmQVXWCy5lxtmwlZVeor5yHlLGRaA9+V5LYDlUtPb2wdERsYs2hbvx0KbdwvK4ixNdxvAlAQXlT30jNALJS4goELg8Fi2oZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ao2AxY69; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qNb5KG2g; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ao2AxY69";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qNb5KG2g"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A93DE114011D;
	Fri, 11 Oct 2024 02:54:32 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 11 Oct 2024 02:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728629672; x=1728716072; bh=ABdmqwpmgo
	uAElw/ia2YQyNjmI2rQlEBuZTFZdafW1A=; b=ao2AxY69idSzQI0tToWxdrI68L
	N8+y4oOmU9LrSgbUFcx8081l8P52RuwtoSiIaU9NKV36YIz2mcLtxGHQoeZQq1X1
	9TZakb0wCoOdyJsodsP6nhqAK2xLteWq5TAx5OpezGLqltOu6rQizm9gyXmLMu0+
	T58dJz+0Py8C9w6A4gRj1urJFjBjomv75heSwb9v/AQMchx2r8mEEQw/JICGJLR2
	ZyRmQSIPjhuIIq13yXDon540W9nrsUWjAR0X9Fvglq9STTKAMdBNfcErCXyp9Zbz
	bccljjgkofBrsSr2eL7dLdaIg1Li1oSwpoQ46kizxLdj+6eOph4NUCKDS3bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728629672; x=1728716072; bh=ABdmqwpmgouAElw/ia2YQyNjmI2r
	QlEBuZTFZdafW1A=; b=qNb5KG2gA0eD+sxSQiiP2tjM1l0rGAKZ+Cr01bJqhgcV
	6gMLr8M3pZntq/ZP12RtKODrqMHUxlAbeobahAAKsf29PCunnIC7iahgH5ebB4lG
	yKABKD/ku+1f+85XoxlL7liCvJMBjD/LBnzZ9dFkdMun9N98SFDVLUC01BE/eNOv
	O2wpy+Eix0MLTDDuVxIqyQFcjBrABvcMZi1aqXFgtVdXVbBMmvDErdsqgOGmfNaJ
	CmyLF7Xp/evpacdlNHitfFRp4QKKNgdFVJAv7UZo6dDaL5lVt0OJqr1IzciO4ppP
	+CI6HAz8d5p2tEx8VWwapP2DpWpzR9h2QkDbuvfp2A==
X-ME-Sender: <xms:qMsIZxOnn-bVXLZpQOmleUmc2FC0ajtLXiFWvxvCdXjw_TQi4DjF5g>
    <xme:qMsIZz9Rj2lM2GAX5ySOugi5n6kO8GGzQWmDWIceWpPWHAQCcye1SAUa7_W6T5udK
    lvnuufmSz5nw7j6lQ>
X-ME-Received: <xmr:qMsIZwSKeDT6o2YiGg_HRLMHyaLev7Ekg7D9uVbTienMcykn-Aj6EjQFM8W3xiv6nEMNxq8k_u6MoFE153qrTJ-j6-jwX_vZR1_wq3N4iBTYQok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:qMsIZ9vH5ZvQt-ENP2PNqzJpkGCjmJwx9OhWYmdj2bQMqOJU24YfXg>
    <xmx:qMsIZ5eejDZcbRBZFd6Ad3cyCqBZ7N6dtuVjTC0uP5YSkDexmR91hw>
    <xmx:qMsIZ53MdTYqJTj48KELaf7sK9K3N75Dpn8KTi8aWYykUTaEXyBPcA>
    <xmx:qMsIZ1--Vj-XAC3bTMWYsY1XdF-w9zVyBRA9_Zw8t8nOpsenJ2krXA>
    <xmx:qMsIZ6pHPtAMzQeRq00jOV4lra-1R8L7YJUvoWFDZYo-S29ThTbixT2c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 02:54:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e33ef3b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 06:53:25 +0000 (UTC)
Date: Fri, 11 Oct 2024 08:54:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 07/10] reftable/stack: adapt `format_name()` to handle
 allocation failures
Message-ID: <66ee431db464fbd1e2fdfb6a8c8452621908bfed.1728629612.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728629612.git.ps@pks.im>

The `format_name()` function cannot pass any errors to the caller as it
has a `void` return type. Adapt it and its callers such that we can
handle errors and start handling allocation failures.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 6ba48ddce5d..e94eb3c4685 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -623,14 +623,14 @@ int reftable_stack_add(struct reftable_stack *st,
 	return 0;
 }
 
-static void format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
+static int format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)
 {
 	char buf[100];
 	uint32_t rnd = (uint32_t)git_rand();
 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
 		 min, max, rnd);
 	reftable_buf_reset(dest);
-	reftable_buf_addstr(dest, buf);
+	return reftable_buf_addstr(dest, buf);
 }
 
 struct reftable_addition {
@@ -846,7 +846,10 @@ int reftable_addition_add(struct reftable_addition *add,
 	int tab_fd;
 
 	reftable_buf_reset(&next_name);
-	format_name(&next_name, add->next_update_index, add->next_update_index);
+
+	err = format_name(&next_name, add->next_update_index, add->next_update_index);
+	if (err < 0)
+		goto done;
 
 	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
 	reftable_buf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
@@ -893,7 +896,9 @@ int reftable_addition_add(struct reftable_addition *add,
 		goto done;
 	}
 
-	format_name(&next_name, wr->min_update_index, wr->max_update_index);
+	err = format_name(&next_name, wr->min_update_index, wr->max_update_index);
+	if (err < 0)
+		goto done;
 	reftable_buf_addstr(&next_name, ".ref");
 	stack_filename(&tab_file_name, add->stack, next_name.buf);
 
@@ -944,9 +949,11 @@ static int stack_compact_locked(struct reftable_stack *st,
 	struct tempfile *tab_file;
 	int tab_fd, err = 0;
 
-	format_name(&next_name,
-		    reftable_reader_min_update_index(st->readers[first]),
-		    reftable_reader_max_update_index(st->readers[last]));
+	err = format_name(&next_name, reftable_reader_min_update_index(st->readers[first]),
+			  reftable_reader_max_update_index(st->readers[last]));
+	if (err < 0)
+		goto done;
+
 	stack_filename(&tab_file_path, st, next_name.buf);
 	reftable_buf_addstr(&tab_file_path, ".temp.XXXXXX");
 
@@ -1370,8 +1377,11 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * it into place now.
 	 */
 	if (!is_empty_table) {
-		format_name(&new_table_name, st->readers[first]->min_update_index,
-			    st->readers[last]->max_update_index);
+		err = format_name(&new_table_name, st->readers[first]->min_update_index,
+				  st->readers[last]->max_update_index);
+		if (err < 0)
+			goto done;
+
 		reftable_buf_addstr(&new_table_name, ".ref");
 		stack_filename(&new_table_path, st, new_table_name.buf);
 
-- 
2.47.0.dirty

