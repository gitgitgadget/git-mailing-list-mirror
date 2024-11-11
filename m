Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00823EC5
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 04:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731299944; cv=none; b=QvhLcKUrxdVzGQo3ysCKCwhC9vp3ZdVRQC3Uq9n+293Rar9o/4toHkvnE7hSHse5sBvxhcY/qsMDIiof70plCEKQPxf93AVT1Y1Rjx77B3R748JZrRGq54Jqx1YJZbD8UId9X0DJKky0G0uFp8ZiWcWSONJPzM5X+mWAraVeU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731299944; c=relaxed/simple;
	bh=i0cR3K+7UO11dcgDb41jM5U7iqWACg5QQAQ/wu78eC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bUjlKjH8xuhjxNH/V2aDTVSgqZt9bUEum3QiOKu3ImOTe5WSpBEosMzhryf2nazBrQnvEUAtUHzq8QROi9/wGKoXrQdHTIEPQuLxL7Y1ICcwPbcupmNL27vEZLfU5RmLIsWLb4ihLSBRcKirSEe5N6oUcSn+i9flJhQJ26acX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WhhDzRwr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UhR2R4qb; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WhhDzRwr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UhR2R4qb"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3202254011F;
	Sun, 10 Nov 2024 23:38:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 10 Nov 2024 23:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1731299939; x=1731386339; bh=zNRSjqtMX2
	oWSbJVzIm4M0rHEV8irVcpua1BHFDESmc=; b=WhhDzRwr5m/xMhG4Bt3mIcj6kI
	BJJsjEUHrLheujqehaKzxJZkXVqHv7NAhAMAu+Xr9L5Zm6Ia32vef3n7YGhPJHUj
	vcYmOLlZZphkUd2SaXEq75f1+8eDnAAhfu/T4Ur6THVql63cm9X7TeW0HDiTMHpX
	njbKgR6PURYrneyclcgDWYy9lgcHb1Y0F1LFYmbVzX8SHadochZjlAc3S86fJ9JT
	+NzoXXIUHnHHnQLW6Paf9YwtGDk/pBrm97tarBjRb+1ZiLAIarw1H6MZ2uAh2aZk
	WB1WlAzH+1oxRELzCcztLxWZuuuz7UPqV+uorUvTmjryps6DlbG+qeLcGmqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731299939; x=1731386339; bh=zNRSjqtMX2oWSbJVzIm4M0rHEV8irVcpua1
	BHFDESmc=; b=UhR2R4qbiI/VDYP+DoIZavrK9s+F6jm/FA+Ex1jok9dNNe/RxyG
	dXEPbKbkpyiRH4+cN9oKE/8cOYDvN1hdjNzRuf+L3KfjLAUE29x6kkb6lG7gWM2/
	EqKIgt5TrZxB6+6Hjob1MX1x/5DFqgVT+BqQGsBD8jJgsDBFtjdnY7TjHzDJ6WrZ
	mXem4jAsnfKmqm9vlgPNSJ0tUsoo76RPRkqDynRbpQRw6/zG3Is2cCGa6otUZRKN
	4rComu7p5yvL8OClfIjJuAHzPHuA7y+JziND22/e+E80Tb8ly2Cx+SDNNrW87JE5
	ukUn4P8kw02WJtzzI1GYSbB68fEkzoul2Qw==
X-ME-Sender: <xms:YooxZ0_Ro1umOfxwFHKh3PCdhLU_NrthCP5dUiIIRlvknC5Zb5dLuQ>
    <xme:YooxZ8s0l_F2Eci_i7TWfiiqCFlbGh8bJH1d7I-MfETyCBmSVkPYQgGmBK9uClUeB
    FMZ0klcwPIiurG1hw>
