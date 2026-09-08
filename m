Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008857EDA7
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885087; cv=none; b=j93lu3gcceRcqQaXNR15UVqTyIttFQT3nFW2Bqj3goRbLRGb1jKRYhyCqoPlcCiaKtCfcOwMMmVD2bh4xIzLBE8LN6YGoWXNry7axjSz0FaRmAu+1VsJuzS1qOtYUpB2+fSe85MBEl/PNnHNEAjcMKf77Vbjrd287yjGVHZkuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885087; c=relaxed/simple;
	bh=1hm72KFNi9bSVCyOcCESo1+mS33KK3vSRnEqlKFwh/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZH6xs0rhj80RlX03kTN127o4a30wRNtMyzLoa9SDaTpVQJlnAo74eYFb/0miPFVJgYaYLMeliFhX0nc6kf8yI5qOkEBVQomjrwkiV9hYJrImA5XfvA9IFAOFUCiejQsl/OL9GxP/nxsIDUUDYim9uRqAEmD48YuCQ7pChhyjzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IZ6nM6YV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mT+fDeuV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IZ6nM6YV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mT+fDeuV"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A074A140007E;
	Tue,  8 Sep 2026 12:31:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 08 Sep 2026 12:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788885084; x=1788971484; bh=wE77vE1DPo
	Q72JRmhVDVVcZaDLXZa6LCImZvkGvmWP4=; b=IZ6nM6YVR5lk0ZdzuduC2GxG3h
	UWyPyuDezfqx/4WIuqq3INWI7EuMOPKMy99J3nZuwz10VsgSGCKFg9yVUxb/3aSr
	daQ+N/3FbVfkJA45ZNxsgcEiKUPfWCfJsTRJfjT68qiu1sA/mGXNo+cGC7RQ6UKb
	H62WWfQ2NA8h79IC6uh+D3VvLlww/HTERBCptDz5sm5vikNNNhehBfU61zmF5Uiz
	6D5YiytTYwYojnCM2ajV7GWV+oO7ajcU63RVRf0lbaXswAKDFsxQa/Wx6hyFXYnV
	zMLVAn3E/BihOIG14MD7dBE3uC+Sc+4coSbyaI7eb0lnN2Qv/R2xRSxMzWNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788885084; x=1788971484; bh=wE77vE1DPoQ72JRmhVDVVcZaDLXZa6LCImZ
	vkGvmWP4=; b=mT+fDeuVa1dk6yH/iK5QGIEF8MdY6slkbrggqM0hLI91Jy1iv7j
	Mjpaf2klCfksy2HWz/wyOzeCt+IH6eDU0/6KjEamIq8oYULeWPAQ4qt0eqo1Yxv0
	NFkqhSE25Pzh63aFcQ6lWDe3cCzmDKS9FGrgE0huuvevh1SQ7MM8vUR1TegDusv9
	eOYMX+QIdOoY27fO4gmqqE7AQ9Obfa8SLhxp/lPd6MP4nihRieb6UCia90e5yydq
	rtic6DnIjJy6jY9KZJaR+oSTZMdkrAzqbs+znJV219b+ZAkc9FbRW4HgcFYyCgT7
	pgROkf7dGriqq4G/xGxKHOszc9G9L/LQqOw==
X-ME-Sender: <xms:XDigam36nYEZDlWn6g9GT43FeS69lSQhq0bIAF1E8SDhZtWYPv3vNg>
    <xme:XDigagFP7OQm5lEmEutp7Hn0KPSwUfr6YcSzLjJoF1jaxo0n9n_Xk9eOZHvWIhW2E
    SK5vbab6Zd7loSujikRYcPGfxFsRdzMkfAidkWk4nrZvgMmK-EKSeMv>
