Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F43B05BD
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790311134; cv=none; b=WpKJLNguQ+6+K6LHs8KHk7V+3QynqdNSW0qOmKUk1Dkuk3OxU59IPW3wup0qhn0+k1XKwwsCKgfwaMt9D6R5hut3cu1U0dIu4Nlo1nleZjQ20qR59Ez31QgdacWl3RjRWfTNMxTgYOH3JQacN8OUuItyeB+hoqJce6HgklL3vL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790311134; c=relaxed/simple;
	bh=14b37RYq9pr80WlJCsXoLQvmagVTTqpmNW0dzilOiuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FQI6vuduX3nMh/ShnILQNKZxRckAk+03Ejopr3uHfEH9ZxLsw3Mt/bYrutbwzGo4dg65SWnGJ0Dqp6jejjlVmhNSh9hOBuEJdyPg3Fjy0Kihwpgd/J1caTeltjlZ/lbgNg6DETjbqwWj52BqAYwY9mK0eeLuoWCtqE9HkeIG6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WjuYWNDx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I2MEgmal; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WjuYWNDx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I2MEgmal"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 533C57A007E;
	Fri, 25 Sep 2026 00:38:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 00:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790311128; x=1790397528; bh=b6AcF4xUFK
	Ltrl3WuAtB7tg5DIfkrOZOAQeIPRJ1F7U=; b=WjuYWNDxxKWnxC2C5oRWeAuQmM
	k31pJxAPP004I2G9wEOKPm3an+JGVe+bLzv1dW0n76UxTks/nvDAfCz6oBjhggaX
	+ceY5PDpmOgNsZHm/IbTg1x8LwPAy3MHrQQbS8qZszqbaHcnjG0RPjnIQB7qXZU2
	XZBJjxchIxnTYDVpGpFog8QtomJo4Qm3k89Nx5lsm3Vb3AHyknjfHQj8qZdcO/d3
	VoJ9HuhVBDhYFbxllNRBqhNonoHaN6I3gm+9A1shmodw588n5xZs+8x5rHbsfemy
	xtSPlP7HKA9WRqRLLqH0l9JJRFBXbXNzmf56Uub6WtSnmtk7cFBU/O8wqdTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790311128; x=1790397528; bh=b6AcF4xUFKLtrl3WuAtB7tg5DIfkrOZOAQe
	IPRJ1F7U=; b=I2MEgmalPgYSjSeUwe4EWbYYMss+lfhw95D4RHfEqxsxtC3hN4T
	//nvNBr+rb2Hg7coJ7LD0x6lQeMnRT8U4BHPvAn8HKTgvwY+/JHLKxFkZEgeimgF
	cKZdMKOfdtZ3UlHchZ8z0zlOpccFxoqeYBQbFhNIGa2+wWYwl9Q86eceh8OBp4Ai
	U+2pniPuEs39TjNRuKvkNjnsnFtpdh0dB5n7WrAtN8Acd3C79u1oheDoebqz3wI1
	uVmCTVXCG8uF10b+/HoA8ZVDuxgDzxkZEtJzM9BbgFirRXs54Hdxs79Tzf/BOkEi
	YjbOTQ2JB3yEIpRDLARMMZBJKbxkgoVMrAw==
X-ME-Sender: <xms:2Pq1ar67X1AR59LjU0W2bk81aUl_tbq7TzIfs9ypYm-O3q0WtgTXUA>
    <xme:2Pq1an5kxnUz6lLYWYxjZIZtVhJl8qT4qp-VIk9TBmZ650l4P7EKX_dDgslAwNeA1
    q9QSmyFwQZ0tzglPppnCmhN3JMv7txdvaGgTLS85x2cb-HqpExeo7eW>
