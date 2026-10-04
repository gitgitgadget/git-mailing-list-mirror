Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C8239182F
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 13:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791120451; cv=none; b=lsy27JqSxQ+TidOb/luM/oWISGuui5abDF50BmAh5USOSY4e0pStr+2MFE+vcLTE8PTS0L7pjlaX5tUQcM+TgVbTyCgRS/au+ndlsejODqIMuDJ8SkJuVq8HzqYi2xoHC2itjc44qRNXWEdlpkRpzPVwKBY52TtWTZ1inPGe0f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791120451; c=relaxed/simple;
	bh=65ieM8+MQ2wjYZZijYEiHv9C9RWDg7X78JnSplUq7F4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JRJBTGLCk6DU5ll88STOvF7mtAZBFOw7ugHzuGJHDAb0C36XsjP8NCdmTYXhw+PtIdLeYCTFqrijx01Eg4F2wGrg/1pJgTVepqRKkVzmCm/yVpN+rs1qLqeN60mBDCIp3QfM0XzvNiomR3BGWV02iiJOYeBNbNze4Vhb+x3Poto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QcSI9O11; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pYB4dkOS; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QcSI9O11";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pYB4dkOS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 997D41D0013A
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 09:27:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sun, 04 Oct 2026 09:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791120449; x=1791206849; bh=H9yb1zhrsd
	aknyRN+T+PoXrpxSzxFi6bTZBybYarLU0=; b=QcSI9O11Y2nMU8pVnD9ea0yeog
	uI7NKGzR5e8PbAVviYw+5vRqXJ1oE5dNu49rfZaDMW4w1eVY8HCWZ8BMhZgDfRM2
	H+hGH5q18OMMT0eWR8nNO4suTMRhMw9HFYaFtkNEaojibqQ631hKVQwo68MeqV3W
	Jnh6Xg1yC3Bvfs2IstmNhN2puSrWHixwpjsJOeFV3vsOaJb4Lfb69ttNscXbTK51
	+sxb3YgCV9rWw/sauctM0Rqo5a4uldUnbR6dmfFuECHf5PW3HqfktozOHMSNXsP+
	sRZrjcgFcZQmm2Na+PHHN8rFwMqlQBeFggSDNeM9QCJb0tXH205CCz+J5iFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791120449; x=1791206849; bh=H9yb1zhrsdaknyRN+T+PoXrpxSzxFi6bTZB
	ybYarLU0=; b=pYB4dkOSCfuNRaSVpYnTi0uNFA3A3nf/MyKaYKK2EESuxodSkVm
	uVnYU2RTjrblSbiflnGSRhAm/nB29nJDxkPoA/HeihckogPT4IQdPhNVMUddxXXI
	v31GfDyDQeZ870hbHRcv6ae2E7GYYac54yDiLjYj8i9EcAz2qPK9LARpSKgjF+i1
	2sz1ZVJo5RUyEeyEV2sH5jsfAYB3NWr+XIMDvRPHtEpuSL1v3KFwk3mGyebjKPUh
	YcokBLFpocNDdxuUrNCbHuJAjkFtnzSMC6zUovSG+PNQn9+ZnzUZK97LhYoZYRaq
	FcWphUZJeIrAikAV3OQFB3bj0g/+FYSAeGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791120449; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VShbwjDiONeCf97kGzrTVqEcpvl+IR1YKRV5p12BCi90Zt1
	yjRYemtcXFNrDlDxwZBoHrhz+wQYNfdbcgqdF+ZDlLWfjESI86SstCopstYlv9rp
	EVopvHAUb98eTSLdP+ZIkRJKjvZh9nvPobMyDhjapIJS7odDQMaBi+062k7skeuV
	wYyF/BT03P7LgM+CX/rwkkdh3MBfCMKm0SophGgwk09nEyQFL3Ihht6998zuHBd9
	4iNFQlTjSH+VspJpJ5/dewas7xE1+Oc3mD/QcxYrFAMLWdenGYiXzP/y+gGFF4tw
	6cIWAeLhB2mRzb42poIZ0Oy7gz1waQZEUIPG9Iw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:0Uzd545q4xnwylUx/6sYZB0lfb6nuCxYKJHx02xH2SY=:65ieM8+MQ2wjYZZijYEiHv9C9RWDg7X78JnSplUq7F4=;
X-ME-Sender: <xms:QVTCakzN-_QO9M411t9uSFbQd1tFIkOPE7DBBBkKrqx-ebtaI0XEjw>
    <xme:QVTCavRx5xaJ4NRQ7Cg6eh1lErsZEEZSIm7b7UuKiIO7HlRRH-IrY73QdeKAPc56I
    ufDgxaKR2HyOLhtgLtbGDlAuv4Agc2nHExE5JO8m07c4BkNZE-UwFI>
