Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427963CAA55
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 19:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791833055; cv=none; b=sh/DAD/q8oHIiTdDSWlNRDKKLcbqa0aHNZ45UXYqTiabHyPL8d45KUkH4dXT5nPzdigw4W4ESfG6uWMZN3uxrYyYzm5npnCq8hrCExINsNW23sZhCAHX5V1LRbFa7ofmx6beJPVLi6Xnb5QgyM4RWtLw3uDCS8w0XaK0b7O7AC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791833055; c=relaxed/simple;
	bh=Rviq167fdJzyvGJO5wFct3GfO1+tklv1BH4ZMFN4n9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nwCIId9DydU6bsBuFvBBbkMJcjePebnIdaBQBeI5IF5u9ZGZzCa/n+v2gfufSUPnWec/3bfAuq6hBayfWl7db79UDOdF338ILLMN2cfT7+wwLCQ5CPO6/gNECLafnHHP899Ju3knrbidzYdlmi6y0V8HNtn/No81KL6Q9+6DZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yl0Kzd36; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ay8bC8Jh; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yl0Kzd36";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ay8bC8Jh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 349C7EC084A
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 15:24:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 12 Oct 2026 15:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791833053; x=1791919453; bh=CQjVutDqmn
	nqocIP30LOJJTanCFueTOnti/NcIU4nTU=; b=Yl0Kzd36QqxXuKZ6qRyPFG84w+
	iTI3A215TF5rMFuq8jSOsS/wt6XVtDpkGYJLjZyHA6tlG8AF+u+ntUejp/NBwygr
	NHAISa3MXzOEsSqf8+PKjMaGpmfcUev1drVzQziZF69ovQJa12KlY8TZ/WuTlrLN
	DWFXCKymMAzY4Nh851HaJcm358uZr+P+B1NWA5C/mSOX61ja4SQCI3CUFmq22wTQ
	cRlV0glviLs3BcsrlArTp8p3vvgttigeF2B2fS1ynMLKv8FJzUhbJenLp/ADkqIJ
	jOpjyOCVtO4rXWu8ThNsuD/jN8B4Os5t0Qs8q2+DBExRHeEe+uj63lfM7xcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791833053; x=1791919453; bh=CQjVutDqmnnqocIP30LOJJTanCFueTOnti/
	NcIU4nTU=; b=Ay8bC8Jhr2KqACpuupVFnHaE2GMiw5s1RqFFcU4ifwfrhTDkioJ
	febkFO7fKBj+7RdUoZbjjRovqhJ21FyWOpdJu77ugj4TbnBjVtiiu30Qs569mbGn
	EFUG3pOK4NtSh9ome7nLkdKBEegDjstiAsqXS7ryFbZxnIlkrxjnq5iUrcteeHoN
	3YQm0VRi54oqAyulTb/xv3DCRp9JEcHvelw05dKGWMULB6FgYJdIvRBLXZIx4VJa
	mR7IT7SP3lgcpIhQPBTbBkwRdtgIXJ+CPHvwwvlXyfoOX6T9YcsXMWQ3oFPo5fTL
	jof7jU5r7v8NxK882Pf9FRhYk82+FIsLKvw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791833053; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:O/8w7ISWQ5NgnS1b++ToOYT8bCGzz9sY1vPRho+E7xunfUg
	isMJIng7oUX7bY76YYc58FnCSWuWOgf/qzTfgTHYIjC8q26BjeNI+yRa5DBIuERS
	YXoqYAqUQofjNGx6LWLLB2HcmfDwutAPIXukrwWPi5TlKUF/2frGvFHE13F0ZDBX
	CN1iOHmx7No1hUgGpfgSnz0IEfEkJAMcaUzpFLOxO0KSa3RzCsKy8uzfgQnhvqUa
	NArf9knL7beaJ5DzLnxLX/fimyedaP6/5JBUZPVU18BMXQklb52szf/D39ZoHhdV
	vxgrlj6nTpSmAQU3TbZ94dZwbyCJBdA+TlEy5Iw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QIJde/n6FLc7Qj0p63B2JeEQ/Orpemu3IG77wl9fliI=:Rviq167fdJzyvGJO5wFct3GfO1+tklv1BH4ZMFN4n9w=;
X-ME-Sender: <xms:3TPNag2HwbBRua7lbpIqqsT1k1o9NX0YeRh_G7nR0WKtBtjRlKT_Fw>
    <xme:3TPNauxvKd-EHBnRwgPV3TC08MZ8aDUimmbjLzfppUadoyFEH9jSdVjvD0GkS5Df_
    NL0ZnehhpZd92ADi0FPNLcpiFIa7sfPYo8i74s5T8HwYtGFqUgIFYM>
