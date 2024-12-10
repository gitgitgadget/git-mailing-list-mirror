Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B24478F5B
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830989; cv=none; b=KEUW6oLhncK17VKTblmzb8gnmhceE2rHkifs1gKdU8A/LeybSDKHYCMshCX+r1o2izJfrbYa19rT6CCnIUzKTlNFKcTGb+ykjItTjn4bcfOPtLHENEy3Ga6cNi7zRBzJZOg3lmhRN1bvq/OA5OcxBHeFpGst1E/6wrQUvzsjA0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830989; c=relaxed/simple;
	bh=OxbhM632CSjJXrAEdtR2QnIf2yotaSxx7aOLNzkBRIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DQ6/YFjsn6w3fOitb6XbTaiKH+QwLaKHxoOrd6zXSa4VrPrTZ6ttP8C84BKrQ7+6464iEH4A+wSHHR5vJE5DcrgBVidiLONeoOAnDuPI1cI8FDoyKiMHejbpyEIJ08xU1HGtHZhvG4hBrLS/aQnopTHeJPqFenquO4gf6B6u6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vtj6824R; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vtj6824R"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A994138418A;
	Tue, 10 Dec 2024 06:43:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 10 Dec 2024 06:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733830985; x=1733917385; bh=yzadLGyShSc9Frlf/qudUxzqHmHfCfQGm9n
	1VtBJB/k=; b=vtj6824R744y6kV9lQCnETeqUCnidXPdndf9L4q511BzU5omZRc
	DEQWFPrIli3Y9FrqU2UJTCm56HFGkTo3K7da4eRIUnNOTKvqxNTKPHI53vE6MCJS
	qecpBa+AFGYBs0+HFyndwVOMCIJB2sVKXJlpKhTgM3JbQ/lKW/GgXuWJZQEAILhN
	UbT0v/dWK6rJpp6XLoI8Lbw4ZKcKul2valpmX9E5dAz0zW91mckLnQjG6+oCMQV8
	tyDBHffxeiHyCO8z0MfPfeMTtL9Vpok2zlPa71ZOyzEe7GdwFdZyJiHQzr+L9hdH
	uLWTsEnKIA46dBLM4wWbcU0topq0EwIRJmg==
X-ME-Sender: <xms:SClYZyewjV0qaJMYmLUqbGft0M1lWT7ycNrnuEnGg_Id3W7e9JtGNQ>
    <xme:SClYZ8MmgZ-qvG-vNfCawK-ErXOpJfnathAXVDuhHroEEgR2-AIqPsGNBwyG1s4IW
    1mgYFoW_z9cjsPiww>
X-ME-Received: <xmr:SClYZzgL9b-4Z5ChcH5w8_47PfryunQZM3wc_zU1YDqUgkSY99FrWdjEXM5XLtkI0f9NAJvgRzBadb73IGCTOTvuVE9K5qOleXsTJNc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:SSlYZ_-C7Q-v5JBSsxEYMYyEMsy-PfLKIUs8Ac8sfJbEnylwMgsM5Q>
    <xmx:SSlYZ-ukKU1VvzsAHz2I5rX7IVAuo0jcvzVxy-vqs5xLZRxB8zGrPQ>
    <xmx:SSlYZ2H2cJhscG4Yw2qaQpY6uAQAmKcopLlNPK0V3lYUsciUKDxByw>
    <xmx:SSlYZ9OefRf4BQmipRWVpJNjlPQ-m7sPoBKDA1k-fDoq2tFOH-ie_Q>
    <xmx:SSlYZ8AxXfRtXDZC37iiMeKOL5WTWuTJHbCP-NAgcgaNJF0eOqEyTCty>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 06:43:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 5/5] doc: add technical design doc for large object
 promisors
In-Reply-To: <20241206124248.160494-6-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 6 Dec 2024 13:42:48 +0100")
References: <20240910163000.1985723-1-christian.couder@gmail.com>
	<20241206124248.160494-1-christian.couder@gmail.com>
	<20241206124248.160494-6-christian.couder@gmail.com>
