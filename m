Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A124D5A2
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007938; cv=none; b=boEVl8206s6k2Z8ZLO380/+2ljvV2COBpIswkA7JXUXL9vBHsF5HZ+1i2SS0PWwkbIID3flp9NmldEDHf0DVnyLQv3Xhg+HValLmxChcs3Ta66KkO4hxDo08DgVYBAA+FKdOxYAMJTEgtoXJ/yXpat4GaWmIRycRl6G/g5Ap7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007938; c=relaxed/simple;
	bh=lg05H1G17Vz9HLFu/gcwvE9K9a71IcZYZl2qMOzku3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FwCU6ane2Zg2MxyBoamOJKTkkzGKGPlvay2AoJktiEGtGMCAb6cQJG8g0rjaToWcV4xaeU0AH8gzBNefZEZWBslCjfHQSPEbr12gsK0egYBONt6N81/kSMm6e/oG0iDt5q5sV8MJMkeFpFDJXRYs1rDFiRsKa0gZuAunGH2u97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqdH6wNs; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqdH6wNs"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so54927191fa.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 20:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709007934; x=1709612734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ND8IVBqvQrGT5YmC5lY2rZcLM64HvRPX4WhJWsxo83U=;
        b=MqdH6wNst1uLCQjob8vwuZUJacHqLbhMBR9Fzfpck26HiyS4ic0N7tTBaN9UnB9SVE
         eAm99ewi6UwL+NdjlIJOer+yX5ODnupUyQrNn++B+LwnlGJIml64ZHKyx2Be8EuRc24H
         Xtv8RZHkJ5bT+nv2nLWauiWq1TkEZCGuFCrq4CMPOdQeCoDtvLOh79d60Do/Zc/PbcaT
         8i3g6DKMMHlfTjFNgNxTgcAwADDmmjIdqmh64dtrGJAUrYePJORj5xej8/J21+NxfZDS
         mgw8suR7gBf5GXtqnAMNNNIpMw5DLWPTwe7C+Mq2kP1vXIYHINhTn58CrEb4fHTygBEp
         Ku6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709007934; x=1709612734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ND8IVBqvQrGT5YmC5lY2rZcLM64HvRPX4WhJWsxo83U=;
        b=ww25IfLlsJtd5Wv41TluISRYM0Pnet57YDtVt7hC8eJKRhkhMJuWhBM98gVPoo801W
         G3FObpNV4Ov0jvxvkJJCPaV7jkWg3OK9WaxFht6XKcIl2xb4jvlj78Vzsv4mYXMsVYQV
         kdCl3zMLvq1tsRUSX3Fyag7oR22iF3zomQINcSTE1ELKCF/CLWIODhjqrmHZG6Ji7IKF
         +TXVAzLNRfy6xDE0Zwg+dO0KjjsM3bggPSexzCagOfQXW7X+99CpFZfUEfZ/bFxt2j3n
         cMAz8V77oT/kEDO6AeltmITtYD+uiWJ4QppmwErC8uE5PRV2qwn1YCfFTbOAeRUkRRsX
         PFJQ==
X-Gm-Message-State: AOJu0YxiJgbKysfFIlW1Xo2dWhFukaSNNQyVUxER8/IAx8bEXsbuGpfG
	5z3z4JzV7NPv0ExPDMr/mEOkYGLy59pbb6M9SYUIZOFEGNu/35/TV1UL7T7xDCLEmNBX5vIH+NL
	vJsiINC51ozT922Vhad7ymxUvH8I=
X-Google-Smtp-Source: AGHT+IGP8XaY4dAg36uCYrkcgWvCqyWk2QDArt5d/Tn+NtC5L59rZjx/Ii/LGCbVQUWabvC/Y7PQ8qn47JzrcTI3Xxc=
X-Received: by 2002:a2e:b4a8:0:b0:2d2:67fa:7fd6 with SMTP id
 q8-20020a2eb4a8000000b002d267fa7fd6mr4592493ljm.47.1709007933916; Mon, 26 Feb
 2024 20:25:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq4jdxmx2e.fsf@gitster.g> <xmqqh6hxlcae.fsf@gitster.g> <xmqqle76kdpr.fsf_-_@gitster.g>
In-Reply-To: <xmqqle76kdpr.fsf_-_@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 26 Feb 2024 20:25:19 -0800
Message-ID: <CABPp-BHbuvLSSr2186XqiHFQD=NUYess5zdwG4bqY6FzQfG8oA@mail.gmail.com>
Subject: Re: [PATCH v3] doc: clarify the wording on <git-compat-util.h> requirement
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kyle Lippincott <spectral@google.com>, 
	Calvin Wan <calvinwan@google.com>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 3:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> The reason why we require the <git-compat-util.h> file to be the
> first header file to be included is because it insulates other
> header files and source files from platform differences, like which
> system header files must be included in what order, and what C
> preprocessor feature macros must be defined to trigger certain
> features we want out of the system.
>
> We tried to clarify the rule in the coding guidelines document, but
> the wording was a bit fuzzy that can lead to misinterpretations like
> you can include <xdiff/xinclude.h> only to avoid having to include
> <git-compat-util.h> even if you have nothing to do with the xdiff
> implementation, for example.  "You do not have to include more than
> one of these" was also misleading and would have been puzzling if
> you _needed_ to depend on more than one of these approved headers
> (answer: you are allowed to include them all if you need the
> declarations in them for reasons other than that you want to avoid
> including compat-util yourself).
>
> Instead of using the phrase "approved headers", enumerate them as
> exceptions, each labeled with its intended audiences, to avoid such
> misinterpretations.  The structure also makes it easier to add new
> exceptions, so add the description of "t/unit-tests/test-lib.h"
> being an exception only for the unit tests implementation as an
> example.

