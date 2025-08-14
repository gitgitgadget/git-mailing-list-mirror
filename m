Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5EB26C3AA
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206331; cv=none; b=HOPyFuLqvUH+tqBHqRKOpkqtjyAOW54yAMSHlhuJuUeM0AFmRrwAJJSejkz5OrjDhq1dhmKmd5opQZbS/vFqub3QtkU95srsrod2XHXgxL70ltSxuqTkq++ZFzJj181Oxf4Od2Bl68VDuKJMlizMJ9rzC2yXgOT3lCWT1t3X79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206331; c=relaxed/simple;
	bh=PayPu+foKkrBYeqvKMtKpi/LdoFCZe8LUhp9IE/k5gM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BesBhq68AUtk6yzKB3c9GgAlDOwNxzx04eKnPpXE51ZztwpNiSv79nvpuqET07kIVNXX5MwyL2X5+mz6nsoBHB/eCCdd8a0MJaTMPZ92tpGc5sVi3NvMbLr9eHYSZv01Yw6vQMrJE8ddlNRcAX+Tb/mNinChMnDDkOGH2hWM0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DwBiZizj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gJqQDRsP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DwBiZizj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gJqQDRsP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0326F140022E;
	Thu, 14 Aug 2025 17:18:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 14 Aug 2025 17:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755206327; x=1755292727; bh=a82UYD9/+4
	+uYiwb3M88RzjjetwPmRFJUZTU8lVEVfk=; b=DwBiZizjlAsNKrJue00/I1XWZ4
	jWfhbk+e6kpO2pTcdvfniyvqwKyeY4TvRODBigaRb0NpqZ1k3hjkuuBA8Cw7KdZC
	qEwqODcK9abFQeIJmBInbcXQ1xvpz/qJyBslei3aYm1LhO64XUjAa61JoJS+e4Ax
	dQwOxlJfM2lxHVYMRp/ZNLXwQxyALsxheczU1Ekrt0q11+5KRlFZWVmr2D3kxKjI
	SeXMzTu944SqzeouR2G5+PDPmyB0Ecy1DONW39CvqnTGW7otQLGlgLwIqcXmStEU
	arYrASRus52wDkhGVNWghfYy7ZIGi3AyLk2UlQCD+T8wJy5StQoCNkGIJO5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755206327; x=1755292727; bh=a82UYD9/+4+uYiwb3M88RzjjetwPmRFJUZT
	U8lVEVfk=; b=gJqQDRsPwimT1XGgEz2GTQwYyzGu9FSX25inz91ZjoWbk6HiSKr
	RQwnnDflAc0xBReSMkRuD3JE+xIIVklY9h/Tj32qYJdbllZO0oRIXlhwMSo2HfZ4
	yaS48KDDxiv/rM1ByxPzywKk819m6/lRBS2f31jPiyVm296c90TyIPFSaeinTh7r
	2bnnZmog+o3pv2wWIrOcGBVAygUbFfyT9y6EnUUbcgocNkAecAM2TZJQtjSDPUBE
	Cp+m6kxRtS6Mx9UCkCzVaG3ySi4jYe+j/E88kvz+G30sZ3NHS856OixCLXFVyW5K
	hCT9sP/pB50YfgJ3l1WtKb0MVYKe3ewTm8w==
X-ME-Sender: <xms:t1KeaCjrgbZwdvm-pyn4LuaLLAXvzjDRvNF6VkpCSttOgNN6mxU_Ow>
    <xme:t1KeaIOetQ_hYVDINqVQ8c5qrvRAkYKqJg9LYZ2oH2JLChEUtF-mbcrokEFX1QUOy
    u4WFJdT6MpbFHn3Lg>
X-ME-Received: <xmr:t1KeaK8tOnhD8Ze3Plt9m9HbavUpWyTeMAjBqyYBZ5BYhwVo2CVNmjZwqjWxeDzP31GcTq7G_ZQvCF0CAVzmaPf-CHs6f1JfR_99Mmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehg
    ihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:t1KeaBf-59ef8IEUDatKzSkRd8iAhWDxKM8qLDqNdbWGn1YSDeDwWg>
    <xmx:t1KeaBy6970Ru898XZXgIAd1Hw9OH8jAqyIjh1u_C3-z4JDLJv36uA>
    <xmx:t1KeaOI6ndRPgwrZZVwPPky4Me3bNmt028XRbw9Yuzs_MJwD3TvOsg>
    <xmx:t1KeaLHTvRsETv7jKVVgh7jsXEr_miB0hnwvf_jN2EyNMggDkIHUfQ>
    <xmx:t1KeaM8qCwKGs-2SOMAfw_Mz9KRqQAwJsyBU_UbcGLeVKEX4Aqjzhxzj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Aug 2025 17:18:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: phillip.wood@dunelm.org.uk,  "Julia Evans" <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  "Patrick
 Steinhardt" <ps@pks.im>,  "Karthik Nayak" <karthik.188@gmail.com>
Subject: Re: [PATCH v6 0/5] doc: git-rebase: clarify DESCRIPTION section
In-Reply-To: <aa1c2758-79f9-47f6-87d4-16b19fa5bd63@app.fastmail.com> (Julia
	Evans's message of "Wed, 13 Aug 2025 11:33:11 -0400")
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
	<pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
	<52504ef0-7d4c-4298-af11-10477673e9d0@gmail.com>
	<aa1c2758-79f9-47f6-87d4-16b19fa5bd63@app.fastmail.com>
Date: Thu, 14 Aug 2025 14:18:45 -0700
Message-ID: <xmqq5xepzjnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>> well given they're also both pretty niche. I'd also be very happy to go 
>> with Junio's suggestion to replace steps 1 & 2 with a general 
>> description that does not mention 'git log' at all.
>
> I like the idea of leaving out `--fork-point` and `--root`.
>
> Now that I know the use case for `--reapply-cherry-picks`: what I like about
> leaving in the `git log` description is that I think it makes it easier for
> folks to build a mental model of why a `git rebase` might be slow: there's a
> "fast step" (the `git log` step) and a "slow step" (the `git patch-id` step).

But that is not what goes on, is it?  What you wrote as if they were
two separate steps (1 to enumerate, 2 to filter) is not what happens
in practice.  Whether it is done via the "format-patch --stdout | am"
pipeline in run_am(), or via the "rev-list --reverse | xargs -n1
cherry-pick" pipeline in run_sequencer_rebase(), the upstream of
these conceptual pipelines that enumerates what is to be replayed is
run just once, i.e. there is only one step that "enumerates what is
to be replayed", without a separate filtering step.

In other words, there is no "a fast step followed by a slow step".

Perhaps squashing the first two steps into one and phrasing them as
a single step is sufficient to give a conceptual overview (what you
have in v7 as "a simplified description of what the command does").

 1. Make a list of all commits on your current branch since it
    branched off from `<upstream>` that do not have equivalent
    change in `<upstream>`.

If you want to keep 1 & 2 separate, then rephrase the introductory
sentence to clarify that we are giving a white lie for the sake of
easier understanding, e.g.

    Here is what conceptually happens in "git rebase":

or something.
