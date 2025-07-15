Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E04072615
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612226; cv=none; b=K6j6l7Nb++iVi6J42LwbBycAcSRCWgHmS+zv9kww8K7p75pVe/0BQgf15jkqGIp/fuqAyaXE4plb8J2i2rCJvzR+eNHSBMAHQSpUZRMQZOHNrSVxJS6R3J+4rjX03om7eU4ig73+nnhZCL0Twv1pKzlAGUb1dGn9+GuEsdCxJRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612226; c=relaxed/simple;
	bh=h52OtZUSH/30veMimZp4SQ5VGD8BdZNSn2Ur1gKqBwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gAAkjeiimI7l12pXQPuZPHcdJRYVcRKvuZl+StoNRHbFL1+SzBhrd42wK1lzTWJr4jFguAMVQHXo17y3Wrwj1w32W4b6Z+f/pSN23KinzoVtHZnJFWOSG7vODilLIeEt6FE1SDmoo5ihKSsRQ23+nbGOzx1jbR9uAzxFZVYErPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S4ASgfha; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JsgQzGbI; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S4ASgfha";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JsgQzGbI"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 10D267A0276;
	Tue, 15 Jul 2025 16:43:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 15 Jul 2025 16:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752612222;
	 x=1752698622; bh=Iuvt+9i/0tmQzEHmrw/GuCD3Ii6XOI3xtQvA0H5NimI=; b=
	S4ASgfha8FUy/FKstHEaYgRYgJHeKoPdw9ZWY+Q8TmRl+JdfmPF+QofNKH1fJ2nm
	3r5SrrXUYZqDgzA8x3KhfyOIfbfKvcH8umcdEkcC4B3UFzSlBZ38xT8K+pLRsB90
	fd7KhgQNWgJvDt1FlUiRrFNxMGj6QL6TITsFTCCefXcOFnef3YbKzd146kNZKmy2
	VDGAYMV0ZInvf10bFGUc4NR2NWnZ1p/gj3VogGJYx8e8VpReZpuigwrOhZs/ao/B
	J07F3lM59Z01h4E64ERXYT6VI8wyENgS/2xwI85OtcsauXl1IrjNdRWg7K2MDw4L
	11apRh2Hkgsuly6mSTrFlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752612222; x=
	1752698622; bh=Iuvt+9i/0tmQzEHmrw/GuCD3Ii6XOI3xtQvA0H5NimI=; b=J
	sgQzGbIMtCYWJ9MIz6wTRL9MfHHDS7nuHB2OHfpMR6E4vWEuT0MidDyqsEgOFjal
	aG5lYZ0H5MrTOxEPfR5QUCH4S33CHhBuJmhe1b/nCFigGaoOtFsTotdUGmopq0os
	2e0s6AI5JwhGzOxzcPS6FePEIcVT4M90Ummp5mCOpbjj7Gc/HnOLelNAReZjzLcJ
	1H2Wo6zR8jmrxQWGmI5RS2kMIVETd4VFhzQ5SfNR9BPspiOXm/EPfk9lFNvve3fh
	oW3ScvWP+5HFf2sO7PjpOLEHJ1ajIibtj9puqSdkbInE95YR0Mvh3lVaCONVgtBF
	g7TU8ip/MGZ+g7HQUE70g==
X-ME-Sender: <xms:fr12aIqV5ZZ3JfVT5NIdcYlbE6zBehOEwsZJTDpSbTOm1VD67hn33Q>
    <xme:fr12aJO1PHnsG957-pKQxj8Y8HadLpx20sSOocSA6NnxxZimDUDs7BTcxjGSs35xc
    zCMdsM8uy55eeJBLA>
X-ME-Received: <xmr:fr12aJxvn-BBZVuJ-f3xqwSvfrtOmZp7XFVgOzIZmWpFhYDEBTBn-G_KZxY0pnN_Ow1t5PrpsdCkoRO4z4yzzLePd33lJwF4qGgx0Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehheekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgfgsehtkeertd
    dtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevle
    fgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhr
    seifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fr12aCvjObsp_dyDmqzxObsxI78KvP7kAMCym8I5STJjG0H_5ty1Ww>
    <xmx:fr12aC6p-L2FxkFsk6dhiQjmerMG6QMFg-vgrSWZcS2J3QXpOmN-BA>
    <xmx:fr12aBRwMq3bhgAMVPjz9jxXTiM7IYVGwDHLCDJeLjRW4tT9Vzt5bw>
    <xmx:fr12aBqXyNRexkny91e1y4LjKthA5FmeTMdQU_EgBRtZtsAPSl7Omg>
    <xmx:fr12aKbc4gqHqybL4KNjg1WUnM06TVpv4d6xviExfGKVz0--LRics22X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 16:43:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: use prio_queue_replace() in
 pop_most_recent_commit()
In-Reply-To: <aa89082f-34ab-4ec7-bdce-70f0a33815e6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 15 Jul 2025 16:51:28 +0200")
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
	<aa89082f-34ab-4ec7-bdce-70f0a33815e6@web.de>
Date: Tue, 15 Jul 2025 13:43:40 -0700
Message-ID: <xmqqh5zdgp6r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Optimize pop_most_recent_commit() by adding the first parent using the
> more efficient prio_queue_peek() and prio_queue_replace() instead of
> prio_queue_get() and prio_queue_put().
>
> On my machine this neutralizes the performance hit it took in Git's own
> repository when we converted it to prio_queue two patches ago (git_pq):

Given that our history has more merges than other projects, and the
_replace() optimization would help primarily single-strand-of-pearls
(and the first parent of a merge), that result is very good.

> diff --git a/commit.c b/commit.c
> index 0200759aaa..8244221b30 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -742,17 +742,24 @@ void commit_list_sort_by_date(struct commit_list **list)
>  struct commit *pop_most_recent_commit(struct prio_queue *queue,
>  				      unsigned int mark)
>  {
> -	struct commit *ret = prio_queue_get(queue);
> +	struct commit *ret = prio_queue_peek(queue);
> +	int delete_pending = 1;

Briefly I was puzzled by the name (I would have called first-parent
since the logic was "we treat first parent specially by using
replace instead of get/put"), but the variable signals "instead of
get to remove the item from the queue, we just peeked, so we need to
remove it later" with its name, which is understandable.

>  	struct commit_list *parents = ret->parents;
>  
>  	while (parents) {
>  		struct commit *commit = parents->item;
>  		if (!repo_parse_commit(the_repository, commit) && !(commit->object.flags & mark)) {
>  			commit->object.flags |= mark;
> -			prio_queue_put(queue, commit);
> +			if (delete_pending)
> +				prio_queue_replace(queue, commit);
> +			else
> +				prio_queue_put(queue, commit);
> +			delete_pending = 0;
>  		}
>  		parents = parents->next;
>  	}
> +	if (delete_pending)
> +		prio_queue_get(queue);
>  	return ret;
>  }
