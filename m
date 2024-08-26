Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E5129A78
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656951; cv=none; b=FaJI1XZy4l6FbuvDpWgd3hBpQpbOQJBH8RFuDFkGZC7suJItLmMNcxO1v3MOYFkz72PDk7LjNxmF7PNafTwOlPeH6eeM0h5ii+xx9RjwbkWFMtoJYuUaDiUjwuvM5yC01369/fC5t/FSHHyGZHb/YehEArS+mbFsM0xjoJ1R38Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656951; c=relaxed/simple;
	bh=10a6V5mRoAIbT5wQ+ApufYFoexwk5I/3W2uf/VusFFI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUwgsHAKG0RBeZgNoSfnMfI49XUR3RP1GiKA2B11bmctXfymFlbkYI0hCoxwd83b+rXQwlowLVWF7pqJLYDfYxxcdFRGy4A+81nQPURSN8qbmH11eocje/1HmaA4E7HvscLRp9tWAkEAI9eFmw/PPZSrRPwnzKFIMBvuPCr0c1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iHmPLB43; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s9fHS4o0; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iHmPLB43";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s9fHS4o0"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C2ADC1146D06
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 26 Aug 2024 03:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656948; x=1724743348; bh=dGATGYv0rC
	S5j9inUVNo7PDoHS47L+j5MH9qWUlk2ZA=; b=iHmPLB431Viy5BhzrzSBrMccjI
	dA1dw3xENiX/A5TN6ygB73IcZyMYOOGa07gjZhqEt3JDB9QU1TNcp6xyDET6JstF
	A7RrhfCTNUy+bPiHC2dlkKnIARUCxEY1Hg3W+wV16EGBSYTr5T6cTHZNe/jFv6Bd
	kPLodaIwzLPLMNqEur5QjXbmfztQlY1A/QYVKPOXAsCxfqmZn5/nTs10VDR9mTct
	vRz9AhwVp3FHWW2OKktd5q/gfVJotcpa+ojwA/vPwv43P9J5do4dnApYwF7jXdFp
	jXDYQr2TCUMMWIV14ktb/MYHTugILVcfiEjT3PV8YwFtq++H6AhzgYUV/uiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656948; x=1724743348; bh=dGATGYv0rCS5j9inUVNo7PDoHS47
	L+j5MH9qWUlk2ZA=; b=s9fHS4o0pIprVjfnhbzDgdWBcYAjgcf5Mz9TWHFqNGs/
	RjGv1G6KiJXv8eYGZ8ewrplPkSGmUuYK04RQRuRcOhiJHbZRViCMIqGK7D/+cT3f
	JQp9ZQaP7oAmy60p7vAlg5bwKyvMScNSKMQL2fZZzZQRYWmsfYO9Z1/8S3nJ/u8Q
	rxF1rHTc0HE6OfVFpHkTnkNBjcM6/67/sXcqa34wzzMTxCwxhcDsu559YZ8endBG
	e1rdX/uz9xR7LrAZVLIQr6hK9UnFUJ+On/5b9rad8xJUqJ0BIUaHiI4lVEb5VxKT
	+2de7658D3FT5uRnQE6oktiVARAB68+qO/6YGwuwnw==
X-ME-Sender: <xms:NC3MZkn8gVANuGlTTe8WaFKohnv3pno9x6HfFI7-mtIJAFg3S3O8hw>
    <xme:NC3MZj0dRDnE6cu7SNQDo_rtTu4KXYtHJz3k2xXwFuA6rSOLT_JbmoVwuzrpP4aDc
    vFHS3Rf_0jWN1wmKg>
X-ME-Received: <xmr:NC3MZiqZ4WXj9KPeYMaBWjw0ZosZwKGayTEaEDjSbYFt6o7A81o3jVNNtwGXkZvrKaun7IcyxXt1G27o6-eV5DCDsQbzqomaf8wGSrGlG8GwcTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NC3MZglfRfTFa4hdbMhbp1ykoMgx4n9-i2I5TEREIaO3QOKYoeFRRQ>
    <xmx:NC3MZi1Re_t8jMFm2sS3WUVTejTAS35eWvLmSCaNaACQJJB5ukAZ9Q>
    <xmx:NC3MZnua0jrNEJWGD4y7nCerZP4NcKVmmcmAF1S6ftQOv_3ogdfRJQ>
    <xmx:NC3MZuXZd8h7-_eX8x2flENpZK_imIeK4zzAh2GoMlBVyN8uqrcYAg>
    <xmx:NC3MZn_imwFOmFUkw0xXsKX-BlrT1j_zFfd87-5pUu22PN7avsCUe2rf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:22:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 44d14c08 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:22:26 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:22:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/22] builtin/pack-objects: plug leaking list of keep-packs
Message-ID: <017713f5a9c31994b18387d8e934fbab61e4aaef.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

The `--keep-pack` option of git-pack-objects(1) populates the arguments
into a string list. And while the list is marked as `NODUP` and thus
won't duplicate the strings, the list entries themselves still need to
be free'd. We don't though, causing a leak.

Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c   | 1 +
 t/t5616-partial-clone.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c481feadbfa..ab78d72e273 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4641,6 +4641,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 cleanup:
 	clear_packing_data(&to_pack);
 	list_objects_filter_release(&filter_options);
+	string_list_clear(&keep_pack_list, 0);
 	strvec_clear(&rp);
 
 	return 0;
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 2da7291e379..467c46dccf6 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -5,6 +5,7 @@ test_description='git partial clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # create a normal "src" repo where we can later create new commits.
-- 
2.46.0.164.g477ce5ccd6.dirty

