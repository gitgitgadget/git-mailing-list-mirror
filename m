Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3E16F27F
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683702; cv=none; b=hPk1qr3RkrT+1MsteyKcgBooZaa8hrZwbN+FbOFyvZIffJz0G1DA7nMA8eMOsOJgEDiraxHbcQ2Qntn3+wkZsASutuT7IXvuJUOkUciK7ImK/LbZh3cJk7ptGZJh/BBk8j4Eh6yjzL9FvKTtWZGBAur89jsPmIE8tqM8Ug3Psj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683702; c=relaxed/simple;
	bh=UJkh+iSggOY7GaOllUTN+BdgPLixnaOebrEfdp2SMpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xpr8dRlEaRbhWa+qcmmqYlgmDwJtDGWUbaCjFiNZFtuSk4mNz0n2a86qw3PuPXTnrpxEPwVu4kh+jA55UvNzZocWur2gBibqmjy+QewaYmuUPbJqZwVq8gQLyZzy0OSemMlQZ97nyxd7dzOF4rNwz7RtMTzlabjleHuCPecjtgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f9b9qyMi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ThHQUCV5; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f9b9qyMi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ThHQUCV5"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CB9913802F6;
	Mon, 30 Sep 2024 04:08:20 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 30 Sep 2024 04:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683700; x=1727770100; bh=kCmK/NwXBv
	J6f5BYJq1tmG9XDCwjZWbAOgOje4rrLqE=; b=f9b9qyMilquIX1WIi09OcyRlt7
	vBhcNCC73XwKdBLcgpFWoj85vZIw1dcJK3Ho1KDifzV0J5tji/XbxaqnZcIlp7Kj
	E6roSEQnN/LEqlOoRLZto621gaquy2zi9f+me9o5reJKUGaq4fpOelkyjwmkm+9h
	CbC00Svu3QPj7S+F5bxjSDzO6gGv93s7L3ccOLjC0h9vEz/dFYqdzEkA9FbXddIF
	8lzcS6r9iWWVnO4GamWzQ6ypVfJl9vH17ne0FFJldhHOpwZhhyDjM4Bv+Bppmycs
	aHoo7++j+Yy5zGh0uStxbhb6T4Y7pX2kbezsxucDdwdRhXVM741G8OFAGkgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683700; x=1727770100; bh=kCmK/NwXBvJ6f5BYJq1tmG9XDCwj
	ZWbAOgOje4rrLqE=; b=ThHQUCV53wqtC7vx5NQLIDfd5oAX26JlXRe31YgZXeiQ
	0245HoIDnYWVru5I0QWDnmEhmnMLWxpzXUqraK6/8nKavyCYgMmqXNQw8YN+KQsm
	jo/2D8BLTLI1o86NNkxL7IYjI+tMWaA+PcNX7WxPOqWm2fVKyjXcvCKvUZOjXTEM
	5uzhaJApDDwk2T/X39iebaFE6EvDLM/0MZncqzwNH3Xa9fHa30UhvkMiScI2WMo0
	o36BzKnpqcZ5afs6SFlzIzaJxUmgbjWGJON1nXw2yCQXaklngTcen8PnWFtfdTa0
	ayJAeFgaE5f883HQbEYc6vclYnIV6hsMU5GsKfgxiQ==
X-ME-Sender: <xms:dFz6ZmOYEcAwmqYcz53SlQcRx1L--4JJPCxUp3fm0AHhq283ChNnUw>
    <xme:dFz6Zk_woDN2QM6vcbI0YZXSnWPCVggNOKL8tOY7beh2YxltpW5KKec5z7agFvHwU
    vDkeL_J9vkUEWnl1Q>
X-ME-Received: <xmr:dFz6ZtSjoZVUHdvSMb8Zxg-TQ0VwbQE594fbfBSPv-0341hRgs_AMQopVcLaIIpg1DoVBbnJckFVxIwQZjuIAgeS1u_nToPBysm3m80s4TFP5ZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhh
    ohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehlrdhsrd
    hrseifvggsrdguvg
X-ME-Proxy: <xmx:dFz6ZmulVhN6wxcxjoYz2SqVXOE7Psf0exNvg9WDt9KQ8uY61nfYOw>
    <xmx:dFz6ZudUaplfTH397-lChLrYidpAtLk7V0dUYeayj7ny4GV6bS5koQ>
    <xmx:dFz6Zq1MaPLCR9Y8I_6NsbRueU2dW0NjhaZ8VJBTO9UbO94OiKDXfQ>
    <xmx:dFz6Zi-lZROgKRdLYQyZn1TLKlzW7nDO_dxtC_jS7s4x-dLzQUs0zQ>
    <xmx:dFz6Zt4KbwfgzKgXvVE6yTdFf-GMb1LzX0_i8EuUJzvo7JyYGDrHEKga>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de4dd435 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:07:33 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 03/22] reftable: introduce `reftable_strdup()`
Message-ID: <21fa9b15d96809728455943877c1b32781364041.1727680272.git.ps@pks.im>
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

The reftable library provides the ability to swap out allocators. There
is a gap here though, because we continue to use `xstrdup()` even in the
case where all the other allocators have been swapped out.

Introduce `reftable_strdup()` that uses `reftable_malloc()` to do the
allocation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 10 ++++++++++
 reftable/basics.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/reftable/basics.c b/reftable/basics.c
index cf072935c8..4adc98cf5d 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -43,6 +43,16 @@ void *reftable_calloc(size_t nelem, size_t elsize)
 	return p;
 }
 
+char *reftable_strdup(const char *str)
+{
+	size_t len = strlen(str);
+	char *result = reftable_malloc(len + 1);
+	if (!result)
+		return NULL;
+	memcpy(result, str, len + 1);
+	return result;
+}
+
 void reftable_set_alloc(void *(*malloc)(size_t),
 			void *(*realloc)(void *, size_t), void (*free)(void *))
 {
diff --git a/reftable/basics.h b/reftable/basics.h
index 4e2e76014a..f107e14860 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -54,6 +54,7 @@ void *reftable_malloc(size_t sz);
 void *reftable_realloc(void *p, size_t sz);
 void reftable_free(void *p);
 void *reftable_calloc(size_t nelem, size_t elsize);
+char *reftable_strdup(const char *str);
 
 #define REFTABLE_ALLOC_ARRAY(x, alloc) (x) = reftable_malloc(st_mult(sizeof(*(x)), (alloc)))
 #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
-- 
2.46.2.852.g229c0bf0e5.dirty

