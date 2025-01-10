Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5AA212D70
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736529058; cv=none; b=f8B93xN+rOLQvkzF+8t/Cezb5Sh5nGskydOmZ8CrR/Yt7bhqZxoEVFeFDGuitDhqkV5znh9Gvbjn26W4mH2rgpS8sL7SK5MZh/fgZXzmU6tK28O1B9ZTNnw+xcrnHh7Lk5G3L+6R21s12NcgfHvsuEf7IOGytlGc1mzuQ1xbE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736529058; c=relaxed/simple;
	bh=gan44ShajwjkPAneaDeTwMKASsMdqlvk4yjcY8eztKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cb/HkRCj30XH+JUC/8yoUkHvhlOZ/iFVXZV9yG4N7CPKzQafwtuGd7q1BpFvsj4VmUpOt8wuHADxzgSM/gKRlVXN7Jx/wek8SC1G9s148J2QgK3k45805ln6bq9DWah2RWopZMjikYIoJ9suuOdK74b+afke74JfUn/h9hF0AFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SlakJfqS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZjM0oh6n; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SlakJfqS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZjM0oh6n"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 89CFF25401F2;
	Fri, 10 Jan 2025 12:10:55 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jan 2025 12:10:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736529055; x=1736615455; bh=jligsKVCTP
	qYZU54VurpZyrK4ZsfHXDPOlWpvK/0okk=; b=SlakJfqS/Ddq/eGZu/io4IfNlx
	3yRh/Y0T1C3B9n6IvvjNNpmxYTEUAUxqPoXVTj3V/CndQxr/wlxQAob6ozv96H3B
	8uGNAwfKA3F6DCOW9rdDJGAnvmmaIa3uP2srnuK0XeE3EtXGSYlOcMoeBpvl8745
	49yUwUQHVVbzape31lSLNCeypDMrC8kKzgngqYwPH8PuZUW4rdNiUILSXM+cfq14
	SW4rjso2VMnBufpltj+SwxO7NxhzIe4cGlbYReax99r/j9IodY/fvbo1BjuypOiz
	t50m7mstsYPV21NrMJi+2yNtvRZpm+UK7o/1aTFzmRu+gqwpCmNmix69R8Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736529055; x=1736615455; bh=jligsKVCTPqYZU54VurpZyrK4ZsfHXDPOlW
	pvK/0okk=; b=ZjM0oh6nrCJxCi0hHlaiPT6uR6SYWZ7mDeq7FyqkHf7DTI8JfWd
	3aBvH1YohzIEoGi70sEY4aQzy2jgCxaeHDaPTkb3nXS46B8HKREePwY1YSJuZvMa
	nnRqqW8pqDh6rajX3hjcyWgMgeT5fDba2tyuUZc8co+CAZCnULqElAm3lfpNrVjx
	O8Lmb86sXWZHPa/+xjEeJZp7UznU1i3c3D3nowTV9bTbekwfk1hvKDlA2JayRI4j
	HZHJJFXRGQyjrezvoG+/uqG+vHNyDohgWd8Us+s047ClxL36HK0aURcSz6paxnSN
	BYPUW23maYInBzc4j8ZmaXsTjoO8zsL1fKQ==
X-ME-Sender: <xms:n1SBZ1krFMh7Hv5nIvr7j15A9Jibyf_Pllor-lxq-RaFF7nyX6wnqw>
    <xme:n1SBZw2Hirv3-S41pTudxgkcf79FqQpwwtH5kJw8b2Y1fijbGslztNjjZ1vGnEsn3
    TdUTqhCb60VClxlUw>
