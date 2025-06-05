Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084FB20330
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749149322; cv=none; b=IK3/xV5Pz5YY7pvdW/KLL70bwQL0KyHdQOtvzNw8y4M7hs94h4OgC3vf9C1qEBBAqbXAEpXdvKEtZHVKnnwHJXojuZGoE5/bv9jL7/1lrzx6/l9DBdUkje1ECalBzVaZJLISQs6Ol7oFUpKnALZHIO4Fimib9YdaiSGll3X1pOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749149322; c=relaxed/simple;
	bh=sVMo0+JrMmRK6LdM0RoeJ/k/4Jf+kR8dTqvdl5AVVfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q1UoGQPgS0mmEVF26yTs4Twz61CHJ741kea5TuvSXyOTsV+1Smb1jiaHMpIRUIH0t02FxoYguIbGDgKgrXVX50qsKz3cQDmnLLb/QH4DIAgqAhRAi29Af/dI2pRSI0/LQBli8jNUbLYl+vz/cihIYsjk8h00QH4OShm7y0etvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vD8AnMcK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WdLK25fN; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vD8AnMcK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WdLK25fN"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id B7ABA11400F6;
	Thu,  5 Jun 2025 14:48:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 05 Jun 2025 14:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749149308; x=1749235708; bh=8Feh+rJWBB
	urjLWM4MuzyN52S0Cr1ZoDB7bB8CAmbaA=; b=vD8AnMcKgFPiCdR8xzvUoqFc/v
	FUgP27fZOilw0CsuP1zccokJd92lHUKILjL52DaXiFjbVk544LF4xSXs+EOXZPND
	JTzChWU92HnjXy3N0VLBKCMeEUEKSsTxi2B+GTUKOOOhro7WyqeCfqWcoJ9aFxqs
	orOwkmcCjYQkIXept7JTWaCM4LlJifTinng7gzJC+yEBvCGGHzkXOW/v59HC0te5
	HYumCoY7SG7toZgY5NYwf/6sdEvfkg4L19+yD8ZbxjjpoB4jmRBgmW+PJM+ljSu6
	8YBUSWJym9guN7TQPzn+fIP1GVTi6RK+HMFwfMszqUE22pLejTA8b5BByqcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749149308; x=1749235708; bh=8Feh+rJWBBurjLWM4MuzyN52S0Cr1ZoDB7b
	B8CAmbaA=; b=WdLK25fNSSOVHU4PRnZsk4g3XPGxXnNpvvAIwGbBeJKZeF0fFVB
	9YZL8E3PtEAjWvMEiFpRB/qv4lKAMCI6x74cHzYalrld1+lcnf2BkDzjeGhQAtMi
	MBQxJxp+XrQ+ZEWiea8aSJkaFSmFXY6mae+Hjlo4GOUi8KXKcOxdSLWZCGzHwv7Z
	9+AW1LN9ik5V43uRo8JIVXH7C8L5dGWAmAB6QP8620GlJ4tbrC2We7icCZ0dGj2T
	e/Iz7dqIBGkwT8u3FZYH2beOg5ANFfYpLfjNpYqawmPFc48ETwzgVI81GBrwH0ye
	AChJ9h9gTQyvMFYQAW9TozCy5N0wIpavJ8A==
X-ME-Sender: <xms:e-ZBaIg_F1W8ZzlWUadd5EmPA3Yl7eyDQr5DmjJB1Qn7fW0owIHE7w>
    <xme:e-ZBaBBZUOduU-P4DDraiS_8NCRen4DFhG-A7Zr4-FJ6L6ydAj7dITGxfcmVf2o63
    sGaVZ7T7wPk41j8dg>
