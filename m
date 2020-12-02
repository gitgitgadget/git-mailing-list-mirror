Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485F8C64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 18:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77112224B
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 18:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389431AbgLBScu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 13:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389422AbgLBScu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 13:32:50 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE10C0613CF
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 10:32:10 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id v8so1481388vso.2
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 10:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sfAW6+BLQdZscz5+nz/ycuWWcNsmJ3BPCEAYaj4sy9k=;
        b=pWnl/xkOrMBZHuLI5ONXCC1MLrTlQ09cJhblsfO5UKWx02pRGCa9xxGHMh7VD3MUPJ
         s2xOFGbeLhzdIVGziUW39hRyoDAN9HB52CRkyXFmIBgld1N2EAbwyDUuLvK4Yc9yIek5
         AkILTdJ8MH6O+cBJK5221y3SzraacPZTxXu+RnsRoZKSPwslBG0YB5R8FZKdchMCoY51
         jKihc/O3LJrWiksxMgYIN4FJPDPl1w8cTc/6TtlRigSwP6yaG2PYuBgxGiWRzR7BVKfh
         Vi43vxTMnaPn9pC61F/IzgqfBRxo76vul24utDoc12eHl66SxFvDJBGt4RektX78jx7i
         dHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sfAW6+BLQdZscz5+nz/ycuWWcNsmJ3BPCEAYaj4sy9k=;
        b=sOfX+S8DHNlnQWUL3hcpoe+3j6vP6em/DUdRONFgVTk+OXtrD7ji9ctyyPBgo/jXNE
         OgyvS6j82iRJJbbcVzaGJ7h7SreJb4DvUpk85/RmeqyKlAl8UfSo8vfLP9KEi1buT/Ze
         jxPptq2HJUxoj3Icsa4Vy+oWAMJQsY7wBiks/ksMNVgLPIGwJpR6bs0CQWPSvL6Pub6l
         WSDHMTUV3tEbzBDA5YZ+ho232T/llAtWnekKei3TvtL1LNoseX5trX319y0KAgRhPf0c
         rRgpo7O2G+gdtUI12bPtfCqmhKGCcwvL/iwuqx3kuJiwGnqFUaHWX2/HLG/kgtl9/ZMa
         w4Zg==
X-Gm-Message-State: AOAM530qTCnhR2l2pnGLw3vYuhq+4+coasVeLKVfQa5Me0pPUWMuJKu0
        ZPNW6AkNg/KyQYR/oJZUamoyXCh0UyN4vBO1rO6ndQ==
X-Google-Smtp-Source: ABdhPJx/YmiiM80mK5gv1+EuDvJKxNEDT3QiWyK4fcRmsP2ivlEOs85UmFI82bPgvr9eguCLIudFlGnQhxqZnqXQ/Gw=
X-Received: by 2002:a67:ed83:: with SMTP id d3mr3144604vsp.28.1606933928999;
 Wed, 02 Dec 2020 10:32:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
 <878bffcdfe5ca7657f839de8f7993d9098726636.1606545878.git.gitgitgadget@gmail.com>
 <CAFQ2z_N=sZuYorZxNLn-OoWjb6y=1zrc7sCPuKzZHQODi08s+Q@mail.gmail.com> <nycvar.QRO.7.76.6.2012021149030.25979@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2012021149030.25979@tvgsbejvaqbjf.bet>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 2 Dec 2020 19:31:57 +0100
Message-ID: <CAFQ2z_PNbMjrhVBaDsDWZbrgCFSQn=VBxxiyh=wpy+JZADmHcQ@mail.gmail.com>
Subject: Reftable locking on Windows (Re: [PATCH 1/6] fixup! reftable: rest of library)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 2, 2020 at 1:32 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> > Consider processes P1 and P2, and the following sequence of actions
> >
> > P1 opens ref DB (ie. opens a set of *.ref files for read)
> > P2 opens ref DB, executes a transaction. Post-transaction, it compacts
> > the reftable stack.
> > P2 exits
> > P1 exits
> >
> > Currently, the compaction in P2 tries to delete the files obviated by
> > the compaction. On Windows this currently fails, because you can't
> > delete open files.
>
> Indeed. So the design needs to be fixed, if it fails.
>
> > There are several options:
> >
> > 1) P2 should fail the compaction. This is bad because it will lead to
> > degraded performance over time, and it's not obvious if you can
> > anticipate that the deletion doesn't work.
> > 2) P2 should retry deleting until it succeeds. This is bad, because a
> > reader can starve writers.
> > 3) on exit, P1 should check if its *.ref files are still in use, and
> > delete them. This smells bad, because P1 is a read-only process, yet
> > it executes writes. Also, do we have good on-exit hooks in Git?
> > 4) On exit, P1 does nothing. Stale *.ref files are left behind. Some
> > sort of GC process cleans things up asynchronously.
> > 5) The ref DB should not keep files open, and should rather open and
> > close files as needed; this means P1 doesn't keep files open for long,
> > and P2 can retry safely.
> >
> > I think 3) seems the cleanest to me (even though deleting in read
> > process feels weird), but perhaps we could fallback to 5) on windows
> > as well.
>
> Traditionally, Git would fail gracefully (i.e. with a warning) to delete
> the stale files, and try again at a later stage (during `git gc --auto`,
> for example, or after the next compaction step).

So, how does this sound:

* add a void

  set_warn_handler(void(*handler)(char const*))

The handler is called for non-fatal errors (eg. deleting an in-use
.ref file during compaction), and can provide the warning.

* all .ref files will be prefixed with an 8-byte random string, to
avoid that new *.ref files collide with unreferenced, stale *.ref
files.

* in reftable_stack_close(), after closing files, we check if *.ref
files we were reading have gone out of use. If so, delete those .ref
files, printing a warning on EACCESS.

* an on-exit handler in git calls reftable_stack_close()

* provide a reftable_stack_gc(), which loads tables.list and then
deletes all unused *.ref files that are older than tables.list.

> > What errno code does deleting an in-use file on Windows produce?
>
> I believe it would be `EACCES`. See
> https://docs.microsoft.com/en-us/cpp/c-runtime-library/reference/unlink-w=
unlink?view=3Dmsvc-160
> for the documented behavior (I believe that an in-use file is treated the
> same way as a read-only file in this instance).

your commit message says "to avoid the prompt complaining that a
`.ref` file could not be deleted on Windows." AFAICT, this prompt is
coming from windows itself, because the reftable library doesn't issue
this type of warning. Is there a way to delete a file that just
returns EACCESS if it fails, without triggering a prompt? Or is the
prompt part of the "failing gracefully" behavior?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
