Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90681F9E8
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 05:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773984039; cv=none; b=UVRc5YYc3Jv0OhwvGI56YFpGh6EiAh80/2I1AUumXRg/UcHDvQRd7nqkOX9wNQdaHjcz03k4S5Tt20vZfHoD9TyZlug/jGyNDaOOOUFIYLMhrotplts7AJpjPPTP+T3G+wn92NhW/TxlQan3eSkw1gyXFb1i+R7/lnAhr4/3Mi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773984039; c=relaxed/simple;
	bh=Tl2UmFEoNV+Nk8lnzm5RFdIH1Z79pcX5WA3p13czR4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X4Tp2s4wMQDIU6qeVC4B/yOjICV6xLkUFuZ28Fi7WO4oq5QjDGsQH9yMPFlkfaFLURk4iDlD4Set8LvcRd6Fe0gXfIlVNw6/thFlI8ekvQPHZOxXf6JS/0UNFlW5d0yFfzYDhQgR3NKmHLYKnkXt1jMW9DW6LfsjOe8w962QVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy3wklSe; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy3wklSe"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-126ea4b77adso1432330c88.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 22:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773984037; x=1774588837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1qRmHZ9Vxkpjso8mEdX0ACs9gcCowe4j6hF8RTnzAA=;
        b=dy3wklSeGb4JMWopNf+7tHACn9HDBa09uN8XPfqwgJqAWEyDI51C2I7MNiX9IMrUHS
         2rf4/6ifN/Z0OlF/kNpJuOoeiBu5xupLfKdlJsUWbtPD4MxjRcxPuzhem20F0YDXng4p
         xI8DBeu5ft4ZSja+jyc2tXf2rp1JiRRDCSuq1CnhKw2XCHTSf9Lb3A26rM1rr3Jd8H0B
         IK7dO+uLQHZRrMRWJb2BVzuQ9TXQux6xu6yNzjNjC9GS3U6Cobkkd5IvuNXZJ4NnPshY
         J7yW82QVStpQhtwYAbxd8lyHOfVw8jgbiiXuOL2HASn6tJZqD6w/HYvKHyp6Q/mcbY13
         qrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773984037; x=1774588837;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1qRmHZ9Vxkpjso8mEdX0ACs9gcCowe4j6hF8RTnzAA=;
        b=pgCOOPPHr0DUeHYbLjy5QAP67Dgi7UpbtgnDVxN7Aguw7xy5xMoA6xF4Z9KZzGgDV6
         mDWh5HvO+cA/BEykQsJLm3vMP6UlCdxGD3FRFSuD6cTMT3SVquexZY1XB3h61troYDED
         fMN+V25StSFsQrN5w50OwKyXsaJjccMi3Mt7gIgQsdhNaeOSagyjrii8fQRUJETJA/hc
         c8Jb3OhgnRSKpU/LDITkfnzSy8JMr8WGYCZ9iCq45ZzGNVUIFZQ9zlBdhS8r5ZBP6RrO
         9yG9wIXDANCn7tBxF4GKQO/iLJPEn9YYSzU8rY+SOXhQBTnaVHnnjfaKTH6pfxtIyixS
         /MkA==
X-Forwarded-Encrypted: i=1; AJvYcCUNx14y9thptlSGVKFxjY1zXXOmPI5nfyVUrGp2ogmWv29mkEK2/QzqWMNCvoR1L2xdsLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw93bt53fIZnHYPjvHNxuHmN1HkBgwgxN0ZBuwAM1eAcJKwfQYD
	T1eEjH+n2D7TqVbTkUWLx5iPTOySq7e76CmkyQh/HJyKpkPotZLyxqkR
