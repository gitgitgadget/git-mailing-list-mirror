Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497E3369
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0OQAq4v6"
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AE7A3
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:24:57 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c9d7dc2b36so2082215ad.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697761497; x=1698366297; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EubeCOfLJ0lovmWvlLUalHlu/YT6yi/oEyTgkF9tbas=;
        b=0OQAq4v6MU7s5L5ieI25J/Dh+Q27ToF/KAFbe3bOTfEVQBaSMuM4lldRRjlCkBqlTk
         P4TiKBjaagixCqLC/Hy8jIp+Wpo6xxpjr4taM7mCvKfOa8zHiHRQi2xd0I6KxxowRS0N
         jmtL7TITTumGeqoYhv0Gews4B2JkgOk38bTcrzq0O9OSy8dyqev0eSGJMsQhOoyJ3woq
         VeflWsN8hcisMSem6TJP3/zRko0rNmzi3bwVkkgOOgExDTY0HVBVnEcWWyuWIyIGNqOf
         apdHBswb4BlE0dK7pjZMQboDnFv1XxCR9mh9OZWCwgIm5OrBVgOOXl/H3JSJSkAqxxta
         JACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697761497; x=1698366297;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EubeCOfLJ0lovmWvlLUalHlu/YT6yi/oEyTgkF9tbas=;
        b=l39iYSuMfgOhXFxUtnoGogr2koTe56xrrf8ZS1+VgqJtkw3UX9a8ff2wBK1dBjWYJH
         hlZTkps1C1l+lrw2LHLGOuxUgR+N8m1G0pYcL3+EGD3TCKgEKtBoBdYNa2UOnRjCup3R
         yxKwuhRRjT2ngphW5OUHG5+3EN1SPrfrtPq7d42KwfmiPvqkD7po8wjeKYEmD83Fmr3w
         JCqvSybNUBC9glqIKgQ65viqK1bqzesBXmRHcxvxv2jkTQWdfCPzxDhOhdM3IaJK7p7f
         3jwiJLhG7ZEoPidbPyUBSa+4+Y9vmlw3lF8w1Vx7OkhfeHwdsXBJPfH07RZXWPQtdslW
         Lm1g==
X-Gm-Message-State: AOJu0YzN0Qzm7rfcvXLBlUW0pzh39oYrE1cDEfKK/T/+0uhMRppMyg/3
	P9rReX6xlFkYwtWJ2SMQUmWfG5bbBHI=
X-Google-Smtp-Source: AGHT+IGNy+HU+N5tv7x0fUIrCe4mmS6bK7pIcPMJwuc0RKiKlYywyQbgsSy3o1ob8znmYWa2iQv+VMZVtfI=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:903:404b:b0:1ca:6b41:2a37 with SMTP id
 n11-20020a170903404b00b001ca6b412a37mr8367pla.5.1697761496902; Thu, 19 Oct
 2023 17:24:56 -0700 (PDT)
Date: Thu, 19 Oct 2023 17:24:55 -0700
In-Reply-To: <20230928231644.3529127-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230928231644.3529127-1-jonathantanmy@google.com>
Message-ID: <owlymsweqgx4.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v4 2/4] trailer: find the end of the log message
From: Linus Arver <linusa@google.com>
To: Jonathan Tan <jonathantanmy@google.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, 
	Glen Choo <glencbz@gmail.com>, Christian Couder <chriscool@tuxfamily.org>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan, it's been a while because I was on vacation. I've forgotten
about most of the intricacies of this patch (I think this was a good
thing, read on below).

Jonathan Tan <jonathantanmy@google.com> writes:

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> From: Linus Arver <linusa@google.com>
>> 
>> Previously, trailer_info_get() computed the trailer block end position
>> by
>> 
>> (1) checking for the opts->no_divider flag and optionally calling
>>     find_patch_start() to find the "patch start" location (patch_start), and
>> (2) calling find_trailer_end() to find the end of the trailer block
>>     using patch_start as a guide, saving the return value into
>>     "trailer_end".
>> 
>> The logic in (1) was awkward because the variable "patch_start" is
>> misleading if there is no patch in the input. The logic in (2) was
>> misleading because it could be the case that no trailers are in the
>> input (yet we are setting a "trailer_end" variable before even searching
>> for trailers, which happens later in find_trailer_start()). The name
>> "find_trailer_end" was misleading because that function did not look for
>> any trailer block itself --- instead it just computed the end position
>> of the log message in the input where the end of the trailer block (if
>> it exists) would be (because trailer blocks must always come after the
>> end of the log message).
>
> [...]
>
> As it is, the reader still needs to know that trailer_start is where
> the trailer would start if it was present, and then I think it's quite
> natural to have trailer_end be where the trailer would end if it was
> present.
>
> I believe the code is simpler this way, because trailer absence now no
> longer needs to be special-cased when we use these variables (or maybe
> they sometimes do, but not as often, since code that writes to the end
> of the trailers, for example, can now just write at trailer_end instead
> of having to check whether trailers exist). Same comment for patch 4
> regarding using the special value 0 if no trailers are found (I think
> the existing code makes more sense).

I think the root cause of my confusion with this codebase is due to the
variables being named as if the things they refer to exist, but without
any guarantees that they indeed exist. This applies to "patch_start"
(the patch part might not be present in the input),
"trailer_{start,end}" (trailers block might not exist (yet)). IOW these
variables are named as if the intent is to always add new trailers into
the input, which may not be the case (we have "--parse", after all).

Looking again at patch 4, I'm now leaning toward dropping it. Other
than the reasons you cited, we also add a new struct field which by
itself does not add new information (the information can already be
deduced from the other fields). In the near future I want to simplify
the data structures as much as possible, and adding a new field seems to
go against this desire of mine.

>> Combine the logic in (1) and (2) together into find_patch_start() by
>> renaming it to find_end_of_log_message(). The end of the log message is
>> the starting point which find_trailer_start() needs to start searching
>> backward to parse individual trailers (if any).
>
> Having said that, if patch_start is too confusing for whatever reason,
> this refactoring makes sense. (Avoid the confusing name by avoiding
> needing to name it in the first place.)

I think the existing code is confusing, and would prefer to keep this
patch.

>> -static size_t find_patch_start(const char *str)
>> +static size_t find_end_of_log_message(const char *input, int no_divider)
>>  {
>> +	size_t end;
>> +
>>  	const char *s;
>>  
>> -	for (s = str; *s; s = next_line(s)) {
>> +	/* Assume the naive end of the input is already what we want. */
>> +	end = strlen(input);
>> +
>> +	/* Optionally skip over any patch part ("---" line and below). */
>> +	for (s = input; *s; s = next_line(s)) {
>>  		const char *v;
>>  
>> -		if (skip_prefix(s, "---", &v) && isspace(*v))
>> -			return s - str;
>> +		if (!no_divider && skip_prefix(s, "---", &v) && isspace(*v)) {
>> +			end = s - input;
>> +			break;
>> +		}
>>  	}
>>  
>> -	return s - str;
>> +	/* Skip over other ignorable bits. */
>> +	return end - ignored_log_message_bytes(input, end);
>>  }
>
> This sometimes redundantly calls strlen and sometimes redundantly loops.
> I think it's better to do as the code currently does - so, have a big
> if/else at the beginning of this function that checks no_divider.

Will update, thanks.
