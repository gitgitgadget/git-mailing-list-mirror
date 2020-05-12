Return-Path: <SRS0=6g9E=62=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CF2C54E4A
	for <git@archiver.kernel.org>; Tue, 12 May 2020 07:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82055207FF
	for <git@archiver.kernel.org>; Tue, 12 May 2020 07:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l8HMxfwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgELHtn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 03:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgELHtm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 May 2020 03:49:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EDBC061A0C
        for <git@vger.kernel.org>; Tue, 12 May 2020 00:49:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so14045977wrp.12
        for <git@vger.kernel.org>; Tue, 12 May 2020 00:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KHeb2x3Fmq+hjLePoNCTTI3+OvTDkFmzrmODHFGeluU=;
        b=l8HMxfwXD81uN7nIE+z4vRbUd7a6gIZpvQrLtxFyp01/pa90bHA48MX0P3sL/sCSEo
         yGNiplCkrbhJ+PQCnaioXbjWiC95I5tY5dLodpMWNi83cxZNkGiy8Jwb/FYappPpONLM
         kAmAkH6kfkdOLkxHwxZ9KU8HBEA/WssUFo/OD0NEZx8hVCTGzk+SGNbrCeQsXE1kB8Uu
         KmXk642ER9h10DUNKbVVQYAHvS7kUu6aJxDLVjcqvWJW+qy/zjkke6PSooF6msrFhv7H
         1CBPu9GSvZdoFAEiFE53ecXN4rlVPFzcMOAfuIxMOTNzBlIgSZpXjbTWF4JxcYplAyKU
         kbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KHeb2x3Fmq+hjLePoNCTTI3+OvTDkFmzrmODHFGeluU=;
        b=rBB0jugx5FTKXx5UhMVpbzLb/Vi2q2h5i2+Lq6qYxUIJieFDiHXzbN5fqORjrvAq2d
         4JtSSeHX+M+Dc+nmFN2fPE8yyuWkUpxxIQdMJY1RDziyhMKfkQxH6Jg8DBjRcBCUx2Tw
         8Cgw6GJCUDvvo1ftRn98f2TCfHk5W08PyeGRzBxjWl+rHI0VrfNaqsmgvD/Wvrwk1Teo
         x9bAkvg+h9V8Q4yUTKYTMcsz6OdMk3HLAMgUVuVJe311jxMA1tMRNjjkYUhcbZy9z4Fx
         rWQMsqBPoX02/M6P12JTp7J8xBQQ9CckdynIVtIBU9u0aicLkDI185G24u1hqAT2I+7/
         Qz7Q==
X-Gm-Message-State: AOAM533rAhZ1T6ePhEzoY1X1Z0uklcgKyK1UQtGMRAYvrRZ7DRONQSoD
        8AaFkivvmNmrYm7qX9ZgSq+/8T7jXYNONBJO3MBllw==
X-Google-Smtp-Source: ABdhPJxvTeyXRf29XVfzIcWBsQSm1xV+G0Nrk4gVkArQbPPtkZ0UhYVC6qzvcGU3RA9QHaQjznKmt91H6naw3S2LIAI=
X-Received: by 2002:a5d:6584:: with SMTP id q4mr2031821wru.12.1589269780793;
 Tue, 12 May 2020 00:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
 <pull.539.v13.git.1589226388.gitgitgadget@gmail.com> <xmqq8shyq90r.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8shyq90r.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 12 May 2020 09:49:28 +0200
Message-ID: <CAFQ2z_Oz4EgP7m1vBjack7FaFRg1BvwoDVuR2SpaZwS577-HgA@mail.gmail.com>
Subject: Re: [PATCH v13 00/13] Reftable support git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 12, 2020 at 2:42 AM Junio C Hamano <gitster@pobox.com> wrote:
> As I already said earlier today [*1*], I think some parts of the
> series can be reviewed before the "dense code" part, so let's draw
> the line between patch 8 and 9 (or patch 7 and 8) and try to see if
> we can get the parts before the line reviewed adequately and merge
> them to at lesat 'next' during this cycle, which will close in 3
> weeks.

I concocted 7 (write pseudorefs) yesterday in an hour or so. It looks
like it passes tests, but I think it could do with more scrutiny. I
propose to merge 1-6, and leave 7-8 until I figure out how pseudorefs
and worktree refs really work.

>   1/13 refs.h: clarify reflog iteration order
>   2/13 t: use update-ref and show-ref to reading/writing refs
>   3/13 refs: document how ref_iterator_advance_fn should handle symrefs
>   4/13 reftable: file format documentation
>   5/13 reftable: clarify how empty tables should be written
>   6/13 reftable: define version 2 of the spec to accomodate SHA256
>   7/13 Write pseudorefs through ref backends.
>   8/13 Iterate over the "refs/" namespace in for_each_[raw]ref
>   9/13 Add .gitattributes for the reftable/ directory
>  10/13 Add reftable library
>  11/13 Reftable support for git-core
>  12/13 vcxproj: adjust for the reftable changes
>  13/13 Add some reftable testing infrastructure

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
