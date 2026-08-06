Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E236C9EC
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034561; cv=none; b=t0tkcSITrEjDGZrzwN2khqnLvvsFPhMq6azX0TpY/NZVF82Lg416dmkPbdXFPHVC8aD4sryMHYuwB1Og+8lx54BFLR8UKQweR1PtMtxQkZXMk66WT1DSGCKFZbVxJZbAW6wDcZWYqxTb4rlDjx7z4QaS1OkIi2QdL+Fu86V0RBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034561; c=relaxed/simple;
	bh=19NYEbo+rnkLrb8XrAkBNjjlTFKcTVXk4EAf+8/MY70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cfOr72JX60beK8Kg1qAc/NY6T0MZpAYnleh2BIUYnPqSpTh9jj+wgi8fgFu7KcElcJpu7tdHtc6rM+YXtCANEdESZt5+LyC+15qepac+BczDNR4tWaDd1oDsD7p+XzxmzToxqb7l5uonTYS1xseXWxTRod9PnnJJTrroQjyi0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WeBXuRcx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jZJmi/U/; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WeBXuRcx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jZJmi/U/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 32B917A0041;
	Thu,  6 Aug 2026 12:42:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 06 Aug 2026 12:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786034557; x=1786120957; bh=yMYNd9WTWj
	codcMEZC9zG6DHmorySTsRdR6EK/MA7/I=; b=WeBXuRcxXcnm5vDA/ZV4841eHA
	AyctDd3n9Q5EbGL/pEjjfbXzSrWPFAokjXN8yFPmqyHhC78SfKUnstK3V56sKcpz
	TTd8ngIrnHIZhD7doq9rNsLVUPAgngIgKaXotZlqd6trKs8B6AO5125nFlCYvD43
	l9roqqlQV9PnxTzi6RTuXNlezHEH6bedE4RB4hNrGCmH34s2VAKdqZwPT66u3YNS
	4zARMoTGVgxOzTH/SB/KzVwLUA/Jkevg7VR9BXATmYuijlPJc5mmmmtlakS177AU
	Ng/m4ZDQCPXDu1w60T1A17WZ5BFtLbA+jJriutyWMpO8hWLJufvGBt/Wznow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786034557; x=1786120957; bh=yMYNd9WTWjcodcMEZC9zG6DHmorySTsRdR6
	EK/MA7/I=; b=jZJmi/U/71aRLMI82a+95Gt4944MQTcUGpZ1SrpEHUi8/OweCKG
	pftqb7n7SI+gOVOUdkgIFYBVWYGnwCJtFh3L+n/5PtLhyevGtjkb2+eTU1tUvlTj
	u6UywZ1PAHWKhEaAGWMAGkzxPbLDu0iZq0LfEwu3x6IIg2Bq252jsAqR9Mnkx3vG
	XwjrJ/UfkyF7xPm+tcIchtng1lCSB40CK2zS9m4sRI3M6Prr9lpneVigyEKoO5sq
	PJrJSHylRi+M8Mdy14X+tGBlTQJS7pShUHoAY/4mdWpJ80le+jU9B90nf7GzKpBy
	yuuOdQpoJ9Ki3ghYwiLWjmgRD4/0tAQa2fA==
X-ME-Sender: <xms:fLl0aj3H5ikOIBb3SRePtMNtnNWKBAEMORBoNmnx07hgCffOUivfsA>
    <xme:fLl0alzk8Lcepip5B3CF-99PtjBy_vdVrCXbtXOGb5DXSbOJGKk7aKbFu3R5EWTxE
    PuJme8kOwsNJHCKTpr2_ImJkZ_tLpBy6QZXA80H9ZNz5MtvPKIfQ9E>
