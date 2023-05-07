Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3D7C77B73
	for <git@archiver.kernel.org>; Sun,  7 May 2023 00:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjEGA4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 20:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjEGAzv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 20:55:51 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8D425711
        for <git@vger.kernel.org>; Sat,  6 May 2023 17:54:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ad89c7a84fso3522911fa.2
        for <git@vger.kernel.org>; Sat, 06 May 2023 17:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683420858; x=1686012858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo6Jdplql6L9f8b9tOieOz/qUL9wi9YJJOJX7/9u1Yg=;
        b=jHFHGeCLIzbQ0HJL10RMGOYgyf5pUPTgmxqtr6SExasCgFBIWFY/1Nx5ncgLauFGEc
         QbtxYDgjlUBSXP8YGByCP9XlQLSa6W3yrDarH7uaFgVerwG/j8hEw2iI4Fmg7gHCuotz
         +Aph+alUgHvzCRZ0fKUj2cmJTEZZLB8Ui/b8RH8reQ6Jzw03pgJ2S4sWafdYMQ2F2B4n
         FwNc/iIHNGlM1Pbv30x5UeF4IVW7zdg210x76sOpTdLnR2cMvRoo7FFeE8aC+C2cnvZD
         JjxXRy0QfVuUIYf4FIN9XaxK9YnJlDgcx+oSQL/uDwhH0A33V236SSLlIKjSwv3HpQVu
         7W6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683420858; x=1686012858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bo6Jdplql6L9f8b9tOieOz/qUL9wi9YJJOJX7/9u1Yg=;
        b=Oy+R3EUj8n+jIRMYUR3t1FksWl/3upMfSE+7GnGEf6iVJsTNuQyXJFClQEJXjnLNrq
         +Z+VZQoltKRKAEe5yGkhQho6G0N1KPrgKVPuySRy+uGSQ+AUUCTIUy8kCqBxMy/OGe03
         jgjGQV8Hu+OJ4T9QU/BYNkfjMyq3zKPb7KN8Q3HKEuK+JlSEfIyuCyB++gO7C/xjPSkO
         Ww1UxVJYoZRuPh3amftrbp8tZ7Oj76m6igcSaE2uHTPBuuznh11sXhmnNIqmk/pGpY/x
         Qjh6iRqA+4/0uBbhwIFhKJLHigpZqvGnCWwzzr9ZMbHpn5+7yo9HRW5BzalTQNbepZ5+
         c5sw==
X-Gm-Message-State: AC+VfDxYizl/z1O6DAwfZpkDcNJxYLXv1vOxKVLu9JORBG5WMAAY51No
        Ezv01xTwMyGhdOF+t594gyNbQ7RgehvQT22wUAMaJfeNhwc=
X-Google-Smtp-Source: ACHHUZ56rm+4tAps+rYsH5Ps6UjiW+HxkLu3NgQZ+IEajgi+o07OyOn1v65R0NKM26dKTCLR/6qIqr9n5EtpKw/0E/8=
X-Received: by 2002:ac2:5443:0:b0:4ec:a4b4:4731 with SMTP id
 d3-20020ac25443000000b004eca4b44731mr1466833lfn.68.1683420059944; Sat, 06 May
 2023 17:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com> <20230503184849.1809304-1-calvinwan@google.com>
In-Reply-To: <20230503184849.1809304-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 6 May 2023 17:40:47 -0700
Message-ID: <CABPp-BGk-s+4b+OHi9FDXjwz5BeZPS8qb4XiJ8CVwkt8Siaq8A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] strbuf cleanups
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2023 at 11:48=E2=80=AFAM Calvin Wan <calvinwan@google.com> w=
rote:
>
> Strbuf is a widely used basic structure that should only interact with
> other primitives in strbuf.[ch].

"should"?  I agree with moving things in this direction, but the
wording here suggests there's a pre-existing directive or guideline;
but if so, I'm unfamiliar with it.  Maybe this should be reworded to
"This series modifies strbuf to focus on string manipulation with
minimal other dependencies"?

> Over time certain functions inside of
> strbuf.[ch] have been added to interact with higher level objects and
> functions. This series cleans up some of those higher level interactions
> by moving the offending functions to the files they interact with and
> adding documentation to strbuf.h. With the goal of eventually being able
> to stand up strbuf as a libary, this series also removes the use of
> environment variables from strbuf.

As Junio pointed out, "environment variables" is misleading; see below.

> Range-diff against v1:
> -:  ---------- > 1:  e0dd3f5295 strbuf: clarify API boundary

