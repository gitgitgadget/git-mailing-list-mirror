Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C3C20897F
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273727; cv=none; b=hbjGdLG+h6ID8IkSNjZuXiKcffXtdFVrfAe2agFRnPLMD7seqWIxOLq8WQkiBSZWJYOIvS6pdGIzlam8LKqbX9XjtqhKO6cxgCbLGGkrkm1B1sVjde15XuHgtK2zF6pkScEu8g15RkuRcHdaYaWwmuvaBynTmei1PABsYWHKd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273727; c=relaxed/simple;
	bh=LTZ901PIO4nZtZkOQxDbRW6bFFdhVn1Wkbh7cfYizCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNLpaHU0usuWpGDj23eUobgrIyqs2h49mwq39VXuyAmCc5Xs2lD7F8dN/nvAy2vXrV8mh2vlIWLLoLbpi4U0VpAXtA6FfzdMHo5S395BeEyeOQQNFSnUuZt1yweZJwSuRwLq0fg485nRvBi08nGSIY7MtogzvJHRjs2uUSLc4tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T82B+qpH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MhZlgIrQ; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T82B+qpH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MhZlgIrQ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id EAAB311401DB;
	Thu,  6 Mar 2025 10:08:44 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 06 Mar 2025 10:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273724;
	 x=1741360124; bh=Re/jjcNAK68m1c0Cf3VEwVaT/V2heXqHXg++4K2b/PY=; b=
	T82B+qpHj2CML1H8pLLxXEzoeIq8jXcbFdwz5UeD8oeZmPpiyrS7Do+0+d1pjmhm
	GkgZEvANXhEE8Wbv/BV1ZVsUm7GIClLkj7sfBTN2hgJVNqWDbOiEWHdLZ3uoJtWv
	w0KwWrHPA+cV03+kzA8o4D1b6EwkjORfGotBK2QnyfNDqxprWATnNbGMLAdZWsTS
	85MzXtSRWCM+i/o6EIhPN8V9Fv39lQWOSJA3B3d2zovT/TU8sI1xshBYrcmkDt4n
	q4zmFwS1ICHzrT57SeyTSEfWjbECk9Ty7/8AHWN3F4TXOk2jwnMxz2tIIyZ8d4XL
	pMGcHRgX7aVaGQUCDDwVkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273724; x=
	1741360124; bh=Re/jjcNAK68m1c0Cf3VEwVaT/V2heXqHXg++4K2b/PY=; b=M
	hZlgIrQC2DKeBvCzAmn8+J6K9pwgz6oxdCvkK0yJgXaeY305ECzrUSQyQo5T+QI8
	oMPfXxguciDeAVRjJQEW7t/JUOZubL0zCjYtQ8wWxdVnIRr0TygkUFBZ+6iVk0Bw
	IxbTn5MB4tkr9gd0X+eV4DfZz2PorvmhjUjACC6hjiv9CvjKiCpbg74Qyp/HNqkk
	4I0pRTZJ9itNTS/+K08vPxDyMf4Q7X0BUc1qekeRe6i97iYy6W01VRmIJ63o2of5
	T8tS3BYeEWqt7d7LOqL8pmHqnXVcSyxCmulx7Mlw9gxc4Ya16k9W7gnBd/WyIGYh
	nDKqwFqVFQ1cIlQxafBFg==
X-ME-Sender: <xms:fLrJZ6sHbcyvX8D9c9FgxvZxVFDTkSYUw7iQuvTuwuLHmAgWBn1Z3A>
    <xme:fLrJZ_cB6qJzs8xLz8UL3g6jc_BqLasjw_FU1R3Kgk77tiNdGuXcdWQW2kovSZRP0
    PB447ioyDFIJdNLPw>
