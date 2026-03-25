Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405A2857F6
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468208; cv=none; b=B2KXaHU+fJ7hAPFo+eLh+0TlLaAgNM+mkakppehME2ANsysc/qxxlAyZAjmM9bCTy1KuOvLYbxNMAtOzA3sUfWWgKUc0qVWl7doDI9GD+hkc1kjm7YhrGkWZB0efWr9NWK0NL2/7IckFh3YKzYyIE2EoFHTIMTg8rqjiPNrKqDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468208; c=relaxed/simple;
	bh=5X/Ff61fPUyQq6jrx0zivmpN78sV37Godu9beW9TnVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iENImBOLC4eWQhO1uO53U1mRAOzbhQxaGVE5B75k4Byv4Y2vPr1GXx13zfdZnit/hAOTdbqpO+5MuhPq9KVZnrIMSiUjNcHtdy7uiuI+QVcCMxBTDsVP4M8zfUnqXMRIfs2/xpiNlTZOlroEHpf/cpuK8S6mD1zXCgYe00URFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=P5vJ3htb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OuSrHxvR; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="P5vJ3htb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OuSrHxvR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 08244EC0257;
	Wed, 25 Mar 2026 15:50:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 25 Mar 2026 15:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774468206; x=1774554606; bh=QyWx3ohPXd
	X+Zd7FdIbCj6LLYbNu+FzX399PIBCmIK8=; b=P5vJ3htbSNS40KBsZ4thlqQMkv
	GE6OoN+RhdPZzrlqMh2XwzBNOp6/UqNNadP4BdU9wJVDVFE8SZTcNUGe0LZZPJko
	4xtJR7ebT4AF5l+sh13gGBdU9nKJ0HJEvBtLortCeB287pg2nleZY9zPkb0scJlP
	vX1FgrED3HrPkhzJF3KXBNNDQxQ2QolDbwSBKr8n1jBG6KiGuAphXfMkbyZtQs8f
	TGnyuYJ3nKnSu1xb3XFFSdAz3gKZyjdHEYjcXNc7Y9rtKpCA7mbnvkIabAGikaO1
	FlqHmvYUfSFHO+wnddll0V3xe75gkrwz3BN9xMCDFZa/YLENSnCx44dwmlvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774468206; x=1774554606; bh=QyWx3ohPXdX+Zd7FdIbCj6LLYbNu+FzX399
	PIBCmIK8=; b=OuSrHxvRr4eY92AiZzBYz2hZh3ZvsQuUUhz88h/4DqeCMKoFiWx
	RAYNsVeSC6DpF66YMtMD/4Q7Ux6JwfNmJDMedSo1RuCD0YhZd6aGYaw5xMtIgXMt
	kxZ+frrh9ixlEHNczKkD+SJCQNjqhc1BPCOhaYR0m7K6DD8Ae/hr3kinUt5iTnK/
	8I9jjnF0viHukkBPiEs4j9porqlbX4tmngExtGBrx+Y4eF15FAVu6lS9PUpWqgFq
	gZf3yYJS2KlnKIOwNt8cd7VvbDbTO2gaJhPUuGbEDtDjn1/toluEOc1+dxFq9TS0
	v60c3LO6HxMA6XJHJOgUf8yXY0Fi9fKFnnw==
X-ME-Sender: <xms:bTzEabFHHQ-TBgJlSgTYby5MkGczI-eLNwrbdc4yLFPh83QyWYwUgA>
    <xme:bTzEafyD3gTCkQGt2y79hTYHHuAHRKh6K6UBBBWMtSzTh8AS-N3uAt1C7h5DGQWdU
    -AKepTKjEx4daHRHVAY7FOIh5hyCyT_bHO_YKtU6vMNBuv00lmvgZo>
X-ME-Received: <xmr:bTzEaaiiIGaBkrYocxXudLoerdyXkqZJLSTYruMW9YgqKxNIWxRPmkdwQTQf4SYSKmXjK8dyhhfjpki9_jplgz-c1F-JfhDeDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhhrvgih
    rghnshhhphgrlhhifigrlhgtmhhsmhhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:bTzEaSy1slk-YzHrZlVGy_P-Dwn4GqrukN3Ku9J1gnRwAGeo2OGQYg>
    <xmx:bTzEaVInzlaeYnzyngw5sOooso0f1xd3MXqLWS_3mPnoyjLIOlHVkw>
    <xmx:bTzEaRTrQ5PWgFP6BryVY7BsPwgz81-VYrBLeO9faYFfpGLiVmD3iQ>
    <xmx:bTzEaVoZYjXpKaRNn9FZfhGRKeQtdlXlxqMtwX6Xb05iOwLSPMkO7Q>
    <xmx:bjzEaTyBXrN2rSF_9foYFwP5aMubXXFjZhS8gp4VIZGIMBpvzHy0iJvL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 15:50:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2026, #10)
In-Reply-To: <CAPYXD65-LwXrZSAtGmbj-O4nW7WMcrJ_D8HtNtW5WZY2fLbGqQ@mail.gmail.com>
	(Shreyansh Paliwal's message of "Wed, 25 Mar 2026 14:03:02 +0530")
References: <xmqqldfgy1ye.fsf@gitster.g>
	<CAPYXD65-LwXrZSAtGmbj-O4nW7WMcrJ_D8HtNtW5WZY2fLbGqQ@mail.gmail.com>
Date: Wed, 25 Mar 2026 12:50:01 -0700
Message-ID: <xmqq1ph7u1sm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

>> * sp/add-patch-with-fewer-the-repository (2026-03-17) 1 commit
>>  - add-patch: use repository instance from add_i_state instead of the_repository
>>
>>  Reduce dependency on `the_repository` in add-patch.c file.
>>
>>  Needs review.
>>  source: <20260317155230.619378-1-shreyanshpaliwalcmsmn@gmail.com>
>
> I think this was considered ready in the previous 'What's cooking in git.git',
> so the status can be changed now.

This was listed in the new topics section in issue #07 (Mar 19) but
I do not recall updating its status in any later issue.  The only
change was in issue #08 (Mar 21) in which the topic was moved from
new to cooking without changing any status.

The only comment the patch got was from me about interaction with
other topics in flight, and there was no discussion or comments on
what the patch wants to do makes sense, or if the way how the patch
does so is correct, which should be the real review.

And I do not consider my single reading alone a sufficient review
most of the time.
