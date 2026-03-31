Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B73DBD4F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993778; cv=none; b=lGHaitDPHMdQuwXVQcUL9P+j4ZzfKfrWKhOXGCzRbfdKpAmsBZXMDfcD+MOyYBrXqn4j78Dg+ON+8eaYR78135kUbY+TUn/0i/K2RPzSFkllSpnAM80rlIGHcgzbIjbKundmO1tkoeyyXUjgbNEa4orJAeOvbW8ltxZ8LI8UyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993778; c=relaxed/simple;
	bh=33ZfHnVRYYVHONa4SFxk/Ir1sFKcCrScTel58lMqPq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vGmlGoGeAZDtec7iU0G0kRMd3VLhRK1bfuYblLWEPzSwG0vkhpJDZoM5N/gFqIvqc8FSObBEjxyI+yX8eGmGHBFQAcjVxc3Zb+HhHpcRu/Xd+miuNMde+0t6LbbQkom6nX/izoySUV7QReanjbs2i/t4ICKzLPzCjhAHbsYEpes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=sZBj6+N3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v9lqvUCG; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="sZBj6+N3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v9lqvUCG"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B0F07A01B9;
	Tue, 31 Mar 2026 17:49:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 31 Mar 2026 17:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774993776; x=1775080176; bh=xgOY3kYwt2
	rIbaQsxKI79dhC/taUHaWr8saV051hPOM=; b=sZBj6+N37MzrDTEZ4XElP+wVyf
	al1kO/+byoFiph2zysxKxz6X3MVyYnezE7blhSpBgXbCPv3qv5INiRm5StBeZd2y
	zcqKisq0CSXvuWMM3HdU963e5TN2o6qVt96NyUPrBDbkZQiIZDwdvpR+KDPbkDkM
	WBDaiSjqye71MbLJzWDNMjKbXPWuflODJKrmwpv8BIou77ua44zgy4Z49YvABCjV
	ykZUKz086qXEcgbnXKYSc0s4ASDYRt54zJPqO286gO+XCBsGCreKR67Dc1m5JXBv
	p7B8q3XRR1pjiLgflOizZ9ZCWRpoAqWjYdENhg/Ee2T6C0NPpiK9aXpi9t4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774993776; x=1775080176; bh=xgOY3kYwt2rIbaQsxKI79dhC/taUHaWr8sa
	V051hPOM=; b=v9lqvUCG1FwGSHiPMxhZpcQaYDoKB6OO1UouMCygRc8oUVgYhfj
	6lr9paJGTUDibqBRqDlo6e41vEPv+yh1v3/ssj5zyKFWVtmTsUJ1eBHY5afrT12b
	sckEmgEZE1ivNbIi/NUox/8k7i+b1AbutKcGYvAzGWkARVmV2KCWh9EiUisxEgTs
	yuWkZdCB/mgqqgB4XtfT+332WMpG/gLE5R1vJ4UOp42SgnD1EGQX3A4nYyagVKS8
	ZwV4a5p2SEph/+6O+6hcHf0LqePjRpxnYDDDlP/H+5hbCB+iG9M+x5jH4q1kBmkr
	TK6y1jxc8epg4uRrMR0nZTDA8sm89rU/FQw==
X-ME-Sender: <xms:cEHMafUUWV0bPJC2E-HdxirJO_vZBhVZVYrAo8EBfGlKEWgPZP0cXQ>
    <xme:cEHMaenKzPLxthM9XUulbXu75UD25GbPD9UQkOjaeRXZEzl06KOLzvmCvGqJv72mt
    tij8Pt5Ubxrs2s1rCwx8r34btAcZqIdaYynOXT3LfYMlWiSxORr>
X-ME-Received: <xmr:cEHMaQbJNeoezesDJSnEgs1ePJ7ltDskgtZjquz-9gm_61RxMancoP5EwpuJBIy4zmU-KbWEsVkhLD85o6566cQP9EiaGgO8eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    mhhonhhtrghlsghosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:cEHMaZMJKmorNzm3TRXY5jgLDjapld7-VseXaLKCEEJPXa3C-9g4Rw>
    <xmx:cEHMaVZbRfN3yzmDvovIwifUv9k4qriPow_1HXQ3sZkGqbytru_Ntw>
    <xmx:cEHMaX11dfoNorYU9RsQNaXEcsXgmaBUGpTvqgDCP1QgbkWg2gz4yA>
    <xmx:cEHMabdnuGgaNs8zP6L1Et730apu4tfj42zYhtCsmpHlD0bLFcSZ-w>
    <xmx:cEHMab4yxj3KrMzO3O_TKsT6jzVNXCH5ap5u_4abRvalqE3TDyGGK0uT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 17:49:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Michael Montalbo <mmontalbo@gmail.com>
Subject: Re: [PATCH v2 0/4] line-log: route -L output through the standard
 diff pipeline
In-Reply-To: <pull.2065.v2.git.1773714095.gitgitgadget@gmail.com> (Michael
	Montalbo via GitGitGadget's message of "Tue, 17 Mar 2026 02:21:31
	+0000")
References: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
	<pull.2065.v2.git.1773714095.gitgitgadget@gmail.com>
Date: Tue, 31 Mar 2026 14:49:34 -0700
Message-ID: <xmqqbjg3y8i9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Known limitations not addressed in this series:
>
>  * line_log_print() still calls show_log() and diff_flush() directly,
>    bypassing log_tree_diff_flush(). The early return in log_tree_commit()
>    (and its associated NEEDSWORK about no_free not being restored) is
>    pre-existing. Restructuring -L to flow through log_tree_diff_flush() is a
>    larger change that would affect separator and header logic; it is left
>    for a follow-up.
>
>  * Non-patch diff formats (--raw, --numstat, --stat, etc.) remain
>    unimplemented for -L.
>
> cc: "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com
>
> Changes since v1:
>
>  * Patch 4/4: fix documentation formatting: use line continuation
>    instead of indentation (Kristoffer Haugsbakk)

The central part of the series (i.e., patch #2) looked quite
sensible.  I haven't read the tests very carefully, though.

I was hoping that we will see another set of eyes or two to help
review this series, but nothing has happend in the past few weeks,
so let's mark the topic for 'next'.

Thanks.
