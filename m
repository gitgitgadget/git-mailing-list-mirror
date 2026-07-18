Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F7743F0BE
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784412581; cv=none; b=mpzniF9l11HFKDWVb0lJ4MOckATxTOmYnHyLbPYBFM/3R1zTrOjzY/6mk+7GcqIZeP/lF+9vjNrUfnOhIoswbXHacAgw8McJSI7lFtHg9cRediutLHSTNUAgHsonuleItaCKqd4ntdoxkhf/wgi5dTBwvsBYqzZMmupq3K3yGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784412581; c=relaxed/simple;
	bh=KPp+TCEYIPO4RG1zyuHGBGmUQWTzuzuR9fVN4INvUH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UHX8ulcrJwtsCl6LZop22yJjaGjVrPzUNAp/+jD4Olf/GsATbT1HM9afrik5W2qugQ03LytQKCpTfkbPQSMrAXVuAZFap/3LQEtMSbEYnUFUrPf+UystXj8NTBi6KDD3g9fqEe+nnuylt1sCYvxTJUeWShO6VuTUYY+BaQDVesg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DyXoMCyw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bF5PfkuI; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DyXoMCyw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bF5PfkuI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 378ADEC01A7;
	Sat, 18 Jul 2026 18:09:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 18 Jul 2026 18:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784412578;
	 x=1784498978; bh=OUOwqKmG8T/cGbVcYY5VG+HUBROXI78xSwdpVh3AxoI=; b=
	DyXoMCyw7Fw4Qdd0BQ+SJyzeIeOeyzHRHaXOTRQl05Rc8V2ptOB92n00o7ms57hp
	I0OqMWWWxJSJgPnCK5/cOmxRXapzJWrIG8mA5z884+nBxoaoKVV/RwT4QG57GtXZ
	xyQji4RMUZDVrgLOYcInV45x/GymtBZsziPxFgSlhreLTvaLuyL8xuXWbzeVo5As
	U+TYfa3aKn3ThkzSAAg+at9loUtPFRXOUSSQG8BETxSowEYFyvCPO7lpzkpQ2iZt
	+y/1Uqw15o2TxeFcQNOPhWxQuVsf7tl8S1BIdedr/3X6euKlG/bmghzQisDn85NS
	rNekQl7bf9dLhXz+Ylbrtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784412578; x=
	1784498978; bh=OUOwqKmG8T/cGbVcYY5VG+HUBROXI78xSwdpVh3AxoI=; b=b
	F5PfkuId7lFh/FDWXISP8BDali2LBi0Fq3M1LEESQxvHUk6FfQd/WLV4CKvMJp5Q
	0fq4x1o76aeToYGPb0Txf9nBdXtk/9bOUU1S1jrobLV1j3kskd7JQ4BZDbbRg4PJ
	LaYcNYKk7fEKSUwFLclIgejKfASiSjSrSavC7KHSAGhH10a6YO6fPxjmxk7szGVm
	rmoJhjbXFZN5Yzh2kfAyjgJHIXNP64JYdK+p+Stq+unD/GCGBgL643SaapCeQqOS
	srRgIGXbf7WT1Kd0CTOFn0R4Ix/AtE8E/1Vodj/AGgj35CasWKk9xrmOPXtzYglv
	UxGouk6Rrh3OApt+D6Dxw==
X-ME-Sender: <xms:oflbatvu3VKe3IqUyhfFbV9ClROeheWavEJM5eekC4ZYw1yjmFzttw>
    <xme:oflbaot5yceYgO7nt54bhLT2_nly9PmtDGS3qeRuDJ7oXbBe9PeGjWY8X213tWIA1
    2Xd4_y7r-yOx6982qCgZ5V9FFBcXBO1UMnvefhxNTqzXqPpDoIkvA>
X-ME-Received: <xmr:oflbajB-Y5VENMctMczI7_Qd64qkAUlILoDqVXmYqhkEa8krDd5P46FvZQErunDhxR9WTm0txVa3jtAD_VWHyd0XMr2H2vDfIA>
X-ME-Proxy-Cause: dmFkZTF2yild5ymfMvyyfbO0558L9ZQhDeKw1qEVyd5I1DSVqf87dkEuKm3sEQ1JJz1hRB
    fJCAc+Xk9+RsVMGNs4ep3l91qzMuA6fFokIzjcUMhIJUq4LuBtQP1yC4nLkqeow5xYthcx
    JNxZOxuhNE5pD/7wdeb60XMAAO0mncyYXlDjOcmC40D+tN3r6aY5o5wW0Je9a4RcjC59Sa
    CjJvwFssqne9WUlWRr9B8QKZg5Cl4JL4Co4q0WvIFMWVkzYCIeqMJk9OlR2SsRqfupf4Wp
    VXSd63jM7bXN0pqsYpWxCHGW5fbVTbDiPDp1B8iW70ORMMtTSkZnkUd5vgnKmFbBQN/nnp
    HjjP39eMilTGF7vkwMjId8PcLfzr4P50euTvJTiQ1OYRC9wFAT84vq+i7pndYQbH5v2IJb
    R9iEgry/wzBF/wPqHhbG77gv5ZE1f+WyWqOy5TSnqNANi5gjTitC9FMKRtEuKH5iOoCXzq
    P0Wb+GrmDUJbYKgx4j7ua2LwAyI2bykU4EJLIVZSPxQfZ5uI57LZeMy+IuptawE2TkBrFH
    SUidgZ5JHLOPqhJ14yaTRiOLUSmWm11iNXR0SENWQaqxd0JKLZgQd8dBYEWOeDo0MZKdzG
    wkro2nAbqed4YCl1pN42c7YQM+LRyy2LVrcFUY4Lk2MymfkpnoERM6ZLVSKw
