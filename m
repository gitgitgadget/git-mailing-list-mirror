Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7625D528
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228551; cv=none; b=aifLeFjbIgQFFxCCMnE7mahlyZLYrO4iT+b8tbN++V2hI5UvTqPy4my2kDLu85CI+PDeR6GRLXq2eTduw5iON9HzZzBKfbFrQpFgxQJzeZI9DD2L5T6OFIWiBeEYyYiPExoVJFh0jxp10AR/KK1H33zwpWo6bW/8waFDDH6Ld1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228551; c=relaxed/simple;
	bh=7/Z98DPF7wB/yoHEeAA7Ok2gJJ/mNL1gSeq0EgYx0UM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YlrMLivupzjWtzbwBDI8kJ+bGwuWc5YrtgSLS9IWblyZCuTZduvJSuEJdNB0XBT8Om53Gto4snDfWcyOJQfymok5aQPfNKoqn7dbRuPk28MmD/ePmIGW8qtGqpS3Ub+ddm6w++IkEFwaNEqfJNJzxwSKGSxEkw6GZFryxnTRZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=TtHLV99u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7hK1UBe; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="TtHLV99u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7hK1UBe"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 025B31D002CE;
	Thu, 18 Sep 2025 16:49:07 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Thu, 18 Sep 2025 16:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758228547;
	 x=1758314947; bh=ahl/4JG9cAj15a/cEGHrhvxn0uY2oLc8q2WcEbHgJBY=; b=
	TtHLV99uy7gboy2HFOjG55jkFS3ZFs9J6IJ+1k+LY/NImM41DZFuqgbVmsSNf/jN
	g4ZQ7mLgzN2nhHJcMKKoW8E1lQ3h1n3YDbLyfElqWaoCismI4k0mnrcyzdMu0tpf
	urswSuToaGCvc91JDR15pLrnazy2agaQIXdmZrlu0aDsJ93z46Mv2n72Ikm6l9gc
	jEFK4ypEZvTPGLXlVoCXfbyGtLxJ6vjfyBURUSxdQb0sCW9SR1BUx/enDa/Q7QVH
	HLoxTu7gcWmjIBdDxJsozbtmYfka5WFFQ1ph3M1zi5fuF/zhiGYUQSHTokkOhE5d
	rmhmCteYYU/olvWF3570Qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758228547; x=
	1758314947; bh=ahl/4JG9cAj15a/cEGHrhvxn0uY2oLc8q2WcEbHgJBY=; b=Z
	7hK1UBeNEfkmc61x3tUUG+SDA8/2W6PBcx/hce/SZ08f0cPEKonoxHQwCEE5kPIK
	6lcen71/Rlrfh/Up2GCssmDgfZwvljDOcFOLKwUhRrpQyQ+8GktFdzm0u11jjaQa
	EC6ohUVryPy/G+bOnlCTECpUilsLhq9+MnFegiPjn6bey9Kjw7oyjt6aHYG9ZF0f
	KmRnPuWsinl1DJObdNa+n0pR4EwZKnU1mGSfGqhILfFsaAY2zZ3izK1wdtuBxgu8
	yl1dVTU55gtG8QE31YetAMDIMeboO++Df5sNtdKe0f+iIt4/NTkZC6BtRVJahcpT
	FPnpw5IPMFkuSMIhG2ybw==
X-ME-Sender: <xms:Q3DMaCePvqnGbitbnejLae2DShQfVSr8w-q48YKrXnG2bUIOwFMe4A>
    <xme:Q3DMaMMZqoxidtQMu-VW2lwG_nY1-Iv57mB-x0gFkHNQ1rUu8YCTUjwKqK5-JrtEL
    LhiUPG8Oz8wyxKBSTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegjeeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertd
    ertddtnecuhfhrohhmpedflfhulhhirgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhs
    rdgtrgeqnecuggftrfgrthhtvghrnhepgfevkeduveeivdevueehhfdvteeggfffudefge
    dutdekgedtledtvefhtddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepjhhulhhirgesjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepfe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Q3DMaPGgtPQE8tTVzXcQnw9jsSYJ7Gq1kq17RjUimTvcjpjv9dnqew>
    <xmx:Q3DMaDOIDkDysZqYtufPzrryMQAZBF7wFOv_V5zeEg2dqsVaIsbXvA>
    <xmx:Q3DMaOFQIyiMz9p73iR3BdEKIbsPqPp5whYs09UgHNa0I-uLgfQrrg>
    <xmx:Q3DMaKOf8uySbUKE-JJHdK8hHYRWGSapnZoupW7u0VBcuMGdI8KmzA>
    <xmx:Q3DMaHmSunGuLSKuSo8Tu2IrO3qbpH_Sux0C4tH-3JiX0J7lLuvECAJf>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8DE5F780270; Thu, 18 Sep 2025 16:49:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APC_Ty_9PZC-
Date: Thu, 18 Sep 2025 16:48:46 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Julia Evans" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <311f6e20-b12c-454a-991f-bcbd66b318bd@app.fastmail.com>
In-Reply-To: <xmqq348kbtbz.fsf@gitster.g>
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
 <2f2dc22c47530445bce50f1bdef9630b046677bd.1758144815.git.gitgitgadget@gmail.com>
 <xmqq348kbtbz.fsf@gitster.g>
Subject: Re: [PATCH 1/2] doc: git-push: create PUSH RULES section
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

