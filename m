Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6966023AD
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727837695; cv=none; b=dFeBlTZAA8CtTnlxFm/ggR2lfY8tEwZgIP6orepQuuOLIoiDzkwqsBqCvo/ayA2jMHQfLHrLnfW/T+sL7S4xUH2qW0X4YosoB8VDo0V9hNIn4HLMg0Laf1L39be89cdKaD+DQytOIHrdh6GRv+3SAFHXFA8TIT18jD5HnSaWHZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727837695; c=relaxed/simple;
	bh=TlglVAYamBGN4CI2Q8ddgGE3YT/9+wqOi8u2Ya5o3aM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TcckRF8XbaRryg1w7wQmzB0KlmjzvcG9nIWeN+T/1gO2m5t23xVxkD5tuzLNPL7pN05BTMUbPX1EUD2htxfOFwiz4LKxb5VhcTnT7T7Jjd8dsZCQeRN7j1uVrPclMqLLphY/1FFziJAWlUIGcxX8+crrQ5G7+r56QwnV2xkfJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uDFGVZkt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ID1Pb1SY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uDFGVZkt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ID1Pb1SY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70560114022C;
	Tue,  1 Oct 2024 22:54:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 01 Oct 2024 22:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727837692;
	 x=1727924092; bh=XIrNkKco1m1wTAN9EDzS3R/sYtvDA/J9gDqhKQVLvmg=; b=
	uDFGVZktI51AswX+WzPJJSz7kWuGsa+fVH/HXz5AuvQjhr/y7vDPrzbrzcPqkSId
	9171qgIrfVdpK5JzovAtqW/judmH0iBtFtEViuVziVy6kRHZoxjVwQCWX642sDji
	modMm7eEId8/o3gyH9IGlwff1LFPwqty4YkO4nEOvm+jQ3wG66i7FA++VODTB/U+
	fbC+oxqgOzWnH8If6ywg3Qc2vT14gyoT820nPRt3Abr71Gn14pAgGA41nTEy35sU
	6oXQGQx/saNua0SKiTDB8jsOPir/balBlVW2Dj63yBJf7dfYTIQstrTsvX+3naL5
	/qUayoVq/Z4H+O0ZLVwngg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727837692; x=
	1727924092; bh=XIrNkKco1m1wTAN9EDzS3R/sYtvDA/J9gDqhKQVLvmg=; b=I
	D1Pb1SY66LLbH0E3HkrOwwfVMh8zhPmoacxA21GtCEj1iCYgXTVwf3ZmgfcUfUVw
	7BACF4T54Vht6smsaPoc50fGpSztMjyB6KatLyjllF7hQODCBjoLIFLHfPbBMKmE
	CPa9Gl1PT78zUwr8PxVoRagA5e1LOBU7QYTUkSmpvtES4PDeI+Xc2maSBPW54Eea
	xduIzNoEA31UtH+CKFVNDGzg0gX0Dm0AHozP55RBMymfmWupirjaFBYje/m2aPxV
	Xej1qfFwWOoLIyW9NDx0nSD38TW/7xi9rjwptPESP3Ij59jVZ7JwloaBMOdxVt13
	dxAaeALfd7gSgX2ovTcig==
X-ME-Sender: <xms:_LX8ZiVVRE9WnFfeydY-l2_c02bHXqlbF15JSlKSG6aRpVRfPtohLQ>
    <xme:_LX8ZumaqQCamNiqMqJO-DksdPyGZorAVEdTv8WTaNbyJp4TLeD_iPxwcspwJyKP9
    vHw89ILviSqPmsC2w>
X-ME-Received: <xmr:_LX8ZmajkH1FfYRy2s1mZpnrsVXJJNSYPmXrcQ8CH4wNVbIfHRmIJk4ZRuK7e9OmbUmXUq1dhbD5yRlQtieu6KDnnc0fHe1C4uQKINA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpefhtedvjeehudehgeelheefieevtdegleef
    vdfftdevtdduffeikeeiieejvdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhope
    hhrghnhigrnhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnth
    grnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohgu
    uddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegvmhhrrghsshesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepshhokhgtvghvihgtsehgohhoghhlvgdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_LX8ZpWiTsQ37XDQ2ZXmYYctEcEWeefo12Q8z-p81eg3Py68fA2vow>
    <xmx:_LX8ZsnbLI8dyf1pysIfcjYUE9_F_XYWtn9B2Zc2HLAE3FoewDY9yA>
    <xmx:_LX8ZufGwq89cEVEYvSWWc4a-uI05nnzD10mMdcF8W_cmtemKwcMeg>
    <xmx:_LX8ZuHLM_aZCFSQHb7oC7-Y2axuwzdwCOUrNWxC0y8kOIAhjSZX1g>
    <xmx:_LX8ZpiS1R2HUhd2gXnzEoI2OmJblVRAELJy--U2OW02XUmZ39RKj00s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 22:54:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Han Young <hanyang.tony@bytedance.com>,  git@vger.kernel.org,  Jonathan
 Tan <jonathantanmy@google.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Enrico Mrass <emrass@google.com>,  sokcevic@google.com
