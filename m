Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E135218FDD2
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728930; cv=none; b=rmR9GKm4sIAHokOpYE6ZiaFlkHyEXMqE2ScC+UHQ0L68HgidxAS0eSnsXnkSoIpTJfsbY1Rxd+53Gifo3HpwVQYCFAH7hlfR2WWYzOYXIy8LqEkDEfUWD5PKvZ/XV1Tkkk7Yfxew/MN+adW90lmtyCuI8ETPnDy7xtykSrnBqQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728930; c=relaxed/simple;
	bh=fYSbVrmp6hBQA8fW3PwnbcI7HhV7O02+bPcCR0qESu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rxyrQe3CIl3WDgNNUQM4XzCc4zpJ8eojmIExs+yMvcG+OjdwQKjC62X0Im3/0okit61KQgNq1Te5gUMFLGL4KFlkWs/m4H4Wt5SFeJ6/jz07CKo/oH1wMHVdzWAxyKL535vK3e81XMnfP5wnq2RMCB9fQ3ziIHGbnxnV1IF8hXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KRoQTsCF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cpVVxAQ6; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KRoQTsCF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cpVVxAQ6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B24A1254012B;
	Tue, 15 Apr 2025 10:55:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 10:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744728925; x=1744815325; bh=uXdZvXEw+E
	KG2EzuXFmnJ4ohvm34KDJhB0jhOtgkCfA=; b=KRoQTsCFBJlkTokOmAf4vhPUn+
	ej3Tpy7to2FmMbPbhdEL7PE7MzSviTnLBy3MFuByFIp4N/KeO+k84xNDTTkEm7Z+
	Fz+vftnfhAg4JXRah9LnfWejudD0UjhaN9Sjq7+JJQGzX7hfyy31PVPBrtI83lcE
	3PbsPrgt5u6P2+pt77C4kwF45AanrGGglyN3rUYSkSiw4Qi5zYWwfdUwjWVGZs4Q
	+Ylh5BmPrJGyQsGDU7uWtRlyN/8u7TOX4+YdTDCDxnDyKaWUb9lOkjaKqYwWt5wb
	aNd8+siTzpk/TpKG791yAIKkYOmhVNoxG8Zf1LpHUmxT6VPhizmlsLfiR5DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744728925; x=1744815325; bh=uXdZvXEw+EKG2EzuXFmnJ4ohvm34KDJhB0j
	hOtgkCfA=; b=cpVVxAQ6N6uFhsV+JbdQ1vaEjSFIv+i/0DActZcvIu6uedOTFz+
	Ghh5MTYsXDecbOXxLIJ4v+/cfAqd8AUwmYlKbjRMGgMfYUxNpFqiU/ehgdvIU65L
	+BXrljjW/rqK72e3Ly/6N/ZXosUVxSeXp9j2v9MAcEWZigGYYNL7Z1G90t6Wbsqd
	FH95kg/iCx5Hg44F54Ng4xU+FpMSlXaMEwyIPHE7Rp/vlxca4LZGg6RE3QrVSaMN
	/2NwhvIKhb7FY6IJx5c4aZSF5n8o2Tb5Thv+EeHnC6hWtSGsQ9yLfufDzaxSYMcj
	UGqmoHYjOXtEtPAOKawI1dO17CPeOFPRR4g==
X-ME-Sender: <xms:XXP-Z0V6W8HVEkW4hOAsuHYDLTDNUg2A75cdC28AjAv-dnaCCTuclA>
    <xme:XXP-Z4kpX1myKYWwFE0K4fafQqlg2l8vyYvYzhuJemj9AUuqHIvrCi-oaOH-qPE16
    kd9bnSVq2H6zSaDJg>
X-ME-Received: <xmr:XXP-Z4Ydgpz09vAVF1PZNvbCMUOjUlScC7rNyaJH16ZGbkLBP6iTrGbSvwm95AyuVeY1-V43XGh_1OkD0Y1U0IRuDxZWoOX5feCR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefjeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:XXP-ZzViWDoB23cHbRrdgdn0vqSROMMeFS2Aj6LhNCpZ_jZRtZh1Mg>
    <xmx:XXP-Z-ky_fp-pliFFC08BKZ5FhmlyTXMUATo_RHcB3RU1bbaGR-0kw>
    <xmx:XXP-Z4efPtdd66RvOXYMOho1bqDe88n-RgKHt7EJzpbmMmg-Nwbziw>
    <xmx:XXP-ZwHIDn42OH6mDi0yaLZRWeEfKkJFt6PdINfcfPu2Hy-DsvBW4w>
    <xmx:XXP-ZxmLEt6COfRav094F8eHQwbRBDtF-9FEEUpqLfVOtojoeWgGsnVn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 10:55:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Anthony Wang <anthonywang513@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  shejialuo@gmail.com,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com,  sunshine@sunshineco.com,  Anthony Wang
 <anthonywang03@icloud.com>
Subject: Re: [GSoC] [PATCH v6 1/1] t9811: be more precise to check importing
 of tags
In-Reply-To: <20250412061957.81747-2-anthonywang03@icloud.com> (Anthony Wang's
	message of "Sat, 12 Apr 2025 08:19:57 +0200")
References: <20250405103718.25160-1-anthonywang03@icloud.com>
	<20250412061957.81747-1-anthonywang03@icloud.com>
	<20250412061957.81747-2-anthonywang03@icloud.com>
Date: Tue, 15 Apr 2025 07:55:23 -0700
Message-ID: <xmqqjz7lo4o4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Anthony Wang <anthonywang513@gmail.com> writes:

> The tests use grep to search the output of `git tag` for tagnames they 
> expect to exist, which can incorrectly pass if an unxpected tag
> has the expected tag as its substring. We fix this by using `git 
> show-ref --verify` instead.
>
> Additionally, we add a negative test to verify that a possible
> uninteded tag does not show up in the imported repository.
>
> This change also fixes the original problem, where piping the
> output of `git tag` caused the exit codes to be lost.

The word "original" is misleading; perhaps phase it as "additional"
instead?

That is because not allowing to notice potential breakage by hiding
the exit status behind pipes is just as bad as falsely taking a
partial tagname match as success, and there is no reason to call one
"original" problem, implying the other problem(s) are different.

Other than that, looks excellent.

Thanks.


> Signed-off-by: Anthony Wang <anthonywang513@gmail.com>
> ---
>  t/t9811-git-p4-label-import.sh | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
> index 5ac5383fb7..39856629c0 100755
> --- a/t/t9811-git-p4-label-import.sh
> +++ b/t/t9811-git-p4-label-import.sh
> @@ -95,9 +95,9 @@ test_expect_success 'two labels on the same changelist' '
>  		cd "$git" &&
>  		git p4 sync --import-labels &&
>  
> -		git tag | grep TAG_F1 &&
> -		git tag | grep -q TAG_F1_1 &&
> -		git tag | grep -q TAG_F1_2 &&
> +		git show-ref --verify refs/tags/TAG_F1_1 &&
> +		git show-ref --verify refs/tags/TAG_F1_2 &&
> +		test_must_fail git show-ref --verify refs/tags/TAG_F1_ONLY &&
>  
>  		cd main &&
>  
> @@ -207,8 +207,7 @@ test_expect_success 'use git config to enable import/export of tags' '
>  		git tag CFG_A_GIT_TAG &&
>  		git p4 rebase --verbose &&
>  		git p4 submit --verbose &&
> -		git tag &&
> -		git tag | grep TAG_F1_1
> +		git show-ref --verify refs/tags/TAG_F1_1 &&
>  	) &&
>  	(
>  		cd "$cli" &&
