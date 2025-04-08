Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC6A25291E
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744147285; cv=none; b=rzAAXffA6gqZTWlB2rPDT0M5kC5gcqn8mNPfCq70TpsxXbLo5Na720jBI56z/2gcT9Rt5DKEe2qxxCMj8hmhT7kS1iMLalUfE3BLS55/Tt+xYj7iaJ155S+wr+zqWdN2sa0i1V8lBKzCfIRtwOTEXnFSfh6jULhF2i7g4cXHJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744147285; c=relaxed/simple;
	bh=yc/Al7n8YKgGubg7+g8fwZj1o9qLLY5v16qc5o7H4jU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X2TUiAuwenOuv+xW6DebYwdxAR1JPPr6c8yQ5Ec1wK3uZtlvoyUeubISrQrYcWzcwWK61gaIDfvxMFR/FNLb0PXuBvuKRGENUGfy7wsHC4WU60peXhSY9bhsTfq+cdrlFUxdq3KWxO1siFKTN3VsrFwjWUTiQQFgiMbrjmoP8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=urXOq4LE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QE1jyiRn; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="urXOq4LE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QE1jyiRn"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 006EE254013A;
	Tue,  8 Apr 2025 17:21:21 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Tue, 08 Apr 2025 17:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744147281; x=1744233681; bh=84Tjg/X57v
	koYuGrBu+twg3TieIUm9vnc2EiSI1rChA=; b=urXOq4LEvcu9C5s+HMU8oP9K/m
	TaDhjaSAovFpUGlDdEDj+EmyquzATn/FPeenabFdonVYOQtHeJnk72GwPWztCm4I
	HmrcdbPL/U6WDhDjzKuA438xPB5XaZF4qtsPL+wH7/roZiBs8tOQIZOV/B/WHWIu
	GZ6zgactciFJNlczQFzWAo5khjflBiLzHWyLW7d4PzDtjfXSf1M+tIcYJHISeH3G
	YnzO1PN2PZ63G5G2WgVa6cpWWL4EOWtjycEO2fvrRn0Mls6t8OQVXd5zX7xVLVVT
	ynF6zyM0ozfIC5YaRzP1yS+PmSFjvnnHg4A1MvMztKv2K1xO3B1zAQ5ps+IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744147281; x=1744233681; bh=84Tjg/X57vkoYuGrBu+twg3TieIUm9vnc2E
	iSI1rChA=; b=QE1jyiRnsQdIrZoZU9o+w5P+BO1QpJIkyx27sWs07t5wHo31VqV
	B7VB9OcNNIfpUEOhHKvzcVPN3+FI2XUwyuo0KzzcurqIDs3AAgjSSsKNmRX94zYA
	esNAhhnjTj3Vq6R3+VhpeaZ0FpcilKcTCuEJCzi8Y5RVmDl19fo0A2PmZhonPrOU
	1Jh8oSxDXcF0ASvbUoKDkuMgf7BoxFzsWFTzhupKguGiS1h7yFCKxlvm+bbhP0FC
	F/SkqFpaQTyunRr1EBLR/KtHbZ0Mn9r2gkDbLxGBJZHnWVDwYUFZL0RdoYMkmyuM
	oml2T2wtxbUB3RUPcVGdc2ATdiVDBwede6Q==
X-ME-Sender: <xms:UZP1Zx1oBgIuOIyesSKEB9cDQRfdH-0COsnJWJvGIc6UdNoMPNFKHw>
    <xme:UZP1Z4F-9ga6CS6Vuew5qIOZ2fPhz0Fm7SeP_fjjRjT8ue731_sXC4-m9gxwEMB4h
    uRKYQUNpUlyKfCByQ>
X-ME-Received: <xmr:UZP1Zx4b6OBhFNskXbl59B2GFG7zbUx8K9nKbGmk0YoCso2wgQU-ctvS3X_C4FgJTt4ujK5Bgkco22yC4XLRu6A3YSIHirXkpT0X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdegudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhthhhonh
    ihfigrnhhghedufeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgr
    lhhuohesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuug
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddu
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvg
    gtohdrtghomhdprhgtphhtthhopegrnhhthhhonhihfigrnhhgtdefsehitghlohhuugdr
    tghomh
