Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E957B3F9FB
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 03:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174914; cv=none; b=DyPQnFF27c1+YXiDAP9gYzKvUia6OqgcPNA2uaVsjPu3khpVjduaF9QQJWl6qhe5o5ouZIuERiAEew/MjcUA9JUlp+EeZqjLgBRF1Z2MBt6Fu80mjZGM80nxG+4RwJljmasvxIMGfVmD/rCnZQ4xjTXEmQ71VdDl5Dy4bnU/yek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174914; c=relaxed/simple;
	bh=wk6UcwUx/SdQOrUqzvGQO+Ag4rmJ0A07Jx+9m4cykuc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N61RVDGOoDScGQRIEjsItv70AfnCVsPqrJJ5SqNE5jK2uJLeaIm5zUug1Rwr+rsO0Q6MCiIgftkp0RAn+v1XOQG0cako8gg8LgjXizuiC/QGpUqH7LzpZ9gjG18FfQ6kWGVkZo5gMdVvaEbao3pXQSpbhnw+CXxy2ZSOOzHWZRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyRBHBZe; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyRBHBZe"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c868b197eso4629074a91.2
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 19:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770174912; x=1770779712; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lx3p0RhP30wIVTtCNBQwKTGu3e+Oh47X+SgYjVMqG1E=;
        b=kyRBHBZeYXnwGnclpMGkmcNWhcYpXNImLN03Rb2uQ67Uy1f2CQaoo+wzi7D9AvMBGL
         0jCraNVS3jgjIki4kIo4nOpwxzaK9lSf180rIKM/sWKLxFlZwqfRVX2/5azzWXAeYedB
         hn2d70ye+t+Vz1kHelYsd8iMZlqruGM4krZ1ICDRUxgdbtaXDRLTgN4b5+Ns3pWaXVBl
         1gLs8Cj1jT4s+OGMZ8zYo4vA7MAPvZVguJnAdp0q0K/WMHuppV3augdb0MwSvNUhNKKF
         sXphLhft1JzoCaZQRIPgmxK4wykeC0iEfR6VxOjZPYYxOllyfbDRw4VJHKZ+Z0LSOEs6
         WkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770174912; x=1770779712;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lx3p0RhP30wIVTtCNBQwKTGu3e+Oh47X+SgYjVMqG1E=;
        b=bCr3NUnB6rCVsgVld/OhYc1JfpN0SKfZOqNiBvlHKs7v5RBxuM9OfEdlJQHb1qsv2B
         36mg9Fo+Qgild/rRuT/kiPJsZE4wkOQ3fZR1D8v7UEGhnom3qJgCDM6GHTbEMg8nJDhn
         PQyEaRPoHbd39T9ujvrtiM1+FXqZr6ga0/1dz8O1X2NNGH4pu1Plkw0kVnpxBhmNOlC6
         qg4lerR24tTX4NbL7bqXJPREzovWmwKnPnHeRqZwS3XqjOFD7Bmkb5ZCCl52Ei0T4H5i
         7rKVZI7h4yTTmuySOreR7Y3eHO+5NifdfQPz0m5csQ+Pavsbis4GTQff9IXe2aouNEYb
         Heaw==
X-Gm-Message-State: AOJu0YyqwbvkB6Gw5h2LiyN1HutiFua0UJADZI4J1KwkyqhF/jDxL0pf
	TK7xcHar64aM3FbsuiBguSLNrPQck684HZwsilsVpgrk0+iu7ggEVq6i
X-Gm-Gg: AZuq6aJn37s5pwkVKL5YIJCLT+G+4HpXP8bJoqhUUArz83TYLijFHSd5m/UfMU2F1TH
	KH2Ef6Z9TGH9qmJIhHaWWiH1io9R5g4OP6doKkxeL6veQVKno/DDGz+EtdpDO7QL2GbRVE3N29Z
	gLdv4BsuytZ7eYl6rxVnk8+Q+Uszh61xfjE2poBjV245SabEKu79UZd9ZjdciQBm/eznQ9l4VVE
	OjHvBfFiekRoSOpuRR2uC+3gvOdWyQDCqU8Jklmfgppyr5RtoqWE+MblozufnVZ08+LoSokG2lq
	VvHsuv9kPAFnv/gadVuGF4zclPn0lyKstWppksZJaLqHI7oxWc2T/cfSjp/fQmGznNI7T4uk2HH
	gWdbCJt6KfGgvpWRqWOBbxhiKhwSg47snlXPgltLtBl5HiAcdDlG5wjnnPpY2WU3jhUQu
X-Received: by 2002:a17:90b:554f:b0:352:e796:bb65 with SMTP id 98e67ed59e1d1-354871b9ba3mr1262847a91.31.1770174911992;
        Tue, 03 Feb 2026 19:15:11 -0800 (PST)
