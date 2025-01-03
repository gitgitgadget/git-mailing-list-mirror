Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D361C7B62
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 08:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892402; cv=none; b=Xb0O8E0qQRncUDu+9C30080LiDppE0ODT5BUibjOVmtomUUsjxH9239lIe0u0M87zRy2Mn2XU4W7XuOUJ4eQueBJChd/fZOsyyGqPalB+rUd6W1+Z5g9xr0Km2xPynOP6ePjivN3Gg/Ibxz/7WrtOxYnMPpZqFVPCanpj8+sOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892402; c=relaxed/simple;
	bh=vUlH2rYpgL7UYDgIYch0FjQee+4qaqBcalnhqPAwZGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UfLot4RCkWODe+95u+R9qoJggC5PgKR/S1OSnyL/axw5iy0fuDgtzuvO2uk+Wbv5unxORvHlRS/yeZdusruLCtF5UyqhyX6T//+r2hJ9yfxTqerFVlPmzxmME0s6tUV6MSCTkrdUG7+5GQiHOvtXWIRb/1auv65YYdpdwLMGoSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s32853bQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KxD9AAmM; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s32853bQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KxD9AAmM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F655114022B;
	Fri,  3 Jan 2025 03:19:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jan 2025 03:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735892399;
	 x=1735978799; bh=2jl7SD9NIMNiRobtMc0O3TvOTZ1z8eMZ4tbF4Ua8DL4=; b=
	s32853bQcA+p8G523mSXeHZCmd1m7ybNp/perZAqQ7IHR1OThpvjijKDR+VSMJJI
	jJfLZXwS7ZNyg4jlhHOq7NW45rGL4rPx9ayTmczAmwfyIhUYyRcTgasrZk8f4r7B
	vlrTZ91M7b1fKkRBTkPzL9E619hIG2+QnLpEM0zfjpFCnEY4PvibHfzxi6CDGEsj
	S4734S/KZok1U5D/3nQwvV8MNYoVAhRT7JC60NZZ7WxMlTxhzTUrmNEXS1vISNT/
	n/hTCwHpfLXpqmCSM//+PvnNSTfsYeynYqVlh2oEZTuDi0Z83r/mVKoc3njlYaa+
	xITcKuiTf2n80y7MtHZV5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735892399; x=
	1735978799; bh=2jl7SD9NIMNiRobtMc0O3TvOTZ1z8eMZ4tbF4Ua8DL4=; b=K
	xD9AAmMeQihnNpIH/dO3n33kQW9lnCPlTdswe0giXV31RYbyAne1RuX3i2EiuXJ7
	jWtsz2+et7WuEwvn0TMtFTTi2EW1KcuTwUXdmpOzA6dVFQiH7YlXDKG4U/fDJQ2l
	n+O0LXUdn8LKh+nabposqMiLEdhd88sMy2ax/U1Oghm17GCIgRtMq0wObmegF+x2
	x9SQWGuxJWZ7bts69W52AXysC+KT/xPTLeKMWJ09VNB7Opz1sKEJikGfFsa36+ZC
	llj8FFEPcAVT6tNVzvTbu7S8spSUFBAb2jAo9zw7zC/omHDRx95xW/waplcR81NJ
	2BuhfbtDyOl3A8ORxZw/Q==
X-ME-Sender: <xms:r513Z774URmSNul_jmq2CYLLAC1xHn2bjD-cNwrxmPgTwhZrbVEhPQ>
    <xme:r513Zw65f8iY3UDNSnlnhxDH6OPiVtJdMt1-byIl6uU8yVlUcani5OEJhgRZP5ekH
    02pFR2oeh2iFuVO0A>
