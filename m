Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9A2E7185
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165862; cv=none; b=sjiIjMZPvfGa14whMw3W/hiOVubpWVYoYgh7N8suzU6CtSW4kj0B3ju9h63rOfxe/5OuYNFdayZh1LnT04NXRM3yH6lZ+925mbhUEzZlyT9b4y/znwQNxaMKJuJ1ukz4RiY6j1BI4e/tRKe7WakH6MH4DYQjQ0685kzXeGQ1Mos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165862; c=relaxed/simple;
	bh=iMtaqLYD9EuWtiHOTysfEbB0jasLBbqoANvUWceGRXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P3bebPZg34GYVn8Rau7WlwAD72WMKjYjanmHusJkQHJWGhz8yWCqz1p4j6RhsRYEZCkjcN8ISG1CmGwTYikwFNRnE92TvlW48dtvW5px8C/VV8m7+ggc9sCKVINXxfbcUbgUdsy6BTkeiWE1y+Zs1DQb5dVbRDBMpJPgmkPvnSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SjGCREwx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gpRGlpc7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SjGCREwx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gpRGlpc7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ECC3A254012D;
	Tue, 17 Jun 2025 09:10:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 17 Jun 2025 09:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750165858; x=1750252258; bh=dhsXj8oy0q
	mTl3kqCl4jb3QuCxGqQfOp4quBvUdZ1Hg=; b=SjGCREwxbzIe7ugDk4ZMWONz9M
	E0RRvS8NN8gRyGFKVe92pFxMIdXYp1NlAS/whTUAMgqc7sOi9nqHh3uX9coo2zJJ
	eO8S6Rf64X7oaPLzag122WX0zYS6MvJgeiA+ob3jgJqX56Qz3FNej7wD1G9tBdsj
	BmrccLKk+U8bOrZOkJGnOeuHRp0XJlgVXN8SsZc/lDy0RrkOWuvxtQBTLwU8IbmB
	6xP2F1ayJttQONc0uH5P9RFG+qzccmgjzFasD2k0jqhDqEvv1qnk/tmVj7ip00ab
	BqQX2lIPW3xF4EIGmH3vT/8Tz6sOL0MFoumyhsDFJjg4HQD1mw+Kqz97lWtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750165858; x=1750252258; bh=dhsXj8oy0qmTl3kqCl4jb3QuCxGqQfOp4qu
	BvUdZ1Hg=; b=gpRGlpc7hC8JwtIeXbsy7KlfgXrvdve3BmVui/vmGXmr58Hbuaz
	eOy5aAgF2TBxcInXoULZ6ZBkkPvmuvRs5yvxKUWt+OGOaRIcyifUOdkWvC/00+gQ
	IlBYB+BxUjDoGmbcFokemQS1nBcyqziZYwwdUS8r+AA5QRT6wMGCJl//sJ/Pk310
	sVZo/OSU2A3T5gyfXTBejIo4sGc2yvPmlWBCeAH3Hma44eEP6uHKVpiuNjzh8eKc
	5W3WTlnPB8xA0ZRssnPLGuEq1Y6/FjZVOWIR4/L7u6MAvn4PV3C4uYndh8KLYTYN
	ixjy3ECtHu+WrTzoobmsLjtXa/YFLKnLdxQ==
X-ME-Sender: <xms:YmlRaKBN6cqR-EimxIl6ggqL7pIiXsWIjXU8x2xJQAzHDIyGf69Fkg>
    <xme:YmlRaEjpiZg3Xq1TI6KdI8eoi6J5fdngqXGPOoPAU44wgJhMcBAuEQhTDewjpHnsx
    alIwNTci5eWE8IFnA>
X-ME-Received: <xmr:YmlRaNlbD1DtISzbfXpEoTT876fp35VRbFGIz5eFYq1iIa0yxFe-4vwongUgVo2slS0MC0Enu0p_t7nY8yT-88e1CqXSG-Gocezo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrohgumhhitghhvghlrg
    hsshhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehitggrshgvlhhlihesuhhsphdrsghrpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:YmlRaIx9_gEmNHb0S08MDgWlXncMuRD6mO40bhLYjacPJAnJL9sOWw>
    <xmx:YmlRaPQAe9-QHCDbM9B6s9TVs2KKAlAj0ARqy1mr-xEhg6zh2fcqVQ>
    <xmx:YmlRaDY8EaT-sXuZEb4S_b41EnYnQrTbWIjjBhRcEVXzYvBF48SsTg>
    <xmx:YmlRaIS41B-rWIZIXNFMmlgADUaAGyJVa3QiM5Z2CtnzDlQXTw3m3Q>
    <xmx:YmlRaObIaXPjr54aPvcciFUSmyhY8ib6I6mQtPqF8H0JhliMb5keOS4d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 09:10:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Rodrigo Michelassi <rodmichelassi@gmail.com>
Cc: git@vger.kernel.org,  icaselli@usp.br
Subject: Re: [PATCH v4] t2400: replace 'test -[efd]' with 'test_path_is_*'
In-Reply-To: <20250617002939.24478-1-rodmichelassi@gmail.com> (Rodrigo
	Michelassi's message of "Mon, 16 Jun 2025 21:29:39 -0300")
References: <20250617002939.24478-1-rodmichelassi@gmail.com>
Date: Tue, 17 Jun 2025 06:10:56 -0700
Message-ID: <xmqqikkuy0m7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rodrigo Michelassi <rodmichelassi@gmail.com> writes:

> 'test_path_is_file', 'test_path_is_dir' and 'test_file_is_missing'
> are test helpers used in Git's development, that emit useful
> diagnostic information when they detect a failing condition, while
> test -[efd] does not.
> Replace the basic shell commands 'test -f', 'test -d' and 'test -e',
> with this modern path checking approach.
>
> Co-authored-by: Isabella Caselli <icaselli@usp.br>
> Signed-off-by: Isabella Caselli <icaselli@usp.br>
> Signed-off-by: Rodrigo Michelassi <rodmichelassi@gmail.com>
> ---
>  t/t2400-worktree-add.sh | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Looking good.  Will queue.

Thanks.