Subject: Re: Missing Promisor Objects in Partial Repo Design Doc
In-Reply-To: <20241001191811.1934900-1-calvinwan@google.com> (Calvin Wan's
	message of "Tue, 1 Oct 2024 19:17:51 +0000")
References: <20241001191811.1934900-1-calvinwan@google.com>
Date: Tue, 01 Oct 2024 19:54:50 -0700
Message-ID: <xmqqo743qkn9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


> Missing Promisor Objects in Partial Repo Design Doc
> ===================================================
>
> Basic Reproduction Steps
> ------------------------
>
>  - Partial clone repository
>  - Create local commit and push
>  - Fetch new changes
>  - Garbage collection
>
> State After Reproduction
> ------------------------
>
> commit  tree  blob
>   C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
>   |
>   C2b ---- T2b -- B2b (created locally, in non-promisor pack)
>   |
>   C2a ---- T2a -- B2a (created locally, in non-promisor pack)
>   |
>   C1 ---- T1 -- B1 (fetched from remote, in promisor pack)
>
> Explanation of the Problem
> --------------------------
>
> In a partial clone repository, non-promisor commits are locally
> committed as children of promisor commits and then pushed up to the
> server. Fetches of new history can result in promisor commits that have
> non-promisor commits as ancestors. During garbage collection, objects
> are repacked in 2 steps. In the first step, if there is more than one
> promisor packfile, all objects in promisor packfiles are repacked into a
> single promisor packfile. In the second step, a revision walk is made
> from all refs (and some other things like HEAD and reflog entries) that
> stops whenever it encounters a promisor object. In the example above, if
> a ref pointed directly to C2a, it would be returned by the walk (as an
> object to be packed). But if we only had a ref pointing to C3, the
> revision walk immediately sees that it is a promisor object, does not
> return it, and does not iterate through its parents.

True.  Will it become even worse, if a protocol extension Christian
proposes starts suggesting a repository that is not lazy to add a
promisor remote?  In such a set-up, perhaps all history leading to
C2b down to the root are local, but C3 may have come from a promisor
remote (hence in a promisor pack).

> (C2b is a bit of a special case. Despite not being in a promisor pack,
> it is still considered to be a promisor object since C3 directly
> references it.)

Yes, and I suspect the root cause of this confusion is because
"promisor object", as defined today, is a flawed concept.  If C2b
were pointed by a local ref, just like the case the ref points at
C2a, they should be treated the same way, as both of them are
locally created.  To put it another way, presumably the local have
already been pushed out to elsewhere and the promisor remote got
hold of them, and that is why C3 can build on top of them.  And the
fact C2b is directly reachable from C3 and C2a is not should not
have any relevance if C2a or C2b are not _included_ in promisor
packs (hence both of them need to be included in the local pack).

Two concepts that would have been useful are (1) objects that are in
promisor packs and (2) objects that are reachable from an object
that is in a promisor pack.  I do not see how the current definition
of "promisor objects" (i.e. in a promisor pack, or one hop from an
object in a promisor pack) is useful in any context.

> If we think this is a bad state, we should propagate the “promisor-ness”
> of C3 to its ancestors. Git commands should either prevent this state
> from occurring or tolerate it and fix it when we can. If we did run into
> this state unexpectedly, then it would be considered a BUG.

Yup, that is the basis of the solutions we saw proposed so far.

> If we think it is a valid state, we should NOT propagate the
> “promisor-ness” of C3 to its ancestors. Git commands should respect that
> this is a possible state and be able to work around it. Therefore, this
> bug would then be strictly caused by garbage collection

Yes, that is possibly an alternative.