Received: from fedora ([2601:646:8081:3770::996e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d438f1dsm697086b3a.32.2026.02.03.19.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 19:15:11 -0800 (PST)
From: Collin Funk <collin.funk1@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Junio
 C Hamano <gitster@pobox.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  Matthew John Cheetham <mjcheetham@outlook.com>,  Victoria Dye
 <vdye@github.com>,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] git-compat-util: make git_find_last_dir_sep return a
 const pointer
In-Reply-To: <20260203062537.GA286409@coredump.intra.peff.net>
References: <e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com>
	<20260203062537.GA286409@coredump.intra.peff.net>
Date: Tue, 03 Feb 2026 19:15:10 -0800
Message-ID: <87ecn18aip.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Mon, Feb 02, 2026 at 09:19:01PM -0800, Collin Funk wrote:
>
>> Unsure if this should be tagged [RFC], but this patch clears up lots
>> of warning spam with glibc 2.43 because of a change mentioned in the
>> commit message.
>
> Thanks for the heads-up. I can reproduce here by installing glibc 2.43
> via "apt install -t experimental libc6" on my debian unstable machine.
>
>> I plan to handle the rest of them and try to organize the changes by
>> subsystem, for lack of a better term. But I figured it was best to
>> submit just this one for review first.
>
> Wow, there's...a lot of spots. Looks like ~65 of them based on my hacky
> first-pass. Many of them are quite obvious "s/char/const char/" fixes in
> variable declarations, that should have been const all along. I think
> those can all go together in one patch, as the compiler can verify that
> we never try to write to the result.

Yep, it is quite noisy.

And that plan makes sense to me. I'll create a seperate patch handling
the obvious 's/char/const char/' conversions that make sense regardless
of this glibc change.

> And then, yeah, I'd do the tricky ones system by system. Some of the
> ones that do write to the resulting pointers are rather nasty, and seem
> to fall into one of two camps:
>
>   1. Some function interface takes a const pointer, even though we try
>      to write to it under the hood (after laundering it through strchr()
>      or similar). I think it would be worth refactoring these interfaces
>      when we can, though some of them are pretty questionable. For
>      instance, all of the rev-parse/revision.c "dotdot" parsing works on
>      a "const char *arg". Surely we feed this from command line options
>      in some cases? I guess argv is guaranteed to be writable by the
>      standard, though we tend to treat is as const everywhere.

Yes, I see. I think the "arg" there is from the command line or from a
buffer read using fgets() in get_object_list from
builtin/pack-objects.c, so it is safe to write to there.

It's also called like this though:

    handle_revision_arg("HEAD", &revs, 0, 0);

We can't write to the string "HEAD", but it doesn't have a "dotdot" so
we don't. It could probably be cleaned up a bit.

FYI, that code would also be made much clearer if not all of the
declarations were at the top of the function. I guess it just hasn't
been touched in a long while.

>   2. We know we have a non-const pointer, but it is passed through a
>      const pointer that is used as an out-parameter to a function like
>      skip_prefix(). For instance, in http.c's redact_sensitive_header()
>      we have something like this:
>
>         const char *sensitive_header;
> 	if (skip_iprefix(header->buf, "Cookie:", &sensitive_header)) {
> 		const char *cookie = sensitive_header;
> 		char *semicolon = strchr(cookie, "; ");
> 		*semicolon = 0;
> 		...
>
>      Our header->buf here is a strbuf, so we know we are working with a
>      non-const buffer. We launder away constness with the strchr()
>      assignment to "semicolon", which glibc now complains about. We
>      should make "cookie" non-const, which is easy. But now we'll get a
>      complaint about assigning the const "sensitive_header" to it. And
>      that one should _also_ be non-const, because it comes from
>      header->buf. But switching it will cause the compiler to complain
>      about passing it to skip_iprefix().
>
>      So we have the problem in reverse (instead of laundering a const
>      string to a non-const, we've accidentally added constness where it
>      is not needed). If we drop the const from skip_iprefix(), then that
>      has fallout in all the other spots that do pass in a const haystack
>      parameter.
>
>      I don't know what the right solution is here. I guess the best we
>      can do is probably adding casts with comments like "this is OK
>      because it comes from...". But I'm not sure if we are better to
>      cast away the constness in one spot, or to make all of the
>      variables non-const and cast the out-parameter to skip_iprefix().

Makes sense, I'll try to handle the non-obviously ones separately.

>
>>  #ifndef find_last_dir_sep
>> -static inline char *git_find_last_dir_sep(const char *path)
>> +static inline const char *git_find_last_dir_sep(const char *path)
>>  {
>>  	return strrchr(path, '/');
>>  }
>
> This kind of recreates that reverse problem again, though: any caller
> who really does have a non-const "path" will get "const" added back into
> it. And that leads to casts like...

I figured it was okay since only one place casted the qualifier away.
But I agree it is probably worth cleaning that up later.

>>  static int chop_last_dir(char **remoteurl, int is_relative)
>>  {
>> -	char *rfind = find_last_dir_sep(*remoteurl);
>> +	char *rfind = (char *) find_last_dir_sep(*remoteurl);
>>  	if (rfind) {
>>  		*rfind = '\0';
>>  		return 0;
>
> ...this one. Can we implement it as a macro? That lets the compiler do
> the right thing, because we do not declare any type then. It used to be
> a macro, but switched in bf7283465b (turn path macros into inline
> function, 2014-08-16). There's also a level of macro indirection; on
> Windows this expands to win32_find_last_dir_sep(), which of course casts
> away the constness manually. ;)
>
> I also wonder if we could do some gcc/glibc-specific magic to get the
> best of both worlds. That is, could we get the same "the return value is
> const if the input parameter was" type-checking that is happening with
> strchr()?
>
> Looking at strchr()'s declaration in string.h, which is defined like:
>
>   #  define strchr(S, C)                                          \
>     __glibc_const_generic (S, const char *, strchr (S, C))
>
> I think the answer is probably "yes". But it also doesn't quite solve
> our problem. That would give us type-checking of callers of our
> function, but we still have to convince the compiler not to complain
> about its implementation. For that we'd need to either cast away const
> manually, I guess.

That macro depends on Generic selections from C11 [1]. I wasn't sure if
Git would like that, given it is conservative with other C features.

> Yuck. What a mess. I do think that fixing these warnings will improve
> most of the call-sites I looked at, but some of them get a bit hairy.

Thanks to C23. :)

Collin

[1] https://en.cppreference.com/w/c/language/generic.html
