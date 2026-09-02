Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E47C38F254
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376866; cv=none; b=pAUWBf5Qcw0YWQ7GGm1sHWmbPK6nPJPusJuxMEVfVZw2N967KgfaU/zK3tpzetLjRc9j36YeKCuLgjqgWvD1c0t6WJkXVENyy+7R6AiGV6o/YVXIUB1KmAHvZNeRgtwO/Fe0FomKi5xACZ3/UurZXlaC7K45/mnfFH8W/cYFS6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376866; c=relaxed/simple;
	bh=Qi+UNuXAo3Qcnu6KoZsOaGDHZ94qjFjyX2nPtm0EqVE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XKV+QuaNNCK6c60sA1ZJWOLAYvC2w2wDAz1Fqqcj2POFNtmaIPaM7XBxPIu+++cZLw7jqi5yeJylUNp7F89lKmuYCgGqiZqEmpTPzEpPoDyq64gXRlcsoZDs5rkQBpjoC5mxj9HPiGPCyoMxRVOXdYsL6tWOlOCbGjs304YcBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PHLF0wki; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wb3ER8xu; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PHLF0wki";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wb3ER8xu"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 54F771D0007E;
	Wed,  2 Sep 2026 15:21:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Wed, 02 Sep 2026 15:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788376863; x=1788463263; bh=awRgkB9FLQ
	Sq+9oyCmlOMLiKbnpVq8XvixdOz514Rvw=; b=PHLF0wkivpxkAo960sXju8tfg2
	3bVbPLRPZT1bGMBvPfFNN94Anqo9VzM4e8gW8vb9Jncbp0JiWnjDJQ3F5DzxHSeV
	hpM5QsOVz/pVF4IbAvyr6YhMytsmaB1zAKOKor1QM+d/CY5PxPK9ZLwcFdweIChv
	R1Be+tjIkRUaAANP0KFN2+XPXkez2TqqVlMocvO4lhL8wkNu8scK8JDOZf0iqVkA
	h+nMgv7G0bCd7Q4Ph7QordY5s6RwEm9m9DO9nOqYti6F2i+0Z0Rm5Y0S0Jqh4sHa
	mc1YCCzT5PFaIKSnVwMJQ3d4lgqgFz6bpbVieWnN2Vc9dTy+mkR/3khGRXZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788376863; x=1788463263; bh=awRgkB9FLQSq+9oyCmlOMLiKbnpVq8Xvixd
	Oz514Rvw=; b=Wb3ER8xuGHILgAZOeVIYiUUfNUc+peJzJQcvIP2MAxMDyGZVLuU
	lC0QtYUzClPHlHvTvAuAanMMfmpnQRVeJTloIC8WEi+eaZjEQq/p8OlPkY/smJwF
	OlpUWOU7avdG+lpNX9ZjBYjEfQZisKGo/F5kvjIi8UaDFXAs0yy/IZuiRLFyQpKs
	VYfO8pSSIOjSJBR0bwvvRPASWdfWOJlQMfzGjRvJlPSTcA51xHrTJrgrlP7MGkMK
	eD5hsd2ubKQCjRZfLskuo9dSO9+B/8p7nrPBSPwVqYCTEmFn1xsYfBkHMuh7S5M3
	CWhrV8rfDqYLQPfe9xqdgdlKWXcarOc4N1g==
X-ME-Sender: <xms:H3eYarLZ9OP4bXsyTAucrzrm85quG4qrty87DRmP_t4afF2TypoI9Q>
    <xme:H3eYamCDGzJigt_I-tiVcJf3myegHkzUDN09FAYTJriVa6_-tl7bcYH5PBwsLiRJZ
    Bqs7YQhzJ-x0UqbMs0e2gqdYC9jx18j-l5Imi9VJ3JVHiHinAz1DPA>
