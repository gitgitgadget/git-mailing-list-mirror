Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139B208993
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624762; cv=none; b=ALD8XPSDFrRlcZd4tPuAZFkVjSHd54Lg5qWZIAGqPilQJ5qFKRq1Dioy4U9np2CY00Tq/p4jA4uY7YoY2dG1Zs/UdqkM8Q5XrQeejf4ZZeZ/I9KgkgshryX89b+Uo9NX+qWRGd1bqeYvnNhQFajwuwJqRpHkV6CdhYzaOR04QY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624762; c=relaxed/simple;
	bh=uGVslUYdt/uDwZUxtKTdHrcHada0/VnuDqYlTcFKQhY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tG1qOg4MViyvYIeJJZQ8wsYhCIWTgfOf+Km7FbEWHIqX2JLAquvQXxANJvdlJ7Fu1E3EetcQLlsLS4cAvRp6ftsBihaMD9hYEDFDtvSppvNJw5T0Js4ckmpmoXB1xy23vD311SHzH6nRd0kb2d0rcN6ksc6SQ+nepgYVQQ1vbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OPVB0GgF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XStCzRR1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OPVB0GgF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XStCzRR1"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id EA719138019D
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Oct 2024 01:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624759; x=1728711159; bh=IkbFydlBJt
	CbeeAxjfuGaV6+f7pnlS6r1oCsHP3w6LE=; b=OPVB0GgFs8Fg0FdP55uqL3ZZ1O
	U+DVyYcC5oLCLHtOEfvvFdpEgoM3y5Ue84dQfHhCpNQ/Hh0tWwN08GL2zDxz/cUj
	AKlK7YBU74CPceeL0qd304m3XE98PJe3eygDvZ3Zn4/+jXd5KO+Y7xaocQWpSzmZ
	6pCEnejA56TdEcdH1ifoh+bMjS9U91sUx2g0z6drPSYz+ivqB95MfnoSDDbefe6y
	pqa01s3rqSqvFCy7BopuIPTMw1LtHAMhwoVIA6xs7t/Qux4sWKTEdS/MbdX7DT8l
	ooEu1lql80vBRrJ6SFlSUMKHR7SoZcTLv4jiR1qWdeNJ8TfPP2Qioi+X9AhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624759; x=1728711159; bh=IkbFydlBJtCbeeAxjfuGaV6+f7pn
	lS6r1oCsHP3w6LE=; b=XStCzRR1GtALT+y6cqR16OY7nQ9PLbnjWDfAAgGjshTZ
	mFAwaU37DCQscSPTALPynA3IfFCpooB+biDzJr1ctdrLdrCFP/V29RGdUXpp62Wy
	OuytczptVMSanc814Z8GLj3wltfM7nKz+SETPCRQtK8TeEE65eZqLCtHyYs4MxoW
	+ytyMB+xSjZAl4euDwo84W2PQb3sA6sMvTnuTV5XCBh0Begb2QxhOQGxnIu0HaJw
	KsitYIeis51U9+NfQO0z+Gt2rwGiA4Qay/jv3DfrNbizYoncYc6fvehUNz9DE10m
	+vLarPZtgrXsRnouAlJbRfTmUnEPycIUXhpHUEOS5g==
X-ME-Sender: <xms:d7gIZ6L1FvVLVjIYZXeteFdR2k-IPeHraTc6KXJ27sR5qNqrZXfI2A>
    <xme:d7gIZyI-xDD6xE5yKqhn4A-ujYeLEC2dYvrGuZIUcPNOm3Oe4ef-FfFbw54FM2xeC
    oAAixOy__igZ13lAA>
X-ME-Received: <xmr:d7gIZ6tYGc5xAGR2bFvQ5mYnI3jBoMYeSfvRt9iGcOTS4IyHLPHvUFUfuCmobTpZ7qC30ZMLFdvfWbwB8L1EkjiG0bbswatxauwTvOdQJ-COym0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:d7gIZ_bO-9LIOyltf1ZWHd678xmm_dKgzFTJ4cvx5uf7TFG_LShcKA>
    <xmx:d7gIZxbnM2x_x9oPxxd_3qofQPxM8pheVxCtdjSC9nLAYBnjlO_T9g>
    <xmx:d7gIZ7DE5VDOtAXdF-9VV2iG8d92eTVBOHbl0xn_OXTolhn8pQ4b7w>
    <xmx:d7gIZ3ZwaEUfjF-EMkYxGKoc1bJDscIjY7_NHwZgGvrP7yB_5Fz_3Q>
    <xmx:d7gIZwyD5WYgHErXvIh_Gv4A8q1NjaYowOWq5xsyRYpEKJ5eToBi3IrN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7cbec7a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:33 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/21] trailer: fix leaking trailer values
Message-ID: <ca5370d572d5750e5fb21c84d4a4134669e7e3c1.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

Fix leaking trailer values when replacing the value with a command or
when the token value is empty.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7513-interpret-trailers.sh |  1 +
 trailer.c                     | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 0f7d8938d98..38d6ccaa001 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -5,6 +5,7 @@
 
 test_description='git interpret-trailers'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # When we want one trailing space at the end of each line, let's use sed
diff --git a/trailer.c b/trailer.c
index 682d74505bf..5c0bfb735a9 100644
--- a/trailer.c
+++ b/trailer.c
@@ -249,17 +249,23 @@ static char *apply_command(struct conf_info *conf, const char *arg)
 static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
 {
 	if (arg_tok->conf.command || arg_tok->conf.cmd) {
-		const char *arg;
+		char *value_to_free = NULL;
+		char *arg;
+
 		if (arg_tok->value && arg_tok->value[0]) {
-			arg = arg_tok->value;
+			arg = (char *)arg_tok->value;
 		} else {
 			if (in_tok && in_tok->value)
 				arg = xstrdup(in_tok->value);
 			else
 				arg = xstrdup("");
+			value_to_free = arg_tok->value;
 		}
+
 		arg_tok->value = apply_command(&arg_tok->conf, arg);
-		free((char *)arg);
+
+		free(value_to_free);
+		free(arg);
 	}
 }
 
@@ -1114,6 +1120,7 @@ void format_trailers(const struct process_trailer_options *opts,
 		if (item->token) {
 			struct strbuf tok = STRBUF_INIT;
 			struct strbuf val = STRBUF_INIT;
+
 			strbuf_addstr(&tok, item->token);
 			strbuf_addstr(&val, item->value);
 
@@ -1124,7 +1131,7 @@ void format_trailers(const struct process_trailer_options *opts,
 			 * corresponding value).
 			 */
 			if (opts->trim_empty && !strlen(item->value))
-				continue;
+				goto next;
 
 			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
 				if (opts->separator && out->len != origlen)
@@ -1145,9 +1152,10 @@ void format_trailers(const struct process_trailer_options *opts,
 				if (!opts->separator)
 					strbuf_addch(out, '\n');
 			}
+
+next:
 			strbuf_release(&tok);
 			strbuf_release(&val);
-
 		} else if (!opts->only_trailers) {
 			if (opts->separator && out->len != origlen) {
 				strbuf_addbuf(out, opts->separator);
-- 
2.47.0.dirty

