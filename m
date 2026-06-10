Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2AB413609
	for <git@vger.kernel.org>; Wed, 10 Jun 2026 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107359; cv=none; b=feM/jQqCY7TFXt+d9n0nx8lBlzoyloKbuSMNx2YtbKUg+iAwfbDNeLIgsWw4/U3U3aZqsN9rWRLpRU+h0F/n+0sPuF+5aewol4HmKhw3Mqdx84qE01mVMXASj9O4XzzqcxoJ0kO9HTIVK1gzZoqoWvGoN+NyJ8YzvC24ZhZ6JxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107359; c=relaxed/simple;
	bh=F01b8+I2qOI+3BzrxVVpTO2CXHFdt4WJzADD1aXIEVo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AGCy5EMpyoUxti6JJZC5AIuGOvcWb1E3HZNKTy0VzKwTEQR9xNn9CY3wts+tty2SjcaZ8HjYtkY23JwfLDRaKgcxEDzFJ4cDKTp8d9YLEk6kwVj9FDpmOmRlfwEzfie1e1griiB7wJ1mfk2il9rCCZPbhpQFc0A/sao2q673Hwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SJRiFuF0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gov+a+ht; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SJRiFuF0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gov+a+ht"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 13E56EC0095;
	Wed, 10 Jun 2026 12:02:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 10 Jun 2026 12:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781107357; x=1781193757; bh=gghLH0IA03
	yrLmoS+LmpQH0S5X5CpvP+EZZkbQz52FY=; b=SJRiFuF0L80xqQ5g0g+NwH79je
	SVBqmiKl+nfoDHHkAV2d9/GlVTpE1Aoao3tuJoQ3mBzYuooG1HLxfqYS6VBsvm3s
	rDYja0XvUDWGGHNwyATX8E5YBy7/+x6MoEWFzXZq9kPfkFdOLBrn8qhdwG4IzHha
	5WeP4OXZgY6dA8xfZni0M/Rh/oG4BgFQdqfR3k/xESnYEat9orzda6wezdVJfve1
	QBa5UGoearyNRG8EBL+2kQADBlWchBRSgs4wgNr3hL4lm3W9cflacJJkTNphYF2S
	T0UsSBH20vcV+0CERLlEt/0D1W+Lhn69olyGjGX811Leflw11H85kwwRZRZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781107357; x=1781193757; bh=gghLH0IA03yrLmoS+LmpQH0S5X5CpvP+EZZ
	kbQz52FY=; b=gov+a+htOP6owGdRxyTCY37OKuPL5RAyloqTY1D15uiohlhjWEF
	tNMJWdOrtDGVDaVyydnA2v6Yqu9uvDypTx9SOveKasx2xFUv+gfVmDIO466zKn/A
	diPnfbmTGy5vtEe2+KweFNPsDf5gCNH3tEf/4RQQxQDqgH8KycAslfJjAh0kImes
	2aXrbDycWmwVc37x9OeqXKUm3oF2++iosFKwNluAcsWyYSAMJfQAgdNxjXxFQ55j
	6roJ/YgXFvA1pxnP0CnEaz9JN5laXo4P71bbqMC3YWvo7QI7k3o51hD0/AoGjmyc
	pHHNdpixsSEkxHTVC8rSJjBeTUoJdNM45Mw==
X-ME-Sender: <xms:nIopaveFdYpfo610ZQ7-Qjw8KQpMC7Yuz6sde9Z2kDgtvW2Da9naSg>
    <xme:nIopaiKyps_z6gF_mXXZhJ8G8sP5DI0ldjh__zwuzwd2OldCnJ1T-s-Lcc9RFaesJ
    LOD2swHmMeXLh5KhemCevVLrvzVEwyFzuBpHXTs6jEVHX9YB5dGasc>
