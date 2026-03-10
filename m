Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5BC359A9E
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172917; cv=none; b=B31MkMyRoWQRPPyFVHTTHVvHFsA2pmEQPJ2jx/5dVeBzWLikuyfukslOV5UzVNZSNAU34WLgqzLK0B2rL1wre1umi3kfGKJhGjvYY6OQXXgMqus/zJUnqjhVL2SAywlL/6cB6j7iAV8TpsDa0GOe3v9EuwRQd/YTJGLITNlP83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172917; c=relaxed/simple;
	bh=iQXZkv4I7n7l4slAipDUSD2VesePHgGKaWc00BPuH08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tq2PUIidqoRWoiXowvlsrzXZKSSiOsFNFLdxCPQq7Ua8YttToc1F0D8W9MCICDaYX1iaVkw4NJUGdLarxH4V2JyaUyQWg3Zq/UObKngYIRExoCQNZg2Nn11N7nuNvN51TvqRiKAAgNwWIMVzS0g/9pjmDoobcFljfm/iNNTSEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HEs1RqO1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXL+iEy6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HEs1RqO1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXL+iEy6"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 20A5BEC0579;
	Tue, 10 Mar 2026 16:01:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 16:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773172916; x=1773259316; bh=vHWtKQ3aQi
	NUNP9Pr/BZmmdGxIK47fiKiu3rBDZI+Cg=; b=HEs1RqO1dPF0Fh6mE3cBYcu2/A
	AVJaUWmzfyOH1ny6LLsPipXVGroTNs8yCVF2y2gHznc6sf1ki71Jl/byCtEuyROH
	vd2XyE4+HkCo8pd4MxUbeBY/e2yw+f/He68KDEMJWpOGu0Ow1+ZawfoR6RisVJhb
	XCvtsmsz20FnHVz0VazfN7DMCYM5SKjlGeE9Y28Y0jGIMUCbIqG9ksyfV0EQlSXs
	zEAYhKIhr/QGG6iC0ZZo8slXi4AAaV7WGvGkiBkf1vVDjW8+XHNjyKZBJDQQ4kLp
	aFv0omDoUWYrPzGd7hzUE+3bUq/faOIBQIdccgy2pphUPgqiRlDBtmYoXRAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773172916; x=1773259316; bh=vHWtKQ3aQiNUNP9Pr/BZmmdGxIK47fiKiu3
	rBDZI+Cg=; b=mXL+iEy6jlnXSxmfU2KD2bmMbI+6mIqcC7pvCUNeDMKjFqHSwrk
	hedaSn+ochhovS0/7MAreMKtoMnS+v9jTiZTgsnu7FVHesFjSfOxKGUJTglFXmSD
	dfgqQaBw1mh5GW1U9QdyFEuVy1S97QFIfGSDCQpbCi3IiZJEWEJwZ1q4XVJMMJkG
	iAlcazJ4N3fr7K/eCMfeJ5Pk05VArvMb1aZAP1WffaaD2xxxHnkNm8kEGD82f78Q
	JJfeEfQFR+C6uF/A7ul0G9JYBbstYCYszS0qCIgMRUTNxOWwhJvZavLb5Hl6LuN3
	4xqfffQqEW87xmU95iyU5rTjn6FQjiTFS+g==
X-ME-Sender: <xms:s3iwaRFLjgHATQd0qV5HKCkNlJqIZbEsbDupcfeGWD_7j51nb8-ZKQ>
    <xme:s3iwaSU6a1Mn1zx0pIR5oIIasM7HgynLJtu9P2J5qNp_PhT_3AXaDwXagwe19L3JF
    rxbFXbp6i4p2rGX7O9kpveSjrsiC5nO0y5Vv7EdywF_bGWDLBrTag>