X-ME-Received: <xmr:2Pq1ancL1LlzOUd3tw9Wf6cVu_W2MhD5iyIJEnPrvSFWX491_b4HbHBLRQruwpk53J7j7NfL-gZ0BjlsiZYLOy_DMHW4kW0Tpmyu>
X-ME-Proxy-Cause: dmFkZTFRC13vW0FkmnaTJrsvmWibymmPWYz3J8AXLkPb7H/7KjjuaXhzncOBltCEKcqqV/
    Kd3jn1GjoaoplGYljRyAdyogieiwAq94Y9RyeeEDH8B1+aTPROJGfjurLGy6RCKLzYbnSx
    qQJ00ufavoDnjTSifzu0NkLhxlSLLDTeNSUQlyNJKGgvnam1mt2c0U1lNx+x2yJh+ZO+t2
    TedwUOd5iW5xTGOLbqtniFPmlsQamJwwgYmO8Ch9n94PTW3BMhGOzVLnqKZy92aLPHwnMl
    eIo7jmUgdyOAicsNJ4JDsZGjviq7O5CdqH5TVjaDvvFT50mj1OHgTLwqihbCQFd9EgHtGu
    6/1ki0fC/zLmSTRy2nGdPHFFUmsJTsC+lcTCIxQO+9JjTip6so6nHrjwre28BukZI5ZptA
    F8i5QZAoO9Bn+Y8MWBKDag7P3rR5QkxvHKvj78qMyc6BYltYH9yumw0272bsn/q+1ze6Pv
    5N8ih9XUXKNT9i40B4kP/aQts8RvzVMShrXhwcKC7pboEgfGBTP0QAfJZfYzPPpktqCqMi
    68FsO7JBANnT6PqqxOTb4bLx7tl+mGW3iUsO0bwgRRkhNieeZJpt6Lc8PBSPCTxbehWKE1
    RoaXEO2CjgbPFTResP9yd4K4Bwu50dof+3+lQ5qIk7DJr3JaeUVITCNMxelQ
X-ME-Proxy: <xmx:2Pq1arDZaT7UedSX5B5eXd0yAy6iPjrxsbgAeyQnPY60zN3X7Xy_nw>
    <xmx:2Pq1aq8FJ6hOWcJuT3PpGqAKj3iGPlpdRUEuAMJl6cMWmCeI_Sv52w>
    <xmx:2Pq1amLzovXwQbtx-NojDvoPI5RnXZntI0fr7se8VO24lErHHp_46w>
    <xmx:2Pq1ajjATt9bOv076hfq9ynoGiPill4jlZn8ZjNfRXHZlns6qUgrRA>
    <xmx:2Pq1akDdSavJbxP6emPnp2yLgSKIiNJOx-L49cKUcCVGVf1kLYxzP9-h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 00:38:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Brigham Campbell" <me@brighamcampbell.com>
Cc: <git@vger.kernel.org>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v3] git-contacts: allow inputting patch via stdin
In-Reply-To: <DLO0S0UUB0EM.1NLQFJUPOMGY0@brighamcampbell.com> (Brigham
	Campbell's message of "Thu, 24 Sep 2026 19:51:52 -0600")
References: <20260914-git-contacts-stdin-v1-1-9ac628e6fd20@brighamcampbell.com>
	<20260923-git-contacts-stdin-v3-1-56dd43c64d56@brighamcampbell.com>
	<xmqqtsnf477e.fsf@gitster.g>
	<DLO0S0UUB0EM.1NLQFJUPOMGY0@brighamcampbell.com>
Date: Thu, 24 Sep 2026 21:38:43 -0700
Message-ID: <xmqqfqyyx7vw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Brigham Campbell" <me@brighamcampbell.com> writes:

> On Wed Sep 23, 2026 at 10:13 PM MDT, Junio C Hamano wrote:
>> Brigham Campbell <me@brighamcampbell.com> writes:
>>
>>> $ git contacts - <patch
>>> $ git contacts patch1 - patch3 <patch2
>>
>> The second one is an example that we could tell the command to read
>> these three files in patch1 and then patch2 and then patch3.
>
> Does the order in which arguments are processed matter?

It does not matter if the order makes difference in the end result,
because my comment was made out of principle.  I would not at all
surprised if the command gathers information from all sources, sorts
and then emits---in which case the end result won't be obviously
affected.

