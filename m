Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01A047CC99
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260992; cv=none; b=pM8IQd5bsYbBDBU+1gFT0btvkh7/qXGP6jMx7UGcQnfJmvSlQmoqvpqg1P1/DCMQopPO9DnBa9VNP6D04Tp8FoTlJwbowpPGac5R0PSBRfUhFrBjRAWO6po2OMVzTpA2QNq037/eTVjmfnCOdObWUSyqZPZNeQSzr5aV7UV23l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260992; c=relaxed/simple;
	bh=ptya8iBbCl/fsUdYq5iBi/S4H4SM+6WLr4GVCVXv/rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JX+L9SPB0R5mrtw1E+Igbh87ueCE+a6Fvw5OhyvKbr9fgfL3oS54TgwRMBtQ5cuCMhwx0Gwp+XOwDd4yZh/L+9w0jiFogAhtWI9KASrNyBOsnQxzBRzgOgYq80DmiACB5SQpuTPfrJ1RrcwemZVDSc0vIrqKjT4pTRVUzWyf9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VctDwe0Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SyVLIYLh; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VctDwe0Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SyVLIYLh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B5CA3EC00EA
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 07:09:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Sep 2026 07:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788260990;
	 x=1788347390; bh=t9hsW+tLmhyhYjlZQ3DOL31zmcvFRxYHCyg/d9tUTYA=; b=
	VctDwe0QayBU/EeAyVG6cugdGB5qcKonb+UUTLJxV318LMGLzkkhWATeAJyKvpe+
	0S2jLY9q/En+hFmav8/eznjcfH2FWWwe4w5VWTOrkwlcSs3vU5ogoSU4aSakCZRj
	i/XiIHGMFKNfRvVrd3qh5PGwvnLD4S13lP1DKRLfpNci0OzmPDvgdfWqANSsKJS4
	jzgH/paTvD3lc5yABX73KEpd1LwVSxerPSnp5u8gS77cFnAW21cZtWhxAgA4BZoY
	5xcHfA5OSDMcHT1i2nNVbfH7mNgsLnRCfmzzWrRJIF6VNg4bZQP1pnNKQTjyN5xe
	t8tDV8PrH7oU7dloCp7y2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1788260990; x=
	1788347390; bh=t9hsW+tLmhyhYjlZQ3DOL31zmcvFRxYHCyg/d9tUTYA=; b=S
	yVLIYLhmwBdbTa7IHtDdBZtiNWsQOQMBBg4nXUU0vN5ndjc1qPZlP0cY7qpNhWkc
	MZunUERMUW83rIMkPqoP5xMRt+t0/g2Uu5jIeUA2qWkAg85qmJEPIzsxekrLWgq0
	X6QNa1FXu8hjUs0YnXgCsDHY4S8xfBzl1G/hrdCYubGhbbob0Kcpx+sxB8lrPyOV
	19yNpCoeUeD+OBfhGj4hAVB4uZX4GtFPS7DMR/yIQuoGbYmpgybNy8x8cmQJL4G/
	l50e8kjzjC6fDMZxnxt/7sAgBrWvPz6vAnEK57xDPmWnSOtmOK25R3S6KllUi1yW
	YRp0pXWVwjZkBl5/MFlUg==
X-ME-Sender: <xms:frKWatYY0HUuhoD1wsPbqHp2naGnJbhPyZ80PYgzXCZFbntU4XfWkg>
    <xme:frKWarXr0j-jbGJM20-zDN6hH1_S8qXZEyzlMmLDEzyCcdyrkSIEHbSrCRPKMyWnJ
    NuRh3CvN5yiJNFULB37ktINFv_zxeyxLEFTKTLKbhu-wfy2vP_VDw>
