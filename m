Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310B821ADDB
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918431; cv=none; b=GS8eapRPheKPm0FxboHA3rkU6SlscdtziL6Wij5UgaR2wV+dwHy52lOF83VoIpjRvk03oBKhVqKEbURDX+Mv38s7qIs0jegTwCIcbnrobfdx5UsywA0ZJ//5/3PbtG/l+KOCRe+43666Eofzf6Tx+40C011b2ApitbeZjery2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918431; c=relaxed/simple;
	bh=qmn70W0bPYbVlS/TwJsreh+WYoCnXgug+kFUgT22tQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CAJATVDbZ5cA5lpJDh8iOdwJ+/FTpHk613Yemg8LzXjJWKj7gngYcvyQf0sQkGiKC93TMfRTI55WvNV5PX/vPYSn83FMYXY29dXtmzBaQqBLFV+hZj1FYwReMXtNL514SPbx5axuxvr2qWXly4RysTQ+j6R0UN1z2/NBF44Erck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kMvnMlSm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hcP50sDs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kMvnMlSm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hcP50sDs"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E76541D003AF;
	Wed,  3 Sep 2025 12:53:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 03 Sep 2025 12:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756918427; x=1757004827; bh=WWcqHNfhjK
	BrtgGysrrI3hZQnVRmiGGpDvN9pFbi2F8=; b=kMvnMlSmtjQ7bPcMKYe4kyjoTa
	UVxCshr6EeusnRvqZQNv8Hy9DuUCyBulqXlYV4SCE9KSKJFcxKmN4pqpa9qeHjLg
	nzT3uN1XRIaBYGT1+0mKAjhVyo3+rnWEdo+c8+IGenJ4jSMGr7RwxcqAm7go50jw
	kof0AKPpFS0vqZQdjxVfvjPQnY6phT6Dvw71+hlQZAinvJnmLPEbpgK7piyokkMu
	yewlb8LxJWtP43XkkkXvlOdiQaFEtJQdUwRZMdvHw3WZwFVxGVkcK8c9kDExLKyF
	3U1cB7akCpoWUGCl2J0dta8KJ+Ev4/DbSZrCreAWAYI+vIXNtjYej1kOcSaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756918427; x=1757004827; bh=WWcqHNfhjKBrtgGysrrI3hZQnVRmiGGpDvN
	9pFbi2F8=; b=hcP50sDsBYWKem//jLf3DwbztoEVjj3zbq57C0L1MmUY1EwtsNo
	MQW641EeDr1P+IicSj2Tdrk9ouKrIC3ukU8nmUtVrT/x7vzt+dw+D78ofebbOMPL
	SNP9QqK7FkbqhWbeHRxAAyPEe+qZ3cesZYxdurqdDOh3N8BqOKE8AXkPSktSGksk
	GQ3PFqA5QREFbb+rVlP7ZDtXgGSjF3Nn4R9fa7zkpRcWyDt+OriGx4hbtCes0St0
	apbbIq5NwVJ1nHkKmaEfIOnbxQgZdcmTviJOavwPnSuzqbEQTkeLSArOnR+Q0gwz
	yYx8an7/+SFf+5oTAIKDGtPru2D0oh9KbbQ==
X-ME-Sender: <xms:m3K4aHwEAOQQ_Ofkx_-NqgJn2oovd1IGqwAE4B4jsydumJwXAV14WA>
    <xme:m3K4aHurHAvsGhfUI5ye_CWysTVXY-1r-JjJ_J_ctE25_4Ptob8ISIi9svhpwQtWn
    w_OkpdKSDVECAbsUQ>
X-ME-Received: <xmr:m3K4aBz1liDgwIMI_NsZZCSPnhQsJcjjc4zG7dnq4hX1kSt73ydc8tZ4E_PTEKWaN6j-mvXPu-ABVDIJc5AxMkDDga2HvtBAjcG_Zn4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhho
    vgdrughrvgifsehinhguvgigvgigtghhrghnghgvrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:m3K4aCBUwyS3nOGTRaAnNZ_2kIunRqRECZdLPZImVU_Or83sOvsOpA>
    <xmx:m3K4aHewbwExobsnm2WTyqiLd4Z0hrwQAURtpal7ld0l171rYHzetg>
    <xmx:m3K4aEmD1eI_DwMkVvxRPyOX2IroH0ukmP1sDS4c3SMNKOwNvLKZ5Q>
    <xmx:m3K4aGGA9ryF_w8NO-yEtAYG_p5DZiGs6EEUd4uOD_rF7sMB4T8HtA>
    <xmx:m3K4aLs4cIHilo2T4mOzZUUdKRsw-48G5uGcjAtSEGVgIQXDycHey2yK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 12:53:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  joe.drew@indexexchange.com,  peff@peff.net,
  ps@pks.im
