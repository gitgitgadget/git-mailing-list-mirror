Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79513259CB2
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776184771; cv=none; b=GYJbB/5dedwVYU5pT7I737m69ZzMa0VUFR9KSb+iDXyjbgENB5B7pHYtJPSOEyuSnefD+vGr+bxRKc2xK4l9Dwkc0qk3C1Ysht4ZC8fUKfIJxcakTTA4F4o3T8jZHdg1m6DW9lIoZ1bpKFLyUksqV3AYZVLUPPQCneNSiBh8MlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776184771; c=relaxed/simple;
	bh=F8OM8tq1cwxj1paZoLLJkW/0rrcTyCkW8PQGbtBPSJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ofBAzXEIadSHhW308dCcBdK4jPetqozeoECqxJMwIQ5T2d9EqADGnljOFiQYXqmtC+4xjvTxKWyFDcZsJFXV/uCvfzP5jyY8JL/IhLjf8lgCu3cw62Eo/e53nZsPDYu10xoIb0OP9yDxlY+KEc/JP4gwbVVBzDt9hO6PaNfPNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fMxS6+PG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZqMm+s2u; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fMxS6+PG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZqMm+s2u"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 83A741D00282;
	Tue, 14 Apr 2026 12:39:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Tue, 14 Apr 2026 12:39:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776184769; x=1776271169; bh=Cuq5qETMyl
	WnVRsuOXQ7X6q/5Wwm81q4ZSX9FJrNfkY=; b=fMxS6+PGsHSrYEmm/ktUG+Dgwo
	ujeHtfS35QqZocyoGnSg1Wa4pH6UkAyJhTORoZqUNFAPWAo3OKMpkkz6/aDSYgV1
	6NtMmQQ6/pDcADx77iR6gtCNGThRQ3pctJseHrIHpd2JSsL66oSSkaYfBWlhKtkD
	O5Yjq8CR8I0cUFCh1gz2KLKJuvlR3JTqtAe+slcZCzEG6Me2Trqm6ZhFWDW/xqjV
	9GblXeD5jdLnYrtR2h4ta6Ej6gYYqUzXxOso3duKz28Lds5TGu9dE5pc9rKLaBrR
	Po1KLRInf3M0Z5I+5FuwWGa3H/CzJRolxWIjpMcYZ5uSZQhvHGVpwnOL6haA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776184769; x=1776271169; bh=Cuq5qETMylWnVRsuOXQ7X6q/5Wwm81q4ZSX
	9FJrNfkY=; b=ZqMm+s2u0eyqYtktoFm5e3Nurgd8wbnGjaj3mseIcsA3MrLySeL
	41VS7mFaNF8+YKG/Pe6GMJ0pM1vxL0KqzSMzelY6QiLHBLGdA9bD666kjLl9TmaF
	doO+UIgX6ih/4lPvCz+0eowYMto+zHhUuLaW7j54MpwgpI2J0VDRUKEBc3xy5OZk
	xexTio0s+0RncnRu2K1vmklPi15xuXMpjakMiShW4fbnUMeB+SBU0gZ3yQwFN1UK
	XH8Pzotki/0oNPg/C5miKRT+BycHS7F6DeEkbvk+eFkA/b0YTTLpzNAcqG9BNdm6
	ElPRLuVUg73AUk/h7GbYiQLc9kBKXLWgc5w==
X-ME-Sender: <xms:wW3eaczZRC0iJ9-TS8URuUcPpRSQgvoX41f_j1JTpPfimTtQIklgrw>
    <xme:wW3eaSgI3NDwOU69Y5s4VV4uZJF9LGgv90z5B0cfWP8PNLwVT9q_kKPxpwos3Gwv0
    kxDcbyZsX3svnOfs-mFoaEKbSyOTs1g23XpSQLLwu2Hdtm0qr79beY>
X-ME-Received: <xmr:wW3eaQlFJ730MJwIxnQSdaVWjCGXZM2kNfxVMyHKjD9om5g0GiL6dOhp7l-DBwzg5nppidRpVs84WC7PSH734X3iHOt3OI4Kbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthh
    hrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:wW3eaQjpudLGSDXvD5Qx1toboCuBlmOQzOcTyWWtF1jlxLjX6DjjRw>
    <xmx:wW3eac08mssLccFOhuMYeijkxCDchzz1e36Y2WWLfKOnfggobzSFWA>
    <xmx:wW3eaRJxlWjiMk3jTxZChZft5Fvx7szZxvtgMbG42d0R9W0N6frnTw>
    <xmx:wW3eaUysqRfK_L91uKCVnRv4L0Xa-gIbmuGXJ_4hIvY9DEgBbALL3w>
    <xmx:wW3eaUneavJVS6tFki4AH8_Hg1xu6yuSCGwt_ma0uOz0W9vE6OW1vEKL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 12:39:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Chris Torek <chris.torek@gmail.com>,  Jeff King
 <peff@peff.net>,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v12 4/4] checkout: -m (--merge) uses autostash when
 switching branches
