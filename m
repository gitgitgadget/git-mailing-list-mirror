Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBBD2030A
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768868120; cv=none; b=QEYK06NvW9HqfeQieorQj0BZYRxWkpuDrjebOCvkos32xjbBwCoczrA7vkEb8wXm10S6C2v5/wcWf8vZULXEoZuEP/9SOUOTcpGJ5AdedKGOtxqvIHkesbG4uh/ImOwUFryxGcB68nCkptc8r39a0/C0IdB0v2YS41JpWda9pS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768868120; c=relaxed/simple;
	bh=Av6at9rvhxGYowE8+3it5DSoCXB229odH6d0/mv8prM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ccMTAGX1eB82BoIJj/xurEqpqzxvhO5k1891bYAtGlplyjbXMVfeixtzvsFKCnjnpDJJfedXFRy0Q8n2p0Hr4+34QaMjbf9oe7gne8/or+Q4yse7plelZFI3E2WwqX6ub2gPyEABl7uxztScljoY9X58hHawKMqStfHXJ/dyD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wk4QfIbb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ekqZUiD7; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wk4QfIbb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ekqZUiD7"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 70F5B1D004E8;
	Mon, 19 Jan 2026 19:15:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 19 Jan 2026 19:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768868117; x=1768954517; bh=YNdi1cVRYG
	/nL7cixkFIBusia7xuPkY5dR5+jehHl+Y=; b=Wk4QfIbbiBOOAST9wHr39wQ0vW
	Pxe56398xm00X3nvJwamN5GSUH0H0Xc7e5mx9no+NmAzlzl9d+UQHFdIuqz4YJ4y
	DYCQosEibHMwjyZPEHeS1nbv65YVqkXi/DVz+oix3BOsmp2hgko4Q+9YuIc+oJz9
	uF5OIWKw1WAC6IvP0vcwE7iQT95XBFvl2obxXWafd0oT6LkXBNuw7XikU7CAn//+
	mltc0l/wyE2COWq9BjYg+WTVQGb1sbtweyNZuphHN+fgDOWOLUl2SgvxAZvnK+t5
	WfcGgykFxwcz+HZRNzhgQXfHa1wruxLOmvj8VtusBT9b2ehtxl8d1cOtKmQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768868117; x=1768954517; bh=YNdi1cVRYG/nL7cixkFIBusia7xuPkY5dR5
	+jehHl+Y=; b=ekqZUiD7EpNlz9WW5KXijHxhKHgsGc3hz7Tbk33j04bwFL+jG/F
	Hv0YxSoCdD0FdiwnxmkpDSNBqza6REWb0dm1MzIzw2Xqv2znk16p0mZQ8TsGDVhx
	ymFMnn/i1aNMBRQM8YIVndnsfqMvwwVQP8kTth/DV1sKBI+tI7oi/tBEkbC/NcuH
	S2ZpsAlXi6ezq1+f6ozOdbjIf068Tw21JgEfXNzrvnUdEY9q7q2WgksPbsD/mO6A
	PzbfXZ3pjA8uokWZB6nM3Wdp/vJzAqoKwH9Iv/XNVKImptwq1X0n/VD1dXZ96NC0
	TEGnY88Wt2zLUETvrppt6IMvEKmHF8BXfgw==
X-ME-Sender: <xms:FMluaZVUrHkWH3I5FGnexaBgl-LcKNfVzALu5Xn1Hb5XNegCwjXOmg>
    <xme:FMluaQfI5uwYKSqD5_L7bXvI9NxUwR7JtZrpe6Ggv73OXHRaKR6d5eTElrOcyZqfc
    A1O9I3C-xBvBNWYyu6dFqBi1voNvk2zLJJYc3VH_-QH-b2NIFycJw>
X-ME-Received: <xmr:FMluadsHgFFz1SW-u0yOh3_dEzs1pCB7paaJH7PmT19XMG4k_i3-NDLwA6SCUvep-71Efdl6kSboaEFVJpxEmsWlqYCebXC_LTty3xs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopeifohhrlh
    guhhgvlhhlohdrnhgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepiihhihihohhurdhjgiesrghlihgsrg
    gsrgdqihhntgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:FMluaX9EF2jknbc62zyxIk139fpUApK_i8hyVq7X97jNYiJj_CW50w>
    <xmx:FMluaQ0BnLWL_w2jeLZ34QPCDCorfruiaVLanDQ32GLrVE1ZQQoFKg>
    <xmx:FMluaUB6Vr4Qom3E9qqhXIQmwJwjPkhUdnAigdvfTCfD3gWXaj4txQ>
    <xmx:FMluaUfV4EVU_8Yp9tMSK0GEAJKtLsqAQ73ejup1Cr-MjRNlJBYONw>
    <xmx:FcluaQYB1SqjLYYpT6Fs_3uqA_3tAmRNUmapKoA531qbLxnoQ4EaBddi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 19:15:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <worldhello.net@gmail.com>,  Git List <git@vger.kernel.org>,
  Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] help: report on whether or not gettext is enabled
In-Reply-To: <aW3XUxaomqGbtpEj@pks.im> (Patrick Steinhardt's message of "Mon,
	19 Jan 2026 08:03:47 +0100")
References: <f3500e698fd40297d2e2634785529b76d49ca470.1768530514.git.zhiyou.jx@alibaba-inc.com>
	<xmqqo6mta7bg.fsf@gitster.g> <aW3XUxaomqGbtpEj@pks.im>
Date: Mon, 19 Jan 2026 16:15:14 -0800
Message-ID: <xmqqsec13zsd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Combined with the vintage of Git binary that had these help text,
>> the fact that an "enabled" line is missing is enough clue to
>> diagnose.
>> ...
>
> One reason why I personally prefer to have enabled/disabled is that it
> allows you to discern the following two cases:
>
>   - You have a modern version of Git that doesn't have gettext.
>
>   - You have an old version of Git that doesn't know to print
>     information about whether or not gettext is enabled.

When you see no "gettext:" line in the report, you can tell between
the above two cases by looking at what the first entry in the same
report "git version --build-options" produced, which is the Git
version, can't you?


