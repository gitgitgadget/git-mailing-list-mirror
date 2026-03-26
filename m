Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50368392C50
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774552989; cv=none; b=Lfgw6hwJuvJJ5pUEXhocDZ2rEXRXpqEXVdB8IA3tvpkiGQ81EPCkMuoegckTNQjUejBxVdz5CDU6Yhg97Ydy/3jH29u8S+hHWHY/L9WHPr/lLwHHCSrF6pgDOwllTvhGGCYd91TvxoWWintb4lNFAqZHg0WYJH9+hsU5tS8yvEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774552989; c=relaxed/simple;
	bh=qwS/Ii6u1U4VV0ks6SZr696DQUIb0M7btkwMBQplsHQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oduYwZy7U54KrUVOe5R6rQ22Bm5g7Xsduk4NSUPd3E6tx0c7IbeU7I7pBxdOCd6mkJYwEk2AamjGClkcGpYnX7Fx3hiv0rD5tapQNSUpGCos2LQi1HEBYegy0jqJQHxN6UZJL/fGOhOJuSSdlb4BqA5OFJmnEcjEA7DBwIj0MKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=CqoUKpO+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1nCz2azP; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="CqoUKpO+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1nCz2azP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74DA87A017D;
	Thu, 26 Mar 2026 15:23:07 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Thu, 26 Mar 2026 15:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774552987;
	 x=1774639387; bh=AIbunBb4IyE1yz3pftIcKCza0bmGCfqWXuNZV16Ek/k=; b=
	CqoUKpO+BXmUwYuHYGTKxSdaNz9bN58hwMbTYvV4uXvXOTe4J7AnXYaJr3qRn6g/
	QopCu+bWd6bz1BMuYQGxIIusOwiW6SW3XbD9O84ucCRatEs2Hib30hFC/YgE5+34
	nwXLZeq6NzxDYrLlrTcoyCjqQKQF/hKg8AlCGOqvA7MlmVv7ey8mCTkqABWr0gtf
	FLkehKBviwaQHGg5HuG6qob78saUITkFpeFPmZQ50W16dbbPytIs4/byBhG+eM5I
	qyfgo9zV7a25pbdKtsPbYsqIfWy/PJnmHGPEV57yPcj3NRSadNe5U+tI2FYNlRIe
	8hlJZkAft7/ZIRANf61slg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774552987; x=
	1774639387; bh=AIbunBb4IyE1yz3pftIcKCza0bmGCfqWXuNZV16Ek/k=; b=1
	nCz2azPxa/+D9PhAxu9DMZj60QZ7Jywe7vezEWsbtaU18nZVB72Rmno1J4IrphJq
	xV5OxFvbNqyLJlyhek1hVaSuHk7GVM6Xf8ACfxsnPFbMDybBYH5KKTRfKF5lz3Ep
	k0Xopm6ONMNsGEaH5vXbfR8S/ieoucdv0SWEJBQEodvt8x3eJnNVM4YX+9SAZpXn
	3YsGYq8FPGgugqWlD+geOSH7MyY1qPhoPZfIOskeavh4hkeKqMPVu5hO1u3Is9pS
	kM3g1bk785MLBi+fqtvBpPPILbqnajOqaTMHMRTKTMtdvEAGWyMYP+RpcuqOrMgB
	EE8oSyeyzGHcdvt+SH+YA==
X-ME-Sender: <xms:m4fFaYtui556wnKAczdShar90fHsKKSNl6p8ElbNsTLrR0fre-oxhJg>
    <xme:m4fFaQTHYRSIy95kSWQqKXmDuAvIrLWpKu5kz3HdmsF2gEZ475KYjuP2pEHIwg57J
    M-7sNjam-5ikwTihupUNeSOBkCegr2XvX7QmqIMQ6Zok29dI8Ogr6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefoggffhf
    fvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcu
    jfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeej
    keelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:m4fFaXaOioq7nGSkopz7_uO6F486GkII7rf5yhVJB0lI6oJ-4x1kXQ>
    <xmx:m4fFaUX1nkmCb7lkAvCFThTgVU3LjqgiXVG6cD6qAA5I5rfn_x1zjQ>
    <xmx:m4fFaRjqbAQfAhT_bpa8DV0CcewLfCLcLRefmVZZ8lOH0bTos-qvkQ>
    <xmx:m4fFaaUnafjhRtM6RTKmwmar4hrRFfOB0Da-VWAXizE7zuKFtOh8dQ>
    <xmx:m4fFaSCMRz8_0ZOEBSbRePWtaIiM9awsK8f0qkZX_WRuOF9f-xCUr5lD>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 06ACD1EA006B; Thu, 26 Mar 2026 15:23:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdQjVcg-2Zqk
Date: Thu, 26 Mar 2026 20:22:46 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <8c9dd9f9-4d41-4901-b1fb-080e4e73b40a@app.fastmail.com>
In-Reply-To: <xmqqtsu2pgu9.fsf@gitster.g>
References: <xmqqldfgy1ye.fsf@gitster.g>
 <e33142cb-1ec3-468f-8080-ba3bad79ae25@app.fastmail.com>
 <xmqqtsu2pgu9.fsf@gitster.g>
Subject: Re: kh/name-rev-custom-format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026, at 19:48, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:
>
>> On Wed, Mar 25, 2026, at 05:20, Junio C Hamano wrote:
>>> * kh/name-rev-custom-format (2026-03-20) 2 commits
>>>  - name-rev: learn --format=3D<pretty>
>>>  - name-rev: wrap both blocks in braces
>>>
>>>  "git name-rev" learned to use custom format instead of the object
>>>  name in an extended SHA-1 expression form.
>>>
>>>  Comments?
>>>  source: <V2_CV_name-rev_--format.51b@msgid.xyz>
>>
>> I=E2=80=99m working on rewriting the functionality in the form of a n=
ew builtin
>> git-format-rev(1) that lives in `builtin/name-rev.c`.
>
> By the way, why do we want yet another builtin in the first place?

I didn=E2=80=99t want another builtin. I looked at the options and didn=E2=
=80=99t find
anything that fit the described use case.

With git-name-rev(1) it looked like formatting options could crowd up
the place.

> Wouldn't this be done as a new option to "git log", for example?

Okay with me.

git-log(1) blocks until I have closed stdin and effectively dedups
the output.

    git log --oneline  --stdin --no-walk
    HEAD
    HEAD
    HEAD
    ^D
    <HEAD is listed one time>

So if an option could tweak it to instead (1) give one output per line
(like git-name-rev(1)) and (2) not deduplicate (well, follows from (1))
then the problem seems solved.

Thinking out loud here.
