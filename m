Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952EC36D500
	for <git@vger.kernel.org>; Mon, 24 Nov 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764012915; cv=none; b=Nj/ESIwXzQ8lGMADk+IEJJagfYLhKvmXZpMJi9RbzISKlwtIJwNv1pFrVinjmxu/V0nUXVKkWctbPmrZQpPMXTiKkYTvHgZl0JxoYCUDohfg1eQIkDZtqfqd4FZ2tbcVS7+J/GaavAH28qwBPpk2lh6KaWBpRgxI1Xg1cbxk51A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764012915; c=relaxed/simple;
	bh=aZWAWXisH6JB6iD539HqonWcY4hXaVqISOjm//8unEE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DmLI0baeb3bgxONzK/BignThWti48RFEZ7W+th/KMbLWZASjKLCL6d/OYaByrI1i5QDkfLlkcBrBYUyPD2Oru/xPiHA9yWwNKsroK8h6Scc7RNaL0ToSZElkf3Gwi4uHGUOWXSjKvbf9rdPBTy7VQW3qj8t4eNjNljq6wSaVw0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kgKtNXn2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PZY+BS+3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kgKtNXn2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PZY+BS+3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C51DEEC01D1;
	Mon, 24 Nov 2025 14:35:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 24 Nov 2025 14:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764012910; x=1764099310; bh=Eo/3rxOjno
	g4qzY3mZySsWtK0oEf9R/3S1+v+5UEBgk=; b=kgKtNXn2REU+2wg2SRkWE7zknZ
	vHriOigne5B9K4Fj36fara/jf97O13IUiUL79Gcl7UyX6kgDf3Rvd9GWOG9JnG/c
	ltBRORlvH/sQZvTTp6ywdmf/RV1erJYUbL5LBKoMUuHzbKC3mLsMfqRRJ/mol3dG
	URRehBVygp8nrgKM/YFThhWZxWbXWbGxuF0esdWsJ13NQfOCKy13AmU7tfLexWyE
	PeUu692BSu9BEl7ddQakQlF9S8oF7+LkYhy0mnvZoy4/ius0kut9geFBvNoXxBn0
	1HIE4t9Luhq6+J/P3108GdDXimYo2HekIR4mvoS7pZy9EIxsJjSGrMFzY9lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764012910; x=1764099310; bh=Eo/3rxOjnog4qzY3mZySsWtK0oEf9R/3S1+
	v+5UEBgk=; b=PZY+BS+3/nEbmG/WErKdI0gdhFL21cqZynnkXJq6FsSNV9J1zRw
	HipH9rH1X1mm5XopxDO4wgqLFLCKrthl0Eq1UfGRdj6vmi8umFq/nfxr3V0fUQQN
	Wd6z/84bTaYD1CeTWswZv73Ag0OWdxaNfV+7GElntBcmIoxYAFRhOrFhYFiHVPYE
	FvwGPRbyVPgD72ssBgSqPk3J0DAzj4M9nkn/S7V4btqsCpsyEyrrq0riKkiS/Cwz
	IPQCOD10ovVRLpuPCusMpQCGsE8OqJSZiLO6KVv1UdwdkE1X/qbwoWRHxAkMFVmg
	6Vj0J56Niljt5cwzCyn0YntqQ7VIk81R0WA==
X-ME-Sender: <xms:brMkadzr4MPh9lhIMnD1Ifqm1F6VV4rMyq9zWosCN00BDGXYGgXQ5A>
    <xme:brMkaUL7qMx0QF4Jj-zdt2-ctYk70kmUpN7n5RLFOCO3Esy6TCnLWmL75qZNWS1fQ
    vdf5AijYNudECYT6oN6qjlVIYCfw8iWzZMNabwjJmT4qP_j_25KQTs>
X-ME-Received: <xmr:brMkafrZmnXkkS-reNh0ijsDvFEBDkfru2bRrhUTMB4f1Fj_rdMCjD6kk804s0FN723lQwtoHZYpvnnE2pktldqPDZfU-d3-EI-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrtghhvgdrhhhithesghhmrghilhdrtghomhdprh
    gtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:brMkabKV3nbzBNfJmum6jOcro04NOlV6a2XJbLQbLCOJXWwr-Doo-A>
    <xmx:brMkacRlcSi3KCjYmJW4Lke38o2MtHcU0gScIpRGgH0bjmnoMJNLCw>
    <xmx:brMkaSvGYuaPKwPaL65kwOnDlMNB3ixzeBY0PGyRbbq5WiU9XP6kVA>
    <xmx:brMkaVZK9iWnIbKLlJrxo3lQhwYGutAFj0w4VsYLd8qApPA9MuzuoA>
    <xmx:brMkaTYeAEnpgDZFnXSKaaGl12T255-KVWnQ1GxwdKhKMQzVrsVmVzah>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Nov 2025 14:35:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kache Hit" <kache.hit@gmail.com>