Date: Tue, 10 Dec 2024 20:43:03 +0900
Message-ID: <xmqqjzc7lq60.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> +We will call a "Large Object Promisor", or "LOP" in short, a promisor
> +remote which is used to store only large blobs and which is separate
> +from the main remote that should store the other Git objects and the
> +rest of the repos.
> +
> +By extension, we will also call "Large Object Promisor", or LOP, the
> +effort described in this document to add a set of features to make it
> +easier to handle large blobs/files in Git by using LOPs.
> +
> +This effort would especially improve things on the server side, and
> +especially for large blobs that are already compressed in a binary
> +format.

The implementation on the server side can be hidden and be improved
as long as we have a reasonable wire protocol.  As it stands, even
with the promisor-remote referral extension, the data coming from
LOP still is expected to be a pack stream, which I am not sure is a
good match.  Is the expectation (yes, I know the document later says
it won't go into storage layer, but still, in order to get the
details of the protocol extension right, we MUST have some idea on
the characteristics the storage layer has so that the protocol would
work well with the storage implementation with such characteristics)
that we give up on deltifying these LOP objects (which might be a
sensible assumption, if they are incompressible large binary gunk),
we store each object in LOP as base representation inside a pack
stream (i.e. the in-pack "undeltified representation" defined in
Documentation/gitformat-pack.txt), so that to send these LOP objects
is just the matter of preparing the pack header (PACK + version +
numobjects) and then concatenating these objects while computing the
running checksum to place in the trailer of the pack stream?  Could
it still be too expensive for the server side, having to compute the
running sum, and we might want to update the object transfer part of
the pack stream definition somehow to reduce the load on the server
side?

> +- We will not discuss those client side improvements here, as they
> +  would require changes in different parts of Git than this effort.
> ++
> +So we don't pretend to fully replace Git LFS with only this effort,
> +but we nevertheless believe that it can significantly improve the
> +current situation on the server side, and that other separate
> +efforts could also improve the situation on the client side.

We still need to come up with a minimally working client side
components, if our goal were to only improve the server side, in
order to demonstrate the benefit of the effort.

> +In other words, the goal of this document is not to talk about all the
> +possible ways to optimize how Git could handle large blobs, but to
> +describe how a LOP based solution could work well and alleviate a
> +number of current issues in the context of Git clients and servers
> +sharing Git objects.

But if you do not discuss even a single way, and handwave "we'll
have this magical object storage that would solve all the problems
for us", then we cannot really tell if the problem is solved by us,
or by handwaved away by assuming the magical object storage.  We'd
need at least one working example.

> +6) A protocol negotiation should happen when a client clones
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When a client clones from a main repo, there should be a protocol
> +negotiation so that the server can advertise one or more LOPs and so
> +that the client and the server can discuss if the client could
> +directly use a LOP the server is advertising. If the client and the
> +server can agree on that, then the client would be able to get the
> +large blobs directly from the LOP and the server would not need to
> +fetch those blobs from the LOP to be able to serve the client.
> +
> +Note
> +++++
> +
> +For fetches instead of clones, see the "What about fetches?" FAQ entry
> +below.
> +
> +Rationale
> ++++++++++
> +
> +Security, configurability and efficiency of setting things up.

It is unclear how it improves security and configurability if we
limit the protocol exchange only at the clone time (implying that
later either side cannot change it).  It will lead to security
issues if we assume that it is impossible for one side to "lie" to
the other side what they earlier agreed on (unless we somehow make
it actually impossible to lie to the other side, of course).

> +7) A client can offload to a LOP
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When a client is using a LOP that is also a LOP of its main remote,
> +the client should be able to offload some large blobs it has fetched,
> +but might not need anymore, to the LOP.

For a client that _creates_ a large object, the situation would be
the same, right?  After it creates several versions of the opening
segment of, say, a movie, the latest version may be still wanted,
but the creating client may want to offload earlier versions.

