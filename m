Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD97229B12
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750721748; cv=none; b=QiZ+m3zWTOvtWUb0a2d7Tz8hg8NtQknL3ONz7ITXLU/pvcz+NoCl3t35L7T4t1u2LRZ9FnI40vC6QDhXM3lUnJb4LTSuzNFh2FB65GLeNaeCI7XlglY1uTEMZOyVbXxywUsHZyuv5BwGMVCHVDe9zcGbRqRWm9GEoYY1nVwHtqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750721748; c=relaxed/simple;
	bh=ER7J3QmCwWB5jjFweHyvEb2JUCkauVZduJ+ht7N1at4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C8teUCSo5IwGWyJwXcB2NnYsmWeM7GnBD4hdH6yIeUXLma0UiuNrsX0lLDNH9wwNExjrIXQIXJf5Z3PbM2FZtX47oxQFKHd+URo2YWwK6UkoLPRqCNR2iSXZ6TIxVRJAcT9/jSdxM+5t7xbQzc6aTl4EuInGvFlzv1scfnoQKfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NY2Iou2H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W1c5Mt1J; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NY2Iou2H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W1c5Mt1J"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2080E11401AF;
	Mon, 23 Jun 2025 19:35:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 23 Jun 2025 19:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750721746; x=1750808146; bh=QZXSG2Tfoe
	OuQg9zai0v+slzunbW530/XY0REo4DRVs=; b=NY2Iou2HCBzj5zY1k6SA7Q7c7K
	JXAtXIVNG8KnZp78q3N207NNK3BhZBONOiKnT26u6XZOUuWPquqndpa2VI8Tg6GN
	ziQ+KCuLEXjvFA7/Gh6MxMoGp0OLyTHh3FyDKnFPUGsacVcaP/c9vCdTuhogie2U
	E9LG1IVKFrhVhD9PovcsUehrh69SWrDT9OSIyF9vYKzpcqt+oNTjrmffdwcG+dq6
	Hwil7VJyKAm/hjhJKY9FmQ2g+xGwCUdZ4OeTdBEtQJEyDQs5inmc5ojz5KwQnsrW
	7f2326ozX/nFYSK/1aKojqVNzs+HZtnO/VYBLaJnrsj0iVhLjclR5v4whAcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750721746; x=1750808146; bh=QZXSG2TfoeOuQg9zai0v+slzunbW530/XY0
	REo4DRVs=; b=W1c5Mt1JeBDwCTFtUKSKpiD5zIEqGdazTIG0Wm3DubJjEpR/bdl
	ybpvQbwOxWrH9Ycyt18yirWqTM0HUU0bsnhs1dQklwUZi7T35D6Cf84Ncxc1yIpH
	gbLWrcU5gaKfhZez8w7hHl1WrxfkgC9FgPv+KYNyf8AYfXbGv9SOFfP5s6BmL3mj
	T4PXk7bse4qiV/qp89Kj5sAiGGr/eZ9di5m/zjRFT4nw5i8OyZm7ewr60ObsFMqz
	iFe6gerTGxvYDAGXPt3lLRkhvfcX8ISEJzL29urEfK9CRlfQDWA7cysRHazwD58L
	IA7zDdqQl7Mlh13YThvWP0SuZsgcbWX5Iig==
X-ME-Sender: <xms:0eRZaPYCdTVBJn7gg1SxJyFT-CiCJSKNG3LVRs93DbP7Cic0aB5MUw>
    <xme:0eRZaOZiOTroAHgU05idfvtC5Vg1pILVIdrifuVPC0WXW49v2VP5T7J4PFxLq3NzF
    V1452c0QElLasbXLQ>
X-ME-Received: <xmr:0eRZaB8YsvB5tHtAKVjfF-L_y6uCju30NRX6dcy8oz2L8mKtiW1AGdkFTQh6hFRcx1WOD68JMd-QRIWd9bG5OIuewHpGKXmoVDOWiFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddukeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrhgvnhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0uRZaFqL9-Dxet0YQxKBmGDrW0SVd6kXbL59JRjdp1vRJZ6QmLYjiQ>
    <xmx:0uRZaKr11O_xUWkkq5W3OmwuaSWq00A6HqVJjAW09Cw9c6PuCWzRUQ>
    <xmx:0uRZaLTxAdh2wABj4LzpR74rl9uR0yC697b_YxfxEvrdunXvvweD1Q>
    <xmx:0uRZaCoziRRxeaXfDMUD-93VO1gy2zkzjQmJW8u9ToUeGZnZYQJQGg>
    <xmx:0uRZaAvreu18H6SH8Z3_IhRGfNNp_XTh01APEWCff-ruhYsxQmZyrDR4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 19:35:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v6 8/9] pack-objects: introduce '--stdin-packs=follow'
In-Reply-To: <3699c25337e1c91388bad4c56441b39a9984798b.1750717921.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 23 Jun 2025 18:32:30 -0400")
References: <cover.1744413969.git.me@ttaylorr.com>
	<cover.1750717921.git.me@ttaylorr.com>
	<3699c25337e1c91388bad4c56441b39a9984798b.1750717921.git.me@ttaylorr.com>
Date: Mon, 23 Jun 2025 16:35:44 -0700
Message-ID: <xmqq8qli3ub3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>  static void show_object_pack_hint(struct object *object, const char *name,
> -				  void *data UNUSED)
> +				  void *data)
>  {
> -	struct object_entry *oe = packlist_find(&to_pack, &object->oid);
> -	if (!oe)
> -		return;
> +	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
> +	if (mode == STDIN_PACKS_MODE_FOLLOW) {
> +		if (object->type == OBJ_BLOB &&
> +		    !has_object(the_repository, &object->oid, 0))
> +			return;

So, --stdin-packs opened a pack and is feeding the objects contained
in it to this machinery.  show_commit_pack_hint() calls this
function in the `follow` mode.  How would such an object be missing?
Ah, lazy clones.  OK.

> +		add_object_entry(&object->oid, object->type, name, 0);
> +	} else {

And only up to this point is the new code.  The "else" clause is
just the original indented one-level deeper.

> +static void show_commit_pack_hint(struct commit *commit, void *data)
>  {
> +	enum stdin_packs_mode mode = *(enum stdin_packs_mode *)data;
> +
> +	if (mode == STDIN_PACKS_MODE_FOLLOW) {
> +		show_object_pack_hint((struct object *)commit, "", data);
> +		return;
> +	}
> +
>  	/* nothing to do; commits don't have a namehash */
> +
>  }

What is this new blank line doing here?


