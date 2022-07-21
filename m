Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1DBC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 01:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiGUBKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 21:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGUBKI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 21:10:08 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF5F103B
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 18:10:07 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id i4so104579qvv.7
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k48JGSqmj/eE6cuZ0L0H+oAlZp0hypOCvb25kZ5kBGA=;
        b=gT8+CFbm9VVo8H4T+/nGlSskmmnvmAcxy6UXaV56Vn5BRJjbRyuXEM1ETMSfRhQuH+
         pCg9Eje2rSzK9Ase1ckjiA0yG/N1P84juGxKeN3RuXlbPruzHCRaf9wqvY+dae3cFj+B
         vVuq22ZgsXahF5OBxhkh1DC/xhwUo7xUQEK8h1RxJWZuJVPZeGj6z/ksK6hvnHapHr1+
         AwfofldtF9UZX5UDI3WU6JNHf5Jon/T/SgnCdCMqVnNsarVt9HGYsKUHK/9sRvA3AFS/
         6mTDDY5g3kle1u4bNMQPOpfL/8P51n4eUeT5Po/ACzMkn3IjZ4vBDxjOgiJZDFw49jm+
         cxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k48JGSqmj/eE6cuZ0L0H+oAlZp0hypOCvb25kZ5kBGA=;
        b=cm96qzVewTuH0PCZE7XW+Q/owKbr144Sri4LzMlCSZ+oit0YcGSqn/M7pbzseQ/Oto
         RjRarfP5Jcsr6V8F3BOk5pvwa+YL6ZfNPfIU8DxSciCS6UkJTNqAfDwLDLDbqA6Ykai7
         1hVldu9iuJfaveL15GvBxd5GEak3fybCPOLcF9NRqNF8NkK1jYQap1ToxNs9+OroXt1x
         DkApltJZr4lES2aJM5wpz841F0qG87Acu7YbcLS12o0r3HcjhPGPjJEFu0iafG45tuBs
         a3chnASuCBTT3vgI7HkZwcR8Ier3VSD3Amm8aJOXcwifFrDeiTGYvm7NQQ9CqanD3Ot8
         pqBQ==
X-Gm-Message-State: AJIora8CTMNirf31HKfkrwkg75xXiWtlM4fBu9NwozozDiZKuG1nrWyN
        Hm+hQJp4lTsA20mqvj+/8+zXZvBfZm2W0Ws/oXI=
X-Google-Smtp-Source: AGRyM1unDx8NwuQJ4iAtPQa9DdrLlI1VKljOPQMrcWCMszQYAqJlVHX0GTGR+s1oH6XgFeJqqAqLh9Z1sK2KdxGqSiA=
X-Received: by 2002:a05:6214:519a:b0:473:6d83:17e9 with SMTP id
 kl26-20020a056214519a00b004736d8317e9mr31121786qvb.115.1658365806347; Wed, 20
 Jul 2022 18:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
 <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com> <89e5e633241e45a0c4b18289ab2fafdaabc8191e.1655621424.git.gitgitgadget@gmail.com>
 <CAOLTT8THesUrMtov0L=pHKNfdABYvHeue6OzHre-sQD36=2e=g@mail.gmail.com> <xmqqo7xk7m73.fsf@gitster.g>
In-Reply-To: <xmqqo7xk7m73.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Jul 2022 18:09:55 -0700
Message-ID: <CABPp-BGMzyJR3C2EREXV5y50N30c9EuVTt9mExcxnfQT2ot3Vg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] merge: fix save_state() to work when there are
 racy-dirty files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 19, 2022 at 3:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=
=E5=B9=B46=E6=9C=8819=E6=97=A5=E5=91=A8=E6=97=A5 14:50=E5=86=99=E9=81=93=EF=
=BC=9A
> >>
> >> From: Elijah Newren <newren@gmail.com>
> >>
> >> When there are racy-dirty files, but no files are modified,
> >> `git stash create` exits with unsuccessful status.  This causes merge
> >> to fail.  Refresh the index first to avoid this problem.
>
> Racily dirty?  Or just being stat-dirty is sufficient to cause the
> "stash create" to fail?
>
> > I just want to show what sence will meet this errors:
> >
> > 1. touch file
> > 2. git add file
> > 3. git stash push (user may do it before git merge)
> > 4. touch file (update file but not update its content)
> > 5. git merge (call git stash create and return 1)
>
> I think, from the above reproduction recipe, that the breakage does
> not depend on racily-clean index entries (i.e. file touched within
> the same timestamp as the last write of the index without changing
> their size).  So s/racy-dirty/stat-dirty/ (both on the title and the
> body) would be a sufficient fix.

Yep, stat-dirty.  I'll fix up the title and body; thanks.
