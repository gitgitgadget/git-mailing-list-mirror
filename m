Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFBA383998
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273857; cv=none; b=QiolR626pGELNGAk2ArOaJ7Mkc2vmE3TAZ8hzaRCdXUlGygcX9WmFWddAqvDWynsEKHr081NldaDH34kDkdkd54vDtJM+M30n4jeKOY8/ANPxyON7hdVpDxtF4gsjNnoLraO1eD9e9L4Qd3/LuGcvEiAcmkTwkTOslgc1evJoYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273857; c=relaxed/simple;
	bh=bkXRwbeZdobXGcMkOyRTC8YgaUqYA2I9WYzvWKldBPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UnSfRzgknz0z9SfpvWiNnHJcTcOi1C6Erdbz3LmjhpVzWAKfWOn7pJtBf2ChhqEAKrLi7YEzDIs1U7HIfHizYv9hPd+aQl7qPagxVrcGxUmP1A5R5L8mM9TCxFKNQl+RbOCyHGXq5MKGE8foYsRC5Nedhwi6ZfWlS4MxZRV265E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VWyXMzoN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnupdVdR; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VWyXMzoN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnupdVdR"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E5601D000A9;
	Fri, 12 Jun 2026 10:17:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 12 Jun 2026 10:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781273851; x=1781360251; bh=2bZr1gFTxt
	Q1Nfi6TLsKfz7F7lOoikvaVI74myY7ayI=; b=VWyXMzoN3oBlglGpgYrJFW3Vk8
	llYnYQXkKNThQ31R2ZQouzeAeney4HG63lGnfMtgOPg65eAeRlJqYdzYrNzxa5aF
	jDk8Aj6U/pBdkfRJ3u0veBa9XTI0jlLcjdMOmhyeX9cr3HOa0WB0NcOhxeaanMcr
	VOxURwGE9uEP9WX2lY6Egu1w1gllHsStNV7WX1lgKPutZA9597yB7USSf4mHAruw
	w3P4Limkj5dKXh3XJXaGcCtVxUsku++Yaap32eGYSfxNlEMuUVYzPc8lDpekGcYg
	RiJtpF5JHmugQN4s8Rvp1EiPPC593mL/2Wmakq7PTbZJRBKSgNrGr/GNTdcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781273851; x=1781360251; bh=2bZr1gFTxtQ1Nfi6TLsKfz7F7lOoikvaVI7
	4myY7ayI=; b=XnupdVdRHIx617D+CmIKotnpg4IiMNHRgbFU6YCVaRlt3x5bs+U
	rWc3P0eppVnN14PI7iTxJJyQZccCKFZ7qkx4umhtAcsmo9Vjc0kc6Yu90EHZNfMn
	4gMxmbHKZnmzsKHOV588KVcGM23nz2EGysLkjQgu/01PaGDMkYvjYs6WsgNgDrAx
	5EF5DPMFR2gu+7IId/i1fdP7+VMAIpMtxc+9rgIiyfweqMG43SUP9hjivLR6ta3F
	XZepjG/Mb+fP65PVyQHpwoUgPeT9g7GMjeQcoD6n2spLtd7XEqklPgR9qiVgeIIg
	MpJGjBqCFcBy4OEUHWSFghZC+uhiwvG6wjQ==
X-ME-Sender: <xms:-xQsan4figJ0yyoiqn9lX_5vG5xpx3QwP0M7fZBh_-DTFb7e0Oy9fw>
    <xme:-xQsakWUFCv-tygM1lgAChHZ0adskigFipskxHKgcHN86uV_isMsvo_9iGAqgxGCZ
    2zEJKWksJz5F0RFVrR4w0x4MnZZfGqqrNne9FMfbzphaiJRAoVpqUg>
X-ME-Received: <xmr:-xQsar0nE48_Z1hMNmIOA91h_B_9-RCXvzy3oSqYwcNfSEIKgBBYmF5uKepYbBEsXzxZTAw0g9fA3GIcXqlFRwFnNxVTY2r04E8D>
X-ME-Proxy-Cause: dmFkZTEn9PJeBWarkXvJrkUPpdJhD14/3TwcUwwV8q8DEMpAnnKQDCIjiBCJDWNRT3wl+X
    d9S4kVHcavi9m8a2gykGZOZpUdXG7iIDMjWGKBZhbbYpQuepWEJUaZucB8bWryW3cF0gLY
    n2aSKXKWUhyPw0n/sIg1FeOXzgWP0tuv3l65T+bsIQfimJHPmIKdr12OxTqj6HGytdBd7M
    BzPglpejM7xNWWBPpoUUa4kxEijEkX4Q/X158Jcx5PUzcXyq7aUlebbUDjLXdl+TEkjHSl
    jvdYsQblTpc6qTohtHko2+TdaIg3wE5obhmQ1Wxwjs0UcQWK+NGZJKAN5rR1l0WYxtz/h7
    AEV3c/FfH8p8SgD9TdqrTKnHatDwsgS5ResSUbKhVQQ3evHp5VNQvn9cHqXFxV1VQ+1I5Q
    wvl3MYtSSiuwayCE5cP0eMHwqcBOxc0CVJj1gKgGZD5FV39nXV1ddu7R9mJMlvGp74XVfz
    kKabMy9DW5plpEPLV7K9mTQi+KE7JNP+4DvzQXU3F3UsQAkoV+G4q7Zr2usmgQwdSSeX4Y
    kcxaUb05p1RVzRsv5+2HLAvqNaT2hQaf/sV/1ops9xF5jWCRcO5ru2z3yUYlpAKJRhxcIn
    FyowhWhJmYhGy3DT/0KMneZ7ScY/gmAHcrjMIPWa/MdirsRa6Mi9CnSbI15Q
