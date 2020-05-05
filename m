Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88777C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C868206CC
	for <git@archiver.kernel.org>; Tue,  5 May 2020 18:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFH0w0+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgEES0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 14:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgEES0p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 14:26:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82714C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 11:26:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so3368209wmc.0
        for <git@vger.kernel.org>; Tue, 05 May 2020 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R69tN8MZvzote9rdEEp9HkDqNxtltP7k2LMXUV9DSXw=;
        b=CFH0w0+LphqJmpk2NbqSc2xSOcVplm1EoApwN662Joo7HJspPL4aJxTkz+O2VY4gpc
         P+nmhelbydvDMPlxevxQiGJh4P7vddXTJ213JPLhM1hcqXisghTH254/OQcJ/RHn0Wnc
         rFjSkTP3AIq3ZvS8Lz4s3k+CR+T3PBoL0hvixwWjiSQnGrZagPXB3OSWtVG2uTCx0Kl+
         LDWK3mZvI/eDWWmHX+1X1V4MJohrv6M1C0l2Dk4hO1mek1jPL9iiJdcf69E2n8tPC1ud
         j9FilFVa9B4TB13hRccNOEQ8yNj3V5/J22XhwlRClmWhUtQfoL8M2LrST4hJ11/e4qqu
         sxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R69tN8MZvzote9rdEEp9HkDqNxtltP7k2LMXUV9DSXw=;
        b=aFskh/hofDnS9OS3UdHkT/QqOSTod8tEL4lQTDynFb/+qWxxe+iRbqDMGObWVgMMUZ
         kXxS78ZluLhzdU43IUUq1Wz74dRVTjZF0HxHfo+ir9XC62azFp+drokdGOP8jaJeIEC/
         xwcBQGKKPrOSpcVWf77swlWNyT91DH8qg4ADAow+epZhReBx5fKjHwoVnAQ9FPAo//M6
         2eB9ElkZ41r3gfg7R4vPjA0hOz8ulCj9FmxREGR6GEwb2jepc3mqlCKzCQerX++kzlOs
         yI71cvGo3MZXxlP20s4M3myCfOMEga11mpDMto+liSZNZ5x1xedzTOmKm28ZW+JK0fOc
         Uktw==
X-Gm-Message-State: AGi0PuZi4MXPzfmc2/mSzHXFuBbpLF++yLP/qj1N2ffgQTnrCQvR22gw
        fqDpQR9jxzzUYftOqbn5cYqH1qbkhq4vY8eY4w3JsavDQ0E=
X-Google-Smtp-Source: APiQypIdwb0U+JXaE7zw8T66wWZj2PYgoE9giKaQLTnfItzSGS381l8GJ65te0cA+8iA4paJrAo1iRjIRbydxocz2v8=
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr9867wmh.157.1588703203769;
 Tue, 05 May 2020 11:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
 <pull.539.v10.git.1588018418.gitgitgadget@gmail.com> <45fd65f72e097dcabba6ea15b1d54c85e7271593.1588018418.git.gitgitgadget@gmail.com>
 <20200430211714.GE77802@google.com> <CAFQ2z_M_hG8zD9R41DLqB3X_Me42F_Ron_87eqCnaGd8K17POQ@mail.gmail.com>
In-Reply-To: <CAFQ2z_M_hG8zD9R41DLqB3X_Me42F_Ron_87eqCnaGd8K17POQ@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 5 May 2020 20:26:32 +0200
Message-ID: <CAFQ2z_NZgkPE+3oazfb_m0_7TWxHjje1yYCc0bMZG05_KUKEow@mail.gmail.com>
Subject: Pseudo ref handling (was Re: [PATCH v10 02/12] Iterate over the
 "refs/" namespace in for_each_[raw]ref)
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 4, 2020 at 8:03 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
> >
> > All this to say - it's hard to convince myself this is a safe change,
> > and I'd really like to read more to understand why you made it.
>
> I'll be the first to admit that I'm on shaky ground here. However,
> given that the test suite passes, if this is breaking some behavior,
> it's probably not very well tested behavior.
>
> Here is what I know:
>
> Git stores refs in multiple places:
> - normal refs, packed: .git/packed-refs
> - normal refs, loose: under refs/*/
> - special refs: HEAD, ORIG_HEAD, REBASE_HEAD.
>
> Currently, the special refs can only be read with refs_read_raw_ref().
> If you iterate over the refs in the files/packed backend, you can
> never find HEAD, ORIG_HEAD etc.

A large source of test failures of the reftable patch series is the
handling of pseudo refs (HEAD, CHERRY_PICK_HEAD etc.)

These are written as

  if (ref_type(refname) =3D=3D REF_TYPE_PSEUDOREF) {
    assert(refs =3D=3D get_main_ref_store(the_repository));
    ret =3D write_pseudoref(refname, new_oid, old_oid, &err);
  } else {
    t =3D ref_store_transaction_begin(refs, &err);
    ..

write_pseudoref writes a file directly to the .git/ directory.

However, on read (for example, CHERRY_PICK_HEAD), the pseudo ref is
given to lookup_commit_reference_by_name, which in the end calls
refs_resolve_ref_unsafe(). If reftable is active, the pseudo ref isn't
read from .git/CHERRY_PICK_HEAD.

If the pseudo refs are read through a ref backend, shouldn't they be
written through a ref backend too?

This causes all rebase and all cherry-pick tests to fail with reftable.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