In-Reply-To: <f012cc7e-14fa-40d2-84dc-7407fdceb36d@gmail.com> (Phillip Wood's
	message of "Tue, 14 Apr 2026 15:07:01 +0100")
References: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
	<pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
	<911e520431e9923d0b5795532e2abe794477707d.1776171585.git.gitgitgadget@gmail.com>
	<f012cc7e-14fa-40d2-84dc-7407fdceb36d@gmail.com>
Date: Tue, 14 Apr 2026 09:39:27 -0700
Message-ID: <xmqqy0ipbio0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Harald
>
> For the subject line I think
>
>      checkout -m: autostash when switching branches
>
> would be more in keeping with our usual style.

Thanks.  I agree.  Alternatively, 

    checkout: autostash when switching branches with -m

would also work.

>> When switching branches with "git checkout -m", local modifications
>> can block the switch. 
>
> Really? Isn't the point of "checkout -m" to merge the local 
> modifications into the branch that's being checked out?

Yeah, either "git checkout -m" -> "git checkout" (without "-m")
or "can block" -> "can cause conflict during".  Also, I think a bit
more description of what happens in the current system without this
patch series would clarify the motivation.  Perhaps something like...

    When switching branches with "git checkout -m", the attempted
    merge of local modifications may cause conflicts with the
    changes made on the other branch, which the user may not want to
    (or may not be able to) resolve right now.  Because there is no
    easy way to recover from this situation, we discouraged users from
    using "checkout -m" unless they are certain their changes are
    trivial and within their ability to resolve conflicts.

... would contrast well with "the user can resolve or reset and
postpone 'stash pop' to some later time" we will give at the end of
the message.

>> Teach the -m flow to create a temporary stash
>> before switching and reapply it after.  On success, only "Applied
>> autostash." is shown. 
>
> and a diff of the local changes?

I noticed that we show the same output as a successful "git checkout
other-branch" without "-m" shows, i.e., short list of modified
paths.  I am not sure what it is officially called but calling it
"diff" is probably misleading.

>> If reapplying causes conflicts, the stash is
>> kept and the user is told they can resolve and run "git stash drop",
>> or run "git reset --hard" and later "git stash pop" to recover their
>> changes.

Good.

>> @@ -814,6 +820,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
>>   		refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);
>>   
>>   		if (unmerged_index(the_repository->index)) {
>> +			rollback_lock_file(&lock_file);
>>   			error(_("you need to resolve your current index first"));
>>   			return 1;
>
> The changes up to here look like fixes for an existing bug and so would 
> be better in a separate patch.

Good point.

> Sometimes we return "1" and sometimes "-1" what does that signal to the 
> caller?

This too.

>> @@ -846,82 +853,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
>>   		ret = unpack_trees(2, trees, &topts);
>>   		clear_unpack_trees_porcelain(&topts);
>>   		if (ret == -1) {
>> [lots of deletions]
>> -			if (ret)
>> -				return ret;
>> +			rollback_lock_file(&lock_file);
>> +			return 1;
>>   		}
>>   	}
>>   
>> @@ -1166,6 +1099,10 @@ static int switch_branches(const struct checkout_opts *opts,
>>   	struct object_id rev;
>>   	int flag, writeout_error = 0;
>>   	int do_merge = 1;
>> +	int created_autostash = 0;
>
> This can be a bool

So are many things (like do_merge, writeout_error).  I wouldn't
worry too much about the difference between int and bool unless it
is a function parameter.

>> +			strbuf_addf(&autostash_msg,
>> +				    "autostash while switching to '%s'",
>> +				    new_branch_info->name);
>> +			create_autostash_ref_with_msg_silent(the_repository,
>> +						   "CHECKOUT_AUTOSTASH_HEAD",
>
> It's a shame we have to create a ref here. MERGE_AUTOSTASH exists so 
> that "git merge --continue" can apply the stash once the user has 
> resolved any merge conflicts. We don't have that problem here because 
> there is no user interaction and we could just hold onto the stash oid 
> in a variable.

Hmph, so it is not a shame and we can do without it?
