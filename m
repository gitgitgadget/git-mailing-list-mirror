Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105CDDC3
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731031321; cv=none; b=BCcscrI4OHSK3MPTv32Tjd+8g7Eys7tEXAO3ERYGLOlqgGh06VVTehIzZPVvYaXilrmPol2d98sfN9SQUpGVjrFFK9MRk5F71PXMSFsVoVrnp/H0d1+bS0E2YwcMVjVmxUUT/ehI+a5TqC3r9Gzpbv3Slywo4kqToeqTOgGETN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731031321; c=relaxed/simple;
	bh=u+ckhqqPJEsdHML5/gj091nJtD9E1fS86ROX/JKDPSY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lDSRP6seJo93J4Jd1XGLBDi9gKTDL+a/cJmFEG3Z8VXaLoBMk6Nl/1hOTmmp/tvnx+45HVsDAXSje0b+fisiikcOJ1eRaywli3TyFs8GKEktK/prDKT6Py+pNwdj8gTua32gWqwnp6sEj9UejcGWe8kWFll4mUXlEH0GvxYTqus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fjX0NoqK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IqOy3azT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fjX0NoqK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IqOy3azT"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 42D441380479;
	Thu,  7 Nov 2024 21:01:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 07 Nov 2024 21:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731031318; x=1731117718; bh=rGytHCaLRa
	uNWtq3NwUi6KzYaIgitVX348heffwJvEU=; b=fjX0NoqKJWo7tXsXYJSeuyzGEu
	dB2XCqsdgF2upuDf+0wBrjF6LlhxfiMc7620psuiM1i4ClV6ACbkjCsw7dFzEQY+
	DpqFVP7InEY15ZmdZ7wteNJ2Rcj+xm+gIbVeEE4qCtOE361leG3C3HfYuMEgAEEW
	dnvxrx99WovbpTOtW+1EHRgBCMh6PLFUb7r1Qpc0RRBUQVJtBvrJJ93PJkiyDLgb
	70BzEDYpSvC2wGe4dUwLmV0XtvS3973WFoP9LjKwJglZLwBklTzLnE1qfCAr5Upp
	7Kd5PhPQkj47dHhYgmC0QRSILv/ZgVG6zdI1gWgPIyi7n82xKOhI+535OybA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731031318; x=1731117718; bh=rGytHCaLRauNWtq3NwUi6KzYaIgitVX348h
	effwJvEU=; b=IqOy3azT79K4VxzaRTJWMmPLRL4ANrtP+CyCCKsuKlOS82Ax2iM
	QEObWMl8RHvbAPWxyBNJuvwhZjZFLeDlwLYOB0Ji+JmtnRBco8POoN5yXZoQ8iX9
	ND7A1rSaQkJBU4LSAUAJhFkijTKo/OODVyLZJNexVLHtwC4az5FFmASdPpGXepbj
	Ud1OGAlYFoSV7u8QD8q+0Zmxe/Q+PW3HmWe1mDrYVUqN+1v+mV+6INgqBFZnvUqU
	PxJy9qbu33YGappIyqGLpIdINOUpDE9wKT5ZMKJelWySCU3uzMqNxiK23VidJjVK
	Gi6q1c8qFcFenrX6ZZlfMKwdMWYyBnpksug==
X-ME-Sender: <xms:FXEtZ-o3tlJxKR2rZV1ge76Za96Fzstp0ewryF4Qp6wInIGoKTMHHg>
    <xme:FXEtZ8omgK39Zv30qdzktVSZb1pMLBd-oWS-Qf1FQBLHv0TLyuNnSntbJ9bYv6aYW
    GhvObuk-gDnAgmjZQ>
