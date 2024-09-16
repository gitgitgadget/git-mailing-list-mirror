Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FFE158A18
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489745; cv=none; b=BJg0v5GCn1HT5ZkSyJuRtB/0po5XcLecy0RVKwJBUxRyfeoqkLWCkEmqUGFSuAQwcaDC2ggIc7D8o1I3xQ8TNo9mYNTM750WNMQgroMrlSmn0IiyU33PNSN5pxpFlBr4FDWfs/o5acVjc+8Ge88VWEUllYiUZ9SCgMsRDm3/8Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489745; c=relaxed/simple;
	bh=3LKaxcf6WxuY9i4s9f+9/WoKLCS+T80gtVqvBJ14Y4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KE8imWmKfh3cr6somaSnaFobbPU9BQijgvB1VsAUhM7fuwsgkmojgvgM1VrHVy66vVvBn+H1ihONWknfo+2eTIhj1A8ULT6VmrFuOhOuA4n3OFlfH+UckVevU36ZaWKEg/dsNlv/fE0CHcuQNldrNcTtCVdLzLSlGqKRVOQDI9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H+MZIT6O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lDN/m5O3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H+MZIT6O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lDN/m5O3"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D36AB1140240;
	Mon, 16 Sep 2024 08:29:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 08:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489742; x=1726576142; bh=mL3oWyEnHv
	HEiP7dArYME5lY7IOUJiRU/6ClTWyk10U=; b=H+MZIT6O7XTKBgmo2vFeoqtFo5
	6keVbmVFSLa2ZW4HeksPBqEIXVn8i0OV8toxPsUymVRo4Z6ItAD2WHqhZMV+XAWW
	2CHOzpUMrkS/9gOjK60PRZrYSls9NHx6Xwl33xXlB7Qp/KD06nlBlni8tMjeLOLK
	l6AD6Lf55xJM3OAzsTSvQauqo+fYaP7Fv5ipYUAs4mlfgyJheoax4gfAekKWE6nE
	f4+K8cqwSipN19sriWp8FOFrCDUnncI4/YvAtrzTNnM+C3ifzPi2RSNdxROoTkkZ
	C8z27wGGhZj5lxyduoRA+EaDZg8agMm6gf1XmIvTl8tr6KAm9Du7VpvU+7OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489742; x=1726576142; bh=mL3oWyEnHvHEiP7dArYME5lY7IOU
	JiRU/6ClTWyk10U=; b=lDN/m5O3+j8B+MXPT494l01/2LEFhlzYbB7X4G58Ijrh
	8X8lM4pmsVp7yIaunJylhr1PZs9nsEGNW9AqJPsoQBsrPcrxGOwmuYlDOsY+gWC+
	sKqjegf+wqDAGoglk/Ko5h53GkaonCvBfzL+6W99xmqYvS3a0Bgtc6faEVfhTbb5
	Tc6jOlztp/K4twyTVQ+BJTdTCzGS6IE7Z+LUMzmL2Fa+TvOWUYHiIsTwuKTXnF6F
	lHMioGobrxyZqXBaXm1A6KlY4+cvFNKepFv4jYhX2uiA2sbf7SdBPzXd82ujstFu
	Cd9LV1kWmgHTdCm12hJ+6xavY7Ya1NpKOxiy74vnZg==
X-ME-Sender: <xms:jiToZuadAq9whoB3s1fjgdVUv8pJ-yq5GDgqNkPtvgvGpebSU06WYQ>
    <xme:jiToZhb79ymVBzlXzXMdLRU1p3omHyKM1X-EvIq3gP0a_4OUGrZ6JS_fW9UnZWQWW
    Qh1BOo52hgwn48wBQ>
X-ME-Received: <xmr:jiToZo8E1C0bsGM1CgOCMcCZQNXw2cTuPY7Dgkxey6glLuNedlTts-l3BcLjXE-Qj3g47swkeOs2NmnMv2ka2KC3YNd9yKrz7L9agt0Ym61eIZh_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jiToZgrXFXpA8tm2OFxPHdDb0lKMnOBlYj_hwkSsw0Tr7kI1hDBeFA>
    <xmx:jiToZppP-79PMtTTx396TWuIdFHCanug9bv8v8OOr8z3qthAcVGmsg>
    <xmx:jiToZuTcY_abJigTOThy-5y9WoixA0Qc_aaWj72MUPg1hsj9Fju_hQ>
    <xmx:jiToZpp2x214-Q85adnOmodhEFjIGGM9oVoQ5Sz1Rk8cClOhCasI0w>
    <xmx:jiToZg324rkY1kN0cRgguWzNFU-6s40xShqKP94PIUoAxaulecyeBaSY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:29:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 41e5bb6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:44 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:29:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 15/22] reftable/stack: handle allocation failures in
 `stack_compact_range()`
Message-ID: <3393a59ce4260cf2c9d948f6c37e101954e5f97e.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Handle allocation failures in `stack_compact_range()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1b77c9d0146..2e6dd513d72 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1131,6 +1131,11 @@ static int stack_compact_range(struct reftable_stack *st,
 	 * from the point of view of the newer process.
 	 */
 	REFTABLE_CALLOC_ARRAY(table_locks, last - first + 1);
+	if (!table_locks) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	for (i = last + 1; i > first; i--) {
 		stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
 
@@ -1312,8 +1317,18 @@ static int stack_compact_range(struct reftable_stack *st,
 		 * thus have to allocate `readers_len + 1` many entries.
 		 */
 		REFTABLE_CALLOC_ARRAY(names, st->merged->readers_len + 1);
-		for (size_t i = 0; i < st->merged->readers_len; i++)
-			names[i] = xstrdup(st->readers[i]->name);
+		if (!names) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto done;
+		}
+
+		for (size_t i = 0; i < st->merged->readers_len; i++) {
+			names[i] = reftable_strdup(st->readers[i]->name);
+			if (!names[i]) {
+				err = REFTABLE_OUT_OF_MEMORY_ERROR;
+				goto done;
+			}
+		}
 		first_to_replace = first;
 		last_to_replace = last;
 	}
-- 
2.46.0.551.gc5ee8f2d1c.dirty

