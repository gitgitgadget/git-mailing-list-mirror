Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8495428A3EF
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771294; cv=none; b=DQgZfH85AvhaT/0lLk1MGycUjXYCN71RrOIzqvZerM3daHjYRBamZSU8H5Oon/YYwnAY1tUN0bq0nV7kuI03duDDq5eGTLPxqu3QO5Tc/3c42UnFUHeDsC8p60JQ1QZeSFH8mj7IFHN4NHftflaB3wmCmRCc9nbAKrZEn7KrkG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771294; c=relaxed/simple;
	bh=X/StFpfZKynnLYOlUVfXV2ynB3T333bnj+p9DqJgzu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M7GyusPq01+4DIITWAGA8lmsufDsr1EdJZMQiEsR24u4bnw3XWPjRuaObmnj3ns5IJpOQo8bcKIjV88Mk64+MjiLAVEe44kzegDkqyJvvdiQca1umyghrPe69lMCF+eyprtanGBrS8Rs8pgePkDrAH2dOW5aSPdfnIMWR4wiOqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QZtZgucg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GcS/IU6r; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QZtZgucg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GcS/IU6r"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8AEC47A0165;
	Mon,  6 Oct 2025 13:21:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 06 Oct 2025 13:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759771291; x=1759857691; bh=caXKXoV861
	sLz5nbQmngWZLvoJ2WtQHIs+mKfueVb4k=; b=QZtZgucg3IeFGutWsEeHso4CSR
	/d4Qr19vUDSb9pQGk7T3tOFrAt5bMeKiU5dFgNDYIcyCj2GX2M6Qe2QWkJiS1Ir2
	ThnaB87+LD+RaMmiGxpxHYkIgnQYSHDLHxkErZ8+/omstjnw1bsAAuU08L8Q3h9A
	ZF1PQKqkozD8SuPxIYXg4vQ7KNaW5+tXY1+4e3l8ZhqRO9+P4CDM1S5wDQnXrhmS
	xN/IT5pFUxcRxQchkD7YRKaRRcfe+bsOea+svdJZzcYJ2hu+9Q6v8lEkdCCTDrRz
	6QA+H0u5cwvCFM6jMEK7dsPZ0z2qFpp2qnvDzFBzAOvbW9IGgfzu6BpYcfhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759771291; x=1759857691; bh=caXKXoV861sLz5nbQmngWZLvoJ2WtQHIs+m
	KfueVb4k=; b=GcS/IU6r4QLs0BUEoJLa7BkyntCIFMyKLaA5r2lChIHvrZ/GmMQ
	flPLXOKQCFePjmcEvPPJ/DKfq/vDdLKzQJ61aFHSNmsPQahM5SGpq0umU3NufvGN
	WEJQhzPqxHmNtqHAjHPR0Gwpla4bvR9ynCtJ+fw0ftpy8mr8iEUmEFVmTU/yUwr9
	cspgYHuNuFdvquYm+3FJZdnMisb96HjFNaVTBCvJN1gbWV4vDg25JwDXq8BQawT1
	IAkl+sWyPW/LohdNJV+9AiDVac9drBVd122zCINWh47G0k5RjQ57uu5b7jnwcjII
	WrVnqD1QAaH4jm8PQaph9JtvknNWtIfMKaQ==
X-ME-Sender: <xms:m_rjaD2xBttL5X9NkqMFkLkDioqITxvIydoEu0K3M5_EKAovHVGJmA>
    <xme:m_rjaI8rf6piR8ptY77Ez1TW1ZB0opDLl23UM0zhQjW4IhusN6Is_OIhJ_qkhr8JE
    AN6aRdDbhu8GBLfYVTlKONGlQUayleyOZ15P8UWzqOjrL1FM2m0UlY>
X-ME-Received: <xmr:m_rjaMOYLqb1KVnJVWVFCaWi7RaAWWRwbKuFe8DHoa7phzHDZK8BBxMrkGhHE3NSVxunopB48OiVepIF7eu8LYPYL6dRyF971M84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehithhsrdhmih
    hrohhmrgesphhrohhtohhnrdhmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:m_rjaEdnexKqChEMq8HStFJDVUvtS0US9qioVQMDlEngH8coCfpmnA>
    <xmx:m_rjaDWA3rmdPQ_EiGLe7S9SPnta_Rkp1sMRWDezr8mIO2pz7_l-lg>
    <xmx:m_rjaEiOxDXXCQogwwk8mGBUm2-kIWwSlrDsKppuOdLlPCJwrloWeQ>
    <xmx:m_rjaK-MHm3p7RPXGJ-gt-FfFF6eWXg8rHGGYct8kfLw5pnZU04Xcg>
    <xmx:m_rjaE5TpOfdSAtAHrUOrJg_bSp7jZ14Ne1vgUjYJEDr_PgsBjoanGet>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 13:21:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Miroma via GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,
  Miroma <its.miroma@proton.me>
Subject: Re: [PATCH] stash: don't show irrelevant entry count in status
In-Reply-To: <CAOLa=ZQVZMNXjZzSDCc9SXxRuAhRbo7hc-F9RmhYap=ABWVxzw@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 6 Oct 2025 07:43:36 -0700")
References: <pull.2067.git.git.1759750539721.gitgitgadget@gmail.com>
	<CAOLa=ZQVZMNXjZzSDCc9SXxRuAhRbo7hc-F9RmhYap=ABWVxzw@mail.gmail.com>
Date: Mon, 06 Oct 2025 10:21:29 -0700
Message-ID: <xmqqtt0cosiu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> "Miroma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Miroma <its.miroma@proton.me>
>>
>> Currently, when status.showStash is set, 'stash pop' shows the
>> following, confusing, output:
>>
>>     ...
>>     Your stash currently has 1 entry
>>     Dropped refs/stash@{0} (abc123...)
>>
>
> Right, so your proposal is to not print stash related status information
> when already running a stash command. It would be nice to note that
> here, along why you think so.
>
> Personally, I think it is important to keep this as is, because it tells
> the user the entries left in the stash post the stash operation.

When pop sees a conflict, it keeps the stash entry, and whe it does
not, it discards the stash entry it used just now.  So I agree with
you that the number of remaining entries may be something the user
would want to see, but in do_apply_stash(), I think we are getting
the number before popping, as dropping the entry seems to be the
responsibility of the caller of do_apply_stash(), if I am reading
pop_stash() correctly.  So, I suspect the current output may need
adjustment if we want to keep the message and want it to be useful.

>> @@ -705,6 +705,9 @@ restore_untracked:
>>  			     absolute_path(repo_get_work_tree(the_repository)));
>>  		strvec_pushf(&cp.env, GIT_DIR_ENVIRONMENT"=%s",
>>  			     absolute_path(repo_get_git_dir(the_repository)));
>> +		strvec_push(&cp.env, "GIT_CONFIG_COUNT=1");
>> +		strvec_push(&cp.env, "GIT_CONFIG_KEY_0=status.showStash");
>> +		strvec_push(&cp.env, "GIT_CONFIG_VALUE_0=false");
>>  		strvec_push(&cp.args, "status");
>>  		run_command(&cp);
>>
>
> So this block is run to print the status, unless the '--quiet' option is
> used. So it makes sense to do this here.

Does it?  What happens in existing GIT_CONFIG_{COUNT,KEY,VALUE}*
environment variables passed by the script that invoked us?

If we are spawning "git status" here, can't we do a much simpler and
more obvious thing, i.e. "git -c status.showstash=false status"?

> Small nit: Shouldn't we add a test to validate this change in behavior?

Yes.  I am not yet sure what the right output should be, though.
