Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269C7C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC17B206D6
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QpjGYwNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgD1UXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726307AbgD1UXQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 16:23:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36226C03C1AB
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 13:23:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i10so26232406wrv.10
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9h4QQhTUHyGFlcbHkimu6EI+kI64Gk+XhNFUvwnRfDw=;
        b=QpjGYwNOC6xmEckyk8+RGe3gmAvVIObKUCbxKBRYpwXJq2pvc52t1f3XlFxNHBDYfP
         9yRCnXI0SiYENqWo/laX4XkxjezRSTLfsYvImISxY36ooujSouYbu+ZxYrwrcyEVUO9i
         cVKDEVkYMcvzUOSOg5GLmd7beq0fWJWK99J1lANQ0nwVNjCwoIjSj/elGxVwOgxJWpIp
         dXFXK28iQ8FMg95NiWszxhnPWOA5cLee1ieALLGUDLyYxxE7/wvPIn9AVt02Biv9WLTE
         mFJbGZjGGFvMf+Fx9DOlW1b61ZsycjsC7oCRUSJqzBjWRec/qj571OPZDyR0sD4+/Vxs
         ql1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9h4QQhTUHyGFlcbHkimu6EI+kI64Gk+XhNFUvwnRfDw=;
        b=t8piUePWpTedv1QP5lKdgfenX88QKp/fChbUoWWOkvGgF85vztRQw8LK2Ab0OUaWxN
         BVvZ2T50H5D48TxNHxpdDx9AZAyWfSS3jtfRFGOsw+qYWQ//VRxCCE/awc3dSQA2RMEp
         LX1hpq3j5XzKRgCzYqjYB6GhAhJ4ksCEx7hivvDseaWXQl5y1038NNJYodZNfDTAbTEr
         Blfg7J5NWKBhNSO5RxaIMKOOvmdnsVoZ80cB+dVDVb5ufGH9GIIlHWSTt/YP/8jqwIsk
         02+2itgoBbsQGWD5gkgiWR3atpOYWOayWolRInnrDP4gP4m5lwxB/SPUzAvw4ZfHp8Z/
         iqOQ==
X-Gm-Message-State: AGi0Pua1isKS/1BYmzSF0LJNHc0V3b7pzyt7ZtG06kvXWGosFCiv5Ru8
        iOlUXTy4BzRbIUDfMOdU3Iw1dBBco0GwHhyHUrvXbcvQta0=
X-Google-Smtp-Source: APiQypLBENm5WhyPCTbeTP/HYwKvIx69fqgjwfWk8A2U+zccDi1j1Avbld6t/Vi2rtlFctzGxnT2xoTXXWTRsrCRNGc=
X-Received: by 2002:a5d:4ed1:: with SMTP id s17mr34146716wrv.310.1588105393679;
 Tue, 28 Apr 2020 13:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
 <pull.539.v10.git.1588018418.gitgitgadget@gmail.com> <59209a5ad39326cf88966715312922f08f149942.1588018418.git.gitgitgadget@gmail.com>
 <20200428145541.GC31366@danh.dev> <CAFQ2z_NtsmyqqGPRr7YWfTWGRAjrgBv5NtV2k6oMfoSbwuAOEA@mail.gmail.com>
In-Reply-To: <CAFQ2z_NtsmyqqGPRr7YWfTWGRAjrgBv5NtV2k6oMfoSbwuAOEA@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 28 Apr 2020 22:23:01 +0200
Message-ID: <CAFQ2z_PpmJd7C=E0k=scp=fuE32KFjfCVgs1dg5uA-yuEvGADg@mail.gmail.com>
Subject: Re: [PATCH v10 09/12] Add reftable library
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 10:21 PM Han-Wen Nienhuys <hanwen@google.com> wrote=
:
> I've added a doc comment.

I've pushed these fixes to
https://github.com/gitgitgadget/git/pull/539. Should I be sending new
patches over email for each review round?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
