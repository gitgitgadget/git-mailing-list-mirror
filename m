Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4A3BBFAF
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 07:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508464; cv=none; b=kbfYZSU6rRWOKdnvmW909ZEDxeI4vFdSwgDdOl5MVCsNXphKtDxAJaES9L+nNYqWCQF5Fnx+UkdK/psMZlUcaDd75STPU5Kbe1PnYBaxHSJZRSuUcj3XEs+8/hMfp4lYwYfvActDwQMtsuLkCCIlFGQdayuB1WwnDcu4HX9A3MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508464; c=relaxed/simple;
	bh=8MoqUTatCA75KStsLUXqeoIe5B2gO1kvQ9trybMcHUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDWgkYwd7ujaAeYBnd+QaRMiG+WCeT/Nj68DpXsNAlnnFx/zyDLuotew+2asa9uf+LKlHq0APavdWCredShZMrdlFoOVCJ+SvkPaQf6Jo8NchnZMTIUocWCK3snBPCK6gIdUHpXGjQY2FgvI82HLh5GjwNtATMi5kkBlWz+E8M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WNggFOtX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQE8JNv7; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WNggFOtX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQE8JNv7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 22ADB1D0012D;
	Mon, 15 Jun 2026 03:27:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 03:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781508461;
	 x=1781594861; bh=3S/eSIMfvGSC6p/6Dsh1OVkVdy2pC/+fri1TCGOwri4=; b=
	WNggFOtX6dzQkxr6b1WVXFNXbB3K4GvHJAdHiNVK+XyJFFQVepT9AZpoQtIFZHgM
	Pgut7xdkM9lAM7u3C6eUNC3S8RwCxe0kBbLXuEO+vxxXacX08oKUcuDduUdhPDCN
	NSq748XGPcfSWDqtBmeM9SIHGuO6kK6rSNto8lBsUMRJwiLlPMBjyApskcrpa0qT
	HVG98PNJmfyGzgrcHmWgCCub5mR/9IaOYGtI60ljb/slc3jXE5o4g1x/iEEKSEsx
	y1lbeSEKgdCergKlkPG4H/kKP6toLrtcMA4qcDSUSULPPsWAbitDZ6W+S/7wZcyH
	oJ3boZtVaVBcQWwd+i9dTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781508461; x=
	1781594861; bh=3S/eSIMfvGSC6p/6Dsh1OVkVdy2pC/+fri1TCGOwri4=; b=h
	QE8JNv7cgfQDQAdJr288YXDHmQ7kbalyP2A1RyJGkpKUncSCYWQEN0al3lIVo7ex
	mESohSrnePi/9MOKfJUR0d57Aet3yAtnDro4eUNktY30v+Y2DSzXpi58AKu9JGhh
	6F/m9WB9po0srfsyQ99mbFZ8N7zTe4WoLkwUt7T2gfS+y6/SG40IOgE8rzTUuNJo
	kgkzAdV/oXsvJUtWpIGlq1Wcc4A1iJ3v64vW8+hG65U3PsGkCkI+DVOA3jZjMv3O
	MNQxULv/dB+kGOVDGqvfY8Q30hnhCDdf5YzIGO5lsidZn3kwK2YivLejfFpnSBKB
	vdych2euVZO8jVHA5j2ag==
X-ME-Sender: <xms:bakvahQf4Ct4v9TZqMx-9WBa4DWdq7PKfzLsVdYLyTIt44RIRET-KA>
    <xme:bakvagzTXOEDWJRm8G5EgMxn9ejX5h0__MFWaavo0pBEXO5EduwxnUS1Q93yyBEU9
    -C9xVqdVg9Agk6Zfr5mdS2QbWD2JZXwcJ51yV_dkrGjinFOes5mOw>
