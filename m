Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBFA1A76DE
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732109994; cv=none; b=jbroqgCKu5vXyEbFYJsOOKE4b2VHc2EOSm0u970ljlAXgR5em3zxTyouiCRMJYS78DmjJWUPpYyRsuZsBfXCn3ikxzCN+XHIm+YZrzaQ8IoLecQkvXMDVnwonalwPLT7Y3Bas4LllBANuI4Ev1Wq7yiAw5NzSlSvRIyOVjf1LNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732109994; c=relaxed/simple;
	bh=EnF+YxZIpOnhDMiw+og6Kedfv5iiXsbtHdotP7fB/fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eEm5UEYyoxkPSpJzwbJskQ0owSYs/Ku0Pvf4jQnPtAjH2NoXjevFoJA50Mq4/pmaXB+rgc58JIeww/ShayaKOEwEEgOfvDEPj0cMc99rijsnTFrB05nROrZjoceMr6h/68wZPQOXYBTYXc2JR9SOCh2b76IBOy8l5S+c5goT92Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kCKNT8pU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zAjD1Mf6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kCKNT8pU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zAjD1Mf6"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 431DA11400CF;
	Wed, 20 Nov 2024 08:39:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 20 Nov 2024 08:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732109992;
	 x=1732196392; bh=5OYcvmCmnF21uOv5t4mdx3tOIpx+OLIEGwNo51ajcjY=; b=
	kCKNT8pU++pUSLZpB5+1Kg0TAMV6JuEUEQeaR3LAmh6B1rZKi8JurKOnKape0DR8
	xL1fiwlg0tGppxCDB59MSmQ/o++9BvELSZ0rORbda0mNB5xbIx3843dKSwPySb0Z
	cnAWH0sfl0t26CTAUQXyKJsQnSe9dyCgLGlVT039pmbB2Hv2WHlO2gg3fLnkSm/N
	inGpUnPXcy0pLhvTWhGA406pzQc3+oVh5LvFVkD/qKAHrtWkT6k6f/aL6zKzMJi2
	pQ3xqnITerqYAKk2xMX/ySoO5NBa3ftlQuhqi7Uwfk25psSRTMbCNFoadwv2abHM
	8jvwkgbFdqbNyxEAAKyl4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732109992; x=
	1732196392; bh=5OYcvmCmnF21uOv5t4mdx3tOIpx+OLIEGwNo51ajcjY=; b=z
	AjD1Mf6GbDMsDEj7sXyGTIrDwrM660n+ZEGuNKCGOJm6oTcUAVEW7FLsXBV7b2zg
	wKC2XXfoGM5AehUHr/063Zooj0MW/eVhOHDVN6+yRnnV0vtONrGntexqEtLbOKIQ
	5suglkYa0CTHjU/IaN6HwbjRwnqxVBZy3Ollq4GgOjUGc5SyFJbjjAyc1jEhTm2Z
	w4UMGdJzIR2nTt7Uz19ERmKgGdtUmYVrYd616Ed3vlX3nRELBk6IqK7kybXh5PhY
	mPbs6pRUsBYCAxPjHV4L1hHIGas7nx9XQkU9z7Bd8BgttUhCk1n9WrEKKMclasMe
	xkZCNqwyIrsM3fZLW6j9g==
X-ME-Sender: <xms:qOY9Z47IROcbttulVnBhf_ornp-kprWlhT1kh9osKhs9RzXl18UjdA>
    <xme:qOY9Z54UV5Nmx1Za49S6lxkS7e9zDQW36F1KbNlNdBrPON-zEkDH7kNDu92qvXtkj
    adNVYIiAFEn6obU3Q>
X-ME-Received: <xmr:qOY9Z3cTovWvhwwpb0XwLdI8MlBHiiKWEiAsQyrpOS62tYnfNEy1ILggYxbJ4Cc5fTbX6mTRk-cxivSmyWTS3ikxZtdvtbjp4XQ_dYFSjzB_EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehrjhhushhtohes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:qOY9Z9KfFpz7fhhPeAzZ2sTN-jcK-fsx_Mk6Kvr2oDJ5uu7ls0uhoA>
    <xmx:qOY9Z8J8FHesVUXwq8wYdshfRV6GYkpl-Y1p2OVjdU961Nb33IemQw>
    <xmx:qOY9Z-wGjtvFI1AKK7flkH9EhrKUP0Rj21hQsvPglOClyYYBFyu83g>
    <xmx:qOY9ZwKM3pF2nxcVydsme8hsWI0a0umoG86J0PQcRU6PDOv7AMT25g>
    <xmx:qOY9ZxHZ4NViQ3K8vTgDuz0Yz97X6VF5TUFnyS_qSUSJY_OjTAq6MQsD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 08:39:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3c93537f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 13:38:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 14:39:35 +0100
Subject: [PATCH v3 06/27] bisect: fix leaking commit list items in
 `check_merge_base()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-b4-pks-leak-fixes-pt10-v3-6-d67f08f45c74@pks.im>
References: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
In-Reply-To: <20241120-b4-pks-leak-fixes-pt10-v3-0-d67f08f45c74@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>, 
 Jeff King <peff@peff.net>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

While we free the result commit list at the end of `check_merge_base()`,
we forget to free any items that we have already iterated over. Fix this
by using a separate variable to iterate through them.

This leak is exposed by t6030, but plugging it does not make the whole
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bisect.c b/bisect.c
index 04e9a63f11c7fa1a9dd11d3f193c500a4cb937c6..12efcff2e3c1836ab6e63d36e4d42269fbcaeaab 100644
--- a/bisect.c
+++ b/bisect.c
@@ -851,8 +851,8 @@ static enum bisect_error check_merge_bases(int rev_nr, struct commit **rev, int
 				      rev + 1, &result) < 0)
 		exit(128);
 
-	for (; result; result = result->next) {
-		const struct object_id *mb = &result->item->object.oid;
+	for (struct commit_list *l = result; l; l = l->next) {
+		const struct object_id *mb = &l->item->object.oid;
 		if (oideq(mb, current_bad_oid)) {
 			res = handle_bad_merge_base();
 			break;

-- 
2.47.0.274.g962d0b743d.dirty

