Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA214A33
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 21:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209663; cv=none; b=gJLsvrBj8rEL86ztofE1Q+C9f6SIiWF6xIk2B9it5OOgSpWx5i00ebxKMKPJ1AeJZK+VfKEFpFcwTSGyMJj489XAW/tvyhSlnW5XUELU+90NrTbboxHzJvUMII66MrgxQy38RlhM45yif9p72iNyGKQMcmEva8XA9vYw5DL6h7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209663; c=relaxed/simple;
	bh=CCJpaY5vTi49jZQn4AH2ZKJU8hGWOYRw6Oj2hIhqF3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EelsdvmouNVIfikka/dD01S+G24QjOh77DulR6m5wyks55tbEJbYSAOeYpe4RcZzQgfA27uBov9bk7I24S7xK9Kr3aLf4DE+3VwGkbkrD/rc59826CwAWXx7Hxgwkr+gra+T5crVNt3vHInFmMWclT3gnOQWuO+V6aJSdq88VeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WuBZyy2n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b4spxHMg; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WuBZyy2n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b4spxHMg"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id C680213826A6;
	Wed,  5 Mar 2025 16:20:59 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 05 Mar 2025 16:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741209659; x=1741296059; bh=exkMLX1ZqZ
	+0/F4fHDcE1qsc3s+XsDISA98+di7mo8U=; b=WuBZyy2ntqkZohrdRI8u9+NYtA
	8V0TNAPnhWSTmSHkN1ogcd9nQpQZgInQCbolydoT4gK7tdvv+jpYe3Sd/RLERwSs
	8d3+FZAxl1xADm2PjoYIEjGuc3CfTlMf4wI6N1bkFoc6qV4qg8g2bxL+PbwmtzIM
	eqGJriOJal+gx5N2gFcFVcDLfzHZHBO43kk27g3lMTipFhhhixsO6zD33URUj1xT
	bYCU8CegTkm6WugEe1MlLbm8HBw9PMQseqrJSj/I8uu9N5NaOYwcLSBmFvvj8O8M
	YBK2219cwcvnoaSSGV+zSlYm++F25iCHHTvzcbA6QcIYPrhWBQkf6SAVn8zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741209659; x=1741296059; bh=exkMLX1ZqZ+0/F4fHDcE1qsc3s+XsDISA98
	+di7mo8U=; b=b4spxHMgD36qWSMoxODSgArKnowekhJZMs+JqzzXdTr6MxQSh8A
	cbqlqyOTCx3uR9aQnESpH+AcpNn6DBOs2mVbVQAF9n5nilHbjvbJwslgXmNQAy+E
	HrTc9ZuqwcxUHAYIh3XXNJPguZycK8m0p8ppRCgesyw1195x1n/tN5UEw6NvBBrS
	rkAdxn0bxJ/LjBT/rsINdGtvxxUUyhtMc59mv7MdSCpPLzlrNwrF4JKLj6AP/FfO
	eBArJ2/hmSb1oc9RYz3oJQpgTUF84CTby/bTkmcXi2vaBeQpN3v/6dEWfLIBaCoS
	7a69seHZO1zBopbRCgrAae5Ab5hhkkqf/Cg==
X-ME-Sender: <xms:O8DIZ2Uwp3_1kJ3fRZRKXuOVXnQjojUH8RRnvv7HAKk9vxDjkREHtg>
    <xme:O8DIZyl1vAq2E9xsqqazT2ZCsFbkJwiHyGUEfLm9VKheWW47DRdIxGuQ2HWH2Bcm3
    UbExg7MSqxkiw2_FA>
X-ME-Received: <xmr:O8DIZ6YQrWoLYOJ-lWx1xwkd-2x6c8qk7tV0bWdUYbInVymcuIOCRgUEq1L064mLTmrW2uzVPBjPqFrOt8LqS4yBpZcQ8Af3J72F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:O8DIZ9WmkHpvz7m07VA1uAWjoQ2jmQ_5XBIZZnbfOzLMsCkebB1eLA>
    <xmx:O8DIZwkrGuRW6zsu3giBl852E63pYu8EW6xKqODHebNnYAhXrGL1VA>
    <xmx:O8DIZycFAZ14m0PzePRf6b_3VH_aG7VojDvwdseQl0bgHost6q-3mA>
    <xmx:O8DIZyHNocip9cxXWfpsHz7jZL_tBE_zj8PtqExx3-MB6zbDUCNFaA>
    <xmx:O8DIZ-Z4BTHuKVq9cN8WEQ9e3fwyhHec1bq9txqV-wug61If9K7CF0A0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 16:20:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 1/8] refs/files: remove redundant check in
 split_symref_update()
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-1-0c64e3052354@gmail.com>
	(Karthik Nayak's message of "Wed, 05 Mar 2025 18:38:56 +0100")
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-1-0c64e3052354@gmail.com>
Date: Wed, 05 Mar 2025 13:20:57 -0800
Message-ID: <xmqqjz93kwcm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> In `split_symref_update()`, there were two checks for duplicate
> refnames:
>
>   - At the start, `string_list_has_string()` ensures the refname is not
>     already in `affected_refnames`, preventing duplicates from being
>     added.
>
>   - After adding the refname, another check verifies whether the newly
>     inserted item has a `util` value.
>
> The second check is unnecessary because the first one guarantees that
> `string_list_insert()` will never encounter a preexisting entry.
>
> Since `item->util` is only used in this context, remove the assignment and
> simplify the surrounding code.

It was a bit unclear what "this context" refers to.  We lost all
assignments to the .util member and that is a safe thing to do
because ...

> @@ -2843,13 +2835,7 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>  		if (update->flags & REF_LOG_ONLY)
>  			continue;
>  
> -		item = string_list_append(&affected_refnames, update->refname);
> -		/*
> -		 * We store a pointer to update in item->util, but at
> -		 * the moment we never use the value of this field
> -		 * except to check whether it is non-NULL.
> -		 */
> -		item->util = update;

... of this comment, and the "except to check whether" used to
happen in this code ...

>  	 * be valid as long as affected_refnames is in use, and NOT
>  	 * referent, which might soon be freed by our caller.
>  	 */
> -	item = string_list_insert(affected_refnames, new_update->refname);
> -	if (item->util)
> -		BUG("%s unexpectedly found in affected_refnames",
> -		    new_update->refname);
> -	item->util = new_update;

... which the patch removed.

OK.  Makes perfect sense.

Thanks.
