Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF953815C5
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 03:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777086399; cv=none; b=UIyFoYxVWXAxwQTYzvJBXZh6e3UONWUtNrjN22vqwL9asGg2oklxZlVnvRKgjGpLVUNBP4aRCtDjHofQffTfTQHWGkbKNn7EowC9PqM9S6L88Z48y8rBGdqPLPTfgP4bIn9auIKyHKUDwebpN4Dz15pKUug7WqBr++Ms7JpsguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777086399; c=relaxed/simple;
	bh=q++9r5hwKleVj/tlmhhIOzMxnVqlSqnHd2dswQRlTyg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pNJprYp8K7M+mJ6AFroQPGiOOxc6uXvmXasdxSsVH3S5KF7UG/ix8oloNGnKmlcjZf+4IaIKTPy2Z82mRNkrfOgrxvolNX8sPeeu/MYjrtU4aT5vv6D6s6Dcs7Vis4OR96dGpsuQvaCKKpHNYq22UNQxVdY4gdd7UetJwFOl8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cSLrSpx9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=upZhbs5m; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cSLrSpx9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="upZhbs5m"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ED9407A015D;
	Fri, 24 Apr 2026 23:06:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 24 Apr 2026 23:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1777086395; x=1777172795; bh=ZdQAFwuDY5
	y/Sx3VoHTRWpJ45qQepPLATfIJ2ylUd3A=; b=cSLrSpx9mi5DG/UZDT2keoxaV4
	zkhA+J3Cydn47/qBqEoH7uYKr4FaORWvzBa8eqyWYg6P2tncbszOYWnnMl20UFzv
	QowQogIiK9DAcfSLfiGZ7BfCXNn7z11fOGKeVfdm1XMpS42KOGKO4HjqhAYrwkuG
	uOCT6VGHZksZPKMdWBX9Yq/i5hpXJP/F/T1gNxqMJzDifXj/5cwrkyJp0PPsXwK/
	pTHAlTlQfZJcDk0+jwPcrK4tTnsO0z4zPv7+9C71MyfEJ79y3f6tsxq4dqy4pUox
	GNXIYyEMKsZzR3h8JzkpmeVs2T+XjbdylhFdP9qB9eIV3vfeRX4vvOTi9JJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1777086395; x=1777172795; bh=ZdQAFwuDY5y/Sx3VoHTRWpJ45qQepPLATfI
	J2ylUd3A=; b=upZhbs5mIRWpXdSZ0WBtzBb5BwvsCmchUngMKig7VnLi3RBa/l/
	mc1DgOOVYDIT0bvmJYkh/gM2Kyq3zln9sTtlir6W6ZP2+dpwb8pBtEXDY7XWLapz
	iaLqUcRf0HpkT91KXcqUmv2Ut/jN/mDj75cpYs1UKaSDsdFVGBRO+/47kZlOsKQC
	PE21AqU+uPBiet1a2tJkkkedyNpuvPYlBydTVRT560G/y3PByQOGifpZWJBygvor
	5zipv8bB4UbKP447the5/QkarE48crShnkC6J84EP5RjdUkOiKqHaXb6Dx79DWiI
	siBoNxgUQBKOv7Sqg1WynWIU6vQCRvH2ECw==
X-ME-Sender: <xms:uy_saZALWFOUThFJ8ERq4w1zv3OtBuPrshXzs4f631JCjRoEDP4MoQ>
    <xme:uy_sad7KCnLg65StiBHVoXZsDSAltSoNwW3CYiDZrxwJalWrSygzfp4AqzXqdbEaV
    jGMLUnxPBAeW3c9RYrNye4O-ea21HfWCLWV5B05ycmZ8tFDOoLUPQ>
X-ME-Received: <xmr:uy_saQ32c0YIl8xULciH1F3aAOx-fEk3LFdeFcsyN1t03AGHgyFK8Qsk5vsbf0UJPvOqk3EkxMWXuSxJN6kqtkWvrh_ZQaRhqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejudejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdr
    khhnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhs
    thihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheptggufihhihht
    vgefsehpmhdrmhgvpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:uy_saRkR2a26l8i4fRi5Rb0NqEC4opkviSmaFb6r01RhoQ4Do62oWw>
    <xmx:uy_saW7IvhQCx3JDBSt7nJ37D5F3t79JfyF0rR0qXCWLzghHXzzbVA>
    <xmx:uy_sacl2YHRfVIjjX_Iyog9iVNPhZiIWjO7PULSviDrD7tCLlbwyww>
    <xmx:uy_saZUMBYHC6LrmMEsyda2fApGjRQimoBjBN0S0mtvpwoqipQzyrA>
    <xmx:uy_saduHLvcEBfvzr7KdGHwLEKzTr9_2noGMxRANvrIExspJNnovhu9F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 23:06:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  "brian m . carlson" <sandals@crustytoothpaste.net>,  Patrick Steinhardt
 <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Caleb White
 <cdwhite3@pm.me>,  Calvin Wan <calvinwan@google.com>,  Elijah Newren
 <newren@gmail.com>,  Andrew Berry <andrew@furrypaws.ca>,  Jeff King
 <peff@peff.net>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] dir: use per-worktree repository ignore patterns upon
 request
In-Reply-To: <4a8d1289-2e2b-4fd6-8ada-143992dd7c4d@gmail.com> (Phillip Wood's
	message of "Fri, 24 Apr 2026 20:53:31 +0100")
References: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
	<4a8d1289-2e2b-4fd6-8ada-143992dd7c4d@gmail.com>
Date: Sat, 25 Apr 2026 12:06:34 +0900
Message-ID: <xmqq7bpvwxfp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Sharing the same set of exclude patterns between all worktrees seems 
> like a reasonable thing to do - it would be a pain to have to populate 
> them every time a new worktree was created.
>
> 	git rev-parse --git-path info/exclude
>
> always returns the correct path because it uses repo_git_path() which 
> knows whether a particular path is per-worktree or resides under 
> $GIT_COMMON_DIR. It is best to avoid constructing paths manually using 
> "git rev-parse --git-dir"

Great to see the best practice raised, like this.

>> Some users may prefer each worktree use its own ignore file; some may
>> prefer both; some may prefer the current behavior.
>
> This sounds quite hypothetical - do we have a concrete use case for 
> per-worktree exclude files?

I can see if somebody wants to have different subset of paths
checked out by setting up separate sparse settings.  But marking
what paths are never be part of the project (which is what exclude
is about)?  I do not think it is useful in general.

The only case I can think of is a repository that houses more than
one completely unrelated histories, perhaps being cheapster on a
hosting site that charges per number of repositories or something
silly like that.

My https://git.kernel.org/pub/scm/git/git.git/ repository houses two
completely unrelated histories, one the project data, and 'todo'
that are mostly about tools I personally use to maintain the
project.  Ideally, the latter branch should have been created and
maintained as a separate repository, but back them I didn't have
write access outside pub/scm/git/git.git/ (notably pub/scm/git/
itself was not writable to me) and that was the only reason why that
unrelated history is pushed into the same repository as a separate
and unrelated 'todo' branch.  It is not a recommended practice, and
if this configuration is primarily to cater to such layout, I do not
think we want to add it.
