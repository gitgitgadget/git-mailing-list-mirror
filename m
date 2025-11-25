Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C9D1487E9
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 16:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088953; cv=none; b=QujgCZbzXe9wm5Ohi84KbAY+cOAVohz4HiW3W/gfOOMa9+5+0BOqurEtNXP5JUuyed1OqBSqU/kBzKLFiuPZ9IZaPhjBLwnhnVbmwZjhgVC4EmLXJvO7VdJvpbsSI8XKmHhrL+JTxpd6DrNNewELzGjMuhZWg0sdS3zpRVtudgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088953; c=relaxed/simple;
	bh=LAWkjB0wtqcObXB6+NyAJOJPz8uzoZasUhNDtFLQVQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VeflKeZTV6xatHo+03IUA1itcbvLrn/5y3Ek4s/G6vCbPviiPuirf6VYrycQzHXNKxvDmppD0DszjSgJF6TBcq3ipuW9v0b+tkRMwd3MYghjeKgw6IhpFW4JsvytakTEDymQc1z2jlKB+QlKQlkoaeaUdNRISv2QDedXln8dXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eyTwKOaa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wmJeBq0E; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eyTwKOaa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wmJeBq0E"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BCCE37A00B3;
	Tue, 25 Nov 2025 11:42:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 25 Nov 2025 11:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764088949; x=1764175349; bh=XHTjE7V8My
	iqTIO9xQ2TGWuUnDFLi5Ylhi/xlLyB9bY=; b=eyTwKOaa/gkFHHvt6FBp5p7yLq
	+ynjxCjM1rkUWCOVXOondx1FRvDOrPU/uSQ5vggfWDPWycFxkz/NqS//DmyyBi5D
	tS6XFs0hkvuCt9Wjq+tA3UEuV8ODOoRy0Cdlw9CsxTa+MOmiYAncJErgFFChGJ9x
	dbO3J4PFCgGDAUxOzjmR3LwWoR1f2dcaQJS4Y4CVMPS7X82LAM6yOn8inx+5ZW5n
	1cxl+IK61OWwry10x4DLDEudZmhjMO11giz3xoJOwtCrNZHgr1LL0cTtgJXRd2Fv
	89P091me7f0hMDCCc8y3CaCWuhRXqy61en93Y7Et0IxJFHQrryUVVDP3sgxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764088949; x=1764175349; bh=XHTjE7V8MyiqTIO9xQ2TGWuUnDFLi5Ylhi/
	xlLyB9bY=; b=wmJeBq0EVq06i2cDegSGr4o2FlyCAKFslb79sESmLbf2T3r1ARz
	CYgGmImGtYA67dnHoLEE/duVuSAENHxNAxOUkDthElY6bG9mMlah1Yy+FLijWR9A
	Ispkpg2W9OSr4zkIFXQWPfW1gCRgwMb/W94OQPUBpRh5AUiVX1ZJTpGueiDw8TVe
	/5fASOwEx8HUvyiB3VqqGICRQZXafB6N9ZF5CT3tRh3995z3riy8/vem923tPB23
	SUPhV/azkfrV29Q/F2Ug6K9/PZ0W4m1CoZDLO/b+FjIraf3gVsYfZ6pDQOQ9iNKT
	O7wKR0pSPMMym83SsSTc8ZTI1ic3sURdrIw==
X-ME-Sender: <xms:ddwlaS18t6mZVQPKUuPASbfYkirbAp0fDT0dMwPi2UpS_k28zAvTuQ>
    <xme:ddwlacENW__aS5sSqeywTe3K_TSbd8pN2LfoViwIWMSnr8XDBNJTTKu2VI2qP2hDt
    Ja5oG5vZlND15ZXBz5LyTjSDhyWm0rZaNkKY5sWbJU1P2cKXjo>
X-ME-Received: <xmr:ddwlaf5O9gEOUdcp6aWoa-jof3yy9Au9KjnTxq5McazLUCVQrMG3T9JhgfeDz0h_Rg_uN2tXwrM9zi3qQvyY8f3-uQE__EsknpAS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgeduleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhifihhkthhorhdtvdefsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ddwlaSvkHxDASjVOWvzbaWl7_XIMkNzjCPZTcpyEckgnvd-23PABqg>
    <xmx:ddwlaQ7-d9NQnDN65mAAcEkds-UyZ3GjTfibtxzeDrOsO4eXqT6ixA>
    <xmx:ddwladUN1n9Lo1bc8enxT80fIoFahzpA6kz9z-eGQ4oQMBQWaBowvg>
    <xmx:ddwlaS9V2Ly1BCQeirqapQRTW-H4RcRkJjNrN4lIY3yE7k9oKjlYGw>
    <xmx:ddwlabbeNCgJJ13w_5y5Dx5QiSFURCREaH3ixDCcO6ffXObZP3c0bfVA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 11:42:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wiktor Mis via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Wiktor Mis <mwiktor023@gmail.com>
Subject: Re: [PATCH] Add completion for short options
In-Reply-To: <pull.2100.git.git.1764052739534.gitgitgadget@gmail.com> (Wiktor
	Mis via GitGitGadget's message of "Tue, 25 Nov 2025 06:38:59 +0000")
References: <pull.2100.git.git.1764052739534.gitgitgadget@gmail.com>
Date: Tue, 25 Nov 2025 08:42:27 -0800
Message-ID: <xmqq5xayt66k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Wiktor Mis via GitGitGadget" <gitgitgadget@gmail.com> writes:

As the large part of the completion script is about completing git
subcommands and options to these subcommands, it seems that nobody
noticed the lack of completion for options of "git" itself.

> Subject: Re: [PATCH] Add completion for short options

This title makes it appear much broader than what the patch does,
which is to complete "git -<TAB>" with short options for the "git"
potty.

    Subjct: [PATCH] completion: complete "git -<TAB>" with short options

perhaps.

> From: Wiktor Mis <mwiktor023@gmail.com>
>
> Git provided completion for long options but not the short ones

Complete the sentence with something like

    ... not the short ones for "git" itself.

> Signed-off-by: Wiktor Mis <mwiktor023@gmail.com>
> ---
>     Add completion for short options
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2100%2FWiktorro%2Fpatch-3-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2100/Wiktorro/patch-3-v1
> Pull-Request: https://github.com/git/git/pull/2100
>
>  contrib/completion/git-completion.bash | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 73abea31b4..3f1d6c0955 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -3916,6 +3916,16 @@ __git_main ()
>  			--help
>  			"
>  			;;
> +		-*)
> +			__gitcomp "
> +			-C
> +			-P
> +			-c
> +			-h
> +			-p
> +			-v
> +			"
> +			;;

When you type

    $ git -<TAB>

the current completion without this patch does nothing.  The above
change makes it instead show the listed six.

Which is a good enough incremental update, I guess.

I however wonder if a separate follow-up change to let

    $ git -<TAB>

to show completion for both short and long options make the world
even a better place.  With the current completion, even with this
patch, you need to type double-dash-and-TAB to ask for list of long
options.

Thanks, will queue.
