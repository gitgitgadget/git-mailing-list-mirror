Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822732BBE6
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117238; cv=none; b=Vh8EGt2lGr1ytUY/0gjeEXIn+PC/++He1hBo8BZBEcL0Sgoqb0oARNp7Bf/uLKxJE2zMOcK0XwhPrTVGMhVwW5q8aLkc7VkHDSxLMMHkcyKF3AfFZ4UPDGvFQLrIW8+syWiV3rVpky8kipztqOZPCDNoWDc0BzfGX5j7E+Leq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117238; c=relaxed/simple;
	bh=I4Zj86104Hi1Ij/rcueyBKVh79pZ77hj9Ak6YAOqt4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A2WWXF1UI955MXfK8pIWXf8HhgnqN8FEodQVnAeHkBybKizIPHokKB0d/BXpimFHCr+uO+wBkE+5u3+m0KuPip5aQhaE9+XQgEJjM0b1b7hfgELdaF6G9AE4l6UHYTEEPyiZSEZO5Yc4U5wc8SbX5738Y3BVw6CB3VP0RFSgpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bFFf5Np2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mCDPJ5Eu; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bFFf5Np2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mCDPJ5Eu"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 544021400189;
	Wed, 17 Sep 2025 09:53:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 17 Sep 2025 09:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1758117235;
	 x=1758203635; bh=KyAyNU0stzH5+nBkwzNFubhBBWZhE4oIe57wfYEV904=; b=
	bFFf5Np2TZwVy8Yvwxc9/SxBzDOXJrTW9ef1p85tuC/7+7kblpsQKY1IklaznKlH
	F4gyVWa6fnbJS0MB1ZfqVt1ENfj8/WkVTrmOXncV1THF0A//OkHM9hw0nnv6onJJ
	nnrh7OYzH96blp+uPM0hgngDjpf4S2gQEQQiucfZtEZDZDuUVjZU8mBQOyGt36c/
	/C0HZOAK0TXE2TVVGS335K88kSe+nDshl61REmQqUn/ZwIxJWSi6OEkh8BcS6sMa
	GrQG0Fl6V8wwWUL2Uk9PnUAGPnwdP2y9g6iDMs6RcVuR0zOemKxEngIbkCoC7goZ
	EnfpzyFz0heJ6MBNvQkNHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758117235; x=
	1758203635; bh=KyAyNU0stzH5+nBkwzNFubhBBWZhE4oIe57wfYEV904=; b=m
	CDPJ5EuRIR5J7m4p9VjUNe2m4BYvB81A0fOfubIMe9NPUvc/Pt6jcPFbO5amXxyI
	lbyZa79mI15b/aO8svaPNj3jkSwlRvz9xbXcGrlF3RnjJ9IcRo2IwMQU+/HgxFoE
	+RhLfGrwnNvtHrbkt+6sskyykf4TziBFEDD2D3YW8iQ1lsLNw4N/D+ZFDw9exlkr
	I3Ne7WeNAuMj8sDse9pHpj5ltDfq8HbogKryoNd/BuZpNKDGNluMMT0xfJ1jzx8v
	pTcS2W4tbCxD9UP7F1t4i2OwU87Ek7d4g1aA35s5picgZHTFnFcAxIM5d+pjBaoZ
	rpLfdOgtXLxsbyUIajjow==
X-ME-Sender: <xms:c73KaIukpzi36FUqWUnqhj3wkMGbjm1NhbMo6CfnlMxV2sgzX6cqPQ>
    <xme:c73KaA-EbJr7eizTwTCMLyFCZusZFBn2JqRvEoHLCyM6ojnMIx2W88E1xLd74faCW
    LkfNfoVhvc9lroPYA>
X-ME-Received: <xmr:c73KaKPeToQT-92Y4WPqlByYCnsDxtZjW8eWrLCs427Cl87v9zcUN4m-6iBdeCh2MGXkGRy-lfORLR6H--Bpkstdw16Iu826RBfIh8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:c73KaGH69P7KLeUlBpFK5JH5r2MhjIwMaHM55JoIN9w7WAh__CvyLw>
    <xmx:c73KaAQbqpqlXuLD9FfxjvGC5IoMHgvY87E6cgrzG727EgTU7N_lXA>
    <xmx:c73KaLtgnGQDAiRQKb4spPHO_kXLaJQ__BoVtHl7TbbjWvnnbwvTFg>
    <xmx:c73KaAJzUqNpmKYd0mMdN5AAn6sl9pf6cvD5NZMIdRZNYpFdaMxy5g>
    <xmx:c73KaBefXrsO06VEyH17mOIg3il0MfgjU7pvmrq52zzRK32SRdalRZWs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 09:53:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,  Ezekiel Newren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 00/17] Use rust types in xdiff.
In-Reply-To: <CABPp-BH-oaV+fJ4u50oofy54ycE5oKoYJ6O1XgEt_JfDSgXvxg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 16 Sep 2025 19:16:28 -0700")
References: <pull.2048.git.git.1757274320.gitgitgadget@gmail.com>
	<xmqqcy7qm582.fsf@gitster.g>
	<CAH=ZcbCra35t7sxnwTvaw2oQeh6VL719v4Hx1fjDTGiU5Gmh-w@mail.gmail.com>
	<CABPp-BH-oaV+fJ4u50oofy54ycE5oKoYJ6O1XgEt_JfDSgXvxg@mail.gmail.com>
Date: Wed, 17 Sep 2025 06:53:53 -0700
Message-ID: <xmqqjz1xi3ri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Tue, Sep 16, 2025 at 3:01 PM Ezekiel Newren <ezekielnewren@gmail.com> wrote:
>>
>> On Tue, Sep 16, 2025 at 3:56 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > I think we saw that the earlier part were read carefully by Elijah
>> > (and others may have read without finding anything worth commenting
>> > on), so should we split this into two parts and start merging the
>> > early 9 down to 'next' and then to 'master'?
>>
>> I agree. 1-9 are ready to go. Do I need to create a new version of
>> this patch series? let it stand as is until it's been merged into
>> master, or something else?
>
> I think 1-9 are close to ready to go, but there's several small
> cleanups that would be nice to have in a v2 on patches 2, 4, 7, 8, 9.
> See my comments on the patches, but it's things like adding detail to
> commit messages or otherwise touching those up, removing orthogonal
> style cleanups (or making them a separate patch), and removing extra
> blank lines.  Could we get a re-roll of just the first 9 patches with
> these addressed?  Then I think it'd be ready to merge down to 'next'.

Thanks for being careful.  I went back to the review thread for
additional and/or unaddressed comments, and I agree that we may want
a bit of final polish.

Thanks.
