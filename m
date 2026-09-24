Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142037F72F
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790266862; cv=none; b=kXNid5Y3lpvfM3gVfLXP5vv/F4vFfsrI0bh0iygENwbQZcQ2uEIzrv376EYsKtDMYIgnCud/1FoKtEn/71S4YVMmvGoOeOX6RFosLdKS6QU8rUtbg8yBgfjeeWk274ErQKIPzfq64UNGd0SAQHBT+EL8BcI9A+/JrcNV8W/uk9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790266862; c=relaxed/simple;
	bh=0rVp8MQzaCKvufs1Js4xLsu5Ni/m9UmbbslPM5842VM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W4YvAx4+fwXPH/S/5FRBf69/GlygDG/5+vlqj9DKsRkRyPHAjawZ0Y5YayV/7DPKRoDRRIk+sFUZ0SC3WbzBw3k4OuNHKeRZWAs5c8lVs0Kjg8VWo6TBgqMG+vLM5ZUbrMBZWp6Z9xmwFLmoVcrEqPeGeOseTauOPUU8d/w4ioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e5Tabu3T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=opCrv9aR; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e5Tabu3T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="opCrv9aR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F05FFEC0107;
	Thu, 24 Sep 2026 12:20:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 24 Sep 2026 12:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790266859; x=1790353259; bh=xVudXQy2pn
	pWryXWt9geQJTK+nW2x5Q/9O3mUkXgxHA=; b=e5Tabu3TognoL0PGocNfI1/YPf
	oczUc26vLQ1W7vfxpS29mTpy6WbpqWedz52BJcP9VnZGAprc1TVXOtuxWD120GOH
	we/nyijA/0N/cRZ+VsoTq49/Iow+M43rtJK5rYppzqoGIz7ZVCFOVpl9vWAc1OkC
	6w1zDVuzjcd7+pq1cDcvsREeDt/ZHOAQu+Z6sKNwtPabwegk5zKgghOtkxS9u2YW
	HVWBHW/si9itj72li8asG3pOQrSQb5RntWY64UgeL8yv/6YpVaeegrvjQO1QSJrV
	Cni75+aJgxOVQ0g0/3SlfrIHxwk0xBdv6qWesaLraAsZlDVTYzSNUcIZ4vzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790266859; x=1790353259; bh=xVudXQy2pnpWryXWt9geQJTK+nW2x5Q/9O3
	mUkXgxHA=; b=opCrv9aR5mzPlKrfjQgjY51A6Fl8XC+Zd3zkq+1Mpk6AaIqBfPg
	Kb/yZVtgcPq9oZtIr3wY0TMI6r6/qmaIk2BadM896xLisD9LKP5/2CIC16YPJSJg
	V7WQdomurrkY5BvEH0Ef1ZyTcASIebrC99MrxSfCN5CLEvcwa1fh8NSbYE7QugXv
	MhyEU6q99dhnrVv6V89KrtSk0oqL2l5mHxi+yvffqvliQyTq6W9oFEDcAEY4vfgV
	WC/QiFBySq8i2H+DWdekyOW9TFV6djopWOJDx5Hrl6XsqM43bXTRrgQ9rWcuc4sf
	zIOkKqA9uGGXZju8stI6cMX1xBrAXPwAYXw==
X-ME-Sender: <xms:6021aqBqQ_-PHwx87UA9xi-Mc9_mIrFb08jtjQOl_8AxpOVYzrMc0A>
    <xme:6021ar8d0v44O0-iNlw2CESwyi6EBz21KLsSpfJVmZVzaZ-1ziGzPqm2ZWxk63RyN
    054zb4X_K5UtMXwDFhGVbPywCHTx5JWkCNVkQ3jS7uW22xFOPcr7w>
