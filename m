Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08E17BB19
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318238; cv=none; b=Hbq44KBEqwngM4zyOK3fJC4p9NAjbl8PwhGjlLMBnfCBdjp6T/WfiV+Cd0EVK5jbe6mkJihPoetBa67BFX52n8CwhIxTMVvgCUFZPuFOVmmtkypNi0cLTxu8G1cw13bgicQ45ACaNb9UIQ80vKwd1NEYnwKElHlulbhu5Z4tAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318238; c=relaxed/simple;
	bh=otBYJDTv0gRId/5uczKSEggpmDaJ+3GgLHUhS1ux0sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txYJwigpQyStZc8GUcqwBML+6ZkZjW6GNY29tj3JgCnleK0eGrSebo4tiAYDeq+vGcDDjkuMfk0AE0rojDdOIa4XjNTA0O0a2rM+1TCzrRMSov/K8CPtJI5vQRl2vrlErcC6ZL9JdeqghwN1E5IfpLC91bnJzrWWdmLuYOo0Lmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V/7JPfwR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=onICFuIY; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V/7JPfwR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="onICFuIY"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1542D138FF3B;
	Thu, 22 Aug 2024 05:17:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 22 Aug 2024 05:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318236; x=1724404636; bh=dn6/T2X+tl
	LtK6xfey+zjja8ro5u/5BaC0FCx5P/YkM=; b=V/7JPfwRVNKdZKW0HtuLwYWiWx
	VIxfQUmmsG84LQpbS8E51imPJmydaLyv/PDYam8PjREHiaI3ExU8aWGvCamzEJZi
	/IBZ8MiFxB8A6rlWIs5MW1ZnFXBRjQq0AlJGf3hbKjtY1WE23Q34uutCS5dJkRqV
	6q0FCxF+UU3VIujIve8V3YFWhFAMq+qnkd93AoKCLadDbMh3kPKwasX7raoHCMzj
	qKxBjUo6RKIed7Fc6LaXYNledNi3wzgb29cWyPbRMGVHSyPVwneaTHJppbd6G5pg
	6JSuQCr0LXfrwKiZg996VJ1TZoci65ODeyHTogxrwF3ykArXlMVcreCnES+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318236; x=1724404636; bh=dn6/T2X+tlLtK6xfey+zjja8ro5u
	/5BaC0FCx5P/YkM=; b=onICFuIYvDXj1NtD3yFoaSWnvoSZTdfB6F8ec/cJ0anH
	nEglcDaCDMQPImFhd8TszQ0mW9jy5KQoEPmy4fW8RMD4c9IgqxUw9veummychWCs
	rOEBt6lX7jUq9Is/oIlrQc13SKIlpBHFYDPElb9akz5XHFjuW2JgffOrMcdmr5fx
	/uyQROkWx/0J+tWw7podJ8Y3CqFcXMslY6pZZzVLTtVOsawItn3hXX+BhNwwveYe
	ayqHWaQJt57Bx5mcluXpMLfFL1xaFA67EwltsQqRCyVLWNUP9212hOyQnLxikFjQ
	6AMoW2jiE7xX/Y1vpD70KKaB6+pyfNdnN7ajoaOA/Q==
X-ME-Sender: <xms:GwLHZrdOwkCtrJ1Li8pirtauaJFdyGSNjlyeSCevwhOIdvcDAf53RA>
    <xme:GwLHZhMKHrDisWp8w24n2lIHF53hbZ3S_G8VJSTt_IHdSB8RNv2BcoE3PWiRH8rGL
    xmUcdL7V59j-U9VRQ>
X-ME-Received: <xmr:GwLHZki0u7QIuH6ekW9L9qas1uhOdFK0bb626QI_WaQCbDEfiNpRaoS7HDGG9wPZ_PGyWvOVU7vlZV1sCCtWzk58HT98jwkpVjH9blgXpLQ5opA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:GwLHZs_eJ39oN5qBzLzbrF9RBjPOIXudoY5Xide09sv9WMQog19RhQ>
    <xmx:HALHZnucPxseU5m9MujL8CxRmHJf5jWjP-HzE-sxVSeRRrd_wJvRmA>
    <xmx:HALHZrG-9izVgvbblEpxgXLR-RUIIrxJeUPtxF7fev-XTWMjXVedtQ>
    <xmx:HALHZuPIK5AqO26rVP1pWvlbyMTJq2ARVs1kMenEeRDZP2Ep788Wrg>
    <xmx:HALHZg6e9cQvAwIZiYXtgLzqGxeSe57OjA6H7sM68rKwBjdIQNgr3g3Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 76a48da9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:16:40 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/20] convert: fix leaks when resetting attributes
Message-ID: <ed0f01bf92c83fb7371326bd1a59933619de2c47.1724315484.git.ps@pks.im>
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

When resetting parsed gitattributes, we free the list of convert drivers
parsed from the config. We only free some of the drivers' fields though
and thus have memory leaks.

Fix this by freeing all allocated convert driver fields to plug these
memory leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 convert.c     | 3 +++
 t/t4150-am.sh | 1 +
 2 files changed, 4 insertions(+)

diff --git a/convert.c b/convert.c
index e6184d21f26..c9a31eb4f03 100644
--- a/convert.c
+++ b/convert.c
@@ -1371,6 +1371,9 @@ void reset_parsed_attributes(void)
 	for (drv = user_convert; drv; drv = next) {
 		next = drv->next;
 		free((void *)drv->name);
+		free((void *)drv->smudge);
+		free((void *)drv->clean);
+		free((void *)drv->process);
 		free(drv);
 	}
 	user_convert = NULL;
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 5e2b6c80eae..232e1394e8d 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -5,6 +5,7 @@ test_description='git am running'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup: messages' '
-- 
2.46.0.164.g477ce5ccd6.dirty

