Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5B6390981
	for <git@vger.kernel.org>; Tue, 15 Sep 2026 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464749; cv=none; b=djGNLOORkST/SGDK6H9TO0ONmHIu0oMpua+MeHPnBIyeCoRMU6Wf+2TYxNTJ4mBVVdjPzXiKBuhbZskPSB5Gh7xaw2uUkc8PbFy4OwjO1cwyu7mBAwb25c/guFL0IXWJCe90tiblorYCx/nJafw0dzoUdPzxLY0FViEzQjtwnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464749; c=relaxed/simple;
	bh=DMOagwHDZMI+eQ3i4e9jH799uvBsHNUpsWwkq1ilQJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MmJPmEAmwptZq1cS3XygpHqj3omED514W1It5QJmC7w+YDdrpA1eI6//PNOfkhd4R37uB6QKfq0u8uReRAQ/tuu9CEIdpQBmbcnPLETcnHj5LADtGPNL+dISKe7CjYm63WOFQ7+m7t4M6Z199OhMmHXe+RfQv1JVsJC/zSkltSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAe/TmiW; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAe/TmiW"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso3023215a91.1
        for <git@vger.kernel.org>; Tue, 15 Sep 2026 02:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789464746; x=1790069546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A0KH5FSvtOg+pVl2aH3ewGO13o34CQzNia+ZASrOF6Y=;
        b=EAe/TmiWvuTPChsoYy0+ERvetk1Xby/6krIH1gvsXLcQp66AohLve6aCgEFbZeEl1C
         ysC2zfBHPfQYcjqehMtN/TfYL8qqJn+R4jEwxAnpvXB9EjPpzNDu7YKATX1neBy+/bUq
         cFh3GCUHq4ZIBOPjRvfKXpaRgzcwxK5jLZtbtYvGEWwAoY5AhIg22uX7vb2Qt3pfR0HQ
         ZHGkZ03ZygmdBowLQBGb+fOYbnAYHjNuKd36J86lqHi5HQx5XIk6/G+vAs2Z0VyCwOMt
         ni1SZUbiblIol2jFLrgPofUZCnjY1CU9Qi9i9F3X2/n6VbynK60PC6tQJFtv3XrwkQFg
         Q+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789464746; x=1790069546;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A0KH5FSvtOg+pVl2aH3ewGO13o34CQzNia+ZASrOF6Y=;
        b=YtaBmFuI+CR9sac0cjnHIVE+gWa6+Wd4/OzZCBrYaowJz7NF9BdO7HPJ155sr53qc+
         NYvYcQ2mnmp62Lzi8tTtqTXrdlIsfryMPKcChcsRgjl1x8nFWYkH8XY7At3qevCHRs3m
         uMXuErqQ3podb5SnUSybGY/dcwdSU4OUfLy1tlY7bIzguMJ3YLJVxyhCKK1mLqUHtu/G
         xcRlvzAiq1IKt/dbnyISK/dMeUOH+edAlcY/iRdPGjfkOHc0jcdsx3q4ZwEXBkqZWy1A
         httcKO7nqCCa5gmNr4kg7rXkFlp9rNl6qwTXhxFzft4yopPGuLoe4bOIfqj6rYO7LDZo
         Rt5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwhIh44BayHFtodgVkBUOTtCjAutT9PFnagjtaz6wmK31j+2Wr0+3QNM5YArQeaSv+sd04=@vger.kernel.org
X-Gm-Message-State: AFuF++lchGvcDQl/umgoDX2jTm6FxwIT7owzkaUZ+zcDnnBa6MudoRtl
	KWvvh8uWKELW5Aq4ANcb+Mq7ztDyjxU0024QF7ACsQnG4kKyyqVTaRND
