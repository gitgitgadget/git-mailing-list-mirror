Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0F1B948
	for <git@vger.kernel.org>; Fri, 31 May 2024 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174833; cv=none; b=FW7XJAt/7Z1I3xF6D1N1RgAyziVmKY1U7Fee2gT65Y0TH8NjTuQuzbi1rbAxJYTpO62HzcjOcGK+WQKxleXdKb9rGrB00FOaDTbu/kKaaJU+oqp/74DDMan6LNkXUMBpVXNyxhGdsuN8x5bkYOSShNr8OAen7IwrMGytsWHDO8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174833; c=relaxed/simple;
	bh=bTutAYoEFKNYXQG/Q7HeQH2jkepQ170lpwNms7gsatM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lzo31Qh5vTnl0oGJ5xKLN5rawXBsOE7UE/J+gUn8uatHgNjxKMer6lc9zcaUkLT1G42xubi5wmtil/YzwrRleadTqLP7jpIRMZYFIJpbO+ezsRnotgQyJTRz8quAQ1g36lZiaUS/5T1e1brFIEpT1g4EP8faZprww+9swAMYYb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hsOA3Y4x; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hsOA3Y4x"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B63EB3BDF2;
	Fri, 31 May 2024 13:00:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bTutAYoEFKNYXQG/Q7HeQH2jkepQ170lpwNms7
	gsatM=; b=hsOA3Y4xzVXDmDRxDJF1geVHZhNFJGACQzAUieMQTGmS0vgZgrP+gO
	jq7qguISt+23dFXaADyCSEqa3NrlufeS0kKcVMnQf+soNtVYel/+k8AoHL2x0a9d
	jimuC7jsh14QdDo9P256lqK+X+xBlm/9CObeBy4/bMqVykQqpp3Js=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AD10C3BDF1;
	Fri, 31 May 2024 13:00:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C53133BDEF;
	Fri, 31 May 2024 13:00:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood123@gmail.com>,  Justin Tobler
 <jltobler@gmail.com>,  Dragan Simic <dsimic@manjaro.org>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 2/4] BreakingChanges: document upcoming change from
 "sha1" to "sha256"
In-Reply-To: <7c84b2f957595a3d8bc6d28970a009339c5fbf5c.1717141598.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 31 May 2024 09:56:37 +0200")
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
	<cover.1717141598.git.ps@pks.im>
	<7c84b2f957595a3d8bc6d28970a009339c5fbf5c.1717141598.git.ps@pks.im>
Date: Fri, 31 May 2024 10:00:27 -0700
Message-ID: <xmqqikytgbmc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 48664816-1F6F-11EF-9547-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Let's plan for this event by being active instead of waiting for it to
> happend and announce that the default object format is going to change
> from "sha1" to "sha256" with Git 3.0.

"happened" -> "happen,"

> All major Git implementations (libgit2, JGit, go-git) support the
> "sha256" object format and are thus prepared for this change. The most
> important missing piece in the puzzle is support in forges. But while
> GitLab recently gained experimental support for the "sha256" object
> format though, to the best of my knowledge GitHub doesn't support it
> yet. Ideally, announcing this upcoming change will encourage forges to
> start building that support.

;-)  Nevertheless, we probably want some of that in the body text.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/BreakingChanges.md | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/Documentation/BreakingChanges.md b/Documentation/BreakingChanges.md
> index d8a26c9bf9..1b0a357e65 100644
> --- a/Documentation/BreakingChanges.md
> +++ b/Documentation/BreakingChanges.md
> @@ -56,6 +56,33 @@ be changed to or replaced in case the alternative was implemented already.
>  
>  ### Changes
>  
> +  - The default hash function for new repositories will be changed from "sha1"
> +    to "sha256". SHA-1 has been deprecated by NIST in 2011 and is nowadays
> +    recommended against in FIPS 140-2 and similar certifications. Furthermore,
> +    there are practical attacks on SHA-1 that weaken its cryptographic properties:
> +
> +      - The SHAppening (2015). The first demonstration of a practical attack
> +        against SHA-1 with 2^57 operations.
> +
> +      - SHAttered (2017). Generation of two valid PDF files with 2^63 operations.
> +
> +      - Birthday-Near-Collision (2019). This attack allows for chosen prefix
> +        attacks with 2^68 operations.
> +
> +      - Shambles (2020). This attack allows for chosen prefix attacks with 2^63
> +        operations.
> +
> +    While we have protections in place against known attacks, it is expected
> +    that more attacks against SHA-1 will be found by future research. Paired
> +    with the ever-growing capability of hardware, it is only a matter of time
> +    before SHA-1 will be considered broken completely. We want to be prepared
> +    and will thus change the default hash algorithm to "sha256" for newly
> +    initialized repositories.
> +
> +    Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
> +        <20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
> +        <CA+EOSBncr=4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.

We probably need to at least briefly mention external constraints
here.  Even though in our ideal world, what we say here will force
others like GitHub to follow, in the real world that is not always
the case.  As this particular commit is about establishing the
pattern, expected form of each entry, how about adding convention to
have a paragraph on "foreseen risks", in addition to the "what we
plan to do", and "why we want to go there" we see above?

>  ### Removals
>  
>  ## Superseded features that will not be deprecated

Thanks.
