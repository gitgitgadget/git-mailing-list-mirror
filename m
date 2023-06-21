Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338E9EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 17:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjFUR4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjFURzy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 13:55:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854EF1726
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 10:54:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-51be42391a3so915678a12.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687370080; x=1689962080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egvMKG++de2nbsLjI3XlqpZ/L/SpYApTlVIrtajiJ08=;
        b=JYL9r0KNlr8IIoeaOEjzkd1urf0csuvAu0zUfH5jgfqTBmsaWcclNPseL4/Ec7rkY9
         V3xqfhm9ccvWSFrN4Y6kgJS/tN5cSFltYZCR6p1qB4rkOcYeeegK7DgU79eiOgOTG8Xp
         Ykr5yh5PHHTeBlrcbEagqtFKOancaoZO6Uicu3P6KVCPZADpt7UAITunpMEbh9AsGOBn
         0U7wrenTXBD4qqqlcFVOhD38UX8sw23az72NaRCUsX6Xtk0cVB3+BT27fn4ypVFrdpcn
         spnFhZXKECNH2KiWqHF6C8UDBcMD0VeWMxwwML83hxibG/ezE3gQTo/aejXQLs9oXWAq
         rZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687370080; x=1689962080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egvMKG++de2nbsLjI3XlqpZ/L/SpYApTlVIrtajiJ08=;
        b=KjpyyJZNbIQJMT2iH7PGGnvLYdMaPjGG1S4K5g+p6SzYKBhP5flqAzAjWGmu1v05kL
         TQLws3A/SsQTARQkyXvlpfqpqPeRxvaHCKFSmCLeo17ylBJYE8D0uJS7/8HhLggjcSf5
         2MU8O0cwNX5LDV/1IbIVQO08hRb1JTOewNod/+TJlR5d25nBFx4gIAm4Q9U7assCmOmu
         DB21m+scXHxjzjYEzOWyFNumk3DLOO6yTXjrWuryzOuKSTEkf2q8PZSxmzgPEB2S2EPa
         rzS79vkFDhQYYHoaTykFCOwqcJcCtZcKcwDoy6eDX0LoKwfB5C4IJNs+21pAZnwtjuuP
         UqDw==
X-Gm-Message-State: AC+VfDxaSrJSXrXsR+csGHP+NdqLo6L7Dilym3S+kc593+qdv2AlyW9L
        4C4lxKxS9GqWlzUJaI4o2NzNprf14W/AcTs9TlM=
X-Google-Smtp-Source: ACHHUZ6BcuJU502jJbHv1Jybwg5ggOt3C/KbDpNjJb60JOqg2GKgyLU/ZDW5zkSgpEl3ypSRsSmk71hi1WLxy8yfnUI=
X-Received: by 2002:a05:6402:514d:b0:51b:ca99:9fef with SMTP id
 n13-20020a056402514d00b0051bca999fefmr5431097edd.19.1687370079728; Wed, 21
 Jun 2023 10:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1549.git.1687327684909.gitgitgadget@gmail.com>
 <20230621081754.GA803861@coredump.intra.peff.net> <xmqqzg4siyru.fsf@gitster.g>
In-Reply-To: <xmqqzg4siyru.fsf@gitster.g>
From:   =?UTF-8?Q?Guido_Mart=C3=ADnez?= <mtzguido@gmail.com>
Date:   Wed, 21 Jun 2023 10:54:27 -0700
Message-ID: <CA++DQUkVzz8Zn0x6BR+sAEo_LXFR67Z+JOgMhcY2JpS5UGi4rw@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add an --exclude-links option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Guido_Mart=C3=ADnez_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, thanks for taking a look!

On Wed, Jun 21, 2023 at 9:08=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Jeff King <peff@peff.net> writes:
>
> >> This option enables a straightforward implementation of a `git sed`:
> >>
> >>     #!/bin/bash
> >>     git ls-files --exclude-links -z | xargs -0 -P $(nproc) -- sed -i -=
e "$@"
>
> Unrelated nit.
>
> I think -i -e above is iffy, as it does not distribute -e across
> "$@" and your users may not always want to edit the files.  It is
> better to leave them to the callers.
>
> "sed" is also something the caller can easily pass from their
> command line, for that matter ;-).

I should have known my one-liner would be torn to shreds :-). But yes, agre=
ed!

> Passing the entire command
> part run under xargs from the command line of the wrapper,
>
>     $ git for-all-paths grep -e pattern
>
> would also work just fine, for example.
>
> > ... A mild application of perl works, though:
> >
> >   git ls-files -s -z |
> >   perl -0ne 'print if s/^100(644|755).*?\t//' |
> >   xargs -0 ...
> >
> > So I dunno. That is not exactly pretty, but if you were hiding it in a
> > "git sed" alias or script, it's not so bad.
>
> Yes, the above would be a perfectly reasonable implementation of
> "git for-all-paths", especially if you do not hardcode anything in
> the ... part and instead use something like xargs -0 "$@" there.
>
> What is somewhat unsatisfactory is that we cannot pass pathspec to
> the "ls-files" so that the command does not have to be for-all-paths
> but can be usable as "git do-for-paths -c '<command>' <pathspec>".

Indeed, a command like that would be great, and doing `git
do-for-paths -c "sed -i 's/old/new/g'"` is still extremely convenient.
I suppose this command should take options -n and -P to pass to xargs.
In the case of sed, running in batches is _much_ faster than 1-by-1,
and it trivially parallelizes.

So would it make sense to
1- Add the file type filter to ls-files
2- Use that to implement a proper git-do-for-paths script/binary,
which can take pathspecs, filetype filters, -n, -P, and maybe more
?

Thanks again!
Guido
