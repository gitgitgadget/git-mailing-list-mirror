Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24872324B0A
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788122923; cv=none; b=U1MtvMXfIJz8nZtZNjZMw3/zr7m/mo7MmGlB7LFUNEvBA9zySxkGUpxwRRqGX3R3rZ1YKYMMoMYRAq9cESGijK6hEf4Gt3jbkh6rhCcPfv3WoCesAjfvs6IJMThVxZzc7kzCjOjBANcNoracW/xfqbvvP3XH+o8BEWOgKNXWwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788122923; c=relaxed/simple;
	bh=OpvCDpbJrnfed/kLNghBHhkq5nGstmDnc9ASWaF3x/4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8OLDp3o3WEiDt0bS4J8kQSAYJu0D/g+X6W0J651vIa5tGvE3RXN1Iyn6eHaLbzL2skgMCdp2c7C7esTkyxGE/M2DTRy2Tbpcrk3WnklWTJMFrxeTRfh/aFUOZLyPEuNaAwukGddtY33NMa4ATtTRXwB22SMv5oimcR3Xj7rOkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FsXrCJRO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WFYSdpRf; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FsXrCJRO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WFYSdpRf"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 49FFFEC0086;
	Sun, 30 Aug 2026 16:48:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 30 Aug 2026 16:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788122921; x=
	1788209321; bh=d1mg2z1xxkFF2Wy4QgDQXdsB0JQM14Qgskg1Gb389J4=; b=F
	sXrCJROLaebZvPClQlxqBk1wRNBIlZ+Lu7hu3HUqFPlKYOtGcntXmBLhpXFlk3DM
	WAal0hYf+XRaM+m+H8HYIanyATJEDPgvnxXQJsRHPP5xa06eegyplPqMP34mc2Hw
	g/9KK9ApVAggSab1qBCfpFUXWPDoWsuYmLf1DiTHxIfCgg+HyK/4nuoxWzb51h9b
	HZ1ljYtRpf5qyB0xjNtsFX0segu9F/hBtZrRjT8pR3pumwMWrYTj2ZvdgpuBtajZ
	nvsLsuX4PPEqMzi9gWP2JAHS/aifWHivVoPctU9lK7+tSVseP0HTFzaldyt4hnIa
	i5iho6SbTxWUjaeErZeZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788122921; x=1788209321; bh=d1mg2z1xxkFF2Wy4QgDQXdsB0JQM
	14Qgskg1Gb389J4=; b=WFYSdpRfzoV5u9cgfJKhXrsDzvY/cvYFfozfVHCAWC0q
	kAYacTwtuI3jA0lOKiDaEJUyKolR/ESFzA3m9AMsOSwrMF4pIQcjyTln+hc22X8D
	KxiaWJtX/fpbPiG5oB6hMsMouP1BhHDewq7xBKCJtmKt5P993o+ck7caqtaPfWLw
	fgrgHcOXJeXM8ReLySNRKfncCW4je9pfi1mYRlabNE55AMr13aELaORfa9WIt10k
	IxLv/pfKeEKjP8EoQWvJZtMLLUfXhcrcYENZhbDKdU9HeACAmqQe+sx1f/BAjhy2
	oFrI2xI7KAmsOt3Y3bYo8a85kLiZImn/lXOetIbXpQ==
X-ME-Sender: <xms:KZeUapGew14l3N4Ud0I2ZiDODbF1lAsqn1KMfxOq3kLl53qiGNpgnA>
    <xme:KZeUakVpAN4I1qrdv7jiqXanMb200vIvn3IRqjX53AEvRuPrb1ZQpqN_Okh4YDvBO
    1cTBsBoey_m-vDePdfqRNFiIrsmflQx1M0s4kOYW6E_5BRX94Lh3_w>
X-ME-Received: <xmr:KZeUaozGpfo55Ywmoc8qkThA9G0fKF_KgRkChvaVl7vSZwGWMONLiceacQtxsegMK6wP9VcG2oNPtWxme1P4KGtdA41tuJTiEg>
X-ME-Proxy-Cause: dmFkZTFScx5N3yID/Wd8piL81iio/vbFBvkFUjI0kIswckuEWS4J5hDifEykfqhESoeOdC
    mwVC8gsuMoEHcRCa0lvsSozaXSelQ6CrY0zT742PYgh1E2l/nRGebCx4/z1qYDE67jEG39
    /B2iVXiolehkRkNhZgPNwdXbXryA2vLv8f0n8e9ovVR6aOgUoOuueTLTatZkiWO+ay2+6r
    c0lcpVsTuIoMHKtwg2MuyTGIZdu33aW/DIf85hVtEgSZr+eNkyWfTuwnHkUaE19zISEs6P
    GdP8ByQrI20KvDmh30LXRH/4yC8jlRNe4SFbibbt/pnsMtVQm6k9k69VKYlig4q9SCItGW
    3iQNjC0oU23mXxSOkLzl7XSj7gauJXCR8MAyBk8+2huAx7sf9v9iFWx2dcDrYYJIAnXSwB
    vQ+5axjDa9ppkyIGZhBkb+nFUqAh40ShIogmhO8ZoixJXQbmPDPNsr8oJOwnTc0vkkr4+v
    oHfii4v4R+/HaM6XBIArLaPxT/6+scW+x9sQtuCESPWCx+7tGpNzY1fqP+YGKDRtCjfudx
    0OiCLEBdaFC8FntRU2vFtLO3AzmjyNWysj4Y5ZRd9SUTDsMSOg5zZaYkctsvU3wISbeOnB
    YgBuc5CitJxtq2up9xw6aIrYAZq4sGXqIGVq/J43+ggD0meNPQ9zC83cHgpw
X-ME-Proxy: <xmx:KZeUaqOa4UHYqckn8QHMnDDv9na17dTmjlsMUr3a6SqFinYF_D0jWA>
    <xmx:KZeUah7HB5BSp9lpfn9-ywrYpwyTdivJTmfB5oE5zRFuKI2yk0ccHQ>
    <xmx:KZeUajOndIG0--09S8IQtKKzXje6nnz6oA8KjdCG2WTRluO6zzJdDQ>
    <xmx:KZeUanm1eyXWKDEIZua-cYTUCqS76S6sT_-wZfm6T2zrsyEK6qp3tg>
    <xmx:KZeUakdJiOVmtub54npiHHsAd0ilT0ZnLI-c9kfaRxIIWuV2ifZ-ykmV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 16:48:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 3/8] checkout: validate stage and merge option compatibility in checkout_paths()
Date: Sun, 30 Aug 2026 13:48:30 -0700
Message-ID: <20260830204835.1040408-4-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260830204835.1040408-1-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com>
 <20260830204835.1040408-1-gitster@pobox.com>
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

