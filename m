Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD06C4321A
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A580E64ECE
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355393AbhCCGfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384369AbhCBVyG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 16:54:06 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8F5C061756
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 13:53:10 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e2so19439580ilu.0
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 13:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkNE4OAWmELjagcdsLMITULMX2+3gPA5+g/m3JNKlzY=;
        b=sDX/j/Rj5BpsUPF7Wz8iDAXPOKyfn4+3aIQwXxXyCxW95tXBRUXSiRO8lK08bV4oJO
         K75SGzb5E4nrGn/H7SqkYX+QV1Of81y+TPrvqIEwkm+y5X7IKr0gZuJCh/Uiz+3K/xEI
         hH+jsODfK+OmHlOgyYfz+cizT1L5LhzFBCMYHU2Es/RQ/etEazL+bdSvyiWyCPWGzj9m
         DdcxewRUftd2cSZfkWG/Fqum6s4ZpHurDtr8Ql12T3p7uv4kJxznOBu0w1n0zarZyrSi
         2j7KE5KiRj+qSYlLmtniqfPpGhY4vlxHeE5TNoBcCegmG1bJHfFbhq4nW9nVboy9zDso
         bz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkNE4OAWmELjagcdsLMITULMX2+3gPA5+g/m3JNKlzY=;
        b=nZn7FzBCOM6voCHF5nh8pZ3FDRatc9nRqzu+xLwnUWMkyaMQHd9bVpKUvKKQy8rAmj
         phVxRDpTc6B0rAqYjFJwmhSpjB5pHzghWsbR4vCD8hKAPcKK9advM0817hNg44Sn58Mh
         35fmuhu2mMGvaVUhBDluJNTArIQjoNRU6XHYD1PfXWq0M6oMvWerNjxx1LARBcXD2FSg
         V+qQpcxywQyqSDTN/PQ7od4T7IMwZ7FCXzeIfXmaij0uYUH/7DQjdFkNjkTq4I9epDHP
         NOqmv2xpdyk6vH9hYQnr7+7/ZjxDWSR/Ok/lmHPluOu36ZP2MZNSlYWdVb0a83yvvlRt
         IFTg==
X-Gm-Message-State: AOAM533U6XDd2lnAURVKSKofYc7chi4eThyaDqezqieSuR2h0vFVDDC8
        Lrr7fcrHtqi0mugnZpa6MCXier9ilehjkYu7cFI=
X-Google-Smtp-Source: ABdhPJz+t7GCNyF+KBi2Lt2+lsPvJRa7Gd8gnb/a9PDrqX/CbJCYPR68K/fv60ABlTeN5ETs8FnY90MFYhiXb6pwvRo=
X-Received: by 2002:a92:c269:: with SMTP id h9mr19005621ild.239.1614721990378;
 Tue, 02 Mar 2021 13:53:10 -0800 (PST)
MIME-Version: 1.0
References: <CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com>
 <CABPp-BGDB6jj+Et44D6D22KXprB89dNpyS_AAu3E8vOCtVaW1A@mail.gmail.com>
 <CAPkN8xK9__74a3aEFsevfdW_hQ-vzWE+c=QypRacTktuZOfdSw@mail.gmail.com>
 <87mtvolbuj.fsf@evledraar.gmail.com> <CAPkN8xLE68d5Ngpy+LOQ8SALNgfB-+q4F3mFK-QBD=+EOKZSVg@mail.gmail.com>
 <xmqqblc2srq0.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqblc2srq0.fsf@gitster.c.googlers.com>
From:   anatoly techtonik <techtonik@gmail.com>
Date:   Wed, 3 Mar 2021 00:52:53 +0300
Message-ID: <CAPkN8xKM0zi-AB1xKRGp=whEQTZAbn78w0JjvUXfGfRDky0C=w@mail.gmail.com>
Subject: Re: Round-tripping fast-export/import changes commit hashes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 1, 2021 at 8:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> It is just that the output stream of fast-export is designed to be
> "filtered" and the expected use case is to modify the stream somehow
> before feeding it to fast-import.  And because every object name and
> commit & tag signature depends on everything that they can reach,
> even a single bit change in an earlier part of the history will
> invalidate any and all signatures on objects that can reach it.  So
> instead of originally-signed objects whose signatures are now
> invalid, "fast-export | fast-import" pipeline would give you
> originally-signed objects whose signatures are stripped.

I need to merge two unrelated repos and I am using `reposurgeon`
http://www.catb.org/~esr/reposurgeon/repository-editing.html
to do this preserving timestamps and commit order. The model of
operation is that it reads revisions into memory from git using
fast-export, operates on them, and then rebuild the stream back
into git repo with fast-import. The problem is that in the exported
dump the information is already lost, and the resulting commits are
"not mergeable". Basically all GitHub repositories where people
edited `README.md` online are "not mergeable" after this point,
because all GitHub edited commits are signed.

For my use case, where I just need to attach another branch in
time without altering original commits in any way, `reposurgeon`
can not be used.

> Admittedly, there is a narrow use case where such a signature
> invalidation is not an issue.  If you run fast-export and feed that
> straight into fast-import without doing any modification to the
> stream, then you are getting a bit-for-bit identical copy.

I did just that and signatures got stripped, altering history.

git -C protonfixes fast-export --all --reencode=no | (cd
protoimported && git fast-import)

-- 
anatoly t.
