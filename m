Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4B244160D
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261004; cv=none; b=JqyVSuMNGoAkSB7vO5KRI1UXSAkv2cO94sYssLK4W0cOv5aCPIOW9KcE1hzHcr9SG9C7ZcGr0y0R8iw4sV9SmY618WnuirhnDww29sRjKShzouVdmd1tw8SsYMt6UeQzWxXyz1stzo+DYdAm20Y9CECb5QiVgelEnCSfFITZn5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261004; c=relaxed/simple;
	bh=J2kRrCXjzuRjx+UTJXBOeatJfiQ1KHbhBTF2IX5HaQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ePWn1mDiZmV72AFKEOuJNzmC7SEhma33JIAL1hB5UuNSLVEPS6LeWigMJ7FD7pDmEoPhDINnEdwFOxg0AZvN8xrkAF1QC49UIoeWI3l9XSlI3qjVpsRMG2xlUHNIMUP0bNJVcnGuziBYA7bACKL1zDCKWmvPQFIgkKzZg9GO+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fxWfBq37; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Czu0G9yU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fxWfBq37";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Czu0G9yU"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3DB8E140002D
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:10:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 01 Sep 2026 07:10:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788261002;
	 x=1788347402; bh=AGeOz+oYNt03Nn8YivgCF/T5Pw5Lfku1ENnIxDrM4cg=; b=
	fxWfBq37QA5wfMtQjicRu08Tno61EaX2qp+msDDSJJ8pxRnZ5Sn80cEbcYjQs8aY
	nPTbAnzQj6vqe3gcPyQyl4RHgF9zIhULROdtaC9Pn3d1me4oyKWtBq5W7cqlUxFe
	SDcxQwuTR/zXJjkNflrAl0Uc77gV3DQ+Iu8nwlX3ycO4+Gn9O0IIO1pddYT8MX0y
	Hur5u4dulXPME7ExFxEH8Oa5Sq3YccupRuuRPRsaVS92MYw7TKqbCnGQq/AvEZuK
	pQoo19E5rksufNgCpGqEPKsw7oYwd1cNDdYw7q5S0A+f5bBDppMjGoBxJjjYKvne
	8BC64kPMT/Ts+pZ8blihJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788261002; x=
	1788347402; bh=AGeOz+oYNt03Nn8YivgCF/T5Pw5Lfku1ENnIxDrM4cg=; b=C
	zu0G9yUZqVgqgc3rCq/r2rWG7FswO5s47MdnfCTg5yByY/sf5YbmrYDlcPI98ToY
	Dq/UmUfKIITwQ08FcQWTt/x8vtIDujwdR61GEUV+VNxliYHr6u4HnkhGfee68pCN
	b6wSWbT3nnGgSBR0wYmzDLncQF93lbayfIwSuXOWhwe9VaW7Bw0m4e772CmGUARX
	51Az0Zwd+HsnYtC+ImtbpV7KD/8CfX7IR4TyoRPyDah+ykktjm23txqajZw+98BU
	IXrtcuf0KG8XYj6/lJO1H7xAO+eymhf8WKHYF2oRQA9vkuEnscdV4k/Zi1U8AeVB
	l4b5uvCvmvZpAoZijo2pw==
X-ME-Sender: <xms:irKWajl8mK9xVlynpMCVCKL4PfS7sugBlmveK9gqFNzvYame2X4elg>
    <xme:irKWatwutFyP7Z562exdRo3p25ou_kY6uvxg5v5-SwaMqpbysSVlJsaDRiFN5t1HC
    mORky_7eNNpkpFr0DreIE--YjnVW_DFMdiBKhM0zhF_t9zPrcp6hw>
