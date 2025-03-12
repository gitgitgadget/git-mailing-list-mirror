Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B780256C7F
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794979; cv=none; b=goP2NjXqEHT93987hfk0G3F8ecs/wQJdnmYgR3WItxZsL121fu0q9FgRms+YMBDHfDehv/NGwGyMeKtqopeYkferEN70lKVRnjVsFSchPskuvsTdJOWeGMgimCfYhai/DOMjKd1AHHRaYnZz3dyVhveh9ZWP6+CtbR50/GIGKIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794979; c=relaxed/simple;
	bh=0f9Y9/EZ53iuqSwxWV5WZcS9qblTqOcD8PlnTpWtKL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFTjbXqjlYVj6B+GXmn0EDq3mhnxMi3hABudioz3aoCZRE4JobRkqqP2ma66kyz34zDVEuxJdDzzXE53RBVS7YfTjD/KEAr0j3V3DI4HRbEo8ewZk5S79/eW1gqxuTfanWCkgnqAmYZN1fH3V5uJlOwX84puPXk4HZbAMfJy5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C6pwJGSr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2XgK6T08; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C6pwJGSr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2XgK6T08"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83482254030B;
	Wed, 12 Mar 2025 11:56:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 12 Mar 2025 11:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741794975;
	 x=1741881375; bh=Odo4sGjB8UB7AFyG+XVCax6uy/MF29PSaSNDMmuBU5M=; b=
	C6pwJGSryDcuUO1Y95uoY3TNre2BUiv3JNAPWHgArMXT7fmWbi0rcRBMsSOfXNUy
	L7k4Cbak2P59rG+FZjJROqDAEoGQ4a4OHI3wa8LDxQ4KDeskDLLJtLPthotBdabL
	lI9G7DCcyQP8yME3bDImw5NO37lrgVoZL6+70k9Lfzr7Uh9LuOP9RYRAjid1oFYj
	P19pCHS/A2jJBaF+urkNzLgPE8IRnEVOjP+YSWimSMJkgj9k1FI3CHRuzlg34nVl
	A993skSr/CXG0DT9tiIfcz8r+1EzepPn5l9GfJphBAgCWnWFeUWxpyYwXVk77mb6
	jxsO4Ac5VJk67cWHC4bK3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741794975; x=
	1741881375; bh=Odo4sGjB8UB7AFyG+XVCax6uy/MF29PSaSNDMmuBU5M=; b=2
	XgK6T08bNLC7DhxYuun5oZ4u9ONeUc/Qn2oDXbNKj+DRP0L4BSw1R80WDHjzIsBB
	2M69/vzxC+ZQxWWOHVnUfmGKapSW3rJIOCQrkImmXhHTm6PQcm5STms9CQKaWP70
	Zjh5aHYyCQWwUtmPBvJ3QC02xOWN1H+E9/vitC8pdnEIid0XEkvfobtlVutgyvk/
	gMI3w5KLRdZg2v4lXm0uFdsk2sDRto9hNmLRcIeQONv5UyDaqrbkQENjRI31StWr
	YLRQFOlTVc8b7UIlzhsfQXrmSlIeXlCa4DrPkep6Hz6+WE30fV3AWQGjOXfLB/bA
	Ecfy33MLlnSkw85rphmSw==
X-ME-Sender: <xms:n67RZ9ygu8LElL2yUpwS7dLHxc1S__CaoWpjnLMhLwEsXJLMsVCHVQ>
    <xme:n67RZ9RBL9etcZvUHwMwD2TzOFtHBWvWfaNRARSKflYmPvEBHnYG94QXXZsQWhyhP
    fZgLFlDe-Spw8N_SA>
X-ME-Received: <xmr:n67RZ3XXE5N4-DZwd6ZHS4pP3bYdMV1KFvgCEvjYQLSI35kju38lUMcW2vr48X1waHHaPjOIm1yZL1E4Vr3l7IJmtuiYKQ7NvWEp0mhhtGwF2aouGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegthhhr
    ihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:n67RZ_hGxc2i3IJIfRkw7yzZHep5Lp7VYWETSJtrGnZmyAnxJh70jw>
    <xmx:n67RZ_DLpZNXii6GI5PUOq3qEviOp5xpjZGmjXqeIPsBT5wzCpS62Q>
    <xmx:n67RZ4IR-HRlrb9OR19DZV75JRlk1zzFUlZHWCrkO-ECdinKVheaqA>
    <xmx:n67RZ-DRz__0-A7uQCBO38LYGEuEkK8gOyQbQD1gEXksfi--ZzF0Fg>
    <xmx:n67RZxDp_Ef9ROyu_BuKWnJEnzIKsgYAHgljlX-0dAw6xDXEw6jMRt0r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:56:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bb8b8ba0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:56:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 12 Mar 2025 16:56:08 +0100
Subject: [PATCH v6 02/16] object-name: allow skipping ambiguity checks in
 `get_oid()` family
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-pks-update-ref-optimization-v6-2-f778e0414f55@pks.im>
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im>
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
2.49.0.rc2.394.gf6994c5077.dirty