X-Gm-Gg: AYBFou1qhtOPDx+GMzPzFXqoF0xtBPFPy+zEJgq/p9M5nlH6+AWtl3Woy9lR8hDneyK
	lw2gFfw+wBMoYdGcTcwJ1too4idAWqjb4qNWsA++7UxWOdrnJGwOcKiumX7+tASdVFKyW7Mu6mf
	AIJ9XT2Pf5ylEtzzjJfkw8Z8Txm4/FezqY/UzyQ42FeyZ6++0WSKT6ePyic5NoLIV9AVQhj9Zmk
	tlVXPSmk0O/QeNQXsgY3I7Ts+pHDWs5235B90I++Qnc5S1NZCWTA4pWcDQ3DZTr+Xym/sSRWeHH
	v9/Lrg8+6O92pUrlLdfz2msljVTAQfBtTAMOn9XG1CbvVCXyd0jUtFcYnmt7D5Fu9DzbrydhBPW
	J7R9WSGEeyAoUaeTZvzE79d3vgYKDIdDP3zhCJcnOcKVlPPZGB1mbw5rqz6Bh0pICttSgqZYM20
	hWjQodF/pq5pTuMLSOK3v9/iWj2SjDwuA4CH/YDiGg/GnNLP8UTjNRBqjijxoFY41sjuvdBGhzW
	kzuNvACHAWYPds=
X-Received: by 2002:a17:90b:440b:b0:39d:e784:3e1c with SMTP id 98e67ed59e1d1-39dec0f7193mr13579332a91.19.1789464745781;
        Tue, 15 Sep 2026 02:32:25 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14365b345a4sm30670856c88.5.2026.09.15.02.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 02:32:25 -0700 (PDT)
Message-ID: <c5266fff-8247-48d2-9679-3fc1f649cf34@gmail.com>
Date: Tue, 15 Sep 2026 15:02:21 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] parse-options: allow for hidden aliases
To: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20260909-b4-pks-unify-ref-storage-format-v3-0-ca041fb40ad8@pks.im>
 <20260909-b4-pks-unify-ref-storage-format-v3-1-ca041fb40ad8@pks.im>
 <CAOLa=ZSh_H9tjnjEsRrmGXm1Ht+3a=gRaGibO6BKZvvkEabesQ@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAOLa=ZSh_H9tjnjEsRrmGXm1Ht+3a=gRaGibO6BKZvvkEabesQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 15:03, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>> The `OPT_ALIAS()` option can be used to create an exact alias that maps
>> one option name to the same semantics as another option name. This
>> option type is especially useful when deprecating an old name in favor
>> of a new one. But curiously enough, we don't have the infrastructure in
>> place to properly support this use case because we don't expose the
>> ability to hide the alias via `PARSE_OPT_HIDDEN`.
>>
> 
> If we're going to hide the alias, do we need to even use an alias?
> 
> [snip]
> 
> Perhaps it doesn't make sense to add flags to OPT_ALIAS() at all? But
> this is indeed an alias and seems like the correct option to use, but
> feels wasted. I'm okay to keep it as is.
> 

Just some food for thought. There are a couple of other instances where 
we are currently using OPT_ALIAS to represent the deprecated variant of 
an option. They are:

   1. `--recursive` is a deprecated alias of  `--recurse-submodule` in
      `git clone`

      cf. bb62e0a99f (clone: teach --recurse-submodules to optionally
      take a pathspec, 2017-03-17) and 5c387428f1 (parse-options: don't
      emit "ambiguous option" for aliases, 2019-04-29)

   2.  `--negotiation-tip` is a deprecated alias of
       `--negotiation-restrict` in `git fetch`

       cf. 1a445fc60b (fetch: add --negotiation-restrict option,
       2026-05-19)

       Note: The documentation clarifies that --negotiation-restrict is
       the preferred variant but does not mention about deprecation.

Since they are not hidden, the deprecated variants still show up in the 
help output of those commands. So, we appear to be doing fine with a 
public alias so far. So, may be it is not a big deal if we expose the 
deprecated option publicly?

-- 
Sivaraam

