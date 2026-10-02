Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B4B311C32
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959817; cv=none; b=j0kyurHd1Cyt/oKj/6NhKZTsvzaJC38SsjVNm67LY3h3bCfLqxhKNcBNEb/BlttGitarXHIEQaKhsBTMYuSMva6Zb7t2RFCbYkgZe/sHWbfXUQucJKRPfBTzcgNFdI7C3TlG8CuIIxdfhAGVhnp84kW5L7V/DbIMzne+sUQ0dpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959817; c=relaxed/simple;
	bh=CxOxUyJTcyDLJwrp1dk9mVcCvf0lG6uAAy9jIvKWrcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iXiA7d/mp08/Fnc5IGCPBUenmy8+jxRluwvTQquCGMxcGAqdGmeYbmXpeA/oq6fflD4kOR4vdM1IV3I1BxZAzSKy80YPvmRavuMjqfuLMd/oAfYyjVWTMpPKfPJ9rtt22qgbnCS0lXjQQWVg7pBzAqPhh8kcaN0IW79Xv2nOvCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hSsVonu6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQSkn2ZK; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hSsVonu6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQSkn2ZK"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 596AC1D000F0
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 12:50:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 12:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790959814;
	 x=1791046214; bh=KH53hp65rC9q74pppqmZ28L3uunt8FAk3YN+aG6c/p0=; b=
	hSsVonu6QfeLdFGAHkmUJjR5MxyxTce7tNc41a3Z5RH0wOvGECbdvrQ0BbKxeyAg
	lK0ctr/QSj422VD3IxIdTxdeL5aez0HMjly7OPKebhWMpUMrfmh8XkX8bzsm6Oxr
	URRLb/7EzRcUesEFFE8lO++fJrd2g28Ebqggg6+Km6TnOkQU76U7yBn4Ts5zQoLK
	9mVCdxXuQ87DC4Z4+d5GWRjJqsBry15ba2PHd8z28E5w3ryCueY7738fRy+CP1/B
	9M0PgoweWUlVct6KuTGjOvFS9NGvsGXg/TtzFNhBbBm4K0Urdh57QuII0nzAEsel
	m2J3faSXqvOcopq03y7iCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790959814; x=
	1791046214; bh=KH53hp65rC9q74pppqmZ28L3uunt8FAk3YN+aG6c/p0=; b=T
	QSkn2ZK5WwIb1D1Hna2phF2MQEeAgaA9AZ+fvMuoXyoltmMP6mCsvV/WWXB9aymP
	x4QeEWCP+g28lv5JnZoowJhRU8xNsKayeWetEWklvclmzZEQeXk8biLIlSXlOXzG
	Q/KkL/GQSgaVHdrZdtjlbbZkL3FgcdsY6TyWLZcRCotD5OTvaU2R2vVv7wOwcNYQ
	4h6FhYubvyXPEB3NgIczH4tMaqNMpxqCfkTE99LHZEwSBFSUDh9xN4068fLbo4Xp
	aNmMauo3iVaon1sFj8G++LY4L3JhbmfQNRMislsZwv1q9o3jOe0abZBJDZtFzvu3
	c/gKxKqXHl2uHFKXo2buQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790959814; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:B7HbC0K3G/MNs4FWxA7mLCK8P9/8tQVXtDqXCWts4ocvPrj
	prMn4vDR5ywdfpsZhxAlTzoWMq4ek0mqXrhQxqA1H3nlpjov0tn5OC82Vsnq3bqx
	uBbVN1GGW3YBj0yYNpcwcYVJ8tCaLP5gPYYWfkr48spXAuAzdcO3wQhkMBxBmAEb
	avZR5s/a2YZSP0Zp4p6gyom0PSR3j1MtDhHbMtj17zFdo17L+deRhs1w4vdEi+ni
	cXnj7qBHXC3iaUnLrrDppG+t8Nm12Ew8REenciKX47Ta15PSEv6AdFtsi5x245Xo
	qLuREMUZIW9Yu37E7cGm/2PV0a1DsigCpnh85Cw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:vpF0zGV6twS99St3YTdGj7njy7z/An8k8vgiv6XRtjI=:CxOxUyJTcyDLJwrp1dk9mVcCvf0lG6uAAy9jIvKWrcc=;
X-ME-Sender: <xms:xeC_agE3A4h-cGviXLAhpl2ZDs3cJQsArXP8e4BqTg6OcCUDhfuOVQ>
    <xme:xeC_agM44nr9VZ238TlcemAX9ICjsexW8SMnPNH_8H8yLETKDUZmDysLI4-2b--GU
    hp9XosDwbY2ACUyA8WkkB4ezKlhzOsDXyfW-dyen9M3HENE_CgFVIQ>
