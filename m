Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A21A9B3B
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109994; cv=none; b=IDQImiHBiZ8EJdfkEk79IuJu2m6u8XNEDyM2yJTEk9R3Z508VRA/gubCXhRQ7sS5/lODu8KEyJUGDX0NmPUtFLxvkeN1+b96R1vXXSk/FZQobd5PAi9xCisT9xhBAnvCMzlHj9wJNL1wJksfzvTO0pf1R5APnpLoWIQM4s+S9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109994; c=relaxed/simple;
	bh=7YYTsdd3Sf/FRtJoml7yEt7Dke1UpYAbpeqQznie5GI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nfEfRTK94ZMLHtElRtFzFigU+aoNLGmApear01whJznp26LwwON7RG42quh09GsXuekFFdzhGvheHZeSeS4X9N4kib8BzWJeB0hDlWIGld0Pv3chm/8TaaxPFDaC1YCAQMWudzqFD+y0ZTCo85IozpCIt32XkmCUhdThOUu40bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qkMGHS5U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v3cvqClt; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qkMGHS5U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v3cvqClt"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 0D51F13806CF;
	Wed, 20 Nov 2024 08:39:52 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Wed, 20 Nov 2024 08:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109992;
	 x=1732196392; bh=YtrT4UbD15UC+333kta4YW5o3r6/9t5+K+4ByaPZtyY=; b=
	qkMGHS5UBheX/KTKQ4qmjHQrn5tmfX2hv2kxh2NaAmpf7AiiXF5gA6jR8SIcmnlY
	L3Zegtm2RH8HvR6uyATbpGgAHlOBnxPLZyPb2h0bVSFv0v8dPYAxReXaw2sQCy7M
	ej4AIxXH25D4q630jdk2tv1HD6FGT81qT2Z/svgeT9wFHl6wfyO2IYcXDjsc0ZlL
	3Wx/zdjeCHWFP7WC97+d933yl7W5QzvA0f3p5YNJHi3eBoSLNbuOYBYuDEHR6ziP
	mIGwe6EslonaIBIAQetL0jv7dfo6qzTVSEAdXLvqLaSFwGoRnvBvnR4a+HGHi/zN
	Qrsu6Fyc1w2/1Og+Ou4MIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109992; x=
	1732196392; bh=YtrT4UbD15UC+333kta4YW5o3r6/9t5+K+4ByaPZtyY=; b=v
	3cvqCltTPAGwhvZ8Vya11NoxanWpwMi+Z9AW0I8KdCpskipR5Zhhi2fTgcR9pdzL
	nM6b2CONIf6XHuDFA38osZ0TTpjYgxhDGPTsPeX9wukEdLv5cW68PbK2Tjcq0o68
	sWMWtj4e1ZAwBP5IXBRNPUbhwofNPY4N6rAW9t5eW7RrW+qvOA7ah5GMewFU0h27
	IxvWTaN4jiEh5A9IKAtb5eM0Ke5sx7ndFobJUTzMwdndpLZli9ZeHnBw7/2WIjCG
	9DK9dCVSkIioKi4/Tu7hYAyp4a7MZzB1xtg0USaxCr/iiuJkTclfPGvteEQXY+9H
	OsYXvi3DGTJbOxsz6jDaQ==
X-ME-Sender: <xms:p-Y9ZxNFxjSvxSySbtIM5ve7GRahHj1vRPOwhq4AyiOB-GDUAU3iAw>
    <xme:p-Y9Zz-X9AlC_azojfLZEqQbiM_uxqCK5vT9NbQq-PZDEsDPqRBlZIs4MrFfrdGQF
    YnaAqkuHlKq84plLQ>
X-ME-Received: <xmr:p-Y9ZwRYewSlNBug6r1EY8rodqDKMi1sDknUhSAqVqIhgkkiDHI6-gY64urPEu8F8KKtTmwqDYSzjWwV8l7N1DI7psLySiiYy4z-G4WIGKdc9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheprhhjuhhsthhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:p-Y9Z9t9K5paZ_ULGwtwT4qkfiz63MJXpOuqaKbgfZ2viIfvB34W5A>
    <xmx:p-Y9Z5ccv-OqRXLWll1esqzzp0xTAHfrkhObsQiy5Zyy88T-Ti6vrw>
    <xmx:p-Y9Z51yKXof2u4fWOYL4OZyDpmf4U9yOBw-QJzab96Eg4vSsG4fHw>
    <xmx:p-Y9Z19s-IEEF9y7qdGN3Lt8SeXKiIULLZA2RZutxcHOkfl1wk8tNQ>
    <xmx:qOY9Zw6IAQwg9CArtya62nEieS4kFX0hzTxkwEAGxC4AjD2RGq0uCpBs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fe9d6596 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:38:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:34 +0100
Subject: [PATCH v3 05/27] bisect: fix multiple leaks in `bisect_next_all()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-5-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

There are multiple leaks in `bisect_next_all()`. For one we don't free
the `tried` commit list. Second, one of the branches uses a direct
return instead of jumping to the cleanup code.

Fix these by freeing the commit list and converting the return to a
goto.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 6dbc22f84fce11743f0e79eb4f8100c7ec07238f..04e9a63f11c7fa1a9dd11d3f193c500a4cb937c6 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1031,7 +1031,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 {
 	struct strvec rev_argv = STRVEC_INIT;
 	struct rev_info revs = REV_INFO_INIT;
-	struct commit_list *tried;
+	struct commit_list *tried = NULL;
 	int reaches = 0, all = 0, nr, steps;
 	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
@@ -1098,7 +1098,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 	if (oideq(bisect_rev, current_bad_oid)) {
 		res = error_if_skipped_commits(tried, current_bad_oid);
 		if (res)
-			return res;
+			goto cleanup;
 		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
 			term_bad);
 
@@ -1132,6 +1132,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
 
 	res = bisect_checkout(bisect_rev, no_checkout);
 cleanup:
+	free_commit_list(tried);
 	release_revisions(&revs);
 	strvec_clear(&rev_argv);
 	return res;

-- 
2.47.0.274.g962d0b743d.dirty

