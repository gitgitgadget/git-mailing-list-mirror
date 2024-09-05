Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70561990D0
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530936; cv=none; b=e+AC5VQJrK8rGhGH4DTJ3ihBDdUx+kQ5TJQayC6CABmdWzVsBK60k9jtsOs8KruPOSJEUTa6hjX1SheB3jSKLT4iuNRomtotPQ0HWF3V3ZFXnm6MRuDYXn18ypuzdf0lqPRLZuhCcoeVlMS+Yq5hnOe4aX2VvG8O+zy5DGbbi7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530936; c=relaxed/simple;
	bh=hLaDXSLIeqs7vwAZZ0T5B8qHjOQvSTyTl7686+5JYQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKeIuljfKiY0uMmMfFxxIm36Ri8DLLpoRe2znWHTfcbNoJhXVxJdutuoRDR6nd9RT8F/3lpk7ouIoEUjB0NNphCNvg8Qj9mdP8cYdfakAkJkzZQD0lplLjbwc3jW5JY1cvmz+xkeZ+SRz/NMhUn2mJMl4YNz5hIQOd8CIwH1l5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fH4DRzgg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMlYfBs6; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fH4DRzgg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMlYfBs6"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 11F881380348;
	Thu,  5 Sep 2024 06:08:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 06:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530934; x=1725617334; bh=oDPdQBH9rv
	zh5gXI25efy7GfVF+L3L2HLBt1Pb7ywhw=; b=fH4DRzggJXFTt2LtsEqbiTUGrI
	HTV8/LVKXLo2LXPe2YryCsieHPxHXYmM2IrSuUzMnONOK/qoffTgaFcQc5Cows0O
	tD9MIVvh6Aw/WLZpDGRPWu9wgeRnHRYqgOPK5GD+4JFG7BECJY7gX2UafQsrjUD+
	lMXnVH6HKItELNiJcv6VWru9mZY31NpJ62Y/GZLMets/ru3wPj5Tzv7pdLWZjGAh
	U9Q+NnQCpsUARyalpxLDeJyXtIqJXdkbWn/YuaS8rcS4T1d1UoEfu++tjyvYVR9Q
	3xTtDuuglXm66y+TWjtRLSaImYMNhrenfVoFnvgyowqsN522BvtDpb3r4zOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530934; x=1725617334; bh=oDPdQBH9rvzh5gXI25efy7GfVF+L
	3L2HLBt1Pb7ywhw=; b=HMlYfBs63W8AZ2QK8Ecvg6n1bA23C1tLoCzjJHV4gT+/
	sKUFoDlCKBlrU7VJM1Yw+nCtNRBKy0N9NpOPM4ErbUSD1gh+fXYU3ejPLs+pmcg0
	Yy8lmaWTrTOuSP5Dj7BrLeEXqdhghfUEfudx4AHsly7/VhpfpdATMBZECu8Ry1aL
	WlTRZUmc13gH0MbUc4wTgVnMEuApR0OrgsmM7SIZG4tHFwahldQEeoUF7O+Thp53
	srAW3sE5R+9FV2YDo08DKM4lebbNUU/5xsoguefXaMcgYvAwr7vAb502sPEZIKKa
	G+XioFRvmpL51okgsr5ZmslH1bqJS5/+H5EamiUqsA==
X-ME-Sender: <xms:NYPZZoGeWhLQ4AKUdKnZxJUYtkr5KURRU7FJnfLvSRspl3eSnbPj8A>
    <xme:NYPZZhV_33_CmhGUeDNZm-KnnnIGMPyva8jRQ231q2SO-akj5c_kErWR1_cFmS6Ln
    KZfXbTQ8vvDOKyUVw>
X-ME-Received: <xmr:NYPZZiJSEpOSr5kw_l9e61c8N4kCm318ImPvsahbSur1XlwOCH3PVGe4f2anlx9b3QfTBqjGGtUwNUNE1zrIf_rCuDGVqZyFnNPS_o1o-xAfc_I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    thgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:NYPZZqHw0oz6WNDh6iSABBpQMv_WZoCzQ8JBFCDzZm3kPDZ99W3RGw>
    <xmx:NYPZZuXesCho2wVxGkDKz8z_Vl3EHGliNwcDzuJPQR_ZXLSJl6pQrg>
    <xmx:NYPZZtNBk83hrpeD4myNAF0vUaRGRVC8SoM38fbxxdNd6taQ8emFcA>
    <xmx:NYPZZl0q-O9YbTuJotoMcNbgkJr9YW7qTJAJiZ09Su4JI0iX0KJtpA>
    <xmx:NoPZZgKmIDwjHqboE1vWK3BiKVWB9VKjwp0vZWdpf2_YvM9xnyP2CbTa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:08:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f65bb07f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:08:41 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:08:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 05/22] upload-pack: fix leaking child process data on
 reachability checks
Message-ID: <17b0c4b577afc0edbedb52299528c89e65ee5a92.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

We spawn a git-rev-list(1) command to perform reachability checks in
"upload-pack.c". We do not release memory associated with the process
in error cases though, thus leaking memory.

Fix these by calling `child_process_clear()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5516-fetch-push.sh |  1 +
 upload-pack.c         | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 9d693eb57f7..331778bd42c 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -19,6 +19,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 D=$(pwd)
diff --git a/upload-pack.c b/upload-pack.c
index f03ba3e98be..c84c3c3b1f5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -709,10 +709,13 @@ static int get_reachable_list(struct upload_pack_data *data,
 	struct object *o;
 	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
 	const unsigned hexsz = the_hash_algo->hexsz;
+	int ret;
 
 	if (do_reachable_revlist(&cmd, &data->shallows, reachable,
-				 data->allow_uor) < 0)
-		return -1;
+				 data->allow_uor) < 0) {
+		ret = -1;
+		goto out;
+	}
 
 	while ((i = read_in_full(cmd.out, namebuf, hexsz + 1)) == hexsz + 1) {
 		struct object_id oid;
@@ -736,10 +739,16 @@ static int get_reachable_list(struct upload_pack_data *data,
 	}
 	close(cmd.out);
 
-	if (finish_command(&cmd))
-		return -1;
+	if (finish_command(&cmd)) {
+		ret = -1;
+		goto out;
+	}
 
-	return 0;
+	ret = 0;
+
+out:
+	child_process_clear(&cmd);
+	return ret;
 }
 
 static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
@@ -749,7 +758,7 @@ static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
 	int i;
 
 	if (do_reachable_revlist(&cmd, src, NULL, allow_uor) < 0)
-		return 1;
+		goto error;
 
 	/*
 	 * The commits out of the rev-list are not ancestors of
@@ -775,6 +784,7 @@ static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
 error:
 	if (cmd.out >= 0)
 		close(cmd.out);
+	child_process_clear(&cmd);
 	return 1;
 }
 
-- 
2.46.0.519.g2e7b89e038.dirty

