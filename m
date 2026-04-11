Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE311DF6C
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 02:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775872943; cv=none; b=k35V5r6KBXYOmUiX3oprsxQ1oWEUqi5RELmsYnr1oIpnjNDDwMOhwTTzjpnjSUHLBupiNF5MBho9HTbfJJr8c8gzW6Xiinx9NsgiWx/BzsGcbZUsmYEDbyI9jSkhTzUwYJoa9lI7q29hP5l9t4hC6gc3YEbpGpxJGstJxsRqXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775872943; c=relaxed/simple;
	bh=JjLcXSsEzDNk7Pr7XJPQHZgPDM2kmOFCzpzqpZVufa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bQXlO1todwdqYOZdm3Manw94L0LMIxOkMoer6QKPH2f01yx0JsNo8Ge4VrZxBEuVcVJurxsIeiWTXNXgDFygfTNfQTvnmMmDYJTrVOR5/nUQx3l6TaxqqThdwU3eTdkkPUX0udzFnAkE54l0K6HJdgk8eTk3iyT0hGTZmKoy6IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IXkPVtQL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HolBVvou; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IXkPVtQL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HolBVvou"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E50DC7A00AC;
	Fri, 10 Apr 2026 22:02:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 10 Apr 2026 22:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775872939; x=1775959339; bh=os4h6IzVJm
	YKJScXf0pP00h8Aa6S66sKpOhgiFmbyqA=; b=IXkPVtQLnnNo7xmlGkQbWtmMuB
	7Fsstuj4kRK7XRkChwg+cCIxhbUE2zO9udAmFSgSoIfSaNNP3oWlEeErHBwwayhx
	oEf/DtUruyR7Fw39Ho8KbUUHnr20hFxLnhdoyVtGW+FvMkhbT9RE2yUbPGiMoUW0
	a8qQwQXMD3JDqEgDMzGaM8cAgDpzljrJOBWRmmZRY13PBZSWmuJEyRy152mm6Oel
	YsY3qDcNNMhk9KSH/Aw4ng5TB/qcnejEEbdCIP4zw8CObdH3eqBJN4KDOvNmz/hg
	JiB9xUgv5CEpd1YBAyLbf0u3CU8nuOlzU7gbfQRkqNXYFwp94xlds1/hN5fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775872939; x=1775959339; bh=os4h6IzVJmYKJScXf0pP00h8Aa6S66sKpOh
	giFmbyqA=; b=HolBVvouQeCsnC7JkChB9SOPnjrDbZOnK3d5YOlTZBDYrmTuvSb
	p+x9NF1ikj3Rt2WB8bTv7BwghmdKsDm6fRyiEHMk9v55QUvIYRVwC7EnfiWhjrSa
	gB/tEHosR3PqgmqwGKTtqOn4eGyHLDVVn5Pmsm42wFzD0RBjylbaQqEWcdORwn9o
	hVAxkTRzD7KJTixjy/P0HTmYylIquuAUsZ/NnqdoAvizUHO/6p/X90SY5DNKPoL1
	k819VK7FTy99mQnLAxfW00UwXo7WSIFRa+beDhcWuKOKmnSDS50LLJ61gMz+8yxF
	gDGWUtK2UMDoux/alns1KwZ2ZgMD2u0aTpQ==
X-ME-Sender: <xms:q6vZaTGUd0Dn00oyLp7Ve-iWUAjqr-RMPPszig4D8ikB61lCZWJ52Q>
    <xme:q6vZaS7_7S_3hMFZDmwXo-yfm0KTYT_K9Ma4OJUmJAunYNMR0xmv9LYt-HrOiyC43
    nhczTi954vtCq46_2CdwP3-uftAqvKvAHlMOkhFxgJ4IlbFS9KcHA>
X-ME-Received: <xmr:q6vZaYzPHuUXSezPmCcD4DIyTR6HYRH-eRd91nj8Rvn-NO5WBh8ILV-5t9jkekhyvkAAZvaK9Q3qYrKiMk9JTJ4mjqv-6iZPCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefuddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejkeeujeegteevjeetgeeileeujeeijeefueegieetiedtleffvdffheeihedu
    feenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhorh
    gvnhiiohdrphgvghhorhgrrhhivddttddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhr
    tghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:q6vZaRPcMgdBigL8_DyuMmJzcfd-6gq4HCJHOvEWk_VwWOgY5YM9Vw>
    <xmx:q6vZaen1ZJ_RHQAPpctb-aQImDPXFsWDF99nC_qhRuxDeF5RkkrJFQ>
    <xmx:q6vZaWTAWWX5_MDIVHb3hSPZZf0_lRo32jEm2skReyJaXODMCEp_TQ>
    <xmx:q6vZadW-R6fRWD0-zLhhfnLXwUeAor5sQI4T8WpLMWu8zrqUdc30-Q>
    <xmx:q6vZaRLBquYZtgDUg0fRrO46Y8TM4euMYvsyuFZ9-CVpfssseTtFI3Gd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 22:02:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt
 <ps@pks.im>,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Tian Yuchen
 <cat@malon.dev>
