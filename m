Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48354213E82
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690995; cv=none; b=SqJiq6Y3IY7B8wPa/eywBWkKIRYGMMRCBO1zgUZdySgZboGxcmnm1Rd6mmiy2ojKJ5O9P6tWpRhK7egJTnldI34P6QxjKmYieM7n4ZaxxMc1hHJ9VsNJ6yMO8Q3Laaa0Td3betuyr/0br8727p4PQvKovvVv7a1Y3OhEGRZrURI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690995; c=relaxed/simple;
	bh=tPK6bTZ/Yx7QTYB82QxQl1ncaC+frKHozEiZB7C2Zlg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nN6CTXOrzjMx/ebGtzk6fp4M9iDix7V/A9TTAAtWk7h641naUQZBhk+BukdDVdMoDqR+WK54e+BHYq3HAWDsQAZZZrFVofRMvookHCNKTIdEyfRdUfzP4vASVR2IkIv4eHGQ77HEC8g7LEzZHDLA697LpFWg//OfFCVDhXMfvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TTVsOs76; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O7shO0Tj; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TTVsOs76";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O7shO0Tj"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39AB325400A4;
	Tue,  4 Feb 2025 12:43:12 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 04 Feb 2025 12:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1738690992;
	 x=1738777392; bh=VhKydg3VyaXfKXvK1s69gz4DEMobDFxzAuBAK8tDtrk=; b=
	TTVsOs76NuAfEXek7Ig+NzQt+LshQLDX+2eByyrJ6VOQ8XOHvhN/q+l/krdJTvuY
	sMTdTul1oLnGsK0jw4me7kZrtYppGzaNbea8t3nKccn0s2wqbAL1wcBvmWqwb3Y4
	HIGQQREgHEUNfTE+fd/y/OONK+OgYefrya4U0ExQf9rgpiA7zshYdKipGpSgv7Kr
	iAqKQ5G6PK4omXkXAN4PtNIN6MTMFPDpBzCeCPG+7MKNzDTy5zdVvWokw3wM4MCu
	lP1jVTA7UA6aADLEjGIj7LXg6+Mg9BVFIosCMqZsFSb3tcA7Yx4LMTMOqsx98dSJ
	347+O0njFv6IPzemSEOahw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738690992; x=
	1738777392; bh=VhKydg3VyaXfKXvK1s69gz4DEMobDFxzAuBAK8tDtrk=; b=O
	7shO0TjU2ws3zTcqirdYwqb4+WNfjXcQvEzus4hpzDjvBE3FV3LTJXRkz/XLPYLo
	coVv76m3Fmv80F82/3MN2ePubMs4MenSVzdSX4E7KugUq2B1Pnz4cvJ7Df2on2+V
	7VoN78r1gJhmvg2+WU15eGsTmVsKZn5uqAPirP+l9mqQqGXSSLQz6Lf7+lZzXuRo
	9EbLQsLB0vEbhh1DqEZDZrKsHoVdPDMyl0zyLmnHXmrZ/SFBWJxR2vXzybSY80kS
	S9m6UgzeBHrD2MWoVHcp5HA8GpHcPSKKiF1TEYA6fsjpvz62meTDAK5AuYU6XJzZ
	kf/MKLY8I77pitLPeY40g==
X-ME-Sender: <xms:r1GiZxmwih2dafFjGKXVB3Wk5VRBN42N6Bu_p5uLPyfWgd_B8AC35w>
    <xme:r1GiZ82MRXu3o6K9W7iXiBWg71kLU2qruQEeqgDyTUUhKIknzpsIJyMAAv7hR4cYE
    ai_6Dr-uilrz80J7A>
X-ME-Received: <xmr:r1GiZ3p5eYMPWmqQkaqCSwtBNamEm8MA5s37XRt3BFD1g4FhNZArZ_DRjL8Tue_yO_nTELOFo54Af2ACnh6pQ_bR0BOK1FDAarJq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    ehveeiieefheeuvddvvdfghfehudetfffhudelvdetudevgedvgfefieduledtvdenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrnhhuvghlrd
    hpohhrrdgrtggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:r1GiZxnBNyuU2QxJJUn2OysUaSKo3CdSrIT3DyaPzw709QIB03XuYg>
    <xmx:r1GiZ_1xiWsm9B8pbqWh-TxgE-0Z2G2_M1X3ujTp2lQJeBx2wKnmcw>
    <xmx:r1GiZwtzEUIqZvFmcGZbKYMJfgIGlDH3MykqADfbFrU3do45wiCwEQ>
    <xmx:r1GiZzVvi9npEdgAo8-jFHmx9X5Xe6axlAMd0QHG20qfvzy47V7hyQ>
    <xmx:sFGiZwwP87XmEcnGqdaxt1yHFK0tCooV7HzmI1g6ydJWHhDLsdfrltqo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 12:43:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Manuel =?utf-8?Q?Qui=C3=B1ones?= <manuel.por.aca@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Usability issue: "Your branch is up to date"
