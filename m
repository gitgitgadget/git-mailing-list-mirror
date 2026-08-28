Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543D3AFAE1
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957535; cv=none; b=pqLNc7eD3U99p0FVq5YMV2e85bLYyBwUpMv9JubJKA11FedcNbCGxEhsZJYes8JA9J0Q2pDEDWUnO4LPzEE+lr7d/Xo1ruBULGmdVUdbEprgWbe4YRsSztl73oNZnUt/3tYDu/tPQxQNZMQFHbD7q8ugHPnSeaa/tCRfr8SoKB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957535; c=relaxed/simple;
	bh=OpvCDpbJrnfed/kLNghBHhkq5nGstmDnc9ASWaF3x/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQ57GRBssnHYUzsPVPU+DTegpjmRBr8v5XlIZQ+UUr+OCHyXOdjnISxgxn6hOMfaeNuhvoW7yt/AZlWGxdxhuAbTDpVytT/sC7x0rDXh835OQp8wnJYzd5Fw1VK5KE4Sc+2bPurRqWZAJsoKqvs63hUzM9GA8hsVu96GJ/15TwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ssQyp/re; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T9dg943E; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ssQyp/re";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9dg943E"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E689D7A0096;
	Fri, 28 Aug 2026 18:52:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 28 Aug 2026 18:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787957532; x=
	1788043932; bh=d1mg2z1xxkFF2Wy4QgDQXdsB0JQM14Qgskg1Gb389J4=; b=s
	sQyp/re3P2Fboo8n6mpw8UJ97KVHj2OY/sYFwrGV9Lk1Fb02OKdoZ0u67fP0ehL3
	Ig50qRi4Ut2Wd+OxW/4DHdt5kewHfStC97B6FzOjsdFvFR26KiQrSNLh+UfREu3L
	bFxw9GwyF5EBlYn7TL2DG8i1xuc/iBnRdFEShFfA/f7eb6CkCUBc12W7fRzfd5BU
	N/MKTsjm+Sk8RTjo7gZ18E4/77v1HXRHy2BjzSVV+NrmdqCqXmOhenzlklyhEGFW
	lzTM/gd12CZ505vRV2kT3ZpIECIQTUyVkRjSHx0v+kNfCULa7vq05pKch96Wg45O
	Aid88yu1nMxxq9j1obx7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787957532; x=1788043932; bh=d1mg2z1xxkFF2Wy4QgDQXdsB0JQM
	14Qgskg1Gb389J4=; b=T9dg943EZ2oZCgtiL+4Mt4/WMNxyf6ESTJwTdkyYj1Qt
	K5h8ppce8xIYReLXob9EaD315QZ62LxF/43iBl2tolh3AHuj6+JGW3O2T5bn5OpX
	IGV4A6YkzmAIXlySiKHyicw5lvDVeypDAcgiXAF57hEgG0/F2vO9W2UXxwyxUgqA
	3gf4cgsdklTZ06ofXbbjSW+90yqqaIxGy5u7IEwFGB0V00bpv9ViFr4xmqCD1yof
	cFvZ41D62kK4k7YgQIHCFvbdZADPLiORmCe/b7Ey52iSKQ30D24OOZkvus9RZRKm
	hQvAi4YlDCCy4MHOqbxLeWGs+Kjd7mq31CKdG9Kk5g==
X-ME-Sender: <xms:HBGSardi22CUzsvd78SNOwNhVZtvE21F80VLQ1XiDlue8CcfkvYR_g>
    <xme:HBGSanMRYePpOAjMtdOSKa138T87WOTJv-pydgjRaNEElfXbrsqW5ybD5HJ8yFAZz
    Pq912Yw9oTZ-0zWDHREOZU2Q7w-PUmaSEs0F00ANETYiTT9RsJvZQ>