Subject: Re: [GSoC PATCH v4 0/5] preserve promisor files content after repack
In-Reply-To: <xmqqse92mn5c.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	10 Apr 2026 16:05:51 -0700")
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
	<xmqqse92mn5c.fsf@gitster.g>
Date: Fri, 10 Apr 2026 19:02:17 -0700
Message-ID: <xmqqjyuemeza.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> When merged to the tip of 'seen' (with a fixup to use st_mtime where
> we need only whole second precision, to avoid using st_mtim on
> platforms that do not have it), this seems to break linux-leaks and
> linux-reftable-leaks CI jobs (t0410, t5616, and t5710).
>
> This topic standalone, without interaction with other things in
> 'seen', breaks these three tests.
>
>   https://github.com/git/git/actions/runs/24267948258/job/70866907548
>
> This is one commit directly on top of your topic that reduces CI
> jobs down to just two "leaks" job, and removes many test scripts
> to leave only these three breaking ones.
>
>
> I managed to also locally reproduce this failure.  Here is how
>
>     $ cd t && t5710-*.sh -i -v
>
> dies:
>
> Direct leak of 285 byte(s) in 1 object(s) allocated from:
>     #0 0x55ce48ca1d4d in malloc (git+0x8cd4d) (BuildId: 1aa6efa30b2fc4772028a3dd31aba3ced49bf128)
>     #1 0x55ce48fed3f2 in do_xmalloc wrapper.c:55:8
>     #2 0x55ce48fed3b6 in xmalloc wrapper.c:76:9
>     #3 0x55ce48eed314 in alloc_packed_git packfile.c:306:25
>     #4 0x55ce48eed209 in parse_pack_index packfile.c:326:25
>     #5 0x55ce48f65f03 in copy_promisor_content repack-promisor.c:67:14
>     ...


FWIW, the tip of 'seen' as of this writing has queued this topic
(the latest round v5) plus the attached "SQUASH???" commit at its
tip.

The first hunk (die when dest_pack is NULL) is absolutely positively
a wrong thing to do.  As I said, I do not know if we want to call
parse_pack_index() here or if we have a more appropriate helper
function to use, but assuming that parse_pack_index() is the right
thing to call, we should be prepared to see NULL returned.  BUG("")
is reserved for detected programming errors, and it is absolutely a
wrong thing to call.

As the content copied by this function is supposed to be for
debugging only, I think dying when we cannot copy is not what we
want.  Rather, it probably makes more sense to fall back to the
traditional behaviour (e.g., not copying and instead leaving an
empty file, if that is what we did before this patch series).

The second hunk just line-wraps an overly long line.  There are
other overly long lines in this deeply indented block (which is a
sign that it might be worth to see if the block is better made into
a small static helper function) that should be line-wrapped in a
similar way, but I didn't bother.

THe last hunk is a real bugfix for the leak (again, provided that
parse_pack_index() is what we want to use).


 repack-promisor.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/repack-promisor.c b/repack-promisor.c
index 26055212a3..c7025e97f2 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -71,6 +71,8 @@ static void copy_promisor_content(struct repository *repo,
 	dest_idx_name = mkpathdup("%s-%s.idx", packtmp, dest_hex);
 	get_oid_hex_algop(dest_hex, &dest_oid, repo->hash_algo);
 	dest_pack = parse_pack_index(repo, dest_oid.hash, dest_idx_name);
+	if (!dest_pack)
+		BUG("parse_pack_index() failed.");
 
 	/* Open the .promisor dest file, and fill dest_content with its content */
 	dest_promisor_name = mkpathdup("%s-%s.promisor", packtmp, dest_hex);
@@ -115,7 +117,8 @@ static void copy_promisor_content(struct repository *repo,
 
 			/* If <time> doesn't exist, retrieve it and add it to line */
 			if (line_sections.nr < 3)
-				strbuf_addf(&line, " %" PRItime, (timestamp_t)source_stat.st_mtime);
+				strbuf_addf(&line, " %" PRItime,
+					    (timestamp_t)source_stat.st_mtime);
 
 			/*
 			 * Add the finalized line to dest_to_write and dest_content if it
@@ -148,6 +151,7 @@ static void copy_promisor_content(struct repository *repo,
 		die(_("Could not write '%s' promisor file"), dest_promisor_name);
 
 	close_pack_index(dest_pack);
+	free(dest_pack);
 	free(dest_idx_name);
 	free(dest_promisor_name);
 	strset_clear(&dest_content);
-- 
2.54.0-rc1-178-ge3ec7964f3

