Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73616F27F
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683708; cv=none; b=KdTvy2oxKHm1ZpXa5+JUSfUN8nuQ9rBM+WlCSHL+nZrJhnlyPIGX4+ZF7sZht0cfy54FshECk2Tvdd0/Mq7Cvx0hKzgZwdG/LRKBudWoxjL18vVXi4pT1YjINukUvXx/0LDbYpQ2iophvKZEXq5OxVcwvSjEHxFWDXK0ZJDJSvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683708; c=relaxed/simple;
	bh=oHr0odYXKBjoliTS60Xmd1A5MusouU++y5vbbABHgGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBdSSJ4fE52VrJPm6DnB0ptlprW1fQYM+2/CjUItYGgrQLXq8kQDSc6d0+AeOywMVH1awQjiG4DufcEx1TMAmSRUo1zIdzbsn1Mrjl4TxSB4PZHGbu4hX0KjTZM1QoPHylIheuULzTR/wBAqRk/YzcRQpZliC6NHzquzwUaW4RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WPRhUQ5V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y3EqbAdS; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WPRhUQ5V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y3EqbAdS"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7571813801C4;
	Mon, 30 Sep 2024 04:08:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 30 Sep 2024 04:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683705; x=1727770105; bh=BdOQcDNqK9
	txB7ZVLhTQxf8avDDJ9sW5XQOwe4uSEP0=; b=WPRhUQ5Vd8a306e0emVd1LHq/o
	4ACgbg8jXEkIttzNhT/w8/YTcfF1VTv2d3CiSmfpE8n/yR4eRTwaFmVzersXCZPa
	UnUM0dk1OrY/1GcKxtkZHo6dMGBpFpgDFe87s9nwMmqgPmhuF5pQP5ZhzjpI1C98
	yM0kvr0jt6RbdP3DLmsw3CkU+eatYkfHEdO472p9xUhympTVR5OTWq1bPbaLaRz/
	xqyFbgmLv/vKuKHf/nYZg19dl0UOa+NO+e6z9o4vPLeTp1NopySMRccAnNldqQMJ
	3g1lPvK7WKFHGK/R0s2we/AWC5IgpOfkosh2jxx/Plfyxu+U/N9bmR949tnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683705; x=1727770105; bh=BdOQcDNqK9txB7ZVLhTQxf8avDDJ
	9sW5XQOwe4uSEP0=; b=Y3EqbAdSyn6dUEYQoUNT+Q7ZBlOHFI1qfUxU0aXub2wv
	zJly5TR1MjCvsoqBk92VKg/h46lO1GCmDXBfKLGo9HSQnRxACMUlS1Sz92Vlv0HS
	fHj+AO7h3Twy10l+sYU7CEB63wBrcI7rpu2K6LOLMQPfM/atWJXAYzToqWqo3AIp
	AjKN0vF6jg7tN+e0JjFlatJ4GKsWQ/hoJamhDNqsCYp7YB81tWm2ejCXHEs6ozmF
	aSjgnjTSDSCFY6DAssJFef8kINxsF0JSZp22a2Pppm/L3uZT4z3bA5sym+5H8uWP
	fUBUW16kd3Or7Y0iBeNefVpq15vLJ8GE2Zc/NrN3BQ==
X-ME-Sender: <xms:eVz6ZjE0EkpGVk9YlKhpaYFWClR6eA1npR-3yDafNs-2DP9g1XtpXA>
    <xme:eVz6ZgVbxsfrdBS5X39vTXNiecw7sd5fWDZ9V6oER5o83O44mSv5UQfunmRp1qSq3
    8IXaFgMh_wToFpqpA>
X-ME-Received: <xmr:eVz6ZlKXN3to6VKWz07wuW2-h0fQMdq54a-QN5o9LpVGJjArLIudQbEMiT7mRJXOjNclqSD29kSP4_RtxYTdPLjmtIQV4ndEsgfemBzD6DLUXlM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffh
    ueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonh
    drtghomh
X-ME-Proxy: <xmx:eVz6ZhGGGkmAQ02bm6RZBnG-VOWPV1gyMBdqv-kxnaJf8urKndaw_g>
    <xmx:eVz6ZpUfroaL3TnYJBaQDV1bCMgXWiExmiiw6J1bC3RcwItTXXHfig>
    <xmx:eVz6ZsPsxZxqGnCZmeuztMa1uQwkaHu9l1Gw38sVomB3oy2d4TbA3Q>
    <xmx:eVz6Zo2SXmPA9CWedP3QdYaFxkNHDBA1kRTOHrm5L3Z1T9XmV9eNYA>
    <xmx:eVz6ZvwFiaLQXZB0xzFnB-LWJYq7E19cb2zXIRIDqmxEjE5jLLpwzj1Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de9ac0f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:07:38 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 04/22] reftable/basics: handle allocation failures in
 `reftable_calloc()`
Message-ID: <f6ad92ffd01c442dacd3ac6aa448891028636636.1727680272.git.ps@pks.im>
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

Handle allocation failures in `reftable_calloc()`.

While at it, remove our use of `st_mult()` that would cause us to die on
an overflow. From the caller's point of view there is not much of a
difference between arguments that are too large to be multiplied and a
request that is too big to handle by the allocator: in both cases the
allocation cannot be fulfilled. And in neither of these cases do we want
the reftable library to die.

While we could use `unsigned_mult_overflows()` to handle the overflow
gracefully, we instead open-code it to further our goal of converting
the reftable codebase to become a standalone library that can be reused
by external projects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 4adc98cf5d..3350bbffa2 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -37,9 +37,16 @@ void reftable_free(void *p)
 
 void *reftable_calloc(size_t nelem, size_t elsize)
 {
-	size_t sz = st_mult(nelem, elsize);
-	void *p = reftable_malloc(sz);
-	memset(p, 0, sz);
+	void *p;
+
+	if (nelem && elsize > SIZE_MAX / nelem)
+		return NULL;
+
+	p = reftable_malloc(nelem * elsize);
+	if (!p)
+		return NULL;
+
+	memset(p, 0, nelem * elsize);
 	return p;
 }
 
-- 
2.46.2.852.g229c0bf0e5.dirty

