Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C215ECCC
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764482967; cv=none; b=gqbrttndNlNgKtWjSI5qh837C0ONr/1Qo5TT2r1k6wfgg5mhc2g/6YcE1HXwjGD2DvoVCy9uliIJFR5Hdt/dfwINsbcLJTf4/3hmr9ABd9cWBJzcmM6Nd9xJL89aCrNLXsHJYpBsvhsTswyNRTg/wZyryt3iBQayGYqM7BOM6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764482967; c=relaxed/simple;
	bh=6V6ijolV/GBNfcXb8xL571TnNTEXNWpzUP4qQLrMaCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rRj2y7/Ij8Ed4udClDN6fBwLrlxxhF3HMn9FL1bCtML8ORRf0vlWaKZMPIy1qJEBsnGratCiJ3pbu+9gP7V48+MJsTnplwnGYLv9iiVXMahMc6juFB84CbLCLs0OvhtCxFucB06jm25Hv5r8huUzNO8n9DhEigL4ahGeooCzcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ji6SzYTE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tD4sK2iT; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ji6SzYTE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tD4sK2iT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4546EEC05F4;
	Sun, 30 Nov 2025 01:09:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 30 Nov 2025 01:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1764482964; x=1764569364; bh=d3HG8oDIf/
	bNwBkpJe37acWWFSiSQSqCgHfP/l2pyrU=; b=Ji6SzYTE9cJe52371YlM2Jqmjo
	ubUfT3ZD3iUZC/dGwzPwADRtop6+Zm1l6WisXz09CnyMKShY7r40XyeLk73lzEtV
	Poets9u8jC7GTrETL2DWxuOR89yZ4XQRUw2kEboRsBQua7xvPfmfjwXmxTuL5IPc
	8UJVFIvMy1g7RvSNEXcA5mJgJAu0F2Pi2mSRepLjBAOCZQzjzOus+6CIeOfSytS8
	pzZw5fZfniC6pkxBoq2G7N6luIN3Hwyg6Sk5AHR+JAM5ZWI9gmKoLSZz6ASHtdoe
	NAWo8Q3E4m0lRl/igFL9CoBu11u2lkT9bvK0qv4XC35rbrY5hLipuCf3OdxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764482964; x=1764569364; bh=d3HG8oDIf/bNwBkpJe37acWWFSiSQSqCgHf
	P/l2pyrU=; b=tD4sK2iTLNpkMT25U0pZsWh5eSJZ5bweWFw72iAHe88XSILQRSD
	GSV/7HMmSbi/7qybdaaJlni3u9VoVk+bErXJJBGrSMcKxCaQeLrLTKdB84ZJXafV
	WMYyOJkzqyCYH/zc/5mume8SyX6cSFc7hziOnthoyHiIgqV3V3UeHBY2sSfqpUym
	2pCEEaAIpMVCPJxwkcGmxFKMpqouqP7WCPDvW36ZNh0fYKzngZ86QMsQLcKAAEie
	HCVf4OrRnqxuNrHgodGyM4F7e2Z3OLTqdZPVPhj+N9J4MxrQ2TBX2TICLXk+nH9p
	lO5kRZwHE2d01B9rpDDLVcqGm2TMJeDa5Sw==
X-ME-Sender: <xms:lN8rabS6ARd3bmCe6AZIwUYJBDrH3u_p7DxhP0HJc1fXzvO5eCW_3g>
    <xme:lN8raTz3mPLTeVPlRFzEN8ptNVYRFm1I7MKPRuorJQazlvGcsohYzfP19RTzzJCG9
    abfbzWcdWGsiMv0QCVjw9cCsO6gpWpb2oj1oDJejQG-iyob1HxEsA>
X-ME-Received: <xmr:lN8raV06expjNPsaYOonQm7ZCmBbg4DVta8mUh3EzzK7A_vSkt1Z5BGv75G28SFX3vWumnTkjcXhPZ98aWKU9HBQ5JJA3i5YuZPq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheegtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lN8raZ51w0mPZEIrGvOR2gmx49DjFN_tFH5rauB-NV_owrjDcR1iMw>
    <xmx:lN8raQU-ziJlTAw790_-TkUt1ofhTLZ_f4wQV37p6nqF0TLyut_nCw>
    <xmx:lN8raQA0u-7YOmREn5Sdw7pC7BNFUCDT_ScIwwm4-GAq4suBgdfSRA>
    <xmx:lN8raX43WE7AOO4MmMNF5WP_9bfgnF6vlvaxfylUU-WXfL0NtW1FpA>
    <xmx:lN8rabMQTwHPu9o8n3DaG3lutcYs_wn48QrhSxvYiQjycX6OxGZN5aIp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Nov 2025 01:09:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 05/10] t0301: another fix for Windows compatibility
In-Reply-To: <c59a5f24789cff55819caf92d828256f2291b3ff.1764440906.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Sat, 29 Nov 2025
	18:28:21 +0000")
References: <pull.2009.git.1764440906.gitgitgadget@gmail.com>
	<c59a5f24789cff55819caf92d828256f2291b3ff.1764440906.git.gitgitgadget@gmail.com>
Date: Sat, 29 Nov 2025 22:09:22 -0800
Message-ID: <xmqqikescar1.fsf@gitster.g>
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
> Just like 0fdcfa2f9f5 (t0301: fixes for windows compatibility,
> 2021-09-14) explained, we should not call `mkdir -m<mode>` in the test
> suite because that would fail on Windows (because Windows has a much
> more powerful permission system that cannot be mapped into the simpler
> user/group/other read/write/execute model).

But in this case, we are emulating "mkdir -m 700" that is expressed
in a very simpler world view of ugo=rwx with a much more powerful
permission system, isn't it?  If something is more powerful, it
should be easy/possible to emulate a simpler system, I would naively
think.

In any case, a more productive than rethinking the "can we express
what mkdir -m <mode>, which is a construct in a simpler world, wants
to do in terms of a much more powerful permission system?" would be
to see if the test linter can be taught about this particular rule.

It is easy to forget that there is a platform we care about whose
testing environment that emulates POSIX does not like "mkdir -m
700", and it is a bit too much to burden developers to remember.

> There was one forgotten instance of this which was hidden by a `SYMLINK`
> prerequisite. Currently, this prevents this test case from being
> executed on Windows, but with the upcoming support for symbolic links,
> it would become a problem.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t0301-credential-cache.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
> index dc30289f75..6f7cfd9e33 100755
> --- a/t/t0301-credential-cache.sh
> +++ b/t/t0301-credential-cache.sh
> @@ -123,7 +123,8 @@ test_expect_success SYMLINKS 'use user socket if user directory is a symlink to
>  		rmdir \"\$HOME/dir/\" &&
>  		rm \"\$HOME/.git-credential-cache\"
>  	" &&
> -	mkdir -p -m 700 "$HOME/dir/" &&
> +	mkdir -p "$HOME/dir/" &&
> +	chmod 700 "$HOME/dir/" &&

That "mkdir -p -m 700" is a no-no while "mkdir -p" followed by
"chmod 700" is OK is a bit puzzling, but I assume $HOME does exist
in the testing envioronment, so this new sequence should be
equivalent in the simpler permission system.  If it works fine on
Windows, that is great.

>  	ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
>  	check approve cache <<-\EOF &&
>  	protocol=https