Cc: "Chris Torek" <chris.torek@gmail.com>,  "Johannes Sixt" <j6t@kdbg.org>,
  <git@vger.kernel.org>
Subject: Re: Filter smudge for secret restoration: no disk access?
In-Reply-To: <DEH58DEF5MGO.2CFIKCM2CAQY2@gmail.com> (Kache Hit's message of
	"Mon, 24 Nov 2025 10:40:49 -0800")
References: <DEGR5XSM0EVG.27IMOKOK1O98Y@gmail.com>
	<9aa7cfdb-fc50-4ceb-936c-2ed441c462a3@kdbg.org>
	<CAPx1GvcXkXMpWgOyMWdfHXGEDJQY4wJrJV0p7LHBMeQFPMDHnQ@mail.gmail.com>
	<DEH58DEF5MGO.2CFIKCM2CAQY2@gmail.com>
Date: Mon, 24 Nov 2025 11:35:08 -0800
Message-ID: <xmqqms4bw7f7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kache Hit" <kache.hit@gmail.com> writes:

> On Mon Nov 24, 2025 at 1:01 AM PST, Johannes Sixt wrote:
>> A smudge filter must read its stdin and write the result to stdout. The
>> presence of %f in the configuration does not change this.
>>
>> The filter can inspect the file name it receives via the %f token (note:
>> the *name* of the file, not the file itself) to draw additional hints
>> how to process the data, but it still has to read stdin and write to stdout.
>
> Yes, I underststand. I'm asking why it's necessary that smudge not read
> from disk, even as it properly satisfies that stdin/stdout operation, as
> in my Python implementation of `smudge()`

I do not think it is a total dogmatic prohibition, but is a
practical piece of advice to be prepared in a situation where the
file %f does not exist on the disk in the working tree.  Also even
when the file %f does exist, its contents would not match (because
it was smudged when it was checked out, and the user may have
further modified it) what in the tree of the commit you are
switching out of.

Suppose you added a path F and G with a SAME smudge/clean filter
pair to the history at commit X.  You check out a commit before that
happened:

	$ git checkout -b practice X~1

and then try to come back to commit after X:

	$ git checkout X

Git would read the cleaned contents of blobs X:F and X:G, invokes
your smudge filter once for each of these blobs, and feeds the blob
contents to it.  Your smudge filter learns in its one of the two
invocations that it is being handed the clean contents and it is
expected to smudge it for path F via %f, and then the other
invocation of the same smudge filter is told that it is now being
asked to smudge for path G.

If F or G exists on the disk, surely, the smudge filter can read it,
but in this situation, because you are coming from X~1 before F and
G appeared in the history, these files are not on disk in your
working tree.

The smudge filter needs to be careful about a similar situation
where commit Y that is a descendant of X modifies F and/or G.  When
Y is checked out and you want to switch to X, working tree may have
smudged versions of F and G from Y when your smudge filter is
called.  Or it may happen during a checkout of F or G, and one of
the things the checkout needs to do may be to remove the existing
file from the working tree, and then create a file anew (probably in
a temporary file) and move it to the final place, in which case,
your smudge filter may be called during "create a file anew" phase,
where the old file F or G may be missing from the working tree.
Even if F and G are there, it may be from commit Y and their
contents may have nothing to do with the version of the files your
smudge filter is trying to turn the clean blob data taken from
commit X.

The note from the "git help attributes" you cited summarizes the
advice concisely.

    Note that "%f" is the name of the path that is being worked on. Depending
    on the version that is being filtered, the corresponding file on disk may
    not exist, or may have different contents. So, smudge and clean commands
    should not try to access the file on disk, but only act as filters on the
    content provided to them on standard input.

The smudge filter needs to be prepared to work in such scenarios.

Perhaps "Depending on ..." talks too much without giving readers
enough benefit.  A shorter description like this one ...

    Note that the purpose of %f is to tell the filter for what output
    path it is asked to smudge the clean blob data, and should not be
    used for anything else.

... may be less confusing, perhaps?

