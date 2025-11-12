Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42DF23ED6A
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762987757; cv=none; b=F8yFfJifPV0qiy0B+EhnsAf47oHnFcYqd30HCPegfaW4I08bpebKYvYRTQRol7gKeIiP2BGEn9y3Qe0C7KUZrAytGeVtQBfopyoRQlwiRZheQlQCzkX/tfafKRGuY5Tm4cD5WpqCOp+XlqTnuS6S69nibM8aPx22bUx12YVQjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762987757; c=relaxed/simple;
	bh=a9M4zSryWgwz6cQq03GTtc/UbOzPIunVTeWaM9pt0V4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LnTBdJycPNzlawaO+bYtxq4yIgYMdb/PyiQPJTQDa8P0K7vWbMPo93CdG33VizLvX3HWZcwGhuZ4KgAcR7BMtylqpDfJMrSl/z1+62sJ24GzK1sRmDkxbICwwFSBuy9kUrtQOjDNT7zPVV/bQGPE680X25nAKgVWhUkqtt3CFes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XxEfvpia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vvXbSPDO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XxEfvpia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vvXbSPDO"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 027FC1D000D0;
	Wed, 12 Nov 2025 17:49:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 12 Nov 2025 17:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762987754; x=1763074154; bh=JhynwDO739
	7tbdhdjiFMhqpAoAVnerEyAhfUJpQqooU=; b=XxEfvpiavJwoRq8Ul8OSWftoUz
	DFoiNIk7HpcXymlMCLfqFu2rupw3ZcTLci/Nu+DfiB+mXRbCX8qId8NhLGVUg75S
	v1/L5ob28WdAIBYRA9uAJs/YLnbeSA0VynQktXCDLCbcHpQ4mdsCCCIYNOH4ha7e
	oA1ftq3cbPtriI5+u5OEcvjSJtuTOFDClF5YKFhOtE6ON1tHeDD9SA+MZuKeVcY2
	Fq+t81N/DlugvW/a/ygG6KWGT/6qwTNBJNew/GNrclLjl5A2mQIKt4r5wG43cGEh
	Ucu0GrjKnik3lpd7c/9+cvofsuGfBL5jCgMpj0/SKapCMQc6N73z8mbLYZcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762987754; x=1763074154; bh=JhynwDO7397tbdhdjiFMhqpAoAVnerEyAhf
	UJpQqooU=; b=vvXbSPDOZ/qLkQZDx2yATZxKxF6DvjdzaRkA2GwmE5LpdFFwEoa
	N7laBOSFpyXiZoR6uy5Rs1yFVJq7XUMiVtTqfFQLpwfi/2Sy1QCxKrqnxETTEmRw
	DjvqSKvb0BdwB5OhM42PP7unva9fRDVqohWSoDXn+HIKFLbrMNJEhGs1jb+H6r82
	u6lPiZ3DSz9+Yos0lyX6+wPeJG2enhPe4VP5Mwo2BFAXHjEMu+FwAxQyPxTo/+jh
	bWpqYDaNXDhlk0sq3yLUpXoM7Y/dXK+95Ivy2s0a2mcX9ZrCi0NBoDXZfTb88qBk
	8iIM1Dd7TexgsaR0URlgnc5GF4adlTup+og==
X-ME-Sender: <xms:6g4VaVINbaO2S_KPHpihj0m5xinQG80pT3ntWqfv3OS7wDzEs7UuOQ>
    <xme:6g4VaTZczPFNkCZCVrI6z7jqHfhYEiY6PMbBgm3eqTNGcK494A5x34yevXhLzXN_A
    h49kg1snHO90dCXTrLvLXA-3eazIvLFyO3qolVLmqlcKX_wFOCcGQ>
X-ME-Received: <xmr:6g4Vaf-i508ds1sKE53W8Q3KqTurZ3b0E0mS3ZQAkphSudPXzhd8q3Qb7gwMyLxkc7sajWkT9Z5LgQRUfRGgPBtJdF0Vfeu77RJd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtghhithhg
    rggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6g4Vacbu1BWCcisTheGVyFZR4DuGA1qUPwbFQ_3DrOhQgdPStzgn_Q>
    <xmx:6g4VabNibLTqTe2bBaVk6QUG0PWIPnrucBCBOqgt5ngigynKFlDaWQ>
    <xmx:6g4VaQA4JLwqQJEN5PPlGpMAJ6SeMeib7A7u9Z7_jpSqdng7UDSHig>
    <xmx:6g4VaaIzlrmM6UlehGZk77Vgt0kZavghPaci-Nv5R2PVoYciPRLmlA>
    <xmx:6g4VaUPs5KImmmr0mzfUQSI0NGFHb76C1zbj5iYtWkPhEljg2wX8bwRu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:49:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>,  "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
In-Reply-To: <xmqqa50rqcy1.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	12 Nov 2025 11:16:06 -0800")
References: <xmqqo6pde90w.fsf@gitster.g>
	<D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com>
	<xmqqa50v4x8n.fsf@gitster.g>
	<150f3442-93a6-4469-9c25-5bca24accc80@app.fastmail.com>
	<xmqqfrakyj0w.fsf@gitster.g>
	<2474339d-67bc-4a68-9f26-fe7edd172ec4@app.fastmail.com>
	<xmqqa50rqcy1.fsf@gitster.g>
Date: Wed, 12 Nov 2025 14:49:12 -0800
Message-ID: <xmqqo6p6q32v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> If we do not hesitate using a new word and introduce "label", "a
> branch works as a label for a commit object" may probably work,
> probably.

Another thing.

Do we want to limit the definition of "branch" very narrowly, i.e.,
"subset of refs whose refname begins with refs/heads/"?  

Or do we want to give a description at a bit higher conceptual
level, something like:

  A branch is a mechanism to help you grow one line of history (in
  the sea/cloud of commits) by (1) keeping track of the commit it
  currently is at (by recording its ID in the ref used to implement
  the branch), (2) allowing you easily record a new commit you
  create while you are on it as a child of the current commit (by
  allowing the symbolic ref "HEAD" to point the ref used to
  implement the branch), (3) keeping the description of the theme of
  the particular line of history being developed there (by using
  "branch.<name>.description" configuration variable for the branch)
  which is incorporated when the branch gets merged to an
  integration branch, and (4) keeping track of how the branch has
  grown over time (in the reflog for the ref used to implement the
  branch).

We can limit ourselves to view a "branch" as a narrow subset of a
ref that can point at a single commit in the dag of commits, and it
can be updated at any time to point another different commit that
has no relation to the previous commit.

Once we stop limiting ourselves and explain the purpose of using a
"branch", "it can be updated to point any random commit" stops being
entirely true.  While the "git branch -f" command can be used to do
so, doing so all the time would go against what makes a branch a
branch, i.e. to keep track of the process of growing the history,
and it is expected that it would be a lot more common for the commit
pointed at by the branch ref to move by growing the history with
"git commit", refining the history with "git rebase", etc.  But that
can only follow if readers understand the branch as more than "just
a ref whose name begins with refs/heads/".

I am not sure what level the data model description you are writing
should be at.  The current description seems to concentrate too
narrowly on "a branch is a specialization of a ref" aspect, and
while it is not incorrect as a description of a building block of a
tool set to implement a workflow, it might be too limiting to form
a proper mental model.  I dunno.

