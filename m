Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2CE3191BF
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369290; cv=none; b=Q6qVjgRqPWKrm1/4UccG9PXweASqpkz4t+mdq7WmizKRcFlLEpCP+WJrUON/BGzaW7rxL6h3xh8NxN+HU5Xoq2sk1zCy/srusLjQRKP0K7oG6O65/iwLSOie36xHucb78oDv8NAikaeTvn9H3yHQ6YcVP2Y4W1XppYWVYsQNqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369290; c=relaxed/simple;
	bh=rNvL8TDgFqmHxDMzAeLQfp2h+r0IcH/mKvf0SToyBBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j7xTqQEI6ibWFiDAd7gkbMWIITPZtAEwhIve91t+GlDo5a2Jt1KckiJhmW3GxeKlI/NgwCw1abnnDBFE1L8950MWzxo3IKkXmFmzy50564GM+MLfN/726Q4KmvLTkAh3J2T+R7Wrme8/fs1/mxmkyQkK9FL6k4SEEb1mCkli/FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=grpiOrpe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WE0QnVoZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="grpiOrpe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WE0QnVoZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F699EC0103;
	Mon, 13 Oct 2025 11:28:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 13 Oct 2025 11:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760369287;
	 x=1760455687; bh=O5G5d0Bf0kZ5vRDamZRceGU2/b3h8bJuKEEjUxlske4=; b=
	grpiOrpeH+llee+fXe85P8kLW5w5ExRApVgJwJja/9N6Rt65lTGDYNHZRRoSVQpL
	saurGpZej6flWgrQ22yE+AndSr2QSScg6GjPAFLEwyFxw/yuaIVoN8+nWWpgqKig
	j3tsT5YQJfnMNR6cXy+W/Uhvx0Ntp08KuMstqvpI2IHYj2HddXVE7dgG0Wpc3p++
	vWFbjh/Ozu6yJYRfqJiJNEyk46JfXQimq/o1Ee0Ev+UqMDgRvKMqivGAtXTaApsx
	D2dRz7m2/b3mPmKsKkrtvSZo/aE8fySvD1Gtv8eh8G9AwWTiD+Dja00jjgz4quP/
	Ua3owsrnIFxgvYC/J8cNug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760369287; x=
	1760455687; bh=O5G5d0Bf0kZ5vRDamZRceGU2/b3h8bJuKEEjUxlske4=; b=W
	E0QnVoZ6w851kTIgQ2XPKnw8YVz0UQGZzb/2ADb+p/rskW8r2JgbBr87EtBDIvpa
	j5iofEqTlsoUvaoKkaUmbBGMYRyN/C6SDDuJIhNcDfjfsnJi6sMbYt4N6HlTU5aI
	JEu0wFzEX6FvArziqGw7y5Gf7COKx41SzH2/Szehfw7SQC4QSje+UazA9pANl2dq
	AKKH9zamkiodhtjBm7x4l63GqDlFSI8edk7V7EDT9F6RPrMJ/1AsUAe1hGMgpqT8
	RhVBsWPABe+91rpfN1Kghv44wClmrhi5xQKjAzZYam7X5BffdNrn89yXH0Dyl4BS
	pr265du4GVtEvSleLjAqw==
X-ME-Sender: <xms:hxrtaJ0LXdNfz4W7oc68ESltYwReh6KVHxXtTMBwneuZk5RpEHoFqA>
    <xme:hxrtaHj3miOQsFj5dbDykbhxHK259clSe6lMJxKRhTpCLxQX_JfW_eESzxMnPJ57X
    pAjil29iXZiAoGNIbcAG-Bnff1azFuVSPO3R3EXDYpQXlAHukj4Iw>
X-ME-Received: <xmr:hxrtaHQ2b8pCg7PIITO9gocjIQQYosTFowt9Tg9t8QR6cISoCtbE9bgFCT3-GR5kjmZ_xz913m3XFPw_1GoV7OUUBB7BF5Vmn8np>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduudektdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvjeehudehgeelheefieevtdegleefvdfftdevtdduffeikeeiieej
    vdelhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    hunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:hxrtaAjrANBHZzj5IuaRrySySmgUYNAh4guo-hVsvsvAEOHyr3yzZw>
    <xmx:hxrtaP69TmndSIw-UVO4Ccfw5P21L368mbf8Y4YTUF8n6IGqMquHNw>
    <xmx:hxrtaFCa8gm30uaVctmw5yPfwx__rfZNgkQVYLBQOLHdDtI133cK5w>
    <xmx:hxrtaOadgkJZJthOpF1kbEq33VDnpgr7wYMiS1cKNF-pt2hqUDoBUw>
    <xmx:hxrtaNKfZr7Lva5H3LEPLMB0aVJC4cvCOjEwxRlPPYu8kCi5IU8ZcMf5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Oct 2025 11:28:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2025, #04; Fri, 10)
In-Reply-To: <CAPig+cQOAU3J4qmdtjwRCRkwqpO2FfgDThLt6Yoxdx9T6bhTOA@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 11 Oct 2025 01:23:55 -0400")
References: <xmqqecra71ec.fsf@gitster.g>
	<CAPig+cQOAU3J4qmdtjwRCRkwqpO2FfgDThLt6Yoxdx9T6bhTOA@mail.gmail.com>
Date: Mon, 13 Oct 2025 08:28:05 -0700
Message-ID: <xmqqv7ki3jp6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Oct 10, 2025 at 8:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * ms/doc-worktree-side-by-side (2025-10-10) 2 commits
>>  - doc: git-worktree: Add side by side branch checkout example
>>  - doc: git-worktree: Link to examples
>>
>>  Document "git worktree add" and use of out-of-tree worktrees with
>>  examples.
>>
>>  Will merge to 'next'?
>>  source: <a203b35538847f3c9358a5ae26fb4ebea5734cfc.1759420102.git.msuchanek@suse.de>
>
> I'd prefer that this not be merged to 'next' in its present form since
> I think the first patch either needs significantly more justification
> or ought to be dropped altogether[1], and because the second patch
> still needs a good deal of work[2].
>
> [1]: https://lore.kernel.org/git/CAPig+cQRHp7A=gtSkrVS4_EvZ9PyqBOdGGHcEajfLPE=qU4uDQ@mail.gmail.com/
> [2]: https://lore.kernel.org/git/CAPig+cSNesf0UwS4=Bxe-Qn+G9y3YYPyOK+7y3q8QJk+o7jaVg@mail.gmail.com/

Let me watch from the sidelines how the discussion goes.

Thanks.
