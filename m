Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AA135A64
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118415; cv=none; b=mKqonD1vM0wKtV9hVJy/TP1Jzp8PmXXD9eqpvRKPmFcZG7s0GnEv1dBsz2TFJiHLjUXEuttsmF9p4rrbSH47hmrNH+1Kp6wqBbju4Wxrsi1O/RhY0DtVdeRZzPhxCluVsM+0hTeb/7qE1FVpt8mkGjnuuETU2MMU3QsI3i/ezd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118415; c=relaxed/simple;
	bh=GVOwFDx1PYznTkX5y43enxxZM+3IED4AR3EtheNNqIU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qs4lcoruAKQZyMB3tpSg1MTf1QkwiPwtFKH7CEy5Sik8QHn5ECoZQDKwYyp/kGi4g68xjWvy+Hybglbuza45PI69xFpitmwTngEw+oJ+RAAh/DJ1/ogGIm9KK9dwf4DT9y5Reysaww6GXlt4HCQlf3daDBrk3Jh0/rhXTcV+B+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TCxly4F8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TCxly4F8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708118404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iNwwLKJiREeKXwkYILZXLYN0FoD3rtpIDXn17VMuWuE=;
	b=TCxly4F8fYqj1MXAsRBUFg0EuDUEH7LR6mljqUaWCcR+jh/zPFfqD2URVZzG/EWjhlLEmC
	njfLuGPtnSjzs1b+3EaUsSfXVhGvIjTkBznurESc4uWQTbdDRXvp/MIfGZSCffwx1Fm8QW
	F4lCrpqx+d/TmEEgWAC/XGu0qUwHixRHWCZ9Ua71bHmaLDO6H2G9FgOt/vxcRbcgrZtw0K
	suiXHeM12sKrSNyaX/6/r/JOOqp5Nxb85oEFHrcz9jFiWhV2jzQniYGR3QbLUNWHY2mKNw
	dgpMpQusUlDjyGK9gs0pqG51tSYRbaSVBXMQjErnvaNexLya/ypw054pjlc0hA==
Date: Fri, 16 Feb 2024 22:20:02 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name, rjusto@gmail.com,
 spectral@google.com
Subject: Re: [PATCH v2] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <xmqq1q9ci3jt.fsf@gitster.g>
References: <6e1c3f2c5816f09aab561bc7dec2b7455d70aaec.1708087213.git.dsimic@manjaro.org>
 <xmqq1q9ci3jt.fsf@gitster.g>
Message-ID: <608b4e81d71a95c820f1e4068382d391@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Junio,

On 2024-02-16 20:59, Junio C Hamano wrote:
> Dragan Simic <dsimic@manjaro.org> writes:
> 
>> Move the descriptions of the <oldbranch> and <newbranch> arguments to 
>> the
>> descriptions of the branch rename and copy operations, where they 
>> naturally
>> belong.  Also, improve the descriptions of these two branch operations 
>> and,
>> for completeness, describe the outcomes of forced operations.
>> 
>> Describing the arguments together with their respective operations, 
>> instead
>> of describing them separately in a rather unfortunate attempt to 
>> squeeze more
>> meaning out of fewer words, flows much better and makes the 
>> git-branch(1)
>> man page significantly more usable.
> 
> The intention to remove non-option from the OPTIONS enumeration,
> and to explain <new> and <old> used as arguments to -m and -c where
> these options are described, are both very good (heh, after all,
> they are parts of what I envisioned to be the way to go in the
> longer term ;-).

Yes, that's what I plan to work on after this patch is, hopefully,
accepted (see also below).  My initial hope was that we'd define
the general outline for the completely reworked git-branch(1) even
further with this patch, which should in turn make the future work
more efficient.  I think we're on a good way. :)

