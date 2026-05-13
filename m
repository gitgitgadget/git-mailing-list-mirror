Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246F831A576
	for <git@vger.kernel.org>; Wed, 13 May 2026 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778634219; cv=none; b=XEE8La33X2E6zuUq2KbwI1I7kKw96wBI6mioxKrwcJw2msDFERyQJHNh5QgJjHg1856jE1ohoWtMVrTp5M0Da+NISwo5Z3XDYqzMuiMqc3MQbiKgJQjVZtPk+sMZGrUXqqtvzCN0MvmBb0mioeQai8U7qlA5yqmNTBnq8ypnUUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778634219; c=relaxed/simple;
	bh=mlCAutzVnpXzbZL/uFM5eQJ+1RKmBC0E22/kKV4gf1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GDBEakB99XFykepoHE1LJOz48wSiwd0YwTDjC7li4RGofggnexUWfdwAkbCApdMytfhjXG+NP5Bu0yBE337qnVWBm3vBqT/DF0wR3bcwcKbkKuPKTgjY6SOLEPft+pxSUCb930I7DOpYLGRAkj3ogJo/3ZlHPd6JS3x+OGsoiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b1G8gPXG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RuTFPE7B; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b1G8gPXG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RuTFPE7B"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E4413EC00CC;
	Tue, 12 May 2026 21:03:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 12 May 2026 21:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778634212; x=1778720612; bh=rb8HN2Cc/K
	E2zgNl4ufDipdfhLSfSdUqaDiPUirI+TA=; b=b1G8gPXGoDVoPq7zf6ya9cbZPG
	ZoCcANYV00YG72/sNWqgaCqIWNzhgLfPvKr2NowwsG5md+/nYooKvjFmB7odNOHf
	jjwr2P/In5/QWKJE3Buk0hX6b7iqeo+0VJdRNSjm7Iae6zgUt90V//mJ1B7m2wrV
	dNsjnIjHX/+jblKA0eYQbpSdm3FxgD8sDo4hQPXjMkf6yE+U+yzBbbDoKuBcf9v6
	Fd0RTl6B7qYChvvJwkPJ711ZmbfL7cSYS/PTc68/LCFl0jldZifWWom54yW/xqOL
	ej2ovd1TgQgb6G5apO/xfJkUba5Aqe+I0Tyxc1hTBCHQKLmPZ+cWQdbETnEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778634212; x=1778720612; bh=rb8HN2Cc/KE2zgNl4ufDipdfhLSfSdUqaDi
	PUirI+TA=; b=RuTFPE7BQcA5T6BwjBadMGCGxn5XfG3oLlXl3+GqwqTaPeLdz+q
	+1Fe9utYEkxn0+ZEJXQj8NrEl1OXGmR5/WZdqM+iwQMTXcN8S/8OOvZYGz+j/qJ4
	YLDplYo47r0Na4NUqoUfsjRJbUKKWZolWvI8v7wodgL1TcrRRwjiTxyc6g8VaICv
	6HKFN8zJNcLPUNw2SlRJ4piU7h1f1/4EWud1fzEd4OZpX89QDGqEQzqgAv2hFZUv
	C03Bku7kwJuh5/2D1HnoZqlpFR6SnOyG3a7iYLteQe47eSIVBRUachuXn76kRr7O
	Mjj2Ug1SkYD/naTvqhOWWZ7xeoZtushHoFQ==
X-ME-Sender: <xms:5M0DapkAxmaguYsK19WHH8aH1fn2RwQk1TZfa40bi2HzCtEXZh36Dw>
    <xme:5M0Dar13EkVceUBIMziDQOmOC1VLLD8S-bGt38kWxYe9yLRcWs9lo0cOkj61N9o9C
    LHz0Y4NqRv0BU63zO9ZaflPEefGxDMNSIv9XDzm4cdVCNI7t-bABw>
X-ME-Received: <xmr:5M0DakrXlrZqE1Teep46C0A37Sxb-OttMs4OdI-Gv5lAFdJu34YUkysaOMHZVbXvNGWt6pdGp84dioBzLPmnzjrr0X35F_Ov3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdeffeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepgeeigeefudelkefghfegkeeuieefudejueevffetieejveffvefftddvvefh
    ffffnecuffhomhgrihhnpegrphhplhihrdgtfidprghrtghhihhvvgdrtgifnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhmrghrthhinhesphgrrhgrmhgvnh
    hovghnghdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5M0Daoc0_sA3SVSclfzUuu5fvKZem5gXV_8uXZGK4iehWNgfqZ-LMA>
    <xmx:5M0DajrdIrtjYTbNSFPGVXrsHeQFXZdy7xkUQjqFosJlCH9W4drcbw>
    <xmx:5M0DapGbqIyAFkSoElMGEWHXF_xSsZN_7busSlDwjCFADwAzUAQ9Aw>
    <xmx:5M0DajuWJQ9_JtmpjSBzgqPQ3xN49ZoERXEYsl1ZbME8js3fDjv-7Q>
    <xmx:5M0Daqoy4RJLI3D1AzpbkUBPx4f3oMEVFkb-sXOLrtI1kt2SfugsUiMS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 21:03:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Luke Martin <lmartin@paramenoeng.com>
Subject: Re: [PATCH] pretty: drop strbuf pre-sizing from add_rfc2047()
In-Reply-To: <20260512162022.GA69669@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 12 May 2026 12:20:22 -0400")
References: <20260512162022.GA69669@coredump.intra.peff.net>
Date: Wed, 13 May 2026 10:03:31 +0900
Message-ID: <xmqqtsscjf30.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> At the top of add_rfc2047() we do this:
>
>   strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
>
> where "len" is the size of the header (like an author name) we are about
> to encode into the buffer. This pre-sizing is purely an optimization; we
> use strbuf_addf() and friends to actually write into the buffer, and
> they will grow the buffer as necessary.
> ...
> Is the optimization helping? I don't think so. Even for a gigantic case
> like the 1.4GB author name, I couldn't measure any slowdown when
> removing it. And most input will be much smaller, and added to a running
> strbuf containing the rest of the email-header output. We can just rely
> on strbuf's usual amortized-linear growth.
>
> So deleting the line seems like the best way to go. It eliminates the
> integer overflow and makes the code a tiny bit simpler.

Very nice.

Someday we may want to go through the output from

    $ git grep -e 'strbuf_grow(' \*.c

and remove this ineffective presizing.  I think any call to
strbuf_grow() that is immediately followed by a call to
strbuf_addX() is suspect, like in the following illustration (there
are others in these files).

diff --git c/apply.c w/apply.c
index 3de4aa4d2e..b0f146276e 100644
--- c/apply.c
+++ w/apply.c
@@ -3305,7 +3305,6 @@ static int apply_fragments(struct apply_state *state, struct image *img, struct
 static int read_blob_object(struct strbuf *buf, const struct object_id *oid, unsigned mode)
 {
 	if (S_ISGITLINK(mode)) {
-		strbuf_grow(buf, 100);
 		strbuf_addf(buf, "Subproject commit %s\n", oid_to_hex(oid));
 	} else {
 		enum object_type type;
diff --git c/archive.c w/archive.c
index fcd474c682..47b8725f0a 100644
--- c/archive.c
+++ w/archive.c
@@ -164,7 +164,6 @@ static int write_archive_entry(const struct object_id *oid, const char *base,
 
 	args->convert = 0;
 	strbuf_reset(&path);
-	strbuf_grow(&path, PATH_MAX);
 	strbuf_add(&path, args->base, args->baselen);
 	strbuf_add(&path, base, baselen);
 	strbuf_addstr(&path, filename);