X-Gm-Gg: ATEYQzzoKcyxOQR1BYPCVt91ipQwB9VQV2wNll9pChC3Dg1vDSWYgqbE0PfU53w0Ele
	pIwsvBqSW+eTkYcAIwRhAXi8xU/Gg2GOezLIAjAleZwDSaN5If8UTOyqkY0IslK/Ayo8aU17Pcu
	4jcN95m0nP8gb8RNjxEAjFPYacxYZDgEJvUEjyVk98vqPfc/GYMoU1TlrbHKUAM+CqZKbxVOAEh
	UBkYdnGJorZLhj2u9ZVCb9VbYFtX0YP1/nLDU0jIGxZveMAONp5BAWKpyBJdR8hGa+m4Wr45wbb
	Jo4pDTo97nc+5Zm1nluFg4fdagJUPqIv/wfeKPRjSiphGPc/r2g4gv5YMpBOBQXblvaT8X4+c4n
	jwg1+kHJmiUbp010rOWIN1dykPOiYQ8FSRFQYGoAoSVhM/qDU7mq5q2yE/w5GNWcCVDgtXpqLw1
	/TCXW8EWWiDAFgZTvUBp2tf3JmoylTEhgO3TYpa6klIgDUG/0d6V/t
X-Received: by 2002:a05:7022:45a1:b0:128:d375:f1d4 with SMTP id a92af1059eb24-12a726dad97mr863272c88.28.1773984036434;
        Thu, 19 Mar 2026 22:20:36 -0700 (PDT)
