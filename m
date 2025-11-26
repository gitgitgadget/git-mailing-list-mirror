Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9830BB81
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 21:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191587; cv=none; b=a5fac6122qMdK7af3KzoaroH8OK6OLkp7ViJ9FWYPYgtXxN00tjCAhaJvNgfbJbueN5RfVnfRtC9pLckcqPxpi1HETd7qHIgjcB75d67XcPzKCyAJwMaShQXEhzSrTsoohIX/38EWOaxWHOakRrBbM0yXt39b6d/5gAB98b0JiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191587; c=relaxed/simple;
	bh=DnW7leDcrDiu0Z3ni5RWMEUC/MScDViC6NK6r2FXK/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2dowBPZBrp1g93ZCjDFuvU2RBAd5fUkDFxnl3LWTeTWOpHvhk60vgZ0JJeK/48wMjn2ejDfvcTGuZQ0Sy4eRNSTXRBFk/8s/hlwsxRmdyqZNECG4jcDYrDaOaj8YPVMYnI9jmd5bawtbAclPnxsFdFCpipFGd1hRy/DxSGOZII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UtphbGW/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UrEHYxoW; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UtphbGW/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UrEHYxoW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E9E521D000BD;
	Wed, 26 Nov 2025 16:13:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 26 Nov 2025 16:13:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764191583; x=1764277983; bh=C9FthNBfiv
	+jhQyPlKh3GwaJs8KCiQct6VNKcnadMiE=; b=UtphbGW/x7G/il5Juyl8TXhL0Z
	eIotPV8hXVvveqpgKVBRQGb4ueX6tWn2qWUC5EySXeENDc6WQG+qC8Rl7n7DNMFL
	phI20TVQHw3ZJTpEMapRblzV33jHRTOKmLO5TPz3rfXbJ1WBnO5gQW45oTcTRCJH
	b14lfSWQFDhE9vbCZyPlhM/E7ab4QbsTjsBlqrHUl+h6XAjg01IQPNgaZQ6bKiKC
	oSAtMPBByJISzJldHPGbTas2s6heMXrDsI5iNzbuZyIsgDvDc3UD1kddaxBuBiXb
	OEOOzBcgJEnYddvO4VHL2qLujtRVJ6+u434rfxU7UDijRN2W92uFAZZEVdDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764191583; x=1764277983; bh=C9FthNBfiv+jhQyPlKh3GwaJs8KCiQct6VN
	KcnadMiE=; b=UrEHYxoWYieR9+L9QKIqnBPlwK5W5c/8Dj/syqEJtQBq1a/Ikug
	l+HXDzS53Y/i6G8yUrdHLQet3tkJp+8W5YII5XGBaTxdUX9oR9jtTRbUX2e/56fB
	U3cwsHnx30lIIxC+i5iJiQ4u/kPRMsqrGhecnkdGnUiIxrjcfesUnY8M1BUBijw+
	+gpG6AOe8sFXu4cvo/fRUDlbAELpyQonQiWZ5UV/gAMfzPxfwxfIv8KxVWwYBziA
	5eDLMLowHGZXz0oBuHXtFv/D6w02Z61i9rJXl7mO+QTTLlOSl5ZOQZvBWibhRkKY
	W6L8rmIAbTh0T0kaQyors/mlCGsxOZ2rBwg==
X-ME-Sender: <xms:X20nadkTS1IvN03CxkxTFJCefJ9S7x3w-rnTIbYA-QF7_k4ER1hdhQ>
    <xme:X20naTN-DX-3tC3vwsjX6etiimShsAymWPyHisIkXkuqKnUusGL43Uyu3WQH5VJnP
    ZFX3KRZ31T7JnxvRXX4iJS7dS7q-03_Zzl-F-WscSQpFWEz-E5BNg>
X-ME-Received: <xmr:X20naZwt63XmNTVG0UaR1b56iyOcoI_E9GW4ucHwzhNEfWYJow5aCe0OJQEaY50asMOyXSpwcFHI8F3lbbkAw6nNo7cy6drg5oDL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeehfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:X20naYu3U--wbeqnUO1PBurDzP1vK-hl7D9CE4KsCd7c4oeLXvovGg>
    <xmx:X20naUYN229b8nQzhl4T4jFJaejk42PzjvSR8bPfVCZaZY2B0HvYCQ>
    <xmx:X20naf39Y5K2D-iBu0goaySOlTdT9x563oZF2B-JJuJrurxHp7o4Rw>
    <xmx:X20naevi4xZiP9QABa_dU95uaJ9Fa59U7yhQhAVI6Uq7VD3BMYgFQQ>
    <xmx:X20naXSpBXKJg7HaP1xVn55HDnIcki5Mh2EM2JMa8LqBrfTrjVNNbo2X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Nov 2025 16:13:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  newren@gmail.com,  phillip.wood123@gmail.com,
  phillip.wood@dunelm.org.uk,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
In-Reply-To: <706e2875-a3f9-447f-9f43-690990a2342d@gmail.com> (Siddharth
	Asthana's message of "Thu, 27 Nov 2025 00:56:48 +0530")
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
	<20251125170056.34489-2-siddharthasthana31@gmail.com>
	<xmqqwm3drk6m.fsf@gitster.g>
	<706e2875-a3f9-447f-9f43-690990a2342d@gmail.com>
Date: Wed, 26 Nov 2025 13:13:01 -0800
Message-ID: <xmqq8qfsmraa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

>>> +This creates new commits on top of 'main' that reverse the changes introduced
>>> +by the last three commits on 'feature'. The 'feature' branch is updated to
>>> +point at the last of these revert commits. The 'main' branch is not updated
>>> +in this case.
>> Is there any topological requirement between 'main' and 'feature'
>> branches?
>
> Yes, and I failed to explain this. For reverts to produce meaningful 
> non-empty commits, the commits being reverted should already be in the 
> target branch's history. I will clarify the examples to show this 
> topology requirement explicitly.

We need to be a bit careful, though.  Strictly speaking, what we
have is not a requirement on the shape of the history.  If a topic
that was merged to the development branch gets cherry-picked to the
master branch, and then it turns out to be faulty and needs to be
reverted, we can still "revert" the original topic out of the master
branch, even though topologically, the original topic is *not* in
'master'.

>>> +		/* For revert: swap base and pickme to reverse the diff */
>>> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
>>> +		merge_opt->branch2 = xstrfmt("parent of %s", short_commit_name(repo, pickme));
>> That is an overly long line (sorry, I notice these things when a
>> line does not even fit in 92-col terminal).
>
>
> Fixed in my local tree by introducing a `pickme_name` variable.

Just a line-folding at an appropriate column may be sufficient, e.g.,

		merge_opt->branch2 = xstrfmt("parent of %s",
					short_commit_name(repo, pickme));

>>> -	free((char*)merge_opt->ancestor);
>>>   	merge_opt->ancestor = NULL;
>>> +	merge_opt->branch2 = NULL;
>> Not a new problem, but what is the point of setting these two (but
>> not branch1) to NULL?
>
>
> You're right, this is inconsistent. The intent is to prevent 
> use-after-free, but setting only some fields to NULL is incomplete. I 
> will either set all three to NULL or add a comment explaining the rationale.

Is this the only place that resets a subset of merge_opt members for
reuse?  If not, are these multiple places want to reset the same
subset of the members?  Perhaps we can use a helper function to
clarify in such a case.

