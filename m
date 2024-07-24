Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B1613D
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721849105; cv=none; b=nk9VA4j0qwnbkO+k/BOpzz3kyLlfrBaRKY0R/w5vZEkHhSsg8OyvJWzvYbhOfMO9cJX8mSfJlZAACGgGObeLfqUWo88ftaBiF3uhVVlqQAXs+5DjT63M7eKLqJCniOJgyNdI5YsSd7jsJmmeyjFjGlq/zAsXetXam0skRiXubwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721849105; c=relaxed/simple;
	bh=/v3D0t+cCh8UoYbUipI/EE2Yv+ugzFKu2dK2t5OBdGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dolvftrdgnVmR3Ic4mWFuPaFyU2hsWnz2NT1d/v2+ZHSjmVzLcJmSnoP9xOExrXLkcCktc4lQVhYRXLJDblmsu1kNR2OcbLi6F2z9juouYev3Z41TidHnoabr6L0JG/awp0I19RZdZDS+ZjGqj5Si5Af61wTygpACXAhahHKU4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GryJ7HZa; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GryJ7HZa"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d9de9f8c8dso103771b6e.1
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721849101; x=1722453901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMkHpv/6r/ZgB2nCLAd1Qj4+r7Iu/Tj5KDjAQp/uZz8=;
        b=GryJ7HZaEnt/TsogCnoLJOGRXQ9WPdWtyqTs8mbsv++VoTFSae2e4w8EvHHvDORtc3
         gAR4qkWNABZvY50W4FJgWZL3AzlKjWe1YCIRuSqB6PLkqGdv7tD2nQDU6TmhL7BVIlKv
         iw0tZ1OCD8hdFg+3O61DK6SO9TammeMANC/+ACxeNSOvhxc15VU6HqI8pZZxPhYSl8Ug
         2pxqQlt1gLuGuAuzT6tTk9mJsTq/VKleoGoNNuaayXgyzuhSJiFp5WYfw2to1sfeLa/y
         yseVNGWwQX7tkRsVa5wGZbWt5i11E2qOnpLNShHon50vx7n3pmnK4PKv9/wJfmwxSEeD
         CzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721849101; x=1722453901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMkHpv/6r/ZgB2nCLAd1Qj4+r7Iu/Tj5KDjAQp/uZz8=;
        b=prSx36Lq+a6h2awYm9wjwDQIbTU5bgpgT9y/QQkzzr8yAuef2BrhCh6IOyGMo+dlkJ
         TsQ3x3n31MCFkvamBGd6kbLwwip+w0NHzdD3KsNSoHB6aj95j0r+6UUGYSaXVsPClhLL
         4y52nmheNz2J0ntx545jRGaZxSW0TV4i1cBfRiaQo0htWKucsWGb7h7paQcGS7Zelp0A
         cvS37rpphsuTC51tDGPC4aLEiVlHV2ks5OeunSQTD+URjuyzFsyA5CAP9JRcjKGmYOZo
         JRLN1dNJPKemtwU16uQs1jw3k+TP4vofCr2kC+DboSefxsyjmVAvzZ/zEASupAQICJIL
         JDOg==
X-Gm-Message-State: AOJu0Yy2jAhrXnleiHFlzqxXlYFnVyFnOTnlvJIlSK1/kUhC2pSoYgOy
	cSByfm/Pk3h+KrwXNqjiIQ6MNkhuqCV3hZXMIFgLN1+TMUbFWs2sspcPiojy66dLn9zpv5MFFVX
	Xqdbo43XmgAvgOtTT2ebN1Hl/dTN0TuGzWNmM
X-Google-Smtp-Source: AGHT+IETU7JcSjQ0P2LXzHOaB9z0wGQB2YzCPWvXj5Yef9dCxFbBNutXC09tYjzqKRI1m5NUkwj2nK4jL9+T2yy2yUc=
X-Received: by 2002:a05:6808:1201:b0:3d8:4603:e7b0 with SMTP id
 5614622812f47-3db11033530mr644339b6e.44.1721849101260; Wed, 24 Jul 2024
 12:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de> <73465c3d-1be0-456b-9471-f875e819c566@web.de>
 <c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
In-Reply-To: <c51025cc-26e5-41e2-be56-94e141a64f5d@web.de>
From: Kyle Lippincott <spectral@google.com>
Date: Wed, 24 Jul 2024 12:24:47 -0700
Message-ID: <CAO_smVi2rJd5SDMsbbxzFUj28a_1KTgdHMz4DTKMsii+Wt5H_Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] unit-tests: add for_test
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 7:53=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> The macro TEST only allows defining a test that consists of a single
> expression.  Add a new macro, for_test, which provides a way to define
> unit tests that are made up of one or more statements.

Perhaps obvious to you and others, but I'm at a loss; can you
elaborate on why this is a significant problem? Why is having the
tests in a separate function a significant downside, and what are the
benefits of this new macro that counteract the "magic" here? I'm not
seeing it.

Macros like this require additional cognitive overhead to understand;
I can't read `for_test ("for_test passing test") check_int(1, =3D=3D, 1);`
and understand what's going on without going and reading the comment
above `for_test`. Unlike `TEST(<func>, "<description>")`, I can't even
_guess_ what it's doing. This macro is project-specific, and this
knowledge has to be attained by everyone wishing to even read this
code.

I personally consider the patches that use this to be regressions in
my ability to read and understand the tests. As an example, one of the
diff hunks in the strbuf patch (patch #6 in the series) does this:
-       TEST(setup_populated(t_addch, "initial value", "a"),
-            "strbuf_addch appends to initial value");
+       for_test ("strbuf_addch appends to initial value") {
+               struct strbuf sb =3D STRBUF_INIT;
+               t_addstr(&sb, "initial value");
+               t_addch(&sb, 'a');
+               t_release(&sb);
+       }

But the main simplification in that patch (not using
`setup_populated`) can be achieved without `for_test`:

+ static void t_addch_appends(void)
+ {
+     struct strbuf sb =3D STRBUF_INIT;
+     t_addstr(&sb, "initial value");
+     t_addch(&sb, 'a');
+     t_release(&sb);
+ }

-       TEST(setup_populated(t_addch, "initial value", "a"),
-            "strbuf_addch appends to initial value");
+       TEST(t_addch_appends(), "strbuf_addch appends to initial value");

It seems to me that all `for_test` is getting us there is an inlining
of the test logic, which seems like it's optimizing for vertical space
in the file. Maybe it's because I'm coming from a C++ environment at
$JOB that's using Google's gunit and gmock frameworks, where every
test is in its own function and we usually don't even write the main
function ourselves, but I have a preference for the separate
functions.

Maybe I'm in the minority, so only consider this at somewhere like a
-0.5 on this series (fine with deferring to a reviewer who is
significantly in favor of it, but if there aren't any, I'd lean
towards not landing this).
