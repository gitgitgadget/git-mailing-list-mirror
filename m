Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F328298CD5
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 23:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027580; cv=none; b=g6y0MAIKS8khLTJFuJjK/VENDZA7pdiAK//8C9rhhI50bu+E3OCkF9sd7Zyr99OQA6ExI1M7O4ToXa49vJTrmXf8eQoTLRIT9YBIVs/5BDpXTOp4gCUHPsUKBcJvG8aKoKS3wPBtWZ+VcE3dW1HIGBYJi/2zxSpv8+7lzyYBO1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027580; c=relaxed/simple;
	bh=EmPxEgcmb8jigZufgGILp+PXRunHgUnWaTUCrCo02BQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xch5yQHkvwJK+vE7cJAwiIlCuRDtXWDZPyxnjiY8GYT4K/GUKJDu2Kb8DFHNcgzE0X4AyISClNWSONwYF0Tvh0TvFimEE0QE0dTSncZblXiNi70KvMbTCPcndfymZoweIYcmJsLwO5KJQu6tTufilr68njd5bkQ6nNHjTO9y5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KPwNcAW7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EE6GnIiG; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KPwNcAW7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EE6GnIiG"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 06EAA7A0608;
	Thu,  4 Sep 2025 19:12:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 04 Sep 2025 19:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757027576; x=1757113976; bh=8ZMTxyzV8i
	ZBa8+ZRJygbMQ3gt5uoQUQQq2uMe43xsg=; b=KPwNcAW7YA30vsWCwTGWrPGnRO
	DVt15EI/PmudPSW3tSrJ6WTHeVagxcjfvgG9IFHU+psluPEkWsgt5Nc9Rx3uakWU
	nf24QJbZ89upo3OfXNDGRkT5KB0lERvJ2joCDdT3nIz+xE8No39SvwNIFMumwVTs
	43doh2fKvmSw4RJ2cdcVXkJ1UlSYcFsJ/BBWxRawKE7mhuvmvBI8Yz5Hn6apSjII
	efCZa4stmawrdES0iMAawxsIrkJyRJzKJTsdzpHOQbTdJlic2bS6k+PlTBUasw7h
	S5HjhZ/6nZ9jcu7Jl8bymZXK/lJ4pldOizQldCd4LqlN51b029fziETiGrGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757027576; x=1757113976; bh=8ZMTxyzV8iZBa8+ZRJygbMQ3gt5uoQUQQq2
	uMe43xsg=; b=EE6GnIiGuDgU9LlVEqjkgb3TL3wJnPf3KibQC6lZnTiTNjTIDLk
	1TdU1frHS0Wfgrta/NG2YmAxTSv9lPw1+aqdddPwj/PWEA+n8O8mCebtsbKAcYpo
	gWCa+lgaTpIXl/8093cyDxiEQ6jnWjACk7YfiaaMlGWp8U5Kl6aYaMGH/eO/TM8S
	h29Bu1dRIgy2kkNaPnifqKE7mh0aTidQVIktjowFdVFyJDP2KHvggR0tJGYtos4F
	1Afi+0M2zw+srUEwrS9PmYPZA0/Pp/6V4i6sr6Hkk/y+Mq/SZP+gX8QxlqremDXL
	yKg1NRLqRGnz36RXB8xx8+/rW7DhVSmQxhg==
X-ME-Sender: <xms:-By6aCiZFFqKYXWhrSQ7B7wjPn4C1AP76DKadt2py5oLZ9Sn7QKuJQ>
    <xme:-By6aGQuvfG86a5xL26mk-p5u0omIFKlgVMmSYe_d4I0JAXgbXEWG1MGHprZUzZlB
    EIvYvDhT7_7S-hUTQ>
X-ME-Received: <xmr:-By6aDgcNUrqIDagC2BhIaTtwmG1KnHXsYiuw8welTPdOeu-P-APaEv5rDxA0nG5Nk9yy_qUPtBhCfC-tERgv7HJ8GwtzBbKMtX2JgA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:-By6aG7P-E0HxhsCoYmu1Elv7EjQDWpUDBksTFcZtzcn_pyvivbHxw>
    <xmx:-By6aACnRmW6nVlNDve10cJH6NJyUM4rwBcssU1bqwQgLFrMPfp2KA>
    <xmx:-By6aNYk8vqs363XhCzSyjJ_7wRy7zVYtruPNOr0zAIR82WdwIsdrQ>
    <xmx:-By6aLazqFJE1w24ze8qTIuc3I-7x2AN5y91zJgIwWNUD562KUF84A>
    <xmx:-By6aF37bHEm5kBStNr0FpuXTRNYe_RmWwVwANapqnxqBNbcPwQDQpI7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 19:12:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/6] odb: track commit graphs via object source
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
	(Patrick Steinhardt's message of "Thu, 04 Sep 2025 14:49:54 +0200")
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
Date: Thu, 04 Sep 2025 16:12:55 -0700
Message-ID: <xmqq5xdx7qx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> commit graphs are currently stored on the object database level. This
> doesn't really make much sense conceptually, given that commit graphs
> are specific to one object source. Furthermore, with the upcoming
> pluggable object database effort, an object source's backend may not
> evene have a commit graph in the first place but store that information
> in a different format altogether.
>
> This patch series prepares for that by moving the commit graph from
> `struct object_database` into `struct odb_source`.

Hmph, I am finding the above hard to agree with at the conceptual
level.  In some future, we may use multiple object stores in a
single repository.  Perhaps we would be storing older parts of
history in semi-online storage while newer parts are stored in
readily available storage.  But the side data structure that allows
us to quickly learn who are parents of one commit is without having
to go to the object store in order to parse the actualy commit
object can be stored for the entire history if we wanted to, or more
recent part of the history but not limited to the "readily available
storage" part.  IOW, where the boundary between the older and the
newer parts of the history lies and which commits the commit graph
covers should be pretty much independent.

So moving from object_database (i.e. the whole world) to individual
odb_source (i.e. where one particular subset of the history is
stored) feels like totally backwards to me.  Surely, a commit graph
file may be defined over a set of packfiles and remaining loose
object files, but it is not like an instance of the commit-graph
file is tied to packfiles in the sense that it uses the index into
some packfile instead of the actual object names to refer to
commits, or anything like that (this is quite different from other
files that are very specific to a single object store, like midx
that is tied to the packfiles it describes).