X-ME-Received: <xmr:r513Zye37NJSEKUj2jul_mVjjLKaOqqm6DfMbTDIXMfOHNfz8ugsZUI4CTiXhJaXx1JwRsSRjtakei6bOxhhdVKN8-QFkQ-u93L5wvsmC0QXmLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:r513Z8JxLmrYhaugJr_7_wOc-jU9GBLFWkNJkfO_S9AyUJedXh1Xxg>
    <xmx:r513Z_J_FkfHezfhCbc9ydemNzo2YD7M5ordZi0lLWBhLcaXz8nnWg>
    <xmx:r513Z1yChsvKW53xhcMF3-CdDvgREQFlZ_H7KHv2aYcs8yBmdieoxA>
    <xmx:r513Z7K60ei7Gscb8mR54WFmPkKo63o_bGl1g4sPs6onwzKcqpLldQ>
    <xmx:r513Z31XQqjhYLQ6TT5N6JZjNcPc16IWBdqnHu9IHJn8z2Rv6qFobSXK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 03:19:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d7aba7db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 08:19:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 09:19:54 +0100
Subject: [PATCH 1/2] object-file: rename variables in `check_collision()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-object-file-racy-collision-check-v1-1-6ef9e2da1f87@pks.im>
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
In-Reply-To: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Rename variables used in `check_collision()` to clearly identify which
file is the source and which is the destination. This will make the next
step easier to reason about when we start to treat those files different
from one another.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/object-file.c b/object-file.c
index f84dcd2f2a7b88716ab47bc00ee7a605a82e8d21..e1989236ca87e565dea4d003f57882f257889ecf 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1970,56 +1970,56 @@ static void write_object_file_prepare_literally(const struct git_hash_algo *algo
 	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
 }
 
-static int check_collision(const char *filename_a, const char *filename_b)
+static int check_collision(const char *source, const char *dest)
 {
-	char buf_a[4096], buf_b[4096];
-	int fd_a = -1, fd_b = -1;
+	char buf_source[4096], buf_dest[4096];
+	int fd_source = -1, fd_dest = -1;
 	int ret = 0;
 
-	fd_a = open(filename_a, O_RDONLY);
-	if (fd_a < 0) {
+	fd_source = open(source, O_RDONLY);
+	if (fd_source < 0) {
 		if (errno != ENOENT)
-			ret = error_errno(_("unable to open %s"), filename_a);
+			ret = error_errno(_("unable to open %s"), source);
 		goto out;
 	}
 
-	fd_b = open(filename_b, O_RDONLY);
-	if (fd_b < 0) {
+	fd_dest = open(dest, O_RDONLY);
+	if (fd_dest < 0) {
 		if (errno != ENOENT)
-			ret = error_errno(_("unable to open %s"), filename_b);
+			ret = error_errno(_("unable to open %s"), dest);
 		goto out;
 	}
 
 	while (1) {
 		ssize_t sz_a, sz_b;
 
-		sz_a = read_in_full(fd_a, buf_a, sizeof(buf_a));
+		sz_a = read_in_full(fd_source, buf_source, sizeof(buf_source));
 		if (sz_a < 0) {
-			ret = error_errno(_("unable to read %s"), filename_a);
+			ret = error_errno(_("unable to read %s"), source);
 			goto out;
 		}
 
-		sz_b = read_in_full(fd_b, buf_b, sizeof(buf_b));
+		sz_b = read_in_full(fd_dest, buf_dest, sizeof(buf_dest));
 		if (sz_b < 0) {
-			ret = error_errno(_("unable to read %s"), filename_b);
+			ret = error_errno(_("unable to read %s"), dest);
 			goto out;
 		}
 
-		if (sz_a != sz_b || memcmp(buf_a, buf_b, sz_a)) {
+		if (sz_a != sz_b || memcmp(buf_source, buf_dest, sz_a)) {
 			ret = error(_("files '%s' and '%s' differ in contents"),
-				    filename_a, filename_b);
+				    source, dest);
 			goto out;
 		}
 
-		if (sz_a < sizeof(buf_a))
+		if (sz_a < sizeof(buf_source))
 			break;
 	}
 
 out:
-	if (fd_a > -1)
-		close(fd_a);
-	if (fd_b > -1)
-		close(fd_b);
+	if (fd_source > -1)
+		close(fd_source);
+	if (fd_dest > -1)
+		close(fd_dest);
 	return ret;
 }
 

-- 
2.48.0.rc1.241.g6c04ab211c.dirty

