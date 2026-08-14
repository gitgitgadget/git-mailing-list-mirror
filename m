Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9863027AC45
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725498; cv=none; b=og0paFGU9kob0pP4u8S/akzTwsbExJd3o1bmv3976YF+c7d4E4vi3X4j0uCeLHjBswOS0eN443HN16618bLIz2SuZqxaKrLp2XjeRxqUu8ggUVsPk7FF+pfR/f5g1xandnl001n42+ho7d3BUdj7WfYXEWfnvSC6zGxdZ4m6BaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725498; c=relaxed/simple;
	bh=Y+2iQgAnLNrDrbB/B455gWLDOlLV6cLDwnL83Pnbqa4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WMhPkvDEhXjCr1zzMsrmPmIVaozfEbzgFzvOGMMiSIZZzTScAuXbzKn+DNd4DTciIqhG7Q03y0QE8M2fDg8PZXRFV85fVHud3iME6+Z4lwKwYCVZstAEx8rDp8eOsH79T4AzIEjtwlKGu15w1GZKFvifcWO9YWdDy/cr47UDRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZhzmColE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hq3UDgh+; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZhzmColE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hq3UDgh+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9ECED1400093;
	Fri, 14 Aug 2026 12:38:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 14 Aug 2026 12:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786725496; x=1786811896; bh=YZBFVH256J
	ykhhaIlCKneAq37y0/Vsh5+LERqCKe78s=; b=ZhzmColEQ0o8FUN8Sk8dtOs/rU
	3+LL6N18Qqd+ZQ9QG0ORe2qYkd6BOBQAS7EVEokAEF6TEK67rDVYjbjca6veO3Rk
	JJM1ypu4f7LW5/cSFr93Eae19w5ijZnsoGW89AWiadO38jyts9MJpgIDOwlMEY0t
	FDbHBAlXROXW8+/ATMZpEhqY2FIF21EG1mBbYO7g/G7ie9T9tLlRnnYnGC1wt5Hn
	4YyUQvCCSifwIYceuq994MMCdEWuXTqDKcogerRID+EQkCvbeL+Usi7YBozsBVtq
	9UC5hn81lpmqBuiZZUnHD4vADrPnB3jGiaOH7N6rNOJrLgPzg76WUi6f6lPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786725496; x=1786811896; bh=YZBFVH256JykhhaIlCKneAq37y0/Vsh5+LE
	RqCKe78s=; b=hq3UDgh+NOb35bxS/RMVIYE43IClxqbcuaIwsvcXRM4/m0zQaAi
	cMYTprwCbvqkVwSX4moucZWp/Bj5fIKBQFvRk39ARl/cC+ckK3IqDg8r9Uupiw13
	y1dtF7OHp78Zb3tK0IiUVjqbPPjZBspgyFPvqmoxiAkv2jQJvv9PDKJDizKkOgzo
	DSoWIVYpJsFFHW8OGeqYQNURIE1kqOTWRtNa1Nai1NdHgDRe91Gs2yN8p629Xtza
	pBp+ZKQs85D8F1ImJwyZPL3EXlWDAkowlZteogStNS7t5gMkRTsf4kjRJKAxN4KU
	bk4Pd5IM6dHNzH6Q6tKacQG5Pp+hyfQ9xHw==
X-ME-Sender: <xms:eER_akQXJ38ZSPZrAvVRx7i2uD9lVDtt3pe2eD9KtekWp_19KOF9BA>
    <xme:eER_avXbf5gnzbil7IqJ3gAKJ2LYiMUOIMaxzWw6nVa14HA6dSaSSiVGM1Vc2WNrZ
    wJR3dtr5ruKQwxHYR4dowcmt3-UO0G35PDcEBuW7QhZOXjH72PAEEQ>