In-Reply-To: <CAPpV+Oaq3d3oNE-V3pnpQRNrGCoZr52uY91QtWYxcu1tgG_QXg@mail.gmail.com>
	("Manuel =?utf-8?Q?Qui=C3=B1ones=22's?= message of "Tue, 4 Feb 2025
 09:38:30 -0300")
References: <CAPpV+OaMcViVKok5U0-4HaYyPMKEA7BBzw4t113uAaMndjs5Cg@mail.gmail.com>
	<xmqqh65b2ci3.fsf@gitster.g> <xmqq34guzi0f.fsf@gitster.g>
	<CAPpV+Oaq3d3oNE-V3pnpQRNrGCoZr52uY91QtWYxcu1tgG_QXg@mail.gmail.com>
Date: Tue, 04 Feb 2025 09:43:10 -0800
Message-ID: <xmqqseottxld.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Manuel Quiñones <manuel.por.aca@gmail.com> writes:

> Thanks for the insightful explanation Junio! Looking forward, do you
> think that it could be possible to record the timestamp that the
> remote-tracking branch has been updated with the remote branch? In
> order to make such information available to the end user.

The time at which each remote-tracking branch was updated is already
recorded in the reflog.  What is missing is the timestamp that a
fetch checked if a remote-tracking branch needs updating, found that
the branch at the remote hasn't changed, and did not update the
remote-tracking branch.

You'd need to first design where to store that information and how.

It does not have to be in the reflog, but as a thought experiment,
let's take how the design would go if we decided to use reflog to
store that information.

What a reflog entry records, in textual form, looks like

<old-object-name> <new-object-name> <user-ident> <timestamp> <comment>

We can imagine adding a new reflog entry whenever "git fetch" finds
that the branch at the remote hasn't been updated, with the same
value in <old-object-name> and <new-object-name>.

A reflog file I randomly picked as a sample is ~5k long with 34
entries (it keeps track of my fetching from and pushing to
https://git.kernel.org/pub/scm/git/git.git/#master), so a reflog
costs around 150 bytes per entry, and if you fetch once every hour
that would be like ~3k per branch per day.

While that is a trivial and insignificant number from storage cost
point of view, if you are monitoring the progress of the remote with
"git reflog origin/main", I suspect that such a change would make it
unusably noisy, so "git reflog" command may need to grow an option
that tells it to skip these no-op entries.

As to required change to "git fetch", this may be a bit tricky.

IIRC (I am writing from the memory without looking at the code),
when you say "git fetch [<remote> [<refspec>...]]", what it does
is roughly to:

 - figure out what <remote> and <refspec>... to use from the
   configuration, if omitted on the command line.

 - connect to the remote, and ask the current value of their refs.

 - drop any refspec <src>:<dst> whose <dst> side already has the
   value the remote has.

 - drive the object transfer machinery to receive the pack data from
   the remote and store it locally.

 - update the remote-tracking branches.

And the last step is where the remote-tracking branches are updated,
together with their reflog (if enabled).  Because that step does not
even see the remote-tracking branches whose value do not need to
change (filtered out earlier to help reduce the number of refs fed
to the object transfer machinery), the "drop no-op early" part need
to be designed differently (e.g. mark them as no-op, so that the 
object tranfer machinery can notice them and ignore) and then the
"update refs" step can see these no-op updates.

I do not think writing the "no-op" reflog entries should be done at
a step separate from the step that writes the real ref updates, as I
suspect that such a separate update scheme would have a funny
interactions with "git fetch --atomic".

So, do I think it could be possible?  Sure.  Do I think it would be
too hard as a rocket surgery?  No.  Will I jump up and down excited
and start coding?  I am not interested all that much, but I can help
reviewing patches if somebody else works on it.

There may be some other downsides (other than the cost of storage
and making the reflog noisy) I haven't thought about, which need to
be considered if somebody decides to work on this.

Thanks.


