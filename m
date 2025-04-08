Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3337E229B01
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122475; cv=none; b=PiK9FFvBWhztv1bjtJzsghPlHyCIhh//c0io/ytrf9VR8HJkjAw9mBDmyBf3rLrxGki4f9KAsC2op3HbuqNlxaKRoO1y9zC3QknXRik0EB+NckDJ8q+ypadRCRA37zgFuRZxYIyeJtBLEY4mMk81LJePWIEWkspruTAYHSF9ryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122475; c=relaxed/simple;
	bh=/0rwihkjInn8vqkYLgqMUwRZm8NM74dJI384eCrwLng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gegGJ3ALfF3ZKBykVM2aOxHjPjsHTMOItVO4JXjbpK8AZToI13LldQctEyMlltprwmeOHgdMx6VF11OKhjyRz7TymntdHScsrm5iG6u46nSu+XJcvHNBn3cFBVf6ywjKKC4RXln00GHvt4+3sGbOWE0OVJIFmlPdksFroVc2oYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rn0rBO9w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fVPLsPj7; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rn0rBO9w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fVPLsPj7"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2FF2B1140117;
	Tue,  8 Apr 2025 10:27:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 08 Apr 2025 10:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744122472; x=1744208872; bh=+zbH57scl2
	7RKOodVEvCNjUF9gaBY9j7h13/cquxAqE=; b=Rn0rBO9wrJdRy22ITL+2q//7TC
	B15urgCG4MC6SP8Zo99kb0YmAWf73Aj0h3aJY1o9bZb/fUACLgXSm9gHpqUg/M80
	uZwPNuIVS74VdHGZN+F8wMswKOqlydqr5Ek4fXGXiGEYT6nBvyoRSSjgPKB1VRhk
	hX4TDqFU/luxCTGWyfiER0UK6v+y9wLUzcuneLSBWaBIKm3BCOhfPRYJEIuZzf8X
	cWYGgEuGz0j2KuS/IAx4rWFZJUPiqXOmrBIgTRVH+m3Zs75PaYkTvcia6lD0Qrgt
	/vu+4wsmix3gP2hJctU0mmycb7vUztT/cKISNroXCJ6CzMkezfaaAnt9zrkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744122472; x=1744208872; bh=+zbH57scl27RKOodVEvCNjUF9gaBY9j7h13
	/cquxAqE=; b=fVPLsPj7aUG8LoNeO+qyioUgI26bsZFD7cmYGa/7LYLjkSf2KOx
	5plVBOPzKhu2zgQklPx4eOVENgDVB1jvp+s489IOt38vSm2Zl9na7Qe74pCuh6Pz
	nOnNKhwDrXP0MJRq+xtRy4+/rreyRSN+zZu9nzG2ulAGkCqp6gwHP+f88PX1dBZb
	guWEexJL1xwDG9RmU5SxTF4z/XRjxacslL6KfFJQpyHo9g0I2iA8WOiMFCxX1U4G
	mrZH6DUxFgML/UbitUkqiJ9M1NsQ62fBAFaQkmi8F2jb9lIMVA5NpHbh6MbQezQN
	xGlS4SUomrFgVYNdKcKpIDYF3pmjhP8HTGQ==
X-ME-Sender: <xms:ZzL1Z53KdzrCQcpo8bQtkhciw27yrivy62yyW4qo_B9h_S41JXl9uA>
    <xme:ZzL1ZwFvvLsK9aDny-KlSUF0gZbpvjYGB57NHseRBVqLMOkie9llbihueZHhNfZ81
    esZJ1W15wdbeL0M8A>
