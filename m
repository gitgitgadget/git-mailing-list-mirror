Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C621E531
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 00:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730852402; cv=none; b=Bcld5AIrpkDMRWrFTdBcDXoaVAEJFnOgr/4GlnILTff2zUQ4xgIqVbdPqZcFm+RQbhzt6qL+OjA3xy0y76hd5DEJUmaPxFtD55ZiHLK8+pZG2o+ZVcM0Dr3Tprjjo9E0UqG/LkbJUMzeGVH1edZnuxcDY8Br6AtXghF2IgVYx9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730852402; c=relaxed/simple;
	bh=S0PQQOUUp6030vf3MMdwhoTnloAaVgOK9BvP1PY0wTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YCQlak5d8ZRydUgrKY5+IbymI5F5a+dANCuBkegrNJpsnIb4rzNsuCXyoz7Z/nUPXuMXCmMQJH4ba6YG2fnJDVSQrVn7QTIg1JB683cx5tnggh+a9GlJI6R3vOa5yN9duyiu9DWl5/qqoBxCB4gqfo4SXZWydQFYKcBWMD4TJQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eWHtYGIg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jtltTCAh; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eWHtYGIg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jtltTCAh"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A0034254012B;
	Tue,  5 Nov 2024 19:19:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 05 Nov 2024 19:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730852399; x=1730938799; bh=ZMW3EhHGbx
	+9U7gevGEHKQzzlb+92uRtMeduGpZ4PHw=; b=eWHtYGIgym+LsiENMApLovFoyY
	ydYLZs62P4KCiNqurInVfk3TcLbhnV6Wwp8voqsgmfzV1xinFQTUv6lsJ8XUUDkl
	FCEq0PSTzD90YK3qVUdt3R8c/Wnf/I8kMW471fzjtNmxZkS5w1g8cDZFxWIUYRX+
	CLrmEzRiB78f4oh6PNljRCwgUFteRXajB8SOIoeTsDdBPFv2L5HpcE4wpsarYExy
	WCLQa5NnA6aUxf9wGiWQYQ6bdBcJSck/0tV+D4v6nZCMm28TQeWf41XL8uwSPN4E
	571uSc8OCAOAAbOp6ZSqWqv3SnQH8lTqpWxqNbxax1l655ihxMwWsoqmzltw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730852399; x=1730938799; bh=ZMW3EhHGbx+9U7gevGEHKQzzlb+92uRtMed
	uGpZ4PHw=; b=jtltTCAhsPbGNAZHJ/3N1eyd5Kf3fCHlXP0zsv1yxsPD3nv+05x
	4fboRxih+9ogodQHYniSBt1tU03UcS53Oe0nvHliPllWNTeD6rMPlNcBp4z1bSo3
	X3dvXs+b+uUoQK0MRYbO2W+aHLgMtaj0QNwb7mghf5vP2gRRAJsoFzcwD0eINqbG
	+uKLI3xLMUDH1Z55fxnDNUZ8bTER0V5tzQ+xMMfIgaqWrsI0Y2qePov+VDxqcQ9m
	bZH3nw1h8FKhasnYz++gJu7gyNrZ533D5bP/BLWHlBZADUWCiC+LgMlFDu9SYq5b
	mZQci5E+NR01mLxNJXatXxl+OfDJryu8EzQ==
X-ME-Sender: <xms:L7YqZ4UPXnw5LIUCg7wlNP8afu6cG9n6Ko3SNPTIvoux32vmwZWo5A>
    <xme:L7YqZ8k1kGI7OUrF7BY5WhTKWN-tWyv57R9J0tY-ZrLHoEPxo4xbfRk4LQL9LSpoK
    19C-XiTWv2XRQrcgw>
X-ME-Received: <xmr:L7YqZ8bUZWJDL506lIkqV-NKcq9zoayhcGiJ_8dMcW2pg9-PMlVY89te7-thZrjVJ1ogPApelMYljxNUlaZUJE8K7ReV6gxd0g1V>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvghrug
    hinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:L7YqZ3Xo8IF5oqB_szVUgGhlXjxXir5JZovpDuYCm6Oaz4NnCRNSWQ>
    <xmx:L7YqZynci8I0f64EuzULGU6_9VZlFT0qkt54ShozXNKh6OnGdwiIAw>
    <xmx:L7YqZ8cvDIIgTsb_V02kfgXSYAhy0n0aawZadS9Zyu7lYIVkbkXS6g>
    <xmx:L7YqZ0GzLmLaDNN8jerTKQVd3oc65XRqoOvZIyxecxPCcHJg4Vx9_Q>
    <xmx:L7YqZ0gnqrs9JNqgiL9Ko20HVJZE51K33y84hVaBZaA1_ifduC_joaeV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 19:19:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2024, #02; Fri, 1)
In-Reply-To: <D5EJL736B135.2ZP7G9GHUY0YL@ferdinandy.com> (Bence Ferdinandy's
	message of "Tue, 05 Nov 2024 21:54:03 +0100")
References: <xmqqr07rwsmd.fsf@gitster.g>
	<D5EJL736B135.2ZP7G9GHUY0YL@ferdinandy.com>
Date: Tue, 05 Nov 2024 16:19:57 -0800
Message-ID: <xmqqcyj9rz6a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

>> Thanks everybody, especially Taylor, for keeping things going while
>> I was away.  Unfortunately, we seem to have acquired way too many
>> topics that were posted and picked up without getting reviewed.  As
>> we discussed a few months ago in <xmqqployf6z5.fsf@gitster.g>, I'll
>> start discarding topics that have seen no activities for 3 or more
>> weeks.  Interested parties can of course revive these topics.
>
> [snip]
>
> Considering the above,
> ...
> and that this version of the series has been in for two weeks: is there
> something I should/can be doing so as not to hit the 3 week mark?

The "manual" to run the project on the maintainer side has this:

   - If a topic that was picked up to 'seen' becomes and stays
     inactive for 3 calendar weeks without having seen a clear
     consensus that it is good enough to be moved to 'next', the
     topic may be discarded from 'seen'.  Interested parties are
     still free to revive the topic.  For the purpose of this
     guideline, the definition of being "inactive" is that nobody
     has discussed the topic, no new iteration of the topic was
     posted, and no responses to the review comments were given.

If the topic has been updated large-ish-ly since the previous
rounds, it may deserve a fresh review, or the reviewers of the
previous rounds may find it sufficient that they judge based on the
change since the previous round (assuming that the earlier reviews
did a good job of hunting problems in the previous rounds).  I do
not offhand know who read the topic and how big a course-change the
topic took during my absense, so hopefully somebody who is more
familiar with the latest round can chime in before I dig the topic
out from the bottom of my pile of backlog.

Thanks.
