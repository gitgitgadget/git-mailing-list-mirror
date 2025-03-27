Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779E13C8EA
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073293; cv=none; b=YbMl8jMGHGSqhl50qbAwW19GYYr5Zj6AvWdOrU4cO75lNgb61dqYp6WqeRhsTc1V0Rqv3VykgMi82CShIu2CBzZW8m8JKzSDmVb1Tq0Vd0iHdvd16NuUgsJTEv+p6ZCCfFnw3ClVdAUt98smARKogEF6MTk8FexmRYmK2lrIsNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073293; c=relaxed/simple;
	bh=4FcJBBGMEIuMfBUWPWZJoFcVbT8GLb72wQkKGEY4oqw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oNCe5qGsug/PCJ3ByczucZ6n2AD8hnZlyyKdM/9zRQos0B1E+XrkQXt1or+xfSK73p60MhZJ+OKALJ/cHGynUkouYimLdTauKWABtOrJS2Emn8XZZtXDI5hLLFDurqqe4JYqzXyo8koYquGZbRtE6rY4UtzQMqNBj8C8jiTKkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z50xDJLo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oa7DXxwf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z50xDJLo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oa7DXxwf"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 70C3213833B4;
	Thu, 27 Mar 2025 07:01:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 27 Mar 2025 07:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743073290; x=1743159690; bh=28RoUYNfgu
	9ZkBTbpa1l7Y6mqjYSz6gkEX12ATVOGII=; b=Z50xDJLoieWROIwCzhy8pbtzTH
	Ajrsi/eyIvLt3v1bD0UGsMgme3v1kr3zYDmsKrUZC+bw85MwcOQd620Dracwopac
	i85lswZC+3neM+64t+4viQSPBsuizY2ZIiu23TpB89gkJgaFvECAAkASb7pArCJa
	gWKauZDVZS3kptb8KZS31k6LMTInM/FTBeXKlBiNoaewZsDutXbRh/GOZmQwhI6d
	H8Jj0j80Pt4J517XYx+F9nCQtT2QyB6NiiYbOsz27ei9dVH3kiOa7HPYfi8t/s1c
	YsiCI2przMNwoxVMHC2sl3vw7rCFnrlvdoForKWOsc9C0TId+4Rl3QF1muMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743073290; x=1743159690; bh=28RoUYNfgu9ZkBTbpa1l7Y6mqjYSz6gkEX1
	2ATVOGII=; b=oa7DXxwfdbSFTs6/WkoEJaVl7VASn+mjkvFbWmxyHHx9Jk/VsH5
	XHEKjouxVV7atY9pIaIVNNUFaXWi+2vbVNJqguykbC8Oj5fkVw3H3gB9havS9PqI
	eLKZGTFaTHaqX0yBuWIAFPouRTMMBBGqtlI4C3ARyKGL6rAxtEXbit1KE6hVW0zp
	Tux2yR4FSpd4mtSqOJ2knuN4Fq8iiKvhD8t8hxZF+ohFXQ51koxN4t+iAOuhS7kt
	HWUFyPY6F+1CB6vj7K2NwdPcAFZZhuc5tQWZjYzI4wrvdRBhkB/SxIcVR13VYxOM
	WUxB9LWeEIu89f+vn/hZzSUQJyTZmxYmmvA==
X-ME-Sender: <xms:CjDlZ8JMEZRtETwZo62B4aWqyIK0KKSmtgcjfFwOOSQXQR9ILEX-jg>
    <xme:CjDlZ8IWIt26a6-6lbDA_On1HXCqSmGK0hab9BkZtJs2imnAdK7SmwNjyUnQH5pqN
    hGOu2nCYUG7zjgm2g>
X-ME-Received: <xmr:CjDlZ8tULvZu0ym94oO0uL6p5ve5JmJ2WJ1IblsNcrE83n8ZwPYPfYSpp7RyJXrn0n6R7urQsygbMc0qUtJJiGZM_7p5GvhK7dDSqlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CjDlZ5bo7-vd7OdaSGxLQ3tp-8PMiB3Tdew7qUUOBV3hprPtFdM8kA>
    <xmx:CjDlZzaQqLrO68Ru06e3rRU3xJt5JuZI8zW8ww-IvbYOxuJjx7Gg5g>
    <xmx:CjDlZ1CHBDJxP3leldgTI5oHJClUHQuxcOv9tUOWxWt6cMvnVvG8Ow>
    <xmx:CjDlZ5YO3e2xbIrsj3U51klV28ASsxhXYc5mB9lDV8rUwjCGlkLzmQ>
    <xmx:CjDlZyWaLZAtfiYt8FTl1DTfW1nhi9L29S3Ru5y2V7EmOsJXe5aXX4S3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 07:01:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] diff: check range before dereferencing an array
 element
In-Reply-To: <ddfb44ed924615bdb61a30ae7627326942575567.1743010011.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 26 Mar 2025
	17:26:50 +0000")
References: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
	<ddfb44ed924615bdb61a30ae7627326942575567.1743010011.git.gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 04:01:28 -0700
Message-ID: <xmqq8qoqivp3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Before accessing an array element at a given index, we should make sure
> that the index is within the desired bounds, not afterwards, otherwise
> it may not make sense to even access the array element in the first
> place.
>
> Pointed out by CodeQL's `cpp/offset-use-before-range-check` rule.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index c89c15d98e0..18ba3060460 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -892,7 +892,7 @@ static void fill_es_indent_data(struct emitted_diff_symbol *es)
>  
>  	/* skip any \v \f \r at start of indentation */
>  	while (s[off] == '\f' || s[off] == '\v' ||
> -	       (s[off] == '\r' && off < len - 1))
> +	       (off < len - 1 && s[off] == '\r'))
>  		off++;

I suspect that this is another false positive, like Peff pointed out
for [2/2] of these two patches.

Especially if this change squelches the warning.  

If the check against CR for s[off] could be oob without checking how
large 'off' is, then the earlier checks for FF and VT should also be
equally iffy.  After all they are accessing the byte at the same
location.

I think what is going on is that the correctness of the code depends
on s[] having a sentinel (which is not FF/VT/CR; I do not offhand
know if it is NUL terminated or LF at the end of line) so any byte
other than FF/VT/CR that are in the leading part of the line would
cause us to exit the loop safely before going beyond the end of the
array s[].  CR alone is special cased because we want to treat it
like FF/VT only if it is not a part of the EOL CR/LF (hence "is our
CR at one before the end of the line?" check).
