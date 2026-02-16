Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B47331A57
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256304; cv=none; b=kAmnro3Sdn7IdG96h6XLmxCQyravZodwZNwL4iWHwe38DtqzGt3ihCzZY6PPmkEHlEC3DqGaVm3YpT1HHyYQV1wUpGdcPoRHJsxaP6QhQ8DBQnfEZyh0AB1VQ17BCaQT5HYsou5jSqv2wbI5mjCf2Gd2vCU0AV8NP0InOnjBTio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256304; c=relaxed/simple;
	bh=EILVSv8O953eVYv3ty++7S4qdqkjBNUWYyW1bCA/A78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QMfBvTRD+aO6kRfPswd8f8VJWpGCqrj4TTREsVbrHgqxSNHt5orOGurxjlr92MhSYkmnf5TYd8OXRgg0Dled0e0IudzSjrqSpPPLb0bSUAhdWZwpfuLg1NOCyZwD8riMzsONpPgYgeSsEOpeXcJ6WTcd238+KJZVAPOr5JuH0Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UXxg/Fz+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QV18hFnA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UXxg/Fz+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QV18hFnA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B6C214000F5;
	Mon, 16 Feb 2026 10:38:22 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 16 Feb 2026 10:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771256302;
	 x=1771342702; bh=XcAmyPYnpKBz/hVH9zexnAVhMviD8jeHLFihDejlYS8=; b=
	UXxg/Fz+7l2LyYcLZeHlSheTbOAsFKQq+WXVXqLwtd1F+L2cJjmhIcahz8/EzeLH
	/PEkfa5C9iiaTkJyOtjWARblVlqFKTL2tBHwmuemesTLsOXkzsIPorx0g1Xsvrt6
	2chxREnsL3+bu1n3N6eL67DCymkXc9lrTOhPjpkmUiMeVZEnM71Ac/IbQAYVjc1U
	c2gO8v6Mx+Lx27QQyyQsvBFPzmHht76kMREIVmDMwM+3kApYk7uqcp/K9Wg3f2B9
	yKhBCbbrwnyF7Xnyk9gUlbbE+J6QAdU7zVOS6FyFZlpQU4K+iKZV7lCSzzRvzNqQ
	p1iM1LzhBNX1c1ZXH9B82Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771256302; x=
	1771342702; bh=XcAmyPYnpKBz/hVH9zexnAVhMviD8jeHLFihDejlYS8=; b=Q
	V18hFnAkWWklMRSmHphj6t8PvZjqR9tybZsOBV9Vd4eGTe6vtXxyQ0wXmWwi+xSl
	Kjm3u+uiVlJFxF4wVqCb0sSMvhRJxQhxzfdr5LtZFiPbapo0vABkg4i7D6PLRusq
	5ml0YilkH70QtgAiCihDZW0dWDshQE8XHTNDs9NbniG18wQoq7S/OVgC/7NV816q
	2Z6AF2l4NCxgSsEbfaxrzpRsZ2pDSXBhgvPZyEnVcUPeF5rMCtToSPnv4etktjRT
	Cq5cFgIwON4tE6GWfCUcMcDkdu9qsrgq5Vq6bTKYT5mS2gl+dMVCydi3M589eSUK
	9imHRCRJ3miwNqsdmDc8Q==
X-ME-Sender: <xms:7jmTaVoqW8-3kK8kxwFiOaxPOzTYE4i-JHCkiWnJUYqz3iPT3bgkyA>
    <xme:7jmTadqDaSGw5Ppp0crebQRm9sbM7s4T7Qkc5jt-SkOu6FSl6qlGZqPlxoMDExPxL
    DdXCqDK1liomGoohPgtraK2apXLrkJ8LJWbaRrK8nklTuhf3z2PAQ>
