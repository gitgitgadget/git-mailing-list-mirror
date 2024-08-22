Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71717CA1F
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318257; cv=none; b=dSgcBFlIqA9Bt3MmQ5P/DRO2lMGjEWaDfMj9dIoAkorf5R5658k1oJL0bOgrMmBOWnGN3LhMrhQeh/B8l/kxWhd3gBCGdpaUM//MDwjspfP4OwLWAfu53jcfLREsU2giIdAMZXUMCYnCLAXfcAFv/L1R9krnY2Qylr/jNpyP1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318257; c=relaxed/simple;
	bh=IBaND85xDInviqKYQgaqKTVmM+3mOwvES62yg0Af6js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4tiGyZQrR5TfYtx1PCQ+a4KGs/6LM3O0fAb/nykdcF5A33gsWNXiD/LCPHOvYAD4mePLYaTicewZ9vQY+X6AwMYMPyiCc3LX0QeP1bB9prDISaxdlWErWS9TKL6F0+XA9ZUjrj42OZ47xf/t0A/wIGn/aqXHG0Zy+2BvHPKdSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=klmtR3Q0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YJn6FloK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="klmtR3Q0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YJn6FloK"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 60BDA1390067;
	Thu, 22 Aug 2024 05:17:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 22 Aug 2024 05:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318255; x=1724404655; bh=a9qZNEVrVl
	ZXZ7pzxUKhGs9dQNL6o6tYDl5LR+6ljVI=; b=klmtR3Q0smzB2c4YjzD+oDeYGz
	LPhunwLwdu5MwbFIflSBIlnWbejCtNz5dfyCtpjQoikOcF0WEsbsm8P+JJ7TEfLG
	aYDEkmNcNlKN/j+Ex9loNfyi7YouPfngsRSNFbmWxo7wVuXjv0tq1guxL1Kp087i
	djrpy1baEfGB4Acgl4DO+48BkZce86CSTE3lQedQx5wkVNtKxnCEOH/opZ/cP5Eq
	o/Jl18/sDbC/PIbdoVgqfQu7JUptNJ6DyaJUvl1tCBHq+eP1q4tdJXJniXjPb3F2
	n2A513aqx+m5ZuVtJIZv91Gpau4Er3pewmRY97TvvIJbPVwPKRPeCbNorEYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318255; x=1724404655; bh=a9qZNEVrVlZXZ7pzxUKhGs9dQNL6
	o6tYDl5LR+6ljVI=; b=YJn6FloK75Np5UGcmCe5DgTk0tDxzMyiNT9bzDZZEFxu
	QSbP4pxtHiaXYDvDGhn/ynyLlvnJF9TIN/twlheKUND3MYQVrmj8UcgWCuNC1+An
	GCPgV5lhLqWES+xUd4yePDSLfpfP9Y56VXKMaoFwiJSOtAwFUHSquo/1E/OXJrVw
	ZgnyIn9VfSBdSXShU0RSQ8xXIqlDfKW/qj63Ge6LPnaThjyGSNDADewHrk5RqDJ8
	Z3dJ4Og8LrCr3D3BZAR6mHgTLl6+VgMD+tqVDngHXeR2h+wLgOYOLrjSKLFDuzQv
	dK/Dr3VPmGwGydsqHIp7jj/hJby5gyMYyr/WEyWpTA==
X-ME-Sender: <xms:LwLHZhX_X-VPyXgn1sGxbOr04_Gw0tWwRqfTf2jsOm4BU53pfqPaPQ>
    <xme:LwLHZhmWXo52o4U1BodxIkIZatWmiayOwrlp2417g7GkwY5DbKCt-7koTr5Q4dTT0
    emPpgpSAeO7NROMMA>
X-ME-Received: <xmr:LwLHZta2jJ2yeA6osOOOP9Sx-mJHE13q0OuyE9sCMZeneRnYjuB0ceWNaJIYhpO7rPG9lBwpzhldqEWOL9xhPvmP_UG6gBSt1Rv9QfCaVSqQ2rQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:LwLHZkWJWeejpcW03sqRsC97bzbwoPBn7k4hTMsA3yn0SnTZkaHE4A>
    <xmx:LwLHZrk0U5DFQ1Lo-E5VOgFO0pCCtlUklwc_B0VGcUqjvyLpV4wWeQ>
    <xmx:LwLHZhdFPr41fpK66THtJiXqNeZd5RUBrI-Z0qVrIIcHoB-PnvzhgA>
    <xmx:LwLHZlGmZwg8cD8GgG2ZhwjALIF6ozq1mccnSGWbvXszPvodyifL_g>
    <xmx:LwLHZgzAAIsy77K0KFi2rNHQi5Hl3V5EY8i5dhZxILlFi_OUSJKZZXPY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id db4f5e96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:00 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/20] midx-write: fix leaking hashfile on error cases
Message-ID: <693c93ddbf761202bff2d7a3213b7afd80049174.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

When writing the MIDX file we first create the `struct hashfile` used to
write the trailer hash, and then afterwards we verify whether we can
actually write the MIDX in the first place. When we decide that we
can't, this leads to a memory leak because we never free the hash file
contents.

We could fix this by freeing the hashfile on the exit path. There is a
better option though: we can simply move the checks for the error
condition earlier. As there is no early exit between creating the
hashfile and finalizing it anymore this is sufficient to fix the memory
leak.

While at it, also move around the block checking for `ctx.entries_nr`.
This change is not required to fix the memory leak, but it feels natural
to move together all massaging of parameters before we go with them and
execute the actual logic.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx-write.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index e3fa33203fa..07d98d494aa 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1308,6 +1308,18 @@ static int write_midx_internal(const char *object_dir,
 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
 					(pack_name_concat_len % MIDX_CHUNK_ALIGNMENT);
 
+	if (ctx.nr - dropped_packs == 0) {
+		error(_("no pack files to index."));
+		result = 1;
+		goto cleanup;
+	}
+
+	if (!ctx.entries_nr) {
+		if (flags & MIDX_WRITE_BITMAP)
+			warning(_("refusing to write multi-pack .bitmap without any objects"));
+		flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
+	}
+
 	if (ctx.incremental) {
 		struct strbuf lock_name = STRBUF_INIT;
 
@@ -1333,18 +1345,6 @@ static int write_midx_internal(const char *object_dir,
 		f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
 	}
 
-	if (ctx.nr - dropped_packs == 0) {
-		error(_("no pack files to index."));
-		result = 1;
-		goto cleanup;
-	}
-
-	if (!ctx.entries_nr) {
-		if (flags & MIDX_WRITE_BITMAP)
-			warning(_("refusing to write multi-pack .bitmap without any objects"));
-		flags &= ~(MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP);
-	}
-
 	cf = init_chunkfile(f);
 
 	add_chunk(cf, MIDX_CHUNKID_PACKNAMES, pack_name_concat_len,
-- 
2.46.0.164.g477ce5ccd6.dirty