I read this separately; this patch looks good to me.

> 1:  283771c088 ! 2:  ec1ea6ae4f abspath: move related functions to abspat=
h
>     @@ Commit message
>          abspath: move related functions to abspath
>
>          Move abspath-related functions from strbuf.[ch] to abspath.[ch] =
since
>     -    they do not belong in a low-level library.
>     +    paths are not primitive objects and therefore strbuf should not =
interact
>     +    with them.

This applies to patches 4 & 5 as well:

Would this perhaps be better worded as:

    Move abspath-related functions from strbuf.[ch] to abspath.[ch] so that
    strbuf is focused on string manipulation routines with minimal dependen=
cies.

?

>       ## abspath.c ##
>      @@ abspath.c: char *prefix_filename_except_for_dash(const char *pfx,=
 const char *arg)
> 2:  58f78b8ae0 =3D 3:  2d74561b91 credential-store: move related function=
s to credential-store file
> 3:  88ab90c079 ! 4:  30b5e635cb object-name: move related functions to ob=
ject-name
>     @@ Commit message
>          object-name: move related functions to object-name
>
>          Move object-name-related functions from strbuf.[ch] to object-na=
me.[ch]
>     -    since they do not belong in a low-level library.
>     +    since paths are not a primitive object that strbuf should direct=
ly
>     +    interact with.
>
>       ## object-name.c ##
>      @@ object-name.c: static void find_abbrev_len_packed(struct min_abbr=
ev_data *mad)
> 4:  30b7de5a81 ! 5:  6905618470 path: move related function to path
>     @@ Metadata
>       ## Commit message ##
>          path: move related function to path
>
>     -    Move path-related function from strbuf.[ch] to path.[ch] since i=
t does
>     -    not belong in a low-level library.
>     +    Move path-related function from strbuf.[ch] to path.[ch] since p=
ath is
>     +    not a primitive object and therefore strbuf should not directly =
interact
>     +    with it.
>
>       ## path.c ##
>      @@ path.c: int normalize_path_copy(char *dst, const char *src)
> 5:  7b6d6353de ! 6:  caf3482bf7 strbuf: clarify dependency
>     @@ Metadata
>       ## Commit message ##
>          strbuf: clarify dependency
>
>     +    refs.h was once needed but is no longer so as of 6bab74e7fb8 ("s=
trbuf:
>     +    move strbuf_branchname to sha1_name.c", 2010-11-06). strbuf.h wa=
s
>     +    included thru refs.h, so removing refs.h requires strbuf.h to be=
 added
>     +    back.
>     +

Thanks.

> 6:  ffacd1cbe5 ! 7:  a7f23488f8 strbuf: remove enviroment variables
>     @@ Metadata
>      Author: Calvin Wan <calvinwan@google.com>
>
>       ## Commit message ##
>     -    strbuf: remove enviroment variables
>     +    strbuf: remove environment variables
>
>     -    As a lower level library, strbuf should not directly access envi=
ronment
>     -    variables within its functions. Therefore, add an additional var=
iable to
>     -    function signatures for functions that use an environment variab=
le and
>     -    refactor callers to pass in the environment variable.
>     +    As a library that only interacts with other primitives, strbuf s=
hould
>     +    not directly access environment variables within its
>     +    functions. Therefore, add an additional variable to function sig=
natures
>     +    for functions that use an environment variable and refactor call=
ers to
>     +    pass in the environment variable.

"environment variable" makes one think not of "variable from
environment.c [that happens to be a global]" but of
https://en.wikipedia.org/wiki/Environment_variable.  The fact that the
variable is defined in environment.c isn't even relevant here, though,
while the fact that it is a global is relevant.  I'd just
s/environment variable/global variable/ in all 4 places (er, 5 if you
include the cover letter).

Your v3 7/7 has an important correction, but you didn't send out a
range diff for v3 so I'm putting my comments on your v2 range-diff.
:-)

>     + /**
>        * Strip whitespace from a buffer. The second parameter controls if
>     -  * comments are considered contents to be removed or not.
>     +- * comments are considered contents to be removed or not.
>     ++ * comments are considered contents to be removed or not. The third=
 parameter
>     ++ * is the comment character that determines whether a line is a com=
ment or not.
>        */

Thanks.


This series fixes two of my comments on v1, and the other was just
"here's another cleanup that could be added" -- it's fine to punt on.

I only had a couple minor comments on this v2/v3 that should be easy
to fix up, all included in this response to the cover letter.