X-ME-Proxy: <xmx:oflbaqNIq4HDWKtyrsUjDqUQNYyeMCbv2_heIuvqCHf0YcCkDE2rhQ>
    <xmx:oflbaswzKbEb3S5GWRIwWx1wVjml5tD7tGqccZXr9vCsGAhoHYWHwg>
    <xmx:oflbaqW1cW3v8FovgYEyDUVRjY5r2VvYCT4rAI3ThYVdzdADw0KfJg>
    <xmx:oflbauPwksCrznqXYHfi8rTuuyezLKlCMM4qOBYmxzeTSTTKIPjT-w>
    <xmx:ovlbarI5M69t26JSrEDl6KpJpVFUPkXmTiHt7nz1ZJLTRoSi8u1gGLFS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 18:09:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Toon Claes <toon@iotcl.com>,
  Patrick Steinhardt <ps@pks.im>,  Git List <git@vger.kernel.org>,  stsp
 <stsp2@yandex.ru>
Subject: Re: [PATCH] branch: report kind of checkout when rejecting delete
In-Reply-To: <c7357faf-3d2b-46c6-99e7-88d3e2c72a77@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 18 Jul 2026 21:07:41 +0200")
References: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de>
	<xmqqjyqsqk1a.fsf@gitster.g>
	<c7357faf-3d2b-46c6-99e7-88d3e2c72a77@web.de>
Date: Sat, 18 Jul 2026 15:09:35 -0700
Message-ID: <xmqqa4roq7a8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>>> +				int kind = branch_checkout_kind(name);
>> 
>> Not "enum branch_checkout_kind" but "int"?
>
> Yes, it doesn't matter for the switch and is easier to print.

I do not understand the "print" part.  I was probably in the last
group of people who was forced to switch from CPP macros to enum
and their argument was always "'print kind' in GDB gives symbolic
output".  As "enum" is an glorified "int", wouldn't 

	int i_kind;
	enum branch_checkout_kind e_kind;
	BUG(_("we did not expect %d %d"), e_kind, i_kind);

do just what we expect?

>>> +				switch (kind) {
>>> +				case BRANCH_CHECKOUT_KIND_CHECKOUT:
>>> +					error(_("cannot delete branch '%s' "
>>> +						"used by worktree at '%s'"),
>>> +					      bname.buf, path);
>>> +					break;
>> 
>> We may want to be more explicit and say "cannot delete
>> branch 'frotz' checked out in worktree at '/tmp/nitfol'"
>> instead.  Unless this is a catch-all entry for states that
>> are neither 'rebase', 'bisect', nor 'rebase-merges' but are
>> somehow otherwise in use, that is.
>> 
>>> +				case BRANCH_CHECKOUT_KIND_UPDATE_REF:
>>> +					error(_("cannot delete branch '%s' "
>>> +						"used by worktree at '%s' "
>>> +						"for update-ref"),
>>> +					      bname.buf, path);
>>> +					break;
>> 
>> I was quite lost when searching for cases where this 'update-ref'
>> state might be encountered, and I still lack confidence.  Can
>> we make the diagnostic message a bit friendlier to our users?
>> 
>> For instance, something like: 'You are rebasing a history with
>> merges in that other worktree, and the tip of this branch will
>> be updated when that process completes, so you cannot delete
>> it from here.'  (Naturally, I may have misidentified the exact
>> nature of the error, but this illustrates the level of detail and
>> user-facing clarity I hope to see.)
>
> That's quite long.  Would it make sense to throw that update-ref
> case into the rebase bin, i.e. only distinguish between checkout,
> bisect and rebase?

Shortening a quite long expression down to digestable pieces is left
as an exercise for those with this particular itch to scratch ;-).
I do not personally mind if it ends up indistinguishable from other
"rebase" case (or unified the "kind" enum into one), but others may
have ideas to shorten the message to fit in the pattern we see
above.

Thanks.