X-ME-Proxy: <xmx:-xQsah094pHD4WzT5IhDVZYTqBkPpAdPDFihOlshD9oyDUdlcS3yXQ>
    <xmx:-xQsau-OWUcFjxvZYH8JGui4hgtCu5C4sAf6el3GDi_R2D_dTdhNEw>
    <xmx:-xQsau0WcuhD6tgio2VW65yGwj48iELemXjcSwn0OVCF63qN6P01TA>
    <xmx:-xQsar-6e49DLzVwERXF3YJ9Z3-mh3mob-c4gDlw8CJ3D-4eg9Vzvw>
    <xmx:-xQsaljcnh6z4aOg8K-oEJ6B7MPLO21_g09RmZvYsUeEYtWSBIDb4RYS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 10:17:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/7] fetch: add configuration option fetch.followRemoteHEAD
In-Reply-To: <20260612055947.1499497-7-m@lfurio.us> (Matt Hunter's message of
	"Fri, 12 Jun 2026 01:55:42 -0400")
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
	<20260612055947.1499497-1-m@lfurio.us>
	<20260612055947.1499497-7-m@lfurio.us>
Date: Fri, 12 Jun 2026 07:17:29 -0700
Message-ID: <xmqqik7nj11i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matt Hunter <m@lfurio.us> writes:

I haven't been following the discussion, so I will not comment on
the idea, i.e., if it makes sense to add such a new option and
configuration, but if we were to add such a thing, I have some
comments on the mechanics.

By the way, do not call a "configuration variable" a "configuration option".
Let's keep the vocabulary forcused without using random synonyms.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 3cc7efdd83a0..a21bb82274d4 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -103,6 +103,7 @@ static struct string_list negotiation_include = STRING_LIST_INIT_NODUP;
>  
>  struct fetch_config {
>  	enum display_format display_format;
> +	enum follow_remote_head_settings follow_remote_head;
>  	int all;
>  	int prune;
>  	int prune_tags;
> @@ -173,6 +174,22 @@ static int git_fetch_config(const char *k, const char *v,
>  			    "fetch.output", v);
>  	}
>  
> +	if (!strcmp(k, "fetch.followremotehead")) {
> +		if (!v)
> +			return config_error_nonbool(k);
> +		else if (!strcasecmp(v, "never"))
> +			fetch_config->follow_remote_head = FOLLOW_REMOTE_NEVER;
> +		else if (!strcasecmp(v, "create"))
> +			fetch_config->follow_remote_head = FOLLOW_REMOTE_CREATE;
> +		else if (!strcasecmp(v, "warn"))
> +			fetch_config->follow_remote_head = FOLLOW_REMOTE_WARN;
> +		else if (!strcasecmp(v, "always"))
> +			fetch_config->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
> +		else
> +			die(_("invalid value for '%s': '%s'"),
> +				"fetch.followRemoteHEAD", v);
> +	}

I think these uses of strcasecmp() are unnecessary and actively
harms end-user experience.  This is especially true because the
value given to remote.<name>.followRemoteHEAD is case sensitive.

Instead of saying "if you want X to happen, set this variable to
'create'", you have to say "'create', or any other case variations
thereof like 'CrEAte'" somehow, for very dubious gain to the end
users.  If you use strcmp(), and document only all lowercase forms,
it would guarantee to avoid confusing a newbie who read the variable
to be set to 'never' on one blog and 'Never' on another and wonder
if 'NEVER' would work or not.

Admittedly values to some existing configuration variables may be
parsed case insensitively but we should aim to fix the mistake in
the longer term, and we should certainly not add more of them.

Is it sensible to die() here?  If you are fetching from somewhere
without keeping a set of remote-tracking branches for it (i.e., a
single shot "git fetch https://github.com/gitster/git master"), you
do not care what garbage value is in fetch.followRemoteHEAD.
Perhaps the version of Git that is slightly newer than the version
that ships with this patch defined new valid values that this patch
does not know about, and such a user who is doing a single-shot
fetch may have that setting to help them working with their usual
non-single shot repositories, but they use a newer version of Git
for such regular work, and they are using slightly old version of
Git to perform this single-shot fetch.  The point is that the
configured value will *NOT* be used for such a user, and dying only
because this piece of code does not understand the configuration that
will not be used is of dubious value.
