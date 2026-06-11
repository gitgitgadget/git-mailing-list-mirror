Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED373093D3
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194098; cv=none; b=jaJC5afkdEV41roq5ipxP8Vu5HkCkAZkAmjA3biX4HsWVSgMtnh35CupsvVvV16vEf8DDVo0ZFWBQ4zDfTpPxubNStRrGeKMk1Fu8cltGTUd8DbUYWRnywXCA+ZOeHbKjStGamhB9I9uvET6msaUyM48oR6rdrbylGiYPu61+xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194098; c=relaxed/simple;
	bh=BFiO9+/Bj6Gfwormde73XWWY+O2oHpm4xtpOfENMEbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QSldYUXsJoJKZcTtzagPQ3Z7plz27v593G3nIb6DJGmRK7bDnOWT22mcC5N++KWgf/vPaSo6XM1lBsm4SSYViaKDaFOy2dDYYaxopTdaD5igaOhLB9f2gryLu96St1SKVVFX3LhS3AwyXS3NPy8LgG/EvyKdyvrkrffVoN1ZtZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fkl8kVW7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qd7Jez2Q; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fkl8kVW7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qd7Jez2Q"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5EE0CEC0148;
	Thu, 11 Jun 2026 12:08:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 11 Jun 2026 12:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781194096; x=1781280496; bh=aj59v9WGWH
	cazkD6ZEnlkpvKOiUYwLcL3IFGRLqc+FY=; b=fkl8kVW79FDoYvCmZ6MocmhwRW
	pWe/0wFN1nhWMdCS1tZMgC/fMWdUIX7LdPJDAlfwskEDTLyQ6EZcqFEKFAeDWbPV
	6JOIFbnExclULI/dyzxmwgVPOPA3S7qJyvsVG15Os7pEuSTSv/uojyBG5ejVHwgX
	pKhkpUxzruKRhWB0RWRKKD1JPv27annqwT5bLuQCTdLkYo81KA8ZuHEcqajpcrw5
	3lIq+ZTvQiXTgOJzheOqjRJc0NQUIT/z654dTHCKF3H6Qztjj2QsFl1dGcSYID7S
	lHx2E0G2DOuiBEn4GhXEZFoN9UpyLHtpCRWbEFrjC23wS4Zj/lMoHR6TV8UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781194096; x=1781280496; bh=aj59v9WGWHcazkD6ZEnlkpvKOiUYwLcL3IF
	GRLqc+FY=; b=Qd7Jez2QBhu4r6nKh27ePcVUgOHq8qm9pgHguNZyn8Q2zayP2Gc
	y0tOib8otu5RilysD3QxKdmYoNn3dQZiexfidAkH3g0+ZqsffP1/SNZVqNdW1gIG
	VcqfnKK/EjJ24QAPVlPP2ctKxz61izkb+NEu8vnUajLlaRqX1HAj1ke4/leSwLDy
	ZJPm47ViVXgMkuV6kWGm1bPA9T7EP8NdV8L36o/Ui1fF1dK+VurMNGsMT0u8EYux
	XTcgClJ2MCYouN55dKkCBD4wDe9g2ZG92/ZhPVaYPipyq/VDd1dL/I5NOpixyfTs
	3hGxJ+RvtP7fWpDze3kgoG6E6zhpAP2aAVA==
X-ME-Sender: <xms:cN0qahLrA98j22QSlgH5NmDCzSXNyaF8-b9AaDWza0uOlIn4wxrGfg>
    <xme:cN0qakApouUjPkId3_ITJNo--trWFqIT9QligPGijhmRWQfAysO59cV4FDsaZYWA3
    tHYiTSRKFrgLlhg_n2twmXPniHoL5MtwOXWibAerjVgOoqT90dk>
