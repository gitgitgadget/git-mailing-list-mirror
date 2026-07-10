Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F5534A797
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654268; cv=none; b=KUul7T48nBbaHQUs8p5mXhuEtUj2vGzY+qBH5b+BgYLJgfg5L5fEHdN82+JtJFO6AvLiGn86dSI3iT9Rb1AKAEDCQLZovmlUaRjjE+tGf/z+vdkFM2eJrMC+OiY52QAwT7YzmhtQsdY2eOMVRLAZISHUqFGYHyTIAQSBvKWuPwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654268; c=relaxed/simple;
	bh=2HPtbtGICNJVnuPWjAWZeD42lqD5CLO6nZvTK6MFiyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V0o3IYJNLTN6CiMqTdNi89bzoY/sSgu4caejHiIvizOO80WbMmrbJN3lZStJeaZWoL1Y3zjoW4HeQSx8nY0V+xcdFLECU7eoHxBLRre9yTkH+G1pX/bn5KgpdX/9BASHzY34fLT7tXPQMHYSjctyOOFI4mJbIaWqt1PLCzJSTDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s0YAihRK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fisdGXzZ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s0YAihRK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fisdGXzZ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1DC881D000D1;
	Thu,  9 Jul 2026 23:31:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 09 Jul 2026 23:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783654265; x=1783740665; bh=5pzNVPXYuC
	vSHkYXVBvVtlMtPqs2R58wVi7sS22+gM8=; b=s0YAihRKLQI3a6h2T+qA9OcKF7
	gfNzITFdgLaYURFJJO0nTG1TVLjB2P7vJsNPyDUQmYVjJQ1yz3Zf/vEa+94LeUww
	rVljNwZ/QZwtj/pMAwXztlQ/DzZ02LVEfMcX6cN6DFiDfnrZ62t6zLcl49YTVetC
	+x2N4YEp6ATH674FkzoiY6amRn7IvnaYMau8OyNV+FFqlqeHxI/VfQLTsjU5QLyl
	7LQ7NYueQyKfOdNuySQ62xoVaPoVtd1THVYdzjcoIw85Q4vZ9OKz/GU+aQdprOer
	p2/iet5NOVbQHkNvbFmyzYTCH9LEPgPeMswX7RrU9pxIcN7WxMtSWfhVekEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783654265; x=1783740665; bh=5pzNVPXYuCvSHkYXVBvVtlMtPqs2R58wVi7
	sS22+gM8=; b=fisdGXzZTF0UgKlDasJ+oGuMlwWSPzVLKCQyP9dyFgpOseQg0lS
	e9XjOHOB8PF3IN2kVr1PzZ8C9bbO1ItKaz37GkX7N47K5Rg9VudRgz5obkUWkVRs
	Dy1gcaaNAQxtJwS5wB4cC8hyxm7lu/j2skfuhPogxgDnsauktehvyk1BfIbovoP+
	jZfirdS9F9JI9W/UYzZTjdtTp2Ez5UFzwSA0Hx0tZVzhHBBATwZ1qNPCns2QNP54
	vRU/BGMHPsf+U8pZN7inlnnEZoDEKwG+KdoyxlQSJ5ZVzi44Iqd42X/76WZLCKXF
	KVulB4xL1SJuZQfvQzBxLJZZsRx+6PgKRWQ==
X-ME-Sender: <xms:eWdQaiI8EK5kXelHi156SSdvxwGQUZY7IvETT2He3V9zjSd-KgX4ww>
    <xme:eWdQahLndgFWPEsT8hpLykbKpYNEhL27FuLV30gInhZ_Dp0-6H2_kFnYhkJqz6lAJ
    7DVsVI-w5kz4oOXA-Ubdu8d_rJ6B5BXZTaEsnxfkDJfvsFivpU5zg>