X-ME-Received: <xmr:frKWalllkWnTZThEdEIgrfrVKMQiOx2bDuxtTWqTxRDTyigGT4ZSJQ>
X-ME-Proxy-Cause: dmFkZTEN9g1Fe0QNve9ECoP2TiUiX4EEH5POEiwmRiQIlHZ+xDbzHkU7NDd2M3NVK6/umO
    bXXkzUK3COWchLgt1/LK6gQ+MqeSaO5Oixh8RPOTrogDUVvdApPqyytnFYWyXEx31a/UW/
    VrRjQoyTePvVd8NFe+FYtwmzmG6MTjOdJtb92EaY7FcVv+MSIEhwv9SzJucvjBA0gTjUZ5
    irBlskFAJd/x0/Ql5UqM+PWol2xq0PhHqo6xS2QHAKohbPBqVxfe/t/HxXIdPstzFq1tQ2
    zZWYaDW+dfkh9KQoVCr2N9lwFiWtupwGIIOt/EhVGn/DGYrANZ/6T7aifXl4bC+/EDNaNV
    o/B5+v0VwRpA36+GoZS2H4vT+oONBFCRX7dEtY2TSb2ed8nszddII9rdo5adBWuF/FtsSv
    MXIgz0bz+SBuAjZ5hnPd8jcitpmabFLZcfPqru9qhEqJUVxrdPjA9Yb2WGA/43vduSDzM1
    a8A/7gzgDLo6Aqt5mos6Nmc2UANs22d75NLBPR6izv+Te5dpqsxXkebJAGwh0u8nUjdMRP
    72ABbolMBvHi6czD3Md8nqpcNYxoKbapO7WJFqJ268PdciHU+Sliq4uZVZT+BTt43o1OfK
    76HD+00cN3scNdV/Y/Kp0BEFAvAM7fCDUePhcOCSXcDEwwWtzxPiaGsNs24w
X-ME-Proxy: <xmx:frKWagyed5i4NZY0z9BUULFtHFFst-XD9XIkfQ4FzBezhJJ8ltSI4A>
    <xmx:frKWaogIIh_QHlP14m2MhMl0DLMKO5KF-6EWbMEBun_ROyp_v_67oA>
    <xmx:frKWatW-MmTZQNIv2N5VoCLBu6zrMQppHhZ3wGc5MDL0F98Stfm3eA>
    <xmx:frKWai2oafKzKDZjlJow6RZmsLBqV6RDI9MhKXeyounVOSsQK1rr2A>
    <xmx:frKWan6I_yRNxKquIG23aIfe_BC4gXsfWWfONNh-hF1beuhw8jAZKnDQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 1 Sep 2026 07:09:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dd4202c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 1 Sep 2026 11:09:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Sep 2026 13:09:06 +0200
Subject: [PATCH 07/12] tmp-objdir: drop unused function to register
 alternate
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-pks-odb-registering-in-memory-sources-v1-7-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The last caller of `tmp_objdir_add_as_alternate()` went away in
bdee7b3013 (builtin/receive-pack: stage incoming objects via ODB
transactions, 2026-07-10) and is unused now. Remove the function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 tmp-objdir.c | 5 -----
 tmp-objdir.h | 6 ------
 2 files changed, 11 deletions(-)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index 0eaa79ffd7..deaaf6ba2e 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -321,11 +321,6 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
 	return t->env.v;
 }
 
-void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
-{
-	odb_add_to_alternates_memory(t->repo->objects, t->path.buf);
-}
-
 struct odb_source *tmp_objdir_replace_primary_odb(struct tmp_objdir *t,
 						  int will_destroy)
 {
diff --git a/tmp-objdir.h b/tmp-objdir.h
index 81eb927413..05f0d08d10 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -55,12 +55,6 @@ int tmp_objdir_destroy(struct tmp_objdir *);
  */
 void tmp_objdir_discard_objects(struct tmp_objdir *);
 
-/*
- * Add the temporary object directory as an alternate object store in the
- * current process.
- */
-void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
-
 /*
  * Replaces the writable object store in the current process with the temporary
  * object directory and makes the former main object store an alternate.

-- 
2.55.0.979.g7e5102b832.dirty