X-ME-Proxy: <xmx:UZP1Z-3ru5NnqBuoppIt0RwQ8fC2O2kEl1pYfasv6icVLj6OfEo09w>
    <xmx:UZP1Z0Emuv12b2qC91P-Y2Fd8ZZ4q5YOO3IPbCsMNeUwp6L73Dt-WQ>
    <xmx:UZP1Z_9Lc2ldOVMYj_weHS4HTBbW8HBMGyABNTUTzMVKVKfGHL4RSA>
    <xmx:UZP1ZxkHECDNkFX5a8dCiUUXpx7ycS6hEC0m5e32Qxtq26NtI-olaQ>
    <xmx:UZP1Z3GogzEvgVIR7F7Qaepy4Vk28bFl21AQgutyOXJRBaLAdMFVRtEb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Apr 2025 17:21:21 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Anthony Wang <anthonywang513@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  shejialuo@gmail.com,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com,  sunshine@sunshineco.com,  Anthony Wang
 <anthonywang03@icloud.com>
Subject: Re: [GSoC] [PATCH v5 1/1] t9811: Improve test coverage and clarity
In-Reply-To: <20250408114841.58592-2-anthonywang03@icloud.com> (Anthony Wang's
	message of "Tue, 8 Apr 2025 13:48:41 +0200")
References: <20250405103718.25160-1-anthonywang03@icloud.com>
	<20250408114841.58592-1-anthonywang03@icloud.com>
	<20250408114841.58592-2-anthonywang03@icloud.com>
Date: Tue, 08 Apr 2025 14:21:19 -0700
Message-ID: <xmqqbjt6wdrk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anthony Wang <anthonywang513@gmail.com> writes:

> Subject: Re: [GSoC] [PATCH v5 1/1] t9811: Improve test coverage and clarity

"Improve" -> "improve".

I am not sure about "clarity", but I agree that the main thrust of
this change is no longer "avoid hiding exit status of git behind
pipe", but more about "use 'show-ref --verify' to validate the right
thing (meaning: grepping just for a string that could be a substring
is an unreliable test)".  Perhaps that is giving more clarity?
coverage to test negative outcome is "while at it", just like we
(incidentally) lost pipes that used to hide exit status, so I am not
sure if it deserves mention on the commit title.

    t9811: be more precise to check tag creation

    The tests grep tagnames they expect to exist from "git tag"
    output, which can be fooled by false positive if an unexpected
    tag whose name has the expected tagname as its substring.  Fix
    them by using "git show-ref --verify" instead.

    While we are at it, add a negative test to verify that a tag
    that is involved in earlier tests that is not supposed to appear
    in the result does indeed not appear in the resulting
    repository.

    Incidentally, this would also correct the problem the original
    had, which lost the exit status of "git tag" that was placed
    upstream of a pipe.

or something, perhaps?

Also you'd need to sign-off your patch.

Thanks.

> Remove the pipe following the `git tag`, ensuring the exit code is not 
> hidden. Add explicit verification to check for expected and unexpected 
> tags, increasing specificity and future-proofing a portion of the test.
>
> ---
>  t/t9811-git-p4-label-import.sh | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> index 5ac5383fb7..593de09eb4 100755
> --- a/t/t9811-git-p4-label-import.sh
> +++ b/t/t9811-git-p4-label-import.sh
> @@ -95,9 +95,10 @@ test_expect_success 'two labels on the same changelist' '
>  		cd "$git" &&
>  		git p4 sync --import-labels &&
>  
> -		git tag | grep TAG_F1 &&
> -		git tag | grep -q TAG_F1_1 &&
> -		git tag | grep -q TAG_F1_2 &&
> +		git tag &&
> +		git show-ref --verify refs/tags/TAG_F1_1 &&
> +		git show-ref --verify refs/tags/TAG_F1_2 &&
> +		test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&
>  
>  		cd main &&
>  
> @@ -208,7 +209,7 @@ test_expect_success 'use git config to enable import/export of tags' '
>  		git p4 rebase --verbose &&
>  		git p4 submit --verbose &&
>  		git tag &&
> -		git tag | grep TAG_F1_1
> +		git show-ref --verify refs/tags/TAG_F1_1 &&
>  	) &&
>  	(
>  		cd "$cli" &&