Received: from fedora (c-73-93-224-2.hsd1.ca.comcast.net. [73.93.224.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a734bbbc5sm1235283c88.11.2026.03.19.22.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:20:35 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  Junio C Hamano
 <gitster@pobox.com>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Matthew John Cheetham
 <mjcheetham@outlook.com>,  Victoria Dye <vdye@github.com>,  Derrick Stolee
 <stolee@gmail.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] git-compat-util: make git_find_last_dir_sep return a
 const pointer
In-Reply-To: <20260320043943.GB18125@coredump.intra.peff.net>
References: <e6f7e2eddbc9aef1c21f661420a4b8cb9cd8e2c1.1770095829.git.collin.funk1@gmail.com>
	<20260203062537.GA286409@coredump.intra.peff.net>
	<87ecn18aip.fsf@gmail.com>
	<20260204053218.GA942606@coredump.intra.peff.net>
	<87a4w42i4c.fsf@iotcl.com>
	<20260320043943.GB18125@coredump.intra.peff.net>
Date: Thu, 19 Mar 2026 22:20:33 -0700
Message-ID: <87fr5vrs9q.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> writes:

> On Thu, Mar 19, 2026 at 12:06:43PM +0100, Toon Claes wrote:
>
>> Jeff King <peff@peff.net> writes:
>>=20
>> >> > Looking at strchr()'s declaration in string.h, which is defined lik=
e:
>> >> >
>> >> >   #  define strchr(S, C)                                          \
>> >> >     __glibc_const_generic (S, const char *, strchr (S, C))
>> >> >
>> >> > I think the answer is probably "yes". But it also doesn't quite sol=
ve
>> >> > our problem. That would give us type-checking of callers of our
>> >> > function, but we still have to convince the compiler not to complain
>> >> > about its implementation. For that we'd need to either cast away co=
nst
>> >> > manually, I guess.
>> >>=20
>> >> That macro depends on Generic selections from C11 [1]. I wasn't sure =
if
>> >> Git would like that, given it is conservative with other C features.
>> >
>> > We definitely can't rely on it everywhere. But if there is a solution
>> > that is conditionally compiled, and can kick in only when these extra
>> > warnings also kick in, that would be OK. Assuming the result is not too
>> > painful to look at, of course.
>>=20
>> So the Git project would be okay to conditionally compile with Generic
>> selections if the compiler supports it? Seems to me this is the easiest
>> way forward to silence the errors for users who see these warnings (that
>> includes me).
>
> Yes, though I think just turning it into a macro is enough to silence
> this particular case (because macros don't have types, and so the
> compiler sees the original types passed to strchr). And as you noted,
> there are a ton of other cases that have to be looked at individually,
> which I think is the real blocker.
>
>> I did not look into any of them, but I think you (Collin) have sent out
>> patches for various of these? But they _should_ managable to address?
>
> I have quick-and-dirty fixes for these at:
>
>   https://github.com/peff/git jk/hacky-strchr-fixes
>
> I haven't been cleaning them up and sending in patches because I didn't
> want to duplicate work Collin was doing. But Collin, let us know if we
> can contribute. Dealing with the warnings is an occasional hassle during
> other work.

Please feel free to work on it. I fixed two more simple cases which are
in Junio's "next" branch. I also have one patch that that I sent on list
but is pending review [1].

I had planned to do more, but got busy working on other things. Sorry
about that.

> If you're using gcc, you can solve it by just adding
> -Wno-discarded-qualifiers to your CFLAGS. But clang doesn't know about
> that warning. Worse, if you sometimes compile with -std=3Dc99 (which is
> necessary to build versions of Git older than e8b3bcf491) then glibc's
> preprocessor conditionals don't kick in correctly and you get:
>
>   ./git-compat-util.h:344:9: warning: returning 'const char *' from a fun=
ction with result type 'char *' discards qualifiers [-Wincompatible-pointer=
-types-discards-qualifiers]
>     344 |         return strrchr(path, '/');
>         |                ^~~~~~~~~~~~~~~~~~
>   /usr/include/string.h:296:3: note: expanded from macro 'strrchr'
>     296 |   __glibc_const_generic (S, const char *, strrchr (S, C))
>         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /usr/include/x86_64-linux-gnu/sys/cdefs.h:838:3: note: expanded from ma=
cro '__glibc_const_generic'
>     838 |   _Generic (0 ? (PTR) : (void *) 1,                     \
>         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     839 |             const void *: (CTYPE) (CALL),               \
>         |             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     840 |             default: CALL)
>         |             ~~~~~~~~~~~~~~
>
> Yuck. That is not even specific to Git, and is hopefully something that
> glibc and clang folks might figure out.

I think something not immediately obvious is happening here. Hopefully
my explanation helps you.

Here is how the macro is defined in string.h:

    # if __GLIBC_USE (ISOC23) && defined __glibc_const_generic && !defined =
_LIBC
    #  define strrchr(S, C)						\
      __glibc_const_generic (S, const char *, strrchr (S, C))
    # endif

There are two cases that __GLIBC_USE (ISOC23) evaluates to true. The
first is if you use '-std=3Dc23'/'-std=3Dgnu23' (or have a compiler that
uses that version by default). The second, which I expect is happening
in your case, is if _GNU_SOURCE is defined. That flag causes GNU
extensions to be declared along with the latest standards.

Here is an example:

    $ cat main.c
    #include <string.h>
    int
    main (void)
    {
      const char *s =3D "hello";
      char *p =3D strchr (s, 'h');
      return 0;
    }
    $ gcc -std=3Dc99 main.c
    $ gcc -std=3Dc99 -D_GNU_SOURCE main.c
    main.c: In function =E2=80=98main=E2=80=99:
    main.c:6:13: warning: initialization discards =E2=80=98const=E2=80=99 q=
ualifier from pointer target type [-Wdiscarded-qualifiers]
        6 |   char *p =3D strchr (s, 'h');
          |             ^~~~~~

I can modify the file like this:

    $ cat main.c=20
    #include <sys/cdefs.h>
    #undef __glibc_const_generic
    #include <string.h>
    int
    main (void)
    {
      const char *s =3D "hello";
      char *p =3D strchr (s, 'h');
      return 0;
    }
    $ gcc -std=3Dc99 main.c
    $ gcc -std=3Dc99 -D_GNU_SOURCE main.c

For context, this change has caused myself and the other Gnulib
maintainers some trouble as well. It broke the builds of many GNU
packages that vendor Gnulib (coreutils, m4, hello, and the list goes
on). Patching things to include sys/cdefs.h and undefining
__glibc_const_generic was a workaround we considered, but luckily it
didn't take too much time to make new releases for the affected packages.

Collin

[1] https://lore.kernel.org/git/d3447c19d83c37bf2db84ae0bf75801ef7a36cea.17=
73115420.git.collin.funk1@gmail.com/
