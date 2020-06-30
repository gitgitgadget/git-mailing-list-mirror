Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AB7C433E1
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 09:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B119204EC
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 09:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzvIMe1Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbgF3J2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbgF3J2e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 05:28:34 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365AC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 02:28:34 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id v1so10807891vsb.10
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 02:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EvaLV6IFdDtiOGM7iSUYm9w2DH82oX3R645ZRsw7LL8=;
        b=GzvIMe1ZI4C5iceMGIYMWki9yFnGuG/1exoFrl16Oap4jmE2KD5WIhK+R0PCeUfyYc
         3dj4vmUW6vdUqplf/itONJd1o0p+7EquI5vAH12C0YByheKbZZMK51TVpKixJ3j9lv+r
         zDEUTfliLBRHJDzcGO3WOgUc5ltG80gQAlgclgQh0bH8DQdFOjhXHL7cnN8ot56RvsoD
         4TkNLZ+JkgyePR71inWl+noBrJPUdCI3Pa+9PrD/6Yltos7FC7zXDxk4yvjFs+EPx+JA
         MsbVhAifIeugsuodXy3HhtKPFpTyV9ka5B2UtGrkNTeyQga5yn2P1MIoZ82b/Suc/+43
         VWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EvaLV6IFdDtiOGM7iSUYm9w2DH82oX3R645ZRsw7LL8=;
        b=YKXfpsH8pNuyoUKelm7YwLz47ECZL6/2nX1EWS9wcuxNR5z/dwQD2qKXOCQHXXclxL
         slSn6CvgwcFvGhYY0KYag1BY84MllBSfST4liO5fV9iSD8xYaligzuUAlE+jiy0ER/Pf
         25Tc5VOPMoSKBX8aDTXaiaDwyX+ZwI2scZwHAxpuhKGAy1ZkOjMm6nSLEoDdCLVkl1AS
         H4Mjn5pYHzYOHWcnovhqufqoe2kLJUcgMpiPGUctpjTQgICYf0f40O9fBWNWRPhTGWuK
         vTYltWUAfbG4ZMDIRAfB6uzIoCmAhikvDk76PjiMfD+b14sABzPbuFDz077Ic4FuGasW
         akNg==
X-Gm-Message-State: AOAM530b+C8xdycUU94rNawyZUu3J/wAe30iqV0E7uNztKHYaVxxZ3lP
        wNKWIPPwLLyWp/PZItJ/dr5gZ0E1r7b0aX5zOlcsiQ==
X-Google-Smtp-Source: ABdhPJz92L2JsFdtSB9Ajt+W3C2VvdGVydGZxOhtJYqq8H5cN0fU1OsrGxyMeFwqJOtoLvCF5PE3bOALbHEud7Wh9Q4=
X-Received: by 2002:a67:701:: with SMTP id 1mr8824847vsh.134.1593509312508;
 Tue, 30 Jun 2020 02:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
 <pull.539.v19.git.1593457018.gitgitgadget@gmail.com> <xmqqimf9fppn.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqimf9fppn.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 30 Jun 2020 11:28:21 +0200
Message-ID: <CAFQ2z_MbiTEzztU9a8beMAQFn1-ozBUwKD1JyhXHUnoTTto0TA@mail.gmail.com>
Subject: Re: [PATCH v19 00/20] Reftable support git-core
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 12:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > base-commit: b9a2d1a0207fb9ded3fa524f54db3bc322a12cc4
>
> This is based on 'next', which usually is a sure way for a topic to
> stay forever out of 'next', but we have impactful dependence only on
> two topics, I think, and a good news is that both of them are in
> pretty good shape.  I think Brian's part 2 of SHA-256 work should be
> on the 'master' branch soon, and Dscho's "customizable default
> branch" is also ready---it just would, like all other topics, want
> to spend at least one week on 'next' to be safe.  And after that,
> this topic can be directly on 'master' (there is another trivial
> conflict around bisect--helper, but I am not worried about it),
> which looks quite good.

ok. For the next time, I should keep basing myself on master, even if
I know there are conflicts?

Do you have an opinion on
https://public-inbox.org/git/pull.665.git.1592580071.gitgitgadget@gmail.com=
/
?

There is some overlap with in sequencer.c, and Phillip's approach is
likely more principled, so I'd like to base reftable on that.

> fixup! Reftable support for git-core

thanks, folded in!

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