>>  overridden by using the `--track` and `--no-track` options, and
>>  changed later using `git branch --set-upstream-to`.
>> 
>> -With a `-m` or `-M` option, <oldbranch> will be renamed to 
>> <newbranch>.
>> -If <oldbranch> had a corresponding reflog, it is renamed to match
>> -<newbranch>, and a reflog entry is created to remember the branch
>> -renaming. If <newbranch> exists, -M must be used to force the rename
>> -to happen.
>> -
>> -The `-c` and `-C` options have the exact same semantics as `-m` and
>> -`-M`, except instead of the branch being renamed, it will be copied 
>> to a
>> -new name, along with its config and reflog.
>> -
>>  With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
>>  specify more than one branch for deletion.  If the branch currently
>>  has a reflog then the reflog will also be deleted.
> 
> But the halfway modification to the description section in this
> patch is not an improvement.  It makes some options described there
> while -m and -c are completely missing now, making the section
> incomplete and coverage of the operating modes of the command
> uneven.

If I got it right, you'd prefer this patch not to be accepted
separately, but as part of the future series that would rework the
entire git-branch(1) man page?  I'm fine with that as well.

>> +-m [<oldbranch>] <newbranch>::
>> +--move [<oldbranch>] <newbranch>::
>> +	Rename an existing branch `<oldbranch>` to `<newbranch>`;  if left
>> +	unspecified, `<oldbranch>` defaults to the current branch.  The
>> +	configuration variables for the `<oldbranch>` branch and its reflog
>> +	are also renamed appropriately to be used with `<newbranch>`.  In
>> +	addition, a reflog entry is created to remember the branch renaming.
>> +	Renaming fails if branch `<newbranch>` already exists, but `-M`
>> +	or `--move --force` can be used to overwrite the contents of the
>> +	existing branch `<newbranch>` while renaming.
> 
> OK.  This is way more readable than the previous attempts we made.
> 
> The description of the single failure mode still worries me (see my
> previous message on this).  Here is my attempt:
> 
> 	When the command fails due to an existing '<newbranch>', you
> 	can use `-M` (or `--move --force`) to force overwriting it.
> 
> to hint that there may be other ways for the command to fail, and
> hint that `-M` may not always resolve issues, but I do not know how
> successful it is.  I could add

Makes sense.  It's intentionally a bit vague, but should work fine.
I'd just replace "the command" with "renaming", and avoid addressing
the reader directly.

> 	Note that `-M <old> <new>` will not resolve an error if the
> 	reason why `-m` fails is to protect the other worktree that
> 	checks out (or otherwise uses) <old> and <new> points at a
> 	different commit.
> 
> but we do not necessarily want to appear to be exhaustive here, so,
> I dunno.

Huh-uh...  I'm not sure that such an exhaustive explanation would
make it more clear to the majority of users.  Perhaps it's better
to remain a bit vague, at least for now, and omit such details.

>> +-M [<oldbranch>] <newbranch>::
>>  	Shortcut for `--move --force`.
> 
> OK.
> 
>> +--copy [<oldbranch>] <newbranch>::
>> +	Copy an existing branch `<oldbranch>` to `<newbranch>`;  if left
>> +	unspecified, `<oldbranch>` defaults to the current branch.  The
>> +	configuration variables for the `<oldbranch>` branch and its reflog
>> +	are also copied appropriately to be used with `<newbranch>`.
>> +	Copying fails if branch `<newbranch>` already exists, but `-C`
>> +	or `--copy --force` can be used to overwrite the contents of the
>> +	existing branch `<newbranch>` while copying.
> 
> Exactly the same comment on "other failure modes" applies here.

Noted.

>> -<oldbranch>::
>> -	The name of an existing branch.  If this option is omitted,
>> -	the name of the current branch will be used instead.
>> -
>> -<newbranch>::
>> -	The new name for an existing branch. The same restrictions as for
>> -	<branchname> apply.
>> -
> 
> Removals of these lines are very pleasing ;-).

Oh yes, it's like a clear embodiment of making the current mess
a little bit smaller. :)
