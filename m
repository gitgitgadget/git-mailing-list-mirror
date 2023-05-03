Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17182C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 20:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjECUcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 16:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECUcx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 16:32:53 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EF56E95
        for <git@vger.kernel.org>; Wed,  3 May 2023 13:32:52 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b99f0a0052fso7836433276.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683145972; x=1685737972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Oghzab4z16KJaPOLughgNYU/9FJ8QIkevhkVbvvERg=;
        b=N3LIKNyCVXaoi3ynEVRXfltHHQDmTdS1+DwYuS57FmgOq05BlQ8O9R2N6lnlEM3T0+
         VRZ+QaVJ4i5sZ7PKNBreogwAQ+sEHkOB6YVEj+lT/aookrVCNDwF786rSOMI642Zl09E
         zuKtWS6nuNzcttrlPowBQYQzqLpQV2Wdcy6C1ILIPUiDtVGPI/Zzu7MhDdJ/9ukM5k7V
         yAM/g96u6L1P6AyaqC2g9rnjNJu1euFLWQ2W4hONhsx689ngXFwmKcHvYCVTQl5iNQis
         AMaPIst64xDfmQ9WKALDpxk/rsBCtLOTOcjSc7ZxB8959To9MPV7TX1NSYbDg+T4hH0i
         iKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683145972; x=1685737972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Oghzab4z16KJaPOLughgNYU/9FJ8QIkevhkVbvvERg=;
        b=TBQnvnfKRUwNqnBmNNFkHClh5cvTEo/J7AkruIw5qkHGY6rHZKSpxTEJeKVrQTT1bG
         igakYlzNMwx78TXcG89qBgryEDOk3K0mnMP4xSgwpCprsStDHAeTDYyUgNjaAmvKv2Pn
         0awfoVpgetfqFmzzSC5snjd8aPU3ihLZUTa9/XC5/T4NQ1peYeWVmbwh0hONjINYqAyH
         q1WijKP/lJt34DXZ1WRMRkROZWNhBBeAQYL6ypysar4LHwBAbg6KxUfTMybiXx/kJPVG
         itRND58l04TiUCLVeVjNN3jMAtEG2kPfbHKXMJe1Gz8zd9NuCOapxsigTl0IlQc/Kcqy
         JZxw==
X-Gm-Message-State: AC+VfDystVK/Q5g+QUE3Mr2t0qOB/a+RQOiEcVQ4NIGdIchJ9lHe63xk
        BIEo6eaXYPhxfYbYYrn7ThFPyZcD2WlKWDx+lR1Onpv1y1k=
X-Google-Smtp-Source: ACHHUZ7iVAtGZlkzR2mV+KB05ONDQ9j+ACST2EBWpTUMaQyh0LuSupizCNSZK/+USorKxuEZsauHy4os85eStc9heW0=
X-Received: by 2002:a25:6886:0:b0:ba1:643f:c114 with SMTP id
 d128-20020a256886000000b00ba1643fc114mr2649518ybc.35.1683145971960; Wed, 03
 May 2023 13:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAJXgQP1j6JYbtikMuWGFn44+FVb3PfmuwiFrxDGLQAYgr92Wfw@mail.gmail.com>
 <xmqq1qjxqkbo.fsf@gitster.g>
In-Reply-To: <xmqq1qjxqkbo.fsf@gitster.g>
From:   Kevin Ushey <kevinushey@gmail.com>
Date:   Wed, 3 May 2023 13:32:15 -0700
Message-ID: <CAJXgQP2Rvye6U64_Nv9a0VbTJF=WsT741J42gfQmP9vz74u0ww@mail.gmail.com>
Subject: Re: git grep -E doesn't accept \b word boundaries?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the quick response! I wonder if this issue could be macOS-specif=
ic?

I just tried building git from sources, and I was able to reproduce
the issue with 2.39.3:

$ ./git --version
git version 2.39.3
$ ./git grep -E '\bupdate\b'

But everything works okay for me with 2.38.5:

$ ./git --version
git version 2.38.5
kevin@MBP-P2MQ:~/projects/git [(HEAD detached at v2.38.5)]
$ ./git grep -E '\bupdate\b'
.github/workflows/l10n.yml:          sudo apt-get update -q &&
.gitignore:/git-update-index
.gitignore:/git-update-ref
< ... etc ...>

I see this bit in the release notes, which seems potentially related:

https://github.com/git/git/blob/69c786637d7a7fe3b2b8f7d989af095f5f49c3a8/Do=
cumentation/RelNotes/2.39.0.txt#L64-L65

And indeed, I can't reproduce the issue if I compile git 2.39.3 with
'make NO_REGEX=3D1'. So, perhaps a difference between git's compat regex
library and the one provided by macOS?

Thanks,
Kevin

On Wed, May 3, 2023 at 12:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Kevin Ushey <kevinushey@gmail.com> writes:
>
> > I'm seeing the following, which I believe is unexpected. I have a file
> > with contents:
> >
> > $ cat hello.txt
> > WholeWord
> > Whole Word
> > Whole
> >
> > I can use `git grep` to search with word boundaries; e.g.
> >
> > $ git grep --untracked '\bWhole\b'
> > hello.txt:Whole Word
> > hello.txt:Whole
> >
> > However, if I add `-E` to use extended regular expressions, the same
> > invocation finds no search results.
> >
> > $ git grep --untracked -E '\bWhole\b'
>
> Does not seem to reproduce for me.  In a randomly picked repository
> (the source to git itself), I did
>
>     $ cat >hello.txt
>     WholeWord
>     Whole Word
>     Whole
>     ^D
>
> and "git grep --untracked -E '\bWhole\b' hello.txt" with or without
> the "-E" option shows the same two lines as hits.
>
> Without the pathspec hello.txt, the output includes one line from
> unpack-trees.c as well, but the hits from the untracked hello.txt
> are the same.
>
> The tip of 'master', v2.40.0, v2.38.4, v2.37.4, v2.35.4 (they are by
> no means significant milestones---just some random versions I picked
> to test) all behave the same way.