X-ME-Received: <xmr:H3eYasDCUQ3zAWkBpMeaSoE5cOmxxigQZDBt27oggz2OYDHOrPKA16W1R2K0mLsU-g977h8yHqdGoTTh082gCjSZk-vH5Qu2NA>
X-ME-Proxy-Cause: dmFkZTF9SpdXXixuI1GaAXQa/hQM7kwDexo+ue5sufXIFj2gaTHwgZ2MEGd8d7INu0Opx6
    IuAy+7FMECaUxv7yA7yoECrLDCUKN3qh4/yZzC4JAfF1VvfunXYTFh7SHFffqJXTK+x7FV
    Qn9ZN0FB2ZyjriVWER7hnR8JSRh+XP1hx7mvhc+QWRdDZ7WdLBTUTeRRr08xKGmZ19ua+/
    FbTNCBK9B3OG5/Zu6T27AxaUcxsPvv9ohVX2eX2H00JnyFde9g+cHtSNxKOZeKFpCVZo/4
    mrNdXK1oC/Dz8wU/Vyg2RkUEHSzcHCP6T9vl9NwjYtrxkS7wh0Rtmy0Bsow+xC1yjyNMGL
    6pBmV1F/vjkpBceQZqBRd/UEfS1elplqUCdDzLErIg/shLtiT1DVtHvKBTDkPMpFLEI8jU
    9vALywl5CUoUKRT0ht14EoSPkj7Tb/PSHIJWOgvCl4dvEY40hYekUArdvYTDkDP+7SUDMB
    cQ0i0CrRaD0VmXv8GyqFwC6eAmmtNGw6h/3L/9pdoS/3D66ReyiKMRUZ2anhRNqq05Wf/5
    BWl0ENo3nr1qERbQpvWKIuC2We0nt96GkdwsXGPWpswOK/hYNurrv9D+r7ROgrqq+On5Nz
    Fltsrzc+RaUhM1tWQ68IO0YAxeOJx3SUiG2Xjoe0pSVQg36lzAfCMAdxXgZg
X-ME-Proxy: <xmx:H3eYagCWaa8ghH-x-SAKVvPZMyS538cTc2NaeYzsGXlRaIonSZPPrA>
    <xmx:H3eYavqazgmA-0J8b0ObmX_avqNNjmfz5tbwo0sSXyngs2-cvOPvaw>
    <xmx:H3eYainyqHqiiiqHG--XcXOmILsW927aC42eYZYTPlDQW_u7gql9RA>
    <xmx:H3eYanw5hSVIFVXggltcQNJn9afgoFneuNzREjEV2tbIsisccgBlVg>
    <xmx:H3eYasjrjQCygXHm9IXrlscAURVeDMqYWQAyqtvtMzPw26iA03D2yshV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 15:21:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alessio Attilio <hello@kairosci.dev>,  Alessio
 Attilio <alessio.attilio@protonmail.com>
Subject: Re: [PATCH] hooks: introduce 'hooks.allowNoVerify' configuration
In-Reply-To: <pull.2215.git.1788365862670.gitgitgadget@gmail.com> (Alessio
	Attilio via GitGitGadget's message of "Wed, 02 Sep 2026 16:17:42
	+0000")
References: <pull.2215.git.1788365862670.gitgitgadget@gmail.com>
Date: Wed, 02 Sep 2026 12:21:01 -0700
Message-ID: <xmqqa4pzihnm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alessio Attilio via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alessio Attilio <alessio.attilio@protonmail.com>
>
> Introduce 'hooks.allowNoVerify' as an opt-in workflow guardrail to
> prevent accidental bypass of hooks with '--no-verify' when set to false.
> Authoritative enforcement remains server-side.

Accidental

	$ git foo --no-verify

may be prevented by setting this configuration variable, but then
would we need another layer of protection to prevent accidental

	$ git -c hooks.allownoverify foo --no-verify

by introducing another configuration variable to forbid
hooks.allownoverify to be overriden?

I do not think we want to go into this slipperly slope.  Thanks for
sending a patch, but I am personally not interested.

Besides, verifications that users may be tempted to bypass, but want
to instill discipline to prevent bypassing, may not be implemented
as hooks, and the way they are bypassed may not be "--[no-]verify"
command line option.  When one wants a way to prevent such
verifications from getting disabled, the mechanism should also allow
forbidding verification that is built into the system from getting
disabled.  Limiting a settings to hooks is probably not a good idea,
and introducing a new "hooks." hierarchy for this setting is not
something we want to see.

