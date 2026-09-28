Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95A4E433A
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611381; cv=none; b=n5jhtcSAgg9KhaNriFxAG6Dcq81ccQ8qsWmVilwoBExhdswmDLLxoJQJ4oiQqi1xoUyUQyXVwE8E5D1DcqrkUB1QAHUuhiZzS2dUyrZue4G6O7Casl+jqr4NDY20iScI2nC02ZyojKC/pPuPnJ7mHDS3DcqP7S63YrBEhaKVIuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611381; c=relaxed/simple;
	bh=gkqoueewLUkW+T9jyzgi6G3o34VjvlUdu0N7i8ywa0o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CXBKQ0lVmpKxnQupcNmSB7O1dO3hu0hAlYBA5I6VUWmN/em93cz+BTbjySvD/7bkjmjKb3zbbahmN1KZYo2CqVphhOCVnQaqtnt29kdJvK2IyDiQ0040jobPqstuVlbsilBUlnxMtAoXnZAvf/QOEimq2jxgpfilKPZY8O6+5HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.joshka.net; spf=none smtp.mailfrom=lists.joshka.net; dkim=pass (2048-bit key) header.d=joshka.net header.i=@joshka.net header.b=6k/AZH84; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sEPRp9Sn; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lists.joshka.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lists.joshka.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joshka.net header.i=@joshka.net header.b="6k/AZH84";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sEPRp9Sn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B5BB7A00EA;
	Mon, 28 Sep 2026 12:02:58 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 12:02:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=joshka.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1790611378;
	 x=1790697778; bh=6GVDZJ97KLHTFZdJu39ZDJVbItHkQjQzJ/aVPJPeyjs=; b=
	6k/AZH84Z/kgsguT9EtaJnA202nHdc+illLNPvp61/S95rIS9tKhqABNvRqKs2gx
	IL4hedThK31BK5dtDl5PcUqZx5fL5Qx39GF200kDq8zJXQjiwx+rRNelUsUYWM/y
	SY1kgtq+h7xx/7qYZGHvJrqgJ1qtOLXM3rUco2MLl+E7edtZZepN4LdSWdF3zQD8
	qkxBq9+O6s7WPir1X/5lZ02CT1jIflOaz/mYA8lY4J25/ic5NbI8Eq/Pxt6ojxZx
	fD92lzU9WnHc0dRO3PcgvSR+dx7Hx0GJDC7gWLJUa2EBxlxA0B9KzoTgYKiDmCIm
	dtJzgcpanMa9nDorVSVqzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790611378; x=
	1790697778; bh=6GVDZJ97KLHTFZdJu39ZDJVbItHkQjQzJ/aVPJPeyjs=; b=s
	EPRp9Snq9ctsK+JdSqzanUJlkdt0sk7z2VoHeqA9pikJlSqA983XeonK3kdfddhE
	1OikKYr73YsPFikgjDtukpNjVKWJ7CH5YwkRQ1vzHeElK8CoX+8bKw6l75d7Woxg
	Iiju3xpmdIog5zl7zjkCruEsZts5y3z4MKLlUAO1sToVf+QxgZcC1hwJzG0MzSKT
	pXEaweCMgQghdEjkS/3LXrsBG6ABdCSoPbj/mCEP+wP0rauflt6Q/RFLlEV+0HAG
	FLhPKDkmi5eMTp9Fx8TE05azz9twwpSKGiooBjhtrU9L4ZmLxBVCe/1kwG15hXh6
	YLl4jXSDEW+W9uitpd4eA==
X-ME-Sender: <xms:so-6anwIuipsx_uPJbNXi2OqslhJhVUSTcO3W0hWFQOPgmzQzsd3qg>
    <xme:so-6aqHYs4qhlBXsswreMeK4vQZH_ac-3oc5uHlHZbGKSic8AKzjGgA1_OffTaZ9N
    rTsPayBLCTAy8bco-fCVjq3FugCoisiPnft49skFK9ZenY2o9jg4EY>