X-ME-Received: <xmr:eER_aoQzmpgg0qDTXcsoyNm_Biyi8xhekmYAn18JBrpWigI4NFWSYML4BuXtLHQk_tgaAlIOdb5c7On07JsLUUgm0q5jv4Ll0g>
X-ME-Proxy-Cause: dmFkZTGqgyFb+ApVOnyMXQv9ZmZNoJ5LPGmmH/H82biaT2mGyYV+a0O+SfzGnXnUpGhJ8r
    pPhpnN7s0bwdGGC4oWues4fYo4QEanDn5GCaWzAkvkGkR8x2TpgioYxQAcCJbCo0zmeG4n
    PyUhcz6/kVLBq2E5PZlpMrVPjmQf36pXnglpWfy4m4A7JevxRr6FQbYevuLVtk7/18GERC
    z3ZiuHTWw56x3bekJdbwOybmshB5RENoKH9bN6hfLNWzUa+2lBDVUq9ShoY5Lki93jmubh
    rn1qkuasm88KyOVdhcWLluhj2/bhtBDnbXHtXJMJ6U+vVSif39vWbvseWlYR4BFOZepSYy
    Z+gXcxlNvVpmGN+D359C4Q+4gpBi9DWZC2luFxslewdesDSf2kS+DMZhO+tLYTzP56ilRA
    oDxMezN11tSsHk34Z2IFxO4Rv6sMzNJ+OOK593G/pqScWAQRD2chAFU4n3m6PFKvWz9GNp
    Q9gRHjt8UeB04ihgttTBIDMn+eDwD/p94S9GCMeXxKaIojJgmL7Q/T6C61hFEQr/YOdq6q
    +IjgPB1eNiUisu3/lTV4S7BpZgcSnswUQVykpFDGN7mwQy/S6qVFbq9eV0baI8c/mVC9k1
    TzWrPaQIC6Rk7rxEsXhsitS3lu2Z+D3gBW1s/+C9P4lhUTX3ECmTC+HsOm2Q
X-ME-Proxy: <xmx:eER_aplbVcE_qiGwlL3G6wNJWhlhWWKjlyexhdvZVDAngSYO8BqoaQ>
    <xmx:eER_au7V_HJQ6ujD2ES8qvrGCZHetotowuz1sRH8gzQzUra6uCtTzA>
    <xmx:eER_avhFHS1fyTKeUFmlJmMdRA4kvQZSH-0wWQ9VmY7YXTb_B2VKVQ>
    <xmx:eER_arGVXKGkY2iEyBvDdEAoRV51zllDVFuQ7ZAC9nkOZSYCsArE3Q>
    <xmx:eER_aqUN6omxHu8Ck682atWifIJUbBsAPbsyBP9e994CziwoYvNomBLF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 12:38:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Todd Zullinger <tmz@pobox.com>,  Tian Yuchen
 <cat@malon.dev>,  Olamide Caleb Bello <belkid98@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/3] core: convert build-time USE_NSEC into runtime
 core.useNanosec
In-Reply-To: <2d1424732af6af9c82c775e8256ea914204e8e43.1786710807.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Fri, 14 Aug 2026 08:34:02 -0400")
References: <cover.1786103607.git.ben.knoble@gmail.com>
	<cover.1786710807.git.ben.knoble@gmail.com>
	<2d1424732af6af9c82c775e8256ea914204e8e43.1786710807.git.ben.knoble@gmail.com>
Date: Fri, 14 Aug 2026 09:38:15 -0700
Message-ID: <xmqqzeyoodxk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> -#ifdef USE_NSEC
> -	if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
> -		changed |= MTIME_CHANGED;
> -	if (cfg->trust_ctime && cfg->check_stat &&
> -	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
> -		changed |= CTIME_CHANGED;
> -#endif
> +	if (cfg->use_nanosec) {
> +		if (cfg->check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
> +			changed |= MTIME_CHANGED;
> +		if (cfg->trust_ctime && cfg->check_stat &&
> +		    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
> +			changed |= CTIME_CHANGED;
> +	}
>  
>  	if (cfg->check_stat) {
>  		if (sd->sd_uid != (unsigned int) st->st_uid ||

This is iffy.

If you have core.usenanosec=true in a networked $HOME/.gitconfig
mounted on both USE_NSEC-capable and incapable platforms, what would
ST_CTIME_NSEC() yield on the latter?  I wonder if cfg's
'.use_nanosec' should be force-disabled in NO_NSEC builds, or
something similar?
