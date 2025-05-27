Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693E92798E6
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354684; cv=none; b=hUSoseMwYGLmn/BQj5mPnsTLSIqekH/X3mrVJg5KMoh9D98jqjcGByP8QdJcomXPBpvS7OFlfCCohOAQd6G4X0WaJFfz7hxbVThDq+pWfbKhfT049hwXi7rFtuLOWxqZFqKDl6v8xn2H3TOb4warWyjBoBetWdU7BwtraIoGj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354684; c=relaxed/simple;
	bh=xYbkvvfKbIHGlPNm7tSWichzhFNTaz7UIc1Tcf/axMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4BzK7rke8cl7C8Fn061VT8hOwzeUQdX7J8B8u6lC3sgnQaQ+0yP4kv8a+wd7CY6kC/qpJDtTKxxzOmCiimgg+qU/rePIKimRvSal+oPfNgzJ+1I1nNQzxU9cpdyZmcSlimlrxciCKurygE1ODtWUS6638cADSIid9CmRVoVtsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aV+18pBT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IhZgNs6O; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aV+18pBT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IhZgNs6O"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 8EFF11383AB0;
	Tue, 27 May 2025 10:04:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 27 May 2025 10:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354681;
	 x=1748441081; bh=BmypOMNZh4vTOgOrYxM3S230sOFwSvhBm6tOu4FEN8o=; b=
	aV+18pBTpvYcoMnTSlK+hvv0obmhcpKWOOAo82xbxgyoLDlOe+SHZkrCanTqmxZn
	fYQJPVLjfjZxr+WcfhSq5Ao7CmJiBUD80vrf42k8XFnt04O07mj6mNwmIkin1rOP
	+7hSZsUFtAGZQLB8RvwWgW3tiOutep+TksDnD0BLwHY/njS7OEarn9RH4ZqTVzbz
	SbVsXygotYhKWy5OrFuhUJ/cynRzy+Y2HqIxQ4Y3+e57UbXP5hzRqfuV2dBYIfth
	m4+hABgb+zXjtoEqamB1FR7hDCptRdP3cCUv1yGcC964rbncprfaeeXqe29twvFB
	zPMV6XpHTefmd6qcwCzj+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354681; x=
	1748441081; bh=BmypOMNZh4vTOgOrYxM3S230sOFwSvhBm6tOu4FEN8o=; b=I
	hZgNs6OARrcPaUPrrzdzHSm+7Th2hGPPSwKoNwmWLa0nu/ZWnfMGTyLBIDq37bt2
	ee006Hc3MxhpGbX0kYmKoBkYNgh57yG82W8znd8G2DfAYwO4LDqR87bIBHQLYz4I
	IuDRnn3Uwc5BbX3GJHkU8CtuV1I6e7tuhLzxEIvKxbqd+Ue/qyE07tGudM9Gq8bm
	CGx4OOwncYxOlY3Zg4QaDJwP9vxi+wdU9O1y5MaNbLUGUs6W8hjyw/5duRvpBERH
	xgJollX+ZNDz9rwmBvOoOiVjpqwxPXkgkklqfTDlNQkjwz0lC8pdInV+AqtuASv9
	EtU/LWQ6et8ZFwqmk6Yiw==
X-ME-Sender: <xms:ecY1aMDxOn5xwXtCx0vD71HTx1nNUNpcpjJ7Blzk6o-KARfaE43qpA>
    <xme:ecY1aOiKQVmJUR0kZyeVOJMxR_NB3hPdLwAyYo7x0D6UmerJ46X3VF3irw6zYvtHW
    yTqbDBojWFaE5vvnA>
X-ME-Received: <xmr:ecY1aPns9BhZRpKLRxLJV4L_D-T6lhYVmMLCuyD9jjcs_50qiRoGPor83Rh-EIu7QEsa3spal0J-w166E8ghndz6rKLndV8d49uhWK1OnrAm-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehkeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihrohhthhesph
    grlhhorghlthhonhgvthifohhrkhhsrdgtohhmpdhrtghpthhtohepuggrshhrrghflees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:ecY1aCwIoFUw3Et3muCoRqt9qV5DzgQOAKWfh-KJkbct7v5tKKM9ZA>
    <xmx:ecY1aBTHTikr3flAGi0uc_Bm2TWY-6e1xnDQb4Ct2Rg1RxT5B7pdLA>
    <xmx:ecY1aNZXvbxlcElOvHV4sEdTxiBQSj5BQV1AHRRgHCKckSG2gz67tg>
    <xmx:ecY1aKQ7bnk7i7GpJ97JJ4YKrBC1ZHV9YCVCiA04g6kJO2JpgimXMA>
    <xmx:ecY1aIuSUswkIpUhWNXYUkd1TGexNRzOMabMoxR2M0_LGKO6wfBfZGJv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 573eb364 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:04:36 +0200
Subject: [PATCH 10/11] builtin/gc: avoid global state in
 `gc_before_repack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-10-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
X-Mailer: b4 0.14.2

The `gc_before_repack()` should only ever run once in git-gc(1), but we
may end up calling it twice when the "--detach" flag is passed. The
duplicated call is avoided though via a static flag in this function.

This pattern is somewhat unintuitive though. Refactor it to drop the
static flag and instead guard the second call of `gc_before_repack()`
via `opts.detach`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e5d1114bd2d..174357b9c25 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -816,22 +816,14 @@ static int report_last_gc_error(void)
 	return ret;
 }
 
-static void gc_before_repack(struct maintenance_run_opts *opts,
-			     struct gc_config *cfg)
+static int gc_before_repack(struct maintenance_run_opts *opts,
+			    struct gc_config *cfg)
 {
-	/*
-	 * We may be called twice, as both the pre- and
-	 * post-daemonized phases will call us, but running these
-	 * commands more than once is pointless and wasteful.
-	 */
-	static int done = 0;
-	if (done++)
-		return;
-
 	if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
-		die(FAILED_RUN, "pack-refs");
+		return error(FAILED_RUN, "pack-refs");
 	if (cfg->prune_reflogs && maintenance_task_reflog_expire(opts, cfg))
-		die(FAILED_RUN, "reflog");
+		return error(FAILED_RUN, "reflog");
+	return 0;
 }
 
 int cmd_gc(int argc,
@@ -965,7 +957,8 @@ int cmd_gc(int argc,
 			goto out;
 		}
 
-		gc_before_repack(&opts, &cfg); /* dies on failure */
+		if (gc_before_repack(&opts, &cfg) < 0)
+			exit(127);
 		delete_tempfile(&pidfile);
 
 		/*
@@ -995,7 +988,8 @@ int cmd_gc(int argc,
 		free(path);
 	}
 
-	gc_before_repack(&opts, &cfg);
+	if (opts.detach <= 0)
+		gc_before_repack(&opts, &cfg);
 
 	if (!repository_format_precious_objects) {
 		struct child_process repack_cmd = CHILD_PROCESS_INIT;

-- 
2.49.0.1266.g31b7d2e469.dirty

