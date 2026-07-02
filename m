Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37704968F7
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993741; cv=none; b=uk58uJimS5GTa5RuqNq7KlHvFtSWRawpVbhNdijvwI1W8A0wmNMQ1uGuYhV3GXnjpouThCHzYFe37KKn+JudDTT5eH2eAyf9h82edObk/kvZ5FG3607kf0nz7KYQPKlwE6QDJ/MNtmFy8gPfR4VjyNMk+kJ1SwwXiUQHH3LQulc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993741; c=relaxed/simple;
	bh=xiuCpgOKEQ5IKnI2LnnuSP+QsFrNvgZ51cctICJUQns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0FFDx9pr8Ho0xCngvS1LrTQVTqbnYnJuH2pLFhFqhpshZh5IPRzUjgWe3zItbysDDL+uFHyypdaXOfQDED9jsNauBFWhuGT67hfVVJ8pbXZlMjbGVql0766BKlXfZD70XbTgw2jC+EXHU7AFHkNlfH2QZstikElmgyEiNtWQiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X0gziq/g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W2PV7A9H; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X0gziq/g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W2PV7A9H"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CB5BD1D0009D;
	Thu,  2 Jul 2026 08:02:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 08:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993737;
	 x=1783080137; bh=UsiPphl45ngQN9KJp22mwX6YYHLRKVC8gVtgsBoD2os=; b=
	X0gziq/gltSvHm+HPZ3jpdc5yvlwmsPIFMVAEC96GFcc121FvbcLaqI54nqOBnGr
	do8g8AI6v8euQc6wwp4BWbYwrym9+FRA7DManoCTyNX8EAWjtAkuD+3l/tW8TVPt
	6ddMp9R7aCvgmmXfphmNaZ22DCVvvRlcvlcBmQeUEypYCDa8FeFfm8tgSu7ky6pC
	bLrBcdnBeNLCs2OFbbAwahc9VeX4+v/5yZrF5q+AB397gIwVWxluYjjNC7f1oytd
	YbZczNrRQ9orf0sl4o1oUktRnGVw71rzZdjXSiUp5ifDlmMV9sCiJg/tcSup+MR2
	KiSbgWyb95x4P1SjU331lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993737; x=
	1783080137; bh=UsiPphl45ngQN9KJp22mwX6YYHLRKVC8gVtgsBoD2os=; b=W
	2PV7A9HE7gReg4MBSrp8mcXkoR+QTYUw0JGnri6b7mA+yvM2OWhA2i2nzq9amYPr
	/yxxpNt15va9e9nZiSrOqCW2WB9LlSaHCgqoREtx8GylKJ31C4IZNwn4rRXbuclM
	xG0cDwladm0rlEBz+8oeq2sOMQGsQqsN7k5vgma7406+8BEQ1ekCEqHVcnKmngHI
	jLMkdIdtssheitmafHcwyqNK/mW2tENdlahStoicoJTuosymkBP65MAX9/+UeVHw
	/mc0n+yJSdn7BkBd7x5OVaBzedDE82StJ4AdlYwBxXU7UdU3BGvSxIa/6otZxDTx
	mgECuoe87Gt7PcJ3b7h5Q==
X-ME-Sender: <xms:SVNGalkexEvmFTKhVe_bmXj69mF8Q4k7KeV96JYVTO24xv_aEQpNCw>
    <xme:SVNGaoTZok_ShL6ce-cWLmcgiulP-xCXmK_mEsnz5Sg8-jpQUXU9xAb_5rBOjQpLc
    5xNuZMSy-kVB5womDkkzIeqTp378BT-7tlIKDqa5aGJZR8J7dttfJM>
X-ME-Received: <xmr:SVNGapA98WlOgGMUNNMDN7F5C-L05pQHUpBSb-wOL8mdrBiethxQ7qkOI55vSRf_BB1WkPXYo3v2m41lseHkC8XAl05wFei3YJxzMTiQI1Z-DQ>
X-ME-Proxy-Cause: dmFkZTGG7LowhUhhUkuNdT+j27xibYErhPFrqFDd3dvB90LTkRVhPR0VUDrwPySMqfFF/G
    4w2SZ5ELpWRvmAxMrm57zOyK+Ln9nCYf8MmcUDynPXs9x1PAvXdEQMiOuYlX+ub2vIGRm/
    XBnbqEIaTrmJsrXBdIETWgATAyaH/Ty03d1aR1I1tLM7HehtaWhSIdSH0p0+GtAPXFCVcq
    DyxIrSifuGrQEC1PWGe9v/SOcRWbNmXq16ITLrMsEZfWB+/fEXHK6MJMqiN5ShNTS3oh8e
    NNvzyvX1BvRk6y6RQKZaUD3YqsgoagjNd2zwU68cBbFYfJdpaK62+C0xRr3owgkZq67wrF
    rHnnq94SqsxE/pzREOckxjNcdijXEhSwBhQjfcxTLEmUMdUhauWNywzmYNbU1QjuYQQgYZ
    94Ab+u1UFYXC6z/91+vfPh4AWmo4zjSDW7t0yVvppCzI74IrKl26Hv1ID0fZj/Y6MN9Xei
    cxTtqMyvKVMyFLLG8cT/4aneYF16DSm+rFBWA2RcuWQ9nZDnEbHOrR+oJXdxwzoZpjxWTO
    fd1E6wG9purj+Xy9AHYz3HQiQ60q1LBd4qTuPMU3bdW7rEes8+T8/wXF3SsDrQ50ppj9sw
    EzgfVabWxHqam7nFqAM1Zm6lwHiYfnU2a9hPBuzImq5O2+c7ihZT+R/Qr1Ug
