Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD962868A7
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786226273; cv=none; b=rgAMIZ4Dfrw5djVnHzNY0j6lV6lKocorbiMH4sq74L3pKQXAsARty8b/9CJaBNrNQbX7azFjBOY7qr+CdkdPV/3FFb/qUp2EzeJg4PTM9OZbOUmA0FVpVRNR7aephEOijwBaGHDwn2i+wSCXvrQNhf/KpbMPjAmaA1L8NTvHinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786226273; c=relaxed/simple;
	bh=YYp2vuTg0DqhNtnJuh2GGf6YQHpwpwbYNASfXn8Ki3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JQ+bu72ICRHdGP45H7kY4J0ZwHWji5j87ZIESq32ely4hrmMc+AHxGeJy3yJ3oapGLwOzfV3qzTVOJ/bgk+6STIYZPGfDLlOVIr8ltlKJ9pUJvyMsZ5uWGOAQbGSW8vdGrDeLxX/5n5q0fgq/fFtsGeAKSe1spl/U72tO66CXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hGavmvPK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FzSQE+Dn; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hGavmvPK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FzSQE+Dn"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C93487A00BA;
	Sat,  8 Aug 2026 17:57:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 08 Aug 2026 17:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786226270; x=1786312670; bh=6XrEQnW7kl
	WH9AOFoeOXY45RE6YobuBBj76EfzIAerM=; b=hGavmvPKi7vnh+PtpR0EvNTzsZ
	is+ewURhXCw2WgXyiJltxtS1TKoyiZ4pLT0DdCSMreev2VOfIFtCN+c7iG0Ptj7v
	jN1oPJTpiwXAcvAfKMKxaDJoyIobjhrOdDfY9teiLaDODXIAYGGLAIHl+CkpxI5k
	YrQUQfHEsfOdwB0hWIRaEOZJyOIwaU3VsnoDRxOoF7DQWGVJ/4JoeMOORpEj6l6R
	m5zdRWYmI+Q5ogJh67Ho+ttoeoBrd4pNcNKgx2BVtkc/jkR1g8KJXhIBSEw8BhaM
	KqXYJwQXh8+vsscBEYufoK3AaAJjfhnatD7HjVlMMFNT0Mke66HSWmezVZ7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786226270; x=1786312670; bh=6XrEQnW7klWH9AOFoeOXY45RE6YobuBBj76
	EfzIAerM=; b=FzSQE+Dn6/502nqxS+sa8GP2WS4plJ3Z/PTpN/cPsqy+uApQDub
	yr7wddQ5o5Hi1aaCDLKd+gwyh1VXvEsnhMFp23fbprF/xZ+KONKjUa8AMR8Y7UFn
	T2Jkg7ifJvg8olu8J5ipfuGyBWVWohNukR06KsVpDc5+vAT5K8IMqrqaPTKkQe9u
	UsPsBBNRob44CQuDLgJUGHsH4hDKgcyjGOKziLtB0rTOtU78HN/TOf/SfjqDIQlY
	5g+sMwLmpq6gjGA5LHy4vsUh21P4l0g6+c1qJGixJXawR+BuRu1bN12fRJJBlGN5
	ba9xLHt3feVVwEWWSPuQffvK8U+am5O9DZw==
X-ME-Sender: <xms:XqZ3au04vKIbK3Bzw7Mae10-ADS5sDldvt21LDwzdhR5MbLqadPf-w>
    <xme:XqZ3aoHr88gmATZpiH1oeX-0C0qf-Ga2cVnmxfq-2Da4rBHPOHu8XuIXChqaLIipT
    YZYJR1Ba7RhIeDXn02Ezm5mXPz5M6_YwR56e-Gt0mOMjPhGiQ06>
