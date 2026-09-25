Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BCD38945A
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 19:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365229; cv=none; b=dgcsV6iyPDpsU4d0Qdb0fFUSEOzcHD1yvZOHiO4vv7of7Qm7Wv/7U4BBF7OXvQ9Dw8rl/FixtFB54E+JQEDGIiFj2Ww9cFddrKJO3iYqIeOC0fNqaSIq0vvmed9GcBM6FH7arZhEph/4Zbf2gZj4G1vqtEpG1niOfpIc8/4JZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365229; c=relaxed/simple;
	bh=pHooB2EvldFvZQrdmer2upjTUyAIMTFKhS11SNU0fLo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rbEOiutdLwIKde7qQUYQ9cytY3u8vOZ6J7ChsPQagVGIhpmS8IBIkSeJrq3A3nLUWMRBFT6hky8ou8n3FFdpkA6MPaMPgshAGtFR23HNiWEb0kWGsN2KhyRs5N3UhWGXjp7jO9selpGK+IjUzFWgzv94xFCFV3CfI14oopHSCNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BGxMtUlo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LF1Nr05W; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BGxMtUlo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LF1Nr05W"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 48BA3EC0064;
	Fri, 25 Sep 2026 15:40:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 25 Sep 2026 15:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790365227; x=1790451627; bh=nlp85OiUlq
	BSRmRQXLhDaeoU6t6J6TlPh3Dt1Ypcmic=; b=BGxMtUlokIBKX5HgRoPCFONgru
	bkL9WRUjP6URtEY9noeQQerLFadPfaqUHnFbe7sXgRBNl+mSShYkjsK/NttE8yN6
	K4MO3Jc4HTF7lsz6wkAo1l4kqfdcCiyxG07o2oDQ8EtFKRPi7R0sg/b6aCTgOeXb
	3kB5H/4S3qX7d/WPoOakk/cRcVLCsliIwD1hbIFtX78V76DlMF/Glhpnx/0odfZi
	WyRY4MmoDNNYFKWv+A6ylnoRnFH1fvEax+NwZFi5T5fwtUi3gGfCU154FTovcU9X
	mpIMevYzZg/PPoCtf4POTEK2NLtfeb5pnA2b9Ne3RMCBQ1nuj4bhbDm2fkKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790365227; x=1790451627; bh=nlp85OiUlqBSRmRQXLhDaeoU6t6J6TlPh3D
	t1Ypcmic=; b=LF1Nr05WWw7MxsiVenL6mcgM04bBzI81rHC2P4edSr3Ess1/y9Q
	lYXSqTlC9//57sx+AyzTo5nGcWkU8USy1WLlz0RJrT3Q5XDPJb1EebRPqXbHbYJz
	4zz3vmejOQjhyuobOyQAnE4kHnMKNkAwSGg5Le6BTf204N8Jcq02zt5UJGx2ygDM
	fbf9iymoEWOUzpsMNKakscIWfz2mGC5MZ/c0pkANgdgL+rkfTBgproUpPyCTh8ne
	D+eF7F0HEE63X0BAjKDtILCKNRm8IepIJpzmJXF6A6TmuK4blgJAWnU8N793OLmA
	PglmG9AwkEOvHUAZQtywZ2mqJ8BwCKPJz9w==
X-ME-Sender: <xms:K862asH2UGQJ71Onb9l7QPKfGJ_SaJTXk2ano9k5Hd3GhwlopRvqPg>
    <xme:K862asU2Ra_NeJB8D2J2q7bUYz8hST9Qn8N54jE5X2eXMvH9AQAF62YtWv5aINSTS
    L7aKZlgxngntrvCIUpof2OtKpVMNk8ytouyAwJXs6rRRCIVFDIsedQ>