X-ME-Received: <xmr:XDigaj6XbuiHTbVfPNVkQQ9_tHAjP11ig5TNE_JwvkMVe8Xe6ABWClrBF2y02e7PKYt0dG-81zxL-2t6XGvvkHpHpIoS1d_9-ChR>
X-ME-Proxy-Cause: dmFkZTFe7LGyAexvx3gvHRn7nAKedIZ8hCmj6H1seOiymQRcLTqCDhw01+vtFR97ycyRMf
    O67oB+9PMyWfrBdtYhcjz8ik7k2AXMOxUQ3XQrkJOHP5jg06tFUaDJtUdmbXUaGn89uQx/
    pF47w3keLeyWYQ+cMRnpxKwdqJgTsOwfiuhg+1n03BAgIorwBrGlO0zwlkpOtPGlOWcVXA
    R+id7SkQGMX7Q3GscE7/QKIy7CwAMhiRO3WDUU/tTndEgAgIgcIl6nvTLk8SPUNakENJRG
    ziTaE7sIy6oeNmZENXVrm5182jFanv+8ObD8Wrsi1O8mubUl0rRCB1racEp1g/hHLqCMkD
    e8fWh350AvoI8X1dQ8kn+JcLa0b8o6i2XZzoSJ1NwEcSmAqp0Z5LL7WTN12bcvw0LfzlUk
    Qc+XyHu3kVW7lkswD+M39A1xEwEmUJRq1o5h5vc1157NrsSrJO35sZ3vWKJNWGgK2gqpZ0
    mmh5roUtHGujlw5yck1zb0cunL14yp/QfWKW/cwREjDa8qS32RQEI+GteURoDRuYKRdZwj
    Q0nU4Ym1WKWdbdIcbXKK7WlLexqEBckCGgkI3xQgGzzL5eI9wNBwt0uH5QZXX0bhHy7v8w
    W/FY8e+q4OuM7uDOPmABbh5ckXyECRjKkXcvajJgpeo/CBB+15s6Yg42u+Rg
X-ME-Proxy: <xmx:XDigamsnQF2KjA_i2K6yn5_sVjQayiI687F3Xw6x73yickTTcVCXIQ>
    <xmx:XDigak4goCXUtCW9KgTv8GWoNrBWXcDb00Q1Ja5RKNVTCy0OEg7dUw>
    <xmx:XDigahUjspz_MJKwOUNMurJE8zaD4iFCx7LUR6Cll-Z9ANeBMgNcoQ>
    <xmx:XDigam_hpNhSjE9XD3tsVdGbQ8g5kNNCGPi6D-C_zS_I0huAjFh-Tg>
    <xmx:XDigagobSOl23vmJmXoBL-z67QS8e1ItMtwCGeHJjEsC7mmP5rxw9jHt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Sep 2026 12:31:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
Cc: ben.knoble@gmail.com,  git@vger.kernel.org
Subject: Re: [PATCH] advice: use global config for default branch name
In-Reply-To: <20260908185653.34702-1-ub4nal@mail.ru> (Vsevolod Myalitsin's
	message of "Tue, 8 Sep 2026 21:56:52 +0300")
References: <90671DEB-7A41-47DA-B865-AB963AEC11D1@gmail.com>
	<20260908185653.34702-1-ub4nal@mail.ru>
Date: Tue, 08 Sep 2026 09:31:20 -0700
Message-ID: <xmqqik4fyaav.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vsevolod Myalitsin <ub4nal@mail.ru> writes:

> I considered using an "is_global(key)" helper, but I think adding
> a field to "advice_setting" is cleaner.
>
> The change is quite small:
>
>  struct advice_setting {
>      const char *key;
> +    int global_hint;
>      enum advice_level level;
>  };

Should it only about "global vs local"?  I am wondering if we ever
want to suggest "system".  In any case, these three things are
called "scope" in "git config --help", so perhaps rename the new
member to "config_scope" or "scope_hint" or something?

> Then the scope is specified directly for the relevant advice:
>
> 	-[ADVICE_DEFAULT_BRANCH_NAME] = { "defaultBranchName" },
> 	+[ADVICE_DEFAULT_BRANCH_NAME] = { "defaultBranchName", 1 },
>
> And used when building the hint:
>
> 	 static void vadvise(const char *advice, int display_instructions,
> 	-                    const char *key, va_list params)
> 	+                    const char *key, int global, va_list params)

Have you considered going in the other direction to narrow the
interface instead of widening?  Instead of passing .level and .key
separately from the caller to this function, I wonder if it makes
it more future-proof to pass &advice_setting[type].  A call in
advise_if_enabled() then would become

	vadvise(advice, &advice_settings[type], params);

and vadvise() is the only thing that needs to know what members are
in the advice_setting struct and how they affect the output.

> 	 {
> 	     ...
>  
> 	     if (display_instructions)
> 	-        strbuf_addf(&buf, turn_off_instructions, key);
> 	+        strbuf_addf(&buf, turn_off_instructions,
> 	+                    global ? "--global" : "", key);
> 	 }
>
> This keeps the information about the intended config scope in "advice_setting", rather than making "vadvise()" depend on specific advice keys.
