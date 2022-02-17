Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239B3C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 10:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiBQKHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:07:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiBQKHS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 05:07:18 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722C130828
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 02:07:04 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id d11so1574854vsm.5
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 02:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sw5RGr9MWRhvFHs0yMBQkO+zOBda+kg/SgCH+4FOnj0=;
        b=FBDhm9x2KRZ4hWEv3KyXDxOAF+TjK/G/G7qyWP/Bb81UbabbZQxyZXkTxD/rV/LO5F
         dIhc1i4811YyZH2Ereqi39RRgbLJGK5f7uzbmtQhgS2vCWOnNX4B6ZxpcCLc96VqWA16
         uX26S4ikerh24zetaip4nxk6ccqH+oTeIe/UHVPk8iCEj5h7Q2Hwrn+dGcndIHHJoIYm
         oMJI+uVHo+xYxRivc/2lQCineDVOY7iIlGBHd536Is71bmAWkckuPW04+XkQpb11atbn
         +EXSjInMstwGmz9gTZClehR9+yn0SC4MpUObps2rhg94+R/vYKOMrQ2nKnCKOkRqpXZX
         gEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sw5RGr9MWRhvFHs0yMBQkO+zOBda+kg/SgCH+4FOnj0=;
        b=Io7/1XPQvrac79Qm2/seOsyeXyFcRPqkYj7i1UtedIb7YDhzwQRkVb82s3VBZ+gnxM
         pi+nOpfjCdnEI6YBF4jcyqTwbkGGBY9byYPpjcNRTbef9r24dHYLbnSYq/xvk3dDsehy
         9CfHukmNpRJ1SQjGNDvFXiJ/bb0h/KtifFtKRr3/j2MejsAw0GuD6Q1t0t9/8cYy+/E/
         EX5nGaPL2pNHQ8XVCHPsNu5S6SeZPRi6asPpXi/tz5MC7HDGMuZ+nhtM8m/R1u/nDyqi
         s0+4jHsnZRLRWqSr65JoO/oEZYkH11AZ+in/HA2sIvRv5BzcEgoARutDQg21PbJff7U7
         RhGQ==
X-Gm-Message-State: AOAM530u8kUKKY2FvHCS1rLBbo/XkKF3vRwarwfqNQEd2fuiGIRyvSfw
        5pMVHxIrpDzvS1psxdEc5dWrPgrsdLEmgpq5yblZ8xWGZAnFHA==
X-Google-Smtp-Source: ABdhPJy5h3Uc7I/lhuKDpm0fEUV/SNVXmFNCCnSoZjISG1W7t0kdVNQ0ESUYIT6Mmd4rmxrnYLIRyH9WALua2phbH0c=
X-Received: by 2002:a05:6102:2912:b0:31a:5ab3:f44b with SMTP id
 cz18-20020a056102291200b0031a5ab3f44bmr960549vsb.53.1645092024100; Thu, 17
 Feb 2022 02:00:24 -0800 (PST)
MIME-Version: 1.0
References: <xmqqczjvxy3o.fsf@gitster.g> <CABPp-BHrFb_AA2OAiR7Bmq7vQuyG2Wme_PdjPdY8j-tp3VJfJg@mail.gmail.com>
 <xmqqiltmwufw.fsf@gitster.g> <CAFQ2z_OgVcaty1wMX0O0mj-PYSAphKAkXgTCW+uJKDAuCwLn4w@mail.gmail.com>
 <xmqqh796tw34.fsf@gitster.g> <CAFQ2z_Pvje9LM0iyiP87S-L754zepEE_9k=_4Oa0w1Lo_pb=TQ@mail.gmail.com>
 <xmqqczjuttyw.fsf@gitster.g>
In-Reply-To: <xmqqczjuttyw.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 17 Feb 2022 11:00:12 +0100
Message-ID: <CAFQ2z_O=WguSAJDD4DRpwtX54A5dWQZQPCuQDR81idknQgchaA@mail.gmail.com>
Subject: Re: [PATCH] glossary: describe "worktree"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 10, 2022 at 8:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > on a tangent: I posted a patch to write MERGE_AUTOSTASH,
> > rebase-merge/autostash, etc. as refs.
> > Is that the right direction? They are read like refs, but they are
> > together in a directory with other bits of stateful data (similar to
> > what is appended to FETCH_HEAD). Perhaps I should rather change the
> > read path, so they're always read as files rather than refs?
>
> I think that would be a lot more preferrable.  If a file is written
> to record pieces of info, among which an object name happens to be
> included, it does not have to be recorded as a ref.  Especially if
> it is an ephemeral file like MERGE_AUTOSTASH and FETCH_HEAD.

For FETCH_HEAD, doing

  git fetch host refs/changes/23/123/1 && git checkout FETCH_HEAD

is the standard idiom for downloading a change from Gerrit. I suspect
there might be other similar idioms. This means we have to read them
through the refs machinery.

I think the most sensible approach is to pass the read/write through
refs_* functions, but special-case the storage, so it doesn't go
through reftable. We already do this for FETCH_HEAD and MERGE_HEAD in
refs_read_raw_refs.

This means we need a formal definition of which refs should be treated
as files. Maybe we could do as follows:

Pseudorefs are
  1) all uppercase toplevel names except for HEAD
  2) all refs that are not under refs/* (for example:
rebase-{merge,apply}/autostash)

Pseudorefs are always stored as files containing a hex object_id.

Pseudorefs can be read or written through refs_* functions, but given
the storage guarantees, it's also valid to read/write them outside
refs_* functions

It is forbidden to make cross-ref transactions that involve pseudorefs.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
