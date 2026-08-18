Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B27344036
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062793; cv=none; b=NW/qtA4W6YYeq6f1arTvFiEmNA+GLrvYbRS9vZjj2Y/vjlB1UbIelCFKn8uzydSR//J8EhTfAQwOnapqkPbKh8p4oj/OqCLoF1hvci92PbMdiXWRXRp1iQNp++qRBo2KLS0ppcIfIF9Dcfvn8f6Hpmgp9PjV0IIlcn4e5GHgpNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062793; c=relaxed/simple;
	bh=54YKCbhq7MpjdDOD58LooYlPVmLUyhAqOJuBbv+7FbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kcDf/oFR00k2jVZByslNUJnA1U4tWAxih28kePnpfy+GISp2VInlass82J4ex7KKUqgLv7BIrvsGecdvVI+s3mYqr1Zsn8OWMUxEH4aDbTrUgnCLRqvHFL25x7PN3rm6GP3xpAxUYivmTZW1aAHmzyHQ8F8ndIumPERDFrCokxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RljnRBtv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IYlQcBNO; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RljnRBtv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IYlQcBNO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0A9847A013F
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 18 Aug 2026 10:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787062791;
	 x=1787149191; bh=wNyKrE2vizerl0PfeFPcwU5C72c69kT4GjjnMXZmZ88=; b=
	RljnRBtv9TqmjIenNeXbz6alU9Et8dqT3YGCjn0+2BO0KlhPd8LHLG4isyVy5dvk
	ZJp08wXFd/d5HgC5SvlqqEBvPGd8yRKnYKrGBk1KLAFW2UZ+58oqHbk7uu6fgX3I
	5FNyAOUQCXJ2oK0m5oSRHlNmmBWhRXalfcujpyvGo4O2JbqXGQC7TMpFz1k8+2bk
	v4ezy5bh8ZQKGnbRbngFJNBSbVrbOT4TGr+W6giquL/zPXlChg5GlGBx5YKflB+T
	R6rlAmWGPEOtXQvuqKjZ2QSRtC+g5ubzEL53XRKPtnxRLDRQiqpmZBmXY7T7BPmS
	Fz8qvCYGX+sc7BqX0YxWGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787062791; x=
	1787149191; bh=wNyKrE2vizerl0PfeFPcwU5C72c69kT4GjjnMXZmZ88=; b=I
	YlQcBNOgZ1veTQDolk6OybexcZQfQZBKE6JzI0Zvfk0ucLJ+KFxhBLZTyf00my+A
	auzWGOeSdqpJUCQeUHu7AvtqHZNtRR/EiagH/1BdLoa5AlN4kP2iyOXwO5kECCKG
	iR7MDL1Kpd/gMGycf4JugoqV4/m0Pilc9IzMpix+fyIn8IzPtCpe/29a9FxGyuF2
	suSy7vkY8zueigY9quLZiOO1nt1g/dJlRD+Bkoe9QdwWfQhg4KbvofyX+fe7iZvY
	4aNjtaLv+dz/bkGSO9vjU1gLk1+D0ZqkZsTCsexlGBKca+Ht6kuy38gWP4rhQOus
	hYET4gO4RnxlWv33LRWaA==
X-ME-Sender: <xms:B2qEamJLjiNW0-nztsjWoX1MiB6swQr1JVdaxJKN1Mo9_3kt_N7hzg>
    <xme:B2qEalE5SBynJQfekE7sUewsAxlt9cAjTNoVz0A64-R9ivfbKKii8u93GF0aEglXq
    B1RTbgkyZSj_bJFSIuBKUoIAvKaYfCH-bYMWsEv01JjJTRLeU5Jig>
