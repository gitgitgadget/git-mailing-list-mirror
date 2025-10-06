Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600C1A5B9E
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759779444; cv=none; b=ALVO2aBcDK8FtJf8dYd0XyuLRMO73J9II4/usDlfU/LSOaeDyF5/rc/8aEInA0JwFK/5t9nB0E4L/VUVLu7p1heyI570MCtmz5O0YLGzv9Hrepd+JbrtPsgCAGn6UNEb/0MeI3jb+V3FFyZ9FIdeKqGfIONRGtJx+7+PBrUIKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759779444; c=relaxed/simple;
	bh=sz4YstEWu7B9EzRMH06e/8TFTgX3f+PcNGVt7YDBgq4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IWymsRU75droZ8+Rt33d4Us3wAwpgiF7AoedUfKzMrmT9t9lbGg8+hAwpdOnVdyZruFJUnOwE1CFXzNSiN76Alkuq0537edujglIvV81GXDLPFIGzHiYX+psOG9A8vX/KzxN/OZBUVcJVIUEPbzRtGOaO04WVzNIfQBqERGV2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=bzJANZ59; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jYlw1pP1; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="bzJANZ59";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jYlw1pP1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0796B1D00470;
	Mon,  6 Oct 2025 15:37:19 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Mon, 06 Oct 2025 15:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759779438;
	 x=1759865838; bh=f0twlvS46ZId9hbeZ8XWgFUOgEnr3wO5EroAyaHs4DQ=; b=
	bzJANZ59pnAQ7Fh30pQqzq1RQyXHxcBq2kxqcu8/h9jN0E4LU+CgJCn2euPPjrMh
	xtmzuhiMG1bDJOgb4u28krp1cAE9j1Ci9xcCKztToJb267g1pQD1rwPhB9zbPZC3
	+QdkXhDfVpRGmfvpqqjWtNPzvW19dxsh8k9GmxoiX0y3BcVRBMzZbGzOh3t+xEFw
	SWm1iIQSMRs6PzQ1oZfP7OVmok1UURa2y85YhYyRqrt/dPFsa/nRq3kuePWJk5je
	BALEi2x9LfGcttDuNOjtoYrPYqjOyJ31i3YKIxQOkvbKGS503t7vrFercjcKXSKo
	ynJSlpmb0JKoqNNJ9xs2gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1759779438; x=1759865838; bh=f
	0twlvS46ZId9hbeZ8XWgFUOgEnr3wO5EroAyaHs4DQ=; b=jYlw1pP1PYY/oU9nE
	f9iM4ZqjVB9Lw21BrBrYZIwXynM2qsiIxC0A12+Gxua0Ii6wAmNzzYouAFOv/Ecw
	IkCki6azYdefwtP0BIEWWP0VYTGkLi6pvZngQZou5PGfQQlV3XxNUzWSEcC1D00s
	7Cfm6/J5vxNacf2M3NNaIr1Yiztl/57JRrPfHMHiTxCkvFuFac9/KwmH/OBf0WC2
	fbnCE6b0/p1qM7blzEuKpopoh1BR0+mLEvHyOOdVthSzvHAnbO7sCo7po0B3Z4zH
	E4Q/DsRH47QlJMPLCA35XMptnw7v1YaCva6sM7YscffkwyS/7pVTIVQyZZd6GTjr
	udJrA==
X-ME-Sender: <xms:bhrkaFAqf20NsPcZ92sD7AShWxBUoz46XSsGYttsZUB2PgdbT7wpWw>
    <xme:bhrkaOW3dxzDi5ugMDnBHRM3beT39HDG13tnfZ_3IM1u2cp113OPAcN_IH2zvt_h2
    FnRqrQ4hiB5iM5H_G7wPxHMmiXnaIbRD2p7bAhkotKxWUr8X79WYLeW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedflfhulhhirgcu
    gfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnhepte
    dvtdduveetgeduvdeufefgteeuvddtheeftdehgfduveektdetleeihfefgfehnecuffho
    mhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepjhhulhhirgesjhhvnhhsrdgtrgdpnhgspghrtghpthht
    ohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhh
    gruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:bhrkaD-DsTX7Tkjn4GGg6rpqK1f4EfLaJhgR9B2RO_kGlC9wVJUA7w>
    <xmx:bhrkaGn39GLmybv35nhtovH4nPrNl17QdvKrvQnEGcK3W1Jh6tL7Rw>
    <xmx:bhrkaN8u82WuV1iGYLT8CqmqRVD06mZdOcDetPYES0jxV22NbicuPA>
    <xmx:bhrkaMlYDurokdpw3hzD-MobG3xEgrkn6rtkigZubOz7xlNZOusMQw>
    <xmx:bhrkaBc-HDDFkGayOswS07DJdMWp6H7vKJKRaxtYzDgodSft8FUIgrbF>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 942CF780054; Mon,  6 Oct 2025 15:37:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Mon, 06 Oct 2025 15:36:54 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <51e0a55c-1f1d-4cae-9459-8c2b9220e52d@app.fastmail.com>
In-Reply-To: <8df4c59c-4d27-4f36-a231-f7af32ddf149@app.fastmail.com>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <8df4c59c-4d27-4f36-a231-f7af32ddf149@app.fastmail.com>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thanks for the review!

>> 2. Don't mention that the full name of the branch `main` is
>>    technically `refs/heads/main`. This should likely change but I
>>    haven't worked out how to do it in a clear way yet.
>
> I think this is worth getting into.  This is a pretty
> user-facing concept.

