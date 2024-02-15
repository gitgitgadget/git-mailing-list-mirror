Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAAD41A81
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026483; cv=none; b=adyKIbQT054Pa9WMs6Olixtt+rUeaga09VeWnGibtmgsrheNh/aQc+ZotFCkzYkupXdMn+TCsqvTsikhdkhyUUwKr8cNgNSOQc048q5s3IUEB9bOQWey2QDGLMoNeZYVD0JiYnkB0Gey85wJfHZZhVXzLDNQRKdAkwqFzijazoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026483; c=relaxed/simple;
	bh=E4VuoSkXNI19FZylmSZEU/2FsV6n4KGB6Md05B/zpaA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MrVvivNLo9wE0NVF85LZqhqCZ2gDFqfIWX2d3n2V2HAjN7QNI7RrZwopsamc0lKeG/UPh5pURGE3ntxMJbm/TArkKJadXresFZr+yQRFo4L4LLkM94beLrN8jP4rlsw2WcpPUBc0uyXeQqhOBe1hlcrYNDKqRvlowzuoMPo43xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Z1MiGm9G; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Z1MiGm9G"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708026460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tapQH24f7XZZ5fI5aHnYsqJEadNCIWOb1Dq4YiFxHbA=;
	b=Z1MiGm9GkpkFfgAxVNno+kH0Jo9kxTxtgaHCq7RMTX+A7LPZvIkuhpuqdT1aoULbZ/oilb
	Laqg85ZOIAX3EJ7NCZS5ahJDQlyOmGzUM6XmDuuwO/OFaiZoPatPNI4dhoyMGlLoreUID5
	ghI89zGcMRHhcz0g/oLdjug1FmqMuOkL81XJrwPQ5vIfkNnPIXrh72mey6998JFS10AS0D
	wlNEfktj5yJOwsGg92ONla0A8Xl1M8Ey1xzdNpfwz9m3lP4AkVxNGaz6z8tjoYyVzXCDu5
	SP+c4g0J5YPAY7PEE21QORxADMmsIZYtWvuVs4w084oFvCqaQ/f1PftWKtGejA==
Date: Thu, 15 Feb 2024 20:47:39 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Kyle Lippincott
 <spectral@google.com>
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <f9ec6d31-7158-4381-9701-06fcb33f2e83@app.fastmail.com>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <f9ec6d31-7158-4381-9701-06fcb33f2e83@app.fastmail.com>
Message-ID: <6d3cf1220823e793a5244d187627ce97@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Kristoffer,

On 2024-02-15 20:28, Kristoffer Haugsbakk wrote:
> (I’m adding some Cc from the previous round)

Thanks, I realised that to be missing like two seconds after sending
the patch to the list. :/

> On Thu, Feb 15, 2024, at 19:42, Dragan Simic wrote:
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
> Excellent.

Thanks, I'm glad that you like it. :)

>> The subsequent improvements shall continue this approach by either 
>> dissolving
>> as many sentences from the "Description" section into the "Options" 
>> section,
>> or by having those sentences converted into some kind of more readable 
>> and
>> better flowing prose, as already discussed and outlined. [1][2]
>> 
>> [1] https://lore.kernel.org/git/xmqqttmmlahf.fsf@gitster.g/T/#u
>> [2] https://lore.kernel.org/git/xmqq8r4zln08.fsf@gitster.g/T/#u
> 
> Since this is a one-patch series, it wasn’t clear to me what 
> “subsequent
> improvements” was referring to without following the links. By 
> following
> the links it looks like plans have been made to improve this man page
> further. Maybe the commit message could either state this intent more
> assertively or commit to it less (like “we might in the future…”)? So
> that the links become supplementary information instead of seemingly
> filling in some blanks.
> 
> (If I read this part correctly.)

It refers to the already planned further rework of the git-branch(1) man
page, which I intend to follow, but also leaves a TODO note to anyone 
else
looking at the repository history, in case I end up not following the 
plan
for some reason.  I hope this makes it more clear.

>> --m::
>> ---move::
>> -	Move/rename a branch, together with its config and reflog.
>> +-m [<oldbranch>] <newbranch>::
>> +--move [<oldbranch>] <newbranch>::
>> +	Rename an existing branch <oldbranch>, which if not specified 
>> defaults
>> +	to the current branch, to <newbranch>.  The configuration variables
> 
> I had to read the first sentence a few times in order to understand 
> what
> the “which” part was saying (which seems to come from [1] by Junio). 
> How
> about letting it trail the sentence?
> 
>   « Rename an existing branch `<oldbranch>` to `<newbranch>`, with
>     `<oldbranch>` defaulting to the current branch if not specified.

Makes sense, maybe even something like this for the v2:

     Rename an existing branch <oldbranch> to <newbranch>;  if not 
specified,
     <oldbranch> defaults to the current branch.

> 🔗 1: https://lore.kernel.org/git/xmqqttmmlahf.fsf@gitster.g/
> 
>> +	for the <oldbranch> branch and its reflog are also renamed 
>> appropriately
>> +	to be used with <newbranch>.  Renaming fails if branch <newbranch>
>> +	already exists, but you can use `-M` or `--move --force` to 
>> overwrite
>> +	the files in existing branch <newbranch> while renaming.
> 
> “the files” refers to the branch configuration and the reflog? People
> who read the man pages might not know that the reflogs are implemented
> as files and get tripped up. Maybe “to overwrite” could be left
> unstated?
> 
> Or maybe I just misunderstood this part.

Basically, the internal logic just overwrites the files, whatever the
files actually are, and issues warning messages about that.  Frankly,
I'm not sure that having "--force" available is the safest possible 
thing,
but it's already there and needs documenting.

Thus, "the files" refers to just that, the files in the destination
branch that pretty much gets garbled after forced operations.

Perhaps it could be worded like this in the v2:

     ... but you can use `-M` or `--move --force` to overwrite the 
contents
     of the existing branch <newbranch> while renaming.

> This patch also drops this part. Shouldn’t this be noted?
> 
>   « , and a reflog entry is created to remember the branch renaming.
> 
> Right now it looks like (reads like) the reflog is moved and an entry 
> is
> not made about it.

Good point, thanks.  I'll address that in the v2.

>> --M::
>> +-M [<oldbranch>] <newbranch>::
>>  	Shortcut for `--move --force`.
>> 
>> --c::
>> ---copy::
>> -	Copy a branch, together with its config and reflog.
>> +-c [<oldbranch>] <newbranch>::
>> +--copy [<oldbranch>] <newbranch>::
>> +	Copy an existing branch <oldbranch>, which if not specified defaults
>> +	to the current branch, to <newbranch>.  The configuration variables
>> +	for the <oldbranch> branch and its reflog are also copied 
>> appropriately
>> +	to be used with <newbranch>.  Copying fails if branch <newbranch>
>> +	already exists, but you can use `-C` or `--copy --force` to 
>> overwrite
>> +	the files in existing branch <newbranch> while copying.
