Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4990731AA9E
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767791309; cv=none; b=hoj4Ld3pOkF5b2ksIy/N1Pp44WKoT65mqJz7FSPabNNEfe8rcxjSVzyV1wDIQ+CVWSqHxqVqbkd6QnHPamJH/nmS1xvsrmuL8JxmPAPPtnjf78bL9BbjPra1upMeyIzLHjwXiBLHrJ9qgcoTiTEGolZ5YC7Z6xLIqu9d7zT4lmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767791309; c=relaxed/simple;
	bh=C7A1U5SUhnYuxUiBgHxgAdnsAcfQaILB1JMj7+lBik4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QaFlPJ5PvjayC9P6oaT82ez+ssjVzji/J0ZyY9inxdSf/o1UnBnm3DL/tcKkKQEE5oiaK0zN8Jdv06TAFGvO/0p5vUL9c3rnlOmkkX+tTk9U9raF+pQpopN/oa/1JBj9o8g3kik0o0ZixTWPIfk0MJv1pIt4/sEtuEQrnkMq7ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a72JVAhM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=prVqsptb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a72JVAhM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="prVqsptb"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7BD81140011F;
	Wed,  7 Jan 2026 08:08:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 Jan 2026 08:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767791307;
	 x=1767877707; bh=s9TlejasDSsSW2N8JDqW8lUh6oLoyiAAlPmvYhH2l08=; b=
	a72JVAhM58d4mfJu+RknZeZ3LX8iQ6w023kA5zovSuMAhyMzxtDkoVdcwslZNWk5
	4GvukGL7h1oEaf8d8WQPg4XBphziygzI2lqbG/H/VHe2uYE/5pj+8DR3sNn/umnL
	7CmTGRea9+DmRIHdjz41V/NBU46PySmtrRkGmQzXlXg1R15kIk1bYosI10pNC2uF
	Iy3a1QswcRypqus78lj92k+Mg0TXs+fkHtjn11aCGEGV5GfL/vuhX01FyawI2B1t
	CU5omIsXSJIF1Y9nRUyjrLSOExRfiyGO7hmdSGLkmtm+8VrHISD2r5fanuaI9WTZ
	M5AtnIiAYY3UelU/33hfEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767791307; x=
	1767877707; bh=s9TlejasDSsSW2N8JDqW8lUh6oLoyiAAlPmvYhH2l08=; b=p
	rVqsptbmmPf7jzg5Q4jyV1DVdG7YOFCWE0uRmVZNxqvu53B7xEL9JcN/ehjloMHM
	rANClBp2MrtxF34wwHWjsAYDqIn0EaaaFbFv0F9P//07ka2KCg+AHmySsWIeBiCZ
	HIPOdSjVIjZvK4z3Z1AVfXSG3Wn9Y8RXGDnpoTpTOhaa5Fcz2lnBKP93wumz5Y7H
	3LTPIVnoIackaOJKcxqM3uGQqaZM4W3+epi4Da6sBoDDyBgC5z5K6wWwkO4cwWuz
	WFc6TPAR79ZXck6zVMflQQolkt+G9F1/TXrIIB1jepKcjbQdjWAveF+Xi5CT5mNd
	LN70q/HNuvROw83CO5cbg==
X-ME-Sender: <xms:y1peaV-Ad2Q5BcnT5nApAX_7I-V3QGo0hYl1FO9sMoPyPgKvDGM88Q>
    <xme:y1peadZDPNXQJr4v11z8lyYOqYSwUXEag5hvKnz-iduDoCtGcCEQXIQslXLzIE39I
    W28xTCUrCubY7rY3K2rDQuuZbQ5PfenoJDF47KNYJtueJMlcx1EGx8>
X-ME-Received: <xmr:y1peac2AplXkRiPCz_bLX5LE8iRAy747JvsU_6l1vFRcGbF83ohq5C-sZjiGbgVVuRtON27w1TcTeXpx3ffncaKXHxFnjLh5_M-Xa0t26Pc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdr
    tghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtoheprghplhgrthhtnhgvrhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:y1peaQZ1hnZm_ziyxpZUKrERkeibOIVp0fPyG3WHUxtVD9GNS8ZNyw>
    <xmx:y1peacIGYcDzNaZM4UzhVy4p3uu9IlXfFsZvRCFOZSXNhqQ1QXIK-w>
    <xmx:y1peaXFLahtTsSPPm4mp_XnglXhkxgRj1Yx5WXzNshGoUWzOMGj15g>
    <xmx:y1peabsbPsSeuRn4n-gnYT19ADwdmNhDpu5z40jK-tWrGsqZVsopGA>
    <xmx:y1peaR8D07qGdq1xXqsnF8w_lGaBiul3jTHk_tskLZWDqWopJxv6itA7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 08:08:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 233e520c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 13:08:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 14:08:04 +0100
