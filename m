Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4107C6F6
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208113; cv=none; b=fQNnVxBjUx1uN3pRZsM/JnhniSBjhya45Vw1FQnxfhDv/VRaukPVXglL30my40iINPIwP5mTd71Yv6lRwaZCVMs4vRFowKu2D9MiHaD8oQJmutHff1V2wQ+ioxP3NziCTC+Bm3R5Km7ujdoS+3zhoytnL+d5WzcWEfKfWxPIpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208113; c=relaxed/simple;
	bh=vj+aM7yDEAfT9/1I+/hAIkFP7aRr7b+unpbWLyJ7Vrw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=L+lmzWUjAbbvhkV+/hk+3Hal+6MKswj0pZeCRP0/FOK6ALjgQdDQs53Q38euzd83rFlW+5LzGtIOMYppKLkjo3Y1gOCPwTGJpfVH7boXbOiNaCndAN5stQWultOVoeE+ZsT9np4WBoE0PMLrS2teM9SxZd9giK4sQWMZiPd+Zvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhXfxWXE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhXfxWXE"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e56d594b31so408121b3a.1
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 04:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709208111; x=1709812911; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQ8Yz/jkGjyjSDIVvNksNhYPBGRlSE4L4EJXFPpMMdU=;
        b=JhXfxWXEjBorCCSLJlhkB5xw8Exd2A2R3+K07fpG40lYUVTLrKRgg1pkTUnSeYmzjd
         K2M2tbQlst8WlihlvwOEwGVk9cXEX61xxIdCA7YYgyWEAuyyBbZLPRkySNSySTSgcs/1
         Ttv5oaK0Mow8Ojj8rSTg8OU5yiMYUFN+IMYvZZkWuBtbM7UCUlkD0yZZwwFI/a+RklAa
         izbk6dpwj1+EzUTxx4lNeU4fvpptRM/sSv+QiCn8xFTiBxlhkLCg9oHzvTGnDBXn4rbJ
         DIVH1qbPvwXTAFdPc1aA1lEAUiE13ESwxw+QefBFknKBb6D+RMUXinelGOCcDDeuG7gn
         aXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709208111; x=1709812911;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rQ8Yz/jkGjyjSDIVvNksNhYPBGRlSE4L4EJXFPpMMdU=;
        b=QjYo+k/nQEoqlyLpJKuPDHvVlhkEyQMQWbU0utqzVCquF+00vl6k/TZQcsEUiw/EU2
         9X/SS/2w33pdzfwxM1e9hQxpzxy+F3seTjt2YHk+Z0DOovZV0nw3OtYd+JE4/ftSDgr1
         HbeRJF4bDr/oXmriOuybYpR5fiTePgW5XjI831WrXWQCyOJSOGhDrb9a7ImwM9McMSoG
         LLi+LV+bN7cOeT3Ik2yWrdipmvKe109qu9C8/Z6Bs5hf2GaJ7s7U4ymfK/9gCeUxWtQi
         YtbwvWmA+AwP+6B3uJ4brmEO4P6gsKPKns9itL7cGmHMwwIYMGTcZ15Equ8aG0erileq
         T4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWhjBK2QQSnna5c71QUmhV71Sr3ThsosqHStWrM6BRekFr7+VL1OqFVkbqofxKiC2I9XKi9/smBqUuliXTeucUUxLgT
X-Gm-Message-State: AOJu0YxKGfcht3srdsZrtw8orrVZD1zfXWIfCiqjqMKzTERxXIsPiQfE
	DuZ7Tta1Oe9+CEAExyjUcsV5tChqrp38tYEDwoJmCkw83Kzdd3e4
X-Google-Smtp-Source: AGHT+IHJc6lQXv7sIwr8krdhsCsNbXIMgwTQISivDwdLEfoxKtuPsKgfLxg/HiGhxGnDs7r5Tt/+3w==
X-Received: by 2002:a05:6a00:84f:b0:6e5:a929:2cce with SMTP id q15-20020a056a00084f00b006e5a9292ccemr90253pfk.26.1709208111032;
        Thu, 29 Feb 2024 04:01:51 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id ks21-20020a056a004b9500b006e481014bf9sm1100561pfb.200.2024.02.29.04.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 04:01:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Feb 2024 17:31:43 +0530
