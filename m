Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54C35950
	for <git@vger.kernel.org>; Mon, 12 May 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747080932; cv=none; b=BnSVh7eh1zkWD76/b+2l9nzK87uzrJHAnzEnnm4Q574GL29gp0QVaByhGQv54X9/AhpYGKBRkB91fvIUVuVWeSbiUXFO0olTrvJN2aERyWNXdCfBvMDo2cULLitg/HG64vntCeb7T0Zv8tNWKyzC/29XgW54B4QxxB1Yl9B/CXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747080932; c=relaxed/simple;
	bh=FuIr1U99wZK2/ILCG/CJhxKDWOZwMWE27NHvkGgVHDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gNK+b0Pg5A4MvKGbREtP6QvAnfSXKQMJ8EnSBfRcVKwQS2joddwemh+sV15CshTlYfLieFOErD/q3QOj/bMHRieqBFT99KVCg3WL+DmluXNo0FjeD+DrtAJnAnUZIZGXGwnL3xGIvJYtCDhOfP2XsqsMyZPnzEfkJkR/Db3Wi2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mToxVL8O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N4sW394+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mToxVL8O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N4sW394+"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EE9F1140099;
	Mon, 12 May 2025 16:15:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 12 May 2025 16:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747080928; x=1747167328; bh=FSqj1njO9n
	cPPCagTj9aXJUh5gKlCK690emetRWpI30=; b=mToxVL8OV0pHXusZ1kLu9R0Hts
	7sQMypjFiv5EqJ2LVmwgOkEqHLY9X8+/94YPB4aDyo8xEj6p85MQkDNpIsmRYpdk
	TXR0RIlvw/iWlBpqpwYJ+C9i8OIdRWp57OWBbD39hE+wkYtettFSZBjj6dOqS70V
	b1LYn8XWuNyusqCApXEogopv4SX7YnK53mcxIcB1nO+NJZWdD914nE6qhfuT43+t
	WUqzS3XR58INqKoMjHG6lmL1nYfN+dX+EetauQFaV2Xo2gb6oI2b0LcwJqlqhwnj
	YlYNFRUE8XsHp3LdxVqHJANbT2D89AclN7jzfq/GCMmF9kkU/XjG7gDSahOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747080928; x=1747167328; bh=FSqj1njO9ncPPCagTj9aXJUh5gKlCK690em
	etRWpI30=; b=N4sW394+BpJ0Ys0zqIpxcY/Zm3Ewf4t+r7A4NgjinGuoeOwAkz3
	W+8ltPQj2mbhzmPAo953J9iyPtH+aOM3MNRnWQIa/roGVfi/TaNMDMQY/2nOc70A
	zWd1uTYTc3NYIc13M9BMQAOiJR+3rJHJ15MJgOEUg6SpSduS+8kb3/GJkcxb7i3Q
	YyZPPIanjhHqtsRufxDZdAHUi2nmDmH00uf689fY1/HSVjnq7qvbw3pzpWvN7UL7
	K6WZOgkO5HLMwyUe39WNOmivRaB6ZuBFvwEZfV9vvM0lNAkapxnZZj63QSyoMgFM
	3TtjBZEszbDA/W1m2J4ergQuPUl16Hiynfw==
X-ME-Sender: <xms:31YiaNhQEKRbda2Y0jqmAtsIGnuutFr_xNy4FIEYz5ENuYQmFv86Gg>
    <xme:31YiaCCYqqKI9tkiJZQDuCIXj0Eo_kyIZcrMv4k6cQFR20kd2FHbiXYji0Dy9MW9o
    wKQxf5WHzKpFNnNqA>
X-ME-Received: <xmr:31YiaNHdL3zktoH3IsTuIQuvMuNEryaIH_DYXLjHNfCmuwQbDRfR1Am5Y8ZuVtRtCkN-3i_6xFrRYH6_yA52MwuA1C4eRd6edpk84LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddvvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgrghrghgrughithihrgdt
    keeslhhivhgvrdgtohhmpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmhgrkhgvrh
    hsrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:31YiaCSkOuFU7G2iEI3fLrtcApFkSeMyXTeu9o6SiDLDtFP1VYWi4A>
    <xmx:31YiaKz_41oOHX9-xYwwtZYAuClBB5BZizJ162cYtlOh83eXctSj1g>
    <xmx:31YiaI4AP-Y-imiKdsvd5R8oRBcXhwSWxZh4LxWwYG6VEsMIk2h_sw>
    <xmx:31YiaPxh2Lzs-kFKY_TiVuQtW4VYamCD29elKP23ehou3fKZ2bX54A>
    <xmx:4FYiaM9N67kgDYs5bq577SgUCqYOAYNZQHtfMoOVon9xusIteym7ZjUE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 16:15:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Aditya Garg <gargaditya08@live.com>,  Julian Swagemakers
 <julian@swagemakers.org>,  "git@vger.kernel.org" <git@vger.kernel.org>,
  "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,  Zi Yao
 <ziyao@disroot.org>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] send-email: try to get fqdn by running hostname
 --fqdn on Linux and macOS
In-Reply-To: <CAPig+cQCpWhJoouuzZu9HPy7Fj-T5RcNnAqryxQ=ATn37Os49Q@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 12 May 2025 15:05:37 -0400")
References: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<D9U0KAX6KVXK.WCY7YGX2Q0A5@swagemakers.org>
	<xmqqa57hvl0f.fsf@gitster.g>
	<PN3PR01MB9597D7CAABB0EEE93A5CC490B897A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqq5xi5u401.fsf@gitster.g>
	<CAPig+cQCpWhJoouuzZu9HPy7Fj-T5RcNnAqryxQ=ATn37Os49Q@mail.gmail.com>
Date: Mon, 12 May 2025 13:15:25 -0700
Message-ID: <xmqq1pstsi02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> The problem is not restricted only to macOS (and Alpine), but more
> generally to all BSD-lineage `hostname` which does not understand
> --fqdn but does understand -f.

True, but the proposed patch limits itself to 

      $^O eq 'linux' || $^O eq 'darwin'

for unfathomable reason, so BSD's are safe already ;-)
