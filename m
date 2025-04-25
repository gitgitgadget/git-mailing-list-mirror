Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95E2356B9
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564948; cv=none; b=CKYDWw+9LbnkUNKQS4anBuXZXc80a7ptdfcRbAEZeRc0vS2WgEfFitfI/QwyqjGF+BnkjI5Yq0rWgZoN/d7FoNB6JjYb9JM1SXxxWImyOp5AMSWkr9Z0Zf1siFF9Qryl0OHZUR6Rk6rJnTT+21FGbvNT+Ig9qGN+pgkWiwrf4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564948; c=relaxed/simple;
	bh=5ogyE33ogTA7OzaYJ7odWfY8T6Ex1VWlN/sdH8coFpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Di0SVhD/Glqa7EkGKPRpUALGdnsajJG68ep9Np/hlm9twhiZtx9kbR6n102TGhyOf7j4ferjQFsfJbkd+RNzKrdBYqLfrtvU9FAA4f9OT3pCW49Ju7smiCazgDSxefZNAiy6Djc8Dw1JBJ2JxfhijBj327V/ybMoQnLgzWyWziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yLmEWClB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQoWsVvr; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yLmEWClB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQoWsVvr"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 87E2411401F6;
	Fri, 25 Apr 2025 03:09:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 25 Apr 2025 03:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564946;
	 x=1745651346; bh=zIOPwvWhiJ7vprqyNo7tPC7WiEDK5KjzvEZ30e6JoWw=; b=
	yLmEWClBKHQEakD3FxMMCo8ejOWCK3P+xTncQclENB6qlblwvJb13xfSz4I3OJ7B
	WXZcusIaaGfKavTKlqqHiMAERzqq474n9LL8Kc6AwPeK2nRrya1WRIgV9q3+1Re6
	V6cpPS0sXVwKZYYC2x749tXLt86CKoUyvofa3LZBkd2zuu0S00/Zuc/vfc+nwV1N
	hz5K9/r5EdGgJY0M5M0bMfCZJdrbgyHD0Mp+9Uu0wrusow5B6t7RZY10poTnVKnx
	c84/dwPjmnPnfP+ZERlHZ+1C7QcluZmRTa2ckCfnZWAqLtRxOVCZSnAfLUJ4wzK1
	j75i0EaDZ+N86bKTCjBdZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564946; x=
	1745651346; bh=zIOPwvWhiJ7vprqyNo7tPC7WiEDK5KjzvEZ30e6JoWw=; b=D
	QoWsVvrceSJszY+pn3XsstZB3HajpwEKSxB9AhQfvjUvkibgiDGJhkGrIqxzaLwQ
	up5wbSyzBwqfOLknTGFXUYM9npZbUn6aCndQwxwNTEtUD6sS8mly1R5QiI8wQ4cT
	1tpIq1OWvgtkY/1JGNZgfCmQvm0us/AT5BaGOFad7eAAQUjsQdPtg0sv5ZDx7c/g
	v/RC9WQHa6/rw56i9d9Xz8fCC4WMRhTOfh+qwK93wus4wn2qf9RidiJWf4dez039
	ViMxBoDWeFVpcDlbKPvATzoPFihOOjtph6hZVVFGMo6a3QYPgt4nUmFYOSvXLs5f
	Ot4v1/FFfHCyzsc/dV2aQ==
X-ME-Sender: <xms:EjULaMwqlJifbdjfPTcPrExvxOxFs0YBcaslyT5mtkX7-2rFGyDlCA>
    <xme:EjULaASdj7nJlzyvqjz8FSEaqIfrSYR3xLgV3WCh0WyFIwGI6uIgETuxvJJ9UPaBq
    NYkwzlxunAjkNZeYw>
X-ME-Received: <xmr:EjULaOXKRzjF3z4M6qA1IHnmidV1jh8UEQWCTgQQl-zoglwguXPsiYrblRhEoXqJeDoCIMWfATon54KgSinJaQFUA-hezGEc91Cy37Pn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EjULaKiN2lynYXsWkaUZ51gugRebgnlKGPYckyMqzDJED9M_rxg0LA>
    <xmx:EjULaOAEd2eHaub2bo8pXi48u1_XH1X3kOcBFsEX96r7VrLashqgsA>
    <xmx:EjULaLLvdDsMWSeF6yVOFn0HeTj9x4e-yE1scV0rcFEbp5QauMe8DA>
    <xmx:EjULaFCM2SZIR1gQa59kw7DXTFSvI07VizDYxQd3TvqO1PEJmO8vSA>
    <xmx:EjULaFfNDownUPMPdXr9tmPbwxvvZQhGAXKLVCKMtaZUo77zd1ETyIfn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:09:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42fd59c0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:09:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:09:00 +0200
Subject: [PATCH v2 09/13] refs: don't fetch promisor objects in
 `ref_resolves_to_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-9-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Similar to the preceding commit, don't try to fetch objects pointed to
by references. Any reference whose object does not exist is broken by
definition, so we should report it accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 6559db37890..0492cf0d13a 100644
--- a/refs.c
+++ b/refs.c
@@ -376,7 +376,7 @@ int ref_resolves_to_object(const char *refname,
 {
 	if (flags & REF_ISBROKEN)
 		return 0;
-	if (!repo_has_object_file(repo, oid)) {
+	if (!has_object(repo, oid, HAS_OBJECT_RECHECK_PACKED)) {
 		error(_("%s does not point to a valid object!"), refname);
 		return 0;
 	}

-- 
2.49.0.901.g37484f566f.dirty