X-ME-Received: <xmr:n1SBZ7qGrQyNnAx4t8sFamOdI53FGmZ3l4Eu1IKyi4R55CT3gdHuNINjurjiEvUiETzcmPnytA5WXKPsja_rv0B521IOc-aAsre9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegrugestggrnhhvrgdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:n1SBZ1nlSBG-Mb7-tPPKEriCeRYbXh-0RFuxVcke4Erpyo4F18tNVQ>
    <xmx:n1SBZz1hZ7JhC94KgK3S9NrIKFjPL29PRv88U-ZxgK9WCEDGkg7roQ>
    <xmx:n1SBZ0vRg-LPkPaXKVQZjivb9da3TuLg5ivvaxGStAo2JdhaFuj6lg>
    <xmx:n1SBZ3UQ603JkhFZrkETXn6ZgvkFH5bzRR0wa_l4cBgp1Gs7GkYI-Q>
    <xmx:n1SBZ-RYYGuPocysvf4JEgnr4PP6cZps7NA81m5JZOyAF15qhCrOnZTK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 12:10:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Adam Murray via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Adam Murray <ad@canva.com>
Subject: Re: [PATCH v2] trace2: prevent segfault on config collection where
 no value specified
In-Reply-To: <pull.1814.v2.git.1736494100622.gitgitgadget@gmail.com> (Adam
	Murray via GitGitGadget's message of "Fri, 10 Jan 2025 07:28:20
	+0000")
References: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>
	<pull.1814.v2.git.1736494100622.gitgitgadget@gmail.com>
Date: Fri, 10 Jan 2025 09:10:53 -0800
Message-ID: <xmqqed1a8uhu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Adam Murray via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Adam Murray <ad@canva.com>
>
> When TRACE2 analytics is enabled, a git config option that has no value
> causes a segfault.

We often call this "valueless true syntax".  It may techincally
correct to say "has no value", but it is more friendly to readers if
you said "a configuration variable that is set to 'true' with
the valueless true syntax".

> diff --git a/trace2.c b/trace2.c
> index f894532d053..49e7d1db88f 100644
> --- a/trace2.c
> +++ b/trace2.c
> @@ -762,7 +762,7 @@ void trace2_def_param_fl(const char *file, int line, const char *param,
>  	if (!trace2_enabled)
>  		return;
>  
> -	redacted = redact_arg(value);
> +	redacted = value ? redact_arg(value): NULL;
>  
>  	for_each_wanted_builtin (j, tgt_j)
>  		if (tgt_j->pfn_param_fl)
> diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
> index 45b0850a5ec..8e09485c83c 100644
> --- a/trace2/tr2_tgt_event.c
> +++ b/trace2/tr2_tgt_event.c
> @@ -491,7 +491,8 @@ static void fn_param_fl(const char *file, int line, const char *param,
>  	event_fmt_prepare(event_name, file, line, NULL, &jw);
>  	jw_object_string(&jw, "scope", scope_name);
>  	jw_object_string(&jw, "param", param);
> -	jw_object_string(&jw, "value", value);
> +	if (value)
> +		jw_object_string(&jw, "value", value);
>  	jw_end(&jw);

OK, so for "valueless true", we do not get the "value" element in
the json output, which makes sense.  Don't we have documentation
that explains what each element in the output means and when they
are given?  Shouldn't we update it?

> -	strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
> -		    value);
> +	strbuf_addf(&buf_payload, "def_param scope:%s %s", scope_name, param);
> +	if (value)
> +		strbuf_addf(&buf_payload, "=%s", value);

OK.

The input did not spell the "=value" part and said "[section] key"
to mean that section.key is true, so we report that without "=value"
part.  This also makes sense.

> diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
> index a6f9a8a193e..19ae7433ef8 100644
> --- a/trace2/tr2_tgt_perf.c
> +++ b/trace2/tr2_tgt_perf.c
> @@ -446,8 +446,9 @@ static void fn_param_fl(const char *file, int line, const char *param,
>  	struct strbuf scope_payload = STRBUF_INIT;
>  	enum config_scope scope = kvi->scope;
>  	const char *scope_name = config_scope_name(scope);
> -
> -	strbuf_addf(&buf_payload, "%s:%s", param, value);
> +	strbuf_addstr(&buf_payload, param);
> +	if (value)
> +		strbuf_addf(&buf_payload, ":%s", value);

I am not versed well enough in tgt-parf output format to tell if
this makes sense.  We'd need somebody else to review this part.

Thanks.