Message-Id: <CZHJPF604DV9.X0A0VX1AB7P8@gmail.com>
Cc: <pk@pks.im>
Subject: Re: [GSOC][PATCH] userdiff: add builtin patterns for JavaScript.
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Sergius Nyah" <sergiusnyah@gmail.com>, <git@vger.kernel.org>,
 <christian.couder@gmail.com>, <gitster@pobox.com>
X-Mailer: aerc 0.15.2
References: <xmqqttlsjvsi.fsf@gitster.g>
 <20240229101131.445405-1-sergiusnyah@gmail.com>
In-Reply-To: <20240229101131.445405-1-sergiusnyah@gmail.com>

On Thu Feb 29, 2024 at 3:41 PM IST, Sergius Nyah wrote:
> This commit introduces builtin patterns for JavaScript in userdiff.
"This commit introduces ..." -> "Introduce ...". I think describing which
specification this adheres to (i.e. ECMA-262) would be helpful for the
readers.

> It adds a new test case in t4018-diff-funcname.sh to verify the enhanced
> JavaScript function detection in Git diffs.

"It adds ..." -> "Add ..."

> Signed-off-by: Sergius Justus Chesami Nyah <sergiusnyah@gmail.com>
> ---
> userdiff.c | 17 +++++++++++++++--
> t/t4018-diff-funcname.sh | 25 ++++++++-
> 2 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/userdiff.c b/userdiff.c
> index e399543823..12e31ff14d 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -18,40 +16,19 @@
> #include "git-compat-util.h"
> #include "config.h"
> #include "userdiff.h"
> #include "strbuf.h"
>
> PATTERNS("javascript",
>       /* Looks for lines that start with optional whitespace, followed
>       * by 'function'* and any characters (for function declarations),
>       * or valid JavaScript identifiers, equals sign '=3D', 'function' ke=
yword
>       * and any characters (for function expressions).
>       * Also considers functions defined inside blocks with '{...}'.
>       */
>       "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=3D[ \t]*fu=
nction[ \t]*.*|(\\{[ \t]*)?)\n",
>       /* This pattern matches JavaScript identifiers */
>       "[a-zA-Z_$][0-9a-zA-Z_$]*"
>       "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
>       "|[-+*/<>%&^|=3D!:]=3D|--|\\+\\+|<<=3D?|>>=3D?|&&|\\|\\|"),

It seems like you manually manipulated the diff/format-patch output that
is not the commit message. Usually all the new lines have '+' sign
prefixed and all the removed lines have '-' sign prefixed. git am gives
the following error:

    Applying: userdiff: add builtin patterns for JavaScript.
    error: corrupt patch at line 11
    Patch failed at 0022 userdiff: add builtin patterns for JavaScript.

If you find it difficult to use send-email/format-patch, you can always
make a pull request on git/git or gitgitgadget/git on GitHub and
GitGitGadget[1] will take care of the rest. If you still want to use
format-patch, it is a good practice to version your patches
(i.e. [PATCH v2 1/2] ...) so that it is easy to follow.
(cf. Documentation/SubmittingPatches or Documentation/MyFirstContribution)

[1]: https://gitgitgadget.github.io/

Thanks.
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index 43593866bc..9c3b80665e 100644
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -18,40 +16,19 @@
> test_expect_success 'identify builtin patterns in Javascript' '
>     # setup
>     echo "function myFunction() { return true; }" > test.js &&
>     echo "var myVar =3D function() { return false; }" >> test.js &&
>     git add test.js &&
>     git commit -m "add test.js" &&
>
>     # modify the file
>     echo "function myFunction() { return false; }" > test.js &&
>     echo "var myVar =3D function() { return true; }" >> test.js &&
>
>     # command under test
>     git diff >output &&
>
>     # check results
>     test_i18ngrep "function myFunction() { return true; }" output &&
>     test_i18ngrep "function myFunction() { return false; }" output &&
>     test_i18ngrep "var myVar =3D function() { return false; }" output &&
>     test_i18ngrep "var myVar =3D function() { return true; }" output
> '
>
> test_done
> --
> 2.43.2

