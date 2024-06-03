Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B513541B
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717432630; cv=none; b=p81qYwBkeMmaF6ILSd8YPsqnsH96aq1rEchfJiNVh9IMsz0Lx4luCdpIRv86++hWIyaVaKRmNyBq0u8fvJZfHw1Lyvg8pg2lthR6rWv4il3a+rCuBi5gnHkpzOAdRoYvrgOcqld0tf7MMCy5Rx/irZvOnI8bJBNW6P7sgiXNnos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717432630; c=relaxed/simple;
	bh=z+IgrwIHPAPLn2Rv+UvFJz7fGTbF5UhjAPote36UXJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J7buL1IUr9rfR5GY5S346VDcGIp/VXdZkWJu9SoegVizkFc2IEa8sXZbEs7hf9DkiV6DQihTjD94DHqQU2cN457OTDQoFOgmn8mAMjVkKKtZZpuajSrgwOqdWUFgAVZJGNLKurdxszC4kROCyNRCy9mJRsbcF/yDFMmP+RJMwAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R+VDmZlO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R+VDmZlO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DED42C903;
	Mon,  3 Jun 2024 12:37:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z+IgrwIHPAPLn2Rv+UvFJz7fGTbF5UhjAPote3
	6UXJM=; b=R+VDmZlODdWbmJFO0CNDOCQ+RlMAeoh5POdr8C/DtchwEVOwIQ8OnF
	O3gNBm5UNXFNJQ1ZLH80PFz6aUOB0JbVnBQ+Vn2QKNfrgrRe4LIYvBGM8zATRpbn
	0WsEKL8alYNCjSvJfG2TL5IrXEgwfRWgk28wnJsL56r7bC17IP3JA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E71732C901;
	Mon,  3 Jun 2024 12:37:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 199D72C900;
	Mon,  3 Jun 2024 12:37:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>,  Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v5 2/4] BreakingChanges: document upcoming change from
 "sha1" to "sha256"
In-Reply-To: <b36ffcbaa67dcdada630e2d582e75da623512743.1717402497.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 3 Jun 2024 11:28:27 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717402497.git.ps@pks.im>
	<b36ffcbaa67dcdada630e2d582e75da623512743.1717402497.git.ps@pks.im>
Date: Mon, 03 Jun 2024 09:36:59 -0700
Message-ID: <xmqqfrtu56fo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7FFC8E52-21C7-11EF-8F6D-6488940A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Starting with 8e42eb0e9a (doc: sha256 is no longer experimental,
> 2023-07-31), the "sha256" object format is no longer considered to be
> experimental. Furthermore, the SHA-1 hash function is actively
> recommended against by for example NIST and FIPS 140-2, and attacks
> against it are becoming more practical both due to new weaknesses
> (SHAppening, SHAttered, Shambles) and due to the ever-increasing
> computing power. It is only a matter of time before it can be considered
> to be broken completely.
>
> Let's plan for this event by being active instead of waiting for it to
> happend and announce that the default object format is going to change
> from "sha1" to "sha256" with Git 3.0.
>
> All major Git implementations (libgit2, JGit, go-git) support the
> "sha256" object format and are thus prepared for this change. The most
> important missing piece in the puzzle is support in forges. But while
> GitLab recently gained experimental support for the "sha256" object
> format though, to the best of my knowledge GitHub doesn't support it
> yet. Ideally, announcing this upcoming change will encourage forges to
> start building that support.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/BreakingChanges.txt | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChanges.txt
> index ddce7cc301..904857a636 100644
> --- a/Documentation/BreakingChanges.txt
> +++ b/Documentation/BreakingChanges.txt
> @@ -61,6 +61,30 @@ be changed to or replaced in case the alternative was implemented already.
>  
>  === Changes
>  
> +* The default hash function for new repositories will be changed from "sha1"
> +  to "sha256". SHA-1 has been deprecated by NIST in 2011 and is nowadays
> +  recommended against in FIPS 140-2 and similar certifications. Furthermore,
> +  there are practical attacks on SHA-1 that weaken its cryptographic properties:
> ++
> +  ** The SHAppening (2015). The first demonstration of a practical attack
> +     against SHA-1 with 2^57 operations.
> +  ** SHAttered (2017). Generation of two valid PDF files with 2^63 operations.
> +  ** Birthday-Near-Collision (2019). This attack allows for chosen prefix
> +     attacks with 2^68 operations.
> +  ** Shambles (2020). This attack allows for chosen prefix attacks with 2^63
> +     operations.
> ++
> +While we have protections in place against known attacks, it is expected
> +that more attacks against SHA-1 will be found by future research. Paired
> +with the ever-growing capability of hardware, it is only a matter of time
> +before SHA-1 will be considered broken completely. We want to be prepared
> +and will thus change the default hash algorithm to "sha256" for newly
> +initialized repositories.
> ++
> +Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
> +<20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
> +<CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.

A few things we should probably list are:

 - Even if you can locally use SHA-256 in your project and
   push/fetch the history around, public forges may not be ready.

 - The strategy to migrate existing SHA-1 project to SHA-256 without
   going through a flag day change has been designed but not
   implemented or deployed.

 - This is only about the change of the default; we currently have
   no plan to drop support for SHA-1 repositories.

IMHO, we would want each and every item in this document to mention
the risk factors that may prevent us from going forward even if we
wanted to, and the first item above is an example.

Thanks.
