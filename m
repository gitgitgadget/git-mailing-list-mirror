Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339934751F
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122237; cv=none; b=WAP0/yzDnWYIBmH9LCJmwVm4jJYXYDZgxQK7itz3YezqDkTHSsmXsL09RlNT8aC1WzCVrko9WNXS02t0MkSuMFotnt3ntPSga8HDKcjQoWaKbc3WQXid94UVL9xbgfgJUX0mzj+GyD+v1sC/H557xY/bGrJ6VZEvWhy5O+8AZBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122237; c=relaxed/simple;
	bh=XS0cKUKZ78B8n14MW/FEMwmVsls5gkPPSS1lJF8sdVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rA5BL950TgcXxkQCFRa2tPz5syESbtof+uBX8CJiw6wxG383O5/+15yvRvE1l0QYh82NBbOKvnab+ruwvgJRXL8dfgKcjguqmYUGjBwrYabexvztNz1PDSnJ+WJz35vz0zUdFFZee5EFtJLfG466oe7VlxwpNxs2HnUbYu00GxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yel68OnY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gVlxOQzm; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yel68OnY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gVlxOQzm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B34767A013D;
	Fri,  7 Aug 2026 13:03:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 07 Aug 2026 13:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786122234; x=1786208634; bh=z7+9KkZX7I
	LTlFbi6kb9Rzt1uS2RyKGXcpBrRMvtT7Y=; b=Yel68OnYbC/TWLTxJ3e2z9oQmE
	C50HYWlZjPTvCpyjrOJqXNygxqKaog7LcoowmVbG1DXmAqEOl9Ga++I6IeecXTWH
	C5yLZchKWdubH7c1w+xbAXNUpLYPWAq9tNgD6LUKTMh2+QyS5rCWIsbHHrBgEpan
	89m6SiXvWUZGrNtm55aD+C5JAuvbLDwpHApSACpXllq3WS4k/8Q/jZHMT2UQAuqd
	zvY+AF4PRSp9W6Yf5wGSwpALTdtFKyQkNRlE2833vsiLSjJG6RKQlqYkjN16qSA1
	rOBN90nX3JqNigLX8syxa0YYuQDhpj3qfhR6UWVqnOhg1UO1EFBbEa8jegWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786122234; x=1786208634; bh=z7+9KkZX7ILTlFbi6kb9Rzt1uS2RyKGXcpB
	rRMvtT7Y=; b=gVlxOQzmKUrlQNaRuzVvjB9dYhWtiazzEjN+j290+U6NZxKZDfa
	Z4xCyltEHJb6Rgq92/AuqF18ZGgbT8knuuvjX1+avI0r9iGSu8OcLjZ0JhVqDvTj
	4ZahdWqYP2z8NAmxfxN/kRigpcD4CBHO6VU6pmNuQzslj8xpgGxM7s2FLJ+rZMqu
	vWn8aTvugdw0Nx0Jk13d6sXm2j7rznm4P5j6tnPx5X+cgvEVmlKXlUrBElEhe4Pc
	FmIvRMN36F/aLgR4NMa/HGfBX3iQgq939u3RBwI1ZvlzdtxN/U12Ptyy42hIY2Ob
	hfFMHghekxI9c7NPYZ69LHFFyMMrEV4JReg==
X-ME-Sender: <xms:-g92avNRb7vLa9OE-zVDeGiNFFed61F5LZpjTx-KWazBzDrIl7f1DQ>
    <xme:-g92asM62BYI8lBS7AWUyIiqwXfSj6mt-Fkk7kNRqNMgZ8qEzwAAHFVDRu1ab058g
    4k0DG8obuli8iCMDOo_AUlk5zF1DHbSMTsXohjGH9uyfDFkyhYaZw>
