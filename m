Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245A4291C1E
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950417; cv=none; b=XGV1t+kaG9QgZEw125LvJ81orTcBLha/GxGF9VBP9rr1A/Pbqq/wS9UAatzxMAi27lIkHhXuW/GwdQA5L9AN71Ez2mgODpvt32uFIxHfpGiXIDAuy+lYXJuELqtEd6mNrDq5Kglw4hGboZKndKONiTPpy+dDRcNsQ2+K+V8mncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950417; c=relaxed/simple;
	bh=3L3dRUrK0SwyBWpdtOoEHjSn4s26+uMPv3F2QEWhcrg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OglLvK6Y2FVaa4nppbAQQ9h6CWLnnXu277fFtIzkqvzdmkQUmqMYOsMqn7LVg8SJHz96R2AAP8fgIPfiPodt6FRtWFw8iOD8ggAc99YI+q12RABJKOlLnewgaedeRBCOsenzCbIbIpA7zVg6gnBwmOTL4RNv1PGxMhkHjlajnxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca; spf=pass smtp.mailfrom=jvns.ca; dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b=LgN8zLJu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oYewdUL8; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvns.ca header.i=@jvns.ca header.b="LgN8zLJu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oYewdUL8"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 364627A00A9;
	Wed,  8 Oct 2025 15:06:54 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Wed, 08 Oct 2025 15:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759950414;
	 x=1760036814; bh=mnr9zJ0tr23dDARxs1f3BimQ5LAZ3SsDRALA3bg9zYk=; b=
	LgN8zLJup6fz4ABiKScoSfmaNU2Iam1+zjZPJsXu53a095ztr+Fp4J2kBRlpJ2wM
	Vq45n1qSZyARFI3I59XLTKnOt9JcT32nQg2TqDiB4Mc5HQucRkN591a30ETSKWqZ
	7d7SFYsC7bemLrXdExVv7gY5HUc8ZKi1QsBcw3wWRSE5J9qo+/zi++3wzN0pbLKy
	kPa92bHEekZdavbd9Q7i9tT9BbWU3PZRQkCZA1AZfocNNbdmS/yd19HHjwP/0PC6
	cTzOslTCq60rFyJgJTQtE8FqR3x7dOBloR9R+tqYPsFIiM/hIBX64Uv9+dm0QE7d
	A1/VikkZM9KeT9aUwp/G8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759950414; x=
	1760036814; bh=mnr9zJ0tr23dDARxs1f3BimQ5LAZ3SsDRALA3bg9zYk=; b=o
	YewdUL8vLdBuRAaPrjXrjJRjTH40Rr+J17zjboiWulUtQ2Ib0t4AaJ4pdRB0FCeI
	aeitehOE1N+J1G3ZuVoDCjo8LlbbNZG1UBLnSahlBu/PujDOBVYWzpAUXx6Miwdj
	EjISow9eA06abziEDYjlrutpAzXi/bpYgbHJxAjhjhVbTMWe7WG/SdYY2eP1BikG
	OsVq7p+7iv/VejMnSNhV9XeBDHNQURQPeLWtp4MTfN5Mrv5UAGFkjJp2xTUXrwS0
	ax3VeeypXRBOxX4hBvD+rEi0Aje4LJfcWKyP8VQCs6Qru4255Vl8M8JhzYouKi10
	FCR8xjeBNlzfRqKjGAhQA==
X-ME-Sender: <xms:TbbmaDyioSafKJEFiar2PE5Jdv49i32aAW9LrPujpJmZbV6mR_6WjQ>
    <xme:TbbmaGHPch0um8Ox4Bhk9DIU4NjaJtVY35T4GyqGOAk42MhVjF27He5ByKWr6CBn9
    LmdXD83VskbzTyHb-WXDVwcohGyvwpEZr5Zzv3W97kCddf180klmeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdegtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedflfhulhhi
    rgcugfhvrghnshdfuceojhhulhhirgesjhhvnhhsrdgtrgeqnecuggftrfgrthhtvghrnh
    epgfevkeduveeivdevueehhfdvteeggfffudefgedutdekgedtledtvefhtddutddtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhulhhirg
    esjhhvnhhsrdgtrgdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TbbmaCb64iCkbwFuLQnBwhtfcUJe726aurrIhRcezcQCFMSwSfvslA>
    <xmx:TbbmaDO0ilV96vYfwniopwWH8cTG7PiG-_lm7ngh3ex0rhwWOLyGMg>
    <xmx:TbbmaHbBORAz-hFcZ-nojbFbR_QOVCsD5xe-9YvZcvgmePWOk9sA8A>
    <xmx:TbbmaB2xxcfB-MxEFk2gi7kqYDWTVru-tqjpGLav0vsqtEJfFpfM5Q>
    <xmx:TrbmaC-AjDnbfOlg2aXHT__yrkDg9c6w6IOZHU2GjpZdXRKrAWdgy5I4>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BA5FD780076; Wed,  8 Oct 2025 15:06:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AfAzQvnzmZPw
