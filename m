Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430CE1E1A3F
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 14:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122466; cv=none; b=UiZTrm1jYxkd/FYAQ1gIoFenQmy175kBCOd8ZJBoqYdqu0EwNOVtoSG6BPwGdJEpFctPViad71Y8XLRA8T/3rAQ4wPFTHaUO8KdfCzWNlqX64sxm9AV++aIEBcEhWRqk6+EThzHtuxcEobGSlLBLe3HWn56KwWVcHmqU8ad7fiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122466; c=relaxed/simple;
	bh=/0rwihkjInn8vqkYLgqMUwRZm8NM74dJI384eCrwLng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jmY1i604MVBA+Ax0EEc2CPD/f/0Gx8W2DabYjKH+w0c9YVNSr5gHCv5fL4VXAlrCm5aUJG/QqKxoV0t9mFa+TTFpNYGz8Y4BzE1ijPgUOwPOwvk9Lj5IJqG/msGbEosqZNOqY2nsJVk2/efcSmB6KyBiIbdibJRWU5QtpARHX/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iXuPOHBq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TsiDAUcW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iXuPOHBq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TsiDAUcW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 45CA313801A0;
	Tue,  8 Apr 2025 10:27:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 08 Apr 2025 10:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744122461; x=1744208861; bh=+zbH57scl2
	7RKOodVEvCNjUF9gaBY9j7h13/cquxAqE=; b=iXuPOHBqrsrBRvzFB7TrjBBbjA
	FNWzmQBG4AUmaROm5RyUVFKl96K2eXxdTFVgZ7kNeMMc3NCrslGDwec3EL5B2wat
	nkoiTLKJLM64xGvGY2DZ/Rhl1Bv91y+82023APiHisQXyXlMnX6GT8ODCqKP93du
	joojQdhjeAREZ+yfsSePKCn/RXE3hHIHAaJ+TGTzz/1tw5490GE6h5DhoOTLTBCV
	79MXrZXPwGdC9wxQvN+fMYypRGCQpqIaZO4ex8Ev0z2yzkLf4XKZQsq8000qEDxJ
	ranDdTa6nxdJrTpbVkI/g4tyDn9I+gX5ItANT3aCi7qcsJhNkfwhFX827hGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744122461; x=1744208861; bh=+zbH57scl27RKOodVEvCNjUF9gaBY9j7h13
	/cquxAqE=; b=TsiDAUcWcbCv1X+/B9iY2wujT5b7bRNaL/0KYcTmV+/yZXMjeHg
	EN6yZ7C8frzuw9r6bvOD5Tv+KjNlHB+4PBuO9KxFG8fuRkHzqIhiRfNb68ZashwU
	mzcp2YRb890l2mz+DYrWmcrOfUbOgDzCMf5o5/mA1v4NO1LIKiSbG36UyPHdg/xq
	Euw3491W/5kQZWHuw3Y77puh9H9qsU34S9P1Qh7Ho2dTTf2DpEfHyIaqko+6F133
	R1KRfs1DRJF5vFwzb7cT35UI0Cvhebe3AY0ngXodHvy1g7ks7/36WIf4b9+KrPdr
	1nvmLv0lmBhsVSgSv5DXVclFixabi6tIR4g==
X-ME-Sender: <xms:XDL1Z2HNLA_UQ2v4TI4UOhcC5wYtNluoDf2IEQ3G_Q-IiSuuLigKWA>
    <xme:XDL1Z3W0-nFMlB8vQVl5Zg3XCLe_XA3pFywkcBT4q7ZxFOTZWQEPrf038PoEkGaP9
    cBEDW3mbIXwXAZxeA>
X-ME-Received: <xmr:XDL1ZwJMHI8NZxP1PQeRo9h2mhFxoOow4cUvPLnd16gXb0NAF6534SEf1k12Ik9RIMYD8mm5Z1uSdW7qAqdEL-obFNcBSA6BZBMG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeffeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhtihhnvh
    honhiisehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepvghkvghmphhinhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepshgtohhtthesghhithgsuhhtlhgvrhdrtghomhdprhgtphhtthhopehrvghm
    ohessghuvghniihlihdruggvvhdprhgtphhtthhopehphhhilhhiphhmvghtiihgvghrse
    gslhhuvgifihhnrdgthhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XDL1ZwGVEW43UOTnFavwH_tJzdjeK4IceOaReBQWILAogPZTCQEu4Q>
    <xmx:XDL1Z8UbiyBT6sGRi0XC76uztPB4XWS0VjUzuXRKtwoDTjLRq0ZTVg>
    <xmx:XDL1ZzNtsMYpWc_NCzPcg1uRiKnNmU5yFsoumpLVzxUMLlq6HBx1VA>
    <xmx:XDL1Zz3i23JMlgMCFs0grr_6zjiXzQPxp9UcCtt4ESOpR37yRqOY8A>
    <xmx:XTL1Z2WonD02ilrtKGj8P6RxLWmggD5vuiNcTBy7zGKDB7jW8I6mjlCO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 10:27:40 -0400 (EDT)
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
X-Gnus-Delayed: Tue, 08 Apr 2025 09:27:34 -0700
Date: Tue, 08 Apr 2025 07:27:39 -0700
Message-ID: <xmqqwmbuybhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