Subject: Re: [PATCH 1/2] refs/files: use correct error type when locking fails
In-Reply-To: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-1-35e69bbb507d@gmail.com>
	(Karthik Nayak's message of "Tue, 02 Sep 2025 10:34:25 +0200")
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
	<20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-1-35e69bbb507d@gmail.com>
Date: Wed, 03 Sep 2025 09:53:45 -0700
Message-ID: <xmqqv7lzfpeu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> During the 'prepare' phase of reference transaction in the files
> backend, we create the lock files for references to be created. When
> using batched updates on case-insensitive filesystems, the transactions
> would be aborted if there are conflicting names such as:
>
>   refs/heads/Foo
>   refs/heads/foo
>
> This affects all commands which were migrated to use batched updates in
> Git 2.51, including 'git-fetch(1)' and 'git-receive-pack(1)'. Before
> that, references updates would be applied serially with one transaction
> used per update. When users fetched multiple references on
> case-insensitive systems, subsequent references would simply overwrite
> any earlier references. So when fetching:
>
>   refs/heads/foo: 5f34ec0bfeac225b1c854340257a65b106f70ea6
>   refs/heads/Foo: ec3053b0977e83d9b67fc32c4527a117953994f3
>   refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56
>
> The user would simply end up with:
>
>   refs/heads/foo: ec3053b0977e83d9b67fc32c4527a117953994f3
>   refs/heads/sample: 2eefd1150e06d8fca1ddfa684dec016f36bf4e56
>
> This is buggy behavior since the user is never intimated about the

"intimated" -> "informed" or simply "told".

> overrides performed and missing references. Nevertheless, the user is
> left with a working repository with a subset of the references. Since
> Git 2.51, in such situations fetches would simply fail without applying

"applying" -> "updating".

> any references. Which is also buggy behavior and worse off since the
> user is left without any references.

Very true.

> The error is triggered in `lock_raw_ref()` where the files backend
> attempts to create a lock file. When a lock file already exists the
> function returns a 'REF_TRANSACTION_ERROR_GENERIC'. Change this to return
> 'REF_TRANSACTION_ERROR_CREATE_EXISTS' instead to aid the batched update
> mechanism to simply reject such errors.

In the above description, both "batched" and "transaction" are used
but they mean different things and their difference is critical to
this description, right?  IIUC, the mechanism for "batched updates"
is based on the transaction mechanism where all-or-none is the norm,
and when in batched mode, that all-or-none-ness that makes it a
transaction is deliberately broken and lets certain types of errors
cause operations on refs individually rejected.

After "The error is triggerred...a REF_TRANSACTION_ERROR_GENERIC"
but before "Change this", you would want to say what the code does
(i.e. "When this happens, the entire batched updates, not individual
operation, is aborted as if it were in a transaction") to highlight
why you would want to "Change this", wouldn't you?

> While the earlier implementation allowed the last reference to be
> applied overriding the initial references, this change would allow the
> first reference to be applied while rejecting consequent collisions.
> This should be an OKAY compromise since with the files backend, there is
> no scenario possible where we would retain all colliding references.

OK.  How do we know that a existing lockfile on a case insensitive
filesystem can only be due to somebody tried to lock a ref that is
only different in case, and not a leftover lockfile or lockfile held
by some competing process?  Don't we _know_ all the refs that are
involved in _our_ batched update when we find that we failed to lock
one particular ref?  We can inspect other refs we have locked so far
(assuming that the transaction mechanism knows what refs it is
updating) and see if one of them is truly conflicting only in case,
and if the code did so, I am happy if the code ignored that lock
failure (and the ref update).  But I feel a bit uneasy to see that
any "ah there already is _somebody_ holding a lock on this ref"
without checking that it is _we_ that took the lock for another ref
whose path is only different in case and ignoring the failure.

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 088b52c740..9f58ea4858 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -776,6 +776,8 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
>  			goto retry;
>  		} else {
>  			unable_to_lock_message(ref_file.buf, myerr, err);
> +			if (myerr == EEXIST)
> +				ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
>  			goto error_return;

I guess the place to check would be here in EEXIST case.  Since it
is an error codepath, we can afford to be more careful (probably
with an out-of-line logic implemented in a helper function call made
from here).

Thanks.
