Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422524908BE
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786730185; cv=none; b=K4EAf+LADCawh7927RshCKpUIft2xSBjfWfihu2+HdX4gAPtrvwX1qwuctawCIarIYKjdkDvA831MsQQ+VvZV07l0tWMRk1AY3H92B2h8iuUscxSpFKNL8dOGBcwQShHeac1k6v5P5ZpuNY8dP1BtcDsid3L5nKlbaNxvb59V9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786730185; c=relaxed/simple;
	bh=ZM8KajEM/hvDsX/apbIA+D3HditY3K3G9WSNYQV/6G4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=npIa+qMrONhKivGCnixH6zYvgYf7FDqqqmKKTlotIZMGZ5FQOh2ZLf/pFIcF1VY7lS5a4JygULCL2CNkOgC2QBhlK1J7G7GFYRynleG8YIOJIhCx2cs1ihuT3FZoBVhT3av2v7pf2NhTsbsSuO5O8i1pxujCnOJSaz6DZRJzipk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J/9TwELe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HfWJmsnz; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J/9TwELe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HfWJmsnz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 442EB14000F3;
	Fri, 14 Aug 2026 13:56:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 14 Aug 2026 13:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786730183; x=1786816583; bh=IMZQ9Rw92k
	3xpjtskBwFcVvwkT+lCpH6i4NxdkVyWhQ=; b=J/9TwELemA5kcHVG96UboYDKM1
	L2m1hiR7/AOEYEsIdsiqvRUMRGoLTnZUJchIxG9DbxcqFVOMsewkYnYPOheD3crd
	Bl+Wa99kMTFWN6mJGE37h9a3mhEI8cic+zcm84eQO1ICiPTd1QPjDNW6hEkbKKJT
	6b1IkMz54LrpW5vKSUh350AK30Y7bnmgZdLN8IJbllV/jkxVcgR4zLNI0mIonK2u
	6STlTMYKuAL+T9OoYv5i60se/gDHNMOUUHsW5CXmOoIxHMPi/2l5YBCQ2XZvdeLp
	opzFL+4++F8EioN0ddN8fJlSPEI5c0f276fCDAf6Q57OlJTXhzE5lOPXkK5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786730183; x=1786816583; bh=IMZQ9Rw92k3xpjtskBwFcVvwkT+lCpH6i4N
	xdkVyWhQ=; b=HfWJmsnzJ1nxelkYpWVGirQMOicOnuVk6EPIvu3bGQ1MPHuXwXN
	4qk7EVaSRMplmQjE8naBgQ+SDddob5LiLRJQ1Vu5F4mbBgImSHXa+ulFbMZlcSZJ
	vX+SIfiElJgCEMLADSBqbhPEZhrOP0DuSyzbC1u45KxxubRhxQXhXalRuZx2we0W
	JqtneMjUmxWPMZDbA5+fgyWdKCoKEnQQCo0jd3ShSAgMp4j6ZiYAbq0WC8HFkby6
	lEek7yk++i1CKwpxEFFe54VhC8O9zmWbntlKoh+ZnTDjAQ0KKz15uDx1dSiuervG
	Af03e+LFnB2DvF5FMJgywkfvC5mLq5grEpw==
X-ME-Sender: <xms:x1Z_atme0SCB5wLlmWYtWOk3D9cGm31g7kGx37uQ3RWoti5TCrJsVA>
    <xme:x1Z_an6TbHrCSbiRhhw2maFHs1Pe5x78RMzVCc3s7XB0aD4p0ZJILrZtDCMyC0TZo
    HRQ5Rb-JfQoS-mqPoTKPVJMGk_XpH8WlZcup3Ib1cI2TsQK-70>
X-ME-Received: <xmr:x1Z_ap2-cnwIuKwNslq99v20wXM3FACOd6ZqzCE6mIXEDIxUUjXDKWlmYUykm2dvhPkNiMDgWwPHd74owIQjXlfkdz_tnUhYAA>
X-ME-Proxy-Cause: dmFkZTEydkasrU9tno5NPaAtjum9x0BPMLyPuL/TS/H0SaGyXxaHgVTeFRgfRayx94a1nz
    yJyxh3yXbhfjNhussUoRwUEb5DIEr72Ue8a6G0yUBYDGA8J7zZA1Dx+Q1yuY25a1XNv5R9
    LFWN1AUTXktk3fLJ3x1YZxoTtIJipAQAPiQvX3jJegvwLuIuyaNzAVfsnYib2VAsgZTOo3
    1ckZFSo4id0WCnkayPyJcRdhl10TLWmebznF6sdP5NSBV49fdLu71b7Pkd3mYaf2mVANZS
    zxcJLQ/m1bpQZ5Yj4xqatUEL+xvrf5oIPJT7MqS5vGLkMXcIEwJtpKaU6F/DpmbQ8p5uiA
    RcJMqFi4Ht7iS/2TxzygOE6tVCG9MM3vDZBiL7hWpqS3bH05QVQykox1XPyX88yqHYStoH
    jJl1rp9t+GWXeGImpeCZLTOp7QEjpRE0ZFG4wMI28glchk/OaCqlwGeQsOt8ZWV58kV4Qu
    hSKlPtzzQFk+BiUOUz3G/0+xqDQehJyxK13lwVaeVpRqhkj53c/FSUXmSRfT8ORvgFViNC
    hEgOvkgdG66JX2n8txFB6aa7rvSPvbeVoUzwYc6gVUr2axexXNSV6njHMy7d3jDZXpC8Sw
    CeFiNIfZ+cJH6k3+vOajIyBRjFIg14/1no9eVu+w9Ih9qqvxw0TndKchhOMA
