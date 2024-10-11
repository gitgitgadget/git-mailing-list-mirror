Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F4199FC5
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664292; cv=none; b=bAIUfPCDiir/sRuU3mwBGs1S3p64jkstvuRO/GBb6q/lSjfYNTfjfov+P+Yht3fPh7fLXeyYDH0sxynX4THQBzeG6lANKO7yNio86kKzNr6Jyrli3kRdMJ+ae9vsmjoRdCpLNGHNXFpD2wMEBDqRlpUOU88l5eGqGEx4qJH3hl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664292; c=relaxed/simple;
	bh=JOeAzTpBxpBjDDmWFbw/2TftKJenKr3wrYyMkWV+xzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XKTRyYHwDp1tsEMcTeBCRpTHQtAEj4Y1J8wGEJlOyq0/dN29L2a7pnNAVsHXKZYImLJ45+nFtPN0DIZeSVQIAIsrjkLNVk7/eNNDgWco50eNzuCSlCcNkNQxhJGeJ92g/k1GomzDoUTj9rw0cnGAB4cBH2zPkjIloOozOp52AXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gNoW8jJg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BRdKbe51; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gNoW8jJg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BRdKbe51"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 52DD61380061;
	Fri, 11 Oct 2024 12:31:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 11 Oct 2024 12:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728664289; x=1728750689; bh=aW+bK/QK+v
	i1gPPOFQCp68KxNYpUtHfoG0eVCgS/cE0=; b=gNoW8jJgHTA6ALttQIEFxOM6l7
	5gTyFlk6XTrCmtGnN650MgA2FW+TQOWVt1rZzeSwczpOT9NORVRDdgFcVUj70k9c
	aoGlzZuyTzyBPJCZxYrcgnwpLS7TZFp+/3cM79ch619MNXeZ6poBDs4FiZxpS4pn
	1LWj0OcpIBXgcYGqdS9Snq6kAZN1apfbojeyZc4UN8NMcjacSPOTcxTwYnXtM+15
	3ieNzGTMk58zrOHHXDOI/tuSf31cwrFUXGPO+C+uWMELKVgZyaWO5jtf/i4gl5Jy
	5nUmwMr52kc0l2aK+XvVWTsJxKfaqUnnqMriJFSq8iXhIpg+bKfGi++11NuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728664289; x=1728750689; bh=aW+bK/QK+vi1gPPOFQCp68KxNYpU
	tHfoG0eVCgS/cE0=; b=BRdKbe513FaW3StRl1SjLSMuEKwnP07ns57PhBLwy1oq
	YeOLn5lFNnUvNzwc04HVZGCoO0d1gNkq034HPc2pHD1dnCcKhexl75C5LwSbxmcK
	1l+WT/HhbT8yH4wuqji44Dlx/esEObVre5QkiPZ0egNpCP76C32hJuA1O0YOjljS
	oR26ODWh00M/Ko3ZvsHv6x+Z85iVlfUsx0MQzv0XZ0XGVZ8YPjmeDulhpBDwh+Bf
	7HSSbwmU6LIl561QykZqpr1KcFLapuq9n/B4wrqRaz72oYUvc5zZT2i5w/V1ClxK
	Qac4cRmRlv5ji8m39Yi4uHYjjy0eQryiLTJgG/UxWw==
X-ME-Sender: <xms:4FIJZ257tSiXPYujpCVaJxkNAW4mECWptmKzS2EHYJ0KFuuzJl0Cnw>
    <xme:4FIJZ_59iNeo4huPASoY5uTEWq7Q8zRZiENFcaNAQuHOz73rCINn8aKenKlxV4Gfk
    FqKZtnlqL_2VW8szw>
X-ME-Received: <xmr:4FIJZ1cx2MeiCuicvuN_x58R18YyoP7r8gBRFIvIDEkXrz8ztFqVMFjp9Z392zT0BPyqU0WdZxWvSXtCypphSMrrygFTgz6eZZRBw-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvg
    hrughinhgrnhguhidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgt
    phhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfi
    gvsgdruggvpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:4FIJZzKYeIar_s5kDAfle0ge8-ZgxPD4EAn6HyOV_mZ02jFUcBhOkA>
    <xmx:4FIJZ6J9cYBtBhI_LbV1V2RYDNSO_nv94xiv0qsfVYUg-UQD7fbZnQ>
    <xmx:4FIJZ0ymcHXLRrxwNz_AbudCsQnMKv0LUZ6cb2OY4OFzpxEyTmyYGA>
    <xmx:4FIJZ-KnDN_klOWCWxr9RFHYStUTcIuGWOgVIRkpBSSpSmY8lpLcIg>
    <xmx:4VIJZ58dYqHmlQHydrTg28JWjGPSof4LiU8sBbFGOauIss1wS6rXWNAn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 12:31:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: "karthik nayak" <karthik.188@gmail.com>,  <git@vger.kernel.org>,
  <phillip.wood@dunelm.org.uk>,  "Taylor Blau" <me@ttaylorr.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  "Johannes Schindelin"
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/6] set-head: better output for --auto
In-Reply-To: <D4SUTJDV0Y04.3Q8YED2MVOKBL@ferdinandy.com> (Bence Ferdinandy's
	message of "Fri, 11 Oct 2024 11:03:30 +0200")
References: <xmqqzfndndfm.fsf@gitster.g>
	<20241010133022.1733542-1-bence@ferdinandy.com>
	<20241010133022.1733542-3-bence@ferdinandy.com>
	<CAOLa=ZSV50OkDC2p5AHHW0u+fAtLMcCX36W1SuT8AnTkX7HNZg@mail.gmail.com>
	<D4SUTJDV0Y04.3Q8YED2MVOKBL@ferdinandy.com>
Date: Fri, 11 Oct 2024 09:31:26 -0700
Message-ID: <xmqqttdiha8x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> Thanks for the very helpful review on the series! Most of it is clear to me and
> I agree with, so for brevity I'll only comment where I have a question/comment.
>
> On Thu Oct 10, 2024 at 23:05, karthik nayak <karthik.188@gmail.com> wrote:
> [snip]
>
>> > diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
>> > index 532035933f..77c12b8709 100755
>> > --- a/t/t5505-remote.sh
>> > +++ b/t/t5505-remote.sh
>> > @@ -429,12 +429,51 @@ test_expect_success 'set-head --auto' '
>> >  	)
>> >  '
>> >
>> > +test_expect_success 'set-head --auto detects creation' '
>> > +	(
>> > +		cd test &&
>> > +		rm .git/refs/remotes/origin/HEAD &&
>>
>> does this work with reftables too?
>
> You got me there, probably not. I'm guessing I should use git update-ref or
> something similar to set these values manually instead of editing the file.

Yup, "git update-ref --no-deref -d refs/remotes/origin/HEAD"

> On the other hand, is there a way to force the tests to run on a reftables
> backend? t/README does not mention anything about this and since in a previous
> round it already came up that I forgot to update the reftables backend, it
> would be nice if I could actually test everything with that as well.

$ git grep GIT_TEST_DEFAULT_REF_FORMAT t/README

Thanks.