Subject: [PATCH v4 5/7] packfile: disentangle return value of
 `packed_object_info()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-odb-read-object-info-improvements-v4-5-b5d55c47082a@pks.im>
References: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
In-Reply-To: <20260107-b4-pks-odb-read-object-info-improvements-v4-0-b5d55c47082a@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Aaron Plattner <aplattner@nvidia.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The `packed_object_info()` function returns the type of the packed
object. While we use an `enum object_type` to store the return value,
this type is not to be confused with the actual object type. It _may_
contain the object type, but it may just as well encode that the given
packed object is stored as a delta.

We have removed the only caller that relied on this returned object type
in the preceding commit, so let's simplify semantics and return either 0
on success or a negative error code otherwise.

This unblocks a small optimization where we can skip reading the object
type altogether.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 21 ++++++++++++---------
 packfile.h |  4 ++++
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/packfile.c b/packfile.c
index f7c33a2f77..8c6ef45a67 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1587,6 +1587,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 	unsigned long size;
 	off_t curpos = obj_offset;
 	enum object_type type;
+	int ret;
 
 	/*
 	 * We always get the representation type, but only convert it to
@@ -1607,12 +1608,12 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			off_t base_offset = get_delta_base(p, &w_curs, &tmp_pos,
 							   type, obj_offset);
 			if (!base_offset) {
-				type = OBJ_BAD;
+				ret = -1;
 				goto out;
 			}
 			*oi->sizep = get_size_from_delta(p, &w_curs, tmp_pos);
 			if (*oi->sizep == 0) {
-				type = OBJ_BAD;
+				ret = -1;
 				goto out;
 			}
 		} else {
@@ -1625,7 +1626,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
 			error("could not find object at offset %"PRIuMAX" "
 			      "in pack %s", (uintmax_t)obj_offset, p->pack_name);
-			type = OBJ_BAD;
+			ret = -1;
 			goto out;
 		}
 
@@ -1639,7 +1640,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		if (oi->typep)
 			*oi->typep = ptot;
 		if (ptot < 0) {
-			type = OBJ_BAD;
+			ret = -1;
 			goto out;
 		}
 	}
@@ -1649,7 +1650,7 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 			if (get_delta_base_oid(p, &w_curs, curpos,
 					       oi->delta_base_oid,
 					       type, obj_offset) < 0) {
-				type = OBJ_BAD;
+				ret = -1;
 				goto out;
 			}
 		} else
@@ -1672,9 +1673,11 @@ int packed_object_info(struct repository *r, struct packed_git *p,
 		break;
 	}
 
+	ret = 0;
+
 out:
 	unuse_pack(&w_curs);
-	return type;
+	return ret;
 }
 
 static void *unpack_compressed_entry(struct packed_git *p,
@@ -2152,7 +2155,7 @@ int packfile_store_read_object_info(struct packfile_store *store,
 				    unsigned flags UNUSED)
 {
 	struct pack_entry e;
-	int rtype;
+	int ret;
 
 	if (!find_pack_entry(store->odb->repo, oid, &e))
 		return 1;
@@ -2164,8 +2167,8 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (!oi)
 		return 0;
 
-	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
-	if (rtype < 0) {
+	ret = packed_object_info(store->odb->repo, e.p, e.offset, oi);
+	if (ret < 0) {
 		mark_bad_packed_object(e.p, oid);
 		return -1;
 	}
diff --git a/packfile.h b/packfile.h
index 59d162a3f4..d7cce582af 100644
--- a/packfile.h
+++ b/packfile.h
@@ -378,6 +378,10 @@ void release_pack_memory(size_t);
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
+/*
+ * Look up the object info for a specific offset in the packfile.
+ * Returns zero on success, a negative error code otherwise.
+ */
 int packed_object_info(struct repository *r,
 		       struct packed_git *pack,
 		       off_t offset, struct object_info *);

-- 
2.52.0.542.g9473a8513b.dirty

