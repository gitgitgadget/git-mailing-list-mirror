Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956E49F10D
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356124; cv=none; b=cfiMUxDG1ZwNsaH655u8sDlmoefJDOgOrshOmkParhJnIsGqo94AIVNYvaAn20FpUBZ1oxjYre8Nn4O45pAC2M6sAwSy0vPcArScmIJT+ly+rnCDhtTH3pvKFJOdqfAzw3q7nysEt2tSFyTXhxFGZAQN3JFv33COdMDxUGOFXwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356124; c=relaxed/simple;
	bh=ptya8iBbCl/fsUdYq5iBi/S4H4SM+6WLr4GVCVXv/rk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LrXAv4srPp2/XwLu4KwqibxsXiyArbbJxCHBfe65JVder2RVw+nhiAV/pWJHwRPIwZ8iFLn2LDVZqKnWBVWq6vSkXXWS80AqYmkFIb3ZmVKS/6C6zo337OqEYJets0hEEKzAbugQgYogo+k64ax/pIriwr2GhFn1SH4TQ7uhgoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WbOf3qk9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Npf6cVJo; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WbOf3qk9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Npf6cVJo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE74D7A00D7;
	Wed,  2 Sep 2026 09:35:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 09:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356119;
	 x=1788442519; bh=t9hsW+tLmhyhYjlZQ3DOL31zmcvFRxYHCyg/d9tUTYA=; b=
	WbOf3qk98Jq5axll5pvww+9WhNdPqoHs/bdK3sVl/Y6CP8nUjuFeWc2z7xpmumQi
	ZdbC3lqspOVqk5hLJDYHkzPaiSzjMV4dtWYmcnQtN0VkujfV4P5yz871HiNzRrRK
	ju3oe1vb4Qg0NFr9lsA7UdsfrP4dOedmzjq3w6U8wYgtiiPKSLL/HDq9RD0fo5vh
	csJWB5kdG5o989eAvy9I0gz2cZMrSUsRgpkB/DID2PCtSZTmhYPJjUykJG/4LUxi
	Ccm0VEiUKej9xV0tZIYUbCOxpbzO+eBXAoXOjGwakEklSIDXU/S/cW6UmUu65Kc4
	usPwT3ofWbeyNiEDGOzKFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356119; x=
	1788442519; bh=t9hsW+tLmhyhYjlZQ3DOL31zmcvFRxYHCyg/d9tUTYA=; b=N
	pf6cVJoYIv3VUELGW0prcQ4o1OW22IlZpvyz0q/csY1v5PoVF6dwZjN0HX8FvoFE
	g5lYvo3Auywcs/q7Y+E4E6NytnwonWmsFf8ImriICGP/FoOrWJzCBdsU3naLgCT3
	+sRwJBdIm3zTr2gCOF4lktyflakDnbmltiSoCZoOwO3qTXUqQ+V04yhwtbDX21R1
	TzsK1JsHU1PNCjZP2pJ7F2zVlwVbEAC4OhTx6dZ+deOA1FkPcLndA74cgJ1DntXc
	y2fScnPY8FtdktH4xxF69udvV1ojkIEFiLnLH371Q/yZB/264bC1teAE7oYrXDYN
	71kNPs0rdWsX+fkf2eGcQ==
X-ME-Sender: <xms:FyaYanxBJ41k-2Bx-QPAHV4YbEDBVtK8BqQuBhfUILVg5EVMzo51XA>
    <xme:FyaYalTpbx2um99Cdy_Ydd-X0r0-BddWHV8F7bazsMeYiBPIcVE5_U4fOPXK7cl_b
    bXGQ4mWCxinupK2ZjyYPRQVl6JE07xx14SYhj3Yq_EdKkWvhM7L>
X-ME-Received: <xmr:FyaYau_GADq5fVkkmOV_m-MJzyAtMyJcPEIQRUuVJckT4FXuCfOPDP1uTFJ55KLymm5pdrs>
X-ME-Proxy-Cause: dmFkZTGarp81zQ7N+tVloiKE1UqEKo0TVx0DnqHMpG6tMyQeDzUmcFcqTqyBBzbj/dcO5i
    LbwQfQxzSJ/F7OuO0073mk61IQ/Y8QnqdvT0Cr0J/Ktw/2nNIdZkmNKQbG5Lv0TtSadPXV
    YJt6BUBe6YFSCSD1qpSFa/W35EhkQFVZ98mE1SmX6MccP/ThCItsxEprn1+jCE0GLkhjxp
    eKRtFU/89dfPD68WyuyQKALyLXoqw1wCy6OPvHcwWR8+2ZpQeL7r9dqYEF6p6YoRGIlX8w
    o8emwGeKpvI/scQeTi2FSXkIEvCq8KSzb2gwGhf9Hz3p6vR0ZHYB0fTSrgYYu9P2x0jiJN
    kUnYfjAUAv8KLSWLbqk0Eic8EKgxFcRydzx1pi2SX5ZF3NuAsgLvr0N7lZCbmPERtF4Cb4
    F8SdUkmzEvNdASPn81VXZ3PmgCOZ7rWWmSew/gr+eb6ZMQMUmeB+ZXh8VhzWx5e25CP+LH
    Ue7FDlBTkYd4jKxwgSpQIVTpOQglvAn5/BSNnJH+Fi8ALrOCcIZQFJm3d7QYWJyT+WQJJO
    DRb9VEJM9LOKLtr04YOidAIkg1ERqnr9PvtKq7tr1v5TQfB5h7TNfWHmjnICM+ZjE1TX56
    MDi6OBMeE56aCrbPiQxJbrlmkYYIT0mXmzkmsq++9XyYLAJGVT4cY8QMvlXA
X-ME-Proxy: <xmx:FyaYasq2PTPFvt2NKz5obqC924tCavwis76gK5NlXmrj1WgC9yFosA>
    <xmx:FyaYarnNftvEvkIDmF75EpCl-5z2S9TEsuGZ0crRhL6Y_kxBC4aGdw>
    <xmx:FyaYajK59RPxm81EoI66_RjdhxFjFxNoXpRAFTuoOGQzaXwXMw9Pnw>
    <xmx:FyaYagx5rzWSpdyPiCmaYUCevrEyesd_DDwNLRcZlGT_743Jw3el6w>
    <xmx:FyaYarK9BlBWlIuwNE2eu8SbETaXFWHSjY8nCJnj7CO7P0xajERzxkMx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71807745 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:34:56 +0200
Subject: [PATCH v2 08/13] tmp-objdir: drop unused function to register
 alternate
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-8-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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

