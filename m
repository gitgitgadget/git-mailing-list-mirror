Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BFFE555
	for <git@vger.kernel.org>; Sat, 23 Nov 2024 04:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732336857; cv=none; b=UjM2LKSaJVPR8l9AFBVjJsxB+Q5SIDA+6BzlM1E3nsDZ9bN46CWGQ3j9irj4i2pg3uQujFHrpmLJZVSznTkaLB2TA/ScEW0zF8FuRUID1o381g0jANULhwZA3APkADsCoLHYye/GyMD+UnA4hnRqr9hwezRQ7qkO5eJmIqgctN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732336857; c=relaxed/simple;
	bh=q3m0heIle7alLOXJIZivRnP6n/Qx+lK2Jz0CM4aKCVs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7xpZt7OdloPcYaFY0fggrnOtymPsSrb/dAIy6UDxbZhXfre+PnPmPUPBt1JN1B5ITCeTQSgPX7PouUCDOBUZJtTXG5B9msVm+kuAnuMFusrXjZxeVPPWIHMkNSOAlsoIgtP+lGzL0NAQfZqpKJiDTmt1f7/4QWCmsClaIbd0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=YlbZ3TL1; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="YlbZ3TL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732336839; x=1732596039;
	bh=q3m0heIle7alLOXJIZivRnP6n/Qx+lK2Jz0CM4aKCVs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YlbZ3TL1tYOnmBTDZvPKEqNR88VQzSVL8jVnpaCy2Bx62l369e07jlwpWBzhXL6pl
	 xT7zxi9cc+dAup6chSpewtQSGtNxQ37uFLDpvNT4k24kj5Mi+6po8dZ8HFoSzGKeln
	 HnirWRGBBbK9or6681SafO0sC1sEm2OgKZQ0u+DA7mMOW5/ADwrXYO9n7nHLq6hFOU
	 O0kFskVej8JqS5KPcoBdgY1xuxAyKKzdM/24qclGhcdJDx1ow1lAYTr1URWvsIGkki
	 hG9Y9COi4fCN5CNo65mDIxwjhRDthTMJ6qNiKZ+9QI3WhIROnXKVr3UFoPiLw+EAYj
	 +kYJK4tZxi+zA==
Date: Sat, 23 Nov 2024 04:40:33 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 5/8] worktree: add relative cli/config options to `add` command
Message-ID: <D5TA5KT15GQL.1YOJ4I225DJNG@pm.me>
In-Reply-To: <7ddddf98-840d-4d36-b3bb-6d5265a1362f@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241031-wt_relative_options-v4-5-07a3dc0f02a3@pm.me> <20fdb5ba-075f-48b5-9e92-f85378500710@gmail.com> <D5QQQCUL0DR7.31L4W6C4NT6UU@pm.me> <7ddddf98-840d-4d36-b3bb-6d5265a1362f@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 638ff6333b7592854159d1ea5fe6469f653848e7
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 22, 2024 at 10:44 AM CST, phillip.wood123 wrote:
> On 20/11/2024 05:01, Caleb White wrote:
>> On Tue Nov 19, 2024 at 9:07 AM CST, Phillip Wood wrote:
>>
>>>> +--[no-]relative-paths::
>>>> +=09Overrides the `worktree.useRelativePaths` config option, see
>>>> +=09linkgit:git-config[1].
>>>
>>> I think it would be helpful to describe what this option does directly,
>>> rather than in terms of a config setting which is documented elsewhere
>>> and that may not be set
>>
>> I originally had a description here, but it was requested by another
>> reviewer that I remove the duplicate information and simply reference
>> the config option. I don't mind which direction we go, but we need
>> some consensus on this.
>
> Oh right, from a user's point of view describing an option in terms of a
> config option that may not be set seems a bit confusing. Looking at the
> man page we describe --[no-]guess-remote and then mention the config
> option rather than just referring the reader to the config man page.

I agree. I'll add a short description of the option here. Thanks for the
feedback!

Best,

Caleb

