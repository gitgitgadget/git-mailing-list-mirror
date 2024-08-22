Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823DB183CC8
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318290; cv=none; b=AdumALrrbPdt+Wk2+yW6pJjTRKjv3pWZs3IhO75YPw7BNTpz+1aRWWf5zuvyZktlN21tQ3wCPKJp4nw5Ge79fzfknmU4qB+wNl4trCP0LkCJkDI60NUU36YSDETZro7yMTVICYO0HNxexACdB7wcvAxIlp2oV5dJeU1RGIKv4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318290; c=relaxed/simple;
	bh=QLPG/ImQs2pcRSbXlKo57qxLPs1KHvNODyorTa4JRDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCphEn4dP/T1abTnwPbU8WKgvwtfnJK1KwL9eAZOZ5infX2KoG08TaoneXCz3wHYVK0MhcbopWBA/JaaiWYEKo9CZ3k/KiTKTew7m/jqsAcPJ7hbR2rK3vTKX3zULj/jcGDCNIJnFeDgBGv9hyBNeZO80DNHtwTTU5End47DzJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tl42Dyu8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l0rNv/6/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tl42Dyu8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l0rNv/6/"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id DAA031390056;
	Thu, 22 Aug 2024 05:18:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 22 Aug 2024 05:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318288; x=1724404688; bh=LmZRIKtX9a
	uGvNsTj8OGDyx1pMfRoPXBFiMIdsEFrXY=; b=tl42Dyu8SA+5QDe+yCZsfQZUAE
	IdA9sCK+60J2Y0+AE2jjy6qDFOUfQ8OCIxzW+EzkohTMvv6iK2zuZI4af7UzyhLe
	hHpZ4sfcmxehUcfrVHvrKTNFQgxyFTM9FrWLerLIxOVXGLgqLtFVLUyzb9562OKP
	qCYLXrNLLYP9xweNoFv83O9lSa2JMX3BNfgGRRCtDqfLJL9X00kjD1f/bUJKJOgV
	7nAA2I9zJ/FoMrzNStEAx8Cmf0sa98KKevWUPfD8qP0d8WpjGHghh8KeJd47x0jH
	9nJG4Wld76Ha9wQlFbRpPtZAkOYmDC8eqRE+npZCCOf1/EoA+tX72O0EjtBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318288; x=1724404688; bh=LmZRIKtX9auGvNsTj8OGDyx1pMfR
	oPXBFiMIdsEFrXY=; b=l0rNv/6/zkhXOyY6NPFsZclbd1F0qvhVS3yyYXnEdxzt
	GWFYI6qC+6kddleR+S/rBB6ufVfoSgyaw3oWsRD+8wcPo0mKRzbeyogjSKUuyE4I
	gu+dg0G0ohKFkGSEkeYT+KyG7TLV2PB1sMiK+zd5+cN9bM/t62kGsKXjqKgBluIc
	+hjhGZgA61NQc0LPST2HGY3sdUPjEB7a3lt9cTjmpaUzdBEn1wgRDK/CZaenQfjZ
	ZJgVoLuukag9Yj3p18g0GMUTgucocRdLQqh38vuKN0ej1GqMGRkOdpQU/5ULv0kp
	buJKfLJdcUY9Nws94G2y8GIrv7QsTDF3l5MlMnUwDg==
X-ME-Sender: <xms:UALHZsNaluWw_qIG1o1Di3B3inWLOi28Jw5VZ3b4PWeROuU2odprXw>
    <xme:UALHZi_zSeTR1EdMVSgEQzqRnE29tsX2mumJL8IwnSFXk3Hbc8AF6iiY_z8hLnQjB
    iRkY9s5zwkFKBOGIg>
X-ME-Received: <xmr:UALHZjQdrYxP0r17Kc-y4VWyEqehIBqbCrk7fdXmCp4iRbIGU70VGWAdy1PJoqp-MYawKuBR5O5RNwRDBleoOmLBezODL7bGU77HTw3LXBm0Rsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:UALHZkuTxbY8e1SQVDSSyZzbtUlXHrDFp5KQfQc6kbXyvCle0lLT5g>
    <xmx:UALHZkfd3GPTQBffnFOHcXnqq1cZFMWaNZPhpvC8orT8-V2QR1APCw>
    <xmx:UALHZo2dMgTNaMDj7mMc_Yr4E4ZmOaEkpnxPxYkbvfYSG7IrDoYpXA>
    <xmx:UALHZo9UsznoexHEPO-6SmlwCO3m5ujls1fRaa98uSfvKilBAr9FJw>
    <xmx:UALHZlqs9d2y8qPxkNILmuhXjHjetS33e9oEe4114bkzvVIObr2DT1Bp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:18:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7e07a510 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:33 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:18:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/20] builtin/fetch: fix leaking transaction with
 `--atomic`
Message-ID: <dbd8eaa2cb1413299d2511f5291e9b91b8828a53.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

With the `--atomic` flag, we use a single ref transaction to commit all
ref updates in git-fetch(1). The lifetime of transactions is somewhat
weird: while `ref_transaction_abort()` will free the transaction, a call
to `ref_transaction_commit()` won't. We thus have to manually free the
transaction in the successful case.

Adapt the code to free the transaction in the exit path to plug the
resulting memory leak. As `ref_transaction_abort()` already freed the
transaction for us, we have to unset the transaction when we hit that
code path to not cause a double free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c         | 8 ++++----
 t/t5574-fetch-output.sh | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c297569a473..0264483c0e5 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1731,11 +1731,8 @@ static int do_fetch(struct transport *transport,
 			goto cleanup;
 
 		retcode = ref_transaction_commit(transaction, &err);
-		if (retcode) {
-			ref_transaction_free(transaction);
-			transaction = NULL;
+		if (retcode)
 			goto cleanup;
-		}
 	}
 
 	commit_fetch_head(&fetch_head);
@@ -1803,8 +1800,11 @@ static int do_fetch(struct transport *transport,
 		if (transaction && ref_transaction_abort(transaction, &err) &&
 		    err.len)
 			error("%s", err.buf);
+		transaction = NULL;
 	}
 
+	if (transaction)
+		ref_transaction_free(transaction);
 	display_state_release(&display_state);
 	close_fetch_head(&fetch_head);
 	strbuf_release(&err);
diff --git a/t/t5574-fetch-output.sh b/t/t5574-fetch-output.sh
index 5883839a04e..f7707326ea1 100755
--- a/t/t5574-fetch-output.sh
+++ b/t/t5574-fetch-output.sh
@@ -5,6 +5,7 @@ test_description='git fetch output format'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'fetch with invalid output format configuration' '
-- 
2.46.0.164.g477ce5ccd6.dirty

