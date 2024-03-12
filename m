Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2061143C4E
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710279819; cv=none; b=MSZbrO4vP+IOxK3ULeqsYcemjNKweN8y/nOqU+z4/Xad5XEh0rtedrx+MIoh3R51JwPcZdim3/udFzitgNgRW3Frw74+p1A6u06HI0KbUGUJgSF1nfDMI53aVmfWNJ+FJNaqpCHGE3P81/okDVE+bWyhSMmtmkhmrGdw7yFqKnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710279819; c=relaxed/simple;
	bh=C1zb9CEpzUZAcN46OLofGbJ8q+vRtN4BvQYyhnm1UBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8fh4/5dRQx91mSGfQe4+Um8rofky+nefiXtXDVIQsIACDdbyrUgyB16wb9IjRkt+i9JTIUVTU1ZOuEYAUTM57HUeM96SIm2bAgowQo9PMqq6df9fOu9aNSJk8T8/Yl72KeKdJuk19cnsmEiHL9j0R+1LVNIiqzS86Ih9TofOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MBByRBlu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MBByRBlu"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b5831bc8so246035b3a.0
        for <git@vger.kernel.org>; Tue, 12 Mar 2024 14:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710279817; x=1710884617; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z61X0cY1MtdyAsNVRzU3Dp1Q6/tPghsSx4eFJHfAVYE=;
        b=MBByRBlum5xmFWAYhs3QiVcY+3UePfaijLXymfYob+YePcYQUFQMHKLqV7MLE1W/CG
         abFgjFnH/itDffYi3R6vQWQFmqv0JfOMWgWiR3yRebDnE2JZ3XQCeqcQ5+R7ZnM8ocUJ
         +5iZ4bNWQ/96cL11q0f4L7vkGpla+G3IkR618l5qRk1F0zt+oFSk3AhpB8xVkypOa1VW
         q4j0TVst1W94nHd4DUihnXpHmVcDYVPBfMkMBwApXY/Nw2/SBThSRTl2e97iNyVIuxBk
         XOq1eMh3+eV2qiX8EyAmS+eNUoYkz+hSWUrL5BDFx+2VcozSoNAEEu2t9zlfsGEfjCsC
         PDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710279817; x=1710884617;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z61X0cY1MtdyAsNVRzU3Dp1Q6/tPghsSx4eFJHfAVYE=;
        b=w6yJHe6eh1WjyQPuRlLaK94lfEEo6Mk3Zfwz6AmVLb6ebBJCi6o2lyZ4PNDs2BWDGl
         4RW5ElL3zFCQ2Mlv7Gpoo4l9oJR0Ygk60875vWODt+O4bH3W+WBSESKn3DXAJKTqWZSc
         8qkosJQI4XHHAGZHgIuq9t/DvD+208bwpOsWxbS0v/4d5cpMottrMbxeCvSNCg01jw14
         ftfcPe3degotfqGp4WrWLRLIPzO3YLXjdRCoENsdaHp/VMVlTICwimQE9uDMswev3wlI
         eX7+cEPoX3gziWN+AEjys/yFoS7m6dHu8y6Pu0jW3gumyFZuALdcq+Mt4Wr91EYVLMpm
         9kFg==
X-Gm-Message-State: AOJu0YyOB2haBU4lB1ZmEqvpcffu4K9hMajH1su077PyD5NQDMX5sFSV
	pOsZ7C/NBZKjS9dEtq3OTUiw6ucAamqkq1E4o635wkS5YEdgw3RE2kMBLkrUkg==
X-Google-Smtp-Source: AGHT+IGMFaktPNGxzS2cSFfaGHzn2mysmQ+ya+ZojbwVV74nVfz+Pyjm/lysgWkOg8Wh5mFDPddFJA==
X-Received: by 2002:a05:6a20:b88:b0:1a1:8312:6dfb with SMTP id i8-20020a056a200b8800b001a183126dfbmr1320367pzh.58.1710279816846;
        Tue, 12 Mar 2024 14:43:36 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:7646:f9ff:942e:a372])
        by smtp.gmail.com with ESMTPSA id k5-20020aa79d05000000b006e688353547sm5033330pfp.168.2024.03.12.14.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:43:36 -0700 (PDT)
Date: Tue, 12 Mar 2024 14:43:32 -0700
From: Josh Steadmon <steadmon@google.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/6] parse-options: factor out register_abbrev() and
 struct parsed_option
Message-ID: <ZfDMhJ4r5g-g-B3n@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
References: <20240224212953.44026-1-l.s.r@web.de>
 <20240303121944.20627-1-l.s.r@web.de>
 <20240303121944.20627-4-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240303121944.20627-4-l.s.r@web.de>

I found this change to be hard to follow, although I'm not sure anything
actually needs to be changed. Thinking aloud below, apologies for being
verbose.

On 2024.03.03 13:19, René Scharfe wrote:
> Add a function, register_abbrev(), for storing the necessary details for
> remembering an abbreviated and thus potentially ambiguous option.  Call
> it instead of sharing the code using goto, to make the control flow more
> explicit.
> 
> Conveniently collect these details in the new struct parsed_option to
> reduce the number of necessary function arguments.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  parse-options.c | 83 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 49 insertions(+), 34 deletions(-)
> 
> diff --git a/parse-options.c b/parse-options.c
> index 056c6b30e9..398ebaef14 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -350,14 +350,40 @@ static int is_alias(struct parse_opt_ctx_t *ctx,
>  	return 0;
>  }
> 
> +struct parsed_option {
> +	const struct option *option;
> +	enum opt_parsed flags;
> +};