X-ME-Proxy-Cause: dmFkZTEuuS143QIHYcLwRd0a2E9tV0gaoNAFHsGVRNLuKjMWd9OnPRL0b3USHMOQLzACfM
    fw9u2pYWoz7UQ/uWhhLN53rsw5yEgnOoiQjjCIo1caHnrziJ1f7wtx+s0RVcMqj43l2sJd
    0QFWh6TT8Y8jahv9chF67Ps0vr4kN/JPh8UFaHWCKWPdEOnnIH4BHwq4LQ6V+uYUhb+mkW
    +lXKdJQDSHHjoSzP3h/d7m+iyzn3yeepjof8SIbFSOrLlkGKAmAV4Z7raBdfpHVZz8Tay3
    LkXy4T/9Vy9qMj7SCE/kjX9YXk+cK8KvTLE5g9Ma+/MjBLXsI1pyd7pmLWuKa/GAqhkRAt
    JzKcNAH6xHkXP+xgVTU48Cs/aVTYkXnMHforByMjTNTOBK90fdq9o1shMlOo5XKVSVbJ0T
    dt3V9rbZlUf+ThcYtBYk3L2FfrNMFCu8TeB28qB+pelP3OPBy0Wn3wfb0mTAiFfLvsMkhK
    0f3v7HEILMTUftHheCoYeNsIAcviiUDFdSpzvV8Pe3/nfYadkKRCLkptJB3e2R2zGvjHaD
    /+y/WxnfwpkJEdW0K8j/VWeyDBLKwgKy1wDSwN/xrcaD+BPudyyLIRojisCtzZMZFkVkaN
    KAYrZCQZ4dAoDBoUdzVbH221EFTh44YGYv93hGnxFYVQeW1cJoYnnqtA208g
X-ME-Proxy: <xmx:so-6avPw_T2Mjf6ivIAdH2SkmnO0SL5C3c5SXFESxSHk-8M-CxfyKQ>
    <xmx:so-6ahttaE6QLhHOSIHlE3LGktkf4F8bKlUp1F0HIxdSpUdLFE8pcA>
    <xmx:so-6ahUywp3dZJFRWGO_EKgEKL73lpYfvYyM4i2n0Hr9v6SsiUtPmw>
    <xmx:so-6ahuymxD6ar0XwKijXmN9LXOxm2G7aABj77YqoBs3yt7ttxfGbg>
    <xmx:so-6atL4FVw0OwQHHn0PrBY4BEn0WeYCqnEBi47OZjdbmn5wTxU-Zwwz>
Feedback-ID: i504042c9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 170A2700065; Mon, 28 Sep 2026 12:02:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: APvEQebsEnVZ
Date: Mon, 28 Sep 2026 09:02:36 -0700
From: "Josh McKinney" <git-bugs@lists.joshka.net>
To: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
Message-Id: <2abba760-d331-4cad-bb8b-6e567b517beb@app.fastmail.com>
In-Reply-To: <xmqq33utphdy.fsf@gitster.g>
References: <85f7daa8-d60b-4348-ac2f-b1a68628af7b@app.fastmail.com>
 <arpZ5xCwFXc9ikrj@pks.im> <xmqq33utphdy.fsf@gitster.g>
Subject: Re: Reftable reflog timezone encoding differs from specification
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I think my main concern here is mostly around using multiple tools on the same repo and how they should interpret on disk formats (my clanker picked up the problem when comparing git's output with a library it's writing).

Anyway, nothing urgent on the problem from me because I noticed it purely in a development context.
Thanks for filling in the bits about the real world impact on this too.

Josh

-- 
Josh McKinney
joshka.net

On Mon, Sep 28, 2026, at 7:42 AM, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>
>> We should use the one that we have in our specification, so in my
>> opinion we should fix Git itself. This is also because JGit, which had a
>> reftable implementation for far longer compared to us, implements the
>> specification correctly:
>>
>>
>> 	private PersonIdent readPersonIdent() {
>> 		String name = readValueString();
>> 		String email = readValueString();
>> 		long epochSeconds = readVarint64();
>> 		ZoneOffset tz = ZoneOffset.ofTotalSeconds(readInt16() * 60);
>> 		return new PersonIdent(name, email, Instant.ofEpochSecond(epochSeconds), tz);
>> 	}
>
> Thanks for checking.  I (unfortunately) agree with the (unfortunate)
> conclusion.
>
> We do not ship reftable files over networks and reflogs at the
> conceptual level is not shared across repositories, so the issue,
> other than the trivial part of updating the implementation, is how
> to migrate the data in a local repository that uses reftable.  One
> time offline conversion may be the simplest but I do not know if it
> is worth it, given ...
>
>> We could of course retroactively declare that version 2 of the format
>> uses the syntax that Git uses right now. After all, JGit only knows to
>> read version 1 of it anyway, so that could kind of fix it. But for any
>> repository that uses SHA1 we used to write version 1 anyway, so this
>> does not really buy us anything, I'd claim.
>>
>> In summary:
>>
>>   - We have an upper limit in divergence of <10h.
>
> ... this.
>
>>
>>   - This only matters in the context of reflogs, we don't use these
>>     anywhere else.
>>
>>   - The risk for data loss by a change is limited as our default grace
>>     period for garbage collecting reflog entries is 30 days.
>>
>> With these points I'm inclined to call it a bug and just fix it, without
>> handling backwards compatibility.
