Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5900CCA52
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 00:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759018748; cv=none; b=lXXU6esKi3iGOn6w2m9+IqLFAaC7VaitHOMcjuBkDvVfxJ1RzYD7escHs53L+AqQ+TRGfyYoZ5yWxSR3+72k2OubcsNLoF8ORRFsGb//nh/eL97euvpgTHDdF4BhDJqeFi22et5uZGnv+O2cuSJ9Mdf38TptVTXywKU7MoEjDPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759018748; c=relaxed/simple;
	bh=qw2pJ2FJS7BAeIyAjVhC9NsKFusOy2FMLVy6DnuUNJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IclH/OgcBIr27nra75BWn90jLRGzt815v5fJGNJS1c5ccg7IovswkOSadELA558ccftPGQ4D6nLvlYi1dWlLYiKqyPOze9dWLndERx23cpNwQBp1H/Eu9FNkA6CJAHLIK2AqswxGSh9EL+4VjYMh7YB2fBIHypreS6ZUKNY8UBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TbJf4EkI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bLV3KwcW; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TbJf4EkI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bLV3KwcW"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 85D411D00156;
	Sat, 27 Sep 2025 20:19:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 27 Sep 2025 20:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759018745; x=1759105145; bh=+GaKYVRuF6
	ifhdfTQf73ah4nthIZcakQsqGk2KpqKg4=; b=TbJf4EkI+nRw9tdOkADaTa+kM6
	oIjYfAY2P4MTRf/IIinYEZHvL5lJ4K1tnNjAg7SjPo49MQzeVt2olN3J5y9CBIR+
	ODOI7wnDRQFrXPqRenn4yNNQOw5SEKerCeVbD5kTS+XFf0x2Aer8+NzpmXc5T7IJ
	tA4gMpWwZc8khnwAKejkX4XQwPB1LgvO3Mi3hCznuRJ8cZFhilWu8oU4xDPIn8bV
	yrhtMztHqObp4jlDFNQrJW/xCe3T6jEr+lo8N309UikbqlTdVNDOFz/Z7tM7mu0A
	i9q9GGcogdKpRqm9I8JBLZ0NwLn9htUF7DwF/+LSdTOT6VYvCYuTngR8r7cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759018745; x=1759105145; bh=+GaKYVRuF6ifhdfTQf73ah4nthIZcakQsqG
	k2KpqKg4=; b=bLV3KwcWkfczDho1Jf28Rco/Dw1d7XrX6tzTYySdIyyIuSaH8mG
	KOpvmoLg4nVCmehJRKB9HsX6J/vrh2FOrjuY11iRtKwWHBBbuiT7DFHPvXb0k5Pq
	LWvLEWamdvkM4EyoOnmtJqf2a99y1CVhh+Oe4k6FN37JBYk38IcuxwTTiFBfqdml
	fj8/HzVMKF/CmvB87P+4GiOI4pwAo0oTC0qThD5ENqVHQyfVPUNM661gUgrh7ruM
	g9guBUrPGzYsSTJNVzO4LbLoDkKT7hBW25KWPjAqi04U95BeZaNhhimVN6sjPJfD
	xFSiflrh4NkNnETka9B2pTIp2aTp8/YtYyg==
X-ME-Sender: <xms:-X7YaGv6cc0arHMkXuGFhJNxRaMkTTv21RW3YgBqeYY_TxTnWwZobw>
    <xme:-X7YaC65-TY_avbE5gcxggZqMite_koNaIIW-Xe66gzZTHvd12g5mh0TW1G6uCABP
    TgyiWrSdfMKCTitPrZYDMDjBFIJfO9QlYhZSueZQZQ4JcyqDxiz-w>
X-ME-Received: <xmr:-X7YaPI0mZPczSrX9JlZIE6AhswdWgqTxItjVe4-SjYV59TrEt3mY8UitAm1emGjfDa7TygXcxZ2y4PnZ6PB8DVLmx8tUGkzuI0R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejfeeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-X7YaK56rxFoV5OrRI2vJFfkZbcMS5HkyMYqRPdHUItaZABEJI6-Ng>
    <xmx:-X7YaKwLuZZwlAyEzcuStnDrDuIiAGqsScb2HsbyYXv3ySHw7cxyiw>
    <xmx:-X7YaGYBaGLqPJgxwK97rwT-oPoiBtzfe0g7Scu7FDdAqip-KJNrBA>
    <xmx:-X7YaERGZYMjqgqmN7uJys80faJEBCEj_vsE8bhDIvdtkDibSVOqXw>
    <xmx:-X7YaIkzUzIhvbW9eyMo9GuJNu__NxC2VgOcSwzL8ogdNpGSLMNbAr73>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 20:19:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