Date: Wed, 08 Oct 2025 15:06:29 -0400
From: "Julia Evans" <julia@jvns.ca>
To: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: "Julia Evans" <gitgitgadget@gmail.com>, git@vger.kernel.org
Message-Id: <395232da-4ac6-4311-ae44-2bbf92fa6d2f@app.fastmail.com>
In-Reply-To: <xmqqecrdgzk8.fsf@gitster.g>
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
 <aOUkZa4_fq1hho7Q@pks.im>
 <dbf0727d-66bf-4698-aa21-d69da86027c3@app.fastmail.com>
 <aOXmA5L5LsUuXWEh@pks.im> <xmqqecrdgzk8.fsf@gitster.g>
Subject: Re: [PATCH] doc: add a explanation of Git's data model
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Oct 8, 2025, at 11:53 AM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
>>> I sometimes hear from users that "commits can't be snapshots", because
>>> it would take up too much disk space to store every version of
>>> every commit. So I find that sometimes explaining a little bit about the
>>> implementation can make the information more memorable.
>>> 
>>> Certainly I'm not able to remember details that don't make sense
>>> with my mental model of how computers work and I don't expect other
>>> people to either, so I think it's important to give an explanation that
>>> handles the biggest "objections".
>>
>> Hm, fair I guess. In any case, if we want to mention this I'd leave away
>> the details how exactly Git achieves this. E.g. we could say something
>> like:
>>
>>     Storing a new blob for every new version of a file can result to a
>>     lot of duplication. Git regularly runs repository maintenance to
>>     optimize to counteract this. Part of the maintenance involves
>>     compression of objects, where incremental changes to the same object
>>     are optimized to be stored as deltas, only.
>>
>> We skip over the details, but this should give enough pointers to an
>> interested reader to go dig deeper. We could also generalize this to
>> objects in general, not only blobs.
>
> Interesting.  It is of course not wrong at all, but it was not what
> I would have expected for the first explanation to help confused
> folks who say "commits cannot be snapshots as they take too much
> space".
>
> To me, it was a realization that even in a project whose tree (think
> of "du -s .")  is huge, each of its commits touches only a handful
> of paths, hence a large portion of that huge tree would be shared
> with the previous snapshot.

That's a good point, I forgot that I've explained it that way too.
I might change it to that instead. 

>>> > This misses "refs/remotes/<remote>/HEAD". This reference is a symbolic
>>> > reference that indicates the default branch on the remote side.
>>> 
>>> Is "refs/remotes/<remote>/HEAD" a remote-tracking branch?
>>> I've never thought about that reference and I'm not sure what to call it.
>>
>> No, it's not. I think the term we use is "remote reference".
>
> Honestly I didn't know/think we have any special terminology for the
> refs/remotes/*/HEAD symref.
>
> Historically HEAD did not "track" the remote state, and we did take
> advantage of that fact to use it as a place to record the preference
> with respect to which remote-tracking branch we would want to
> primarily interact with.
>
> But these days because the protocol is capable of expressing where
> the symrefs point at, the users can make it track just like all
> other refs inside refs/remotes/*/ hiearchy.  So I personally think
> it is OK to call it in remote-tracking branch.

I may just add this to the remote-tracking branch sentence then,
which is hopefully correct:

`refs/remotes/<remote>/HEAD` is a symbolic reference to the remote's
default branch. This is the branch that `git clone` checks out by default.
