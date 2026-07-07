Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445C63403F1
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439530; cv=none; b=VVeZTYulIK4GJdyleEYKUD9QLNlCycVOPymluKz3eamFmozJPLtT0Iz44c1yVTxS/lZ+0v0lY7q3jPjF51AU0QBezYvGRSX01MTLkurEE+iDq2HBKvCqOZn/DMJcFLsSrL6mlek1mYaSkI/rojqTzuszaeoQ3nW6et2qDOE9O4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439530; c=relaxed/simple;
	bh=Wo2iE0xsLaCl413dquQYQ3k95xa+6bLrU/RPl7yTApA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQT4fXkqRrcmU8+ZzpkDTipopU4vAyH68aA1uxWrAxO46LXVWPK8a/QlqoL4OYjs8JAj10ny45VqLJHfWix1Jq53U0k6hZ9T/1AzHLH2BzYHphNFdNmSjDepMmEVUIYAT8Me7JlASitnzB9cpkn7IXpj/SDEeCLPniZXGZ/eQLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U0Aw6Fp8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VLVylar8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U0Aw6Fp8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLVylar8"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 416291400151;
	Tue,  7 Jul 2026 11:52:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 07 Jul 2026 11:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783439527; x=1783525927; bh=q0WhVKpv0G
	T8jD0yP+p2Kv3EXi/31EiF1ZyEFVasq14=; b=U0Aw6Fp8bgBkBp0jBNM92Q7DVj
	WrIoJwswivbmlso8yUa+L3BiNzgPILdNBGizY597DOvhkKMIUUOoPm4jFQ1ckW+r
	q09KjPNd6e2sL5zhQwRB0sjy/cy1LZknsn/h8HMjoNMVi3J6bBSP0k5yVww22vsC
	9S9psIcPhA7ejkJSY/SnOVilccwV4XGSPGCJARN3G3tmgif/hQ9tTKtTZa9a83vf
	d02IFe6j+8+GCok2OF18Oyv2+AWBYawlMKrat1DchT/vbt9jrUnntoe6xhcv38t/
	2oiHZbA71/Z/amWDGy/NmbtpU9x5BUyAlvuGe66Q93UYqkW59B4a1q22cnJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783439527; x=1783525927; bh=q0WhVKpv0GT8jD0yP+p2Kv3EXi/31EiF1Zy
	EFVasq14=; b=VLVylar8YTl8PIWiyMPj8yeqTuh8zT4TzQsTrB6b+PHlcRmypEY
	rGrlVMbuhj9BEg0/zL3VXBiiNdF0/oVNHx/xONziAQhWT5h3MjKgOPcHKKMSKhVt
	2CztKtS5IIMsAi0b7Vzrsvj0GA93plioCSCb/kelVrn/x5vJ2o8N3dVU8ETcx1rl
	yeNrk/nLmm41/zfSD9UAHENsE6tSfUYP0SSyK02cEF1Bnaf8uvqkUy/aQ8ZvVYbd
	niyKItHiqhhveNybfU0ZtDk+WFxmHloU2dGC7eyJpU0WZZDHM6QWumoQojm9R/DL
	UFgMI1LzPsJipqutpOWeNGBFOgYtj7SHCZA==
X-ME-Sender: <xms:pyBNasFvFq5lTA-jDhw4WVd5IjXXuLmVaanxtY0DsCI1PFzMuQ2ogQ>
    <xme:pyBNaokDX-Cb3drGio2oqvv0RN-uvgX_RjbJDF-IavAAjzvR2Y0h1-rF-kqh0TOqI
    YBvXGkLVLe9bzvOivHGzQM_BBcBGI6tInELBffuMfLHuENcPl7k>
