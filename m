Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA11C3DA78
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 15:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLQP1j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 10:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLQP1g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 10:27:36 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090B412621
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 07:27:36 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so3062258oto.6
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fWe9Xm/SygIgWy3RbUeNViZ6QVXDkm4BEPvwFMxcd+s=;
        b=DkLBeJRIhsK3PqIwBpR5SBHMpn/xtBuoeDFASoPfthB5xa0iaAp6fMzwZXeSTjvKRX
         /S1kgEe/T0qpu9qiuNX3iLtnxgna6yWopRprrMgsO+kpwXVXdYreP+8KPzZ9xequfZws
         txM4EonxZz3RRufqn59CUyEv7ZZeHFITHUsvDnidSbUtzCCGJ9ILZvHA2A7yqp0J2AeT
         g0FDhZUela5GzKX6ynuWvQq3bD6HfFxr3gJIFsjCHI4FUNAvF8eGL8lQiFmDKezWlMDI
         e6ld7Ia7Z8KYDUguYbvBsXLqYpNaNruhbcec1ZbzUDr1TlzkpyIQhsk/XAaOHf27ViIG
         K4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWe9Xm/SygIgWy3RbUeNViZ6QVXDkm4BEPvwFMxcd+s=;
        b=xsq+BF5j1Ors2k1cvF8jdep2a0pFGAzZx+bTzgmhhXBEGEWSkKKrR0qDG6I/+L4mUr
         qmH4DQNXH6jRwh6D0t69N5VJYnPekopD8O0daPYnidzyksGIdw24lAnWU6u/MrXxh/aq
         b+HDwvTqL1AVDE8B02bSsuEzZYePIRtnDWigPPzXaPNJ9HTMsvaIRiI9UKCKtfgeVygB
         dSTfyfP7D4T2kAWKOmQbgcgaKvzbysKzeoFKfxTCpQsP15amOgjETnYigMxgZWPXzCDN
         +RWsDWsVgnIkEUqynUiU2bwamJwHHXCjIXtSw+0Nyk1JPzJKKlhtYWbuX/tCjJedwDNT
         p9Lg==
X-Gm-Message-State: ANoB5pni6Dm3y7G4u6FdoLP4B0ZK+jH6Df7jW9U7SnubJLhqswvLQbSb
        C6/IF5gbjI9VmqdsTI3iGN8yL99LrT+txbE9CzE=
X-Google-Smtp-Source: AA0mqf7aXSfyhMum5X6sdGXJ91BEwhKmECKXpCmJwsliL7fZvnoRifkOXwHU2/grpjZ++ibTiFaeHqdvYWyjSSKAySI=
X-Received: by 2002:a9d:550d:0:b0:66d:6909:e477 with SMTP id
 l13-20020a9d550d000000b0066d6909e477mr49571938oth.114.1671290855289; Sat, 17
 Dec 2022 07:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20221216093552.3171319-1-karthik.188@gmail.com>
 <20221216093552.3171319-3-karthik.188@gmail.com> <xmqqcz8ikgxs.fsf@gitster.g>
In-Reply-To: <xmqqcz8ikgxs.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 17 Dec 2022 16:27:09 +0100
Message-ID: <CAOLa=ZTXQ6e_JY+3jN6r52j71qTo5-OJBs-_vLaE_obn+3Fb1Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] attr: add flag `-r|--revisions` to work with revisions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 17, 2022 at 1:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> > diff --git a/attr.c b/attr.c
> > index 42ad6de8c7..99883024ec 100644
> > --- a/attr.c
> > +++ b/attr.c
> > @@ -11,8 +11,13 @@
> >  #include "exec-cmd.h"
> >  #include "attr.h"
> >  #include "dir.h"
> > +#include "git-compat-util.h"
>
> Unneeded.  cf. Documentation/CodingGuidelines
>
>  - The first #include in C files, except in platform specific compat/
>    implementations, must be either "git-compat-util.h", "cache.h" or
>    "builtin.h".  You do not have to include more than one of these.
>
> and this file already begins with including "cache.h".
>

Thanks, I thought this was removed.

> By the way,
>
>     $ make
>     $ cd t
>     $ sh t0003-attributes.sh -i -x
>     Initialized empty Git repository in /home/gitster/w/git.git/t/trash directory.t0003-attributes/.git/
>     expecting success of 0003.1 'open-quoted pathname':
>             echo "\"a test=a" >.gitattributes &&
>             attr_check a unspecified
>
>     ++ echo '"a test=a'
>     ++ attr_check a unspecified
>     ++ attr_check_basic a unspecified
>     ++ path=a
>     ++ expect=unspecified
>     ++ git_opts=
>     ++ git check-attr test -- a
>     t0003-attributes.sh: line 9: 1508946 Segmentation fault      git $git_opts check-attr test -- "$path" > actual 2> err
>     error: last command exited with $?=139
>     not ok 1 - open-quoted pathname
>     #
>     #           echo "\"a test=a" >.gitattributes &&
>     #           attr_check a unspecified
>     #
>     1..1
>     $ exit
>
> there seems to be something fishy in this patch.
>

Seems to be because tree_oid is not NULL initialized. I think I only
tested the new
feature, but the other tests are failing. Should be fixed with

    -+  struct object_id tree_oid;
    ++  struct object_id *tree_oid = NULL;
        int cnt, i, doubledash, filei;

        if (!is_bare_repository())
    @@ builtin/check-attr.c: int cmd_check_attr(int argc, const char
**argv, const char
                }
        }

    -+  if (revision)
    -+          if (repo_get_oid_tree(the_repository, revision, &tree_oid))
    ++  if (revision) {
    ++          tree_oid = xmalloc(sizeof(struct object_id));
    ++
    ++          if (repo_get_oid_tree(the_repository, revision, tree_oid))
     +                  error("%s: not a valid revision", revision);
    ++  }

will include in version 4. Thanks for the support, Junio.

-- 
- Karthik
