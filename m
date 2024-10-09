Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E72517332C
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728501043; cv=none; b=oPqgk9XX68/LDYnK/DN/HxN2p3AJIuxVGq43wnZOZauRHjTBHbUqDn3yZiD+2KQnO4wmukK0SHW/E7tgWZYkPFFHSJE/IQ2eLcSDFXp+YjpVzs2OVrtl2IfzZnea3AHbbk8H9Qba9tzktQ+Lro4efnSBL11cSPGC0bpREhn4eAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728501043; c=relaxed/simple;
	bh=OAmuAnkCNPM/MszklnPsNBViAkha5QNkmrbVVN/GgBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fMcx3P5IUJIZhHF2P2VrdMw1CZHJRdJlPJG1fhvlH6+rRbtFeInyu56okhZcz07DQkYH+x0sNo+QfgIQ6yFxME57nPrqgiBdfuKcfygEt8GyL4hDXslkKkTj8/K88x9bcn3tvmOo53KjAeNYz78hIpOewIhMmYIl9R4+2wo1fII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AWho4vxw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cJrfjcpC; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AWho4vxw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cJrfjcpC"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1DE2A11401FC;
	Wed,  9 Oct 2024 15:10:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 09 Oct 2024 15:10:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728501040; x=1728587440; bh=E/0jHHt+AJ
	qJ+7SuDAvRb5H58G5HtqSVNDRS6quSNhA=; b=AWho4vxwYt01caTLbxmmiT5eD+
	AIMYBBvgmm01gdWebPGQKOPblT7Q4OCgkH61UnNUEE4yxssNTN7ILnZQU9nIA9ml
	0SBqqeIqLn3F6drtZELZ9Vas0aWSnQnuAzc9CVhPrIQjpREkE2l9V1LJuGI3is2T
	r95hhfizPm9+I4CnVoHplwC00wvB0AoiSYhvlawiDAf8Xr5cs4XB6zySXV/2DLD5
	OzlUfJJ5aAU+fAiO9MK3aSz7AKVzR7+noho85PB5xdv253HfHNErv51jUVgE+yON
	B3hFqig6SFxGjfmP11/7IiZ3bzEEi3m+pUw09mlpfKvMU4iIPoixh7C7kvew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728501040; x=1728587440; bh=E/0jHHt+AJqJ+7SuDAvRb5H58G5H
	tqSVNDRS6quSNhA=; b=cJrfjcpCzUERso6Cn6yAIRA6hcg2xA3L7yJdsKq2BZ71
	uee/NFb/qw2QvH+Ot6Ef1KrfE8zGfYJBA6q3EQLsPwY0s92/fuFA2fu8Nfo0osFZ
	cM/DpN2s27VNdbfQv3I2I7XiYBDhX80M5quK8fzqpI6yFiQK3oR/mxbfZs3EJ67R
	WmI1ogJpGlIXENbwQKmQD9WbE3of/DBk0Fot6MldKemio4DsQVPRYRKK4Bzbyet+
	n101sNike/1TCA22V8x3GCPCEjawunW24Fg3ju/GaU1AkMpMgE9aBSbLYnBAgHkR
	7dfGWXeDS2Ao1yk+4wQ7sEUtcpbV21gCh1KNMm1fNQ==
X-ME-Sender: <xms:L9UGZyDiF2oyXvyNr8aslVMZR1wElTf1JypPobkG7DAnsfJwhpXqJQ>
    <xme:L9UGZ8gjyh6yI42hnmk-_QrVhy-rYEjYM21JYB0E_s6zMVHV9E-1BbPeB0ksPTadp
    DNStnYCaV3Yo3NDjQ>
X-ME-Received: <xmr:L9UGZ1lE9xtAlZ2hs0mrXGNw0SEWj6POI5Ru_1E4MHGLtekv8-Mq5sfeL0jgXC365KAo_mEka7-tFpFbYT4E-bJXbgE5sW11QIr->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtugifhhhithgvfe
    esphhmrdhmvgdprhgtphhtthhopeguvghvnhhulhhlodgtugifhhhithgvfedrphhmrdhm
    vgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:L9UGZwx8n4S-7NXaQN14XHhIjvHIWMaAdgpDYTLOthEzxxPWUmYmWg>
    <xmx:L9UGZ3RdrsB8dX7l214q93lV8CPHBL4-1xYyuDJVRUgZkb_2KSrGOw>
    <xmx:L9UGZ7aeCvLDaobDbUdLpRjJII2MXNEnGJxuz9sYSFLH1DNCDQ7KZg>
    <xmx:L9UGZwSpgi-j8oZPp6J8agOSGtWLZnCyH57FVqOfVEuxfSCsaClz7Q>
    <xmx:MNUGZ1PUVoXuQMuRr8eq7wSmE-tuzGIfRcMMgTtsakCu4VQu-NNVPFUp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 15:10:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: Caleb White via B4 Relay <devnull+cdwhite3.pm.me@kernel.org>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] worktree: link worktrees with relative paths
In-Reply-To: <k3X5W4US76LBJ_IUq-quVRha2jd-4iWJ9yX6Ukh6-ifZdWC3iajoUJ8VUyTDfkJHSqiD1RJlqIuVlDGIsReR_SDREVWyHGIqsXhazvJu1ek=@pm.me>
	(Caleb White's message of "Wed, 09 Oct 2024 18:34:10 +0000")
References: <20241007-wt_relative_paths-v3-0-622cf18c45eb@pm.me>
	<20241007-wt_relative_paths-v3-2-622cf18c45eb@pm.me>
	<xmqqmsjexkcg.fsf@gitster.g>
	<k3X5W4US76LBJ_IUq-quVRha2jd-4iWJ9yX6Ukh6-ifZdWC3iajoUJ8VUyTDfkJHSqiD1RJlqIuVlDGIsReR_SDREVWyHGIqsXhazvJu1ek=@pm.me>
Date: Wed, 09 Oct 2024 12:10:38 -0700
Message-ID: <xmqqy12xqehd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

> What's the best way to parameterize the worktree tests? I would like
> to run the same tests for both absolute and relative paths and I'm
> not particularly a fan of just copying them all into new *-relative.sh
> files.

What I meant by interoperability tests are a lot smaller scale.

A test that creates worktree/repository pair without the option to
use relative, and then tries to use such a worktree/repository pair
with the option would simulate "how well the newer Git handles an
existing repository", and another test that creates with the option
to use relative and uses the worktree/repository without the option
would simulate "how well existing versions of Git works when seeing
a worktree made with the newer git with the relative option".

By "parameterise", if you mean running a set of worktree/repository
tests without the "relative" option enabled, and run the same set of
tests with the option enabled, you could model it after how t8001
and t8002 (or t5560 and t5561) share a lot of same tests that are in
a file that is included by both of them.  In smaller scale, it is
common to have an ad-hoc construct like:

	for conf in relative absolute
	do
		test_expect_success ... 
		test_expect_success ... 
		test_expect_success ... 
	done

that has bunch of test_expect_success, which may change the
behaviour depending on the value of $conf, not &&-chained inside the
for loop.  You can use a nested loop (one for preparing, the other
for testing the use of worktree) if you want to test the full
matrix.

I do not offhand know if such parametralized tests are necessary in
the context of this change, though.

Thanks.
