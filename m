Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEA4C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3262469C
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 16:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uo4r3Yx8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgB0QB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:01:27 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55952 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbgB0QB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 11:01:26 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so4198322wmj.5
        for <git@vger.kernel.org>; Thu, 27 Feb 2020 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZqwXcPkWPJaINfpTLNCsjxgPjlJSpmYO3aQHPCTfcPA=;
        b=Uo4r3Yx8vHSrIeDPv/r2Cw7u9Eity7OOyxCN52bB/LInDsaYlS5eWY/ogKMouupl4Q
         l6TAPmlFoTXYHNJdKFMfKazOrkvZ2oRcN5yd2K6CfO+ex9ov4CQggUQEy7R8EN2at8I+
         b11eA1qSqtlI8Qard8Uab3lv5i0c/4YWY3qKs//C2LyXFYLKIdmcdkpKr+l/8FSl5+0M
         gXl7DRGvt9/I7cn0Y9UO81k1Ze0l8zKhEzN1enLCsZyEjUnmdSkbHEc8UFE1reDPn0EP
         uL6JainTyI923SRy/ddN2g7SAGI7+wqCAcbhPmu3g3j2aphp0yyeF+q2zf+0Q5rBGBAm
         gdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZqwXcPkWPJaINfpTLNCsjxgPjlJSpmYO3aQHPCTfcPA=;
        b=XOLa766qJrDUFOxoAHnlOcEPR7e/BY8wNmzZEZZ0RbAxBqCE74EUqpljz5IuNhA34z
         ShxmoPiEZ/YGVTa1l6fv2Yn9yxAfcsEFlAAiLWFDS1U99xTV/K3hXXEhw5zXSCZp7/lt
         AKtFmxpn9zfwlbAQx3EALfPGD/t8Abj7U6c+Y/bzRtvUBnNnoSXW8fp9d5etdQ6narNn
         wnPiSxQU8d6snP8Mz+Guem1DfkQ2THtWeK9xPLvXtY+iq7XoiadRGya1yEi6vymT1JqY
         /VKeymG7p+w/3z9wOiSPKiIQU3AMU0Qde1fB8ICJfhMCB7nlzMmYlUBMzgv3X5trcoXW
         WV8w==
X-Gm-Message-State: APjAAAW9IT5M1fVdOJMUH9abHr3F8MfScjNcGqg8I/aRNFv5QFRfH8L6
        Kg+oE3lyas5VEjph6gTJ7/UGWoFj72ftSxJ2TXlb3RWe
X-Google-Smtp-Source: APXvYqzuL3fYaU2HPmjluAaFAn290VO5bQX/TgPWtl/x8Qv1hOXHE4tt6CDKPcGDzuOk2ZI+Xa/x8Hdp3VyGhz8J8R8=
X-Received: by 2002:a05:600c:145:: with SMTP id w5mr151437wmm.157.1582819283245;
 Thu, 27 Feb 2020 08:01:23 -0800 (PST)
MIME-Version: 1.0
References: <pull.539.v6.git.1582015420.gitgitgadget@gmail.com>
 <pull.539.v7.git.1582706986.gitgitgadget@gmail.com> <a622d8066c7fe27accc5101c3341c30bf706dae1.1582706986.git.gitgitgadget@gmail.com>
 <xmqqwo89ghmt.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwo89ghmt.fsf@gitster-ct.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 27 Feb 2020 17:01:11 +0100
Message-ID: <CAFQ2z_NR1HtEphYC1A+J8oU+YAyoa2P69k9enQ8w4Q5pa=NtEA@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] Reftable support for git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 26, 2020 at 10:31 PM Junio C Hamano <gitster@pobox.com> wrote:
> This change, and Brian's SHA-256 work, obviously will introduce a
> conflict as the other side wants to add an extra parameter to choose
> from different hash algorhtims.
>
> I wonder if we should rather add a single pointer to a struct that
> can hold various initialization options as an extra parameter.  That
> way, each topic can add and manage its own new member in the struct.
>
> >  static int create_default_files(const char *template_path,
> > -                             const char *original_git_dir)
> > +                             const char *original_git_dir,
> > +                             const char *ref_storage_format, int flags=
)
>
> Pretty much the same story here, too.  The other side aims to be
> more generic and passes a "struct repository_format *" as an extra
> parameter.

Sounds great to me. Could we submit a patch that changes this into
master already so Brian and can work on the same basis?

> I am not sure how quickly Brian's SHA-256 work solidifies enough to
> build on top of, but if it is a good option to build on top of the
> topic, that may save some work from this topic, too, as the
> mechanism to choose something (i.e. hash algorithm for Brian's
> topic, ref backend for this topic) fundamental to the repository at
> runtime and at initialization time needs similar supporting
> infrastructure, such as changes in "[12/24] setup: allow
> check_repository_format to read repository format", and "[13/24]
> builtin/init-db: allow specifying hash algorithm on command line"
> of that series.

Can I pull this series as a git branch somewhere?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
