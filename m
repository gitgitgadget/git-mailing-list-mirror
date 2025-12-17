Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B71927462
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 05:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765947740; cv=none; b=tf3YLG9XKOwFsbNLMvGnCrOm08IBgXkRfEaj9FmEIee5K+w/mbmpFNTo+du1ySBtyooSjQ05guJGLx5jHBQj9hYMvnL1i9X44NbKueBWsdh5HSpU3sM+XITTtzQ1okhqjmTtFeQvYmUbJG2OZs5wQsZ+B0EYdKXuN9AR/Zv3BuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765947740; c=relaxed/simple;
	bh=U41aJiG5oV903XD2OtCgdaNyUtZtiWgwf7QyatBsXLs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ev+iOC3QebE6Srem/Qg83z7lMuV1F0ZcAfVEnc60+8FKfiUmDq33RYkWQuLRvyFWlDX4i8ydaKAt621kEl+aIG1qdEsPe+1KuP4bLgz1iVmWEP3bAIfCBp61BwOzKR+zIdaQJAJvazY7eknBdSAI79mGMRvDtRKcS/I889J0FZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YH9I9Db0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DuL3nDsx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YH9I9Db0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DuL3nDsx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 253C01400228;
	Wed, 17 Dec 2025 00:02:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 17 Dec 2025 00:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765947737; x=1766034137; bh=m1I+GzW1Zy
	+Twzb6BoH3ZUCW3Z9pA4dUAasmErSGrEE=; b=YH9I9Db0NgYDe02A3+AXqu/S8S
	wNBK9esItGlpJc2yKPqnvn655t8A6Vv35BRqR5rWtqCAe85Y68IAf8G8/obhE/yv
	ESEJAzLbdIhVmwDkB8ic5zZLC3XxKruDXDj+SHUgeY6viy11pSDLccAz7awSlyZ1
	K50qiOkerfksbp1SGtfod7QaxcjytP5YmJ0dGv2LrAnRiiR1X78+VNavd7eVZZ+R
	UA/ZV96sK7ilvcWuUNvAEf/3jGa60iSg2jOFYhrji41Qa5LpFHqriqywIHcYfADr
	1rfA/SlB/l/tWlzFqRLnfltbeNOaPa5QcK1nWmp5/YgHxqrwA2TPmmrzkdXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765947737; x=1766034137; bh=m1I+GzW1Zy+Twzb6BoH3ZUCW3Z9pA4dUAas
	mErSGrEE=; b=DuL3nDsxoHPhqxIkBgvks3Zpl1LmgI1j6bEiCku7Wxh7Luh8rGH
	++fInBXpRWKMc+gD/O1yHGFbVBlt6C4FXNZXpRaf8qXkKSeUxvNc0zZDv5EM5iuH
	sB0QKf489TN+c+Hhc3pfYt8MPm/pfBK7L5PDl7CldsfqN+ij1U6MDetiSaXqtZOJ
	/qPRUmKElZFJWE8uRL0y2e+r2vmaf2g9IIUkhnNcX9ZNvTlN4HiT055Nod8DCTbh
	o5SvAU/oI5+tonwitlgCofnre5MMj5m5ozw2lkdyUejMIq3sQhTw96sSBGIZzZvy
	2zYbDvGEXNJW0GUSfSyyfODoc9nvUQPmTHw==
X-ME-Sender: <xms:WDlCaVhnG8IadNJcTTxa0KIjqtS-nBSV79gl2LBVm5J2-K5QfO05lw>
    <xme:WDlCaRDR0jyPvqrrV5hsJaDTLhSoo83YEQ66L3t1utZf3z-XJZGlfjaaEUcy5TSdc
    PpM3zM6P5_r8o4gS33W5TMB3FTE-qPPfj0H_sQXkuWYpH1pQX0p0g>
X-ME-Received: <xmr:WDlCaaFxQVYpcsOs2G_TOLNrqpE7fwGLEuuI_-QOUMLV3LK5ocW7ZBY5h-uP0-QTOTxS2cnzKIcPtzkNTsy2mWYmCPeVZJMLAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegudeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghplh
    grthhtnhgvrhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WDlCaZIVgL3ZvU8OYhdh_DHgQb38jUYlLDnaLUIf08GjDn0MbP0i3g>
    <xmx:WDlCaemQw-7E4FRl6gDtSEcGUlOQxwnxcsPtF5yNT39fuSJCmoxhSw>
    <xmx:WDlCaRRX2FD5KuHZ82G-h_1evKothVL4H2WAI7ubgz1XrWtMhSCxdQ>
    <xmx:WDlCaQIftPAJhAMYAj1hMjAW3Nc4mAT9TzWAjGA6AFjDXobszEHcMw>
    <xmx:WTlCaQIvpwHMiZet7W8CKE8dU12fM3YfzgqRcg07PvPo8Xae58hPtFOs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 00:02:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2025, #03)
In-Reply-To: <93afac3c-c532-4183-a1fd-7e2322ee912f@nvidia.com> (Aaron
	Plattner's message of "Tue, 16 Dec 2025 16:09:30 -0800")
References: <xmqq4ipwc7y2.fsf@gitster.g>
	<93afac3c-c532-4183-a1fd-7e2322ee912f@nvidia.com>
Date: Wed, 17 Dec 2025 14:02:14 +0900
Message-ID: <xmqqecot3dm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aaron Plattner <aplattner@nvidia.com> writes:

> On 12/12/25 2:26 AM, Junio C Hamano wrote:
>> * ap/packfile-promisor-object-optim (2025-12-08) 2 commits
>>   - packfile: skip hash checks in add_promisor_object()
>>   - object: apply skip_hash and discard_tree optimizations to unknown blobs too
>> 
>>   The code path that enumerates promisor objects have been optimized
>>   to skip pointlessly parsing blob objects.
>> 
>>   Comments?
>>   source: <20251209014900.402637-1-aplattner@nvidia.com>
> Jeff King said v2 of the patch looked good to him but recommended 
> splitting it into two changes. I don't know if he wanted to review v3 or 
> if he was okay with it based on his comments on v2. The only differences 
> in v3 are the commit count and descriptions.

v3 did not have links back to previous iterations, and

https://lore.kernel.org/git/?q=s%3A%22improve+--exclude-promisor-objects+performance%22

does not even show v1 or v2 (understandable if the topic was
retitled, which is not a bad thing, but makes it harder to find the
previous discussions in a case like this).  So as far as whoever
wrote the entry in the "What's cooking" report you quoted was
concerned, what [*] showed

 * https://lore.kernel.org/git/20251209014900.402637-1-aplattner@nvidia.com/

was everything known about the topic, which unfortunately had no
supporting comments.

Is this

  https://lore.kernel.org/git/20251206002014.2066644-1-aplattner@nvidia.com/

which I found in

  https://lore.kernel.org/git/?q=f%3Aaplattner%40nvidia.com

the v2 discussion?  We are lucky that you are not as prolific as
some contributors, for whom an author-name search would have found
way too many messages ;-)

I can see that the end result of applying the v3 patches match what
was in v2, and v3 separates along the lines Peff suggested in his

  https://lore.kernel.org/git/20251208202812.GC216526@coredump.intra.peff.net/

so that's an endorsement enough, I guess ;-).

Let's mark the topic for 'next', then.  Thanks.

