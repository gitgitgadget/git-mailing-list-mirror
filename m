Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5EB1822F8
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683738; cv=none; b=ebB7JxJ3o04OHc4bnDNNqkrZ7VVTsZkFDDMv1ca/ERS/cPu01tFo5yJrd8Zm+Jxg+BEBAfS4uZM8tgvdy6NEy4fGnnLcEgqmmNr0JbK0dGN+TXNIAI+vWDjE2vfaxq+qUwuMseTJeq1xi+Kprs5Tx7MXYeUogEki8fj3d7S79SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683738; c=relaxed/simple;
	bh=ZEnp5iU+YjARyWN+efhLf6Pm/VO/ja8GdfdydPETjoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulP+AF56xIgiSwqkRT2nq/cXl87YUs1wQd4by5KmHui1MUNWu2/i9Y3ytMkNYr1Hs8JVYOUDmhp8vyrywRnBodO3AT/wHliv/uRnC8hsSo7vOskBXAqXQyuc+7w3oSPNjyTsHDUjrga1GZkb3kl1vPz+B9ovSG5U8UDjeS3qZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WKU4TSUM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dyCyMmRm; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WKU4TSUM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dyCyMmRm"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B82B21140128;
	Mon, 30 Sep 2024 04:08:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 30 Sep 2024 04:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683736; x=1727770136; bh=wWLDmqEq5W
	UbBPI2Eulp8Ap4qzmx2AEGBUkNUVCgsbc=; b=WKU4TSUMmLeimZd+n64IELk6dW
	Ut9No76N4hzlfK88CuKM+GwDLFExlty+7RuWe3dHF2y3vxmxXIx63tHNX684X3AP
	Uv3ygv5orn+La2xP8YfsVPScO7LrypUgALv1YHblTSmCDIA2FJb8jvxnPbHsFDd/
	yeytAwOGoY8N0YARe0usVc3QyXyXXgh7vW2mOakU08uOymMEn2coE9AmR9iWQUIh
	0CJbqQ8KWnuFWCJSBQvk1ZsQonbkUUW5L6lkyLMF6oDrQypWEkuXq5/HjxqYgU3r
	36OQ/GnOHxfqh8KjTWuZv1Q5lmMBHB/35pLwRQJDT4fMICNCsEwnh1FQvVbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683736; x=1727770136; bh=wWLDmqEq5WUbBPI2Eulp8Ap4qzmx
	2AEGBUkNUVCgsbc=; b=dyCyMmRmbh8MTQUsdqs9zzilb313PvOeiQpf8HxkaczP
	t/xIOWcQ64zl+flLipjL1Vi/wmZuR91KlfKGa+tR96hIxqzaDgeujPKSTltxqKZZ
	2wUHO1G5cEr2KxxskFfXV6LJ0cY6MSK5lCN4Fz4PgonZhQBV01dmPDRIvLFvVin3
	6L0KMX+EFaGOlAhlbyc33uK5RYnWEIjYQJFX9mzg5SRJ+oNVhjnPw8+RtlPJfKhA
	Zpdpnv5sLS3hwPIN0mVZfK/r9JXA5hhPfxmiNoFmEx7Gs2L8DEEQeCZEoMEcDztL
	QEN2v3zG1PGgw+ol55d0LdKAYX1IdukBNqqVlG5nvQ==
X-ME-Sender: <xms:mFz6ZgrovoLfXo6pQUlUrTtK51HpvsL01XyDtreUorH8b0MyYlIz-g>
    <xme:mFz6Zmrk7wwBkALFN7KO9eUIBWs3xpPpSKcwoVzbUijxJknu5dOCr947Z3tLqVBG0
    MsricFMCnpUib8TGQ>
X-ME-Received: <xmr:mFz6ZlPVc35twMzxBtAdjFbxPBOnkFGndy_QGXqG28SKM75qhNMOc9sGkNTmyIxsZQhO94NXroF9heV6AD1A4Hfiyv0hlKQa70qJMyCD3sRtt8Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvthhh
    ohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehlrdhsrd
    hrseifvggsrdguvg
X-ME-Proxy: <xmx:mFz6Zn7SYdBVKLuD9DP3rsc_Xl6WKcirY_5xr_4tVjLMeABTog2RhA>
    <xmx:mFz6Zv6XLyk6nbg-HSnIk2DBwpbo9xzboc7327f651spTAlUtMx6zg>
    <xmx:mFz6ZniH4C7KYWfShMKh6CtWoTOUw52uz0bp2SN8fSc8EIR5hCz2pA>
    <xmx:mFz6Zp4PjRSmebCmLQRVK-NKHkrTeVcLPnuSITnJVbpuX0OLxcfRHw>
    <xmx:mFz6Zi20qfsVBQ4p4WPQBRqpIRWMRoJol9o-bovSetesUTdUVrVcv-G9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 67d723d5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:08:10 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 15/22] reftable/stack: handle allocation failures in
 `stack_compact_range()`
Message-ID: <92ad4fc9346aaff0f6d15a6f5556d150fd5c8f1d.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

Handle allocation failures in `stack_compact_range()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1b77c9d014..2e6dd513d7 100644
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
2.46.2.852.g229c0bf0e5.dirty

