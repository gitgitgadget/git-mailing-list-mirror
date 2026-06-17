Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE83B5854
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678418; cv=none; b=G8CRXiVtDX6tAl4CuTLimim9zbMl5xuag2u7nYDgwcZr8kMbIaILUgSWrpH2aLDYKNMlzWz5wHTuQFLFd3HoaICnRxGB1FrU2Hwkzho7NthC04Gh50jLPurmcd9WCqhYqf98qiyB8yFDpeRqi8HISxyLQ4h1heNMvDhWMdqBdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678418; c=relaxed/simple;
	bh=Vd4/MlUExBZFHzyk6znXgaRCfdtg4LGDwX53zQPhLk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=juS5FzLod+ATOaZXDoUdCMesClQgCFVSksvrkcdflJcIpyEcLyxtfRamRm7GHBTfxndiqA2gFi+v/GOxC8OeBXhMI32AejWkXBhAp4MAElZ1BC2csnnnVPFHXMAtKOGMJE5W/NyQAzxazAQiwUz+gdxkKR7NQyKzTChYo8UubLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=saQ/dsdQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I5KUp13x; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="saQ/dsdQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I5KUp13x"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 971871D0012F;
	Wed, 17 Jun 2026 02:40:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 17 Jun 2026 02:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678416;
	 x=1781764816; bh=P1kKdl1BiL6/lyQnNXGzGovT9B87CbHuZPzKXQ9EPPA=; b=
	saQ/dsdQ3ebqB8tLIETBigPX2gjVL5CpXtfu1jdMBs1lWq7uGhPv1U/+ef+uPjVa
	pnTPMG03ncOr370AelZq07B5Jy2ZPtIwMSAtfIqI8Nm1vG/0qf5Jgq8nnWkiVhF7
	AIb2/+iQ8X3smCJJHr1bZlo1W5vOXOOhbaA0IoF0UY3UIcpVbhJpn22ZitMrNyjh
	bpx8HXrXVJlmjiuHFvvowGK3JtMbM+LFcnY5HffdyzH1E0IZXfdTYRj5c+TZSGEu
	G4XQU2rDbxtD3Wc8i3JtsyFAJEgZrx1y4yavjjEg19zMxQOcdIcb849QL8bzdWbp
	jk4h24ZzQupLVSLo7Z0V7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678416; x=
	1781764816; bh=P1kKdl1BiL6/lyQnNXGzGovT9B87CbHuZPzKXQ9EPPA=; b=I
	5KUp13xf3+lgopcz/UpN6vmhRcCDDBrTEZr20I7WzXZJ4l9NdQjoMRTJyLxSNXyR
	nATbLcQVmgrCM3ciliwRMbvhTXiIXtlrNOtHxrFs0/mVLsRmNBg+3M+FC5950vQf
	ccglFGjjf1zZrEgvOBTcprjDL/IQya2nmVVc1k2PIMUY6kmrT6NDOGgvNNhC+Uvz
	UpFulYLL1zzXL966+RAYB6mHQRAM3VMN0AyL7zgnCiO+u0LbWNCzKu+k+qzD3ep8
	59TQKzc2GiznRgupfnUCr+7MhtU3pkqOdaMPQA651ufvqMIqEi/sPrJRcCgOCXLN
	yn9r4L7Y31oZR2F24SorQ==
X-ME-Sender: <xms:UEEyalAOO5OKD0_avjDaSjBhO0cHwl11sRsDjqdGHWMbNfK3oKZWIQ>
    <xme:UEEyaq_vkgKD_O-bLx_t68tlFwMN_6Hevny0dZnlhLxPdDz0r-9S-z4TiQyMFcCsk
    7d1txe4aa1ePhJbeSGblvummqWaxpubQ926M-bXBLCsQ02t-SgW>
X-ME-Received: <xmr:UEEyat9PuQfT6vfRJ6vOF02U847giO9Atjb_HJ6jmLpADl8QGzkrAL0PdWLSZdRxZAagE7TQ6-M5tokBzSHYQNOvw1di1eXK75PtQ0w>
X-ME-Proxy-Cause: dmFkZTEnB39eLvyMgsk+d1zBATJAS2Dd09yZUP4TCe4zWysBccoWgY8Y+enBv1+9aJfPT8
    oVvaCC5MWGV30uZzKswgiCAK2gGSGYELp/F+QCNhRNY/bQx6x+ywijOIUW8TKDwAx48Lcx
    KhLHoOJu9m1Ux2Kfz7iOtjqmT/hnPJJkdtWT0xsGgHMCb1yqiVx9G0A93DDw8nseLTKulF
    USUks9qtFi47cv66z4EPIfMktSNXs9lIOpQJ4JZJ8Sqt4LT7yml6xL5bA1DQ7F1XoINCS5
    8+0eJLKjW+BUl0nBlxv0Wa8T6T4Bg1YQKal6uMYv+KeVZbCqw870pv0xnOpn9ZF3vGEMaK
    izS9mKooVIpHX/e0lFHJ3ZMg6Rvlqeupki++3moXrHiVcm876/grAVrx4auekQJsGykJ2z
    CkLGNoATsGFZ7+Vqt3xp39rCgeK8r6QGZywBhS3PV4X6TbjBsBUKbVtzJNU54Azr/wSOJT
    OEjxCkxp5p/y4u86nxZGAPvfYicIu1X49I1TRCz/Tog/k7exQ+f85LHf3VqSQFy9UcN/Rf
    xEqsWHq7mK4xVYGicBcNTN7L0YMpfP9IHHQw9rXbDHNh+qsO8V17mZU3se0057rDehPD9P
    oxawTRTq2E0IpMYfcvJZud+5H8KEUGchGhcsFr/KHHAJhaJC7WtkruIlR9Mw
X-ME-Proxy: <xmx:UEEyapffB7RG3qObjcZcMOzJ7jENEVtAhqO72VDS5vZ9HEH9YTXBUg>
    <xmx:UEEyauFY0TV9WW871spJBTs_2Yfom7tsOVSDARkCKRPkwZY_u-uJTg>
    <xmx:UEEyavd--hfyDtDkm9Whga3H5MOBauqOn3mY41Q7DxG_QERapXS6GQ>
    <xmx:UEEyagEDQe80HY0FZspuzfWqtkl7fiLcG8thxCVKUQgdGdPRoKBZEg>
    <xmx:UEEyaubqLaqzHuJtpNzo2MowDauLYRatVd9ql1hjhdiS3oG2h-cIsfmy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bef4ba2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:51 +0200
Subject: [PATCH v3 08/17] packfile: use higher-level interface to implement
 `has_object_pack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-8-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

In `has_object_pack()` we're checking whether a specific object exists
as part of a packfile. This is done by calling the low-level function
`find_pack_entry()`, but this function will eventually be moved into
"odb/source-packed.c" and made file-local.

Refactor the code to use `packfile_store_read_object_info()` instead.
This refactoring is functionally equivalent as that function will call
`find_pack_entry()` itself and then return immediately when it ain't got
no object info pointer as parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/packfile.c b/packfile.c
index 65631f674f..b35afd7797 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2049,14 +2049,12 @@ struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed
 int has_object_pack(struct repository *r, const struct object_id *oid)
 {
 	struct odb_source *source;
-	struct pack_entry e;
 
 	odb_prepare_alternates(r->objects);
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		int ret = find_pack_entry(files->packed, oid, &e);
-		if (ret)
-			return ret;
+		if (!packfile_store_read_object_info(files->packed, oid, NULL, 0))
+			return 1;
 	}
 
 	return 0;

-- 
2.55.0.rc0.786.g65d90a0328.dirty