X-ME-Received: <xmr:HBGSaiK2Tgp3CZHrv19nxFVT17JO9Rpv99LokQ7tXEPz16wf1UfGYlFjTS6NN5VeKomUBC8C-A3RvMm00DdLhlSNdNiVIpDO3A>
X-ME-Proxy-Cause: dmFkZTEC+LQSNrvb6E/M1Xll0EuUaS4YcEOHyU7TsRVWIW+NQMTY7E+vmioirGGvNQl4jA
    owPQNp1nmr/zh39kFmIJE1YssyS0h8se6+MSIHYg6w7oxBCDO5CM/zG42gSevsm1iQzpgo
    4xpJ7l6Fpl3IhZBppALJCr4SbUF+BpDWO283+tGMT/7Jk9fYxTp7Ad7msHZobwxjUK9V8P
    X/1o2zSHVxUEa4rJhJWoHrEaGWceEuk1qoqamZqqTrNQ7Xy/RtJRNu52YDg4SN2hm8kq9+
    05QB1LTaUCwEyOSc88uKmq1PzT8WLFQlzwa/MAXdoybCaJZFy8AHh7zk8SRV9lPgZOqfnb
    QNamYlAxGpvpk8n8BC9h55vxGD/kttIJNHf2JRm71fLck+0CLBH/q1DLFJxeA/ILDiWclG
    vsqyJBdkFc2nRNKTRQsrG1hkbTrCfKIAkpZ/CFmK6lcDrrqntfU6mfRZxwbiKVsQFM5Dp8
    dpp+hqy0/+rW6lG+88RwYwnd+cl4kXrASwRY5yESoEzV4mXw3HXUphDlem6FhOxfJdzlp3
    VI8Zxf+TtbTe5qQORHPh/4yEzQHsNYzpWDvBH12pv6hdHGKh9MU/+ij9bf9TxqnOAqJPTv
    dkZHx+p02A3WFsCjbV7cOizC4/vfy3KI3zO7NE9kus9e52AxzBnWJIMrvJ0Q
X-ME-Proxy: <xmx:HBGSaoFhWKaHxXrq8O6BdeUFJnrOAU5J9_zqX20EfFnKXhyCH3qeHg>
    <xmx:HBGSaqTn7eUGII7fT_KlDpEGnOC1VAElHL54O56aprhwbkn8zHPoig>
    <xmx:HBGSakHkMAVKWpcBj5iQGV4217HStoqz0jQoBMt8o2S3lSLtnMMEnQ>
    <xmx:HBGSam9IZMhDpPZczAFp0m9bf1H8fe9bzGdKJwnbLfUgB1VpdWKZcw>
    <xmx:HBGSam0YA2I7-IJo830uCQwnSx2KfbSGJQ9YEZ1toQiqXGbvDGewvtIK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:52:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/8] checkout: validate stage and merge option compatibility in checkout_paths()
Date: Fri, 28 Aug 2026 15:52:01 -0700
Message-ID: <20260828225206.310500-4-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260828225206.310500-1-gitster@pobox.com>
References: <xmqqh5kd3lm3.fsf@gitster.g>
 <20260828225206.310500-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In checkout_main(), checking that no more than one of --ours/--theirs,
--force, and --merge is specified is performed when pathspecs are
present, before dispatching to checkout_paths().  Checking out a
branch does not use index stages, so this validation belongs in
checkout_paths().

Move the incompatibility check from checkout_main() into
checkout_paths().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 14542626e9..e3d23256e2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -591,6 +591,10 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("'%s', '%s', or '%s' cannot be used when checking out of a tree"),
 		    "--merge", "--ours", "--theirs");
 
+	if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
+		die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
+		      "checking out of the index."));
+
 	if (opts->patch_mode) {
 		enum add_p_mode patch_mode;
 		struct interactive_options interactive_opts = {
@@ -2063,11 +2067,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 
 	opts->pathspec.recursive = 1;
 
-	if (opts->pathspec.nr) {
-		if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
-			die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
-			      "checking out of the index."));
-	} else {
+	if (!opts->pathspec.nr) {
 		if (opts->accept_pathspec && !opts->empty_pathspec_ok &&
 		    !opts->patch_mode)	/* patch mode is special */
 			die(_("you must specify path(s) to restore"));
-- 
2.55.0-884-g76cf8659c2

