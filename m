Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE9A3101A6
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965127; cv=none; b=JqvEDT1kq8NQdYbB494xCim8N78LLSYDcfUHr+d0OIKFvLmOgBl2RlboQWP+d57eTENfn5lhF2RYxh8zRsO9OxgwjDYR1SkBbKZKm6Vl7xOFPLCCteEtOF0d+Ve7tVGNRn+i7TLOsNJ9su7PaHCe4TYMkR4cu+ChigIDBA4ppUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965127; c=relaxed/simple;
	bh=ULtRbnIA4IMCxLtCUXYvQEI6mUL3efHhdizoJ+t4+c8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Da3vWnLsjIVNrzVb6EIzDoIdd6XMUXPMhqXsgEDhi74DF3kmd1RdeO23JnqwpmN/vLGGFje8zrohPikHUPK0pirws1E0X76yiyLunWttZ4p/VkPZhXpe9fxbfR82ExZU/yOyg3GEiZRlu7c6GDeydrmZgoCniMYQ+9pAFrTEEhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AlXNZsj9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rDLweWwb; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AlXNZsj9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rDLweWwb"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BD1067A00E6;
	Wed, 12 Nov 2025 11:32:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 12 Nov 2025 11:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762965123; x=1763051523; bh=YBzhxK/I8W
	I41XsiBld9a0CmgCsHJTh1QUmmIGfnEPc=; b=AlXNZsj9ex8so3IJ9Ji6qkmCTV
	vTjWtjkDz01M1dEXSMx5oWe5BdLofsTO/hG5gG8r7/ouujg/3hpIGdENRbn37CBL
	XxHDJJKA0tRhBkpT+l1GwmycbtNi+00ila1HENylHFkXEGyyLhPdILg2z05eTVAq
	Tkzo9G/AqjRdA34w4KoTh1CFHap0TJL8wQ+W/Himl+OEzaSHQzCyR2T0lwNqBCwl
	x8iTM/oKH7IfYnyyPswlNRAIK/TCCYK/6Hr1YUhBy+8impw9osnJwXm6R+Iuxs6n
	pPuXICge2c+SfWu38RXX26nfEvuOwGOYAjl1wAMQm24kW1D0Zz5cfn0iOwuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762965123; x=1763051523; bh=YBzhxK/I8WI41XsiBld9a0CmgCsHJTh1QUm
	mIGfnEPc=; b=rDLweWwbxUqCd5wUdIu9YOcNo87+RVIGaYr5/6BPrMXr20mui9f
	3whY4utQWZJ3BCCNj+XdQ8n0BJP+oybeKGqoi/m8Nv5eyrho6ZNklS1TH/K5Hsin
	ANiAx+H3NH/uDJkcngZiRXh/09DEOeMYsH5wF7pC4C2mEW1RApTZlF5FgEJD08xA
	aQS+qpUiJ3NYk4guKUi+8mxBTUaHp6BhGiu2QZuiuZgGk0JkDwal1rj6QlTBZZcR
	ms8fMW6XIxkQwEiEKNNfbdu/V6anDRyCfkSCgBOy4R9QMUczRQBJjWdU0Kef3F82
	kg00TB47VYse4NIBbBmWzLWwtbSpGMz8YRA==
X-ME-Sender: <xms:g7YUaeJpaqvpLuwanO4h2bfhrk7p8SciOIx9bc7m4T_rzbimMiQWWQ>
    <xme:g7YUadAH9UqgfNHzhiixQ0ZxvK_PlJKq4vqhKVEwCYaONKvaqiO-2UPHXINfmLwRN
    EOI6j63zAUFWxOiCJxkKlFB1XlfBsLky4Xuyxp_X40f3SwVWa_eaQ>
X-ME-Received: <xmr:g7YUaXDGK0Y665_E3-qJDCKzw6UVaqhGD2j56hzJC2-H4EA9VDQyXez41FDsT_MKbTeBHCd7J18vJ-kxiefLyHuVy6STjuHyih7E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdegheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmfi
    hilhgtkhesshhushgvrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthih
    thhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrughrihgrnhesshhushgvrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:g7YUafBHzcnm4GWrGtVulqLqB8S57f7JytvIQmN_dMQE4MniJm5gbg>
    <xmx:g7YUaSr-XgF_m4Bcnxi5KUj63VjvZgDP3r1KgF3nkzuPB3hWtuIuvA>
    <xmx:g7YUaZlNgKx65kfEEs7LCT-GH4QklYpGJh4aH7rP2-zKCywppnVP2w>
    <xmx:g7YUaSzInUXyE96CrVznOP59dQc9tECjAJymOXuXgF9hld5Su0d2mw>
    <xmx:g7YUaXM7OAGh56URcbYXXSl-yNTq5r5Gs_5IJnlNjtW24FrWaekjmPN6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 11:32:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Martin Wilck <mwilck@suse.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
  Adrian Schroeter <adrian@suse.com>
Subject: Re: git fails to checkout SHA1 submodule in SHA256 repo with --depth=1
In-Reply-To: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com> (Martin
	Wilck's message of "Wed, 12 Nov 2025 13:58:46 +0100")
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
Date: Wed, 12 Nov 2025 08:32:01 -0800
Message-ID: <xmqq7bvvtdoe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin Wilck <mwilck@suse.com> writes:

>> Subject: Re: git fails to checkout SHA1 submodule in SHA256 repo with --depth=1

I think it is not supposed to work to mix repositories like this,
regardless of any other option like --depth.  I think brian gave a
response to that effect in a thread in the past few months.

    ... goes and looks ...

https://lore.kernel.org/git/aJ5gOPQ9oologqj-@fruit.crustytoothpaste.net/
https://lore.kernel.org/git/aKPJNNWMW9gtueEK@fruit.crustytoothpaste.net/
