Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D7242D7B
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783654868; cv=none; b=nONQpM1zM7diL4XYg1ods36fmTnoy0krE9GoboTAX9qYNslw53XfERWSWkHXRe8v3NiapkhPu4KzMZVfCIm8tAsBEwkSFgzWBhMb/0UntXVWwGJAuaicylZ0tWpwPQLVm/x1O7xYZ2teynCFEA1OMaMx2zPqJnOn8R+IfbexzlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783654868; c=relaxed/simple;
	bh=IXAamxG95Sz2/yMkiAEiOTGedNoDAT7APPeiF2z3DM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jJG2hpcj7bDr4lvoYGv8IL4y0XzLk0kZ6OKwzl5zIRDN1ieLY4FVywI0aP3cBhui5df1nwzGCoq4VbBY8VzMZzkoGAPBexKVsYaNUbVADCzo66SDYZq3m1bJ1166+wpX2VT+eYNZyolMJU8vPrzrMkxEYlo/VxkrGjI6VA9VFk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GJ2cYNqH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ghmT+jhO; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GJ2cYNqH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ghmT+jhO"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 606F97A001D;
	Thu,  9 Jul 2026 23:41:06 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 09 Jul 2026 23:41:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783654866; x=1783741266; bh=dhDcrmQI7U
	W0rmd1JxyrTKj61/km7WXvxYgaZdVnkqA=; b=GJ2cYNqHFPaS4Ncr++psUl8zkR
	9K3btkPjZwkX4ZfSnnaaL9C0Q8nX0jwY/1HCayqhHDGJNVpdDP4e/HHLhuu7YIfb
	cH63mPnOj6wYaYyD61WTGtEQodPaV4NF7URWby9G7Zcimcit4yC2SLv3Cpz5SLud
	JhJCNAUXtOsCzzBw7bfePECQvc5ye3dmpQKJuPayEKhSGutwz8ENo1n+bbt6abQI
	XzoYmt9X50cEa782WkgP9gZYc3thOt2bkLs9rHDNtzNPX4JKIX/cVHhSnyGw4+FU
	y6VuHr5OvG8WQUiA17rnl3+9fQvnjrm8IDvbfrZQblwpzrh+EsnS7KR+zNOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783654866; x=1783741266; bh=dhDcrmQI7UW0rmd1JxyrTKj61/km7WXvxYg
	aZdVnkqA=; b=ghmT+jhOjCAAaLc/GBbBegh0VKsPyVlSudp8MIDqXuFLuN+hojP
	SfCW1sByyn75BlxQPUs1ZRhiop/626wMzHe8H+jMOWRlJUw91BYjgTCDHzfx699o
	LCz2JIMGtnD0P7gxTGwdqIWMt89QOw3/tipA7/3ZeBymP5aUtJxtogC3Ui5kcuED
	5orFnpW2dtcKWbsjRNQG3uaH4ix54jqmonjXhU4XFmBYLikZp+MzHX3OZgLUSGIH
	zdxSPpUjGv6jaTGNoOHLdwbH8K70l/XtMIInFybSwDAFVQNbHtG1aSczlWZvvxAm
	d27A+lc3+Yt/YYcPra3hhpC3inFU0NTzLIQ==
X-ME-Sender: <xms:0mlQaqiewo1TqLWkYhnHLLpRH6N73RPg-TAzKnJLwjWdNkT74E-Rnw>
    <xme:0mlQah5kdUQIrdFmEzTKX2csdZtx1QP15ISGreSoX247P6Jksu9sGoib3HYZ_GOXe
    ZnBFTzjqf5APTtPyp5awOYO0b-3pJEgnZcZSQ9I4fY-OjuCh81axw>
