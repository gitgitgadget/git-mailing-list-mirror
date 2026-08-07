Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39F244B662
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786084214; cv=none; b=Gu/9o/zUBgLKx4G7sro+aOCcpcuYWYSnY2iEiZx4wAf/pp6+Lrj6P+HmOXAkEYNwlyoDzWOvlo8XsvaWrEHef+5yxROsWDtSfbZpw6V/lCE31gtHwv0sWvvR9BmdyVZ0o6qjYSqxOoDzYKlXWqBGXeEnqW112JiuJsfOaXOxz/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786084214; c=relaxed/simple;
	bh=hkzXMgjyt48br269oJwCdX9XBG4QHwa/IV0U30P+hq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGYE6Q2Cg99cKEIpIAxO7zQFmL9KIldZLsdvcQyjjXlhilUVhU5ZGkXcy/fZvq+0pDcFYtmVf8Mw0LP5RCHdORvD8xa8dnXpC6GcZbqarUNo75h9Jt6I938rkWNH9aUt2CXIhYDxl3JigS7o0OzhKljhLWB41ZeHihRk2q7N8iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hzYBa4jx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ELB/PObK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hzYBa4jx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ELB/PObK"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F59AEC0190;
	Fri,  7 Aug 2026 02:30:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 07 Aug 2026 02:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786084212; x=1786170612; bh=uMVcHM3Fwg
	FDPyhNUwIKxy+/IfWhtvy16uobr5TL7bc=; b=hzYBa4jxnuVqX82GwIZXok90Y+
	UfJKdeNqKM/x4wYQxZ/kXCK3m0VniCxEt/bqrwOfPMmN0y2xhyzq2D87F8DeZ2Ri
	tLcqMVRrPhvVOxmXhUTwJekis3IKQd3N0oKu6B48gwCEtm3UBm8kaCYflafP+hKu
	KwFT+VdYjM69xyXqBltcIvwb2CwoL/weODeOjxuwMuTCvf+jUs4XE3C1qiz2uVqZ
	HVw95U23arLMOVeAole9XIhX2MyKffPhHpEyEVOt0vrYHE+JtWAuwqLcLBmr6deM
	GUKiJXl2S4JSzCnFhOIgZwyD466gxIJznHQ+G1TCMmAUBcNJRGZejcjB3jgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786084212; x=1786170612; bh=uMVcHM3FwgFDPyhNUwIKxy+/IfWhtvy16uo
	br5TL7bc=; b=ELB/PObKt7aS/DUY3rYsZaIjXM8cuA01oVT6gKnjA7VDRifk6bQ
	CSAG9aHS5cavV1t8GFMrWwVteWaLHq0X0bFuv44RmDIWdy62WXoG3TvyuZtINH2V
	0hBhO1VeWNn3u0ENkKVAggk/5gkAp37YsCmRxNKbWNK83Yb5kM5NRcdbBMzAW2Wk
	24Tk3AIpW53k+ezkSy7Dzd6RLsF+R1PSRcKVV+ztaYkDYEyW9F0jyfdMwiFd9ByD
	3ETZTvxyDvwprY2GgqVr57dTaC12Do7INOVlGKku+hzcaheYQnXQaQut6EYtIjlR
	Adk4x1HYpeDKyEJVfxKpLwrRvPzhnwsnfiw==
X-ME-Sender: <xms:dHt1ajlkyrIAaGNcBK22giTzMOVrdUSOw1JozUSSzfx2nQs7PudC7A>
    <xme:dHt1at2i8itH-fVVgFmgi7wAeBq591qoJVOJwUdyzypaJrMs3cznGush7mchsUIyc
    TMGxJTV5ABZjtOf-WCOOK6Jo6jKxj03aOTA4-grMb_vfLzYJKgZmQ>