X-ME-Received: <xmr:XqZ3ar45RxwkLnLPkzLdoXcqeNmsBqk2Yxg-VSfCbHrrtOULcs6YpgstCAYQfFbB1Yuqe3-Ut_087tYHYkm0N_k9NtTUbKH1LQ>
X-ME-Proxy-Cause: dmFkZTE+tuo7QKKISmFY3TRxzTQirmf6hG2bUGPJxiimSQBqWSASu+SAXzjt5eZ+xPqW8F
    wzyIOzj4Dp9gLNgg7XFFgGdDKmknWoQDTz7ABzpbnyheMrKe0nBAOvqorM6ock0oQqkjJ3
    uOXmC+pbdGRfGdh7kHIsupyhFJM66fjY1u2c5ShvxEbsP+fvXP0+9/nMAOv3CJSvH6Hj+U
    kqJsBx4xy9oeZ67z9jBoIJRckZFa+4RketqadWEEWQKDHxo/n/UGGiFP3pURtDUHLkOFRM
    aov7nUrMyYUwHfK+XDjSTVJDExniWjwe8KiZoiPYk2cZUNH1d81kThqefS/634uXVidBjo
    VEOhCxGS/0fwBo+OZd2kJrhKXgRDImq4fkAtwvJMXcZPwk5JDEFqXDARf780RT4T1TH4TB
    EkhoAx2xKBgDZYpxajs4E2Xkp9/Jv4007ZYLsyscYupb4uDtIFP5DgZgQhZZbJYTCnTG5W
    Xb8bgiIfw31bLic9X1nrQY/kukK2vIEBopZJGKt7iBYVLchqvGY+4n08yDaNF8CDHFTysz
    RGcDsbYgUSxc5cPkDVfVdCWyKTA1C1xqLMSudceQjgxPp8VH2c189IkMXkcug7iKz2kpCn
    ls4OX1qWIv+Zj5NwU6RfB9gqb+XUiXUyzLeVkhhJNQ4kwdeOxt+Ux+ts1ucw
X-ME-Proxy: <xmx:XqZ3autXfODtKQCBnF_9ZDr5FSh6hFZ0bANBBv26N9Yv6A0E9jREqg>
    <xmx:XqZ3as7G08_-C8AbvsNsbG3p-IWrXUZKU7MtGqH82Ogrf4iQqE65VA>
    <xmx:XqZ3apUHR_pu6avnZvnTM9UvNKCg5T1TIRWvAVjfkRiM99YRyHPoXQ>
    <xmx:XqZ3au8rVRwTL7qWxsXelRVOKcVsl_Ml8X9TSkpb_23V_ZlfSMOiXg>
    <xmx:XqZ3ana5DtYcyqohU6IQEfOESuHdEUMLF6S9tUpKnnttsYszPrV1nbbn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Aug 2026 17:57:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote
 branch name
In-Reply-To: <xmqqzeywa6ol.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	08 Aug 2026 10:00:26 -0700")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<xmqqzeywa6ol.fsf@gitster.g>
Date: Sat, 08 Aug 2026 14:57:48 -0700
Message-ID: <xmqqo6fc9swz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> +static const char message_advice_ambiguous_remote_tracking_branch[] =
>> +	N_("If you meant to create a worktree from a remote tracking branch on,\n"
>> +	   "e.g. 'origin', you can do so by fully qualifying the name:\n"
>> +	   "\n"
>> +	   "    git worktree add <path> origin/<name>\n"
>> +	   "\n"
>> ...
>> +		char *remote = unique_tracking_name(*new_branch, &oid, &num_matches);
>> +		if (!opts->quiet && !remote && num_matches > 1) {
>> +			if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
>> +				advise(_(message_advice_ambiguous_remote_tracking_branch));
>> +			warning(_("'%s' matched multiple (%d) remote tracking branches\n"), branchname, num_matches);
>> +		}
>>  		return remote;
>>  	}
>
> The worktree.guessremote configuration is set.  dwim_branch() is
> called when "git worktree add A/B/X" is run with a single argument
> "A/B/X", which comes here as "path", and that is munged into the
> branchname "X".
>
> We used to pass NULL as the second parameter to unique_tracking_name(),
> so we were only interested in the case where we have exactly one
> matching remote, and if there is 0 or multiple remotes with the
> named branch, we returned NULL from here.
>
> The patch does not change that, but using the branch name, we try to
> see if there are multiple matches, in that case, we give the advice
> message to say "hey, don't be so lazy, as X appears in more than one
> remote, so tell me which one you mean".

Stepping back a bit, I think what I find lacking in the proposed
warning message is not that we lose what the user gave us, such as
'-b <branch>' or '-t'.  While this loss makes it impossible to
simply copy and paste to reproduce what the user may have intended,
it is not the end of the world.

What disturbs me more is that the code holds back information only
it possesses, which would immediately help the user if we shared it.

The reason we got this error may not be that the user did not know
exactly how to spell out the necessary information (such as which
branch to use from which remote) on the command line.  It may be
that the user did not remember some of the necessary details (such
as which remotes have the branch they have in mind).  Displaying
the command line and advising them to use the fully qualified name
might not be the best approach in that case.  Telling them that
they may have meant 'origin', 'upstream', or 'home' (all of which
are remotes with the named branch, though we could not guess which
one of the three to choose) may be much more helpful.