X-ME-Received: <xmr:-g92aggT5C9BD5f7PeBNB6FTLMwZPQHvT6ZQ6Zcuy9R_z2jrHUC6xFfPOUm0V2tcUPbdO__u_o2vMZGsCS-fctPlZWH76MC1tA>
X-ME-Proxy-Cause: dmFkZTG0QgWdpupZ/6zTzywTkUC3DybKL3HUh7SB5h9ue6hEBzgtD9LcG1go1cRUsCA4bu
    xyEkWSRNaDvZCmoB7kj0PiGmJhczZuT6h35fn9jlr0gyOAcYAb70ZcylW3hweBk2WnK3Pg
    O0FMXvkrAr9FfkyuJFSptPhVP6NRv6r0GbWftz2lkRS7v6W/Ow3yBsNilfZrE28HFnK0yi
    qBcUqmy/0nyYE7CsSV3HIeRDlikJ9UOw2Lf55/CtI9regI/U6lpxKfWPT2vHv1wJADYv7F
    oY4h5exMq6tx4LyCUDQHrni0P0KlhXPZo7InHG24GtKcwzNGxU3FnYG4oMzHiKNWqhm7k0
    AL7TgGOQ8FZsnVM2yMnOyeigJInnadGC9w73pPeQ+y5Vm3PrAceBXz8lyu5az0a0znO6wi
    u3FSH8U3AlbgjLL9z0l27ut41TzT0PcQflacQzGbqfZ8iLZF/uil50ea+ABAq2UDfpM9Lv
    D1asS4mEHuwmC8MgaXlw/IzHYCQR9P5UNy+dzhZCbMciRqMZtSs1f8a/XRcAlLEeuwT/g1
    HlbgkjOMy2NkCWtSnbtt5JAIxSRYM7J4sEX8JyTkVls/Ctc+5XoeKTLPeLG1XFSCKMlyM+
    xDO6LFFIWf8PtUncgKWU/aA9gYE4rkQbo135Y9Pow2uGoloG+GiMhgXyolDA
X-ME-Proxy: <xmx:-g92apu4RFc_HwODiMtsQi9h8geXM_ooMy_ZKtfGUH0vW3s8RkwAMg>
    <xmx:-g92amSwtsarOfYmLVbRu_KF733C3Zb4IWyO84oXXC3mslUiY2njfQ>
    <xmx:-g92al1SwGS8fsDSYwQCVTTww-p-n1TGnvG0vjFBqbzKwQUyUYd2wQ>
    <xmx:-g92ajv7eLe-TGE-_1P-VzSKIPNVgCIeb7mtIzvfH0uIxMFBfwgHcQ>
    <xmx:-g92anYweTPecOJmdoHBlFdae65-vS8ZdX5IBXfpa0G0MO4LSJTNKq_2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 13:03:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  ps@pks.im,  Christian Couder
 <christian.couder@gmail.com>,  Ayush Chandekar <ayu.chandekar@gmail.com>,
  Olamide Caleb Bello <belkid98@gmail.com>
Subject: Re: [PATCH v3] repository: move fetch_if_missing into struct
 repository
In-Reply-To: <20260807094132.806165-1-cat@malon.dev> (Tian Yuchen's message of
	"Fri, 7 Aug 2026 17:41:32 +0800")
References: <20260716072954.582235-1-cat@malon.dev>
	<20260807094132.806165-1-cat@malon.dev>
Date: Fri, 07 Aug 2026 10:03:52 -0700
Message-ID: <xmqqwlu1eubr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> The global variable 'fetch_if_missing' controls whether a missing
> object check should prompt a lazy fetch from a promisor remote.
> In order to continue the libification effort, move it into
> 'struct repository' and initialize it to 1 by default to keep the
> previous behavior.
>
> Note that in builtin/fsck.c and builtin/index-pack.c, when running
> related commands with the '-h' parameter, the 'repo' pointer is not
> passed in. To prevent null pointer dereferences, we defer
> operations on the repo until after parameter parsing is complete.
>
> Additionally, update the partial clone documentation to reflect
> that this is now a per-repository flag.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> ---

Have you made a trial merge to 'seen' and 'next' to see how well
this change plays with other topics in flight?

> diff --git a/setup.c b/setup.c
> index b4652651df..ce2a80ac31 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1064,7 +1064,7 @@ static void setup_git_env_internal(struct repository *repo,
>  		set_alternate_shallow_file(repo, shallow_file, 0);
>  
>  	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
> -		fetch_if_missing = 0;
> +		the_repository->fetch_if_missing = 0;
>  }

Pelease remind me the reason why we use the_repository here, even
though a few lines above we are already using the caller-supplied
repo.

Also setup_git_env_internal() no longer exists in 'seen', if this
topic wants to play well with cf1687a41c (setup: split up concerns
of `setup_git_env_internal()`, 2026-07-07), you'd need to coordinate
the other topics and their author(s) before relying on the presence
of what they are removing.
