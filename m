Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B9C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5297E6124C
	for <git@archiver.kernel.org>; Mon, 31 May 2021 15:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhEaPbZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 11:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhEaP2B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 11:28:01 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E34EC04345E
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:16:38 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id s14so3432767vsk.1
        for <git@vger.kernel.org>; Mon, 31 May 2021 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UYBjYICPnNq66//9XVOAu2lwTr2EeEJvWL1rtCnoGO0=;
        b=M60g5UOPUkUSMidzw4FfHJDGDqWFEvYX3HDzUk1fA8tF9u3hypHGmSRnYkC80t3V/J
         4/zPRwCYsnNvM8QLDSMsWaudVeVB96Lj+KWjP+O22YYaKl2b4FPCN2HN/kCcbtaV0lzK
         CazdIvZw+4YJq5akOY/TjSrYdNi5fhIFp24jab3zbzq8z9w6ekDcYlPOjcwcWOPPKPjS
         JwwsNo7X3zEhaCm/gv6Dys29qU9p4wrTWS0900CmH+XwTVtwa8zt7E0EvhUjq1UMqZWR
         Eh/A5uIfrXolH3lJWr7uuPfKkGhyXyC2zjFmMgnycOF/71FDE6tNT5+38BPnNeNnUkkv
         6MvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UYBjYICPnNq66//9XVOAu2lwTr2EeEJvWL1rtCnoGO0=;
        b=ngdHgPovYXFjTWPcBgwtV8+tTPWKOCWrE24CWEEJmODOq3JSbV+qfEIUQmTFIPKjJ2
         thGe1glRLbciPtcCpDyFUyjBb8dphlht5NbcEepwMQzBZVurL6xiPiBoiR82gh/Jfh3B
         Fe5+KBQOCUuP7CmTxS+8Ndni0GVKnRhusAdHYVzugxjzqL82qPg8jf1uKs64DdjFRYWZ
         KZPzbZ2ua8zFTStFIeQF825CS5GWVZEhjDfJGYF1pG28Kpd/oVXWuO2rp3rudJDswmCk
         agd1bswc4YOSd4Lv0sXYA5MiWh4AZYaZpas+wSqzdwRz9OhNnWPr+IaljzjkuulO9PCp
         jyWQ==
X-Gm-Message-State: AOAM5331v8y1AX65B8LEyDcqvQnG4Jc45t50H8oZ64JMoSITiJ/Zk0rP
        8MN8uPKwn7M87tKqntbcb4RGZzZkShzkJIixmlNtLw==
X-Google-Smtp-Source: ABdhPJy+a3e5/6igbvXW8ofTcR120R7zUlrOwY+r2LMCiPSt3N+FZDAaXkpeMT7tVGhrCb7Zd1zHVhffftN6xixRaJs=
X-Received: by 2002:a05:6102:9c9:: with SMTP id g9mr13314564vsi.50.1622470597583;
 Mon, 31 May 2021 07:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com> <d7e5de8dba465098afa421d162df5ca7b0fb1a33.1619519903.git.gitgitgadget@gmail.com>
 <87bl95pfnt.fsf@evledraar.gmail.com>
In-Reply-To: <87bl95pfnt.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 31 May 2021 16:16:26 +0200
Message-ID: <CAFQ2z_N=RtSeD6f3a2VPVdDUBxFS1ekC=na=5iVcsWOpkDdORw@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] t1415: set REFFILES for test specific to storage format
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 20, 2021 at 5:51 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> > -test_expect_success 'refs/worktree must not be packed' '
> > +# The 'packed-refs' files is stored directly in .git/. This means it i=
s global
> > +# to the repository, and can only contain refs that are shared across =
all
> > +# worktrees.
> > +test_expect_success REFFILES 'refs/worktree must not be packed' '
> >       git pack-refs --all &&
> >       test_path_is_missing .git/refs/tags/wt1 &&
> >       test_path_is_file .git/refs/worktree/foo &&
>
> Nit but also chicken & egg: Let's keep the "pack-refs --all" though
> under reftable in its own test, and do the test_path_* assertions just
> under REFFILES, i.e. does/should pack-refs warn/error under reftable as
> redundant, succeed silently?

I don't understand your comment. This test is checking constraints on
worktrees that are only relevant for loose/packed storage. In fact,
under reftable, there is no such thing as a "packed ref" storage
class. This test is just not relevant for reftable, and I tried
explaining in the comment why this is so. Happy to hear how to further
clarify this comment.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
