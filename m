Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52E1E3DCD
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502952; cv=none; b=CNoJYHv2W8BHFFNfsytNDMBokd9qZC6IfjXVeaYEXlMQxmhXgxBtv5r5d/VT1lqBlSC1JjnCD9msp9OX3fjT1Ytd/woa3Y124HunzGIGp4Jff9+0kn0kCBX94r/XhXkH7TmPb5avNjVrq4Jzb9+Vnig8+3VQTH2aX78IuOGEhg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502952; c=relaxed/simple;
	bh=jg7CdAOpc3NRbh8h64MLuFA2kU0taHW8V1xMIQG1uwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8+9NAO+M+A413nXUxqdNkI3XI0mIzYsDz6eafDfEk8pwRPnMhVwXGAdLUngS2s+jgd+dLe8DaTiyC3bakUjVu0nAyKnLFXHZBYm1q2njutBtuBSrbslQeEx0eL+58tQ9Zd6dWdQ1MdWBHVDB/SIZInqC9uilCmOFjp4mTUomIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YJqJKj0s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dPacyH4R; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YJqJKj0s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dPacyH4R"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1BC2511401BB;
	Mon, 21 Oct 2024 05:29:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 05:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502950; x=1729589350; bh=PEN28oqqIX
	f8IMKt/qx0Lz4xq1xrxDEu9ibMoXDoq8Q=; b=YJqJKj0sBkOkMNDNcNKGH+iMHi
	VaUvO31H4kEoSFGhtose2L0o4/Qv7AXOCYHIwNqR3jacbGtmN0aH/lA3jJh98gFS
	LUQ/EFyJebtCqwpq6i5nDsIfkB63IPLjRfOP07OizvfRjcnxIuVcjFphRRx/dr7b
	VtlF/CBVKUgfhe0vzdbftCeO6jMkFdddCP/h+D1kLjtKHdxl/Ezpe0ECnipt8s1c
	boFQjqMYVr3CmgULuQcgldkB9wjB97X+GwNwK8XzRFzrs1nLcrI7jLhsQ4WBIM/8
	3uzKI4vAAXy7k9PJ6yAyZ+odNQQP1gPAqtsCGuTXk0StZEAXBrsh8tW5vRPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502950; x=1729589350; bh=PEN28oqqIXf8IMKt/qx0Lz4xq1xr
	xDEu9ibMoXDoq8Q=; b=dPacyH4RtiIbphQ0b1VQK8dWQFZ1kXcfrwGQ57EWi//s
	UC9JTYytwMfH8Cbl9Wb7VxI26BvMyR/6q8Zy5yOwB3BVMhpYN8tFTbzLfdszeg62
	atz/aqJUT3kWGRQ9j31035+RlBTwThLzqPzok01eqQo23Shy29YRC64p/ZPjhGWp
	H7KHHyDggjCAfDi1vYkkrVb3OhKIN9TQL4eZY1cIiT7MZQbfsirj8JCNDeZU9AVD
	285jGjpIiUzQ/DX74zV6Z1iNf8PjqA1672146JMN3or1SzL7XQ1QFkpMnCS1gHMP
	SPM40RuzwyWZazMC9XSt/dks0/jck0tv4pXHqWIL7Q==
X-ME-Sender: <xms:5R4WZwieVJAaoR0tsBO1gUNakms__G8yKeFrEG2obKyzQb79Ac1KUQ>
    <xme:5R4WZ5CVWGGqn7VLAznoM0BNK1QI2jP-xMQZrser1aMVC9aKqyMugWNo43xUAyTJD
    U5AIIVElwZYna33AA>
X-ME-Received: <xmr:5R4WZ4FmN8Fxim5J8708IaGaZ_FQl-jLuQgShsEeih2c_CECwoZSUnQxRVKkZtA61YZwl9ddZai0LAsxspmFh0kWlVkbwn7sdWBOP4F9BJ__>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhm
X-ME-Proxy: <xmx:5R4WZxT3fazV7J5CTmPWf3ZfMdwi50Phl0obeOej5Z5IqsszTl8hGA>
    <xmx:5h4WZ9zvUfiDTABvcfBgnezdAuI_QmIPtaElhmcN4-Yi9yD4sQdWig>
    <xmx:5h4WZ_5kGcDD29IUUYcSgKtfiOBK2uB_DjLF3iNpCVU2TPEMUkcSmw>
    <xmx:5h4WZ6zFUWzG-baz9dHjKJVNduE0OGnzc77vaWm17XpIxBACWuzJ2Q>
    <xmx:5h4WZ18sXsl_nJINNTEU-41UP_MQ2LkO0CHms8kIvhex03S6pij7NVlw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:29:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 19d91ef0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:42 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:29:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 21/22] builtin/merge: release outbut buffer after
 performing merge
Message-ID: <5e243f9ee530da417beda9230f65ccf18ae21a9e.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

The `obuf` member of `struct merge_options` is used to buffer output in
some cases. In order to not discard its allocated memory we only release
its contents in `merge_finalize()` when we're not currently recursing
into a subtree.

This results in some situations where we seemingly do not release the
buffer reliably. We thus have calls to `strbuf_release()` for this
buffer scattered across the codebase. But we're missing one callsite in
git-merge(1), which causes a memory leak.

We should ideally refactor this interface so that callers don't have to
know about any such internals. But for now, paper over the issue by
adding one more `strbuf_release()` call.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge.c                          | 1 +
 t/t6424-merge-unrelated-index-changes.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 84d0f3604bc..51038eaca84 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -754,6 +754,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			clean = merge_recursive(&o, head, remoteheads->item,
 						reversed, &result);
 		free_commit_list(reversed);
+		strbuf_release(&o.obuf);
 
 		if (clean < 0) {
 			rollback_lock_file(&lock);
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 7677c5f08d0..a7ea8acb845 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -2,6 +2,7 @@
 
 test_description="merges with unrelated index changes"
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Testcase for some simple merges
-- 
2.47.0.72.gef8ce8f3d4.dirty

