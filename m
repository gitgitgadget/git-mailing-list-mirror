Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B32AE99
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511761; cv=none; b=eHUdCEyt+246ULcjPaljXPGW7vExo+1LtT1GoibrHzQPc6L1ILfJoLkWJfqSUxElldDcHhJhm4B/uNxzvCZR1Eg1qyBpMZLrS+o9xmD4J4FvJf6bUYQa8PqaI7sVhFqIVd40WKevvkB82DCscuf1HQ5jTHdfRlfnFg8E66SArb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511761; c=relaxed/simple;
	bh=by4Mmq6I5HzLYTfZ2u/WLLWfPDZr2EgBc8WNFYAgBpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DbMYvvx4PS2WT3hXoM+qYxgxdHPwUB1fF30yoLlawcQ4zrmcq6OxmbeefKptT+FD1oVQUUN/jgz7QgE8bFNrldUsE2uBiThhaRxc2nRfqQQ5ljyVF3/SeFoZSPHgeMIhm50xq5MmutI5Cbg1/f/kXbeZNRrWgSUl20VCn1zO1Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IrDijguo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/4DSjpT; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IrDijguo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/4DSjpT"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 73E55EC00FA;
	Mon, 14 Jul 2025 12:49:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 14 Jul 2025 12:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752511758;
	 x=1752598158; bh=3CR8LHZl/D1pyQ0M7DhHkU0bMrHqUH6tqXNx2sff3qs=; b=
	IrDijguogh44QYisYTiiLNzFbk7zDKKCMzZpYC4ROheWOr/1xPXA9q7ooZ0Wn2WO
	OguWBisXcGSrfncb4XDUTD9tvARoPwKkdiVZ7hNfJcBLK+rPhsX5PCM8BPlus/y/
	8gk8/XN3J5Fn2iyqZ5P+9NG9dI1XpW+1wzxJAlZ/qk6svwCP80FWiq0GUHlTqbad
	TrwSJ5Wx+g9Lg7feOh1Ktk+jCDV4rbQH77PLP16zZkEcfI04WZSyLFkb4Yza1dQN
	a6Ae5dsa+4pIYHapxH07wTuvxOp2Z2s6AIIAwxHByGct4aWnXlpqKwot2Do0sVv5
	tCYyiJT7NiwxKrGQfkzQDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752511758; x=
	1752598158; bh=3CR8LHZl/D1pyQ0M7DhHkU0bMrHqUH6tqXNx2sff3qs=; b=a
	/4DSjpTgdaWPnpaXiv/BSFQqjMhIBCvBiyY4kPT0PwMmyDjE6tEQ3XND92rYlpga
	OgCvopK2B6qsfJnp6qE9ngIwcskFIX53Pl/RXAW0FxS4kZ8Xeh5puryRzdXAqGVg
	cfvxTEQ2DTgNu03qaDF0mnss5a5cd9DPmPCvnL31/oH9D3N6JgSiShvqFyCZN38z
	u1kNSVfFlwwdhGHcppinKOLqHAKBLLsPomOcntxTNFoIweTrztfo6tArZt02xY/S
	2HvhjO/iTO70FQIyZjyFy2a0+Zr/lBQfjbClz/3ybl3yMvzv3EwkMCsUz/LGcuVv
	PLH1IST8uPg4KacfIiGfg==
X-ME-Sender: <xms:DjV1aMY_4hyAF_qgmdu8O7DO__f0uj4OexDq2hD3AocndR3mYdWCoA>
    <xme:DjV1aE_nbPt9dlsfYnrwcLpJ4fVlyHPVBjnH8vzeiuRD96-B4dqqzbXylZanl3pO5
    uBd5BPrnoiu8xeX6A>
X-ME-Received: <xmr:DjV1aNbksjLZb2WoRfUtcplR3UugQruNfaU4DhUPmpuOLCI_j82OnzLpqd0pPTangVycfUB4C0ayNZsKSOkYOlu6gYfrZlxLNCprwzM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehstghhfigrsgeslhhinhhugidqmheikehkrdho
    rhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DjV1aIOHwCAHr5OVvXWkpyCGiv9VcGFlH-TvElB559wKiwJKJmR7tQ>
    <xmx:DjV1aJDEysQhlVYnezxqJWBpC6Bq2Tv_7NOIqJNdlui9kE25pVBh3w>
    <xmx:DjV1aPJsiX8dvt1NDczJ8ip5q_CuCFnfCNpazJWqYJxT0X-7KwrGbA>
    <xmx:DjV1aCPK5Z7rAL-Xb1d43FVX63q05BP8AuBMRtELWJWs5yt4ikf7YQ>
    <xmx:DjV1aOAGbPQTRv5iTLm2hVdW35KrGOQedLhHkvwOaf7HwNdubZv7YLS_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 12:49:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  schwab@linux-m68k.org,  phillip.wood123@gmail.com
Subject: Re: [PATCH v4 0/4] for-each-ref: introduce seeking functionality
 via '--start-after'
In-Reply-To: <CAP8UFD0anB4dPDf99-w6dyZNNGuOKU-b30_k322D0EsWE0cKPQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 14 Jul 2025 18:34:58 +0200")
References: <20250701-306-git-for-each-ref-pagination-v1-0-4f0ae7c0688f@gmail.com>
	<20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
	<CAP8UFD0anB4dPDf99-w6dyZNNGuOKU-b30_k322D0EsWE0cKPQ@mail.gmail.com>
Date: Mon, 14 Jul 2025 09:49:16 -0700
Message-ID: <xmqqms96u38z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Fri, Jul 11, 2025 at 6:20 PM Karthik Nayak <karthik.188@gmail.com> wrote:
>
>> Initially I was also planning to cleanup all the `refs_for_each...()`
>> functions in 'refs.h' by simply using the iterator, but this bloated the
>> series. So I've left that for another day.
>
> I wonder if there is a plan to add the '--start-after' option to `git
> branch` and `git tag` too?

Good question.

"git for-each-ref" is for scripters, "git branch/tag" are for
humans.  And humans do not page (outside "more/less").

So while it may be trivial to expose the feature to these Porcelain
commands, it is not obvious that it is a good idea worth cluttering
"git tag -h" output.
