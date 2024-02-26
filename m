Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205D135A46
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708991867; cv=none; b=oJamKhyZIkItP3evr5+BWBWh3+VYOi6wZfR306xhaHVpKKC8B0hT0iHTRyXIrmnsPTRHN0XSM0nGYXVgo9WFfMCqBJWfSptGA+TCHmuZi/+CXzFSz+KGo1A1800chN7hbekYjIne8odj7Mvjq55w0huxXdDwM0WLdrFAhNCp7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708991867; c=relaxed/simple;
	bh=FxyOL1gFOhQUviwP7uBhgfPw4Tdbrk8YGUDZoILTfFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGbAWvghl3SKuThctKpuPcviMP0yU6c8Pizdh5SnXbbsS6dE73fsTF51s0CXJNG5ta2hfj0pRxsGLedrQLH9BDlWKauUo7V+jz1vP+OxJo7ubJjIpdq0ZxVTJ4ZRKvCrb3Uw0vf3j0LW268y8Cpk5S65m4asexjjIUcF2S8Swow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sLzDQjfg; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sLzDQjfg"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512bd533be0so4493730e87.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2024 15:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708991863; x=1709596663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMh2+kGi5gqqkqZIQbCJ3xBP+2LrNAKPwgROgiF80jc=;
        b=sLzDQjfgVclfmISypG40b4X3M79kqqce/SnoeqULVqlxYjref10wYmWmOpjb+PZGaz
         IlP5yfql2tZFfGBVk1l9WvIi2nuwGVD3KfA+HamsJRe6Ja1c2+uhMPRCBaoHTa6H+dhB
         rBjxaXBSR5/X0IOxyNl+U4GzCYeSNed/uWQRjK+V+n+7iOaSM845OEIRn5D/DxL5RXPr
         zkZYu04ypKoGRCsyg4aki1/HpOvRZ2R12CDF1TnnFF0ju2IkzmGj//sADvTDgjBxtjWA
         85LRhPkSby09UWl8sr8WDLNtsLr0MlOyBis+DXuz9qDWrC3PM8t6lkHPwTH8nA+bSG9a
         yh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708991863; x=1709596663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMh2+kGi5gqqkqZIQbCJ3xBP+2LrNAKPwgROgiF80jc=;
        b=Epip3GJ1q2PgDML+yjKssWhEjG1hvDfMpboaYeCKgSqQKWLpQgJ4WH9maqqhwrzMNX
         gLWK9gwNai1BsmrAEph38akQvI0Poeb1lNrtSAJdlJs+kwCU67YFbTAUfg5/kuHqUDUt
         O2L/ejBQYYEIC/+7Wspsi7+eGI2duzk2u6ZCivW/nH7NHFfsHVRFGZ+aIAHzrnCSoGVs
         6QB2VQPIUFab8DJ+bFMekn3mGmFEfJ4XgkhV7soSCYdHwpBZJar/ukBktWJL5nDgLzcY
         8f/EWLvjVvQ3cYO+JbUP9wXJUMP9Q2HyLUKcAhrnlFf5o0hpIt9ZYxQ/eZB+3uKkVloy
         rc5Q==
X-Gm-Message-State: AOJu0Yzs2nHhUCxjCvFaQ6NarinI8uekuKQlndI3w81mwKQPrFxy+C5b
	P/JCQGlBDjEUao8ObAlkCvY590Ee8T8Go8ggDZ2c0HaKEJccQ6VajOb83LCk/yLfq6cpFHzg7qK
	PDGp9qKFvKwOUswu2FRjaPmnwf+57vS7CwZwA
X-Google-Smtp-Source: AGHT+IF8afrcoksLT9EGTCRfBRJyS2p4mGox+DXklWcG/gDUf/X4SiwUaKDsGDw/w7cw7LEaxSYXxoy1dyLKOUjVx1I=
X-Received: by 2002:a05:6512:348b:b0:512:d8b0:2630 with SMTP id
 v11-20020a056512348b00b00512d8b02630mr4814876lfr.39.1708991862505; Mon, 26
 Feb 2024 15:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq4jdxmx2e.fsf@gitster.g> <xmqqh6hxlcae.fsf@gitster.g> <xmqqle76kdpr.fsf_-_@gitster.g>
In-Reply-To: <xmqqle76kdpr.fsf_-_@gitster.g>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 26 Feb 2024 15:57:27 -0800
Message-ID: <CAO_smVgHTiKvn-erH=m3Ky67X9hHGieC7+qKL2Hymc5NAvKu2A@mail.gmail.com>
Subject: Re: [PATCH v3] doc: clarify the wording on <git-compat-util.h> requirement
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, Elijah Newren <newren@gmail.com>
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
>
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
>

Looks good
