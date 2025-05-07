Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4C35280
	for <git@vger.kernel.org>; Wed,  7 May 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638420; cv=none; b=XuObWs4P/MR2hMKVYVF0mM6dIYKQDMQKDKRhOzI3Emc8rgMr5a8ib+iB6MxTVhx9boX2P6Y+sgp3uI1Z0fwuB/cb+XuDNbQJluYED1dyck6XJUwvMB5kU0hCBJAY1fPi1QybcKiBZlZIWRFJtuIFJASkZAXZrMeZT7l+dKEBESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638420; c=relaxed/simple;
	bh=8LP/tHJcyb9RHKFikJMZPz/x6SFiVLjaswtGpeXuT30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qm4vqH7GYfsholUuhmS7u4JLzwdaGXR3zBp5LXMHPl52v/Ve7Qb6qJPpzpOwPtR4Rj4c7K+b8zmEuYnj7BSQ6Awr7CVXdDEWCwwjK9qimvwD0nESI+jJ8q5EmBWgAVdZOadEdttzCYP7dtuEP+fzJOmz9j9pNUHmFGT4LBgs65U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z8g3oguH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+JyWWyL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z8g3oguH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+JyWWyL"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6A203114019A;
	Wed,  7 May 2025 13:20:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 07 May 2025 13:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746638417; x=1746724817; bh=lAYaMWKI6F
	vkRUJVJcaeUI+/KtHSQ48lydAzhG9lY/A=; b=Z8g3oguHpTQHIlmbN3cYTSm/9F
	GbM5uOF4IRF2jD6YJIXTsMU1fffqHB0JnqlRyIFSWYiRNfF7HG4VcihXD+3HvaQR
	kr+I4Tbyy42kGm0RLuP0jyJs4iDeXLf9SUy2cGL/mTFqn6/mc7gZ5i6i0mblUk48
	8/2CpYDYi82UYnJ9W2rfE9Tl46f72VQh9B+1WHgemRoD++5TDcA1DCDZfZgJPcpk
	96D3HLRgw4CfTbrKL0KnAY+PxtyrMi04DbR/zm4JgRcOfSUcAH/+1NgvRk//ZyQy
	ftOsawkIb3FmWPhN/F3pAocn3rum8dQtpmBW3qavpbAb2VbJ0tnjx+J0wiGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746638417; x=1746724817; bh=lAYaMWKI6FvkRUJVJcaeUI+/KtHSQ48lydA
	zhG9lY/A=; b=Z+JyWWyLn0CngX3blJ9+H1LM7I1MpjM6g/0suP/si0TYRZzPxAj
	Jzi0B08UB8WyIIcv84AcXpSxBY86jrvFgwuiyeu/3lrNM5BhCjLtDOQjyJcJiSXq
	+ZmaROJbO9E3v9vFS0PczU4Krs7eWgMSj/ippb0SxcZ6RiNFe/dD2T0G8N27m0Oc
	fY/iyWUCKgMmPJGL49b9aHO7dydFaCfyr7AavEIvD/bgbRm7U4u0uASiGzIb891S
	ebzsy2GBVIZRwW1+2Y76hHSXruobLsol5zRVJXM6ZUBQyWoFLrYUNan4bCDyY9Jg
	FrOp6vZ9BxMppBArwmzd/VlKrkobrb7t9VQ==
X-ME-Sender: <xms:UZYbaNUpPSF2NTPClVSHw6GvZIdbHBI50Cg8ardL3DG4OWyuxztV0A>
    <xme:UZYbaNlJ8qh6T0TRvgvPeLfGHxGjbWzJM7uAriEYuB7TG02LLqnfcgGBHzhlAigLz
    a0w2HqprUmiUiHWcw>
X-ME-Received: <xmr:UZYbaJa_7tYVLoNcf17p-SPFTJv4MLLVdH-MFP5LbXLwij_noV-0PCgr0EBAT9I078TpcmyHMCXX10eGBDHChjJmO-IvRljpzraY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:UZYbaAXD8_p6IHss6HCg1_6TqTZQoGkPaPIvjxRF2HCxwqkMX71euw>
    <xmx:UZYbaHlL4DWZNM-A0ORFbW47m9PcbRrZg_wNRO53Ekod-d2pPLyrAQ>
    <xmx:UZYbaNd0wXYxmXbY6wsBr1ibv1UCKVEtcaVfugd5TzX92AJxSTSAmA>
    <xmx:UZYbaBF7KfpKmjzqKp409whQQA61LgBtndf3POe5a5SvWstuilg3hA>
    <xmx:UZYbaA1IFepeDElhXEzFXpTOUNECr3RWALPAlaxBI363z6pesqfj3MjA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 13:20:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org,
  karthik.188@gmail.com
Subject: Re: [RFC PATCH 2/2] builtin/receive-pack: add option to skip
 connectivity check
In-Reply-To: <aBtgBQxv4_NanE-r@pks.im> (Patrick Steinhardt's message of "Wed,
	7 May 2025 15:28:37 +0200")
References: <20250507030249.4802-1-jltobler@gmail.com>
	<20250507030249.4802-3-jltobler@gmail.com> <aBtgBQxv4_NanE-r@pks.im>
Date: Wed, 07 May 2025 10:20:15 -0700
Message-ID: <xmqq5xice3sg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, May 06, 2025 at 10:02:49PM -0500, Justin Tobler wrote:
>> During git-receive-pack(1), connectivity of the object graph is
>> validated to ensure that the received packfile does not leave the
>> repository in a broken state.
>> 
>> Generally, this check is critical to avoid an incomplete receieved
>
> s/receieved/received/
>
>> packfile from corrupting a repository. In situations where server
>> operators validate the connectivity of incoming objects outside of Git,
>> such a check may be redundant.
>
> This is a bit handwavy. _I_ know why we at GitLab are doing this, but
> other readers won't have the necessary context to be able to judge
> whether this really is a good idea. I think the important question to
> answer is: why does the server side want to perform the check if Git
> already does it anyway? Why is it in a better position to do so? And why
> can't we instead have Git itself perform it in the same "better" way?

All of these would be interesting questions to be answered also in
the documentation patch (yet to come, I presume) that warns against
use of this new option by mere mortals without thinking things
through.  "Unless your receiving end has such and such facility to
ensure that new data taken from the pack stream really makes the
objects at the new tips of refs being proposed by this incoming "git
push", you'll risk corrupting your repository" or something.

Otherwise, I think the cover letter sells the "feature" nicely and
in a convincing way.

Thanks.