X-ME-Received: <xmr:K862arJdM5FR9hMB5p3IPAxnVDYhhw0rK2sm99mKqGCTy8RV2x4B24mdZyZs-LvbZVkZ2NNSE7rx698IIoK6MNRszLEPlo-28xjL>
X-ME-Proxy-Cause: dmFkZTFcI0M0wjS5pESNCj55/32M5ptlT8EMdp42L5MxkGNWABXW73Vo0jqUrkjNULRjwK
    j4XkONQeYjaXd2qlPMQHriTeMPIFgkrNwUDw4Kae2gHnHXf9dj2efk9a0+gOzoaJ+jG5N+
    NCZpUGAUZhVkjB17X6QGua0lM6At2K1YjflYMwyavIbqZJAHtW96qZCYfkXcQtEHVyAQam
    ENjitpv7FmXyaz1n5+eFb3/wX2M/HDC6lKD3DkRxfP2s2+b6MfGZPm+6TABNtgh+AUu3uk
    TM+1ylTHayokVwn9LL9pL78WsCbOYJsBjGVM+JGo66CnlAmQ2bpc+4gVaZSEx7wLGtJser
    JE+QOQCjnP3A3+wFFlCAhlusjR9m5pCnWBmJ6fBli9DGhx8/EsK4IEPN87NADZAwykOwW+
    TYB/j1+fenAIj22JRZ+68VVVQD5IoJzWheOxXCy/3jNZfy+QhLFfd7vVBLWat8ujFmxYgB
    JbRpGPlQjS6S5m6JdJ4mnxWeQylrn4bI+uPEFLrCjrygdSsewPOT/uCj4Jz8BShd8XzqBK
    H3yRJAs8CP+X4C5jLaWev4jr69ah7NMAsXvIRyTEM5ZPo9ccrDbdsqMUcpDTkQeOUGIWCN
    zAI3GyTEUNPzFeD0O1nEKrWywDr2TSlHy1fFI4/sGeXxCNgW1mPGfeQ9JQjQ
X-ME-Proxy: <xmx:K862as_eRI5EkeEN1He2S0m6NOyslaP5ro-QmDrWpaO3Bwkyr37boQ>
    <xmx:K862auINlgk2KycWZtLITA_zJDDOekxb3z99p4_ijRUWRKiBhgFsyA>
    <xmx:K862ahlDS_wNliovAFXNaDrByKZFUVfxQ30BkszNXVlOEInr9OYw8g>
    <xmx:K862aiMbSxsLjsM2ePL-mqnUTyJzM_8JiELf0DPsWZEqKd3RpLNyqA>
    <xmx:K862at4eLwy4aJ4YLR2j5ZwT13fRm854E-pwNqVyRfvZGJI7OYVt2N8h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 15:40:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Colin Hinton <colinlewishinton@gmail.com>
Cc: git@vger.kernel.org,  m@lfurio.us
Subject: Re: [PATCH v2] fetch.c: defer fetch.followRemoteHEAD validation
In-Reply-To: <20260925192658.1166-1-colinlewishinton@gmail.com> (Colin
	Hinton's message of "Fri, 25 Sep 2026 12:26:58 -0700")
References: <20260922040047.2567-1-colinlewishinton@gmail.com>
	<20260925192658.1166-1-colinlewishinton@gmail.com>
Date: Fri, 25 Sep 2026 12:40:25 -0700
Message-ID: <xmqqo6dlt906.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Colin Hinton <colinlewishinton@gmail.com> writes:

>  struct fetch_config {
>  	enum display_format display_format;
> -	enum follow_remote_head_settings follow_remote_head;
> +	char *follow_remote_head_raw;
>  	int all;
>  	int prune;
>  	int prune_tags;
> @@ -176,24 +176,31 @@ static int git_fetch_config(const char *k, const char *v,
>  	}
>  
>  	if (!strcmp(k, "fetch.followremotehead")) {
> -		if (!v)
> -			return config_error_nonbool(k);
> -		else if (!strcmp(v, "never"))
> -			fetch_config->follow_remote_head = FOLLOW_REMOTE_NEVER;
> -		else if (!strcmp(v, "create"))
> -			fetch_config->follow_remote_head = FOLLOW_REMOTE_CREATE;
> -		else if (!strcmp(v, "warn"))
> -			fetch_config->follow_remote_head = FOLLOW_REMOTE_WARN;
> -		else if (!strcmp(v, "always"))
> -			fetch_config->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
> -		else
> -			warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), v);
> +		free(fetch_config->follow_remote_head_raw);
> +		fetch_config->follow_remote_head_raw = xstrdup(v);

This will segfault when !v, so

	fetch_config->follow_remote_head_raw = xstrdup_or_null(v);

With that change,

> +static enum follow_remote_head_settings get_follow_remote_head(const char *setting)
> +{
> +	if (!setting)
> +		die(_("missing value for 'fetch.followRemoteHEAD'"));
> +	else if (!strcmp(setting, "never"))
> +		return FOLLOW_REMOTE_NEVER;
> +	else if (!strcmp(setting, "create"))
> +		return FOLLOW_REMOTE_CREATE;
> +	else if (!strcmp(setting, "warn"))
> +		return FOLLOW_REMOTE_WARN;
> +	else if (!strcmp(setting, "always"))
> +		return FOLLOW_REMOTE_ALWAYS;
> +	warning(_("unrecognized fetch.followRemoteHEAD value '%s' ignored"), setting);
> +	return FOLLOW_REMOTE_UNCONFIGURED;
> +}

This would do a reasonable job.

We should do something similar to what remote.c parses for
consistency, but other than that, it seems this topic is moving in
the right direction.

Thanks.
