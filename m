Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E6C3AB460
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697542; cv=none; b=t01yIQ5Et7jAMnEMh5AgdUnY+MbH24X0emVQtqwwUakL3u/Kj3Jy1YTARgoshnRbJnTRyxk2Jn8WF1tXoZyHj1Tt6vopsbGx03WZ29uDDTXRqO0gS7f11lKq6Dw87wN3vlTZ7867INWRq5jZDsYSchL9p/xlbdGscYw2DHAaXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697542; c=relaxed/simple;
	bh=b4eFSzCUkT9NGm2UqYNIrP+WoHxI4DLSWOIXLuNjQcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L8lg0PzAnjxc71aQXvaP3xI06aUJ++nwNF/DnivdJMFMo3mf8QefhxO5TR/yGe6+C/5fIgijEIskyXIh6JPNOopNMq6kdgjfn8wzxB+gohRXT0CdVpOZlHgiS6L0FDhY6kuKf5RSPTyqWts6zz4DSfOsnp52npsU+tqT9K8MaKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fyCW2//w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g/awLooU; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fyCW2//w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g/awLooU"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 83CC81D00141;
	Wed, 17 Jun 2026 07:59:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 17 Jun 2026 07:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781697540; x=1781783940; bh=GFa+Jw58T0
	XE0U/6v75/Ji3zWnb3JZpCq6crreiVj0A=; b=fyCW2//wwic0NZc6RpCL0vey9E
	tutUo+IADQY2pj7UBaWYnmo8/Q/bpmSN2GONIh75Yfaiqe8mRg3LOWlDDdzZxN9a
	YSW6xCEjc59kebYxMA2F79/rJBsSsj7FAwjuBp1wBWWbHQ2EYp2tDF753OUHi5OV
	sInvx5N50K1LkPN1ErXeGBw5wT4Dt48evDxuYRxmcKNbkxXMbRBVraSQqfpMe3DL
	Gxrr8B9yW95nT46lb8q39VjL06A364nQ12gSnO/voSxCexOlq/y85nvXq3dDiKNk
	o2ltoxqmdzC87ueXFG5BJT/utZEQ1iVJe8hWgQbDjyWKBx0VfNhuYUrMuKZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781697540; x=1781783940; bh=GFa+Jw58T0XE0U/6v75/Ji3zWnb3JZpCq6c
	rreiVj0A=; b=g/awLooUw1+eFc9kS5E+x2O/UV6stvKK09E7hM7gScgApWE6HDX
	NDZmlNjIzeCuNbhfQaWV2QanLhKBhOLvFB8X4l6OpQ/06YOeIXja6e3IYsap/GQw
	fGVCRf0gSitOWnix3oI3qtu5vQBKeBdW+U2ApSpsDYacX91qZMsyayeKa3c2tXRY
	iWVq63xDCYcCcJhRS/uqrnqubX42xG6HJzCjkuqkSmQAuyg/g8VOUECpT1NFFCeb
	7vq6OTHfb5do9+2xihjcJBSv0/+hySbNfvm4aC0kGgNbqkCwnw0sI0O1WbQr4vqF
	AhKSgBcvINkspELo2P+9v7zIayrlOFXNVTg==
X-ME-Sender: <xms:BIwyarzwEhJ_Gh57UBiXaCAgqDxNrtRVtCJJ52lJ-S4CfpgThC4kYw>
    <xme:BIwyam-pGqP2L9ghK4i-u2sWq_vtAfFmuFhNiIk-PffiEZObSScjkN2-Dm_wzNJQv
    mdj7Aw1MYSii4GQCuzroWop15YrA1z7iLBWqwiz6EHkDFt782yUAQ>
X-ME-Received: <xmr:BIwyavI4qyMWD8QExIvQU6jI1F2aeMo5zyQVgbMsDk-VLu1UClD02qmylPYnQ6FcZRRm5719msP7EhZkmz1YZYK37mLF_oxVrtNT>
X-ME-Proxy-Cause: dmFkZTGIW7Mw+T895CBMSiGyiL7nWHIDDE/239D1EIVjZoDoxHVM3eVAffkMJR/R9n6Dr1
    nu/QqP2yzHiONAVac/YP/HVrO/0yrKb3a8p/KsTtWLF6h1PuElzI/qsXWyfXX3Ro7pw1RO
    /bVElfsjhfKjkDAHTEqegMZ6hP4g8KttcJOO0HPrS3Yf7ghjBvubFgoUxB5qLPMLeKi0NS
    Rxkypy+o5wvnrbQ1alYI5FgMRqGl7eWCQZruDPGcITdC/LJQqZRer515dQ4dpTOWIWGyHI
    wKLzAfYm1Ng756SdZFvOvky9BF/4oGgXsNieUGEwC8tVweSq+pAM7++PBL1pO25b/5PXsO
    17rKXGd+3gv09INCW+lR+3l8uy0pGufMjEfCZx7vNDmEdP3UnDznygLGUq7jQAZuYCIQFO
    lcpPybyLpmCyhV0CapeaG5HtBvTToXbh76aLhdCUIECOVk6wrVi+cSW+AXlzRHhnTP62Y0
    fsCUE/SNQ2aUDpDATJgDj7MVSSkIztuG8PqyoY1pD0D12YKnJ7oHQ+wPZl6YC4ZDlOfOHS
    Cfil6qtoX8cnQnMWzJy8m+NqjFlj5pBIsmGbk26JpQLUvdFKEombuUhyoL42/xBlZIP/ik
    eiydaL1eFdAlU8Uh76wQVnnhNNHh9d+x5JTorfB3SsTPCug7gb6b0LtarNCQ
X-ME-Proxy: <xmx:BIwyascaFkR82fm_H_dUzI_xN1YYgp50dRw6ZhwZu9alOIQm9fCOkA>
    <xmx:BIwyau__YYGGIw172SN24EeWxcxO207Zfv8THQFujO5Mhes43zUIAA>
    <xmx:BIwyaprRLuSx6mVLD7HcvjUqVqR01j4DxvHfTlvYuQz4LRwDT9L0VA>
    <xmx:BIwyajARQAzt7bCDIcA8q1aLCG0DtW_HDauMp-Vr2SqlJLypcU_LLQ>
    <xmx:BIwyaiaBmSym2Q0hSIZVcHc8lAdV60AZAesH2LQzQY1INCUAtHpVs9s7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 07:58:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Philip Oakley <philipoakley@iee.email>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: How does GitGitGadget generate range-diffs, was Re: [PATCH v2
 0/6] Support hashing objects larger than 4GB on Windows
In-Reply-To: <fcb9e52a-5f71-1fd0-a18e-c48e22e6e28c@gmx.de> (Johannes
	Schindelin's message of "Wed, 17 Jun 2026 12:39:15 +0200 (CEST)")
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
	<pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
	<xmqqfr2m4gd1.fsf@gitster.g>
	<fcb9e52a-5f71-1fd0-a18e-c48e22e6e28c@gmx.de>
Date: Wed, 17 Jun 2026 04:58:58 -0700
Message-ID: <xmqq4ij11ipp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> GitGitGadget is using range-diff to compare between iterations of
> essentially the same patches, therefore it encourages `range-diff` to try
> harder to look for matches via `--creation-factor=95`:

Thanks, I'll use the matching 95 in my local "sanity check after
applying" step.  As you say, it is not like comparing an integration
branch with many topics with the same integration branch from a
different day, which would need to avoid misidentifying two unrelted
ones as if they are related, so the tool should asssume most of them
match with each other.