X-ME-Received: <xmr:YooxZ6A0VGMXiChoKsA0KBIxSwrDd1V0YwfYOeWH2m5CLYk9gFtMJTtqpSSsG5THVi_QV29OWDuVAGRC9fGEyTD5fVfMj1shUwIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddugdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepvghrihgtrdhpvghijhhirghnsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtrghlvhhinhif
    rghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhi
    lhihrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehjlhhtohgs
    lhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:YooxZ0eUhXoUdYM0bi1xx3Oq5SbDk6XcYbytiUmkjodLiuXAv8GDEQ>
    <xmx:YooxZ5Owz61DijQRVGq6T7o4f5Lk9fCJQYS5xYKzUh4yIhqQMUsHRQ>
    <xmx:YooxZ-ncfFxwDC9CfEpJRuKcQ78fRZtr9tpbGNw0AHtwDXg3dok1GQ>
    <xmx:YooxZ7v2DLfC-TCm_68bnmSzp3ewm-P6uauLmqXklGXC_Qx4Re4XaQ>
    <xmx:Y4oxZ8pUVBQuiceeKCvYfrwoEiRhsF-ys7D0sz4LChWFHU30OVfFq_Ze>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 Nov 2024 23:38:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  jonathantanmy@google.com,
  chriscool@tuxfamily.org,  karthik.188@gmail.com,  toon@iotcl.com,
  jltobler@gmail.com
Subject: Re: [PATCH v6 0/6] cat-file: add remote-object-info to batch-command
In-Reply-To: <20241108162441.50736-1-eric.peijian@gmail.com> (Eric Ju's
	message of "Fri, 8 Nov 2024 11:24:35 -0500")
References: <20240628190503.67389-1-eric.peijian@gmail.com>
	<20241108162441.50736-1-eric.peijian@gmail.com>
Date: Mon, 11 Nov 2024 13:38:57 +0900
Message-ID: <xmqq4j4egza6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Ju <eric.peijian@gmail.com> writes:

> This is a continuation of Calvin Wan's (calvinwan@google.com)
> patch series [PATCH v5 0/6] cat-file: add --batch-command remote-object-info command at [1].
>
> Sometimes it is useful to get information about an object without having to download
> it completely. The server logic for retrieving size has already been implemented and merged in
> "a2ba162cda (object-info: support for retrieving object info, 2021-04-20)"[2].
> This patch series implement the client option for it.
>
> This patch series add the `remote-object-info` command to `cat-file --batch-command`.
> This command allows the client to make an object-info command request to a server
> that supports protocol v2. If the server is v2, but does not have
> object-info capability, the entire object is fetched and the
> relevant object info is returned.
>
> A few questions open for discussions please:
>
> 1. In the current implementation, if a user puts `remote-object-info` in protocol v1,
>    `cat-file --batch-command` will die. Which way do we prefer? "error and exit (i.e. die)"
>    or "warn and wait for new command".

In the primary use case envisioned, would it be a program that is
driving the "cat-file --batch-command" process?  Can it sensibly
react to "warn and wait" and throw different commands to achieve
what it wanted to do with the remote-object-info command?

If the answer is "no", die would be more appropriate.

> 2. Right now, only the size is supported. If the batch command format
>    contains objectsize:disk or deltabase, it will die. The question
>    is about objecttype. In the current implementation, it will die too.
>    But dying on objecttype breaks the default format. We have changed the
>    default format to %(objectname) %(objectsize) when remote-object-info is used.
>    Any suggestions on this approach?

Why bend the default format to the shortcoming of the new feature?
What makes it impossible to learn what type of object it is?  If the
limitation that makes it impossible cannot be avoided, would it make
more sense to fall back to the "fetch and locally inspect" just like
"the other side does not know how to do object-info" case?

Another thing you did not list, which is related, is where the
"fetch and locally inspect" fallback fetch the object into.  Would
we use a quarantine mechanism, so that a mere request for remote
object info for an object will not contaminate our local object
store until the next gc realizes that such an object is dangling?

Thanks.