In-Reply-To: <aNhX9AJ/zq4IYhmW@nand.local> (Taylor Blau's message of "Sat, 27
	Sep 2025 17:32:36 -0400")
References: <xmqqldm0am4b.fsf@gitster.g> <aNhX9AJ/zq4IYhmW@nand.local>
Date: Sat, 27 Sep 2025 17:19:03 -0700
Message-ID: <xmqqseg777k8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>> ... (note that this is based on the assumption
>> that "find any remaining bugs while it is in 'next' before it hits
>> 'master'" philosophy is working, but we have never run experiments
>> to shorten this to say 3 days to see if we see more bugs on 'master'
>> yet).
> ...
> I have a vague recollection that Google internally has their engineers
> run a version of Git that is based on 'next'. But after spending a few
> minutes searching through the list archives, I can't seem to find any
> record of that.

They do, but the frequency they update desktop installations is lower
than the frequency I merge new topics to update the tip of 'next', so
I suspect they alone would not be sufficient guinea pigs.

> Maybe tooling could help with this. But I think that we could also push
> ourselves to be more proactive through policy changes. What if we
> required that (unless the maintainer wants to unilaterally merge a
> topic) that at least one other reviewer must give it a positive "ack"
> before the maintainer starts merging it down?
> ...
> The best that I can come up with is the above (one or more contributors
> must provide a positive "ack" before the maintainer merges a topic, up
> to the maintainer's discretion). I think something like the following
> would be worth trying:
>
> --- 8< ---
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 86ca7f6a78a..789febefff8 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -506,7 +506,10 @@ After the list reached a consensus that it is a good idea to apply the
>  patch, re-send it with "To:" set to the maintainer{current-maintainer}
>  and "cc:" the list{git-ml} for inclusion.  This is especially relevant
>  when the maintainer did not heavily participate in the discussion and
> -instead left the review to trusted others.
> +instead left the review to trusted others.  Patch series must receive
> +a positive "ack" from at least one contributor other than the primary
> +patch series author in order to begin integrating it, subject to the
> +maintainer's discretion.
>
>  Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
>  `Tested-by:` lines as necessary to credit people who helped your
> --- >8 ---

It would lead us into ugly awkwardness when we start clarifying what
exactly "contributor" is in the new sentence, though.  If a person,
whom none of us have ever heard of, sends their first message to
this list saying "Ack", does that count?  If an active developer,
who is known to be sloppier than others, sends an "Ack" to somebody
else's patch that was posted 3 hours before (hence there wouldn't
have sufficient time to think through the issues), how much should
that "Ack" weigh?

Perhaps rephrasing it to "those who have helped in polishing the
patches with their reviews and discussing the issues with the patch
author" to tighten the language a bit may help?

I dunno, as that would still give the "ack right" to a random
noisemaker who threw a drive-by "review" that did not add much value
to the patches, if the original author responded "Thanks" out of
courtesy.

> I am not sure the idea of adding more maintainers is a good one or not.
> Since I am not sure exactly what you are envisioning here, I think there
> are a couple of cases:
>
>  - There is a quorum of maintainers, who are all collectively
>    responsible for building 'jch', 'seen', 'next', and 'master'. Any two
>    of them are required to agree to move a topic down in order to do so,
>    without needing the other maintainer to weigh in.
>
>  - There are sub-system maintainers who are responsible for their own
>    trees, and who send pull requests to the primary maintainer to
>    integrate their trees back into the primary maintainer's.

Git is not large enough to benefit from the latter arrangement.
What I had in mind was the former one.

> The "quorum of maintainers" idea has a couple of drawbacks. Unless one
> maintainer has the special role of being able to unilaterally merge
> topics, each topic would require twice as many maintainers as we
> currently have in order to merge it down ;-). I could also imagine there
> being some coordination overhead between maintainers when shuffling who
> is building the integration branches to make sure that topics don't
> mysteriously get added or dropped when shuffling between maintainers.

True.  It was a strawman to invite other more realistic ideas (like
your "positive ack required"), and was not necessarily designed to
be workable ;-).