X-ME-Received: <xmr:dHt1aurzR-yPHrdPno5HF_PwzArfNLnUFmKi6S2SDEXJy9xqeKVwQf9IgUbg8XzBvxsGJP3DK3LYoxJBAirATcCE-kxRKj9GRQKGfKh4J-9VMQ>
X-ME-Proxy-Cause: dmFkZTFo08Juv5F3lUZO7xmXmn/lNpFZ59RLSPAY8cDimnsJud875y64o4g6wfYoBy42zu
    wG/HkISjUHCW4J8dwXnJvgdcaff55+DcNwqzT4Blkcrcd0HcDE57OZB5FKYtEd0j+nmqRd
    w8ZkxGp8tYPTfaNbHYIh6UGai3YFASnZei8fOxmTscWDXsb5bu/2hBfCsUXKPGvkAKOpm3
    3WSUDeV7ul3HkkZkS6BzFl34Z4g22pptCVoWiDQsNZzL+Sg9DPFvoAWT5cj8EmtPG8jlUY
    mNkU4pcJlYJwhTOBKZVty0xLp91O/kpFHwpAslxzViKynhycAiLR5d2ONIZUUYaTzhn1Ea
    UBRMYOFxrT09ziQ/ITDxWdoaemogQoKQBG/cIdXVzJBirMP7/S1Gm68IKbQGrKSF2PBebm
    PE1Lo9KlsltjoGomrJ2UbOOz2gENALe4bs+hUijkFqknQid5PvNVuXQYHmsuc43Cgik14s
    FeVRF0bkX0uFZXaoy2EW+Mnt2ciBA/qW23T/gS5PFOGw4+wKvk5U9BZNhn8PuuVo7kn8GM
    +Ddl7tAMfR37ieSbOFBegA9MuSj7tBPxWZW9ozAxrxCUnMe41z2hHfqIr8Dq7xaBNBiOxu
    /iDX6wRHpU+lL8IHcYi9my3n/CZI/Mgeq9Px2DyjWLORtHgKr+NIp390DIMQ
X-ME-Proxy: <xmx:dHt1aqckn-B63T3HUVTuVrEwd1XQmUQkKHt9Dx-ze9_nD0nlSE6FlQ>
    <xmx:dHt1atra5edf3weJ1BPD89AA9Kym2B1qLIhWyoa0d_eldJHTaadwsQ>
    <xmx:dHt1arFYDFvF36BdKtyL7jR02tGUhtWa7XYvmxYcpX0iwxQVCjosDQ>
    <xmx:dHt1atvcB6WnFZlYAdaVgzKDpcbYloU4lTUicSWJb-JWqMyLeKHa4Q>
    <xmx:dHt1aqTrgp2nPJBR1kFw5fUa4nsMSc3FDw4cYAiWx_5ejj7nzVEHYp2D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 02:30:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6910f3ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 06:30:11 +0000 (UTC)
Date: Fri, 7 Aug 2026 08:30:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 1/4] completion: add 'git history' subcommands
Message-ID: <anV7cHblfmGvbl-e@pks.im>
References: <20260806-history_autocompletion-v2-0-7e60f52a1c20@kernel.org>
 <20260806-history_autocompletion-v2-1-7e60f52a1c20@kernel.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-history_autocompletion-v2-1-7e60f52a1c20@kernel.org>

On Thu, Aug 06, 2026 at 10:27:36PM +0200, Vincent Mailhol wrote:
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index e875787710..7372e2919b 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2137,6 +2137,54 @@ _git_help ()
>  	fi
>  }
>  
> +__git_history_has_revision ()
> +{
> +	local i
> +
> +	for ((i = __git_cmd_idx + 2; i < cword; i++)); do
> +		case "${words[i]}" in
> +		--empty|--update-refs)
> +			((i++))
> +			;;

This will unfortunately be quite a pain to maintain going forward, as we
now have to be aware of updating this site every single time we add a
new option that accepts a parameter.

I don't really have a good idea for how to fix that reliably though, I
have to admit. Maybe we should just mostly ignore this edge case and
always complete references, unless we have seen a `--`? That can be
checked rather easily via `__git_hash_doubledash`.

That'd still be a huge win compared to the status quo, and if we really
care about making this work properly we can still iterate.

Patrick