X-ME-Received: <xmr:s3iwaVVQxA1EgnfeB6-R9HeJRC7t6W_MVPbYpeTgW-eFajIupkXhep6V2ROY-RWJeI55VMne-fywdCm0Ky0tsQZpq5XdxszspA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmsehgih
    htrdhsthhrohhvrgdrughkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrd
    hukhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhrtghpthht
    oheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:s3iwaYJy0jPXaUQ-HKTit3geafiL-4UgdXFQz0E-HnQX9Ke5xcxaOg>
    <xmx:s3iwaVBicfYhujw39x6Yde5LVAEXyfY2Bp3000hhWPX9E66QaB-CaA>
    <xmx:s3iwaYdx59s1zV_HLY_4KUGSLAsy2BkZT6XugpMVUtQK6H-r5DX30g>
    <xmx:s3iwaU3Qfs3ei4oXBxPCzoO4EPnQq9fxMBh1RnOi7rhmpxogbtIf_Q>
    <xmx:tHiwaSXaf5GPOYlM1eJflOWZq5JVEaij3ZIYLRTIfR63phzBboxcaCyz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 16:01:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Mathias Rav <m@git.strova.dk>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  John Cai <johncai86@gmail.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,  "brian
 m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] merge-file: fix BUG when --object-id is used in a worktree
In-Reply-To: <abATPiRUczb8fe4t@pks.im> (Patrick Steinhardt's message of "Tue,
	10 Mar 2026 13:49:02 +0100")
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
	<abATPiRUczb8fe4t@pks.im>
Date: Tue, 10 Mar 2026 13:01:53 -0700
Message-ID: <xmqqh5qntpvy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Mar 10, 2026 at 11:46:01AM +0000, Mathias Rav wrote:
>
> Which commit is this patch based on? It doesn't apply in its current
> form on top of "master" since at least 8600b4ec9e (merge-file: honor
> merge.conflictStyle outside of a repository, 2026-02-07). Please rebase
> the patch.

This applies cleanly relative to v2.53.0.  Generally, it is a
recommended practice to fork from the latest stable release in many
projects, so I do not mind it too much.

>> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
>> index 46775d0c79..a8768c6e0c 100644
>> --- a/builtin/merge-file.c
>> +++ b/builtin/merge-file.c
>> @@ -110,7 +110,7 @@ int cmd_merge_file(int argc,
>>  			return error_errno("failed to redirect stderr to /dev/null");
>>  	}
>>  
>> -	if (object_id)
>> +	if (object_id && !repo)
>>  		setup_git_directory();

Good.  I suspect we would want to check !repo first, though.  The
idea here is

 (1) We know we need to support running "git merge-file" outside a
     repository, so the git potty may have called us with !repo (aka
     RUN_SETUP_GENTLY);

 (2) But we do need to make sure we have a repository in some case.
     We happen to have only one case, i.e., when "--object-id"
     option is in use, but that condition may grow in the future.

So in the longer run, we'd better prepared for the "has the user
gave us the object_id option?" part to grow over time, which would
mean

	if (!repo &&
	    (object_id || another_option || yet_another ...))
		setup_git_directory();

would be easier to handle.

>>  	for (i = 0; i < 3; i++) {
>
> Okay, makes sense. Makes me wonder whether we have other cases of the
> same error class.

While I agree that the second call to setup_git_directory() that
triggered this patch is pointless, I also wish that the function
were more robust.  I wonder if there is a clean way to make it
idempotent.

>> diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
>> index 06ab4d7aed..60cc43775f 100755
>> --- a/t/t6403-merge-file.sh
>> +++ b/t/t6403-merge-file.sh
>> @@ -506,6 +506,15 @@ test_expect_success '--object-id fails without repository' '
>>  	grep "not a git repository" err
>>  '
>>  
>> +test_expect_success 'run inside worktree with --object-id' '
>> +	empty="$(test_oid empty_blob)" &&
>> +	git worktree add work &&
>> +	(cd work && git merge-file --object-id $empty $empty $empty) >actual &&
>
> This can be written without a subshell by saying `git -C work
> merge-file`.

Yup, that would make the test even better.