I think I'll see if I can figure out a way to mention this and at the
same time remove most of the rest of the references to the `.git`
directory when explaining references (which you talked about
further down), including packed refs.

>> +
>> +1. <<objects,Objects>>: commits, trees, blobs, and tag objects
>> +2. <<references,References>>: branches, tags,
>> +   remote-tracking branches, etc
>> +3. <<index,The index>>, also known as the staging area
>> +4. <<reflogs,Reflogs>>
>
> Reflogs is certainly auxiliary ref data. What makes it qualify as
> one-of-the-four?  I am open to it being both, to be clear.

The reason I like to talk about reflogs is that it gives you a
way to "undo" Git operations that can be really useful.=20
And any Git command that updates refs can updates that
ref's reflog.

Understanding how reflogs work helps to understand what the
limitations of using reflogs to undo mistakes is: for example
the index is not a ref, so you can't use the reflog to undo
changes to the index.

>> +2. A *commit message*
>> +3. All the *files* in the commit, stored as a *<<tree,tree>>*
>> +4. An *author* and the time the commit was authored
>> +5. A *committer* and the time the commit was committed
>> ++
>> +Here's how an example commit is stored:
>> ++
>> +----
>> +tree 1b61de420a21a2f1aaef93e38ecd0e45e8bc9f0a
>> +parent 4ccb6d7b8869a86aae2e84c56523f8705b50c647
>> +author Maya <maya@example.com> 1759173425 -0400
>> +committer Maya <maya@example.com> 1759173425 -0400
>> +
>> +Add README
>> +----
>> ++
>> +Like all other objects, commits can never be changed after they're
>> created.
>> +For example, "amending" a commit with `git commit --amend` creates a
>> new commit.
>
>> +The old commit will eventually be deleted by `git gc`.
>
> Maybe this could be moved to a part about what happens (eventually) to
> unreachable objects?
>
> Mentioning `git gc` and how things will get deleted raises
> questions naturally. Like why would they be deleted? Okay
> that=E2=80=99s clear: the previous commit will be replaced by the
> amended one. Then when it is not reachable by anything
> (even the reflog) it will get garbage collected.
>
> It all follows. But is the reader necessarily mature enough
> in their understanding to make the inference?
>
> This is a long-winded way of saying: if you=E2=80=99re gonna discuss
> `git gc` you might need to go into all of these concepts.

If folks here think this is a reasonable document to add to
Git I'll try get some beta readers to read this, see which parts
folks find confusing, and address those, keeping the `git gc`
stuff in mind.

Similarly for the style comments.

>> +blobs::
>> +    A blob is how Git represents a file. A blob object contains the
>> +    file's contents.
>> ++
>> +Storing a new blob for every new version of a file can get big, so
>> +`git gc` periodically compresses objects for efficiency in
>> `.git/objects/pack`.
>
> This gets into mentioning implementation files(?) like you mentioned in
> the commit message.

That's true! The reason I think this is important to mention is that I f=
ind
that people often "reject" information that they find implausible, even
if it comes from a credible source. ("that can't be true! I must be
not understanding correctly. Oh well, I'll just ignore that!")

I sometimes hear from users that "commits can't be snapshots", because
it would take up too much disk space to store every version of
every commit. So I find that sometimes explaining a little bit about the
implementation can make the information more memorable.

Certainly I'm not able to remember details that don't make sense
with my mental model of how computers work and I don't expect other
people to either, so I think it's important to give an explanation that
handles the biggest "objections".

> 1. That it=E2=80=99s a packfile and where it is might be too much deta=
il for
>    this doc
> 2. I vaguely recall documents discussing what happens to =E2=80=9Cstor=
ing every
>    version=E2=80=9D discussing deltas instead of packs? Again, I am no=
t a Git
>    developer though.

I could be wrong about the details here, I'm not a Git developer either.
From https://git-scm.com/book/en/v2/Git-Internals-Packfiles
it looks like packfiles are implemented using deltas.

>> +
>> +References can either be:
>> +
>> +1. References to an object ID, usually a <<commit,commit>> ID
>> +2. References to another reference. This is called a "symbolic
>> reference".
>
> You seem to have used `**` when introducing terms:
>
>     This is a *symbolic reference*

Thanks, will take a look at that.

>> +[[reflogs]]
>> +REFLOGS
>> +-------
>> +
>> +Git stores the history of branch, tag, and HEAD refs in a reflog
>> +(you should read "reflog" as "ref log"). Not every ref is logged by
>
> You=E2=80=99ve heard of the re-flog too?

haha exactly, I just want folks to understand why it's called that :)

> I appreciate that this is the first version and you might have plans
> after this one. But I wonder if this doc could use a fair number of
> `gitlink` to branch out to all the other parts. Like git-reflog(1),
> gitglossary(7).

That's reasonable. Do you often use the "See also" section of
man pages? I've never looked at them so I'm always curious about
how people are actually using them in practice.

I also need to think about what else could link *to* this, because
without attention to discoverability probably nobody will find it.
My main idea so far is actually to add it to
https://git-scm.com/learn
but I wanted to send it here instead of adding it to the website
directly because I thought it could benefit from a more detailed
review.

> Thanks for starting on a whole new doc. That must take quite
> some effort.

All the work on documentation takes a lot of effort, in some
ways it's easier to write something new than to edit something
existing :)
