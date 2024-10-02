Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33631E500F
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862897; cv=none; b=QWMKxI8eCayfoEIeHeiVu1FU2BR2qVr0Q1UvPm5BzU32ocjVYx5RwWIXWq6ClUtweaiBpqEBWUhK5atbhghfKWic0CoskE+RjgocLyeqAH78fzHVYM5+4rGzopxZuLvMaXkBtQmt/gIbnf36Q+U8RjpXwi4xrJqWkuj0XV6AqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862897; c=relaxed/simple;
	bh=0E9byfvs9jm0Bc3/HcX34NhaoikMWCRHGvy5wrJ5BNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLdWCw4TeC/iOSEqaFItdaltW5BZ4bX1ShtRB2v3SrZd5S31tdgK3chVJxSikeYWn3EZLnkxNX64B6l6B/trYXPTsH3pGnbUzaM8RV7XUmDuob5MA1nZB+Zsh80DpwawCoJ0TBU8C8fM5EFQw0JUzYGJR4M0ZSxGoGwInWYWCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLP1b26F; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLP1b26F"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8d4093722bso962125266b.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727862894; x=1728467694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iPdhj8gJ+E5VQQ63E1cB05aHgmpJQQYbAbl4Y9KR0pc=;
        b=TLP1b26Fq0O8Lb7gKxxY5Y2cA3y9bN5skqpyIaNnKNgfcO4moDwno4kknn2puPQgQE
         pZa8uPeF32tZAoX4qMgeTRrGhbs5aL2D5NWyJenP9zLgjTOwg+T6AYgwZWr+WxkAF77/
         JKhaPIbnpIOBC7+jy57aT1yNo4ongcI+6oxghc2bGEhsnZOwcj6acX5LTnFKSzQesnLA
         3XEclX1Ug6x5QF/f5QwlGMPbjyAIgLnYcrkt4cUiDk09fRBO/YL7tWYZyXGnZTZi7nms
         XkujrPeMMlUwKOvirH7JOmWX4H4Rbx497Qc2efziwmj2hxkCKHEbW3omWsLTGKj1V8K2
         YPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862894; x=1728467694;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPdhj8gJ+E5VQQ63E1cB05aHgmpJQQYbAbl4Y9KR0pc=;
        b=Hg8KBxRxwHt8suVP2co2YiCjNHM/eNZvPnnbcfnOhlV+yh5f9n09KRMEdRhTWZJ3nU
         646MwSFp0WSnoYvQEoZUGHJZLhbtqqsSV/J3gvMUemA0u24PjJFj/ufXmInvDIRIZv8z
         2q5rPm7kF6hcpdk7AUd8qkdiJvqLhzpBw30bjasH2RhNU5p3upOasGs4z7bKpwN4FTYb
         bm3sz3sZfoSUS6u3zxP7QU9DyuH+JCsDP10bxg7J3IQMJey4i9DvAtbFMGhODOKmyKZT
         nwPTZxf+/QbLbz5lmQ6/USnI9pKFNJ45QjVUpFgn7shh7G/xdZyyIZa11Hy1viTo5xiG
         KIag==
X-Forwarded-Encrypted: i=1; AJvYcCXfbwIQr3KvsynVMeJbZUZrZv3l8OyAqVXvPwr1+jL1fNFm1n0zcJMq+u+1U3/fXuhDKPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHibPkpiPY1OcQ2y2HGtzcnnd0rspahlVzspVsW7u/ZgMkp+er
	4HSXDkrNJAMaqiJBEUSuYtn4eUNqrksIKjXJTk5OB6jC/LaTNiMn
X-Google-Smtp-Source: AGHT+IH/sK+vorroZ+jU2gEvb/nh9gALKbviotzyiuy88F0cj7sMY0/H7Ghosi14YjV/eZK1wmQIww==
X-Received: by 2002:a17:906:f591:b0:a8a:837c:ebd4 with SMTP id a640c23a62f3a-a98f82600famr262800366b.27.1727862893708;
        Wed, 02 Oct 2024 02:54:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c277726asm854484566b.10.2024.10.02.02.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 02:54:53 -0700 (PDT)
Message-ID: <2d2f14ea-cfdc-4b52-948f-b42c8f6e41de@gmail.com>
Date: Wed, 2 Oct 2024 10:54:52 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/1] Add a type for errors
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Emily Shaffer <nasamuffin@google.com>, Junio C Hamano
 <gitster@pobox.com>, Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <20240930220352.2461975-1-sandals@crustytoothpaste.net>
 <20240930220352.2461975-2-sandals@crustytoothpaste.net>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240930220352.2461975-2-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