We're bundling up the state for previously-examined options that "arg"
might expand to. Looks good.


> +static void register_abbrev(struct parse_opt_ctx_t *p,
> +			    const struct option *option, enum opt_parsed flags,
> +			    struct parsed_option *abbrev,
> +			    struct parsed_option *ambiguous)
> +{

Here we're defining a function to separate out the logic that we
previously jumped to with "goto is_abbreviated;". Looks good.


> +	if (p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
> +		return;

This is the (negation of the) allow_abbrev condition that was removed
below. Looks good.

> +	if (abbrev->option &&
> +	    !is_alias(p, abbrev->option, option)) {
> +		/*
> +		 * If this is abbreviated, it is
> +		 * ambiguous. So when there is no
> +		 * exact match later, we need to
> +		 * error out.
> +		 */
> +		ambiguous->option = abbrev->option;
> +		ambiguous->flags = abbrev->flags;

Couldn't this just be "*ambiguous = *abbrev;" ?


> +	}
> +	abbrev->option = option;
> +	abbrev->flags = flags;
> +}

So, we've found a candidate that matches our abbreviation. If this is
the second (or later) candidate, then we've got an ambiguous
abbreviation, which we'll need to warn about later. Since we're
overwriting both "ambiguous" and "abbrev", we'll only refer to the last
two candidates seen, but that seems fine.

>  static enum parse_opt_result parse_long_opt(
>  	struct parse_opt_ctx_t *p, const char *arg,
>  	const struct option *options)
>  {
>  	const char *arg_end = strchrnul(arg, '=');
> -	const struct option *abbrev_option = NULL, *ambiguous_option = NULL;
> -	enum opt_parsed abbrev_flags = OPT_LONG, ambiguous_flags = OPT_LONG;
> -	int allow_abbrev = !(p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT);
> +	struct parsed_option abbrev = { .option = NULL, .flags = OPT_LONG };
> +	struct parsed_option ambiguous = { .option = NULL, .flags = OPT_LONG };
> 
>  	for (; options->type != OPTION_END; options++) {
>  		const char *rest, *long_name = options->long_name;
> @@ -377,31 +403,20 @@ static enum parse_opt_result parse_long_opt(
>  			rest = NULL;
>  		if (!rest) {
>  			/* abbreviated? */
> -			if (allow_abbrev &&
> -			    !strncmp(long_name, arg, arg_end - arg)) {
> -is_abbreviated:
> -				if (abbrev_option &&
> -				    !is_alias(p, abbrev_option, options)) {
> -					/*
> -					 * If this is abbreviated, it is
> -					 * ambiguous. So when there is no
> -					 * exact match later, we need to
> -					 * error out.
> -					 */
> -					ambiguous_option = abbrev_option;
> -					ambiguous_flags = abbrev_flags;
> -				}
> -				abbrev_option = options;
> -				abbrev_flags = flags ^ opt_flags;
> +			if (!strncmp(long_name, arg, arg_end - arg)) {
> +				register_abbrev(p, options, flags ^ opt_flags,
> +						&abbrev, &ambiguous);

This part I found hard to follow; the change itself is a simple
replacement of the original logic with our new function, but I don't
understand the original logic in the first place. Why do we XOR flags
and opt_flags here?

These are both bitflags which can hold a combination of OPT_SHORT and/or
OPT_UNSET (i.e., we've passed --no-foo). Since we're only looking at
args that we already know are in long form, the only one we should need
to worry about is whether OPT_UNSET is true or false. And indeed, we
never set OPT_SHORT in this function.

IIUC, "flags" corresponds to "arg", the flag we're trying to parse, and
"opt_flags" corresponds to "options", the current item in the list of
all options that we're trying to match against.

So OPT_UNSET will be true in "flags" if either "arg" starts with "no-"
or if it is a prefix of "no-".

OPT_UNSET will be true in "opt_flags" if all of the following are true:
* "arg" does not start with "no-"
* PARSE_OPT_NONEG is not set in options->flags
* options->long_name starts with "no-"

So OPT_UNSET can never be set at the same time in both "flags" and
"opt_flags", and thus the XOR makes a bit more sense: either the
argument we're parsing or the canonical form of the candidate that we're
matching against is negated. We don't care which one, but we need to
know about the negation later, to either set the value properly, or to
report potential ambiguities with the "no-" prefix.

>  				continue;
>  			}
>  			/* negation allowed? */
>  			if (options->flags & PARSE_OPT_NONEG)
>  				continue;
>  			/* negated and abbreviated very much? */
> -			if (allow_abbrev && starts_with("no-", arg)) {
> +			if (starts_with("no-", arg)) {
>  				flags |= OPT_UNSET;
> -				goto is_abbreviated;
> +				register_abbrev(p, options, flags ^ opt_flags,
> +						&abbrev, &ambiguous);
> +				continue;

This is a slight change: we might set OPT_UNSET in flags where before we
were prevented by the "allow_abbrev" condition, but register_abbrev will
still be a no-op in that case, so I don't think this changes any
behavior.

All the other changes in this patch are straightforward. So, despite
having to puzzle out the original logic, everything here looks good.