X-ME-Received: <xmr:ZzL1Z56BQmXhYR_kQXrB6mE1npQsTZgmtK-YxKdNgfsM9jHPFk34UcdLVqx4ZJGJjE6DsdpTFCDXPv2Ep-yp1wpqzEG3ObCjJyww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepteeijefgieduheffhfetgeeggedtvdef
    ieeiuddvudetkeetgeefteejjefghfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhtihhnvh
    honhiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepvghkvghmphhinhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepshgtohhtthesghhithgsuhhtlhgvrhdrtghomhdprhgtphhtthhopehrvghm
    ohessghuvghniihlihdruggvvhdprhgtphhtthhopehphhhilhhiphhmvghtiihgvghrse
    gslhhuvgifihhnrdgthhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ZzL1Z22QUKTQYrjTvKs9DSCMjHLipN2mr11UR7HMw86AcDBE54B--A>
    <xmx:ZzL1Z8Ewzz6C9Jmk5I4MPqL_QSPW3jD-RgsD9UOQ85i_eUbRnAZluQ>
    <xmx:ZzL1Z3_E17Qk1a8dg4NPSHdhATFKoUXltiyRg4Ym6H1wD2ePfgzL2Q>
    <xmx:ZzL1Z5lVGpTyQJQ4K-KdlTs1jRAb6wj56sJXJ_xrBCsw2o_PeoSOQA>
    <xmx:aDL1Z6uImYjmY7tRqaOohulWaKaBvwApKi2-CgwrumOsvelg7UYQfW_F>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 10:27:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@google.com>
Cc: Git Mailing List <git@vger.kernel.org>,  Edwin Kempin
 <ekempin@google.com>,  Scott Chacon <scott@gitbutler.com>,
  remo@buenzli.dev,  "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
In-Reply-To: <CAESOdVC8m6VjQtyVi8O8bLWyJFaq7wnQ8U2kxW6SHnoXpCd14w@mail.gmail.com>
	(Martin von Zweigbergk's message of "Mon, 7 Apr 2025 22:35:03 -0700")
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com>
	<xmqq4iyzn0vn.fsf@gitster.g> <xmqqzfgrjyws.fsf@gitster.g>
	<CAESOdVC8m6VjQtyVi8O8bLWyJFaq7wnQ8U2kxW6SHnoXpCd14w@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 08 Apr 2025 07:27:50 -0700
Message-ID: <xmqqv7reybh5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Martin von Zweigbergk <martinvonz@google.com> writes:

>> A set of individual commits that share the same "change ID" is,
>> unlike reflog entries which is an ordered set of tip of topics, not
>> inherently ordered.  This is inevitable in the distributed world
>> where many people can simultaneously work on improving a single
>> "change" in many different ways, but making it difficult if not
>> impossible to see how things evolved, simply because you first need
>> to figure out the order of these commits that share the same "change
>> ID".  Some may be independently evolved from the same ancestor
>> iteration.  Some may be repeatedly worked on on a single strand of
>> pearls (much like how development recorded in reflog entries of a
>> single branch in a single user set-up goes).  I guess you would need
>> a way to record the predecessor vs successor relationship of various
>> commits that share the same "change ID", much like commits form DAG
>> to represent ancestor vs descendant relationship.
>
> That is correct. The change ID should be sufficient for handling
> simple distributed cases involving a single remote but it's not a full
> replacement for something like Mercurial's Changeset Evolution [1].

Just a random thought.  We could very easily replace "change ID"
with a concept of predecessor-successor commits.

Just like we can represent parents-children NxM transitive relation
only with 0 or more "parent" commit object headers, we can record
zero or more "predecessor" trailer in the commit log.

 (1) a commit with no "predecessor" is like "root commit" in the
     commit history topology.  It is a brand new change that took
     inspiration from nobody else and that is not a polished form of
     any other existing commit.

 (2) a commit created as a refinement for one or more existing
     commits record each of them as "predecessor" to it.  Having
     more than one of them is like a "merge commit" in the commit
     history topology and represents that two patches were squashed
     into one.

 (3) Splitting an originally large change into multiple changes can
     be represented the same way.  They share the same commit as
     their "predecessor".  Perhaps you have originally two-commit
     series, A and B, and split them differently in such a way that
     C has half of a and D has the rest of A plus B.  In which case,
     C has A as its predecessor while D has both A and B as its
     predecessor.

 (4) Just like we can use auxiliary data structures like bitmaps to
     figure out reachability without following all the links in the
     commit history topology, we should be able to learn how a new
     change was born, and trace how it evolved into newer iteration
     of the moral equivalent of the change, possibly as a series
     with mutiple commits, using auxiliary data structure, which
     would represent predecessor-successor NxM transitive relation
     in a similar way in a form that is efficient to access.

Something like this should allow us avoid relying on "change ID"s
that can collide elsewhere in the world without having a central
authority to assign them.
