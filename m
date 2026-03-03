Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79FA20299B
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502508; cv=none; b=ONdaGlJXb2yla5tJO/+wCQqyZYZeSEoCoyDg+MTpyhdcWX5QsmOhhtzT7wBKpUuFX0CWFaxwTx6wTaS62JVwaOWtE4O42SZuuHbqEeXkVOGqm7DahnsU4GR3MCzQUhy68OAxX+NVMG0bqoNwSJRsUt8N6ErKoS5VeFRzszaw0Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502508; c=relaxed/simple;
	bh=XCpUjHodxQ7H4EbML+L6VgKOPaIkPjtoWZMPemHMblo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q6r3YHoTAlJSbEE/p2IvIpqembIiHWxNQekKrEPCQ/jZbRj79wGcbWBkLflggf8RklSfw6Afni27cvW0nkOUgNdJTYzl7P9RgZwKrbB2QH5Q2fIk+gq4OCrDpfvxqimBI7f6WCM63lEj/7DpX7I/8lc6sqmUU/Vdl6k9MLquEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VGlEUsxV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kqJu3Scg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VGlEUsxV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kqJu3Scg"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EF6BBEC05BB;
	Mon,  2 Mar 2026 20:48:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 02 Mar 2026 20:48:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772502505; x=1772588905; bh=eLtrXdUkj9
	TgqB0bzSUnHY9pYvcc7w23/SaWJ0NRoTc=; b=VGlEUsxVhFKpSGq1U02TOWT0of
	78pgQCZxF7qfOqFsxns0TuWidmNIjJrtZhR2TSC08PETxFYN3W4BrgaQa2cAefTV
	uRts6qTEVU+nMOC8ImjgpN204LZ14a29fKTyt8JQgxjAu5GFHqW2zG7vPNoasUvc
	fcCjxXMl3ia9gEQXi6IQYnuZWGs/mI/kLwAKHSk00KLYdgpc5SON5SG1zz21I6Hm
	3JwIeRYkCOqlS7mE3JESUyj9nvVt+sHM7VKZN2xFAoE/5nKfN2mUicTaaNVInffK
	f0XRjNMT9Yu1Hl4QM2syvyOIvv2RDuyYjrqBr7PcD9elkHz5EbV/goRYu5/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772502505; x=1772588905; bh=eLtrXdUkj9TgqB0bzSUnHY9pYvcc7w23/Sa
	WJ0NRoTc=; b=kqJu3ScgjaigPzzvRzJk2Tsu659P5x+nhqC19AsRlmP6ye5gj9V
	0h3iV/u9LePaustUktH2HToPjiIfZNaJtd7VYfMlaHNPswcXIYRZxA74mtKG28tk
	BneauHLvBmvcBDDfaSWsyMvGX/VAXL+WFA/YZmO/+bWlCe4cAi6cNWa39Kudl0Bh
	xreNoOuHWvFCnWECBw5Gvyr8uxxtmGUNgYu9WryUKNvQvn+HXrU1kApXB2AwE+nq
	AnYUAHLkSdVKtp4k0DWFwZXXYrN5tmYT57J7xQUUs23ydZs7pqSd7mkzXn8VJxyX
	NPTWzC3DftPcxl99pGlt6wNalA1qBLZ+yLw==
X-ME-Sender: <xms:6T2mae3O0i0mJNzsFyf5THMpHQ8yYG6kS07xfAB-GEFjsgy3auI1kg>
    <xme:6T2maYgA-eIXhcv4jFRt6dwqf-pC23dRHVThZSS5C2tGpzN0bAiq4Qr8mSMAQTBdc
    CN4ptT-kE8bUyMZDookklvsyWj7xn0nsae0zgRFMz0PcaCewRSzHEY>
X-ME-Received: <xmr:6T2maURyXfx-4v6YlZPXrT1hikcLsLEynfMtNJ8AjpEUWnC-l2EHWiA-rvaDQraf-b1DWz9YfFTRE5LKludHFW4MY6tJ3PWJnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheelvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhorhgvnhiiohdrphgvghhorhgrrhhivddttddvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6T2maZhC7Z-063K62tasSu-dGxZfBWUhKmOS2L8LRQ8YD9WEuSoKmQ>
    <xmx:6T2maU5mW-CidQblQlyQHSYSmXwTuXa0525Leoth0BKpRyQqUDNFNw>
    <xmx:6T2maWAkTqNYqyzRl4jI-ZmDbOgV76Et0YZ178b2bEBHJJuHSuO0_g>
    <xmx:6T2mabbGRvMn8IFSUTWVZom1cZYWevp20uwd-sBNz-p7fqq1st6S1g>
    <xmx:6T2maciksWD_noXsWnnrT_bGgK64AnZXPazozKB8-q4qQMC0L8jMxGFl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 20:48:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 3/3] doc: gitprotocol-pack: normalize inline code
 formatting
In-Reply-To: <aaY4tQzdEGE0hfvB@lorenzo-VM> (Lorenzo Pegorari's message of
	"Tue, 3 Mar 2026 02:26:13 +0100")
References: <cover.1772467050.git.lorenzo.pegorari2002@gmail.com>
	<e0e4ea3d22d11d8d6b6e721228f1420cb8dfa612.1772467050.git.lorenzo.pegorari2002@gmail.com>
	<xmqqms0px2de.fsf@gitster.g> <aaY4tQzdEGE0hfvB@lorenzo-VM>
Date: Mon, 02 Mar 2026 17:48:23 -0800
Message-ID: <xmqqv7fdvg2g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com> writes:

>> > -Initiating the upload-pack or receive-pack processes over SSH is
>> > +Initiating the 'upload-pack' or 'receive-pack' processes over SSH is
>> 
>> These are not `backquoted` for <tt>teletype text</tt> typesetting,
>> like the other hunks in this patch do?
>> 
>> All other things in these three patches I found them reasonable,
>> except for this hunk.
>> 
>> Thanks.
>
> Thank you so much for catching all my mistakes Junio.
>
> I misread the existing formatting: I mistook the apostrophes for
> backticks, and so I incorrectly assumed that the document used inline
> code for command and process names. In reality, the rest of the document
> uses italics for these elements.
>
> I'm sending a v2 where I correctly uniform command and process names to
> use the italic style ASAP.

Sorry but I am confused.  

I am not sure we want <em>emphasis</em> for most of these things;
when we spell names of commands that users would type literally, in
which case we would do the <tt>monospaced</tt>, no?

I may be way off, though.  I'd appreciate our Doc experts to inject
a bit of sanity.

Thanks.





