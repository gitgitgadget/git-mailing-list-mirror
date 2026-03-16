Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C2C313552
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675354; cv=none; b=D8G4/HtSJlpoIja8JOVit/2WZ9YGVLFxl+SWDWBxQi/lggOS3zWQ9h8xmcx8ZZC05/b4zMI/EKXD8SDKsDu4+v6a7gJXlrP54dhBR1A9N+YKxyujhzba/sMShYnuN+3zZfgWIp1Oq08wm1gXDtgnUJ0MhNuaDk5o0K7ve/C39hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675354; c=relaxed/simple;
	bh=qzTlBbQqmpxrv3SLJ3BVwI+63wXWwkCbh2krceLDi4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LwnvX+YwSU8A7HD7ZE3nyv8ffTgQywwVF6uR9Tk2osg5UnEQPKz51zyI6HVrRknnQgcs6IpVy9sQt7JSImd0SEFlzrNwVl1sXfreRQpyhHn6gvnm79MIwksS3p5jxaU75HW2cqh2XXTRD5QW3iVo6aHZQDOMzx6N1+hOL84ccps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iWjqYRPG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NooFH8Xq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iWjqYRPG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NooFH8Xq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0AA8614001B0;
	Mon, 16 Mar 2026 11:35:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 16 Mar 2026 11:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773675352; x=1773761752; bh=QuWE0gvz1t
	/qBv/XL+EdREjzAtZP7Q1Pr0kB13b9zDY=; b=iWjqYRPGyDPfDWi8MZp3LZeMAi
	+xDEuYi75lLzQ4N+Bl67YlXqJdxseO1bm4RWp4gQajvOwSf/5Z7nFOYyRkpdKKTm
	unvIdiGblwh6CCML2LH32QD31rv0FrWysd+BLf/R+iiURoxr1lNVfRJduqWBO2oi
	hleimJ5Tr2xugQcTGHuxbUPURPmeSJHtC7L8GwNO2lsWvQfzX/UFMnXd2arNHL3F
	OSf6raOlftVtLFIAOH8mi21HD6WAlxp0su4NKa3Ojdg/CVLrlz/T1B1aOZFMeKFC
	sjh17cgqy+NKdnNKXmKGNrBxhlA4P4QUpZvORYCFkxCf8AZA/4BbLSe6M5ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773675352; x=1773761752; bh=QuWE0gvz1t/qBv/XL+EdREjzAtZP7Q1Pr0k
	B13b9zDY=; b=NooFH8XqtZu39WHtFoD/uhMWS81Z1nz+yzd6u5rvsYAysN2Gh8C
	ae9FVB4/bid/+6/fZVwZ44XqwBcD4sccxrtwgnZnY0+WZrDR5gjmC6H81wphrRy5
	1nYKkIjCCBnbr70mYWJ6hvwNrDyt4ojsKntuPQCjoWKIS/P62BZMqUmi33F9Ej0m
	lmZGUJNzeMpwWXxZ5Tpx2NpP2Fm6kOMxeLhmSa6TfZJfuT965zDJlk9P145sy8rk
	OpuOLukq76QU6nGB0PwHFnGjsp0tSUq8Gh7yiMN/24S2EpkjOQuLPE35NxTwlZ75
	PYWNCFsuoY+k7+kQg9I/p2BY/H/Bnm3GSRw==
X-ME-Sender: <xms:VyO4aSWKf0Q_U_GZDJRPwJQuIS8LOVLLtKJpjqDIe6VbBo6XlbxBQw>
    <xme:VyO4aVnQtZPvxMzQLjtUYD37h4oGWoiveAhwS4_msctRGHHzef8BmOSjOqIjR1pcf
    bil5H5by0wCsWMGgQ3YWP4Xne7SunoF36W_vo-Brk6adBRmtY3lSw>
X-ME-Received: <xmr:VyO4aba5j-txXazbpo7u7VZBc-RO9QD1D3xxKLkCOk-qMAYLWe6VMwOnD5Hl3I_uXlkqArgGemg83rzgEVGwF_2kNGFJ1T4FPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvvghs
    hhhighhurhhgrghonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VyO4aYOk800VWVs--ZTs422mAiIprqf9MdPB8L8E5r0kse_cuwwRfQ>
    <xmx:VyO4aYbzjwYP5eaGuw4XvGQfIbhNocGXYD71T6puFt43nDDHYLBHaA>
    <xmx:VyO4ae1hMyIOWtbjmG7ajp7LttMZxguG0PSAOVdB_1BK9ZFbbXCpoA>
    <xmx:VyO4aWezQg7hxmfG4mFTWZPkZD2nAv6Yy5kjJYvDkorgAVs9HUrRvA>
    <xmx:WCO4aTWRR8YvoyLhOVtXOry9pGK4VhRXMAKdb1TE-lgvDcxsKHsIwV8b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 11:35:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH 0/2] coccinelle: detect and fix strbuf-by-value parameters
In-Reply-To: <20260315094445.19849-1-deveshigurgaon@gmail.com> (Deveshi
	Dwivedi's message of "Sun, 15 Mar 2026 09:44:42 +0000")
References: <20260315094445.19849-1-deveshigurgaon@gmail.com>
Date: Mon, 16 Mar 2026 08:35:50 -0700
Message-ID: <xmqq5x6vrdm1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Deveshi Dwivedi <deveshigurgaon@gmail.com> writes:

> While reviewing the write_worktree_linking_files() fix [1], Jeff King
> suggested adding a coccinelle rule to detect functions that take
> struct strbuf by value.  I previously posted an RFC discussing such a rule
> and its implementation [2].
>
> Patch 1/2 adds a coccinelle rule to detect functions that take
> struct strbuf by value and rewrites the parameter to a pointer
> to highlight the issue.
>
> Patch 2/2 fixes the one remaining instance found by the rule in
> stash.c by changing the parameter to struct strbuf * and
> updating the caller accordingly.
>
> The worktree.c instance that motivated the rule is already fixed
> by [1], so only the stash.c case remains.

Nicely done.  Will queue.  Thanks.
