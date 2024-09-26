Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D29B184101
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351194; cv=none; b=gdbNBdaLl4qElqOUxyBM7x74MvClcCpyvHE9eJbnBpwWeeuSE9ftvDhvf6nu4lXTfoJyzsJyoRKajA1GnKcCEG9Hp5Kb64SxyhkCEFeeTHymiGyTA5qb/BdeTWLlCIqRAEnAUVhQrOOq28cfdJ3Jsbdqp/7WESQ98Sz4g2E1T04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351194; c=relaxed/simple;
	bh=HDjqDwizK+SjvKJjEDDf2VPW/GeJMb6TCurWfoPtIYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWXx6na+70lmxzAqsa52pdaHwgYL8Tt7/u2LqNzdkmCDtFs6vGP2xUnnmBGwcUcwPFYn0vhbQ+57nLWKQqi2ABhqRyxQWQBhmd1Y0URDu9WtBjInfnmbhjir32/TzdllcyGSbCWh1IRhGrGXdYsV333zEY48+Rp4a1E4bP7D3gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sJ/CjrL+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qIPitmDO; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sJ/CjrL+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qIPitmDO"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BD37114024B;
	Thu, 26 Sep 2024 07:46:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 26 Sep 2024 07:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351191; x=1727437591; bh=ygYBHGbj1B
	YAY7PiiH9PleYauqmsPzrfI10wWmvES1M=; b=sJ/CjrL+TVEg70+iU7PSilLGSE
	25EKAP6VpNZ1gAwfMiv4sYJwvagpjCy8P4FeKzX2J1v1fSbUrV5T3Y8EkXAOTUy9
	hOUwSAKBD9huNiBodpRMsf7jSuhWeqo5ImM8dWwCRVMHfyavQrD8nL1Po/pZAYRI
	Q3ofj9JD34FY0QO192NqkjdfzasNCZ4GCct0jIklqgdha4FN56LU2ZyKznW5A6w3
	D1CwWvTIKFpWKeSTMlpMAr4zvq2S+r79vVDhE/YYeksOv2jEcWSmVDakkGY9AYBg
	NfCh7bcONzr2OtURTDUtamvs/gvTffD2LZJTj6M3Wj+7ICCGwDUbrOJiJDTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351191; x=1727437591; bh=ygYBHGbj1BYAY7PiiH9PleYauqms
	PzrfI10wWmvES1M=; b=qIPitmDO0iyBj1w/UwjHOFv4LHbBN2/yQN/QePCOlI0K
	SHj/i/03p4LLU1YGu4shtO/kALEjlcL5ZHuHn7yvMzVvbLsuR9K1JkZYg12FxxqY
	c3/8QMO0KXc1J17t348Z8+UmaNeAz/u2+08UbHnp1bq8E3y3qOj2N2MwQZ8vw0UF
	Citq+hILz8PmSX0iEkbgYVY69ElLqbMihnRLCUrQ2BOcR9OgvCaP1NfjEiRc6QEA
	7wGMwTjM674R1sIsDd6tufDnkGoSQ7YnUVcLFqf6PJhQluetmiDxgKDlyaDRV/sv
	OCPta95hPcg3NOuF8ZTaFSbGu+hL3dnqIqb9db206A==
X-ME-Sender: <xms:l0n1ZtRssbf761gfdxQ5kMB65GMxX3sBz9tr-sh86LXpbBJr_TA7OQ>
    <xme:l0n1ZmzqtxEUe96OjHO4376po_MFr5XIu8IkI1rdeeW2Hjb_cHK2Ndun7hgH4VlG2
    9G8N47R6ZIh4ycH3A>
X-ME-Received: <xmr:l0n1Zi0w3ILOWo33VeVf4fe99WH8oZ50HOOw-_0jZN0vufEqU3n3S3VD8GRYcCvZTCj_isnzHTefnFbZfz0IbFjrtDHLGPhIjKVk5k9QlE6zQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:l0n1ZlBdaD_RYUAJ1EAVD0kb7xABmWhN1gV7H0DCs0NiOyNMPHwxaA>
    <xmx:l0n1ZmhfSWX8f0G6rEMLUa1x7DO-1BjC4d7sLMUALNqpbjJTuz9ylQ>
    <xmx:l0n1Zpqru7DfOPBB-tOPCaFuytQLBcwajfShfo3JHq3CyuFZZkj0sw>
    <xmx:l0n1Zhj-qQwXFC4Fy1cQeC5rN8IcuyDO-kmLEB0YYzB_ZfHKWABbhQ>
    <xmx:l0n1ZnsqsLAw6ZYzgskxclSLpbesdMGn8DKeQcOIRYoi5MHrpI2hyNbn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:46:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fa7c2e17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:45:52 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/23] builtin/pull: fix leaking "ff" option
Message-ID: <2338b5e2a81b4036bf3740265126afddd2fbe6a1.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

The `opt_ff` field gets populated either via `OPT_PASSTHRU` via
`config_get_ff()` or when `--rebase` is passed. So we sometimes end up
overriding the value in `opt_ff` with another value, but we do not free
the old value, causing a memory leak.

Adapt the type of the variable to be `char *` and consistently assign
allocated strings to it such that we can easily free it when it is being
overridden.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pull.c               | 11 +++++++----
 t/t7601-merge-pull-config.sh |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 4c54d8196f..5d9d9e467e 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -84,7 +84,7 @@ static const char *opt_squash;
 static const char *opt_commit;
 static const char *opt_edit;
 static const char *cleanup_arg;
-static const char *opt_ff;
+static char *opt_ff;
 static const char *opt_verify_signatures;
 static const char *opt_verify;
 static int opt_autostash = -1;
@@ -1024,8 +1024,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 		 * "--rebase" can override a config setting of
 		 * pull.ff=only.
 		 */
-		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only"))
-			opt_ff = "--ff";
+		if (opt_rebase >= 0 && opt_ff && !strcmp(opt_ff, "--ff-only")) {
+			free(opt_ff);
+			opt_ff = xstrdup("--ff");
+		}
 	}
 
 	if (opt_rebase < 0)
@@ -1135,7 +1137,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 
 		if (can_ff) {
 			/* we can fast-forward this without invoking rebase */
-			opt_ff = "--ff-only";
+			free(opt_ff);
+			opt_ff = xstrdup("--ff-only");
 			ret = run_merge();
 		} else {
 			ret = run_rebase(&newbase, &upstream);
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index a94387a75f..7fd8c086af 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -4,6 +4,7 @@ test_description='git merge
 
 Testing pull.* configuration parsing and other things.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.2.852.g229c0bf0e5.dirty

