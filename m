Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA014600F
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032430; cv=none; b=SRsx4+pFveyYFL8jXD/PJ0qkTmRzeKe052hmUzcfhTJ4aqrLFv2nBzEk1Jf5jyOsQYMo3kwqlaiGIxIw6+0Db12pcFjR7h+ulwnvNOP5haIBVE3qaLg2MnCFMNy0qaXvj29K2XMw7RYT5xw8tesusmuo3R+kHtMXbl+BuSv8G/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032430; c=relaxed/simple;
	bh=KCkx/F5KBIZzqZD8ZxAOW6YlBZ61SPbj0XyLTZl+n18=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NVRnVoChhoayypmF1LkY7NjmUrXMrYurE6JsOwjFDHKBcYJXEpp6zkaF0dZcLqMP5n5WqMD8ljICsBk/EV48po9He1vLl7SQgmNQ08MDQhb6uOky1ktPXe1VcDzNjtmXeST8qtCnkgI1iN4mQlkgEWSSy3oFUwRUOCIOcS9G1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkPsWqPS; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkPsWqPS"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5389e24a4d1so2209232e87.3
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728032426; x=1728637226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mn6qMVvL9kXUHG/+8wpBsvckiV8b9ytFiF+ryWxXBmk=;
        b=BkPsWqPSsSdI11qIDVwbmi5uVtqZGD1Uk9sMDfBvBH2jVX1dC0DD+z0dMrpf013lgf
         zDq0JGiKfE3+9VqvNF/URlftH1WNqIp9fhEQ3T18H+zWUD378jIthNhFzBZP4fjDRuAi
         tULOuOJsHV3nyuQcde3HdXS+fF6saxq0S0PTmM+GQ6oI17WV/BBiN0rkeM9U5g6BM/SR
         lOsGKJ1H+XsZ9+n3mm9MGkERhwbO9bSp674mTn8+V9r+XYggpJMOhlZ1ETZG7YOK07K2
         EmvA/n7uSEmVPEX+NEaiXAiJIjKuFwrf2RM3iQiRxfyiCVbnlCDVzKV0NLFu5LRfnmda
         7MPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728032426; x=1728637226;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mn6qMVvL9kXUHG/+8wpBsvckiV8b9ytFiF+ryWxXBmk=;
        b=N/wOc79xjr0IfGffMeps52mmIDdhFSzN0/2jULyfdk2GyR81RHey5kPutscty8jlLI
         LVajLld/6t9h4faa+JD5bW3Dp5pAGcTPhVhd6e9ntANKsHwpL+Umwifb0S1jh0c5EaoL
         LUXPyCJ1IFCUXJkTY/BrZBri9gWHfQgnzKoEG20+OUGLpRoWa/7NAXwRDF0uzs4upawk
         R4+YDo/Bzyck0ZRv1gk2QCxjvf3dIsxyoQQCuRP1eXVbJLKneujmteFNOuIn8+2/hUca
         dZLOJ7GseztUXGcUQdKSjatG1cdpx5ye9vk2QQ4XkOtfwhciOENdFv7kctUbsRcHkjTt
         n7NA==
X-Forwarded-Encrypted: i=1; AJvYcCXaHsUBA9GyOnAdJH2YWTViQJIXqwkuhfgHL70M19a8QDB7/jHRpQ6psuH1xdtfBDHMYhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/stLnMQXyh/72Sn9yyOpkaayYcKWtAp96TOLuRySGVNL4pZkv
	D93AEk0Qb5ws/ZRmrezKlna97Vb7z6sF3EwvcpWB1MvZBzGtCL1B
X-Google-Smtp-Source: AGHT+IEhK2HNheRwjbCONP38xm8xJsbX3ALsmXKwRs/44YOys+CJ36sNnEFhFEWcU9y/y7l56Aio4Q==
X-Received: by 2002:a05:6512:3c8c:b0:537:a745:3e with SMTP id 2adb3069b0e04-539ab8add14mr1031221e87.45.1728032426118;
        Fri, 04 Oct 2024 02:00:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99102ab1b5sm196708866b.97.2024.10.04.02.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 02:00:25 -0700 (PDT)
Message-ID: <9731c23c-4383-42c4-83f6-1cf6b25f89d8@gmail.com>
Date: Fri, 4 Oct 2024 10:00:24 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/1] Add a type for errors
To: Emily Shaffer <nasamuffin@google.com>, phillip.wood@dunelm.org.uk
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
 <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
 <CAJoAoZnhY0Z7XdNqt8A598jptiNVDJC=4kT5n_n1FCGN5GkXRg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJoAoZnhY0Z7XdNqt8A598jptiNVDJC=4kT5n_n1FCGN5GkXRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Emily