Makes sense.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Updated the leading phrase introducing the list of exceptions.
>    I think this is now clear enough to be ready for 'next'?
>
> Range-diff:
> 1:  2e7082d2d2 ! 1:  470f33a078 doc: clarify the wording on <git-compat-u=
til.h> requirement
>     @@ Documentation/CodingGuidelines: For C programs:
>      -   "t/helper/test-tool.h", "xdiff/xinclude.h", or
>      -   "reftable/system.h".)  You do not have to include more than one =
of
>      -   these.
>     -+   implementations and sha1dc/, must be "git-compat-util.h".  This
>     ++   implementations and sha1dc/, must be <git-compat-util.h>.  This
>      +   header file insulates other header files and source files from
>      +   platform differences, like which system header files must be
>      +   included in what order, and what C preprocessor feature macros m=
ust
>      +   be defined to trigger certain features we expect out of the syst=
em.
>     ++   A collorary to this is that C files should not directly include
>     ++   system header files themselves.
>      +
>     -+   In addition:
>     ++   There are some exceptions, because certain group of files that
>     ++   implement an API all have to include the same header file that
>     ++   defines the API and it is convenient to include <git-compat-util=
.h>
>     ++   there.  Namely:
>      +
>      +   - the implementation of the built-in commands in the "builtin/"
>      +     directory that include "builtin.h" for the cmd_foo() prototype
>     -+     definition
>     ++     definition,
>      +
>      +   - the test helper programs in the "t/helper/" directory that inc=
lude
>     -+     "t/helper/test-tool.h" for the cmd__foo() prototype definition
>     ++     "t/helper/test-tool.h" for the cmd__foo() prototype definition=
,
>      +
>      +   - the xdiff implementation in the "xdiff/" directory that includ=
es
>     -+     "xdiff/xinclude.h" for the xdiff machinery internals
>     ++     "xdiff/xinclude.h" for the xdiff machinery internals,
>      +
>      +   - the unit test programs in "t/unit-tests/" directory that inclu=
de
>      +     "t/unit-tests/test-lib.h" that gives them the unit-tests
>     -+     framework
>     ++     framework, and
>      +
>      +   - the source files that implement reftable in the "reftable/"
>      +     directory that include "reftable/system.h" for the reftable
>     -+     internals
>     ++     internals,
>      +
>      +   are allowed to assume that they do not have to include
>     -+   "git-compat-util.h" themselves, as it is included as the first
>     ++   <git-compat-util.h> themselves, as it is included as the first
>      +   '#include' in these header files.  These headers must be the fir=
st
>      +   header file to be "#include"d in them, though.
>
>
>  Documentation/CodingGuidelines | 41 +++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> index 578587a471..806979f75b 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -446,12 +446,41 @@ For C programs:
>     detail.
>
>   - The first #include in C files, except in platform specific compat/
> -   implementations and sha1dc/, must be either "git-compat-util.h" or
> -   one of the approved headers that includes it first for you.  (The
> -   approved headers currently include "builtin.h",
> -   "t/helper/test-tool.h", "xdiff/xinclude.h", or
> -   "reftable/system.h".)  You do not have to include more than one of
> -   these.
> +   implementations and sha1dc/, must be <git-compat-util.h>.  This
> +   header file insulates other header files and source files from
> +   platform differences, like which system header files must be
> +   included in what order, and what C preprocessor feature macros must
> +   be defined to trigger certain features we expect out of the system.
> +   A collorary to this is that C files should not directly include
> +   system header files themselves.
> +
> +   There are some exceptions, because certain group of files that
> +   implement an API all have to include the same header file that
> +   defines the API and it is convenient to include <git-compat-util.h>
> +   there.  Namely:
> +
> +   - the implementation of the built-in commands in the "builtin/"
> +     directory that include "builtin.h" for the cmd_foo() prototype
> +     definition,
> +
> +   - the test helper programs in the "t/helper/" directory that include
> +     "t/helper/test-tool.h" for the cmd__foo() prototype definition,
> +
> +   - the xdiff implementation in the "xdiff/" directory that includes
> +     "xdiff/xinclude.h" for the xdiff machinery internals,
> +
> +   - the unit test programs in "t/unit-tests/" directory that include
> +     "t/unit-tests/test-lib.h" that gives them the unit-tests
> +     framework, and
> +
> +   - the source files that implement reftable in the "reftable/"
> +     directory that include "reftable/system.h" for the reftable
> +     internals,
> +
> +   are allowed to assume that they do not have to include
> +   <git-compat-util.h> themselves, as it is included as the first
> +   '#include' in these header files.  These headers must be the first
> +   header file to be "#include"d in them, though.
>
>   - A C file must directly include the header files that declare the
>     functions and the types it uses, except for the functions and types
> --
> 2.44.0

I like this latest version.
