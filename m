Return-Path: <SRS0=/SyM=B5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ACFC433DF
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 13:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B30205CB
	for <git@archiver.kernel.org>; Wed, 19 Aug 2020 13:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gKtFZqR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgHSNVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbgHSNUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Aug 2020 09:20:14 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F5FC061757
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 06:20:05 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id v20so6875917ual.4
        for <git@vger.kernel.org>; Wed, 19 Aug 2020 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JTYPq621nUzgUVL1LjFidgeqDv9PRuD8MMxV1mS9GdQ=;
        b=gKtFZqR5TNhrj/0vrMtX3t859W1ZXdivA6bLdgo+drNeI9Pdg5R/AiK9qWrDwxhi4T
         C6eFkNqNtFU1zdg+I96L+F2+WzvvJp/r3HdMhzjCIAnTdSkdRjBo+fE4f3+MN18WUbBa
         GLYjXpDksTRpeYB0eKImG3yGEZ4DLqy2rI9i8uj7gRbQoT7NzhdDWO6xK7EN1OS6asIq
         qx/J/if4pvPFlZ0HcBwXQKGkef8LSVfPIjXjRHWDMbFCnrPt/ovDEhHsB+UF4ayN/vHX
         H6qk4fbn0NrQMQyzTzTi3I+A1y8nR5ap54Dby/fHCRaSMvuPhl5Q+O3PsG3D4eDqHRHV
         ZawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JTYPq621nUzgUVL1LjFidgeqDv9PRuD8MMxV1mS9GdQ=;
        b=nBTRRJE9xBSYRil83/hMu5vmAydC2e65SMTvRuHbtue8RA77oLIsw6U24QZMIxCe6p
         IqK5/zJ3ef5Wi3TWQx/lNFeFi8n1nuy0X7RpQU+MxTN2h7qhBx3/Tss60W42fE5IvXoz
         uItcSsTo2vdaQwEGftevo5PzeypyJiwNcXyaEmqYFzW2xQ6X3CSusDksq4TZyOdHSLJf
         x7ffDm47X/WnhY+m431dkezlVMYrAKE78fk4MzO5aPlxM5/lQaRQLWRW5cPRahbcymHj
         dhZwRnDXjnAGTzxnoA2ZnzQT/O30ODkkm1UMHDByTLZ7JwpfhUo33jml16sjOYH3dLgq
         0eag==
X-Gm-Message-State: AOAM533JXONpJ6IbvAKE42x4hIs6xSAlxL7LbOwmkPM0wT6lU8/rhXuY
        OZJwha78CnB0qojoUUHZePpx2d7NNb61nTNGobRI8A==
X-Google-Smtp-Source: ABdhPJy6gXHlBPdMQuctjjfCuB+sZQhbiB3tiqNjFnf8ei5q528sDQZRo7SaPaTTIjN1HeufalSffs0EqMatIOWWgXI=
X-Received: by 2002:ab0:4828:: with SMTP id b37mr13574752uad.83.1597843203077;
 Wed, 19 Aug 2020 06:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
 <pull.673.v3.git.1594925141.gitgitgadget@gmail.com> <xmqqwo33f6xb.fsf@gitster.c.googlers.com>
 <CAFQ2z_P+L5ystTA8MjSjnUJQyEoH5Q3QtnMd0ezJpKPv_ntrgA@mail.gmail.com>
 <xmqqpn8hgca7.fsf@gitster.c.googlers.com> <CAFQ2z_O1sRm-_SNP=-GvgNLqB+qgf6k9YVfbF1XCAmFWdeX6Ew@mail.gmail.com>
 <xmqqh7tjv6hb.fsf@gitster.c.googlers.com> <xmqq1rklrhle.fsf@gitster.c.googlers.com>
 <CAFQ2z_NU4=WcUDvVY9PNs+p-WU4u5=QY+=DHonGyK29numhWoQ@mail.gmail.com> <xmqqk0ydozqe.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqk0ydozqe.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 19 Aug 2020 15:19:51 +0200
Message-ID: <CAFQ2z_No3QPJju7N9EqnT+knOioJpxxi61oFf9HyRGgf-fuwpA@mail.gmail.com>
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

On Wed, Aug 5, 2020 at 5:54 PM Junio C Hamano <gitster@pobox.com> wrote:
> >> All of which means FETCH_HEAD is special and we may not want to
> >> burden the special casing of it to newer backends.
> >
> > Can you confirm that FETCH_HEAD is the only thing that can store more
> > than just a symref / SHA1 ? Based on the name, and a comment in the
> > JGit source, I thought that MERGE_HEAD might contain more than one
> > SHA1 at a time.
>
> No I cannot.  I do not think MERGE_HEAD is something I added with as
> deep a thought as I did with FETCH_HEAD.  If it mimics FETCH_HEAD,
> then perhaps it does, but I somehow doubt it.

blame.c has an append_merge_parents() which reads multiple lines from
MERGE_HEAD, and cmd_commit does so too. It's populated from
write_merge_heads(). So the special casing should be extended to
MERGE_HEAD.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