X-ME-Received: <xmr:fLl0ats9T1RR4rJElojZ9yAX2M0DZRnW134dqpebiRBNHZRb-p2_e0w-7P5HqVbuZo_pzn79WtaCalLFxPvIABbZvQ_CB91YlQ>
X-ME-Proxy-Cause: dmFkZTExVusNIji43rC7jX3Teatot9Ua5zZwskQtdDdLEW4hLBEuPRlL89c+F/arpJrCQO
    Q3PW51ud16OP4v9Z0Pa+5mnL22runXvehHewyuYOP2uhGLhLbniayQKl3TD88MahADjtrl
    apJc978r9d7k0hq8JoWMC45c1Uf+esiVT7bVwlkNU06/9HWBySbgYoZOnHIXQYYhKCOlu9
    f8zHFOnPyKvTnDgbxZVIveJXGoonuptUUfAdB1VZKOd54nUZJcDwDmT8D4Wk7RGwsWwQ+H
    rOocFW5qawauPK/yW8AAyRsyv/YNrs1VWYuVqJjYyyt2oYFwrQ5fZUImQBb7ONblObE5sD
    JZnQwguME/YlufuJipJB+GhIyrlesPvRyLinAUxBD0Wl6ZKwTUhszAhNngUR61iUMJTLdg
    BC8FCAg/oKCkFvPkHITDgGg7r8kb2NdYY3ZnGF68qq0PTjbMOr+WA0jq1rTpqLhdB28vK0
    KjnroRcUFCCtfwKcZ2gcR1QvYXIUfSswBkPvuUeqEDMTvZ5QwOKsXOJkQsKs92+E5a5X4K
    a9Plbk2ESUnRHguf93yfn3R+5Cr5l6N5P/BtTeYlz/QTxren3dlQjCpuFhP8Ix8ccolwv9
    TJV8mik14n3AB0p2SOaSgpYdcK1BmVa4Zl88uzwvU8mPr/RFs0sgmqTpaK/Q
X-ME-Proxy: <xmx:fLl0avyHIeuti3rOGl7F3_hn6mOrAiW91gSBIRQMMxQ6vlaIGNxJuw>
    <xmx:fLl0aoAdOYiE0VVntGhP18voqtDtsLTYCifw9SuFB2hwwt_pyewfQg>
    <xmx:fLl0aleuAhKmtEBkeNB9rjEzRfbWVTVRVJocfRgcTvuNxD1JC4Lmww>
    <xmx:fLl0aqnbAkzi-kiUaOBtpR4aYQSH92y8qju1JZVomAQgKukr3rjW2w>
    <xmx:fbl0ajgYE8qfe6Wulu18ONSyG9EbszqUUZsjCrDt8xv2xWDxx2JyLFg7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 12:42:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH 3/3] environment: reorder variables in
 repo_config_values structure
In-Reply-To: <dbcbb042-5c50-4569-9b18-3edcc7b1ef4b@malon.dev> (Tian Yuchen's
	message of "Thu, 6 Aug 2026 16:44:03 +0800")
References: <20260805115342.3939931-1-cat@malon.dev>
	<20260805115342.3939931-4-cat@malon.dev> <xmqqo6fgnssx.fsf@gitster.g>
	<dbcbb042-5c50-4569-9b18-3edcc7b1ef4b@malon.dev>
Date: Thu, 06 Aug 2026 09:42:35 -0700
Message-ID: <xmqq5x1nmc90.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> On 8/6/26 05:47, Junio C Hamano wrote:
>> Tian Yuchen <cat@malon.dev> writes:
>> 
>>> Reorder the fields in struct repo_config_values and its initialization
>>> function to follow the order of configuration sections.
>>>
>>> Keeping the declaration and initialization order aligned makes the
>>> structure easier to review and maintain.
>> 
>> Really?
>> 
>> Do you have some automated tool to make sure these initialization
>> assignments in the environment.c file and declaration in the
>> environment.h file match the order in Documentation/config/*.adoc or
>> something else?  Have you designated some list as the authoritative
>> source of truth to check these against?  Without such a list to
>> check the code against and a mechanism to enforce the ordering, I
>> find it hard to agree with such a claim that this makes it easier to
>> maintain.
>
> I see.
>
>> 
>> It is typical to list the structure members in the order of stricter
>> to looser alignment requirement of their types.  I do not know how
>> strictly it is followed for "struct repo_config_values", but by
>> spreading pointer valued members more widely with smaller enums in
>> between, the change certainly is making the overall structure size
>> larger by requiring more padding between the members with different
>> alignment requirements.  Not that we would have 100s of instances of
>> these structures.
>> 
>
> Oh, I overlooked the size issue. Thanks for pointing out.

I didn't mean to "point out" any size issue.  As I said, it is not
like we have hundreds of these, so padding bloat here and there
would not matter and if we get a readability boost by reordering
into a sensible order, that by itself could be a win.