X-ME-Received: <xmr:nIopakKCRVboQhpnKByYrO0AOaNxGWwn3UWfwuCMay0jEieEK9Vr9UygZOOZsMi0MGx5MGA1iBWT_OLTBz8xTI250Ahu2fbpiUg0>
X-ME-Proxy-Cause: dmFkZTGYL5afcmQUIWRoZEGztLSKqqkCQ4Vm39vXJZMbbAYAYUtynCGWJNI8Mi7w+VWx8q
    Yq8vKIY3Yj3LG/NHQ0+w5wDjg8WEs3S4yChTr9KTdLhENx1R04bEuVRv7B/4sE0GPft+w1
    6O7zYy5c4ohD1htWnBapzyYqbfBMvTUw1xwqChmI+AI6KD+bEZNTU5hc+ImNufyJnOZ7gu
    XzPYXYyDG7KGPPSUnqyhIZe5Qd5Mso1BLEWnPsLnX3sXb/mZW14lQrcGXdEjsGKMRw+kKu
    5JIkfy7RBdnD9Gcl7IyXd3IZSNfVK2lDYaGJkrGQVOULDlhDsloaVwhRSjYJ6BpmpjljNk
    IdOD3mFYn18j//xTT9L6LKcGqSSbPrwbvKrcgmt/ih82TjziUfVfUfpc7DCGUdw9ABw37l
    F55gPzCeP6fDqq0/qQVpWqz/ti5O3kbvuZrGZJsxe2jk1XDEmvQQR0DTt6HwuwhtRn2PpH
    EJIjVFj6zCNsA4o+Ml25ApCGamimqlEFhpjs8datNaACENNJJZ9RJawxFZXlO3u7T3jhHD
    8FtfiZjqegAhiSxHTdlMNhSZl5vQ6ypJsmUEZ6zOqC1Cwhmn+wJRZzBpEfDNEgN80rTHrJ
    KE3cD2sAMyFXhIU6gvjWg+6oOvpGwceNF1bKFWNtDfkFqcwJBWQT1/5inYGA
X-ME-Proxy: <xmx:nIopapVQtqeHmvs8H0wovPbnGlYmhPDylCGZDcfS3q_Tt-719bFgMA>
    <xmx:nIopalkrGpXmpZ1zlYC7Ve5yOhbPBBLuqsoShRk-wHdjC3g0ygUSzQ>
    <xmx:nIopanm75aWWw9jD3b7ZkoG4sPI1J_KjWAUZWwJrWi_CYvkqeqOmUQ>
    <xmx:nIopatZof_2_Ro9k1dBqC2SowKag3tbPQB4l_tTd13g7oAZcQGvwtQ>
    <xmx:nYopano9PteL06Di9X7oSORNAajBdjWY8lubRBDb5hycD1z4v5w8U7mY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jun 2026 12:02:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Pablo Sabater <pabloosabaterr@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  git@vger.kernel.org,  cat@malon.dev,
  kaartic.sivaraam@gmail.com,  ben.knoble@gmail.com
Subject: Re: [PATCH RFC v2 2/2] builtin/history: abort reword on same message
In-Reply-To: <aikMLBCC9Rc7q9S7@pks.im> (Patrick Steinhardt's message of "Wed,
	10 Jun 2026 09:03:08 +0200")
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
	<20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
	<20260609-ps-history-reword-v2-2-a0e6028ca9b4@gmail.com>
	<54bd36e9-3d21-4f83-86d6-2882a14779de@gmail.com>
	<xmqq4ijbsn2m.fsf@gitster.g>
	<CAN5EUNRz9F+njb_O=Q4DzVMec-q+rDf83Ow+MPJE4yLCBq9qww@mail.gmail.com>
	<xmqqbjdj1q1s.fsf@gitster.g> <aikMLBCC9Rc7q9S7@pks.im>
Date: Wed, 10 Jun 2026 09:02:34 -0700
Message-ID: <xmqq33yuxu1x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Jun 09, 2026 at 12:17:51PM -0700, Junio C Hamano wrote:
>> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>> 
>> >> > I wonder if we should check that the committer identity is unchanged as
>> >> > well in case anyone is using this to fix commits after committing with
>> >> > the wrong identity.
>> >
>> > I think that if you reword a commit committed by someone else but end
>> > up with no changes I want it to be kept as it was.
>> 
>> That depends on the reason why the feature to "reword" the commit is
>> being used, and the use case Phillip is talking about is a bit
>> different.
>
> So the answer is "it depends". Maybe we should do handle this the same
> as git-commit(1) does with its "--reset-author" flag?

Interesting.  I was mostly focusing on the committer identity, but
the same argument of courese also applies to the author identity.

Having said that, if the user who used to commit others' patches
under a wrong identity (i.e., the only thing incorrect about these
commits is the committer identity, and author identity of them are
not to be updated), "--reset-author" would not be usable, as they
want to keep the authorship information recorded.  I think 

 (1) in the shorter term, always create a new commit by default even
     if the only difference were the committer timestamp.  But add a
     mechanism to allow users to tell the tool to skip the update
     in such a case.

 (2) at a big version bump, flip the default, making the "always
     create a new commit" an optional feature.

would be the way to go, and the way to trigger that mechanism needs
to be separate from "--reset-author".

Thanks.
