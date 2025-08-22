Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B11D5174
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 20:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894830; cv=none; b=iK4rM+CrFYTI4pUSiJ+srI7O0s4EsrBlKr8SAqmFmwcwO8Z7ZdWopOiw+7BYhL48W8iPsI1OpRvnj3M819Lex/2VPPWpl463r+aTsFtRqd2xX06DG3fR1zrRJ5817daw0mzCJoSmVP5RkX3/DyjgGYuxYUFtDmBg6wh2LPwkB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894830; c=relaxed/simple;
	bh=d0qXoaq0eFY6E5r7KPN5BGpYnqzzaUKTnwW13AEhb1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p/wqXCZyUH0598ryhr4tVtwka4C3ye0Qbcq7u3BgFPDEvOJndfD2bu38213xQHWNOFsRM+fHU+wMg1ZcG1Ln88/I0ip9Rxo5vAXQrnMkI07wwtlgkFpCC1p0dxPqxrNAKTMh4Pjk9mNk7LCyXrTQjsf8xngJG9G887grGjqiccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lJcKT+sZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VjIxUcFd; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lJcKT+sZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VjIxUcFd"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7FE497A01A0;
	Fri, 22 Aug 2025 16:33:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 22 Aug 2025 16:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755894827; x=1755981227; bh=S1HKP0SAzi
	bPlj0IbJqmX4pU4DHO5DNcdmEmqd6cBys=; b=lJcKT+sZgbw5Dpswq16j5ApO7k
	rjj0DUog8Cglg+Oxb7s79q1eSunaq0FqcogG07Pvcm8NUpO8AFCOtIr4kcS70TOj
	TKhceMySjvpH8gpzABci1sWW8XZok1cRgC+xy8fSJT9bXkXTFLp9Mwa1Vc8013R1
	/Q9IvBifS8tfcYfGTvjXnjMe5OzV8V6WNgPDVcPd/KN3hOb1ln54lTp4s7YkMa02
	V80FKz00srfXXg+4N9xmI/gdVNRAwr3R1D4pqCmjjrqaGxxLTy5W+ysazdJCKBCB
	EsJck5igWmeTO2KnZ+LeyHPK+zxnHazTfO/kuFbiDkDn3BTFPF85UU66uFDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755894827; x=1755981227; bh=S1HKP0SAzibPlj0IbJqmX4pU4DHO5DNcdmE
	mqd6cBys=; b=VjIxUcFdGZUk49Cam/WUAxoizHd3j56Qcm+LKfoEB8eQkLvTaib
	sl7b0Z7Iy7WlIhFWayiVfjIqJ3OoNHqOG7AOckGeSmi0EUcH4Z13vbY5JMw6G1Z7
	yj7aq+s6+D9xcOQcRiO9iLUiMHq3JnLGJ7AqJ++iMXm3EAykH+jY4bjDmFqeGJU9
	GjN8/a8dju5L/xBE9sOKm8eEPemBSY56evWh923cEBbvzlkIWyDmowZtHxGPjZmB
	gI2sfbpTvaKiy+NycqteT0L/OzcifFMAfkiLcTykYUPUSUyr23iZUqFjpYZy32jd
	azp87Ku4Vt7dY5xlgY/AkJ32VuAdaFAC6vA==
X-ME-Sender: <xms:K9SoaMk7fZuYNhKSilxFAa-wytB3pLPFWq-sNb2jXz2chQCw7XGQSA>
    <xme:K9SoaGYYP5EUoc3JXFOEl55eAMe-kOLNJt25GwUcHpF1HOLF2dCX0M2Mtdd2P1QUr
    antiL-ZZURy8Rq_CA>
X-ME-Received: <xmr:K9SoaHMV8VK3K-nFOSkMBR9p7Xy75O-F6oFPfvdTFSxKquOXH5ifIvpJCgWIhAwHDqyQtrgP50rmA3cef-g4pcpseMnZI6bJiDqnIR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:K9SoaLapMBeo1h5lPp5gJ6Xb0ucFzQ_vAonQulz4D2emKaNU1xkkOg>
    <xmx:K9SoaF0UkC6Rbju4WzENSb0zRCiMAGUwUp5Cb-j4oxZ9_TPVEqlqGQ>
    <xmx:K9SoaBdNSzmC7tsA_6HLvAGQPVyGCxBwZKkgsGLmEX8_gtkvOrNWzQ>
    <xmx:K9SoaGFjsyoyh83is2oeZVpywcXy8Pti5mB77vFWaWHkDiq1hCjZKw>
    <xmx:K9SoaP1wE_Is5riSdyrsthR9GcThvHLpDCwLDJBInSvR88-EiN5PUrrW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 16:33:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 3/4] bulk-checkin: require transaction for
 index_blob_bulk_checkin()
