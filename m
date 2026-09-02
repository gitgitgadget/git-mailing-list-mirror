Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F5B49B21F
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356114; cv=none; b=L91Sst36tb3fxv2WjF49qiVic8MBeaqhk5LCwaYZjR1vIm+jhVxDZvgpGRSFXqkKpuScE3IG0arKO4XWgVQOOxGtW04etmGYs090f+qDVvQiD6WcUXFPLdsLCXmcVCH1G5fqpOQxQQ02Fua5TK1ujjiAk3aks76AwLI4ATCknwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356114; c=relaxed/simple;
	bh=A5bLQ6/VuwkQPQfoVxs3QRuXgUW6IJYRzj6dU6yHjn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATKIXtv1O0z0kusrGSTQ2kOJSaPwn5zJHliCpXPpDplJbToOeHd95fnN0DCJwVeaK8ZpEigO0fqtdni7z61b7+BAhTMAlZbHlppiAZ9QSLOC+gqf92eXORF5nPyHfbG16SvwaP08SluBLjoDWu/WAAajBuyaozbJklnvOxYKsO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bZXdT5FN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lLoKESKD; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bZXdT5FN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLoKESKD"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 950677A00E0;
	Wed,  2 Sep 2026 09:35:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 09:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356110;
	 x=1788442510; bh=Dlognmgy6Q0uQ+R81oUOOjVNM/XsR2UDadp9F46EZC8=; b=
	bZXdT5FN/h9QcUsScXu96wjMPeyR4cY1yms15tIIcO8miQFqZFN0o0n6F2fIIH9k
	Uvep4GobDIJSkMKCRgOgpj23qUxMCpHg/mT1w006rFiqgkvzjkVpd4iAW6/z83lZ
	C4jMPc2JkfnIcKil3g1mDFWhQujUUpcEq2+4q/WeSC/cDqkAaCQh6hURJ772Or5g
	BkhTPQlAhNYRI4NSwQAznHwbime7wv1QhKtMgqKNqolS6LzxIQwyQXnRZCK8ZS0Q
	yvVxl8eNLBO4MyXYXyhIVafs6kCzWhVSn28hnxWlTo0rrycWBor/uOY8oleRGed5
	3RtefZIBnkUdYANGJ5qgmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356110; x=
	1788442510; bh=Dlognmgy6Q0uQ+R81oUOOjVNM/XsR2UDadp9F46EZC8=; b=l
	LoKESKDpfMv/tnKuIT8s8OFQqG+WnDG/NLiXKghvGgFVigwM0NCIh57R72RGM4EY
	QePl3Wdm6KBjeLT4Y1Znge09LE9S4xPo7JYmHQ8gmJa6+v6RXge6JUWiwRvyl4pi
	6lYSp3rJ1MUgd84ShvDoN/fvQfdoMa+67WgJucxweZMMSUkH6tDHwX+5kMdtXXky
	WFOvmrLx9gURLkgPqzgYbwCQA3o9IfDw9zKzD1W7b0LTnMTeY5GZ20vjj/oIha6O
	ObJ6067wKMTOJlKux7HsIiPAdPFUONjqzR0EW5FwChOYc5g0DGvku37uyuRzGSng
	NwiLTn0jCB4O1EjljNqxw==
X-ME-Sender: <xms:DiaYaoj4z_PKVVnXgqtxlWC66uS2-2_IS9DEZrjCiUgAq6tj1t5GQA>
    <xme:DiaYanChyo6QwRm0qLjCAS32iJZp4FnetPjK5vUARVMiWr5rNWAXKAMudqMT7Z1cq
    v1KpAE3L3m4VZ3WiFF7OBlq0HLlhOeePboykeQvrBfuFtPRDParbg>