X-ME-Received: <xmr:3TPNaisKhl2d28e35FzGKM8vC7FNTGT9mHIfLRxY-5QB99loLbBkhNxspMeqeEkGTf6SoB6TiW4bo0WlGzdsYOUccaMBr1cjBl9D>
X-ME-Proxy-Cause: dmFkZTEjqq/7hcbtL/q53nsBua0CeWcnX4a0Z7QUmjUFjfdMXNbV999halqZzIMI+LG1Nq
    FJRbAkVTibB/09EJKlDDQYDAchvZhe6q3JmxymcvGRe+h3jNrC59wlEEiGV9dh5kxXWp7U
    eXqzWQaFhDT8x49PupeeoCuqTdLsfdjFz/IgiIoHWjCLnu/VtAm2qyyXV1cOhiUuK/BsQL
    H/p0I5x9/R90FwhXfkZWTTu/yMus7AxkOGBL1pN6wxJIGszwZdxC3D4YblI2LXWsSgvmE3
    yeXr1cT+4rdUibjBSfw8lKuNvJCm7joTaCSpJ+b1mikGLzv/gi02bGCKdR2gEEgKWFBuE6
    1QKTlfqvc588InUC+1j5cm0joME5+Li/ztQPNQcq15D+Sm/KMxC7UpXpGjDb34YziT7HUz
    extjozv66CaChlGwZwwke7Jly7qtFPJkzysqpiNV0DTYxE8cR90whf7W9oCDe7XkobteI6
    gFRwLCzzmK4EIg68fV84sGtLi0ZX87ieS1b563nF+zpIN9o+jwWAY8oH1j28Zy7RzskwXE
    9Kk2NlWj814ZPMDxIbyOQJ4Yv43mu4ITCgXaqjN6+gvyObSrcqCxIBE0lUqimjMVjHTcbA
    ZDTCOh43kU321bsINCZwuBcWwQzXTvLIgYSjO1l+DbFJcycxXiY0snKiWEKA
X-ME-Proxy: <xmx:3TPNagxmxsxJXItyU9l8OtzESSPa17EDXzSKk3vLT8NKvJz-4jP8EQ>
    <xmx:3TPNalAKrlFjSOYUvveeM4DGNX0_NS-HDXQhDBglTQlaonAz3VwrVg>
    <xmx:3TPNaudiTpXlhSTpKtFyX4ej1tO0Bx7UqcmSBQeeggR9O1tJpUk7TQ>
    <xmx:3TPNavkcOIytAx5aR2zxe1Y93Sfxrzevd7_p-W0JSL6deVMYj9Ujng>
    <xmx:3TPNalA0PEnad_JdrgJAmRTnRPeEbwmV4Xb0wwlyR3md8Bqt7eOSNQUq>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 15:24:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Isabella Caselli <bellacaselli20@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Ignacio Encinas <ignacio@iencinas.com>
Subject: Re: [PATCH 3/3] config: learn the "hostname:" includeIf condition
In-Reply-To: <20261012015846.2649843-4-bellacaselli20@gmail.com> (Isabella
	Caselli's message of "Sun, 11 Oct 2026 22:58:46 -0300")
References: <CAK4AdTSnaAOk649a0GLe1M9C+cYuDa0Nwo54=HT47R53Q4ZdWw@mail.gmail.com>
	<20261012015846.2649843-1-bellacaselli20@gmail.com>
	<20261012015846.2649843-4-bellacaselli20@gmail.com>
Date: Mon, 12 Oct 2026 12:24:10 -0700
Message-ID: <xmqqa4oi67tx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Isabella Caselli <bellacaselli20@gmail.com> writes:

> +static int include_by_hostname(const char *cond, size_t cond_len)
> +{
> +	int ret;
> +	char my_host[HOST_NAME_MAX + 1];
> +	char *pattern;
> +
> +	if (xgethostname(my_host, sizeof(my_host)))
> +		return 0;
> +
> +	pattern = xmemdupz(cond, cond_len);
> +	ret = !wildmatch(pattern, my_host, 0);
> +	free(pattern);
> +	return ret;
> +}
> +
>  static int add_remote_url(const char *var, const char *value,
>  			  const struct config_context *ctx UNUSED, void *data)
>  {
> @@ -411,6 +426,8 @@ static int include_condition_is_true(const struct key_value_info *kvi,
>  	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
>  				   &cond_len))
>  		return include_by_remote_url(inc, cond, cond_len);
> +	else if (skip_prefix_mem(cond, cond_len, "hostname:", &cond, &cond_len))
> +		return include_by_hostname(cond, cond_len);

Neat.  With this include_condition_is_true() helper, adding such
conditional inclusion is made very easy.  Quite nice.

