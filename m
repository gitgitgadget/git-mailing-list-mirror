Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C29C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 18:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B287461441
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 18:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbhD2SPk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 14:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbhD2SPk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 14:15:40 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA2C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 11:14:52 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id a11so8324846vkl.0
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 11:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=m7Y1vniXNFXlon/yM6OWKE6bthh45YLIY2PV/lr0bZ4=;
        b=g+853ys28upeegApJ4tWwPoQ9JgBes7XM4f7CX4k9BB7iDElJxpLy8fYXV1SLzzpuG
         emRgS/KL//gTvoBG/uNAhyGJpO+u9fU8+h3D9cudEsdiY8TLp0otiLlaqpoj9LBgYKGQ
         SfO5tgnGHzdcT3HRJ1CW01AvJv5q4kOYPivU8HqehZbKnGdlSipN7Dxt6r6WFGYZajTx
         Pqvtaw57YrDxsu1CcrQNQWEfe00jQGIHDeCP5tnyy6e/pdIl0g5aBo6D+9vEgzs6MfPq
         dap3GyLyEfgfzc6WmFWfZrH4lexAFsO5W6lJSfAVgXKjxTmNbsUpW4XkD2BW5WQRAY12
         Jg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=m7Y1vniXNFXlon/yM6OWKE6bthh45YLIY2PV/lr0bZ4=;
        b=GnS/HRc96OcdF0iZF8x8+mrJ9iGesqR7KUquxJnDQZ7lJk4lJ1Ws5YSRl7YKK5dZJ6
         TSwtDoRMqFuVRyCy/nlxA/oXAQogrKfp0ebtgHeFWTJrCUOcrksvmaYB8Y6ABh1m44zp
         qfH53ozdJf/Igif1ENgiL6xKx1D/B+2iyhaRzjl1Ch7vK0qvYPUWX2s0j/cOFXgpSduP
         Novd5sJrStZIocS6EyMuLWbE2jOMyxao4MHSHhb92RcJj8iId0cnWi8fzp8rOBifU/da
         omldiucUiwQ4HVlytwsQgRix10971x/qLGY1QZOXYP1v9AaKYm+VyXayq8qOhMXnU+FA
         c0JA==
X-Gm-Message-State: AOAM532RnPO6Mgcuph2k5NISdfHdJ/XALpqB4N6rDknlfvg5wmf8GoPN
        cJ1eS/KeiUrz9JIkyEGNCXHo0rDwyQjkHbK+keWpQQ==
X-Google-Smtp-Source: ABdhPJyu17xEXiN5wcDODAy1cpZogjKoPzGxqj0ATQXOZRAz3W7JolOVi9GMGiXq3GJiJJnvjuXzrt7rQ2TiLYRExpA=
X-Received: by 2002:a1f:53c7:: with SMTP id h190mr1873251vkb.19.1619720090862;
 Thu, 29 Apr 2021 11:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <1ce545043846ee06070d1a4bc05fcd5221847eab.1618829583.git.gitgitgadget@gmail.com>
 <87pmyo3zvw.fsf@evledraar.gmail.com>
In-Reply-To: <87pmyo3zvw.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 29 Apr 2021 20:14:39 +0200
Message-ID: <CAFQ2z_Mdv=vZa5yzBjGyG_o4poNeSJsfa7-KwpVH559cWqM9Qg@mail.gmail.com>
Subject: Re: [PATCH 13/18] t2017: mark --orphan/logAllRefUpdates=false test as REFFILES
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 8:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > In reftable, there is no notion of a per-ref 'existence' of a reflog. E=
ach
> > reflog entry has its own key, so it is not possible to distinguish betw=
een
> > {reflog doesn't exist,reflog exists but is empty}. This makes the logic
> > in log_ref_setup() (file refs/files-backend.c), which depends on the ex=
istence
> > of the reflog file infeasible.
>
> Okey, so I'd follow this if the test was doing something like "test -e
> .git/logs" to test whether we didn't have reflogs for a specific branch
> or something....
>
..
> In your v7[1] of the reftable series there's no patch to
> Documentation/revisions.txt altering that blurb.
>
> So it seems to me that between this & that series there's some closing
> of the gap needed with how this "must have an existing log" even works
> under reftable.

the problem is that it's using BRANCH@{0} as a way to indicate whether
the reflog exists or not,  and something looks at the current tip of
BRANCH for @{0} even if the reflog is empty:

hanwen@hanwen1:~/vc/git$ ls -l .git/logs/refs/heads/windows-2
-rw-r----- 1 hanwen primarygroup 0 Apr 29 20:08 .git/logs/refs/heads/window=
s-2
hanwen@hanwen1:~/vc/git$ git rev-parse windows-2@{0}
7048e02d79350e332f34f2bfae50eb28700cbeda
hanwen@hanwen1:~/vc/git$ rm .git/logs/refs/heads/windows-2
hanwen@hanwen1:~/vc/git$ git rev-parse windows-2@{0}
windows-2@{0}
fatal: ambiguous argument 'windows-2@{0}': unknown revision or path
not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

in reftable, with the current implementation, all reflogs are assumed
to exist (but possibly empty).

> Per [2] I had assumed that this worked under reftable by abstracting
> away the syntax to some query for the ref name, and faking up "file does
> not exist" as "there were no records" to anything like rev-parse, but it
> doesn't work like that?

you could make it work like that, but I bet that then there are a host
of other tests that fail because they might check that a reflog exists
(but is empty) after doing eg. "git reflog expire --all".

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