X-ME-Received: <xmr:irKWavQGxNH79K89Z7tfSw41eSO-cR5FMlRhIi2un4PD66m12k0N8w>
X-ME-Proxy-Cause: dmFkZTEN9g1Fe0QNve9ECoP2TiUiX4EEH5POEiwmRiQIlHZ+xDbzHkU7NDd2M3NVK6/umO
    bXXkzUK3COWchLgt1/LK6gQ+MqeSaO5Oixh8RPOTrogDUVvdApPqyytnFYWyXEx31a/UW/
    VrRjQoyTePvVd8NFe+FYtwmzmG6MTjOdJtb92EaY7FcVv+MSIEhwv9SzJucvjBA0gTjUZ5
    irBlskFAJd/x0/Ql5UqM+PWol2xq0PhHqo6xS2QHAKohbPBqVxfe/t/HxXIdPstzFq1tQ2
    zZWYaDW+dfkh9KQoVCr2N9lwFiWtupwGIIOt/EhVGn/DGYrANZ/6T7aifXl4bC+/EDNaPT
    AMYs1jewkqIHUCWckD96X1IfR09AFFlFshiXinRO559n5SgTOh7/zuT0q7hWLaj6leqMUm
    VioR/zHF2AG/dV9E3JJo04zxbroVr3KZj7nrd3/nCJduJODC2FLCkqAj7h7GAF4qRrPuGb
    kPHELtiw7vSxGHHxlL2LED3DAdKsRmQNm2VsS0XX0XM80QxH7O/aqiaehkvIY8xxpcZFJ+
    4fP/jovwhyXIISFE9AKlD0BbYIMBofeuZjubmKJBeprHf2dYDzCwOfBu2M6MZ9wapYFvUC
    E77iFk867ay25CAnLP714eQXNsSSIiDgzHoqL46obr44SbyIWXWXx2mh9bcQ
X-ME-Proxy: <xmx:irKWaguvG9iZyv8qoJx_s0-MRwob5PdUppMWGNtAbB22MYEPtogAlA>
    <xmx:irKWahtfVmzhbp1FmLX3nyEPnc4e1LdRLGxcEayZFjEeGeLjxoEoYw>
    <xmx:irKWamytx5IdSabI9V8JeXm7Mywh92OEi2nY2jiX-d9J8lFyOyWd2A>
    <xmx:irKWanjoYnvQBYhWU9_Z_v93_yW_tmV2HhvXwrKbaD7UlFRul6AMDg>
    <xmx:irKWaj3XVekLAQEaGjqO4O_wSu1EDL33GBuEof_Qt6M6Dk5depsPjn0f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:10:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7984e0d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:10:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:10 +0200
Subject: [PATCH 11/12] t/helper: stop registering alternates in "ref-store"
 command
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-11-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When using the "ref-store" command we support access to multiple
different reference stores. As part of that we allow the caller to
explicitly exercise stores of a submodule. This allows us to verify
low-level behaviour of submodule stores, which is exercised in t1406.

When doing so we also link the submodule's object database into the main
object database. The intent of this is that it allows us to access
objects of the submodule, too. But that functionality is not even
needed anymore: when creating a submodule reference store, we will first
initialize the submodule repository and then initialize the store with
that repository. And as the reference subsystem doesn't depend on
`the_repository` anymore all subsequent object lookups performed by the
reference store will be routed to the submodule repository.

It is thus not needed anymore to register the submodule object store
with the main object database. Remove the call.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-ref-store.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 5a9a3053d9..db58f00589 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -74,14 +74,6 @@ static const char **get_store(const char **argv, struct ref_store **refs)
 	} else if (!strcmp(argv[0], "main")) {
 		*refs = get_main_ref_store(the_repository);
 	} else if (skip_prefix(argv[0], "submodule:", &gitdir)) {
-		struct strbuf sb = STRBUF_INIT;
-
-		if (!repo_submodule_path_append(the_repository,
-						&sb, gitdir, "objects/"))
-			die("computing submodule path failed");
-		odb_add_to_alternates_memory(the_repository->objects, sb.buf);
-		strbuf_release(&sb);
-
 		*refs = repo_get_submodule_ref_store(the_repository, gitdir);
 	} else if (skip_prefix(argv[0], "worktree:", &gitdir)) {
 		struct worktree **p, **worktrees = get_worktrees(the_repository);

-- 
2.55.0.979.g7e5102b832.dirty

