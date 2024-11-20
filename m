Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6A177998
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089114; cv=none; b=WU9eallt1JbddaG/gOZZwaj5H6RlS64mr7HlY3/faFpND8bzpaEdBSk0d4XGj7nQ5LlVO1hNkC9a39GQozXd60Nq0/ErsAom+rxWfOTFW0664nfa0aK2NQh2QaTbLkKVs0ypOnlvtKRHyfFCM8daeqly8Xvxqkudb7I0J9q+Cbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089114; c=relaxed/simple;
	bh=Tx66guLuVGsiufRowLqdqhLMamQlMUfi/bJk9pjO2hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IKZQCM9OHb3y//q2/pFcNgMN/VjUKERX2rhR9v1V/EdqCV71SJ1ORxa5SIbxfEWxp+ncyt4HgFE4xvD9eBnABTm4QBvX0kf4EtQuJ4RYQ2wYI+DottkzDPJf4FTCG2x2UH+wPpPxbEnc9UEmFP6C9A5bT4QfI5flbBQQTXT76Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a3FRPZBW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c1423Qgm; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a3FRPZBW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c1423Qgm"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F0BC1140170;
	Wed, 20 Nov 2024 02:51:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 02:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732089111;
	 x=1732175511; bh=QYjCOLJu/P6y7EzQ3v7bDVy11RbPe8pvuy7UgGBCCCM=; b=
	a3FRPZBWwxXgdU8BzSrN9ERjkhCear6oFkA0q29IwbGQQwareQpc6Ol4YN1qInot
	KiFwQ1XmbgDFU6dm18MJWuGCLLqPBDjljh+JWrN3OCsxZX/eEJRdeTTEuxCfU7Ze
	tCw75D1OQ+IpzsCHx9h6RdF6RQkXBPFVkLNkK8f3LhBzC58sCzrRbJRz/5A9tMwP
	j9orv1MIrDOLyinQSNztxOsC7pOInMH0Hrco/3wXjHckeiqXdVpiPTU66mC0o7wc
	5kP9Pno4BPqvke7OaGRb0VAUZUO26r9X1Y5vp709ZRAYUm5WX5+PBsbEdebMwK7D
	PpfT/VveBp3EqgKc2xMthw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732089111; x=
	1732175511; bh=QYjCOLJu/P6y7EzQ3v7bDVy11RbPe8pvuy7UgGBCCCM=; b=c
	1423QgmJSle8g7677lAeYisP0tUdM7Ywb2tGvZZOEUfZ2iuVycpsA1gQFeToiqAF
	KHd0wSh7g9714Isd/K2ajnVBt7Gg+oLk5kmnGiMvmgQZZ0BvDMSdOd3ngtDVUa4G
	FV2y3KJqjeFDJylCdfiNFS0IBm8avmL2OMU4LE5HTYSCQfs91Dcsautgh7xOjyL3
	aSCAfkLFXdF4S7/K/LnY808pBRqsUWuWyV2cAjCIneNgXACwC9+g0Pv8wsEeb9Md
	AgPTMG669jdE22PuZ+TATw6604A283oss7jFAsTWmEuZvhx7rE3fvNYE3kvG3XE4
	Mu0DhVfQ4xLqSRyxStIEw==
X-ME-Sender: <xms:F5U9Z50uaCzO44QWyuxXR0RTiXqkQ2Db_EDNNyPtIuqUx6J681w9Xg>
    <xme:F5U9ZwED7-ihInorbhr6MwU0liHf-PlMwcu1IKB6Ajx5HtJdtZtiu3HyTCrfm4Lkc
    fLFFs-MzypPjs4BHQ>
X-ME-Received: <xmr:F5U9Z56Fw4R-hO4Q94iWRUmrcry_uB_fhLfzIuJA8y5uIVfcaA4FE8sZ2T0lDGfafsr9x3QnllrJgZCKl6cR2BnIzTCkQ8zTouUe1QlilTRFZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudff
    udevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:F5U9Z21E16fnEwP8NmCXRsvP9bEI7VYziaBXWQDaKN5x9ZZZHw_HRQ>
    <xmx:F5U9Z8HU4bTQgwjzppaqDEzRtYkVe-hteaGpHXckUIaHdFZWDGpEfw>
    <xmx:F5U9Z3-YH-pV1iu3vEr_WnbeoU-lljF6q5BDfyPoIKDUU11tADPg5A>
    <xmx:F5U9Z5mZJzz-xLgmrU_76kUzq5OlHulmGJAoTcN8xHlnUK3lgt4GhQ>
    <xmx:F5U9ZwDvzJ5A2gAkf4J6mD1VUHT6_eNTUK_j-5j8e-CbSGvb7dr-f0YE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:51:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 02235682 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 07:50:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 08:51:36 +0100
Subject: [PATCH v2 07/10] refs: don't normalize log messages with
 `REF_SKIP_CREATE_REFLOG`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241120-pks-refs-optimize-migrations-v2-7-a233374b7452@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

When the `REF_SKIP_CREATE_REFLOG` flag is set we skip the creation of
the reflog entry, but we still normalize the reflog message when we
queue the update. This is a waste of resources as the normalized message
will never get used in the first place.

Fix this issue by skipping the normalization in case the flag is set.
This leads to a surprisingly large speedup when migrating from the
"files" to the "reftable" backend:

    Benchmark 1: migrate files:reftable (refcount = 1000000, revision = HEAD~)
      Time (mean ± σ):     878.5 ms ±  14.9 ms    [User: 726.5 ms, System: 139.2 ms]
      Range (min … max):   858.4 ms … 941.3 ms    50 runs

    Benchmark 2: migrate files:reftable (refcount = 1000000, revision = HEAD)
      Time (mean ± σ):     831.1 ms ±  10.5 ms    [User: 694.1 ms, System: 126.3 ms]
      Range (min … max):   812.4 ms … 851.4 ms    50 runs

    Summary
      migrate files:reftable (refcount = 1000000, revision = HEAD) ran
        1.06 ± 0.02 times faster than migrate files:reftable (refcount = 1000000, revision = HEAD~)

And an ever larger speedup when migrating the other way round:

    Benchmark 1: migrate reftable:files (refcount = 1000000, revision = HEAD~)
      Time (mean ± σ):     923.6 ms ±  11.6 ms    [User: 705.5 ms, System: 208.1 ms]
      Range (min … max):   905.3 ms … 946.5 ms    50 runs

    Benchmark 2: migrate reftable:files (refcount = 1000000, revision = HEAD)
      Time (mean ± σ):     818.5 ms ±   9.0 ms    [User: 627.6 ms, System: 180.6 ms]
      Range (min … max):   802.2 ms … 842.9 ms    50 runs

    Summary
      migrate reftable:files (refcount = 1000000, revision = HEAD) ran
        1.13 ± 0.02 times faster than migrate reftable:files (refcount = 1000000, revision = HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index d690eb19b3fd7083a5309deb98738547e4f48040..65eea3eb7734d03f09a22e8edfe5074d532398ff 100644
--- a/refs.c
+++ b/refs.c
@@ -1188,8 +1188,9 @@ struct ref_update *ref_transaction_add_update(
 		oidcpy(&update->new_oid, new_oid);
 	if ((flags & REF_HAVE_OLD) && old_oid)
 		oidcpy(&update->old_oid, old_oid);
+	if (!(flags & REF_SKIP_CREATE_REFLOG))
+		update->msg = normalize_reflog_message(msg);
 
-	update->msg = normalize_reflog_message(msg);
 	return update;
 }
 

-- 
2.47.0.274.g962d0b743d.dirty

