Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B671386A7
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656915; cv=none; b=CX6YbjIDSXqRc68lNAqQEDau6hCzKvUM+ab75dSlTPKe3xVTrfacHu5xndgdo+iS9CqrQZiBFNBIivAuJGslUfUuADnDWXqDaGRqDejbAqgrMn3Tpt0xT7J9d+d5ZGNIP+jHdAmlzblDGlqOs/Uysexn2fXlbBb1FuY6olJVGIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656915; c=relaxed/simple;
	bh=n35D90uBMRU5CGQTrYIA7qfouVtUTgvV9suGhT7zbcs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOl4a5Ju2HyNGYScrMCp8OqEQkCQYuwGjvxk3T/seifTGlaOdbHD63dWuR669RNfrIjUEtCMFWo0fo5fl1PTSxkEZoTIzSMB9gH4hysJVhnkvp4V2Qv21gz6VXLOxZWP36wyca69P1pfwQtgdhBhlTcywS+8UqIFsgP/7/I0eTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mkbmH5Gu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OO6A+hoh; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mkbmH5Gu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OO6A+hoh"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 05DFD138CC3D
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 26 Aug 2024 03:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724656913; x=1724743313; bh=842R9ODo2w
	1O90geA0iJoTC+cL+iLWYRRq9J8zN97nw=; b=mkbmH5GufCy6Tk3pcoypRiwUDm
	spuzAtby9OAD7GijSeO+kotv3YMZS2wzUSquKl4JGbQ00bH2Iq9iAQUcUZrxwwPw
	9y6MYFHHOSPRMGPnN4N1npdEWPtDmLTS+YtD+KyqmAXRmiCOAa0w5XVzvBds5pom
	bhH8ND2Vc3rOsp6zYW0gbn9RehipGAuPSKRpdTeApnilLo54GcOmRnUGXfVwRhYi
	qRpl5WqZ+61BpceLcoODJsmIy+NpVoHvO6QQavHaSLd/bYGZpN8mJ7jinc2cAXYK
	Gvl9TZcRSe72G84iFyQYGQ4jEpB1FJYc9YMoJigw/bKNghZYJToL97N8QkLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724656913; x=1724743313; bh=842R9ODo2w1O90geA0iJoTC+cL+i
	LWYRRq9J8zN97nw=; b=OO6A+hoh5fw9LRMLpPrBKdPa8ycZ32+prpS2/nZwEkn7
	UgjvMxWfGRY7G/Db36Hmj43UNCL6mqCSxyDIq+cnync0XWvgBf47NOqzaHYY0AAI
	KhxO9hgTBUce+EcBNlOT/wU+s/Jhyy0CcsKHfxpxpKvCnEdZGwWdgXoymnXmoKdS
	GqNR/ijoM7pQH+bH7bqlT58KavZCpb9Mx2B1pOTVhzpVLrJTMcCk2Jpqy9vWoPkA
	yDY7UejM4qL42doDSi1Y/sWQSq4d1ZwapCTI8XXHI0uUTlUAYj67TuCcLu8LSvST
	6G6gYeXkTwOZ8ext2tCINTj/ut343XNBWz8Mgn/kbw==
X-ME-Sender: <xms:EC3MZt8FR5BmM-SQF6wmz98e76UOthOvddGiNY-VObNXszcz-06qHA>
    <xme:EC3MZhv2DVGooChwZrKf0RVj3QslGFV8TRVS8yu2hI7NpuxUEkfAlpScX6jGkcLqt
    14ocNV1tb_x2xiUVw>
X-ME-Received: <xmr:EC3MZrBjUlAoCxsFi7cfu4PSII6yvLoIspSURiSAZMKdfuc46JfRHwGJ8V2arS4wbJTDTd5exJM5BzONpIb0WWEx-VYYf0Dgds4Sj-z5TLIhiVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvjedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:EC3MZhf-xwPhVi1darm57WrBWfCJOLlJpRjhwFeCkc-SUb0Lfjyudw>
    <xmx:EC3MZiOe57XhplJnApygESwPi2FijFzJ9vEibiRVGx-E1v3BxZc0qQ>
    <xmx:EC3MZjlj3C6mkmw90eZabh0DECUPcwa0q4wnWgZgRU8vjDCTCbMPkw>
    <xmx:EC3MZssGJU7foVmCOIVFV39K5ZWBhpQ1b57vIb1RZ280OSLbPKXHgg>
    <xmx:EC3MZk0VQtF9kmjZMJ2IPa9bd6zOTaC6hGmIKOfjmiAeUJn6RVzGAXbe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 26 Aug 2024 03:21:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0c9c130a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 26 Aug 2024 07:21:50 +0000 (UTC)
Date: Mon, 26 Aug 2024 09:21:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 06/22] submodule: fix leaking fetch task data
Message-ID: <b4b65c3783ca496a62aa4a0ac3d82deca4793062.1724656120.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724656120.git.ps@pks.im>

The `submodule_parallel_fetch` structure contains various data
structures that we use to set up parallel fetches of submodules. We do
not free some of its data though, causing memory leaks. Plug those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule.c                 | 2 ++
 t/t5526-fetch-submodules.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/submodule.c b/submodule.c
index 97516b0fec1..97d0d47b561 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1883,6 +1883,8 @@ int fetch_submodules(struct repository *r,
 out:
 	free_submodules_data(&spf.changed_submodule_names);
 	string_list_clear(&spf.seen_submodule_names, 0);
+	strbuf_release(&spf.submodules_with_errors);
+	free(spf.oid_fetch_tasks);
 	return spf.result;
 }
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 5e566205ba4..2cfb5bd6bb1 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -6,6 +6,7 @@ test_description='Recursive "git fetch" for submodules'
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd=$(pwd)
-- 
2.46.0.164.g477ce5ccd6.dirty

