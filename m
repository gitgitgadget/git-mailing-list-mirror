Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47303FA5D7
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457359; cv=none; b=DyAMwVIbwTv9OXy2itbM2rEvBhOshkOWW0vyBvubmgokGhgK6rh72T++tujO396yzblUhHh4NhckH6djoWD1VkR0y/TJWRazQgpnPjpsb2WragSSK6atC8JnjFddQANW46csqAnlX3oFUgsSijuRdQQ5PDIoO9bF5VEJdSkYEjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457359; c=relaxed/simple;
	bh=+nBtR7n5oyhZhkGcQoexGVlrmoN1yGMIHyple3zYZN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U6ZUmQP5ioml7x8aYwNJhcOLy+/RnYIMuaBSiksqFENIq2focAHvrs1I8dprYjpbvH4wy1G2uONAq+28KKaxKdfVBZfHLdQIoQkvY6M/xUI5ckcZvjfY9JXEOk1r+Dj6F4lWlOdGqYhE+TN9/0f7nEDJgLYnjKA5JZ2Xjkiz/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZdcdwDvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KVeYiFH7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZdcdwDvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVeYiFH7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 03614140019E;
	Wed, 25 Mar 2026 12:49:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 25 Mar 2026 12:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774457356; x=1774543756; bh=W9/A8IMzI0
	KJYApuSuemL4BHJEDjoUEzRSdszqKy/RE=; b=ZdcdwDvvZCMmH6YesuO72hQ9NJ
	T7855IHphJd1jiwKyfRklH/zHf6S2D3eR6EMjshrSKClTYMk0QRMbjzTdvFjWvwk
	STSGcu8vq+F3rA1aEXJE4ozkPduB5opxkwEcYuRvpWQvPEoApEyRw2F/TvKGkQ0T
	01DkDlypGC3g+cSl649ew/whlKFFsZUZfKouz42cdiKiLobIjmMwZ1ooLQctcrcs
	ReZI5XDDXG1ZGfNvnrl3s6LzQBwEHHRIImaqE+t00s2wsV65ZW2qL/ZHaubx4lKM
	hb6ivdJMQSXnE/G1IeH+ZSXys8PNi0r+8NuZjxVzsod8IYtjWBCb+FKHi7qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774457356; x=1774543756; bh=W9/A8IMzI0KJYApuSuemL4BHJEDjoUEzRSd
	szqKy/RE=; b=KVeYiFH7Kqigvdr9g9+SXSJm9Fg+5HojrKTurzDE0n+uPAx5kee
	uEL8hSJJCpYKH6Kp55/AbQKToErwxaCTZP9w8vpxYiM5ursTv6hK4Jyc+OTX4JpM
	H52joMs1ODnbjXEjmUkXI4iVri4YKQNalmOxJYDatqUVnhCir8s5/mbedj0ZkgAC
	D761Xy49clid1hsu69eaOKKlhrdOOx6ZfhjkSDQCR2bYTsizdui1hw50KW4Il9qX
	JSUCvhCRdhnQBvGzRNQRiQn/HXETDECAhlC5u73xE2mvSKZVCkC1G0+CgfY1C0xt
	r37/X4e8WE//4ilxzeaNVT7aSNvqPyUmPjw==
X-ME-Sender: <xms:CxLEaRNJL8R7UVG6nQyFinCfQkv1vmtBVuZnwfnUz27cXik5bvhF0w>
    <xme:CxLEaa0VevbjruiQ-P7u2xKhNen8PWfCH0tkTiw_61LTEgl2stRWDV0aofyiC441w
    _KnaTqzulGHsbSAVwXOLMZJn-CGYM99YtsuKrIrxuGiRKyaP4Y5dQ>
X-ME-Received: <xmr:CxLEaYk7A0Y0QOkVtGl8DMaAZq99GTXehhJ-2DVjSfUpEqBPNLxn_2FSOcTa01eY7MW7OkPOh4UDSvsFIylJDwn-90a5XNyfXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeehveejjeeuveejgfdvfedvfeegveegveffgeeukeeuffduvdelgefgjeeu
    gedvnecuffhomhgrihhnpehtohhpihgtrdhtohenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrih
    hsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhes
    ihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CxLEaZWZyuxABYYJ76DTbvroyIDUfB9Aos6acXupnSexO_OK1zK4tA>
    <xmx:CxLEaWv_sNg0gvFCI4xqy7ESuTYVjEh2U2Sl-72qx1ltgRS7zTfoug>
    <xmx:CxLEaUY8d40OmW98E5J2RN0RAkNdnWyWILSrB3wJQ1nmWV_Sye1efA>
    <xmx:CxLEadXVrPYKSnht74Bq4cTwgUnFur-TkMkfLtUApxp9eZGzNZPqeg>
    <xmx:DBLEabyJvzZlob0OUfrdQMxMIH0ymhRtiAJ7CwdDPfMEGRr4X3_y-HXw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 12:49:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2] replay: support replaying down from root commit
In-Reply-To: <CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
	(Christian Couder's message of "Wed, 25 Mar 2026 11:00:18 +0100")
References: <20260317-toon-replay-down-to-root-v1-1-cb5c249e15fd@iotcl.com>
	<20260324-toon-replay-down-to-root-v2-1-34e723489f6e@iotcl.com>
	<xmqqtsu5xaw0.fsf@gitster.g>
	<CAP8UFD1zJXnsm7POK32GqEu4xSC+VO5mfzUpM-jn+Nr1qvzEFQ@mail.gmail.com>
Date: Wed, 25 Mar 2026 09:49:13 -0700
Message-ID: <xmqq7bqzx3au.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> For example, before this, `git replay --onto main topic` would fail,
> but emit "fatal: replaying down from root commit is not supported
> yet!". This would likely help users understand that they might need to
> properly specify a range like "main..topic" instead of 'topic".
>
> Now it would likely fail without any error message.

The fact that I do not quite understand the suggested change is a
very strong sign that people would be helped by a bit more
documentation ;-).

Depending on what is in "topic" and what "main" has, wouldn't it be
possible that the history leads to "topic" replay cleanly on top of
"main"?  And if there are problems (e.g., the replayed history may
want to add a file where "main"'s history already has contents with
a different ancestry sitting there, or the path may be taken by a
directory), wouldn't "git replay" fail loudly explaining what got
conflicted, instead of failing silently?

> Maybe something like the following could help:
>
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -23,6 +23,10 @@ instead get update commands that can be piped to
> `git update-ref --stdin`
>
>  THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>
> +Note that `git replay --onto main topic` replays the topic branch starting
> +from the root commit, not from main. What you might want instead is
> +`git replay --onto main main..topic`.

To be helpful, "might want" needs to be accompanied by "if you want
to do X", I think.  In this case, that X probably is "recreate what
was done on 'topic' since it forked from 'main' on top of 'main'".

Thanks.
