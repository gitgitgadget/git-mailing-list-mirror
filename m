Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE626C4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D366108E
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 09:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhHRJBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhHRJBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 05:01:23 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34947C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:00:49 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id v26so1364352vsa.0
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yjcDv9zsENwodx+2hgFEXlKPLuUUNyEY43MgZ4W2kzs=;
        b=kepHrdw2H2KC0UVRK74ly0NgysK0BsktjnlqvkZdBPCeSMV2MP96hzEEa4k+/E9+x0
         hvPCjvKi7qYkjOiVWxt4s8DCWlHmeRQ3rOMCRjLOJONsXvbqnF5rSDXTOxkdC003kAtG
         fDx19m6YZheIbSDAR44M7jIEk87wAfU6QceJ4D/tg2f3DS/w5ix7tisr5rTnILBG7qmJ
         YhwV8fOoQMEAdrLsEZ+q7masEdTLpiL2WMN3aKORvK9aMhZD5oNjPiAy++TliC0o0R9y
         K29NRxCK9gcGgpgShvQE3+QqkMsAun1QcKgPBtyouurCPG1Ig71BxAI7TipRQH0E+o4e
         QktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yjcDv9zsENwodx+2hgFEXlKPLuUUNyEY43MgZ4W2kzs=;
        b=SvJTaKfAyO34S0Zw3t63Cg2Ud9yuZTyGIq/pMeR8KnxuWvtEZLPRvcej/3Umky3lJd
         g/xbO7eu+pDOIAPq4lK5tAAMSTctIWAwWOXDWwxRRw3V5THc/4ba7T84KeUct9HQPcjl
         peTqg0bRgfu4XNk26ZVgNdYYXusV3P3IHCkqRLUJOn9ZI47RwuXiqQn+JTpSRpOVdDC+
         QHKmJE5LY3i3GD9fPFZalvimltIzfmVOn1qgVQeFOEyo5cSy5wgquAwafpXNz86JieAB
         wVMWDIs7itx7SjfJaN8tA97EKPBPi5B1JdluUSSgQUylUJbdrIDEEEkSulG22MzRDt93
         67Eg==
X-Gm-Message-State: AOAM533BmHKf7NvYLC8nKb9DdwxSGLbTKInpBtzvE7nCm1TvM5hT5z4g
        4rAG78OXtEw+cOoJMyZuiPqgDAvb6Fll3lV7MiON9w==
X-Google-Smtp-Source: ABdhPJw/b/A6AZ+osEceXzmHj6sAfpQSHkUliM8h3hWHZBCdkkQB2BwvIptDdHT0dyVStJA9ze8wNbpa77YoNJt8Ync=
X-Received: by 2002:a67:e989:: with SMTP id b9mr6582331vso.2.1629277248166;
 Wed, 18 Aug 2021 02:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1068.git.git.1629203489546.gitgitgadget@gmail.com> <xmqq4kbn7l3l.fsf@gitster.g>
In-Reply-To: <xmqq4kbn7l3l.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 18 Aug 2021 11:00:36 +0200
Message-ID: <CAFQ2z_Ni1bvj0Skgp_3p9htQfjn_M=3uF06pyZm_hkXgT_L61g@mail.gmail.com>
Subject: Re: [PATCH] fixup! propagate errno from failing read
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 18, 2021 at 12:38 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > This fixes a crash triggered by the BUG() statement.
> >
> > This can occur with symlinked .git/refs. To check availability,
> > refs_verify_refname_available will run refs_read_raw_ref() on each pref=
ix,
> > leading to a read() from .git/refs (which is a directory).
> >
> > When handling the symlink case, it is probably more robust to re-issue =
the
> > lstat() as a normal stat(), in which case, we would fall back to the di=
rectory
> > case.
> >
> > For now, propagating errno from strbuf_read() is simpler and avoids the=
 crash.
> >
> > Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> > ---
> >     fixup! propagate errno from failing read
>
> Hmph, I do not see a commit with "propagate errno from failing read"
> in its title anywhere in 'seen'.

> I think the convention to assign errno to myerr in this codepath
> originates in a0731250 (refs: explicitly return failure_errno from
> parse_loose_ref_contents, 2021-07-20), and it forgot the part of the
> code being fixed with this patch.  The commit being fixed is already
> is in 'next' as part of the hn/refs-errno-cleanup topic.
>
> Usually, a flaw in a topic that is already in 'next' is corrected by
> a follow-up patch, but then they won't say "fixup!" (none of our
> bugfix patches do).  But a post-release is a special time, as we
> will soon be rewinding 'next', restarting it from the latest release
> and we have a choice to tentatively eject a topic, fix it up or
> even replace it, before merging the corrected topic to 'next'.
>
> Do you mean that you want me to squash this change into that commit
> before the topic graduates to 'master' during the new development
> cycle?  If so please be a bit more explicit next time.  Using the
> title of the commit after "fixup!" would be a good starting point.

The problem fixed here affects anyone who uses git-repo (ie. does
Android development) and runs "git-branch -m", which is a large group
of people, so I think it should not be allowed to get into a release.

So it could be squashed into commit a0731250, or put on top of next as
a separate commit (probably with 'fixup!' removed).

Note that, even though commit a0731250 originates from a branch called
"hn/XXX" and has me as Author, the BUG() call causing the crash was
actually introduced by AEvar when he reworked the series.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