X-ME-Received: <xmr:0mlQaqYnqZBhyDLwvR6pZnUcvkC-aaNG5I2W2Auy-2NNk8K9E7CHERB0OmLJoAlCct3hsVTNe7VZGxfLajFbJCE6vmKj-6xmDBunao4>
X-ME-Proxy-Cause: dmFkZTEr4DJuqNZhm/89b9qPkWGsbx/op1v76Cp4uMIe5wsx5O9ZWPQiUvdik3W8FKvi0N
    2szFeVvg9JOOE22bGnU0QtkHWa+nTDXAGakWLtuNVqUwV6Omj1oON7C6UpbuCrM5j83SOn
    pBEzzT+LYqlnYKV5mquYbnMocWOrT4Q/01UxsmMa1xj386hfYp1PBGS1WMj8LIlvAFQyNB
    uHCsT0QFnaWENGSPHj5YJWiB60x7To2kzqPEQBUuRYWS6ocxBuB+yDP4LVZfgs0A+YRHI6
    xk99wdld0hGl7y8fS8xVfroHX4h/rZF+DQMiSOzDnXvAKHEHymmpnVnUT7cnrqi3ecSTD/
    tKpyVaBkKbPb0S741Sz2WT3XbSEgciHgE/ToXWoI7uuM9xfiRXb50F4JGFZ5m84ebj5SCZ
    A5wcNb7oEHVWMI+WiejgcCWnD9DPeBzwidaUMY8j3srJQk5ZXvOoQX26SSf15RlrOUim8K
    duOk3Ll9oMeyS2d8LgUVtu+lB6NitIoCIScmYYb5wEcv47bZsreGp4EpJ3La8Al7dXx9+P
    jkot1UOp2OPsTTlcBnNQjiujA9dFg1N0i6saiBJpSUkJrmuNzKldorJ2/aq7rDMoIlL7rz
    9B9cdMXUes0j9nH/BkzsgllvbqijOxH8BEGTjLroCe9ioaFyqEx2xdXSSLAQ
X-ME-Proxy: <xmx:0mlQau4vTpjg6SgNhU52A0O7kF36yNXxExFK4uchNALlq5kfDKCsSg>
    <xmx:0mlQalD51-CNqKomqllu1FAB6siNxtYWrdxcpVtSCLUJUC-3NPzBmQ>
    <xmx:0mlQasdgr_-4sjKn7LRLk85MRT1v_g2kGpkK-aaGuYGSOW1oKvYCCQ>
    <xmx:0mlQasJGTI7ahI1Mper46HF0jED1bM1lHb25zd4gRM8FeaF6kx_KcQ>
    <xmx:0mlQavNKuXgmZ8rfV4TdVm5UI6atkcnoJsQ9vI-wl3mCMsOynOWvHtt8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 23:41:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
    Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 09/11] pack-bitmap: handle missing bitmap for base MIDX
In-Reply-To: <0b27860478a284719755b8ac2386862c1fc3d0e7.1783590159.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Thu, 09 Jul 2026
	09:42:36 +0000")
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<0b27860478a284719755b8ac2386862c1fc3d0e7.1783590159.git.gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 20:41:04 -0700
Message-ID: <xmqqv7anfr5b.fsf@gitster.g>
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

> This can happen in practice with incremental MIDX chains: the base MIDX
> may have been written without `--write-bitmap-index`, or the bitmap may
> have been pruned while the incremental layer's bitmap still references
> it.
>
> Check the return value and go to the cleanup label (which unmaps the
> current bitmap and returns -1) so the caller falls back to non-bitmap
> object enumeration, matching the handling of other bitmap loading
> failures in the same function.

Nicely reasoned.  It would have been nicer to CC those who are more
familiar with the area, though.

Cc'ed Taylor for incremental MIDX expertise just in case.

Thanks.

>
> Pointed out by Coverity.
>
> Assisted-by: Claude Opus 4.6
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  pack-bitmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index e8a82945cc..ca7998c10b 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -523,6 +523,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  
>  	if (midx->base_midx) {
>  		bitmap_git->base = prepare_midx_bitmap_git(midx->base_midx);
> +		if (!bitmap_git->base) {
> +			warning(_("could not open bitmap for base MIDX"));
> +			goto cleanup;
> +		}
>  		bitmap_git->base_nr = bitmap_git->base->base_nr + 1;
>  	} else {
>  		bitmap_git->base_nr = 0;