X-ME-Received: <xmr:e-ZBaAGkWp_uI5vl-IM6IeuCTzlHeoRodmsRG0OML3BKGKAso8Uwr1mKVuhPAzit-MGv-bKX8QU11QelzsnR8VAIPdAYx4OH3u8K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghgrrhhgrgguihhthi
    grtdeksehlihhvvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
    dprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepshgr
    nhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepph
    gvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:e-ZBaJQmwJwQtRBJCJ4HVvuoZb68BzDij5DdGUYmn9eGLSMa4zv-9w>
    <xmx:e-ZBaFwpLYXXYE2JPn3dpN6wjCcgtqzQ_SuNq7gKmMQIuj41SvQkSg>
    <xmx:e-ZBaH7gGbGbLPHvQz1iwN_TPXNSUAOQQYFeO-R1VaeN488t8hW26Q>
    <xmx:e-ZBaCxbe1L8-wTjw2WTM72RpMjVkHeptTVymlgnuomjThsUwrQjNg>
    <xmx:fOZBaLcHWflDhz7LwH3lOZ8J-b7fGtpP1T3FT3ti4arl9NH8POoRgQHU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 14:48:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Zi Yao <ziyao@disroot.org>,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Jeff King <peff@peff.net>,  Ben
 Knoble <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
In-Reply-To: <PN3PR01MB9597EA16029BEBBF4B966212B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Thu, 05 Jun 2025 22:46:45 +0530")
References: <cover.1749112640.git.gargaditya08@live.com>
	<0d28e337cfe7ce3c52490544875474b3502d2081.1749112640.git.gargaditya08@live.com>
	<xmqqy0u687ww.fsf@gitster.g>
	<PN3PR01MB9597EA16029BEBBF4B966212B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 05 Jun 2025 11:48:25 -0700
Message-ID: <xmqqy0u66n46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Might look less ugly, but will result in a compiler warning that this will always
> be true if compiled with NO_OPENSSL. If you are fine with that, good. Else tbh
> I am out of ideas :(.

Sounds like a good place to use NOT_CONSTANT(), it seems?

	if (NOT_CONSTANT(!auth_oauthbearer)) {
		... skip the thing ...
	}


>>>  	server_fill_credential(srvc, cred);
>>>  	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
>>> -	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>>> +
>>> +	if (!srvc->auth_method ||
>>> +	    (strcmp(srvc->auth_method, "XOAUTH2") &&
>>> +	    strcmp(srvc->auth_method, "OAUTHBEARER")))
>>> +		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>>
>>Can we clarify this part, possibly with an in-code comment?
>>
>>"Unless XOAUTH2 or OAUTHBEARER, use the password" sounds a bit
>>strange.  What about methods other than these two that are not a
>>plain simple password authentication?  Will we remember extending
>>this code when we add yet another one to exclude it like XOAUTH2 and
>>OAUTHBEARER are excluded with this patch?

> Let me answer this first. CURLOPT_PASSWORD is for plain or login type
> authentication, and if srvc->auth_method is not defined, curl's behaviour
> defaults to them.

Which makes it sound like if (!srvc->auth_method) is enough?

> OAUTHBEARER and XOAUTH2 use CURLOPT_XOAUTH2_BEARER
> in curl, which can use either of them based on what server says.

That is what we can read from the updated code.

The question is what happens when the user sets srvc->auth_method to
something other than NULL (unused---use plain password), "XOAUTH2"
or "OAUTHBEARER".

If the answer to that question is ...

> Other auth methods
> are not supported yet in this code, and this is the reason CRAM_MD5 is supported
> by only OpenSSL.

... "with srvc->auth_method set to other methods like CRAM_MD5, the
control would never enter this codepath, as they are implemented
elsewhere", then I think it would make more sense to write the above
like this:

	if (!srvc->auth_method)
		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
	else if (strcmp(srvc->auth_method, "XOAUTH2") &&
		 strcmp(srvc->auth_method, "OAUTHBEARER"))
		BUG("we only support XOAUTH2 and OAUTHBEARER in this codepath");

Or the code is not protecting this code path so control can reach
with auth_method set to CRAM_MD5 here (e.g. when built without
OpenSSL)?  If so, replace BUG("message") with die(_("message"))
above.

On the other hand, if you are trying to fall back to plain password
when other unhandled methods are specified, I would expect that the
code to read more like:

	if (srvc->auth_method &&
            (!strcmp(srvc->auth_method, "XOAUTH2") ||
             !strcmp(srvc->auth_method, "OAUTHBEARER")))
		;
	else {
		if (srvc->auth_method)
			warning("auth method %s not supported,
			         falling back to plain password",
                                srvc->auth_method);
		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
	}

I cannot quite tell which one you meant, but I am guessing that the
former is the case from your explanation.

Thanks.