X-ME-Received: <xmr:B2qEasWYDX_1QbFS4V4XL0jJOOotlwFdj69zqlZeMOSounugejd3G0goItaHINQFJ4miPFStFq__0sn_G9eXRAXipXv-WOFM0YSKWAiz>
X-ME-Proxy-Cause: dmFkZTFi9gTDGN5rU6v5bk4puH/TN6PnebWJZuvNiMPwE2cjL/TcvdlYqVaQ+lghmSk/qN
    WCasTuwVGcAbpI1P2OnhaZi0kO9rwywa2//F8UO4KwrYPyqIVy8n3cjkIejGy2zTwRJWTO
    2g4RZKKUqC/L0EQ1DOWFvX9CJk/85pj90zgi9yL3SAXHLijFYCUIGa9l2nu9m1z149jyrj
    iVnndofBls0dTQZrLD/SJsERHbs2ZKG9wFCTkCpCcBmjHjSfmbQUtLdkHp0u/JktXsA4/v
    2ltnMeFDVWCfVv6/ePXXwP1mhEgz1iDdYm09PKsAH+RLX1v7QmJBJ4XCDQs1kQLkCd/4jw
    jnTZY8NZcCZZ9xyYXkZY9DzY5IYBZa5Gry5pGVwM6gZhJPHYQd/UsfIzy9szHmzW3Yt/b+
    7i3e5uTQ/UV6ki2FnYyEzU6/hXJ491j5oxrr8CynVtBPidlDqAmZM9/emu4Wp//9H2PBo8
    +jtT51NVTmGIyrQLzb6t2nYSpSrKK/PLkJ3eytlh4UUHdDJcam2DRLTcoFwoLXgJnd18a5
    NJNBPAJ7MKGdpb2QWpIhuvutiBgCLDZVpqJEfIYmGcyPP7/3novPJptBdKrKEUr7EeT9mf
    sSHYChleqLbOCd2AbVyjaMOYzDeb394TluOtVesmO2txk3HULuE3G5dv931Q
X-ME-Proxy: <xmx:B2qEagiLHGRq9k0Y9EBlnhCayvBF2QYasYLOoRC8yup1yACj0sLkjQ>
    <xmx:B2qEatRXlQEwhjjNp2Fj9vJa2BqwfpIrLfnFFhFabQU7hCoMCZeNJQ>
    <xmx:B2qEajHKmWprjpMDQEHekY9KecE1s7MFuBJNlH8lI0_NF1v-Ts1h7g>
    <xmx:B2qEalkmToEjnl5wokuXwCATqKL8crb_giltJI0GZhTbmMMwYht5rA>
    <xmx:B2qEanqs6QXXuT8V58QmdsGz1vhDEmOtssDFK1eGaru4qgA5mOajoo6E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 18 Aug 2026 10:19:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9339d9ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 18 Aug 2026 14:19:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Aug 2026 16:19:32 +0200
Subject: [PATCH 5/7] odb/source-files: signal mark objects via positive
 return
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-pks-odb-generic-corrupt-objects-v1-5-ec234567510f@pks.im>
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The files source conflates all failures of its child sources into a
negative return value, so callers cannot tell apart whether an object is
missing or whether reading it has failed. Both the packed and the loose
source have been converted to adhere to the tri-state return convention
of `read_object_info()` by now, so all that is left to do is to
propagate their respective return values.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 5a68af7d84..1124a18091 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -65,12 +65,26 @@ static int odb_source_files_read_object_info(struct odb_source *source,
 					     enum object_info_flags flags)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
+	int ret_packed, ret_loose;
 
-	if (!odb_source_read_object_info(&files->packed->base, oid, oi, flags) ||
-	    !odb_source_read_object_info(&files->loose->base, oid, oi, flags))
+	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi, flags);
+	if (!ret_packed)
 		return 0;
 
-	return -1;
+	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags);
+	if (!ret_loose)
+		return 0;
+
+	/*
+	 * Reading the packed object may have failed even though the object
+	 * exists, for example because it is corrupt. Report this failure to
+	 * the caller in case neither of the sources was able to read the
+	 * object, and prefer the error of the packed source in case both
+	 * reads have failed.
+	 */
+	if (ret_packed < 0)
+		return ret_packed;
+	return ret_loose;
 }
 
 static int odb_source_files_read_object_stream(struct odb_read_stream **out,

-- 
2.55.0.822.g20453c30eb.dirty

