Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5C9302760
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756302796; cv=none; b=gi36SwqxTsIw8/afIwyUtelxtWri4CGvAaSrfxunK7z7mmqTHJbSPEfgBnQVOc/ARHjJvVtrjmhb1iFKKoclobSPY+tz9cy1NExchQQ2ZK9CmqwguuiH2PEq+lVxMxL3UTZqfDEd1ZFae7qUS4UP5Z8wtx+ClNd3TtBfnKMXipo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756302796; c=relaxed/simple;
	bh=05ClpSjGEb5b3c0VGcaGNRnU9QapfXdFb5B69t7IS7c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=aoo4wTgOYVcSANeVX3+c27WknEloDIB/wRDhCRI7MuhF6yLQJRMOtvxcb8Li4rWd41dw+5g+InoJWkDYNMEhreCzoTBTFhbdZnlaiDzPmv2LENiUSgvE5kWVednys/ZpmViK29NbjvV71uV+tAo7vkMLCSwruQHHBN88T9XydmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=Vr1VQ6cG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a35dYPws; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="Vr1VQ6cG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a35dYPws"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11E35140037A;
	Wed, 27 Aug 2025 09:53:14 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 27 Aug 2025 09:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756302794;
	 x=1756389194; bh=rdotN1uO5twslb+aaaFOr/uKW+FbC5X2AQCB15naWAA=; b=
	Vr1VQ6cGL41k0QgMh0SIbvK815kFKLDZXpdPS04RYr1hfQSV+UmcvEZsC6YaZKtu
	xbKMcrIytzVoKUqguSl8VQZa2UkvfAtr/YQAeO1uEQ4qa+2cg9eAB2E/lw7PzLUH
	kiEdEBPzoBej8q9HzXCB8y1+u/qcQltnP9YbQp2BSnlkzDQbL9LA3DJP2unI+NgZ
	32nr+Tmi6v6O4/5oha+owzsabc+AZUDd3mfb15C+u7iLXPQtQCC/+B20Aas0+Klc
	IdBU1CKhLieX8jzVYTgJwJ/IGmrYrZasV6jYR6hUiTwJ9256V+sE+/5oZznwUMS2
	L3teB/4V7lT97SvMUkEpmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756302794; x=
	1756389194; bh=rdotN1uO5twslb+aaaFOr/uKW+FbC5X2AQCB15naWAA=; b=a
	35dYPwsAjrRr5f6HgfSIHqbBN2FEmm4a5PPwFG7Fm9nVHn1hf0MAwqyTat3VBP8t
	cCFQqfz1S29oiKjZiNdIFmjc6VonL9hMkfKsXbdH7OWTth+eK+xYBeNoBzmJRikc
	0OFx4UDLGsqaSSNqXjAF6pOTbMpOvm5Ojjl12DIK/rPTBno0kBXjawFlPeyKOIsV
	2nMfh1rZ5OyEspEkA42kkXGya0ANIDzHFrc3xAyAFOzabZcGaUOChOrBea6UAxPq
	EN5juxVVNXfXmW0Ww2zWVue5M2VPMf1C0+sCedEEOXUYd7av2xoCSmexQgmJz0WB
	8dz8cG2eDtuAi0HNiMC7A==
X-ME-Sender: <xms:yQ2vaMiUGkW3mZuz7vbPynDomO7cCItEaFj4s6Y4ZZXNRSmn9dj_1w>
    <xme:yQ2vaFAlUy4ycvmZQj5XduSE7cBXs_C6_H_nkdoFpNWvOexEFsjDqLzRsWWdYF0tX
    LHvVD6Oz7PXGSRMdTc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkjghfufgtgfesthejre
    dtredttdenucfhrhhomhepfdfluhhlihgrucfgvhgrnhhsfdcuoehjuhhlihgrsehjvhhn
    shdrtggrqeenucggtffrrghtthgvrhhnpeduieejkeetheeivdduueeuffdvjedvtedute
    dtteekjefhgedvueeuffegleffkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yQ2vaMp5wKKDwS16xEHVSFuEPgPLOSRs9lo0m4k3dMgX6RI-ujxUDw>
    <xmx:yQ2vaJjS-BWBcdkDpHxnAW3MPN0Gjy7-9LDpIgqwCdrSriDCGOMy9Q>
    <xmx:yQ2vaOK71-ZPDmU3YQFL0Bp_ovrIp1xFn8xlmU2V4g97W7E-_2UKlw>
    <xmx:yQ2vaBAV07rgaTSz3o5vun1agNv5hLIErmK8HFj_uxeGk0LZ5y53GQ>
    <xmx:yg2vaKr2YK_SvFWxoWcTh7P4MxP8hw2ld11EFOrUKPtXlvnFTepB9EVf>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C6D427840CC; Wed, 27 Aug 2025 09:53:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ALMQnK0r4jnk
Date: Wed, 27 Aug 2025 09:52:53 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <092da24a-b9e2-48e2-b0a2-7203545d38bc@app.fastmail.com>
In-Reply-To: <xmqqldn5fxfi.fsf@gitster.g>
References: <pull.1964.git.1756240823.gitgitgadget@gmail.com>
 <ac554cbe75444880bbb2791c4d85dcf083d833d7.1756240823.git.gitgitgadget@gmail.com>
 <xmqqldn5fxfi.fsf@gitster.g>
Subject: Re: [PATCH 3/4] doc: git-push: clarify "what to push"
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Is the last sentence correct?
>
>     $ cd /var/tmp/playpen
>     $ git clone https://github.com/git/git src
>     $ git clone --no-local --bare src dst
>     $ cd src
>     $ git checkout -b alter
>     $ git commit -m 'empty' --allow-empty
>     $ git -c push.default=simple push ../dst
>     Enumerating objects: 1, done.
>     Counting objects: 100% (1/1), done.
>     Writing objects: 100% (1/1), 185 bytes | 92.00 KiB/s, done.
>     Total 1 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
>     To ../dst
>      * [new branch]            alter -> alter
>
> In "src" repository that is a fresh clone without any customization,
> the current branch "alter" does not have any configured upstream.
>
> Puzzled....

It looks like Git behaves differently depending on whether the remote
being pushed to is named "origin" or not: in this example
the push fails to "origin" but succeeds to a differently named remote.

$ git clone https://github.com/jvns/vue3-tiny-template src
$ cd src
$ git remote add origin2 https://github.com/jvns/vue3-tiny-template
$ git checkout -b alter
$ git -c push.default=simple push origin --dry-run
fatal: The current branch alter has no upstream branch.
$ git -c push.default=simple push origin2 --dry-run
To github.com:jvns/vue3-tiny-template
 * [new branch]      alter -> alter

I tried to find the responsible code by adding some debug print statements
(in this commit: 
https://github.com/git/git/commit/541e5d7cf61f970a5653ab496e5c3111271654a1)

It looks like push.simple has some kind of "same remote" checking, and
if the branch has no tracking information, then origin is considered to be the
"same remote" (so pushing is not allowed), but origin2 is not the "same remote",
so it is allowed