In-Reply-To: <p6bdiflg2fe7kgw47ntg46csjhmp63gkovtf4inlc42f4dga77@5oieqa4bydne>
	(Justin Tobler's message of "Fri, 22 Aug 2025 14:13:27 -0500")
References: <20250820225531.1212935-1-jltobler@gmail.com>
	<20250821232249.319427-1-jltobler@gmail.com>
	<20250821232249.319427-4-jltobler@gmail.com>
	<xmqqqzx3xpwc.fsf@gitster.g>
	<p6bdiflg2fe7kgw47ntg46csjhmp63gkovtf4inlc42f4dga77@5oieqa4bydne>
Date: Fri, 22 Aug 2025 13:33:45 -0700
Message-ID: <xmqqa53rw0ye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 25/08/22 09:49AM, Junio C Hamano wrote:
>> Justin Tobler <jltobler@gmail.com> writes:
>> 
>> >  /*
>> > - * This creates one packfile per large blob unless bulk-checkin
>> > - * machinery is "plugged".
>> > + * This writes the specified object to a packfile. Objects written here
>> > + * during the same transaction are written to the same packfile. The
>> > + * packfile is not flushed until the transaction is flushed. The caller
>> > + * is expected to ensure a valid transaction is setup for objects to be
>> > + * recorded to.
>> >   *
>> >   * This also bypasses the usual "convert-to-git" dance, and that is on
>> >   * purpose. We could write a streaming version of the converting
>> > diff --git a/object-file.c b/object-file.c
>> > index 1740aa2b2e3..bc15af42450 100644
>> > --- a/object-file.c
>> > +++ b/object-file.c
>> > @@ -1253,19 +1253,26 @@ int index_fd(struct index_state *istate, struct object_id *oid,
>> >  	 * Call xsize_t() only when needed to avoid potentially unnecessary
>> >  	 * die() for large files.
>> >  	 */
>> > -	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path))
>> > +	if (type == OBJ_BLOB && path && would_convert_to_git_filter_fd(istate, path)) {
>> >  		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
>> > -	else if (!S_ISREG(st->st_mode))
>> > +	} else if (!S_ISREG(st->st_mode)) {
>> >  		ret = index_pipe(istate, oid, fd, type, path, flags);
>> > -	else if ((st->st_size >= 0 && (size_t) st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
>> > -		 type != OBJ_BLOB ||
>> > -		 (path && would_convert_to_git(istate, path)))
>> > +	} else if ((st->st_size >= 0 &&
>> > +		    (size_t)st->st_size <= repo_settings_get_big_file_threshold(istate->repo)) ||
>> > +		   type != OBJ_BLOB ||
>> > +		   (path && would_convert_to_git(istate, path))) {
>> >  		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
>> >  				 type, path, flags);
>> > -	else
>> > -		ret = index_blob_bulk_checkin(the_repository->objects->transaction,
>> > +	} else {
>> > +		struct odb_transaction *transaction;
>> > +
>> > +		transaction = begin_odb_transaction(the_repository->objects);
>> > +		ret = index_blob_bulk_checkin(transaction,
>> >  					      oid, fd, xsize_t(st->st_size),
>> >  					      path, flags);
>> > +		end_odb_transaction(transaction);
>> > +	}
>> 
>> Interesting.  If the caller does the odb transaction management
>> itself by calling begin/end before calling this function and fed two
>> or more large objects, the original code did the right thing with
>> .nesting set to 1.  In the new code, it still does the right thing
>> even during the call to index_blob_bulk_checkin we raise .nesting by
>> one, because the all non-zero .nesting values mean the same thing to
>> the machinery, thanks to lazy initialization of the .objdir.
>
> In the original code, if no transaction was setup prior to invoking
> index_blob_bulk_checkin() (i.e. nesting == 0), the object would be
> written to its own packfile and flushed immediately. If a transaction
> had been started further upstream (i.e nesting > 0), the object would be
> written to a packfile, but not flushed. This allowed for subseqent calls
> to index_blob_bulk_checkin() to write objects to the same packfile. Only
> when transaction ended would the packfile be flushed.
>
> With this change, index_blob_bulk_checkin() must be provided a
> transaction so it can write the object to the packfile. As there is now
> always a transaction involved, there is no longer any automatic packfile
> flushing. The caller is required to ensure a transaction handling as
> appropriate.
>
>> So, isn't the comment above the function now less accurate than
>> before?  The caller of this function does not have to do anything
>> and we do not expect the caller to "ensure a valid transaction" at
>> all, no?
>
> I'm not quite sure I follow. index_blob_bulk_checkin() now expects a
> transaction to be setup even if we intend to only write a single object.
> Thus the call site in index_fd() is adjusted to ensure there is a
> transaction via invoking begin_odb_transaction() and
> end_odb_transaction() before/after the function respectively.
>
> Just to clarify, are we talking about the comment above
> index_blob_bulk_checkin()?

Ahh, sorry, I misread the patch and missed the hunk/file boundary;
iow, thought the comment was about index_fd(), which was the source
of my confusion.

Thanks for correcting me.