X-ME-Proxy: <xmx:SVNGavQZkWJNNtOh2tQ0IMPYJbKW2NciEpwGmI1zlLu0QNRG-nIZ4Q>
    <xmx:SVNGanrAakQMCM8ILEU5LIS2EsS6I9WzmzNIry2BZ7l46GimG9o2NA>
    <xmx:SVNGahwRa1H2v4hZnZhV4HK6L7QW6W-88-mE2o42Kg0cDqjYpN3MpQ>
    <xmx:SVNGasJ6mFcX5CHeoX1giQNZ9xsshtMUDwcaUDF2fVUJM_2fqLPVNQ>
    <xmx:SVNGasQQSqQJ7VLceN4lYnYoG1smvQoJKymgGlqJUvuBXIiX4qiNkqnt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:02:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57ceeb33 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:02:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:02:03 +0200
Subject: [PATCH v2 5/6] odb: drop `whence` field from object info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-odb-drop-whence-v2-5-b0af7468ad95@pks.im>
References: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
In-Reply-To: <20260702-b4-pks-odb-drop-whence-v2-0-b0af7468ad95@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

In the preceding commits we have migrated all callers to derive their
information of how a specific object is stored to use the new object
info source instead, and hence the field is now unused. Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 | 1 -
 odb.h                 | 7 -------
 odb/source-inmemory.c | 2 --
 odb/source-loose.c    | 2 --
 packfile.c            | 2 --
 5 files changed, 14 deletions(-)

diff --git a/odb.c b/odb.c
index 34c35c47a5..175a1ee42c 100644
--- a/odb.c
+++ b/odb.c
@@ -691,7 +691,6 @@ static int oid_object_info_convert(struct repository *r,
 			return -1;
 		}
 	}
-	input_oi->whence = new_oi.whence;
 	if (input_oi->source_infop)
 		*input_oi->source_infop = *new_oi.source_infop;
 	return ret;
diff --git a/odb.h b/odb.h
index 659bf8afe1..c251788d50 100644
--- a/odb.h
+++ b/odb.h
@@ -311,13 +311,6 @@ struct object_info {
 	 * or multiple times in the same source.
 	 */
 	struct odb_source_info *source_infop;
-
-	/* Response */
-	enum {
-		OI_CACHED,
-		OI_LOOSE,
-		OI_PACKED,
-	} whence;
 };
 
 /*
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 1d173bfa46..460aec821c 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -54,8 +54,6 @@ static void populate_object_info(struct odb_source_inmemory *source,
 		*oi->mtimep = 0;
 	if (oi->source_infop)
 		oi->source_infop->source = &source->base;
-
-	oi->whence = OI_CACHED;
 }
 
 static int odb_source_inmemory_read_object_info(struct odb_source *source,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index c254957602..54df2e57d3 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -198,8 +198,6 @@ static int read_object_info_from_path(struct odb_source_loose *loose,
 			oidclr(oi->delta_base_oid, loose->base.odb->repo->hash_algo);
 		if (oi->source_infop && !ret)
 			oi->source_infop->source = &loose->base;
-		if (!ret)
-			oi->whence = OI_LOOSE;
 	}
 
 	return ret;
diff --git a/packfile.c b/packfile.c
index ce51d1e5a3..8fa6309a09 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1421,8 +1421,6 @@ int packed_object_info_with_index_pos(struct odb_source_packed *source,
 			oidclr(oi->delta_base_oid, p->repo->hash_algo);
 	}
 
-	oi->whence = OI_PACKED;
-
 	if (oi->source_infop) {
 		if (!source)
 			BUG("cannot request source without an owning source");

-- 
2.55.0.795.g602f6c329a.dirty