X-ME-Received: <xmr:6021aq9MwojJj2fbvpr-WvC6ZWssG84Swr6YYS4_ef8C3xQNDq6TZRUcCWyem-lN3i0SyFVR9Q2R5iZXYtbELJQWpWj1izd_WFub>
X-ME-Proxy-Cause: dmFkZTFSK773hDUvDILUmcH5bjAe7jAC2cZ9MJHJVJuX9IKzgIaUix46Q04WoYTu3H92LT
    Mo9dwEuPLIlw7sdBj4NBfUc7kQ97tPM2FzQV/1raWn62Wm+lfj6CV0ICKk+e6jpEgquEKw
    k9RtWFY22+zW8gyYDJGtIFB30PcdYu7KyG3JIX6dp/KTO+bjG7CSc/GJYpO7jtLyRUWhy5
    qvjI9NewmkxeVErHU9pzGmg3Z4z5ONN/eN/4f44OGWtdxoyPCME/zODnUj+L9LtA1VWUze
    YM7kUgOXMKvDFhEJ+RUT/HwGL/Eq53iJbQ65igZ+2ChZwoGbwwRCPOKCYulC3HzHLc5FiW
    jtmd5q9XAaIyPcRL/Kyawi/HIuVLCg4cojHjnDenEkibQLAfUkhIIhS+xHoRu/PmuTTdzf
    +Oh6HMEIxj0/3LrNKei5SJVIuq48JGvioZhxJ0OOfAxjMOfStCzbPMacKtiFnNacFFS7zS
    jMqDq4hg3EHwzRtbn1r/z66M6GaAS4+WQPOMbjYB5JF9OXnY6hGZzGZUra8Kpk3kJriI/L
    0pkq2zW98qARYOkPKR8FWsD/gTqzRFJgUmxFRdWh7BXjotM3CnjK5dbgApqACWefZGhkQo
    8lbd899DOXakuDLHpISUxGxVZf3T+HGZO4zHDDC9Ntz8ctoL1MZR791uRp0g
X-ME-Proxy: <xmx:6021aidkvifMGbj9iHVPf-589nSX3jzI8GYACu4XArFmQyzEGHvKBA>
    <xmx:6021ajEqYYpCivyxLXlMp_tcHPyeIBS98aZJD_jd4nJ8ARjDIFuI-w>
    <xmx:6021agd-BKXo-3N4YTJs027Jdq0XcNCjtd6VanRqyRYSjN7jrUmKpQ>
    <xmx:6021atH8avpBDhR7MidUTADQphdUToI6s0FD9ah0Qtxtam02EY7oGw>
    <xmx:6021ar_Mh-5B84Pb1uc7ESXdsesWQGmbIDa-aa5ceeYboeFLNYN3ZLg->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 12:20:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: parovozik <kaliugov@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] doc: remove unnecessary commas in git-add and git-rm
 documentation
In-Reply-To: <20260924074041.1428-1-kaliugov@gmail.com> (parovozik's message
	of "Thu, 24 Sep 2026 11:40:41 +0400")
References: <xmqqo6dn6329.fsf@gitster.g>
	<20260924074041.1428-1-kaliugov@gmail.com>
Date: Thu, 24 Sep 2026 09:20:58 -0700
Message-ID: <xmqqh5je4o45.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

parovozik <kaliugov@gmail.com> writes:

Here at the top of the message before your sign-off can be left
blank for a trivial change like this patch whose motivation is so
obviously good and whose correctness is so clear.

> Signed-off-by: parovozik <kaliugov@gmail.com>

Documentation/SubmittingPatches::[[real-name]]; we prefer to see a
name that is not a "handle".

> ---

For a single-patch topic, here under the three-dash line is where
you describe what improvements were made relative to previous
iteration(s) of your work.

>  Documentation/git-add.adoc | 2 +-
>  Documentation/git-rm.adoc  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 16b06e38e1..3fc2513a2d 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -223,7 +223,7 @@ for `git add --no-all <pathspec>...`, i.e. ignored removed files.
>  
>  `--`::
>  	This option can be used to separate command-line options from
> -	the list of files, (useful when filenames might be mistaken
> +	the list of files (useful when filenames might be mistaken
>  	for command-line options).
>  
>  
> diff --git a/Documentation/git-rm.adoc b/Documentation/git-rm.adoc
> index b5ead86796..67061e961f 100644
> --- a/Documentation/git-rm.adoc
> +++ b/Documentation/git-rm.adoc
> @@ -61,7 +61,7 @@ For more details, see the _<pathspec>_ entry in linkgit:gitglossary[7].
>  
>  `--`::
>  	This option can be used to separate command-line options from
> -	the list of files, (useful when filenames might be mistaken
> +	the list of files (useful when filenames might be mistaken
>  	for command-line options).
>  
>  `--cached`::