X-ME-Received: <xmr:7jmTaf31o9NKbhsyY3tudUMJhV42MnDVhxXjTOqICXNWWuPN03JKUjdqQXaZYuqJ1eyBI5SCXl-FZvSC-Q86hcpIbMSTLPSUhTjrzdk9fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7jmTacBT576DVxdRXiwSrGv1I5SLy9RFNtFgUwAQ383imE4AmHFEnw>
    <xmx:7jmTaXemg7wRqhsyHvMd0TrRB88X2_4HgGgG8h2sj6Mw7ZEiXG0fLQ>
    <xmx:7jmTaRi26NCT6p91HvsILZ69Fa_vLyE7YBw7PqYPBZLkcuX2WkdbLw>
    <xmx:7jmTafrKY5Cho1Um6dnwt6f5t9U7dSrxeapwAUsx2zqpj10e_xrMVw>
    <xmx:7jmTafa6gyaa25uC-cecYQ8lbaifBu3tvR1fhsRY44m2PS-g25KVI6Sc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 10:38:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 15eef0c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 15:38:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Feb 2026 16:38:03 +0100
Subject: [PATCH 3/3] commit: use commit graph in
 `lookup_commit_reference_gently()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-b4-pks-receive-pack-optimize-shallow-v1-3-e98886daff2b@pks.im>
References: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
In-Reply-To: <20260216-b4-pks-receive-pack-optimize-shallow-v1-0-e98886daff2b@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>
X-Mailer: b4 0.14.3

In the preceding commit we refactored `lookup_commit_reference_gently()`
so that it doesn't parse non-commit objects anymore. This has led to a
speedup when git-receive-pack(1) accepts a shallow push into a repo
with lots of refs that point to blobs or trees.

But while this case is now faster, we still have the issue that
accepting pushes with lots of "normal" refs that point to commits are
still slow. This is mostly because we look up the commits via the object
database, and that is rather costly.

Adapt the code to use `repo_parse_commit_gently()` instead of
`parse_object()` to parse the resulting commit object. This function
knows to use the commit-graph to fill in the object, which is way more
cost efficient.

This leads to another significant speedup when accepting shallow pushes.
The following benchmark pushes a single objects from a shallow clone
into a repository with 600,000 references that all point to commits:

  Benchmark 1: git-receive-pack (rev = HEAD~)
    Time (mean ± σ):      9.179 s ±  0.031 s    [User: 8.858 s, System: 0.528 s]
    Range (min … max):    9.154 s …  9.213 s    3 runs

  Benchmark 2: git-receive-pack (rev = HEAD)
    Time (mean ± σ):      2.337 s ±  0.032 s    [User: 2.331 s, System: 0.234 s]
    Range (min … max):    2.308 s …  2.371 s    3 runs

  Summary
    git-receive-pack . </tmp/input (rev = HEAD) ran
      3.93 ± 0.05 times faster than git-receive-pack (rev = HEAD~)

Also, this again leads to a significant reduction in memory allocations.
Before this change:

  HEAP SUMMARY:
      in use at exit: 17,524,978 bytes in 22,393 blocks
    total heap usage: 33,313 allocs, 10,920 frees, 407,774,251 bytes allocated

And after this change:

  HEAP SUMMARY:
      in use at exit: 11,534,036 bytes in 12,406 blocks
    total heap usage: 13,284 allocs, 878 frees, 15,521,451 bytes allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 commit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index b7c4ec2eb5..014f74822c 100644
--- a/commit.c
+++ b/commit.c
@@ -45,7 +45,7 @@ struct commit *lookup_commit_reference_gently(struct repository *r,
 {
 	const struct object_id *maybe_peeled;
 	struct object_id peeled_oid;
-	struct object *object;
+	struct commit *commit;
 	enum object_type type;
 
 	switch (peel_object_ext(r, oid, &peeled_oid, 0, &type)) {
@@ -67,11 +67,11 @@ struct commit *lookup_commit_reference_gently(struct repository *r,
 		return NULL;
 	}
 
-	object = parse_object(r, maybe_peeled);
-	if (!object)
+	commit = lookup_commit(r, maybe_peeled);
+	if (!commit || repo_parse_commit_gently(r, commit, quiet) < 0)
 		return NULL;
 
-	return object_as_type(object, OBJ_COMMIT, quiet);
+	return commit;
 }
 
 struct commit *lookup_commit_reference(struct repository *r, const struct object_id *oid)

-- 
2.53.0.352.gd1286b26eb.dirty

