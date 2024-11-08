Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429341E1A16
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731058511; cv=none; b=si6YY/YO/3g3m3uck1gpctV/Yd+mZVJwtmJGSL7q1lPesZuHUthWhTr22cx+P6JLVsVzjbi5EcRi9hCYyz7cmpHQZ0hvil6Fx8cB+Q0e3UKNVbxvMqXyL4bpsaTGAVPxfChzOVqgBvGfP+5cBanPm6BVPGV6MTNGe7LedL2vZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731058511; c=relaxed/simple;
	bh=E0+sThI0olyoP9TQdePfFRs6BvTppF+8ms3SXEBSOUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YxEmyFnxITQr90M0AdOFOy0i/Zl/vHIIRKYkNRVPCZtxyJ6iB9BWHVZ57p5bcJeLnQ84TZpsIXbqieQUvmdBrbSR0ilXe1RZz1mO2BQ1/YAax53t1Goy+xtB97spMYD5VTz1YpxgkVgLt3Gt9nbWKzeCFq2aQxRuZjV8dUK2CXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dOYETSUZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mA0/g+F1; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dOYETSUZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mA0/g+F1"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 95C351140155
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 04:35:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 08 Nov 2024 04:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731058507;
	 x=1731144907; bh=MSRUjDiVNYEhr/WBLtGdY25bYoNAdlcPWQLZALlzFEs=; b=
	dOYETSUZcu00m1Uyfh5oagkoWUxgXPL7R+8Zgx0w475z9QKXnLh5BKKqEmotm3Wr
	U23bAqaG8cAMahADt6wYFNcqbW/21XPbrGJ8AA+Yak/1P5QBS9QEIPWWscWZAph1
	S2Don4r9aMUtTFMnmHrmfii15jTlResYVvQhfUHVv0EENRQeQMgYBm5QDhvEP5mP
	oV++VtiCI5RTJRSm7fzu3uBA/LwULgjg3r+hw2Vb68lc3epcu08vQuB4/gyUApFV
	U8pMuOpq76JleYDzRma3bazoNWCoVlZSUb9qxFUxZM+pdO7tnXRN4oNklYZIB3hk
	1cuuwZrlx2QCzyX4maAaFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731058507; x=
	1731144907; bh=MSRUjDiVNYEhr/WBLtGdY25bYoNAdlcPWQLZALlzFEs=; b=m
	A0/g+F1GKUf9xmPIcuBahxKz3gzCmQU5U6CkG9Om7yB0V0XGkf38ERWI5oUXmbk/
	7g10/WKPXEFtQSWlokc+dwAN7n4xu3b5uut9czRoWr3v+3Wb/0KpQHawPhW4lP0D
	svgMOhfYsYnGDUoPOEKQ8NKYW3/WEVarcT9ETbz0d1eB52zNndcP56UrOP7DtMCw
	ZJkElHflSVG+zl6NAd2RvL91L0Ec3wvWuQjt+8CA++i7VIla7oscXLT0TgnBOAUT
	+GVQzbICQd6Tlc6uZSONnT88pxURViFAlUXV2tNPtfeHaVuQvZi9Hsbw01Q8Co4z
	GpORuhDmsqCjjyKbHBG8A==
X-ME-Sender: <xms:S9stZ4tDrgzcmxZqXvldeidYGN0hDmwe1Tiw9muUHgLspSgtsD6eog>
    <xme:S9stZ1fA-wx4AIGOprIoTBjKsKaAQhyLpZ1dXwj5wVvokOlQQrzZ8R-BY_ju_omna
    caHd0eC5fe2PHLjPQ>
X-ME-Received: <xmr:S9stZzxnk29yzErLtswW3fPRqqKdSqzKHK4iwujttEI7RbT2E500QqmtQnCf-2OeGmOnBvz_69VkUnfqAlYjo8f67-YmI5Kl3YIm2H69dKJvwHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelhe
    efjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:S9stZ7NItmhcbVlLlx4Y8fTy9sXOcnxSwxVXTs9_HsWsZIMDfnGxgg>
    <xmx:S9stZ4-KNdbGbxrHJ-4LG4LCXhI4qXKIR2SVYrna9ShJrdMaLT2UOQ>
    <xmx:S9stZzUVA46Bfkvrp2OsBu7iYb7fj8x1N4BjwWY7vTTnXFEVK6zkfg>
    <xmx:S9stZxc31zH52dLcjq6-pmJ8k9w8xqXYib2d3oWF77fOYGW7TrItww>
    <xmx:S9stZ2mX3IAUt7MGEBhNMXel9MM-bW3E7FbiAnJm9xwHC4g3mAw1z4N0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 8 Nov 2024 04:35:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2abdd478 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 8 Nov 2024 09:34:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 08 Nov 2024 10:34:47 +0100
Subject: [PATCH 07/10] refs: don't normalize log messages with
 `REF_SKIP_CREATE_REFLOG`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241108-pks-refs-optimize-migrations-v1-7-7fd37fa80e35@pks.im>
References: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
In-Reply-To: <20241108-pks-refs-optimize-migrations-v1-0-7fd37fa80e35@pks.im>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
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
2.47.0.229.g8f8d6eee53.dirty