X-ME-Received: <xmr:fLrJZ1wYe5QfFH-CEj6xc8rViLdrrUFwIGRkm4MAR6nT0H0fM72fvQ6qoOOELqjgj2EzWC2Hdnxo3Maq3Z8eiYz5hbpshtNCt3lirN1WxVJF6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlsh
    estghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrd
    horhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fLrJZ1Nz_1Fk_CjL2mTPX0tnDiM6HyRQCZ7Ltjj7EQUPn5rxO06wkQ>
    <xmx:fLrJZ69wKPIrlBzAU4OJEC5hfoG1VPefyxhuESjb2YGw5AL356Cdbw>
    <xmx:fLrJZ9XQr5R2DE2fCyqaXbmZC7RvITDTOTgUq4On58dVovDA_ZAOvQ>
    <xmx:fLrJZzfadPG6lQFVzIaulhXP7nfJ-ey768nQxl_wQA1Xip5x1_p-qg>
    <xmx:fLrJZ_P3w6fA3CWvR0TUWePw-mrKT0Re1A9oRatTP9j-FqTjiQ8J3BEt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:08:43 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 21ec19f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:08:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:08:33 +0100
Subject: [PATCH v5 02/16] object-name: allow skipping ambiguity checks in
 `get_oid()` family
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-pks-update-ref-optimization-v5-2-dcb2ee037e97@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
In-Reply-To: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 shejialuo <shejialuo@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

When reading an object ID via `get_oid_basic()` or any of its related
functions we perform a check whether the object ID is ambiguous, which
can be the case when a reference with the same name exists. While the
check is generally helpful, there are cases where it only adds to the
runtime overhead without providing much of a benefit.

Add a new flag that allows us to disable the check. The flag will be
used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hash.h        | 23 ++++++++++++-----------
 object-name.c |  4 +++-
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/hash.h b/hash.h
index 4367acfec50..5e3c462dc5e 100644
--- a/hash.h
+++ b/hash.h
@@ -193,17 +193,18 @@ struct object_id {
 	int algo;	/* XXX requires 4-byte alignment */
 };
 
-#define GET_OID_QUIETLY           01
-#define GET_OID_COMMIT            02
-#define GET_OID_COMMITTISH        04
-#define GET_OID_TREE             010
-#define GET_OID_TREEISH          020
-#define GET_OID_BLOB             040
-#define GET_OID_FOLLOW_SYMLINKS 0100
-#define GET_OID_RECORD_PATH     0200
-#define GET_OID_ONLY_TO_DIE    04000
-#define GET_OID_REQUIRE_PATH  010000
-#define GET_OID_HASH_ANY      020000
+#define GET_OID_QUIETLY                  01
+#define GET_OID_COMMIT                   02
+#define GET_OID_COMMITTISH               04
+#define GET_OID_TREE                    010
+#define GET_OID_TREEISH                 020
+#define GET_OID_BLOB                    040
+#define GET_OID_FOLLOW_SYMLINKS        0100
+#define GET_OID_RECORD_PATH            0200
+#define GET_OID_ONLY_TO_DIE           04000
+#define GET_OID_REQUIRE_PATH         010000
+#define GET_OID_HASH_ANY             020000
+#define GET_OID_SKIP_AMBIGUITY_CHECK 040000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index 233f3f861e3..85444dbb15b 100644
--- a/object-name.c
+++ b/object-name.c
@@ -961,7 +961,9 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 	int fatal = !(flags & GET_OID_QUIETLY);
 
 	if (len == r->hash_algo->hexsz && !get_oid_hex(str, oid)) {
-		if (repo_settings_get_warn_ambiguous_refs(r) && warn_on_object_refname_ambiguity) {
+		if (!(flags & GET_OID_SKIP_AMBIGUITY_CHECK) &&
+		    repo_settings_get_warn_ambiguous_refs(r) &&
+		    warn_on_object_refname_ambiguity) {
 			refs_found = repo_dwim_ref(r, str, len, &tmp_oid, &real_ref, 0);
 			if (refs_found > 0) {
 				warning(warn_msg, len, str);

-- 
2.49.0.rc0.416.g627208d89d.dirty