X-ME-Received: <xmr:DiaYattS2gCndgldXhWaM_nPJkpzgMUCIBxK8LRyDyXZKErkC8ovqk_YySTzW0Gp3Cw8iQo>
X-ME-Proxy-Cause: dmFkZTGrKOyneZupe5mOAQPCzJ04iP7AmLoFfKmvCbE1PXGMupxk+V2NHymWcC4MTqxXOZ
    qKq9wTecS2icL0DdCtTOCKdnafWbnAKgdH0wDaR59e/kpg4eReC0lLpo1evFjFMIgvnYon
    R2hs/5JOn9f3OdQ+vxHFb1QyrsNQEv+x0IdyoER3mghIqNxh/lgxkwG7av+ggFwoKfIkeu
    C1JKjSxfbfW7SEzYHMwa58HzzfC3iAL4Xe0WqbEAZkixIKWw5MujaEcHt0BX6zRfJxMnJz
    Bp+bTfsYkt7cMLy/SwKjfahsGUCnP+pXCap9lrxYaxGr/JafFjNSixolp5e/H25iF1cxr4
    UsxpX+20MIDLrc4HCnH7yIVDmz3y+iApEbEd3ono1lIw1ahkzQyxOny2Imaxg0Fr2a2srI
    SgO1g4u9BmV93czjT1Jhk2T5Lj14UvXjVxw5JeA1jZA9YeQZ7vPcWc5muMBrsSAmg4tcMV
    MDSE5Qt0QFCK1TtrK0W77BOiUJBukqvL53g04/r8DkgAKkn9H2h/T/LFTsLv71wrXc+nf1
    eW+xm3QCixMFrnn5hpOb0vgXcu7w6r/jBC8SBZRGKa8xArVDurN3HBsq5m17WbTiHVTiql
    nMgk2tbqIfGrsU+9fFq97Y2pgPFgsXsOR7PS9h5O0skYFWWIpGiB9D5h6cHQ
X-ME-Proxy: <xmx:DiaYakZSJPdjaQB0TUIRUoCDdObpf_dplT3-QVpTH1UiOfyfNwVtUg>
    <xmx:DiaYaoVpsFIlSKCVhgRu4obGv0-mpb31MQk66ExBk1wI5MM4UF0Qfw>
    <xmx:DiaYag5XHu4fjm9cKAwa5g12qO6H5azM8NDzwcqrMAzF_ymgNoonfg>
    <xmx:DiaYarhXnuVA-w8juIn7pLN37jbMTnBRJ2OUdrM8kV6MGj0d3ikNBw>
    <xmx:DiaYar7qcye5wiiUnTbJgzGS9q_WwQVwTSGgHJFkll1s7V_1BikD3VWG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b23e3dcc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:34:52 +0200
Subject: [PATCH v2 04/13] submodule-config: stop using `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-4-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

We have two uses of `the_hash_algo` in "submodule-config.c":

  - One trivial use in `gitmodules_cb`, which we can convert to use the
    hash algorithm of the repository that's already available in the
    caller's context.

  - One use where we compute the hashmap key of an object ID. We should
    only ever get valid, populated object IDs here, and consequently we
    can easily adapt that function to use the hash algorithm of the
    passed-in object ID.

Adapt both sites accordingly. Safeguard us against the case where the
passed-in object ID is _not_ properly initialized. While this case
shouldn't ever happen, it doesn't hurt to be defensive.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule-config.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index f8c2cf7a93..7c73fa108b 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -133,7 +133,9 @@ void submodule_cache_free(struct submodule_cache *cache)
 static unsigned int hash_oid_string(const struct object_id *oid,
 				    const char *string)
 {
-	return memhash(oid->hash, the_hash_algo->rawsz) + strhash(string);
+	if (oid->algo == GIT_HASH_UNKNOWN)
+		BUG("hashing an object ID with unknown algorithm");
+	return memhash(oid->hash, hash_algos[oid->algo].rawsz) + strhash(string);
 }
 
 static void cache_put_path(struct submodule_cache *cache,
@@ -824,7 +826,7 @@ static int gitmodules_cb(const char *var, const char *value,
 
 	parameter.cache = repo->submodule_cache;
 	parameter.treeish_name = NULL;
-	parameter.gitmodules_oid = null_oid(the_hash_algo);
+	parameter.gitmodules_oid = null_oid(repo->hash_algo);
 	parameter.overwrite = 1;
 
 	return parse_config(var, value, ctx, &parameter);

-- 
2.55.0.979.g7e5102b832.dirty

