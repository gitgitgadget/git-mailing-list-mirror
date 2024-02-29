Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700CD7A125
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234139; cv=none; b=oiVnvBe9+oKMclsFBhaqMVoSV1oSh4RCXfI17UqVwD16i6MlPyy9OBXWy/GdtmuzgqdgVlpzeAkRJd8N9vcwMsw+JnjEC5fcCILA8vWbLerPDz8iuTo+uIjuUTGv4OpAHI5Y+XwtO6L6GU1VtnaRZ6mzosQyseQRLt9daC2+3jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234139; c=relaxed/simple;
	bh=TY7npMdnHXtt83Za5D9Vlll1XLRKgVu+0qPBtpfOHwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=btC3+bF5vCcR6jmPbHKzf+IwS+2CfiXNoX6T6WZVNx7LVLJJexUUF8lBh+/7PvJ7rNjkCsGPXadSix8K4xuijD9JflUIHZaXcZQkqK3Fl9Ioe+ODC1S0NFnLpACp2btW4R0bqPVx1LexpJM/QonTLN7dgay6v76lmou7GUCJpbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dg1dixjd; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dg1dixjd"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DDB31D16E5;
	Thu, 29 Feb 2024 14:15:37 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TY7npMdnHXtt83Za5D9Vlll1XLRKgVu+0qPBtp
	fOHwg=; b=dg1dixjd4NJxCflbuL/C0Ep/mW8jtjh+cBCJPhObHGZfHz47amKzCr
	RUYe4srLDaWVBTDsLqy/NcFIF/iPMp0tApwNeNe7Kp32SAY8vvQ5lqfOUREpwxVB
	C5wjUdiDs4UWlXPHuH4SC/MpV72OZmFS0K1qXXCwWX8v7v4WCCJc4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 551DC1D16E4;
	Thu, 29 Feb 2024 14:15:37 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B76331D16E3;
	Thu, 29 Feb 2024 14:15:36 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  newren@gmail.com,
  christian.couder@gmail.com
Subject: Re: [PATCH] setup: clarify TODO comment about ignoring core.bare
In-Reply-To: <20240229134114.285393-2-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Thu, 29 Feb 2024 19:11:15 +0530")
References: <85d4e83c-b6c4-4308-ac8c-a65c911c8a95@gmail.com>
	<20240229134114.285393-2-shyamthakkar001@gmail.com>
Date: Thu, 29 Feb 2024 11:15:35 -0800
Message-ID: <xmqqsf1bf5ew.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 EB1B280A-D736-11EE-8D79-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

>  	/*
> -	 * TODO: heed core.bare from config file in templates if no
> -	 *       command-line override given
> +	 * Note: The below line simply checks the presence of worktree (the
> +	 * simplification of which is given after the line) and core.bare from
> +	 * config file is not taken into account when deciding if the worktree
> +	 * should be created or not, even if no command line override given.
> +	 * That is intentional. Therefore, if in future we want to heed
> +	 * core.bare from config file, we should do it before we create any
> +	 * subsequent directories for worktree or repo because until this point
> +	 * they should already be created.
>  	 */
>  	is_bare_repository_cfg = prev_bare_repository || !work_tree;

I do not recall the discussion; others may want to discuss if the
change above is desirable, before I come back to the topic later.

But I see this long comment totally unnecessary and distracting.

> -	/* TODO (continued):
> +	/* Note (continued):
>  	 *
> -	 * Unfortunately, the line above is equivalent to
> +	 * The line above is equivalent to
>  	 *    is_bare_repository_cfg = !work_tree;
> -	 * which ignores the config entirely even if no `--[no-]bare`
> -	 * command line option was present.
>  	 *
>  	 * To see why, note that before this function, there was this call:
>  	 *    prev_bare_repository = is_bare_repository()

If it can be proven that the assignment can be simplified to lose
the "prev_bare_repository ||" part, then the above comment can be
used as part of the proposed log message for a commit that makes
such a change.  There is no reason to leave such a long comment to
leave the more complex "A || B" expression when it can be simplified
to "B", no?

Thanks.