Thanks for working on this.

On 30/09/2024 23:03, brian m. carlson wrote:
> There is work underway to move some of the Git code out into a reusable
> library.  In such a case, it's not very desirable to have the library
> code write random errors to standard error, since this is an antipattern
> which annoys terminal users.
> 
> Instead, we will expect callers of our library function to return
> errors. 

Isn't it the callers that will expect the function to return an error?

> The reusability of our library will be substantially improved
> if we return typed errors so that users can easily determine what kind
> of error might have occurred and react differently based on different
> contexts.  For example, if we are looking up an object in a partial
> clone and it's not found, we might decide to download it, but we might
> return an error to the user if the problem is instead that the revision
> specified is not syntactically valid.
> 
> To help the libification process and make our code more generally
> maintainable, add an error type.  This consists of on 64-bit integer,
> which contains bit flags and a 32-bit code, and a pointer, which depends
> on the code.  It is designed to be passed and returned by value, not
> pointer, and it is possible to do so in two registers on 64-bit systems.
> Similar functionality works well for error types in Rust and for the
> standard library's lldiv_t, so this should not pose a problem.

Part of the reason it works well in rust is that it supports 
discriminated unions with pattern matching and has the "?" macro for 
early returns. In C the code ends up being quite verbose compared to 
taking a pointer to error struct as a function parameter and returning a 
boolean success/fail flag.

     struct git_error e;
     struct object_id oid;

     e = repo_get_oid(r, "HEAD", &oid);
     if (!GIT_ERROR_SUCCESS(e))
         return e;

With a boolean return we can have

     struct object_id oid;

     if (repo_get_oid(r, "HEAD", &oid, e))
         return -1;

where "e" is a "struct git_error*" passed into the function.

> Provide the ability to specify either an errno value or a git error code
> as the code.  This allows us to use this type generically when handling
> errno values such as processing files, as well as express a rich set of
> possible error codes specific to Git.  We pick an unsigned 32-bit code
> because Windows can use the full set of 32 bits in its error values,
> even though most Unix systems use only a small set of codes which
> traditionally start at 1.  32 bits for Git errors also allows us plenty
> of space to expand as we see fit.

I think the design of the struct is fine. It does mean we need a global 
list of error values. GError [1] avoids this by having a "domain" field 
that is an interned string so that error codes only need to be unique 
within a given domain. I think that for a self-contained project like 
git a global list is probably fine - svn does this for example [2].

[1] https://docs.gtk.org/glib/error-reporting.html
[2] 
https://github.com/apache/subversion/blob/be229fd54f5860b3140831671efbfd3f7f6fbb0b/subversion/include/svn_error_codes.h

> Allow multiple errors to be provided and wrapped in a single object,
> which is useful in many situations, and add helpers to determine if any
> error in the set matches a particular code.

The api appears to require the caller know up front how many errors 
there will be which seems unlikely to be true in practice. I think a 
more realistic design would allow callers to push errors as they occur 
and grow the array accordingly. For example ref_transaction_prepare() 
would want to return a list of errors, one for each ref that it was 
unable to lock or which did not match the expected value but it would 
not know up-front how many errors there were going to be.

It would be useful to be able to add context to an error as the stack is 
unwound. For example if unpack_trees() detects that it would overwrite 
untracked files it prints a error listing those files. The exact 
formatting of that message depends on the command being run. That is 
currently handled by calling setup_unpack_trees_porcelain() with the 
name of the command before calling unpack_trees(). In a world where 
unpack_trees() returns a error containing the list of files we would 
want to customize the message by adding some context before converting 
it to a string.

> Additionally, provide error formatting functions that produce a suitable
> localized string for ease of use.

I share Emily's concern that this function has to know the details of 
how to format every error. We could mitigate that somewhat using a 
switch that calls external helper functions that do the actual formatting

     switch (e.code) {
     case GIT_ERR_OBJECT_NOT_FOUND:
         format_object_not_found(buf, e); /* lives in another file */
         break;
     ...

I know this is an RFC but I couldn't resist one code comment

> +#define GIT_ERROR_SUCCESS(e) (((e).code == GIT_ERROR_BIT_INIT))
> +#define GIT_ERROR_SUCCESS_CONSUME(e) ((git_error_free(&(e)).code == GIT_ERROR_BIT_INIT)

git_error_free() returns the code as in integer so we don't need ".code" 
here. Also our coding guidelines would suggest git_error_clear() for the 
name of that function.


In conclusion I like the general idea but have concerns about the 
verbosity of returning an error struct. It would be helpful to see some 
examples of this being used to see how it works in practice.

Best Wishes

Phillip