On 03/10/2024 17:17, Emily Shaffer wrote:
> On Wed, Oct 2, 2024 at 2:54 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Part of the reason it works well in rust is that it supports
>> discriminated unions with pattern matching and has the "?" macro for
>> early returns. In C the code ends up being quite verbose compared to
>> taking a pointer to error struct as a function parameter and returning a
>> boolean success/fail flag.
>>
>>       struct git_error e;
>>       struct object_id oid;
>>
>>       e = repo_get_oid(r, "HEAD", &oid);
>>       if (!GIT_ERROR_SUCCESS(e))
>>           return e;
>>
>> With a boolean return we can have
>>
>>       struct object_id oid;
>>
>>       if (repo_get_oid(r, "HEAD", &oid, e))
>>           return -1;
>>
>> where "e" is a "struct git_error*" passed into the function.
> 
> I actually don't find this complaint all that compelling; it's not
> hard to write a shorter macro that can be used inline, so we can do
> things like:
> 
>      ERR_VAR(e);
>      if(ERR(e, repo_get_oid(...))
>        return e;

Right, but what's the advantage over passing the error struct as a 
function parameter? It feels like we're adding extra complexity and 
hiding the assignment to "e" to work around the inconvenience of 
returning a struct rather than a flag. Is there some other advantage to 
returning a struct that makes this worthwhile?

Best Wishes

Phillip

> or even a macro to do the return if desired:
> 
>      ERR_VAR(e); // or, i guess we can be not SO lazy and just write
> struct git_error e here, whatever :) )
>      RETURN_IF_ERR(e, repo_get_oid(...));
> 
> For better or worse, you can do a lot of things in a macro, so I don't
> see verboseness as much of an issue because I think we can hide a lot
> of it this way.
> 
>>
>>> Provide the ability to specify either an errno value or a git error code
>>> as the code.  This allows us to use this type generically when handling
>>> errno values such as processing files, as well as express a rich set of
>>> possible error codes specific to Git.  We pick an unsigned 32-bit code
>>> because Windows can use the full set of 32 bits in its error values,
>>> even though most Unix systems use only a small set of codes which
>>> traditionally start at 1.  32 bits for Git errors also allows us plenty
>>> of space to expand as we see fit.
>>
>> I think the design of the struct is fine. It does mean we need a global
>> list of error values. GError [1] avoids this by having a "domain" field
>> that is an interned string so that error codes only need to be unique
>> within a given domain. I think that for a self-contained project like
>> git a global list is probably fine - svn does this for example [2].
>>
>> [1] https://docs.gtk.org/glib/error-reporting.html
>> [2]
>> https://github.com/apache/subversion/blob/be229fd54f5860b3140831671efbfd3f7f6fbb0b/subversion/include/svn_error_codes.h
>>
>>> Allow multiple errors to be provided and wrapped in a single object,
>>> which is useful in many situations, and add helpers to determine if any
>>> error in the set matches a particular code.
>>
>> The api appears to require the caller know up front how many errors
>> there will be which seems unlikely to be true in practice. I think a
>> more realistic design would allow callers to push errors as they occur
>> and grow the array accordingly. For example ref_transaction_prepare()
>> would want to return a list of errors, one for each ref that it was
>> unable to lock or which did not match the expected value but it would
>> not know up-front how many errors there were going to be.
>>
>> It would be useful to be able to add context to an error as the stack is
>> unwound. For example if unpack_trees() detects that it would overwrite
>> untracked files it prints a error listing those files. The exact
>> formatting of that message depends on the command being run. That is
>> currently handled by calling setup_unpack_trees_porcelain() with the
>> name of the command before calling unpack_trees(). In a world where
>> unpack_trees() returns a error containing the list of files we would
>> want to customize the message by adding some context before converting
>> it to a string.
>>
>>> Additionally, provide error formatting functions that produce a suitable
>>> localized string for ease of use.
>>
>> I share Emily's concern that this function has to know the details of
>> how to format every error. We could mitigate that somewhat using a
>> switch that calls external helper functions that do the actual formatting
>>
>>       switch (e.code) {
>>       case GIT_ERR_OBJECT_NOT_FOUND:
>>           format_object_not_found(buf, e); /* lives in another file */
>>           break;
>>       ...
>>
>> I know this is an RFC but I couldn't resist one code comment
>>
>>> +#define GIT_ERROR_SUCCESS(e) (((e).code == GIT_ERROR_BIT_INIT))
>>> +#define GIT_ERROR_SUCCESS_CONSUME(e) ((git_error_free(&(e)).code == GIT_ERROR_BIT_INIT)
>>
>> git_error_free() returns the code as in integer so we don't need ".code"
>> here. Also our coding guidelines would suggest git_error_clear() for the
>> name of that function.
>>
>>
>> In conclusion I like the general idea but have concerns about the
>> verbosity of returning an error struct. It would be helpful to see some
>> examples of this being used to see how it works in practice.
>>
>> Best Wishes
>>
>> Phillip
>>

