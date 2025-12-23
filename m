Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E1225409
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459553; cv=none; b=bixVxRL6W3BI8v0iDM7DEywVoloRWnSWhUr9tf7fOncGvNTvj45hHzYE248e8DKqeynJuUxYHERnI+Hmfh3k+HLtQmgqb8WtTq3hl97meWhkypAAMMBel7cedfnBawMada9lNADbIiJvRJckjgeLY94JgYyPyUOxv7oTEE4AQSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459553; c=relaxed/simple;
	bh=JDzGsD2XbKXkmpstZD+m1SxhQfRg996ouwV8CE/PSnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UN3gd/n1JOPW/6mP6vrGIKwCcExufwQCEJg8lzmGcPv1MUDpIGzpDCinw5epwywiMts1t1nJORqiKuVDTH0gzUxjolkUFLVfSH4yQ+jSdDEhQZfk8XGCcUQz6iut/HV15GxXqR3dxFCW9sAEd5iYN+zbth4rxq682Ns9tXxtQyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QGMVUkao; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tYvbao9s; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QGMVUkao";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tYvbao9s"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2D5B61D000B2;
	Mon, 22 Dec 2025 22:12:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 22 Dec 2025 22:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1766459550; x=1766545950; bh=Bm/uvMWPRD
	MUBI26TrISwaVEP7M9LLiQEe8sB+g64Dg=; b=QGMVUkao8lY28Arf1Og41cG5lS
	wyD/LEn8LnMFAS1zyEdz8ijGR6gNujZDk64mKr6vcnPzU4PO7Nh1ltaDE5+z+hQh
	W7q/cddjZy8a6JLl6aHrCqFnbaaqpT2h6Yq448KH0ehsCCfWxPP0ctWakx7GSjDP
	idgxQ5ONCiAIDlTqDhpbmq/4wtKmeFsmG1isFMXoUotdmsvq5RfYSQF1D2s6ho98
	Y7OQBsLs9lyv08DDWkSI5kNTkGAwN2sDtCMudNM0z7KNsaIrojB3XPV7zzgTj6lk
	LZ2xFj2hnTqqX9rPPlE2nF6NaZAe6FTWUALER4YTux5R5wDUgR3oktqWw+fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766459550; x=1766545950; bh=Bm/uvMWPRDMUBI26TrISwaVEP7M9LLiQEe8
	sB+g64Dg=; b=tYvbao9sE8Cr3dlSuFap8mp2nf+zptZnPzCWz57lgA6CXIkHEBl
	+zXFZVqq4gEq6Uyqno1znpn/tDGM8rG64BrrYozZVekc4JTCLhSMpcmNZMeIA8Gb
	CWaS7yx9enQJlTLVd/3gjmbNC9gmro2YTDvSiG2kSXyXicM4yza+3qyYA+CDtuc+
	jc7HWzq1m5YuJLKn6zdgsiPmMrljcgSV2QTibkYbFjkXttSIlGwxNZsote9HrXaP
	2jmzOyfxih5MM3beI04GTTwAXEaBgW+KK0c+SN4xzNJjn/YeWqM+Jw6gBs2VP8FV
	6RncRdUkK85AUhkUFNQXfanTdsZJdfbe48w==
X-ME-Sender: <xms:nQhKaTRChpDv8f2hHZkq6rjsJpNYWyS2pMXumnsHLiCQcCPvUiIdLw>
    <xme:nQhKaXDsYkdoN9Uk-M4-SrnYORZhHaR1fH1EL_sKfa590W6Wq0kOPHHczNNWuKv9W
    wPDnumaRYm7DZDfFvNtkcw5LoT4EcNogzdfQ-UQtVNltczkxdvXcA>
X-ME-Received: <xmr:nQhKabEnD0izg5wS4Q5kRjczpBufmSvOfC0PnTc4TgzfN1OzmmoPNMrfOGCTfLo5xHX9TK1XzvZUKl3nvhDdPSWChwzPyOlQjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehkeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpth
    htoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthh
    grshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:nQhKaZBa-O-uLc4yOCa8CgOAvBv7zPwredsaH_1X4-sZy6euOrSTxg>
    <xmx:nQhKabXDkPISkCyHFewT1Sh5vX7bsR_IHZRyIM7bCawb3WiKc8LR-g>
    <xmx:nQhKadpRoQqUMDTwmiRfiZoaUrKmWa0yH1BmKxJ5cfj3ZSgaxGSB2w>
    <xmx:nQhKaXQRDGtHzYcCulhUMreDpORA_VRM-q-PhsUS9sOlgehf37ii_A>
    <xmx:nghKaZ0a-VD5BoCl-AwAqyPAbyWNjL3Z0NAzzSgeZFzdAxloXt2TMiwr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Dec 2025 22:12:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  christian.couder@gmail.com,  newren@gmail.com,  Siddharth Asthana
 <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 1/2] replay: die descriptively when invalid commit-ish
In-Reply-To: <replay_die_descr.140@msgid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Mon, 22 Dec 2025
	23:04:42 +0100")
References: <CV_replay_die_descr.13f@msgid.xyz>
	<replay_die_descr.140@msgid.xyz>
Date: Tue, 23 Dec 2025 12:12:28 +0900
Message-ID: <xmqqikdxriw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> diff --git a/builtin/replay.c b/builtin/replay.c
> index 6172c8aacc9..175b64c5335 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -33,7 +33,7 @@ static struct commit *peel_committish(struct repository *repo, const char *name)
>  	struct object_id oid;
>  
>  	if (repo_get_oid(repo, name, &oid))
> -		return NULL;
> +		die(_("'%s' is not a valid commit-ish"), name);

This is after repo_get_oid() fails to turn the "name" into an oid.
The only thing we know about "name" is that it does not name an
object, but we want to get a commit-ish and the new message sounds
like a reasonable way to tell both of these two facts.

>  	obj = parse_object(repo, &oid);
>  	return (struct commit *)repo_peel_to_type(repo, name, 0, obj,
>  						  OBJ_COMMIT);

The previous parse_object() can return NULL, in which case
repo_peel_to_type() would also silently return NULL.

If obj is not NULL, repo_peel_to_type() would die with a descriptive
message when the thing does not peel to an object of the expected
type.

So the caller of this function still needs to be prepared for
receiving a NULL from here.

How many callers use this function?  I am wondering if it is better
to give a better message at the caller(s), rather than here, where
we lack context to tell something like "You gave string 'ource' as
the argument to the '--onto' option, but 'ource' does not name any
commit" (in other words, "for what our caller is trying to peel
<name> to a commit").



