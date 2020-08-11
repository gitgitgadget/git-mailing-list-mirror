Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E593C433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 10:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4778920756
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 10:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GP+micLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgHKKuO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgHKKuM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 06:50:12 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F582C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 03:50:12 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g20so3353600uan.7
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 03:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w7MYwNDfAcFWIwaZpb1ZWyEDlxaM58fymy/kgpEi1KQ=;
        b=GP+micLz7gHA0/d7MalGNiXXIxHHVdj6JRdwzt7F9XocXoLBGJMCiAfW0XfSvjo6zO
         05k/pqgUmqGYjokcPYo2yXNo0NKH/Z++SFWXMfSyHfm10RBRFoVO2HwHeDa3ws4B627c
         hvOxh+9a1sNm+nRcxL86whG1wA3ZVHzDhgnR+l6y/6h3jrqocBu3m4HiVfMYRjlXKnqX
         GrIJCxWD2PDSfGbLhp6P4d/NDnuIXdszKEPrWU8zsN0PQEK9LzzvnHw642Ke0CSQTy96
         xZ/fDUX4b3fqymJqatXf6SO3fQCTjjqmiHTWlDWiWbUjLf27L7Q+k0BoEK+9v9y+bf84
         Q/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w7MYwNDfAcFWIwaZpb1ZWyEDlxaM58fymy/kgpEi1KQ=;
        b=TOgSZWJh1qSnBwBCNJy8DasB+GKrYM3ithYDxZLN/gtJ+GXmwOTwL+HjVIcziOy3Tn
         BeobBid9GLb+g69n3b29v54V7FtMzNFAXw9AvDX63oRhxLLFVqCiNYrDIhUTM9IJH6si
         93q5GYrhOV/aRCfgBRcriD+x5N3zTLd0QeGKEqj5H4ntQ2S2egeA697fTM0sLMM/Ugds
         X+klIqlIkaJJWV+VeO+eoM9ibQCWPh6SH5uHNWLKSeuGxTG7snRjLZseY1BcEvakaDWs
         XkbhditUxxYs1Hgutt7ZOf2oCehfzCGNPX+TSlBUF/hOuhX4qV/0NFBHjauofCqOEVWi
         c5Og==
X-Gm-Message-State: AOAM531NMKZGLsEJfGnzJscShl/nCR91KKAeX+Zx6GYZd0SaW+srSSc0
        RgyVtXgsA7daMMtL10t/TLQnVzIZ2W0aPWYzQK0nKQ==
X-Google-Smtp-Source: ABdhPJwqScagxcMMu8jNAFwjQBpxvM7RbTxmkB4HUNb41s+ohtOtYEbDEgI1eHgu3q4W5xWXs3SAkuJeXyM4iaVos3A=
X-Received: by 2002:ab0:6054:: with SMTP id o20mr17269734ual.87.1597143011254;
 Tue, 11 Aug 2020 03:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
 <pull.673.v3.git.1594925141.gitgitgadget@gmail.com> <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
 <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
 <xmqqpn8hgca7.fsf@gitster.c.googlers.com> <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
 <xmqqh7tjv6hb.fsf@gitster.c.googlers.com> <xmqq1rklrhle.fsf@gitster.c.googlers.com>
 <CAFQ2z_NU4=WcUDvVY9PNs+p-WU4u5=QY+=DHonGyK29numhWoQ@mail.gmail.com>
 <xmqqk0ydozqe.fsf@gitster.c.googlers.com> <CAFQ2z_OgNQKZ23gNB9=LqPn2M=WKL2vPQQpxm3drRWeN1sxH_A@mail.gmail.com>
 <xmqqk0y6cwst.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0y6cwst.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 11 Aug 2020 12:49:59 +0200
Message-ID: <CAFQ2z_NMH75mewQyvN=NnjYR059ut3jfJLH_GPuiMA0ehyzBrQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Remove special casing for PSEUDOREF updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 10, 2020 at 6:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Han-Wen Nienhuys <hanwen@google.com> writes:
>
> > Dealing with FETCH_HEAD generically isn't possible unless we extend
> > the API of the ref backend: the generic ref_store instance doesn't
> > offer a way to get at the path that corresponds to FETCH_HEAD, so we
> > can't handle it in refs_read_raw_ref(). In the current reftable
> > series, FETCH_HEAD is dealt with in the backends separately.
>
> I am not sure what the best way would be, but I do not think any
> existing code writes into it using the refs API at all, even though
> it may be read only for the first object name using the refs API.
>
> And I am not sure if we want to extend the write side API so that
> the callers can express the full flexibility of that single file.

That's not what I am getting at. I am just interested in how to handle
FETCH_HEAD in refs_read_raw_ref.

> So perhaps the best way forward would be to ensure that anybody who
> tries to read from FETCH_HEAD using the ref API reads the first
> object name in it from $GIT_DIR/FETCH_HEAD file as we've always done
> since the beginning of time, regardless of what ref backend is used,

Right, but how do we get at the value of $GIT_DIR given a struct
ref_store? We can either push that out to the ref store backend,
because each backend knows what $GIT_DIR is, or we can make $GIT_DIR a
property of the generic ref_store.

I suppose it's cleaner to make the latter API extension.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