> Bad State Solutions
> ===================
>
> Fetch negotiation
> -----------------
> Implemented at
> https://lore.kernel.org/git/20240919234741.1317946-1-calvinwan@google.com/
>
> During fetch negotiation, if a commit is not in a promisor pack and
> therefore local, do not declare it as "have" so they can be fetched into
> a promisor pack.
>
> Cost:
> - Creation of set of promisor pack objects (by iterating through every
>   .idx of promisor packs)

What is "promisor PACK objects"?  Is it different from the "promisor
objects" (i.e. what I called the useless definition above)?

> - Refetch number of local commits
>
> Pros: Implementation is simple, client doesn’t have to repack, prevents
> state from ever occurring in the repository.
>
> Cons: Network cost of refetching could be high if many local commits
> need to be refetched.

What if we get into the same state by creating local C4, which gets
to outside and on top of which C5 is built, which is now sitting at
the tip of the remote history and we fetch from them?  In order to
include C4 in the "promisor pack", we refrain from saying C4 is a
"have" for us and refetch.  Would C2 be fetched again?

I do not think C2 would be, because we made it an object in a
promisor pack when we "fixed" the history for C3.

So the cost will not grow proportionally to the depth of the
history, which makes it OK from my point of view.

> Garbage Collection repack
> -------------------------
> Not yet implemented.
>
> Same concept at “fetch repack”, but happens during garbage collection
> instead. The traversal is more expensive since we no longer have access
> to what was recently fetched so we have to traverse through all promisor
> packs to collect tips of “bad” history.

In other words, with the status quo, "git gc" that attempts to
repack "objects in promisor packs" and "other objects that did not
get repacked in the step that repack objects in promisor packs"
separately, it implements the latter in a buggy way and discards
some objects.  And fixing that bug by doing the right thing is
expensive.

Stepping back a bit, why is the loss of C2a/C2b/C2 a problem after
"git gc"?  Wouldn't these "missing" objects be lazily fetchable, now
C3 is known to the remote and the remote promises everything
reachable from what they offer are (re)fetchable from them?  IOW, is
this a correctness issue, or only performance issue (of having to
re-fetch what we once locally had)?

> Cons: Packing local objects into promisor packs means that it is no
> longer possible to detect if an object is missing due to repository
> corruption or because we need to fetch it from a promisor remote.

Is this true?  Can we tell, when trying to access C2a/C2b/C2 after
the current version of "git gc" removes them from the local object
store, that they are missing due to repository corruption?  After
all, C3 can reach them so wouldn't it be possible for us to fetch
them from the promisor remote?

After a lazy clone that omits a lot of objects acquires many objects
over time by fetching missing objects on demand, wouldn't we want to
have an option to "slim" the local repository by discarding some of
these objects (the ones that are least frequently used), relying on
the promise by the promisor remote that even if we did so, they can
be fetched again?  Can we treat loss of C2a/C2b/C2 as if such a
feature prematurely kicked in?  Or are we failing to refetch them
for some reason?

> Packing local objects into promisor packs means that garbage collection
> will no longer remove unreachable local objects.
>
> Valid State Solutions
> =====================
> Garbage Collection check
> ------------------------
> Not yet implemented.
>
> Currently during the garbage collection rev walk, whenever a promisor
> commit is reached, it is marked UNINTERESTING, and then subsequently all
> ancestors of the promisor commit are traversed and also marked
> UNINTERESTING. Therefore, add a check for whether a commit is local or
> not during promisor commit ancestor traversal and do not mark local
> commits as UNINTERESTING.
>
> commit  tree  blob
>   C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
>   |
>   C2 ---- T2 -- B2 (created locally, in non-promisor pack, gc does not delete)
>   |
>   C1 ---- T1 -- B1 (fetched from remote, in promisor pack)
>
> Cost:
> - Adds an additional check to every ancestor of a promisor commit.
>
> This is practically the only solution if the state is valid. Fsck would
> also have to start checking for validity of ancestors of promisor
> commits instead of ignoring them as it currently does.

In the longer term, this looks like the most straight-forward and
easy to explain solution to me.

> Optimizations
> =============
>
> The “creation of set of promisor pack objects” can be replaced with
> “creation of set of non-promisor objects” since the latter is almost
> always cheaper and we can check for non-existence rather than existence.
> This does not work for “fetch negotiation” since if we have a commit
> that's in both a promisor pack and a non-promisor pack, the algorithm's
> correctness relies on the fact that we report it as a promisor object
> (because we really need the server to re-send it).
