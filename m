Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A07EC64E8A
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 12:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC22622241
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 12:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgLCMZk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 07:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgLCMZk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 07:25:40 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D44C061A53
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 04:24:53 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id b2so1887162edm.3
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 04:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=yexj1+5f2LvpY3j3RfJqpKzZAJnXZIG5jvVvbLglu+E=;
        b=P07gS/3+NQuR4l/kyPlzoeVjMMRNsc8SXgWvDovzUYCMTOCgjRSd53qX40x6ciM0FV
         qRV1h3Ep4lLOkBEBr1UdvV8S8UALVfRL41VdsiCCve5yB087eaAAjNaBicbHhfUzgBPh
         dMNQRwurQ3sd113SzWZPOo4HCmojQrsOVuZzvrIvWWJ5vUNzXqODWGDn2pkjg2Sl7n0u
         TpWeoPylTwmZx5q0Doadszri4KNgeUpdlRwym7/hXw7V3vAlvNipwzP/P84Jc1ds8bKA
         76e+HuIutYk7j6Fp6Yfyj0SJD1oanZCHHqIPfXntuSyXTDYG5bOHlOqLPUa+U9+mw2yP
         ENhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=yexj1+5f2LvpY3j3RfJqpKzZAJnXZIG5jvVvbLglu+E=;
        b=hmOAWxxi6ehVkxdcyQJ7YJs9PA75w2WmFmpo3ySIRkWaHU9EbfPCKFEMJNaWB4SA5t
         Nk8vQYM1gR/01KukrAl+c6P5bolsa0NIuPe9vEBDTMPGDXRldxt0K/xly5ao+YhX7ImT
         L+uZ1B2E/4pPZTy3rUGN897+M9Wm6oDRXS4Wgo0mhAwkO+PFW8jK0QAfiMJ2M3BMoz5w
         nDLJY7leyYdynors8RJlUzoj/dj1i4IsJmTTAQWU/BJIsEkpO2K1T4wseF1gdiz/LS95
         4K+vhVuEkRYFtlwgsl6GyTio/fxFsIW0QicqCB8Syz08JXuQG84QibQobVsNf603A2sr
         Cjag==
X-Gm-Message-State: AOAM531n/sBdx2EfcTxCjbKabbJw5GEn9+nWXBEMI5hbnfZHvwIPGc8B
        ZUwB70vUaJ3METejS3/WdSY=
X-Google-Smtp-Source: ABdhPJz0sh1kr8OC7q6NXNDRMRkbBXWxSW/ftlClAJzvvutd8GQbyBTHT44IKMq9CVgR0/YvohZnng==
X-Received: by 2002:a50:8a8e:: with SMTP id j14mr2628987edj.87.1606998292445;
        Thu, 03 Dec 2020 04:24:52 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id ho12sm647686ejc.45.2020.12.03.04.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 04:24:51 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: Reftable locking on Windows (Re: [PATCH 1/6] fixup! reftable:
 rest of library)
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
 <878bffcdfe5ca7657f839de8f7993d9098726636.1606545878.git.gitgitgadget@gmail.com>
 <CAFQ2z_N=sZuYorZxNLn-OoWjb6y=1zrc7sCPuKzZHQODi08s+Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.2012021149030.25979@tvgsbejvaqbjf.bet>
 <CAFQ2z_PNbMjrhVBaDsDWZbrgCFSQn=VBxxiyh=wpy+JZADmHcQ@mail.gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <CAFQ2z_PNbMjrhVBaDsDWZbrgCFSQn=VBxxiyh=wpy+JZADmHcQ@mail.gmail.com>
Date:   Thu, 03 Dec 2020 13:24:50 +0100
Message-ID: <87k0tzulf1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 02 2020, Han-Wen Nienhuys wrote:

> On Wed, Dec 2, 2020 at 1:32 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> > Consider processes P1 and P2, and the following sequence of actions
>> >
>> > P1 opens ref DB (ie. opens a set of *.ref files for read)
>> > P2 opens ref DB, executes a transaction. Post-transaction, it compacts
>> > the reftable stack.
>> > P2 exits
>> > P1 exits
>> >
>> > Currently, the compaction in P2 tries to delete the files obviated by
>> > the compaction. On Windows this currently fails, because you can't
>> > delete open files.
>>
>> Indeed. So the design needs to be fixed, if it fails.
>>
>> > There are several options:
>> >
>> > 1) P2 should fail the compaction. This is bad because it will lead to
>> > degraded performance over time, and it's not obvious if you can
>> > anticipate that the deletion doesn't work.
>> > 2) P2 should retry deleting until it succeeds. This is bad, because a
>> > reader can starve writers.
>> > 3) on exit, P1 should check if its *.ref files are still in use, and
>> > delete them. This smells bad, because P1 is a read-only process, yet
>> > it executes writes. Also, do we have good on-exit hooks in Git?
>> > 4) On exit, P1 does nothing. Stale *.ref files are left behind. Some
>> > sort of GC process cleans things up asynchronously.
>> > 5) The ref DB should not keep files open, and should rather open and
>> > close files as needed; this means P1 doesn't keep files open for long,
>> > and P2 can retry safely.
>> >
>> > I think 3) seems the cleanest to me (even though deleting in read
>> > process feels weird), but perhaps we could fallback to 5) on windows
>> > as well.
>>
>> Traditionally, Git would fail gracefully (i.e. with a warning) to delete
>> the stale files, and try again at a later stage (during `git gc --auto`,
>> for example, or after the next compaction step).
>
> So, how does this sound:
>
> * add a void
>
>   set_warn_handler(void(*handler)(char const*))
>
> The handler is called for non-fatal errors (eg. deleting an in-use
> .ref file during compaction), and can provide the warning.
>
> * all .ref files will be prefixed with an 8-byte random string, to
> avoid that new *.ref files collide with unreferenced, stale *.ref
> files.

Just trying to follow along here. Do you mean prefix the file name or
the content of those *.ref files? In any case isn't this synonymous with
proposing moving beyond reftable v1 (to the WIP v2, or a v1.1 with just
this change?). The current spec seems to preclude prefixing either the
file content or filename, but maybe I'm misreading it:

https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md#update-transactions
https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/technical/reftable.md#header

When the reftable format was initially being discussed I suggested
somewhat flippantly (why not SQLite?). Partially because in trying to
invent what's essentially a portable and concurrently updated database
format we'd be likely to reinvent much of the same wheel.

So not to drag that whole thing up again as a proposal for a format
replacement, but I wonder what SQLite would do in this scenario & others
where desired DB semantics / transactions and FS/portability semantics
clash. AFAIK the reftable has only been battle-tested in production
under JGit so far (presumably Linux-only). Whereas SQLite has been
ported to and widely used on Windows, HP/UX and probably other systems
where Linux-specific assumptions don't apply.

> * in reftable_stack_close(), after closing files, we check if *.ref
> files we were reading have gone out of use. If so, delete those .ref
> files, printing a warning on EACCESS.
>
> * an on-exit handler in git calls reftable_stack_close()
>
> * provide a reftable_stack_gc(), which loads tables.list and then
> deletes all unused *.ref files that are older than tables.list.
>
>> > What errno code does deleting an in-use file on Windows produce?
>>
>> I believe it would be `EACCES`. See
>> https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/unlink-wunlink?view=msvc-160
>> for the documented behavior (I believe that an in-use file is treated the
>> same way as a read-only file in this instance).
>
> your commit message says "to avoid the prompt complaining that a
> `.ref` file could not be deleted on Windows." AFAICT, this prompt is
> coming from windows itself, because the reftable library doesn't issue
> this type of warning. Is there a way to delete a file that just
> returns EACCESS if it fails, without triggering a prompt? Or is the
> prompt part of the "failing gracefully" behavior?
>
> -- 
> Han-Wen Nienhuys - Google Munich
> I work 80%. Don't expect answers from me on Fridays.

