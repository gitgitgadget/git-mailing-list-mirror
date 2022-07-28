Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5215FC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 00:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234159AbiG1Alu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 20:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiG1Als (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 20:41:48 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207425466B
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 17:41:47 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id f14so514103qkm.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 17:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y9mZeSTndS/OYh2274vXnwkl4tFxph+nJrxH7zaYTUA=;
        b=EsqHJzexGizydRWNiPaghH/1z/XmyQUR9NE6BKWdZHRoe3BAiJpLEfRdEOmGiAgyTK
         0aJQ3KawI41t2Gdsq5sM6orhz7u0pC0A5aYMbpeByVCL18L+4a0+boC8yw3OOwm89Ipv
         +Yhs+mR2DoyD84sGPuE88NFmx/M1nDCr/NUFCoiyWfDmFEUPwIKSWop3Lq3ExbF6aunx
         0pbUsSlliZTBzD7yaAxcgmA5YUF+3h1YY3z629KlrlcUtnACth3uVjzJhzPvd9eiEJfq
         UJmnyW95Uu1+Sx5c186xTo8UYzsoxX74cQzaYZpuJe9r6bkRKf6utffdGdeyvbc8TT1p
         Xuwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y9mZeSTndS/OYh2274vXnwkl4tFxph+nJrxH7zaYTUA=;
        b=Yju0JyVl1zGQ+5vcIZaqjuDgz94EM/4uMP+q+S86RnAk3/5LHTFFhBqwje34QyrA6L
         zrlF8UuNW0Px53T3tPu2UFXEngDafe/H9QlqHwVog6n7bZnldW2Qgswb+jOxqKgeel/U
         Kk5F5v1/ahyVETsVaVXbmfeQwxI3hyOKbSXkYi9i6RBZLTfqX5RRubnEH7kVX1iH8F/l
         ixnUzxnLqaw28Ux4GUtopYX3bAWq/Vn/G2vsdqxAf70oJnfiY/rGGpYtV/22toSfUoWG
         jHbLwpElVdgOOBj3/MoB+2Td1JKEOt9GQIuUSlT0qq0RIWaBrn/akLKMplDEyRLwM2In
         XiNA==
X-Gm-Message-State: AJIora+gYBt1c7gkFD7k5F+fv1DDGQHX/lEmX0UJN3o6XAz5XsYCBph8
        73wFrEwSDW01ZjCB2gaX0N9NWlg3D1nMkOAf0ug=
X-Google-Smtp-Source: AGRyM1twLTljuLZFvHZwVvEdPN66fojMir2neWaZPO5t1sYmNTItMVIhn7xPMowe5Rg/4K0lEAFE5VwCLKAoy1+xoQU=
X-Received: by 2002:a05:620a:741:b0:6b5:ee4f:35e8 with SMTP id
 i1-20020a05620a074100b006b5ee4f35e8mr18244628qki.131.1658968905937; Wed, 27
 Jul 2022 17:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220718214349.3379328-1-calvinwan@google.com>
 <20220726210020.3397249-1-calvinwan@google.com> <CABPp-BGvDLvmj720PFzsjrZrYuYauprL6JeOQhiQ4BjtfjF7Dg@mail.gmail.com>
 <CAFySSZB6bB0qqCv5EPmJBJY9RbDRFv8JDYj89W+ND_Jw6Ys1kA@mail.gmail.com>
In-Reply-To: <CAFySSZB6bB0qqCv5EPmJBJY9RbDRFv8JDYj89W+ND_Jw6Ys1kA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Jul 2022 17:41:34 -0700
Message-ID: <CABPp-BF2O9mT4tX-1PuNmNvQwN8S_OmMz-Y8_yCu7tmVO_ZJmA@mail.gmail.com>
Subject: Re: [PATCH v6] submodule merge: update conflict error message
To:     Calvin Wan <calvinwan@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Jul 27, 2022 at 3:00 PM Calvin Wan <calvinwan@google.com> wrote:
[...]
> > Sorry for not catching this in an earlier round, but merge_submodule()
> > has four "return 0" cases, for particular types of conflicts.  Those
> > should probably be switched to "goto cleanup" or something like that,
> > so that these messages you are adding are also provided if one of
> > those conflict cases are hit.
>
> I didn't send these four "return 0" cases to cleanup because I thought
> the error message wouldn't accurately reflect the resolution steps. Is
> merging or updating the submodule still the correct resolution? The
> first three cases are for a null o/a/b, and the fourth case is for a missing
> local submodule. Also in cleanup, the subrepo is cleared but the
> subrepo hasn't been initialized/failed to initialize in these four cases.

Ah, I remember we partially discussed this earlier in this thread;
sorry for forgetting.

For the failed to initialize case, yes we also need a merge -- the
submodule is conflicted due to the lack of one.  The steps the user
needs to take are probably even more involved, though (they also need
to initialize the submodule), so perhaps that one should be special
cased.

The 'a' or 'b' being a null oid is actually dead code, as discussed
earlier in the thread.  Perhaps we should change those two code paths
from "return 0" to 'BUG("submodule deleted on one side; this should be
handled outside of merge_submodule()")', and possibly with a commit
message linking to
https://lore.kernel.org/git/CABPp-BE0qGwUy80dmVszkJQ+tcpfLRW0OZyErymzhZ9+HWY1mw@mail.gmail.com/
(and mentioning the "a and b being null oids within merge_submodule
will never trigger" portion of that email).

The 'o' being a null oid is not dead code.  That particular case means
that there was no submodule in the merge base, but both sides of the
merge introduced the submodule and have it checked out to different
oids.  (At least, hopefully it's the same submodule.)  In that case,
yes we do need some kind of merge.  So I think your message should
probably be included in this case, as-is.  Since the cleanup thing you
mention is an issue, perhaps you need to refactor the code a bit so
that you can make this case somehow get the same message printed for
users?

All that said, if you want to defer any or all of this to a follow-on
series, that's fine...but it would be nice to have it mentioned in the
commit message.

> > > +               for_each_string_list_item(item, csub)
> > > +                       /*
> > > +                        * TRANSLATORS: This is a line of a recommended `git add` command
> > > +                        * with multiple lines of submodule folders.
> > > +                        * E.g.:     git add sub \
> > > +                        *                   sub2 \
> > > +                        *                   sub3
> >
> > Why does such a message need to be translated?  It's literal text the
> > user should type, right?  I'm not sure what a translator would do with
> > the message other than regurgitate it.
>
> It doesn't. My point was to let the translator know that the only text
> in this print is for a git command. I should probably add that context
> to the comment though.

Um...if the string doesn't need to be marked for translation, and
isn't marked for translation, why would translators go looking for a
comment to help explain how to translate something that doesn't appear
in their list of strings they need to translate?

Using
    printf("    git add %s", ...)
means that the string "    git add %s" will not appear in the po/*.po
files.  If it had been
    printf(_("    git add %s"), ...)
then it would appear in those files with filename(s) and line
number(s) stating where the string had come from in case translators
needed to look for clues about the context in order to know how to
translate the string.

So, I think you can just drop the comment.  Or am I still not
understanding some nuance here?