X-ME-Received: <xmr:xeC_aicee3AY6Au-SD3ghQOMRZacXT1yqK2D4gyT2sg9oQg32KCw8WtyBMaiPKUNk4G3K6o9nFwYoUauLCJ_6M3L4oPKI6B46HHq>
X-ME-Proxy-Cause: dmFkZTExO6pnyJ9gNTESC1ZFDvNK0GD/folppKR/YCbXrqFjWO2bHyy0nHnxgdrgiIw6R+
    pN+TiDlR3W6xnLZh+gAfFVtlJdWTsgx2Lbe4jdNgB+CK7V+GxL9rBsBqgA7WP80DYtcndH
    GqeWNiGSI3FE2MP1donEIF1bWJXrPXbpIpkuqUWaQyhgZAik2uiBzWW4aZOR/rVPS2zHHR
    hLtPnN4+N2J1SavtvofRZvIxq52bpdz7c9YMAqeBqYVa6dm5VHMGPeUzygQs9oCVlIezsk
    Ao5rCl2/aReySxZivWbFLskBE1qi0VPHWBnzc8zsdZUJHEdfzmCkJgPfeAxCiKizJ3iOAm
    WjmFjXPSRTZn9IxblfITeZl3KSHlm7OfbQaLTHIlOXxy2TpfRZAtX0mE8jOeNz/sx7Yzqw
    qZoF6mu0cug2Es2JPl/ey73Pw9xn6CAicYF4wF6HGNinc5HkMcyP+lDGfa8xXrZt8V+GAY
    YCfqQBS7fTRgeORkyiXqkN31srbsj6NSPfZDJiZUFXcVwr5C1XFBpqZOM5ENca7YgX+ud/
    Thya+r+mN0148wHqBAP6B8tCfaRxPDUgBtmJz/HoR7uPggpdr2yGY6oULzh/W5JmbaaWjA
    ARKLNATbo5zYR+kErNAh8KDsuGFAZ4xtxQ3tag4BQo9oc88LGikRQEt2N+Dg
X-ME-Proxy: <xmx:xeC_atsKGKWiT9aZ9Z-XzpGte2fxvhSIbjKbp_DQI9y4nB9k9RrxhQ>
    <xmx:xeC_ajke9wVIC8IoJin70D8U6mtsE7g7um8COJBlZoGAdin-k8zYtQ>
    <xmx:xeC_avxt5904_hNFVEylE2pX4iyn6f-wV3KlAWvrXNOxlgYimIrMkg>
    <xmx:xeC_alOE46roI5tq1-B8UkGU4tZ6R9unM0whyEAaottODrr9BvmorA>
    <xmx:xuC_as9s4wCZBSW_tSOHDZMIN65qP72iTmoOHVluuFMgybQmoOsz5jwB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 12:50:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  "D .
 Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 1/2] format-patch: simplify get_notes_arg parameters
In-Reply-To: <V3_simplify_params.d3a@m5gid.xyz>
	(kristofferhaugsbakk@fastmail.com's message of "Fri, 2 Oct 2026
	12:56:38 +0200")
References: <CV_format-patch_learn_--range-diff-notes.c57@msgid.xyz>
	<V3_CV_format-patch_learn_--range-diff-notes.d39@m5gid.xyz>
	<V3_simplify_params.d3a@m5gid.xyz>
Date: Fri, 02 Oct 2026 09:50:12 -0700
Message-ID: <xmqqtsn4xd17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> 85bd88a7 (revision: add rdiff_log_arg to rev_info, 2025-09-25) added
> `rdiff_log_arg` to `struct rev_info`. I changed `get_notes_arg` by
> simply replacing the first argument with an access on this struct
> member. But the second argument was already `struct rev_info`. So I
> should have just simplified to *only* passing that parameter. Let’s do
> that now.

The readers do not necessarily want to read the "author's journey"
narrative in log messages.  Let's be more detached and objective,
like

  85bd88a7e8 (revision: add rdiff_log_arg to rev_info, 2025-09-25)
  updated get_notes_args() to push into rev->rdiff_log_arg instead
  of an explicit strvec, but left the rev argument as the second
  parameter and strvec *arg as the first. Simplify the signature of
  get_notes_args() to take only struct rev_info *rev, dropping the
  redundant strvec *arg parameter.

perhaps?

> Now is also a good time to format this `for_each...` line since it’s
> gotten quite long.
>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (testing):
>     just compile tested

The code change looks good.  As long as this stays as a static helper
function, this is not a loss of flexibility but a simplification of
the calling convention.

>  builtin/log.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 350b35c5563..560af00e2fd 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1333,16 +1333,18 @@ static int get_notes_refs(struct string_list_item *item, void *arg)
>  	return 0;
>  }
>  
> -static void get_notes_args(struct strvec *arg, struct rev_info *rev)
> +static void get_notes_args(struct rev_info *rev)
>  {
>  	if (!rev->show_notes) {
> -		strvec_push(arg, "--no-notes");
> +		strvec_push(&rev->rdiff_log_arg, "--no-notes");
>  	} else if (rev->notes_opt.use_default_notes > 0 ||
>  		   (rev->notes_opt.use_default_notes == -1 &&
>  		    !rev->notes_opt.extra_notes_refs.nr)) {
> -		strvec_push(arg, "--notes");
> +		strvec_push(&rev->rdiff_log_arg, "--notes");
>  	} else {
> -		for_each_string_list(&rev->notes_opt.extra_notes_refs, get_notes_refs, arg);
> +		for_each_string_list(&rev->notes_opt.extra_notes_refs,
> +				     get_notes_refs,
> +				     &rev->rdiff_log_arg);
>  	}
>  }
>  
> @@ -2404,7 +2406,7 @@ int cmd_format_patch(int argc,
>  		rev.rdiff_title = diff_title(&rdiff_title, reroll_count,
>  					     _("Range-diff:"),
>  					     _("Range-diff against v%d:"));
> -		get_notes_args(&(rev.rdiff_log_arg), &rev);
> +		get_notes_args(&rev);
>  	}
>  
>  	/*