X-ME-Received: <xmr:pyBNavkauN7yXrwYye1g30fssZIyDbzKQFvjs_2DJ5ivGUk9UBaJKubg6JT06DlCxcGDXFe1_RNy9KfLpo1jN-KBG5ZAm1TjmAp-aUJneg>
X-ME-Proxy-Cause: dmFkZTFIReUjLzwQYD0Szvd1xy7Z/pw7Q+XXXUZ92t0GoJklyVA4WdCmyvb6jXx9eKD7NS
    LL9ElxhBtBTm4UEusfB7wuO6IHVq0VidUzBo6F2icn3v8KXAIDiuXWdCMH32Bp6D/aiMJI
    mEvNNfOr/oJkTWrHZo0cWWQwuJGvLqNhud7Ko/fYB+gkp+QnJXYfSftJwR8JbippLSswk1
    xEt/A97Vgv7tiGgORbBof30yfV1T8HNnN/qLF4tzC5fgVRKwyzK8c4bADpIGw8LDhMEO00
    8+m8DOQJbdaLd8Z6jOme9hfLGdl5RSZhrVFZWVKSELiEY847amObccphoSLoB30QkOlqh3
    LiVAu8Rk87vV8KuL43CeBugQYn+bOJqtjcEKlHG4jYrNmNYLOITTiFTVbuAl0FFId9ckZs
    9qYDbkACf2WXAQPOPABG0Z6AaPxp6l6XN8dcrlYjfIXa3np0Jg4eVOHtqCI7jir8auqyka
    Lg8qPxDepeTIDYdC2tjLo3EhO3DJbgSwg+TUP4UTNj2BVzr8h/TDNZSatrCMZp+b66ByWN
    BaOcuU5JLhJ5giCs6ucHBxn0C02WKqzVSDmgM2mCJRC8Esqv7YFfMpcv2mt5vK5lxo3pQZ
    8EsuqVtBLj3k08nTmJk6TcCysya839aBznxoYQ1zS3JASHr/EOWCQ1H5fOOQ
X-ME-Proxy: <xmx:pyBNaputjHJnU_5MRNbO_MJ6u-bxfnkRIig-GKdTIii-naoBkf1OFg>
    <xmx:pyBNaimuVKkZassiAQvjZM60WFuthOcPTSSEMY7ze_tuFXzt0nkRRg>
    <xmx:pyBNaksHJrd315us_DcuxbjdqEmAKZYtI7LJSVF9-0HJuYDANRh0aQ>
    <xmx:pyBNaoc9EUwJMBBKXhu4f1ZaVrmkpQqk3LVtnUmtplXc64hNsVcteg>
    <xmx:pyBNaq0aoVPIfgZunkIFtyH9PRF3cExAQwVzHjEDVk-7MW8_LKeyUD-G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jul 2026 11:52:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6f8d4eb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jul 2026 15:52:04 +0000 (UTC)
Date: Tue, 7 Jul 2026 17:52:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 07/12] submodule: fix cwd leak in
 `get_superproject_working_tree()`
Message-ID: <ak0goVzo1oNMTlO5@pks.im>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
 <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
 <5397ea785c6da50e977598a35d03af82cb2a5e4d.1783239870.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5397ea785c6da50e977598a35d03af82cb2a5e4d.1783239870.git.gitgitgadget@gmail.com>

On Sun, Jul 05, 2026 at 08:24:24AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/submodule.c b/submodule.c
> index fd91201a92..92dfb0fc2d 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2627,13 +2627,12 @@ int get_superproject_working_tree(struct strbuf *buf)
>  		 * We might have a superproject, but it is harder
>  		 * to determine.
>  		 */
> -		return 0;
> +		goto out;
>  
>  	if (!strbuf_realpath(&one_up, "../", 0))
> -		return 0;
> +		goto out;
>  
>  	subpath = relative_path(cwd, one_up.buf, &sb);
> -	strbuf_release(&one_up);
>  
>  	prepare_submodule_repo_env(&cp.env);
>  	strvec_pop(&cp.env);

Right. `ret` is already zero-initialized at the beginning of the
function, so it's fine to just `goto out` here.

> @@ -2678,20 +2677,22 @@ int get_superproject_working_tree(struct strbuf *buf)
>  		ret = 1;
>  		free(super_wt);
>  	}
> -	free(cwd);
> -	strbuf_release(&sb);
>  
>  	code = finish_command(&cp);
>  
>  	if (code == 128)
>  		/* '../' is not a git repository */
> -		return 0;
> -	if (code == 0 && len == 0)
> +		ret = 0;
> +	else if (code == 0 && len == 0)
>  		/* There is an unrelated git repository at '../' */
> -		return 0;
> -	if (code)
> +		ret = 0;
> +	else if (code)
>  		die(_("ls-tree returned unexpected return code %d"), code);

The diff is a bit hard to read as we also convert this to use `else if`,
but overall the end result is easier to reason about.

> +out:
> +	strbuf_release(&sb);
> +	strbuf_release(&one_up);
> +	free(cwd);
>  	return ret;
>  }

All of these variables are always initialized, so this change looks good
to me.

Thanks!

Patrick