X-ME-Proxy: <xmx:x1Z_aqFUwWeEzsjxyU8xYgyPH40VxwktCEBJv9c68-0n_21NgwILOA>
    <xmx:x1Z_agg9BKoM1yMfADn4mCaQtt-ybtlfN4eE4no19x9WtzNKACI-nA>
    <xmx:x1Z_alAqu0Y_yyhiHpILMZsA4e-8ZqeblvUIELckxT3cqRaI5MgzqQ>
    <xmx:x1Z_aqQ0OCqK1tn_mDpQvBJhezWhGP4yMIZRegXJcOp5iGAZYXIgZw>
    <xmx:x1Z_aiqkyUaYYT3b4YBcGr0KCxK9BWv9mWPMIwzbNaLm2GWbnmMs0ICx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Aug 2026 13:56:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik
 Nayak <karthik.188@gmail.com>,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>
Subject: Re: [PATCH v2 2/5] setup: extract path_allowlist_apply()
In-Reply-To: <20260813154748.2378747-3-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 13 Aug 2026 17:47:45 +0200")
References: <20260807135511.1818458-1-christian.couder@gmail.com>
	<20260813154748.2378747-3-christian.couder@gmail.com>
Date: Fri, 14 Aug 2026 10:56:21 -0700
Message-ID: <xmqqecg0oabe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> In a following commit we are going to check whether a repository is
> part of an allowlist specified in a config variable.
>
> To prepare for that let's extract existing code from
> safe_directory_cb() into a new path_allowlist_apply() helper that will
> help with such checks.
>
> While at it let's make the helper's code simpler and more generic.
>
> Signed-off-by: Christian Couder <christian.couder@gmail.com>
> ---
>  setup.c | 107 +++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 59 insertions(+), 48 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 95909e9603..39dfa1cc5f 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1339,6 +1339,64 @@ static int canonicalize_ceiling_entry(struct string_list_item *item,
>  	}
>  }
>  
> +static void path_allowlist_apply(const char *key, const char *value,
> +				 const char *target_path, int *is_match)
> +{
> +	char *allowed = NULL;
> +	char *normalized = NULL;
> +
> +	if (!value || !*value) {
> +		*is_match = 0;
> +		return;
> +	}
> +
> +	if (!strcmp(value, "*")) {
> +		*is_match = 1;
> +		return;
> +	}
> +
> +	if (git_config_pathname(&allowed, key, value) || !allowed)
> +		return;

The inversion of the polarity from the original here is a nice
touch.  We no longer have to look at deeply indented block to tell
immediately that nothing will happen when the configuration variable
is not set.

> +	/*
> +	 * Setting the config variable to a non-absolute path makes
> +	 * little sense---it won't be relative to the configuration
> +	 * file the item is defined in.  Except for ".", which means
> +	 * "if we are at the top level of a repository, then it is
> +	 * OK", which is slightly tighter than "*" that allows
> +	 * discovery.
> +	 */
> +	if (!is_absolute_path(allowed) && strcmp(allowed, ".")) {
> +		warning(_("%s '%s' not absolute"), key, allowed);
> +		goto end;
> +	}
> +
> +	/*
> +	 * A .gitconfig in $HOME may be shared across different
> +	 * machines and the config variable entries may or may not
> +	 * exist as paths on all of these machines.  In other words,
> +	 * it is not a warning worthy event when there is no such path
> +	 * on this machine---the entry may be useful elsewhere.
> +	 */
> +	normalized = real_pathdup(allowed, 0);
> +	if (!normalized)
> +		goto end;
> +
> +	if (ends_with(normalized, "/*")) {
> +		size_t len = strlen(normalized);
> +		if (!fspathncmp(normalized, target_path, len - 1))
> +			*is_match = 1;
> +		goto end;
> +	}
> +
> +	if (!fspathcmp(target_path, normalized))
> +		*is_match = 1;
> +
> +end:
> +	free(normalized);
> +	free(allowed);
> +}

The name "is_match" somehow feels a bit awkward.  How about calling
it 

    *matches = true/false;

instead?