X-ME-Received: <xmr:cN0qaiCjLaHZSuxwvLC4o9L4UcG7ox_d_VlQg4oqEFTKKTIludTOihO3RXx-YI6yjsmAFvvbJVSyKKppHbhPV2AtCYIqYNX-l0ZR>
X-ME-Proxy-Cause: dmFkZTGw5vShyKJT9Mx4mCXkN4Z8bTm5Lg9oGiyrPjeSCbQ5IwF4cH3eJgXdKj/4LOpgQw
    GvjtjlKcUN9dUQoClejtOIBtdUL4IJi5iUyUuwAfBqFuEosy15P/hCgHhgPrFUQCH77WpR
    uDZTjht5bez7bmyCBDmw6TvlqqfzF6VKk7Ihbom2xD57rYg+mv6s48p2JqPQ4oPvDpBAHT
    5nahMc0/ivL98WCw2y8la3tXFxcu04vC9f9+96C2HYs8UUU7x1VE1FriX2L9yXycnkOGqv
    IuANr+xznvr+EyduCT44Pp66xXEG8fG8kvMjnthZJpg0IU2ruvuZ+AvqQ6dBPoJk/FshfQ
    QvYK8O7blo8xR0HhP9qfJ40zsS03gN2Dp8hy6yihKX1Gl0qRVkXOxqr7xDufMr38rm1jVs
    SyvQ9lUui0h6A19o+AZNiSY0AaORXxL4LUXF1rYoz0KnUETYg9etYKv67Vb0KygPVjZ1mF
    Z3deBuau3hPboXX9FtAApEOce8Ojzt95PpIwTYQiCgcqX9ojAq4JoUzEzViaQ0VGzFyVn1
    xeRzi20DdInI798kdLyk3GkteTAyU7m8EKsSUUsm6N01GXrD1Fhq5PUcmc7S4sgo2Ktyh4
    XuyqhWoCpVanJjQofAHMkVwe+8tBBQhWQ8/3Nh7LPiwU+2axIJR3DH0+6tNg
X-ME-Proxy: <xmx:cN0qauBeHkh3kI2h1PMSUWgcka90Llzd8sfE6GfPqHoOtCBVNzhUIQ>
    <xmx:cN0qalpiwenpjV2nFgHvgRr40UpROg9MtIdJWB1Cr7lyaEJLG_dA8g>
    <xmx:cN0qagkWqAC48_-EuvfJXl7e7QeLR3_e1swZuctFxUWMT7335aGXhg>
    <xmx:cN0qaty_4r_-OFxJZddVZCNwpBE70jANAJczDJkzIs_8M5OhRE4iRg>
    <xmx:cN0qahQZdIod4CsLUsjFwpg7opjeb2UJd-O9KnI3YdkE36--KJ7BSiYt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Jun 2026 12:08:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 2/2] status: improve rebase todo list parsing
In-Reply-To: <4fafee2c-4151-45f4-a842-17d6b77d951c@gmail.com> (Phillip Wood's
	message of "Mon, 1 Jun 2026 16:20:23 +0100")
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
	<cover.1777648598.git.phillip.wood@dunelm.org.uk>
	<b80bc1e0a298e2773a2fdab3e73651d59b8d39b7.1777648598.git.phillip.wood@dunelm.org.uk>
	<xmqqbjdwcsno.fsf@gitster.g>
	<4fafee2c-4151-45f4-a842-17d6b77d951c@gmail.com>
Date: Thu, 11 Jun 2026 09:08:14 -0700
Message-ID: <xmqqqzmdoya9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 31/05/2026 01:46, Junio C Hamano wrote:
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> 
>>> +static void abbrev_oid_in_line(struct repository *r,
>>> +			       struct strbuf *line, char **pp)
>>> +{
>>> ...
>>> +	have_oid = !repo_get_oid(r, p, &oid);
>>> +	*end_of_object_name = saved;
>>> +	if (!have_oid)
>>> +		goto out; /* object name was a label */
>> 
>> Can there be a label "deadbeef123" that is unrelated to an object whose
>> object name happens to abbreviate to "deadbeef123"?
>
> In theory yes, but I had assumed it was so unlikely to happen that we 
> could ignore it. If we want to be more careful then we could add a "bool 
> maybe_label" argument for commands that accept a label or a revision and 
> check if "refs/rewritten/$object_name" exists before trying repo_get_oid().

To me, how rare the possibility of such a bug happening is of
secondary importance.  What affects the decision more is when the
"rare" failure happens, if it is immediately obvious to the user,
and if the user may be further harmed badly if they used the wrong
information given by the tool due to such a "rare" failure.

It would be a huge plus if the workaround, when such a "rare"
failure triggers, would be immediately obvious to the user.

What we do not want to see is that the tool to create a wrong
result, cascading into more problems, silently.  In a sense, it is
even worse if such a bug triggers only rarely, because it would mean
that the users always have to be on the lookout.

Having said all that.

I suspect that the OID in the output generated by "status" after it
parses rebase "todo list" is merely meant as an eye candy, and the
users do not _use_ it to decide further actions based on them.

Or do people stare at "git status" output, find an interesting
object name and go "git show" on it or something?  If not, then even
if such a failure were not rare, it would be OK.  We may however
want to record i as a limitation of the current implementation in
the end-user facing documentation, though.

Thanks.


