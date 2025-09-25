Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1E1917FB
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834950; cv=none; b=J9jUzt2VxhOwsvY5JjSZ9VxfC51yudd/Ea76nQanY1u1DjkOzfTiq3W9B2rQKij4PzmLZp+W4JAEx0LPiBr2SxMq/ixJjvlTRFuDDBCyVWpBe+avfinOexn8CO8WkzHKioknWawqtmJhTlaW/FIWOjPBQwHDtiNC/HLPn5Z1SUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834950; c=relaxed/simple;
	bh=aJF2JxWProV3oXB617piKjYrI35MuGcj/+pdS9IEJis=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a/0/BcLzbt+LN9ALkjkXZ3eMhDWGiUf7VTYhOe/PvKfT3jY6a4w839/XMWuMjtnXLy2vhknSDpkUfBUs/RBcobsP9o67wJyOO3/E+Kb02hzX5Kqk8XihCq4howo9rTyRxbf/JoDTvAu1Hj9Cly3GJQQKFOjvQKwa+u9uAsKEmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n2hCD8gK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NpMhHzws; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n2hCD8gK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NpMhHzws"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 17CB3EC0105;
	Thu, 25 Sep 2025 17:15:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 25 Sep 2025 17:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758834948; x=1758921348; bh=h3MHKLa3cS
	DFWu5hMYcav3r6AwuR1hDBEq+Vph9A3oo=; b=n2hCD8gK2KsX1foRU/BRCPdqSm
	iJhjX2Jy0xqi0aDuz2DYLM5pbzDYJpMw4rtAzU6yf/dhRnHHUJ77ITR/fbVkD73S
	BdT8rPxtX3OajhOcmaHfgUZGxvnB5HTim4k1PaNuj69BARvRP96xAnzLlPjQBc4M
	0yUTRuwi39mXFOU8jMEomk2AbOlYjF6/ZxqZnjJ4yQPjIXz8ROhO0S8QkTJ10NXU
	S8hwcdBLHDA4PSAVjvE+M3A7IaaCXjth2VNUtTI+VPaOZuRA9QVyMbKwwvk0spN7
	vIkjMcnhrnMQf79RiLIIN1mY/YWnBGXHeAoWFxxiKjlwMwgS1PrMf0J0jobw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758834948; x=1758921348; bh=h3MHKLa3cSDFWu5hMYcav3r6AwuR1hDBEq+
	Vph9A3oo=; b=NpMhHzws1rBW/33ToyuLn2qWjpHUKf34QzWxbh3Bk5T21lXbTgm
	zQXwt/K35aG7922/SOp+oh6RjHTioTqqeN+x9K2GERIcEqB5EtUpfRwxD35sAZKx
	cWrJNqloIfvB3+Gi2TCga7M/5RfspOPImkR2BbkL6XMI0ENgv2BSensxVFLXqvDr
	ceA1Y995vvy26zWZqYt101+eisneVYoYxI8HlV+jGaG0DCaASMqOUw9P53ezvU57
	eiXdu81zm2L5Mzew5ZgP3n/839hcGvuk/G0WAzYq5bUZxL+ymYS7B1UWg9VYq6Nd
	NAiPTFBtp0fzMLz/DBM1i1mGyVUrCTRjKiw==
X-ME-Sender: <xms:A7HVaFeRTN4TooSR56CzSCUr4lzJJzkfQzGBdfS15mQ3US7Ih3YEag>
    <xme:A7HVaG5N09Y2vWQVszgaX1eLBkUxQO52XqLzpwp1PoxZK1VTWtJwZVKnwtFYHPqgK
    YPoJJLd-pFAbZQiLQtbdzuleAXKPHDDtV_Bgw14IY2VFE9CSC7vfg>
X-ME-Received: <xmr:A7HVaIUmtF3Q0wErYB_EX0-r68o8_5IylgLJ9RDAX4CLB4oxQM95D9h413ymauIEk7AtDfo4lqU7u6yuYJ_oFKmVEmMQPGWOjJru>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtohepgh
    hithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:A7HVaF5U2Xy0_awY4v0fUSNA7pzjhLnaMQWa2mM8ShvZNUiMhbjlfA>
    <xmx:A7HVaDovcxsW0ohMc0HLX9sTD6RcHyS-VXP7UhW9TkWYO6Pm6jWO8A>
    <xmx:A7HVaIlWIZHXMpy7GgXCHYc-CKJJ1ziwqIrB35bnvA65h-rV3_HkZg>
    <xmx:A7HVaPNkRWHqKUPdFIX8kjqwHQarWsSNsHI0OT-exq1hxua9JuQSYA>
    <xmx:BLHVaOBf4IYk-WvfiLCjSnV5L5RifdfhMT7vD9atAM_B3ePCizVCrkh1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 17:15:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 4/4] doc: git-push: clarify "what to push"
In-Reply-To: <2365a7b9-3d22-4406-876d-65822822655f@app.fastmail.com> (Julia
	Evans's message of "Thu, 25 Sep 2025 16:50:32 -0400")
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
	<be6453d010bdc9d2b49988d6841dd7e7f9bdf1f8.1758649472.git.gitgitgadget@gmail.com>
	<xmqqqzvvk4bj.fsf@gitster.g>
	<2365a7b9-3d22-4406-876d-65822822655f@app.fastmail.com>
Date: Thu, 25 Sep 2025 14:15:46 -0700
Message-ID: <xmqqzfaidyil.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>>> +As a safety measure, `git push` may fail if you haven't set an upstream
>>> +for the current branch, depending on what `push.default` is set to.
>>> +See the UPSTREAM BRANCHES section below for more on how to set and
>>> +use upstreams.
>>
>> This feels a bit out of place, as the safety measure, as I
>> understand it, is only relevant in 3. and only when push.default is
>> set to "simple".  If we are referring the user to the configuration
>> section, then it may be a better place to say that the "simple"
>> setting requires you to integrate with the branch with the same name.
>
> That makes sense. My goal here is really to communicate that you may need
> to set an upstream for `git push` to work, since it hasn't been mentioned yet
> that the upstream branch might be involved in deciding what remote branch
> to push to, and it comes up pretty often when using the command.

Actually, I think it is a mistake to tell people to use unadorned
"git push" all the time.  Have them say "git push origin mytopic",
get them feel sick of doing so all the time, and then tell them they
do not have to if they set an upstream for the current branch.  IOW,
"sometimes you need to" is the source of the confusion that comes
from giving them too much DWIMmery.  You'd by default need to tell
Git, because you know more about your project than Git does, until
you tell Git once, after which Git knows what to do.

> Perhaps this instead:
>
> "Depending on the value of `push.default`, git push` may fail if the current
> branch doesn't have a configured upstream branch.
> See the UPSTREAM BRANCHES section below for more on how to set and
> use upstreams."

So, rather, something like this

    "git push" needs to know what branch to push to update what
    branch of which repository.  It is done by giving command line
    arguments and/or setting configuration variables to the command.
    See UPSTREAM BRANCHES section for more information.

would be more in line with a preferrable mindset users would have to
successfully use "git push", I think.
