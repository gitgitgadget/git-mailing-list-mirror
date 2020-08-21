Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012DFC433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE39F2078B
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 14:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TsvGr7nd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgHUO5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUO5h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 10:57:37 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE0DC061573
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 07:57:36 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id q68so616691uaq.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2020 07:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wjsgbWjRfPBEWn+9rLzMV+2NjvJnq399QVW+TZeBPmc=;
        b=TsvGr7ndYce2++5oJiIosMyKih/9OW5dgFcWwQ6U3qedSr1xlq8zOpqgqhyi7dg7nr
         hJe7I6NGJBytSQX9rPGWLxDigOKQj+WbR2qlM4SwGLnMi3CqGXimwo7ovdbfG+37IL0T
         TTpX1DZkxKyoQZ57wTWG60YwxMrzJ0W6gIEwYg/D1D03KNgHgB20Lmitwlm8M2ef/eBd
         +vYEnqcNqvSshyzwp6RN0Lj+EAiqYOObJT3E4/4H15YUrzW8O7ae2XZhUCx1sdqwy35w
         neAZ2gcR0Dg42eLCIdb7tc6rxxvjV1ksD3WsOoncqodir1BINzDtOJM9qZuFmp624+nf
         MVBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wjsgbWjRfPBEWn+9rLzMV+2NjvJnq399QVW+TZeBPmc=;
        b=s7yhAFCXalNSPbUe/qk4+KiH8LI1T7BSCKYpzGzeOYJIVO9mDaeMtFquKdOp7iJeNj
         kA/I76mu6ijj9IuR5vyvvzmYm4++yI/vgHF6TdPPI23ljTd/9nsed1wpoPITb7fcbmPx
         SlPijkRYdumE7AOEwioa1BT1/ZADr9jq0ROCogcwUClSPWpM/6dbCn8Zx9+r6AxDyVDE
         AREoxlqlojoiMUnRzkuTznEPUmUGFKJF30Tj2tbO+ENXrPQw6r8T8ftyC+bxvTxbsfSe
         D+GNN/AYWNaji6++iL9v9b66NZ1EG00SK8t23p6hnuiyQXNpImReO+vYXztBlwa+MXe9
         YL1A==
X-Gm-Message-State: AOAM532Px/XHKESCudgt5WTzWhR8tfWh7/SmnyOt8Zogyjcw0NxwbClU
        TjCM5x6FhYT4EDrUSJKciVApy/XOhSQFqxIYH5EoOg==
X-Google-Smtp-Source: ABdhPJznbL2zYxSpdvGOCaY6Q2loIwl/KJXziAHmZfKv4EiwjJp+21y1n9dsmjrgH3TuI8ccU90uT6kCdFJggWbIA4o=
X-Received: by 2002:ab0:6018:: with SMTP id j24mr1820609ual.85.1598021853486;
 Fri, 21 Aug 2020 07:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.706.git.1597753075.gitgitgadget@gmail.com>
 <pull.706.v2.git.1597850128.gitgitgadget@gmail.com> <2681638651debf267bbe7e45e41decca5852808b.1597850128.git.gitgitgadget@gmail.com>
 <xmqqwo1us506.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo1us506.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Fri, 21 Aug 2020 16:57:21 +0200
Message-ID: <CAFQ2z_O52ymKhkmWQpKSq1cMoxXBf=93HDN1YPzmQ4Kt-d2JYw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] builtin/commit: suggest update-ref for pseudoref removal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 19, 2020 at 11:25 PM Junio C Hamano <gitster@pobox.com> wrote:
> The spirit is good, but the execution of this patch hurts i18n by
> consolidating messages that have been deliberately split and
> duplicated to avoid sentence lego.  Limiting the scope of the change
> to doing

Fair enough. I've just written out the complete command in the next version=
.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