X-ME-Received: <xmr:FXEtZzNYAugJ2hWk49oQEz3HQHblj5Ti5p3ExNxFym8alL0ChFqosObuNZlLfiDt6rkcCgg3wuizSY30Iy4vmx9m4hpQixKvnbjn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtdehgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegrvhgrrh
    grsgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FnEtZ97LJLIrBQc4NOUkByCqQvJwoTUZN5LiaDryrZEV0vT4s4KzjQ>
    <xmx:FnEtZ94FwJn24Yqpq54p7LFozX1v3TqNcqnHWIz_vUPpiKLy0U_NAw>
    <xmx:FnEtZ9iPlmlr-1v9lFJkdptRO9NG31tSvqNNl4_ftqF83ojAbN7VcQ>
    <xmx:FnEtZ37gFJi7N4iv9d-Xa7vj_U3mLBP79w65tIzfosVJhkNAnRIMqg>
    <xmx:FnEtZ6trKS4Vi8PFxhOBn9QEa4BRU__5-_cFvSjjy86EpU57zab8vuG5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Nov 2024 21:01:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  avarab@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v3 1/4] Documentation/git-bundle.txt: mention full
 backup example
In-Reply-To: <b222c6787a79c852442969721dadc629ca84cd5b.1730979849.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Thu, 7 Nov 2024
	12:57:33 +0100")
References: <cover.1730234365.git.code@khaugsbakk.name>
	<cover.1730979849.git.code@khaugsbakk.name>
	<b222c6787a79c852442969721dadc629ca84cd5b.1730979849.git.code@khaugsbakk.name>
Date: Fri, 08 Nov 2024 11:01:56 +0900
Message-ID: <xmqq1pzmqy97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kristofferhaugsbakk@fastmail.com writes:

> +We'll discuss two cases:
> +
> +1. Taking a full backup of a repository
> +2. Transfer the history of a repository to another machine when the two
> +   machines have no direct connection

Contrasting (1) taking a backup and (2) extracting a backup later is
a very useful way to frame the problem, but then, I'd say

 1. taking a backup, either full or incremental, of a repository

 2. using the backup, either full or incremental, to transfer the
    history of the origin repository to any repository (including
    itself) without needing any other connection between the two
    repositories.

Whether a full or an incremental, the resulting bundle file can be
used as an offline medium and then later extracted elsewhere, even
if there is no direct network connection between the origin
repository and the destination repository.  But you can extract in
the origin repository as well.

But that would require a bit more surgery to the presentation order
of the text, so I do not mind deferrring it to a later and separate
series.  If we were to go that route, it would be helpful to have a
paragraph to describe how you use your "full backup" bundle to recover
lost data from, though.  To those of us who know what is happening,
there is not much difference between the extraction side of the
sneaker-net example, but as we framed the use in two distinct cases,
it would be helpful to make each case stand on its own.

> +First let's consider a full backup of the repository.  The following
> +command will take a full backup of the repository in the sense that all
> +refs are included in the bundle (except `refs/stash`, i.e. the stash):

Are you sure the "except" part is factually correct?

I did

    $ git bundle create x.bndl --all && git ls-remote x.bndl |
      grep stash

and I see refs/stash listed there just fine.  You should be able to
extract them all with

    $ git clone --mirror x.bndl xxx && cd xxx && git for-each-ref |
      grep stash

and see that refs/stash gets propagated.

Fix is a simple s/except/including/ ;-)

> +----------------
> +$ git bundle create <file> --all
> +----------------
> +
> +But note again that this is only for the refs, i.e. you will only
> +include refs and commits reachable from those refs.  You will not
> +include other local state, such as the contents of the index, working
> +tree, per-repository configuration, hooks, etc.

And to make each case stand on its own, we would want to teach
readers how to use the full backup to recover data from here, before
moving on to the "next example".

    You can use the resulting bundle file as if it is a repository,
    a snapshot of it at the time the bundle was created.  You can
    use

    ---
    $ git ls-remote full.bndl
    ---

    to inspect what refs are recorded in it, and you can fetch from or
    even merge a branch out of it, with commands like:

    ---
    $ git fetch full.bndl my-butchered-topic
    $ git show-branch my-butchered-topic FETCH_HEAD
    $ git branch -f my-butchered-topic FETCH_HEAD
    $ git pull full.bndl  my-butchered-topic
    ---

    after you screwed up one of your branches and resurrect it from
    the backup.

or something like that.

> +For the next example, assume you want to transfer the history from a
> +repository R1 on machine A to another repository R2 on machine B.
>  For whatever reason, direct connection between A and B is not allowed,
>  but we can move data from A to B via some mechanism (CD, email, etc.).
>  We want to update R2 with development made on the branch master in R1.