>>  --force::
>> -	Usually, the command refuses to update a remote ref that is
>> -	not an ancestor of the local ref used to overwrite it.
>> -	Also, when `--force-with-lease` option is used, the command refuses
>> -	to update a remote ref whose current value does not match
>> -	what is expected.
>> +	Usually, `git push` will refuse to update a branch that is not an
>> +	ancestor of the local branch or commit being pushed.
>
> I read this as "there are two conditions, and satisifying only one of
> them is sufficient for the push to be allowed.  (1) the local branch
> is a decendant of the remote branch being updated, or (2) the commit
> we push to update the remote branch is a descendant of the remote
> branch being updated".
>
> But of course that is not what you wanted to say.  (1) would mean
>
>     $ git reset origin/foo && git push origin anything:foo
>
> would allow us to push literally anything to overwrite origin's foo
> branch.
>
> I think
>
>     "... not an ancestor of the commit being pushed to update it."
>
> would be a way to avoid such confusion.

I like this, will use that phrasing.

>
>> +PUSH RULES
>> +----------
>> +
>> +As a safety feature, the `git push` command only allows certain kinds of
>> +updates to prevent you from accidentally losing data on the remote.
>> +
>> +Because branches and tags are intended to be used differently, the
>> +safety rules for pushing to a branch are different from the rules
>> +for pushing to a tag. In the following rules "update" means any
>> +modifications except deletes. Deletions are always allowed, except when
>> +forbidden by configuration or hooks.
>
> One important operation is omitted.  "update" does not include
> "create" in the following, no?  Obviously since refs/tags/ would
> never take any "update" (unless forced), if "create" were thrown
> into the same category as "update", you cannot push a new tag out.
>
> So, next to "Deletions are always allowed", shouldn't we describe
> what rules apply to creations?  I presume that they are also always
> allowed?

> The first colon might be acceptable (I find it a bit odd, though).
> The second colon is very weird.  ": only" -> ", only" & "allowed:
> the" -> "allowed. The", perhaps?

I agree the second colon is weird, will fix it. (probably ", which means the
destination must be an ancestor of the source commit")

>
>> +2. If the push destination is a **tag** (`refs/tags/*`): all updates will
>> +   be rejected. The source can be any object
>> +   (since commits, trees and blobs can be tagged).
>
> Again, I might prefer ":" -> ",".  I cannot decide which I prefer
> between "all updates will be rejected" and "by default no updates
> are allowed".  Either should be OK, so let's take what has already
> been written.
>
> The second sentence is not wrong per-se, and I can see that this was
> inherited from the original, but gives me a strange aftertaste. When
> you list object types in the context of "tag" and have only commit,
> tree, and blob, a little voice in the back of my head asks "oh, what
> happend to tags?".  It is made a bit worse with the phrase "can be
> tagged", as it typically means either (1) to create an annotated or
> signed tag object, or (2) to create a ref in refs/tags/ hierarchy
> locally, but usually you do not think of pushing to refs/tags/
> hierarchy as "tagging that object remotely".
>
> I think the untold assumption here is that refs/tags/foo at the
> remote is being updated most of the time from refs/tags/foo we have
> locally, and "any kind of object can be tagged" is trying to say
> that refs/tags/foo we have locally can be an object of any type, as
> the act of creating a ref "refs/tags/foo" and pointing it directly
> at an object is "to create a light-weight tag" for the object.
> Since we can have not just tags but any kind of object locally
> (because any object "can be tagged"), a push can ask object of any
> kind to be pushed to refs/tags/* hierarchy.  But it is an awkward
> concept to explain.
>
> Would side-stepping what exactly "tagging a thing" means, and
> phrasing it like this
>
>     The source is not limited to an annotated or signed tag object,
>     but can be a commit, a tree or even a blob.
>
> work better, I wonder?

I think it depends on whether the reader is more familiar with lightweight
tags or annotated tags. The only kind of tag I've ever used personally is a
lightweight tag, so the sentence
"The source is not limited to an annotated or signed tag object,"
feels confusing to me ("why would it be limited to an annotated tag?
I'm not even totally sure what an annotated tag is!")

But I can see that it would be different if the reader is more familiar
with annotated tags. Will think about this. 

Maybe we can just say "the source can be any object" to just be clear that there
are no restrictions without trying to educate the reader about the nature of
Git tags.

>> +3. If the push destination is not a branch or tag:
>
> Here, I do understand and support the colon, so I'd equally support
> the first colon of the previous 2 sections for consistency.
>
>> +   * If the source is a tree or blob object, any updates will be rejected
>
> OK, so this is the same rule as the refs/tags/ hierarchy.
>
>> +   * If the source is a tag or commit object, any fast-forward update
>> +     is allowed, even in cases where what's being fast-forwarded is not a
>> +     commit, but a tag object which happens to point to a new commit which
>> +     is a fast-forward of the commit the last tag (or commit) it's
>> +     replacing. Replacing a tag with an entirely different tag is also
>> +     allowed, if it points to the same commit, as well as pushing a peeled
>> +     tag, i.e. pushing the commit that existing tag object points to, or a
>> +     new tag object which an existing commit points to.
>> +
>> +You can override these rules by passing `--force` or by adding the
>> +optional leading `+` to a refspec. The only exception to this is that no
>> +amount of forcing will make a branch accept a non-commit object.
>> +
>> +Hooks and configuration can also override or amend these rules,
>> +see e.g. `receive.denyNonFastForwards` and `receive.denyDeletes`
>> +in linkgit:git-config[1] and `pre-receive` and `update` in
>> +linkgit:githooks[5].
>
> Very well written.  refs/heads/ not taking any non-commit, and
> receiver side hooks that may reject a push, are not something
> "--force" can override.  The mention to "the only exception" above
> sounded as if it forgot to mention the latter.

Will mention the receiver side hooks there, I didn't think of that.

> Looking mostly good.  Thanks.