X-ME-Received: <xmr:QVTCarXKxsM3ERY2F40y2XTbnTGpN3QGJ1hbtoiR5xBq5i3tr07kl4oOrjPMS2LfkylzXqo4P17lK5CglVxYMPZpQfeQywuLDGj0>
X-ME-Proxy-Cause: dmFkZTEf5dRh62KONRcqDQkJiM2/DorZoKDlRLMyuDeojA9utY1jAPTsP8+11yofTvLms5
    CJyXQrqrOReeiYMT5/mjMABIyEEZLguqBI/cWDTS2WIK1JlfpxhQ0jzxe9L8qtkkEnCYMV
    1IOcEyZv4IWmruI0nSuN66GqdQYRHYIEP4j9XtSVcE3NM75sB6FpHpYUK8htno6Sul40Qb
    YuzoZYC+0GBjc5+aHVr6F246GJAkDnwHPHM3uotKNbhRNMZuOzHfd/mphgNrp1U/PwZzOX
    pzIbfq+9DLiusR+n32TOJ9a1y/tzvXArmHMozwZ/ap9sK2A6m4QBPAeiJ5r3+UCcojlbku
    XijAdhK2Cew8lEWpRoJMrsfeEnI6sr4X4oU9bDj7x38JG2lSE7YjP5nQe7Q8DjG4OC8sqi
    urVLOL13zFZ1PlDuCHpxBm8Z8SD+VMjNmvq5aYDIeimZGaAZBf5BSDHCWk4nhGks9Kak3i
    UVb4nmIJmviZAVzRQncyYF9NxbWBb3ejoTCFPlIZGh6Z+miN9k2hzTMUiLkU5eV/1nIcKT
    XprEBv8SWqlTil8yeD40LmqZb2nGhu3SXlVqD1zNmDhYCAQAtr4AOFhNxkwR037v18ALSa
    TlwskTAI1byzAvNamgOWRdOj5mc0lVK5r33UgaLg9USUt+Oop9WY54pw44Bw
X-ME-Proxy: <xmx:QVTCahb7vqNJLMrnEBZp9WeMvouiphvOp2K235-6KrwzKpPUkL4FCA>
    <xmx:QVTCah3ib4cPd2YAl4jRgG1dN_7noUkTQaGgm0XD6hp-Oy4iyxWIyA>
    <xmx:QVTCajiiGxdhRk4ANlKDG2HzVhahT1QPUj19qZQbw2JDQR2N-4SlZA>
    <xmx:QVTCalZ1DU6CebGSDXvpoiGDMh1Btgts_wusU8QBGv1_2pnjRoxfdw>
    <xmx:QVTCaolPBlZ6Vzg7RU9CAF-ZiwECr__PijfX_n1qN6YAaoqrdUNwqua3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 09:27:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: git@vger.kernel.org,  m@lfurio.us
Subject: Re: [PATCH v4] fetch.c: defer fetch.followRemoteHEAD validation
In-Reply-To: <20261003231422.6004-1-colinlewishinton@gmail.com> (Colin
	Hinton's message of "Sat, 3 Oct 2026 16:14:22 -0700")
References: <20260925230621.179649-1-colinlewishinton@gmail.com>
	<20261003231422.6004-1-colinlewishinton@gmail.com>
Date: Sun, 04 Oct 2026 06:27:27 -0700
Message-ID: <xmqqa4otvbnk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Hinton <colinlewishinton@gmail.com> writes:

>  	if (!strcmp(k, "fetch.followremotehead")) {
> +		free(fetch_config->follow_remote_head_raw);
>  		if (!v)
> +			fetch_config->follow_remote_head_raw = xstrdup("");
>  		else
> +			fetch_config->follow_remote_head_raw = xstrdup(v);

Hmph, this means that the code cannot distinguish between

	[fetch] followremotehead

	[fetch] followremotehead = ""

It would be less code and more expressive if you lost the
conditional, i.e.,

	if (!strcmp(k, "fetch.followremotehead"))
		free(fetch_config->follow_remote_head_raw);
		fetch_config->follow_remote_head_raw = xstrdup_or_null(v);
	}

> +static enum follow_remote_head_settings get_follow_remote_head(const char *setting)
> +{
> +	if (!setting || !*setting)
> +		die(_("missing value for 'fetch.followRemoteHEAD'"));

Then you can differenciate

	if (!setting)
		... we got '[fetch] followRemoteHEAD' ...
		die() as before, complaining that the this is not a Bool.
	else if (!*setting)
		... we got '[fetch] followRemoteHEAD = ""' ...

if we wanted to.  It probably do not need to check for an empty
string as it will fall through the "else if" cascade below and
eventually end up with the warning + default.  

> +	else if (!strcmp(setting, "never"))
> +		return FOLLOW_REMOTE_NEVER;
> +	else if (!strcmp(setting, "create"))
> +		return FOLLOW_REMOTE_CREATE;
> +	else if (!strcmp(setting, "warn"))
> +		return FOLLOW_REMOTE_WARN;
> +	else if (!strcmp(setting, "always"))
> +		return FOLLOW_REMOTE_ALWAYS;
> +	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), setting);
> +	return BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
> +}