X-ME-Received: <xmr:eWdQanucvIEDRpQkLFvPr6NQubnVgVx_aDx51Cr0QRYY8LOYVpsi6frydDNA1sVkl8onDpYzExhm0NDrcR5GsSeXW98dnBh_ZHDkoZk>
X-ME-Proxy-Cause: dmFkZTGqzDp5xBm2vUu5jZhnvmMN1QEF0BOsaNyXsfjagJL+hG6s/gWgDTIXAIW2UR2sjO
    Ybkk15vLoZpdXShTL9GSBSSGZITbF+6mmw+HtoQqUgOH7pEN4tg8OPAFxgvnD60WM2IaYm
    6jSi4Uq6Rm3JQGmeyvC7aMiYA0t9UrTHcgfdB+VfQ7/x+pG/KDRo5z0OT1GtgLvuo7TmoJ
    fE92/MYx2i0GVhtYxstLTpixXW3od2sKqDoiVczqwhzVO0mwGg3DxVj8uIRa1+q+wFOWoZ
    I61ko3BV1aptmYt6YBBidCkRGjSbxIiC3Wt2zIZvtyGnmPfD+ExBzdlugSE6QOz9fWIOF3
    ipiUFoqrTE/64UUsmUm2Y/jmqKQLo94ZZGWKuuN4FWMg5mM7QcxoijlxKv9GqrhQLBOe18
    /hCrXWdfUjl8P0hGj9xZhzjmrc8eDmBBeD5R1TKbhrBJ3WdWzpNVnh95/stAc4ySBx70L9
    30k/nPk5ejreyyIoy49FBD0Ov1luzB1CwoUXRk32czvM/FrF9oVSvfDDPsv0wjN1l7V9Aw
    aX2mhpvmZq5L75uR7LkdSgEt48LyD1w62XbiOSVrT6olI3j8ymImXjhHF/cvCzfg41dFGk
    r9NkXd2l5140j6cLAa8KbHKfFoVjORgK2YmNo8ZmW22w/GBrVUEqsfya7kLQ
X-ME-Proxy: <xmx:eWdQamQwaXZexHvpRAg1t-a2HOw61eMXJbOU1cCDAm1as17YBp5hOQ>
    <xmx:eWdQalOotO1p4qUN8ciGQfTu8UzukJb-w7qN2td7VjRdcGg5uMxFsw>
    <xmx:eWdQajaLQPoJMe-CVFH8WLMD7DK6dSPGRhsM2Qv8jDglunL9jEeAzQ>
    <xmx:eWdQanzdQDx7LzUumCFjK6O7QzKP-aFxIZ5Gtmsx9CV7n7Dcfvcy_w>
    <xmx:eWdQahnyr9c4Wuy8V8S-wm6hfYxXZWiT62OdZpJa92eC2svP4FC1_Mpd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 23:31:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 06/11] bisect: handle NULL commit in `bisect_successful()`
In-Reply-To: <704137510808ade246c6f1463e88a8e3041e0f7d.1783590159.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 09 Jul 2026
	09:42:33 +0000")
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<704137510808ade246c6f1463e88a8e3041e0f7d.1783590159.git.gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 20:31:04 -0700
Message-ID: <xmqq4ii7h66f.fsf@gitster.g>
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

> diff --git a/builtin/bisect.c b/builtin/bisect.c
> index e7c2d2f3bb..6ff600c856 100644
> --- a/builtin/bisect.c
> +++ b/builtin/bisect.c
> @@ -663,6 +663,11 @@ static int bisect_successful(struct bisect_terms *terms)
>  
>  	refs_read_ref(get_main_ref_store(the_repository), bad_ref, &oid);
>  	commit = lookup_commit_reference_by_name(bad_ref);
> +	if (!commit) {
> +		res = error(_("could not find commit for '%s'"), bad_ref);
> +		free(bad_ref);
> +		return res;
> +	}

Catching this case as an error is the right thing to do, but there is
a bit of an impedance mismatch between the return value from error()
and the status passed around in the bisect codebase.

The bisect.h header defines an enum bisect_error type, and I think
the sole caller of this function, bisect_next(), expects to see
BISECT_FAILED.  It may happen to be the same -1 that error()
returns, but for longer term maintainability, I would prefer to see
it done more like:

	error(_("..."));
	free(bad_ref);
	return BISECT_FAILED;

or something along those lines.

Thanks.

>  	repo_format_commit_message(the_repository, commit, "%s", &commit_name,
>  				   &pp);
