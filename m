Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997491990A7
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530960; cv=none; b=VeVbGz1YV4tEy+mR8RIe7ROQAygBMGIQSMZSMFXsLYv2xz6JF6CQPQYj+nQIn3npTpi3PhF2H/02ibZnhxivpsrvWZVmdh5ea+uwirXhtfn0wxcIyGZg+PpufZZLCZZ4xbwUGajiMl4nsLwARxla6XyyHWAPA4y2FVjesa6Yn6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530960; c=relaxed/simple;
	bh=CiPrT9Lv5ZmDA3iI5uFH9UoeIHMd31aUeAlNF0PhILE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luw2KOo3uj/E9jH82NzQZf9Y4MU+axlSfZgOhhheov43er0QHFMEbjFJdw61gV2TflLJ6gomKr4zL64nUXcwOH8ocOEeSU0zBU+M1LFqCqdhD8iQ4a/+xxxH6OWL98+ZB8w3LE6cInIYzY9Udn/V2l7NUophy7LIuj7VkAAA8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=joJbIRE7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mWfCJnY/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="joJbIRE7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mWfCJnY/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A61EA11400DB;
	Thu,  5 Sep 2024 06:09:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Sep 2024 06:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530957; x=1725617357; bh=5H237q3dmm
	8m5oMw3ClNqlwpvtO7Zp/23dAOnNAg/jI=; b=joJbIRE7V8lesuUjBYG4qP7T/g
	tcjoJ+m9pYfUpkXBMaWSZbxHZo++5wXm8YbNgpmterFP/GbvJnZM7Jlr2gaVlLIN
	xwSNYHTDnvowYFO9V7yeaiJAiH9XnJUJ/o7qpyovQXA355QPt5YOz8uwVt4xYz86
	eAPV5dTvEzLuGNJj8DhqYqWqqEB3mq6Rh8caR89n5MjZrKeOY/nyM4HLoEIWqPnY
	WKM/NhbSI6Sk2llTRizcdS8PuT0FO86tTPHGxxkt7I+Zxnp0SryEmFq/GXTJFCG8
	cT+2rLluv8OEqR4qqXj5XrRKoKcyS9afA6MBPkk0N/eJ4zPGXzqJgOCtgnUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530957; x=1725617357; bh=5H237q3dmm8m5oMw3ClNqlwpvtO7
	Zp/23dAOnNAg/jI=; b=mWfCJnY/Qfg7c6PbGHaC9rXeYgWOtTUUFAzNp6cb1sxd
	91igGAycfkfVLbG20Fq6GtOsfYzc7Q/s87OYKX6b4B1kDT96fK7z5vzIFmN4NvdA
	fZOoBWEKvdBN8HJY9l/WM/i00QmsfW9pEKC9BTiEAr3OQF4vSY29UnxDXGRPubj9
	vWaRsLjXFJADFW5JXdraSZ5s1v1pur0RT52WRyWMgl1gmS7UUPmkStdtVbcjvBDk
	LM6HcQFoMXBs0a4FTu1FKjkGjw3h+C+fw567Q0NT1RGm0A98QQFlCYVrY3tgSSQd
	hlZpi3CaFnimZcyDt0sIi8eDD2Q8JTG2S5JW6hSghQ==
X-ME-Sender: <xms:TYPZZpgo-nRxYcVg7W5FH_nqLQGwG19F4XLZPIhLeRbnguBThE-KBQ>
    <xme:TYPZZuD0ERP1cecPZaP1buwgCtIk8_dDeicU32YA6OlQSl06UByqzU4Jfr3pZPeaF
    QNd3YWkMU1JjJvt-g>
X-ME-Received: <xmr:TYPZZpHbhjYnVST4pwjKZ5jhN38ovQreanBc0-bJ1GOngGKAULg4PcEeaUCpN-P5BVbj8XGbT8K2raZtCnZ1iCzoMXzAYEr0PyRSBi-IYG8mmEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:TYPZZuQuP812E_MINf4pIv4brEROdREsm3zeexnwQLGQb74AXXyEJA>
    <xmx:TYPZZmyTe1a9AziQvVqWqmxdwZmCGIZXtnAlABz2JF1uglwfC-z0lg>
    <xmx:TYPZZk5ph-nr20yoIp__vQZQ5c1XIPL120BFwhQM3hjGHRQ_WrO8Ug>
    <xmx:TYPZZrx7yUFv7rgntNkQLtvAWVrFYB3drhBdGTg60oARcBELkQr-PA>
    <xmx:TYPZZtnjIric-v1CWHeGL6oHm7VM_LJR4z3aQEwzluXzLloA5SKCXbTa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ed1975e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:05 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 13/22] shallow: free grafts when unregistering them
Message-ID: <4747042cb6a779c87eef35f23e127795828281db.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

When removing a graft via `unregister_shallow()` we remove it from the
grafts array, but do not free the structure. Fix this to plug the leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 shallow.c                | 4 +++-
 t/t5537-fetch-shallow.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/shallow.c b/shallow.c
index a10cf9e9d5d..7e0ee96ead9 100644
--- a/shallow.c
+++ b/shallow.c
@@ -51,10 +51,12 @@ int unregister_shallow(const struct object_id *oid)
 	int pos = commit_graft_pos(the_repository, oid);
 	if (pos < 0)
 		return -1;
-	if (pos + 1 < the_repository->parsed_objects->grafts_nr)
+	if (pos + 1 < the_repository->parsed_objects->grafts_nr) {
+		free(the_repository->parsed_objects->grafts[pos]);
 		MOVE_ARRAY(the_repository->parsed_objects->grafts + pos,
 			   the_repository->parsed_objects->grafts + pos + 1,
 			   the_repository->parsed_objects->grafts_nr - pos - 1);
+	}
 	the_repository->parsed_objects->grafts_nr--;
 	return 0;
 }
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 37f7547a4ca..cae4d400f32 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -5,6 +5,7 @@ test_description='fetch/clone from a shallow clone'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 commit() {
-- 
2.46.0.519.g2e7b89e038.dirty

