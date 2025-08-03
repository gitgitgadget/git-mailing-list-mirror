Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CB41A840A
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754239272; cv=none; b=r85B/6P22cLDL8ckGVTMnzWsxIxC+DJ3A3XEfaIBpZVcy2sl+m6oXLll/wQKBJyhTKhTH3dgRmbFf31PtCJREfC8bGS9Z5kMCVLHnmnM71OBA6+O9bqbTtIjlECnw0GWquNCmFL/WTnpcEWeTRG0adt93e5RQkkMl0Inmmf8Shk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754239272; c=relaxed/simple;
	bh=/B7muSfkAkiWTRPCHH5PSqmBsFuOM3zkjyGAOB0yccs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eSPWMv3dC34Zd7CNbmxvDbxFh7Oh6MSV2LO0g+/j4gm8qVfutnYdSi/n5iYPl/GwCamTGW9e2lw+taZ+pX0Sx8jYtpAXpppRjiN+p+ELAuss2ZX/VTQUWbkg99xRYkseisFeuHnUXwFowipKrT9Y5N+eITMoTiClH7lqAek9OG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EDgiuKTQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UDQxdSra; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EDgiuKTQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UDQxdSra"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C795C7A0020;
	Sun,  3 Aug 2025 12:41:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 03 Aug 2025 12:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754239269; x=1754325669; bh=JJkNS8iVgf
	ZPiAShzwz+Xsy+Dvx+6MNuREKXqjtH3fs=; b=EDgiuKTQE4/R5xPvoNZgdPk2li
	aosbcMvmDZqzxu2qxtUqomYNO0ht44WNuag1Av/8m7HJgwlsgK4ueFinfvCMFWWA
	tdQYUUegFfiV73eDIflW6ZVtQQizFZTzErwAqHcoLCcak10gefgv0Q5Q9EqcOKgW
	BuXvZ+5CulK6kJBRVfMTTF5nNSnZzyx3ARhkdDlqj7U4KUAV4RYKBV2d74JP5TEP
	ypeRNHTlXh7W7nFcv6EfCWKKWAJXL03MDJlsAdAgSzCHrv/Oy6O/DYrPBF9bkicH
	pDUGh4JkaUDDJRJji+mAjW700jf2F93HlCqaVcOox8p7MpftfGB052UvwnsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754239269; x=1754325669; bh=JJkNS8iVgfZPiAShzwz+Xsy+Dvx+6MNuREK
	XqjtH3fs=; b=UDQxdSraIcCoiSQBTocDtrmGkA49cSyY1RiGLVarYAT2MfEaWzc
	YOVcetnPi8t74ElW8sV8AKt0wpy+VXUQg/8tel1ThYGyH61VkhjNkpES18wAVGEw
	NykMO9KM2ywtPIaGy45v6P9gHqwgO3BfbZOAmNKIvMEEcrgZ6KJaL72EHKF23fQs
	xXJwlqNZzbbGCHeQ3Ha4t7SLKHvNjutbzefa4aX/4dCFdncR/KCWrglTl61HJuvr
	paZZ92jf05XI6JzFDmA9DmuCsScNhVcn1Hfu/JBJBTAmSjljDQOP2WU04AvMzhjE
	RE5wOox1eypRmR1SdVxRvYKvkWbawmYuexA==
X-ME-Sender: <xms:JZGPaKt06FZG7hwLezdKzIrkrrjEdRm6dX54DVafvqv7OT3viiBaXA>
    <xme:JZGPaK_hgVSQuLn_Asznj8MIak4elMS-Zxs829O_n4XyGXNo_Lv0JJN9yeyQis1lM
    tgJRtNAizlbFgwlUQ>
X-ME-Received: <xmr:JZGPaMN7BQEGlT2U9yui6w7eE6uLBpvhDg4VzwGp2kPdx_bH0TtNT0OGErNocAmmxqFUeIEFjedNPIGAEdybgftZsGysTlTxdpgC__w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdelleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:JZGPaAGhYMMCXu5wkNCPabc1ee7XYmF_Q6i9mDYJ3s0i2ubOTfHi9A>
    <xmx:JZGPaCTNs0_vDzczVPQPNSCCSJsjIOZFN4bZFGLXTV0tGy_7ZhTdPw>
    <xmx:JZGPaFv4RSXioGQLZG6yZM_mEMyl3gL016cz1V6Kdl1csT9iEvIyrw>
    <xmx:JZGPaCLCQZE8HcUATqcY8wiAZNn4oIezDiXBq5Y6MBOAOi_3VWxRDA>
    <xmx:JZGPaE682EvIgcQIX1exfjHDx42OkAehsA86dTULB7iHtWV6YUwLBp3y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 12:41:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Usman Akinyemi <usmanakinyemi202@gmail.com>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v3 1/3] t1517: fixup for ua/t1517-short-help-tests
In-Reply-To: <20250803161033.77696-2-ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Sun, 3 Aug 2025 12:10:25 -0400")
References: <20250803012613.54086-1-ben.knoble+github@gmail.com>
	<20250803161033.77696-2-ben.knoble+github@gmail.com>
Date: Sun, 03 Aug 2025 09:41:07 -0700
Message-ID: <xmqq34a8fjdo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

> - fix instaweb test prereqs
>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>  t/t1517-outside-repo.sh | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index 8a417af47a..3dc602872a 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -123,7 +123,13 @@
>  	*)
>  		expect_outcome=expect_success ;;
>  	esac
> -	test_$expect_outcome "'git $cmd -h' outside a repository" '
> +	case "$cmd" in
> +	instaweb)
> +		prereq=PERL ;;
> +	*)
> +		prereq= ;;
> +	esac
> +	test_$expect_outcome $prereq "'git $cmd -h' outside a repository" '
>  		test_expect_code 129 nongit git $cmd -h >usage &&
>  		test_grep "[Uu]sage: git $cmd " usage
>  	'

Ideally this would want to be squashed (or moved) into the base
topic.  Can you two coordinate among yourselves?

Thanks.