X-ME-Received: <xmr:bakvakeae4Uw7wWdetjJxRjfAJUaobplN8SJprNkDq5Ih0rX9LLmPv0QJm4LqKCKwR7249aGEfhlmyEiD36NoMlXHvPC7wzb9rSJgsfCrw>
X-ME-Proxy-Cause: dmFkZTGruqCZgYTaM2pVzpf1TVtPlQYNxKBnuzyWkmWb4IlQdcavRbBPuFrEoMRym2hIkG
    E6eVUjhnAcez/LLO4FOdztS9E0ssG+RsNPzasqFkJgDZJYnCMwrJn+K1V0P31Rvx5qu1k3
    v4c7SmAzpacLRKB/+NSoupjSGZpFJ1aWiZzfCTYcQI1a5q6i6odrylzjJcjhIrMLtZ1L1G
    JsRfV5L4lJcWtC7xZaIRuuuTWp6rRUjVgxhPtUjLeLBI8itOqYXDXjFCLx7nA4giWknErJ
    eHkf28Hdft5Y2FoA1GNGfTZbCvoHx0OZvBRal8X8XkY9ZSyIh/nZ1fNoi5PR0RsCBkoJj7
    mWqQk2YIbpx8JlMgVAENNiebfvUeVNA1wGcwiUxa7Yv5OEjzw33sGj1ly5hnwv4Ci/oerP
    2hPkTIotR+kZl8gYdfxMsl5dNLmkEc1KE0M5M0NLHrK3VpPCie3kFYZhyMRGBnF/ZkfEqH
    jeCv59dpsBROUn+PQfz5DsgHk6pLwP1EOp0NpQDTXXvdOxnz46TYoynMXtLErXpCiTcgDY
    1nQT6QHx82WLSGZjV/OdSTT7L74R9S9AGmY/o7WdiQkMnZ4mYIFn3PI//blIrFjGFE2e1v
    uV/Dv1jcR6N+kRz0uX6brGKtOnNf8k7tc9MC1iV98UxQzg0/gcQw7E8EZAwg
X-ME-Proxy: <xmx:bakvakLDitUz5xAmCMRvFuIEMrLEZ9fJHZvxSfELmurmeieHnjHIkg>
    <xmx:bakvatHsIL420zL6EDBkUi94RfUGHUNWmqJI0qMOL-U28KJc8OPKmg>
    <xmx:bakvamqGDLVr-wDadGJgYupzwknj36aSunfiLSjUTDXyK-8jmlFJuA>
    <xmx:bakvauQpZQhjNC_mVgO5WrDvx2WyUV-roRGLO8tUoyve5G1FA5FTiA>
    <xmx:bakvakpHNtJviMsUROeysBzWCr3HPBYeg9p_7lOYzgbAXM6YLVQl5yjN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 03:27:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b64c6e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 07:27:39 +0000 (UTC)
Date: Mon, 15 Jun 2026 09:27:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] cat-file: speed up default format
Message-ID: <ai-paIFWuVzQ_yx_@pks.im>
References: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>

On Sun, Jun 14, 2026 at 06:28:34PM +0200, René Scharfe wrote:
> eb54a3391b (cat-file: skip expanding default format, 2022-03-15) added
> special handling for the default batch format.  In the meantime it has
> fallen behind the code path for handling arbitrary formats.  Bring it up
> to speed by using the new and more efficient strbuf_add_oid_hex() and
> strbuf_add_uint() instead of strbuf_addf():
> 
> Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype) %(objectsize)'
>   Time (mean ± σ):      1.051 s ±  0.003 s    [User: 1.027 s, System: 0.023 s]
>   Range (min … max):    1.049 s …  1.058 s    10 runs
> 
> Benchmark 2: ./git_main cat-file --batch-all-objects --batch-check='%(objectname)-%(objecttype)-%(objectsize)'
>   Time (mean ± σ):      1.012 s ±  0.002 s    [User: 0.988 s, System: 0.023 s]
>   Range (min … max):    1.010 s …  1.018 s    10 runs
> 
> Benchmark 3: ./git cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype) %(objectsize)'
>   Time (mean ± σ):     979.0 ms ±   1.1 ms    [User: 954.1 ms, System: 23.2 ms]
>   Range (min … max):   977.7 ms … 980.8 ms    10 runs
> 
> Summary
>   ./git cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype) %(objectsize)' ran
>     1.03 ± 0.00 times faster than ./git_main cat-file --batch-all-objects --batch-check='%(objectname)-%(objecttype)-%(objectsize)'
>     1.07 ± 0.00 times faster than ./git_main cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype) %(objectsize)'

This almost makes me wonder whether it even makes sense to keep around
the handler for the default format. Is a 3% speedup worth the additional
complexity and the need to keep those sites in sync?

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 2b64f8f733..d7f7895e30 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -461,9 +461,12 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  static void print_default_format(struct strbuf *scratch, struct expand_data *data,
>  				 struct batch_options *opt)
>  {
> -	strbuf_addf(scratch, "%s %s %"PRIuMAX"%c", oid_to_hex(&data->oid),
> -		    type_name(data->type),
> -		    (uintmax_t)data->size, opt->output_delim);
> +	strbuf_add_oid_hex(scratch, &data->oid);
> +	strbuf_addch(scratch, ' ');
> +	strbuf_addstr(scratch, type_name(data->type));
> +	strbuf_addch(scratch, ' ');
> +	strbuf_add_uint(scratch, data->size);
> +	strbuf_addch(scratch, opt->output_delim);
>  }

The change itself looks obviously good to me though, thanks!

Patrick
