Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD6414F126
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444760; cv=none; b=VDKFQUSLN9sYOmDoBPnsqlKTgj32Pi+a972ZLoSgj2gqKnXhmrLCvadpPfrx7d4mdh5oTnKFn6U/aDEvDEUCubU3coVD7vvOe5pz3ZLbCscDHUk/mcreYFeJoIf1Z4JMF3LiCb1G7FGECoZhs9zvbPwyLZ7YUMcLlsTWD8dnKgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444760; c=relaxed/simple;
	bh=T+uAGp+nzs/IAuZKPcePA9QCxu+7zQzSINXg7bGauwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yt/SyICI3ZTTCfKsU1tJASF8S1gKgSXRZTP9686XyobGS/913QsNoIg91BA0hc7wdaLhYonBbSVOZSE45ev6m5z2SXSNo5HVV4cQR3MQs4cHb9jSUCgUIC37KMFghU36bOeCuZKYlEraJEFXddcVn7M4dsWhnaKENy60p7qq2f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lblh3rX7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C3PSasL/; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lblh3rX7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3PSasL/"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AC1691140114;
	Fri,  1 Nov 2024 03:05:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 01 Nov 2024 03:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1730444756; x=1730531156; bh=goBANmtbnC
	bteMuhUUxZXkvL59eGSwj6laED7daYFFk=; b=Lblh3rX7ZEAgFIwTi7jM14Q8Zz
	O360V3yed6BwRtV3GO+sdXKxObbJQVThvbVlwqVKy9YjeeEgELzCDqYkSD72oDXo
	XPTjgexPoQxU7RVwhaG/WyQq5HJ4NuWiUdVFc2623vh5EMeyGXqOGcGkP/JxwUoF
	xFWUrQZgZSzrfgAsGjSbAIVU3qqAnRtvucw3YEJF9614EnDOhDPSwopRzxIp/3cW
	vumhG213xxvuJsutxWY6TGvuTNVNj4hq48lRQJu1JrZ+6JY9PUvSBvP6f7I93arC
	uRwKi/rmFaUeSRq3RmNQrdOZ1MGfCx1s+M72OGikbodz1AJJNEsRlDsTmxjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730444756; x=1730531156; bh=goBANmtbnCbteMuhUUxZXkvL59eGSwj6laE
	D7daYFFk=; b=C3PSasL/Q0dPwtHmLoT288x33EG/+GTROWRvq0qyRvVbx58OhM+
	YBCGvK+ElT5N3S3QG5yMihPDYNOoWTgW1h1l7lSGtpyZaM7H+cavfTgSylRK0jwz
	5tA7I268HtYfTEAhspmhjaJhDgqjRpVCq1GmwJotpaGBrgZ+TQAEB21mk5pB+vaP
	5l4iC6ZJsRwq7BDau7buosyOAyW1YCdhy0CKECaijrWnLwYT7lWpRGwNPX+3KCB6
	j5qytx/qu/Op81Air4HE3/xjUeahfw9XpnCA3AptRZmQjxrq1Tdnn5WtHWjr4pqf
	6Eo6e87IS65UureijBtVfqzVghCkaWk6iwQ==
X-ME-Sender: <xms:1H0kZwD5SVZn7rLyShr91_F2fW0rdQtZbWjr_oedEn_8l69fX92DOg>
    <xme:1H0kZyghKwcZ3U_nyz22egsY_7qxOZ4Vm7QgQdis40Cvk4vTGnSaE3b5gAYGWPA2K
    5M3LySiNWCSNeq46w>
X-ME-Received: <xmr:1H0kZzlmZwXDAvQ1SDQwQmflVWrcho3UiLvFmYf_CA7_kNYfMnAG1i2sfcn3bRtRmVMA3U6JcRHg-e7qymqYj6tYYw6yRAGRUfL1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekkedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepihgrghhoqdhlihhtohestghlvggsrdhiohdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:1H0kZ2woTSL4XXBoMaKifwAopxFEuUc88k7aqIlR-GXhw8G3lSltVQ>
    <xmx:1H0kZ1QC_xQWo0BJfMq7Gr_9bLQwv5kuxYkSYMtX6A9dr5FxXDU_UQ>
    <xmx:1H0kZxYSAouOJ3P6ORmJpz0Sjd7etNIyoMGMJuY66OA-CgV93-DwLQ>
    <xmx:1H0kZ-QIBz_DX12tfkCnn2kMiyEv0Q3D-DgteYTBtkWLRnzHqRWYtA>
    <xmx:1H0kZ3dkVmGSV00H5eW0qvBK8cLq0o8G1NVmS-d5iq44aSIO0ZbY8i7Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 03:05:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Iago-lito <iago-lito@cleb.io>
Cc: git@vger.kernel.org
Subject: Re: `git apply -p` doesn't remove source prefix in 'rename' diff
 entries.
In-Reply-To: <3af246eb-3473-4964-9aed-ecff62b215b7@cleb.io>
	(iago-lito@cleb.io's message of "Fri, 1 Nov 2024 01:17:20 +0100
	(GMT+01:00)")
References: <3af246eb-3473-4964-9aed-ecff62b215b7@cleb.io>
Date: Fri, 01 Nov 2024 00:05:54 -0700
Message-ID: <xmqq4j4r4enh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Iago-lito <iago-lito@cleb.io> writes:

> Hello,
>
> I have troubles understanding the behaviour of `git apply` with respect to renames in a `--no-index` context.
>
> Let us craft a toy folder:
> ```sh
> $ mkdir x
> $ echo a > x/a # To be modified.
> $ echo b > x/b # To be renamed.
> ```
>
> Duplicate it twice to get three identical folders `x = y = z`.
>
> ```sh
> $ cp -r x y
> $ cp -r x z
> ```
>
> Modify `y`:
> ```sh
> $ echo newline >> y/a # Edit.
> $ mv y/b y/c # Rename.
> ```
>
> Now I would like to use git as a "better GNU patch".
> Calculate the diff from `x` to `y`:
> ```sh
> $ git diff --no-prefix x y | tee patch
> diff --git x/a y/a
> index 7898192..4030aa5 100644
> --- x/a
> +++ y/a
> @@ -1 +1,2 @@
> a
> +newline
> diff --git x/b y/c
> similarity index 100%
> rename from x/b
> rename to y/c
> ```

Interesting.  I think "git diff --no-index" is "wrong" here, but
"wrong" is not in the sense that it is _incorrect_, but in the sense
that it merely is incompatible with what you are trying to achieve.

If you had files a and b, modified a in place and renamed b to c,
and if you did this in a repository with tracked files, you would
have seen

   $ git diff --src-prefix=x --dst-prefix=y
   diff --git x/a y/a
   index ...
   --- x/a
   +++ y/a
   ...
   diff --git x/b y/c
   similarity index 100%
   rename from b
   rename to c

Notice how "rename from" and "rename to" information is different in
the "real" git-diff output, as opposed to "git diff --no-index"
output you have?

At least when comparing two directories, "git diff --no-index X Y"
could be interpreted as a request to treat as if X and Y were
checkouts from two Git commits X and Y, and by comparing them the
output should be identical to the result of comparing the contents
of commits X and Y.

But feeding "git apply" however may not be the only reason why
people are using "diff --no-index X Y", and there may be a
legitimate reason why peole want to see "from x/b to y/c" in the
output, so unconditionally changing the output may very likely break
workflows of other people.


