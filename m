Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C53C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B57C207D8
	for <git@archiver.kernel.org>; Wed, 20 May 2020 17:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tw4a+st7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgETRZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 13:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgETRZc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 13:25:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DE3C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:25:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j5so4014023wrq.2
        for <git@vger.kernel.org>; Wed, 20 May 2020 10:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YYwrU8lJ4+mVYesm7Orz6+sKjW58w4ZA8sBE3VoyrKo=;
        b=Tw4a+st7hPaxmTTlZClfT6GCKXKl4m8qJY9wbYorbPpnPzIiw/Z7HDNJFPs4RLFL2G
         VEEXZuSVAcsvYb+qMh0NHOJPIy3AzNaQdn1lJaLg6TOheg4zI1kxSm5DG1+6wGQGWU6R
         8Qqm4tw/ATPBRZ6D5tnc3abI7ANw9AI4/9oZVS1D063XRzsWQiXVmk54gvICwP5IsTl4
         Qe22/zv4Pm93THtWzBQDxrnm6GUrf7Aij0OxxTa83wRgR+BPP7e84sxLSHCSMBI2m7ZE
         r3zV+Uz/krS/4F1jENvEmND4VhqzzNfGpLmNeJF9WcBBtpacvaFjF1UDvo2tccqvPjBc
         gqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YYwrU8lJ4+mVYesm7Orz6+sKjW58w4ZA8sBE3VoyrKo=;
        b=Aqc6nTIdhMSTfCZab8qedLoWrZZfC8BWiGrcTY8eK17opX34phTojbtIc+COSBYQ8L
         YfQ7tnNWx4fJvhD0iLc4Lr7rayjbO45vdjQ5BmjYDblenUUUAK4M0NFYHCp5oXznWKfn
         pUMLkJUSMlx9spGNXezFrGZ57B+fIgj9TYwrXj0yVNG23bcFfjYGxRFdIzhD7CzjHSyn
         s+I/lJBt/swmUEIXkBooywUWeAgr3EVR36zuejzn4UunPobNcFa3145jSjBCTPbEkmhF
         6ItDCEr0CEX/BinnOTGHuBUhDPTuowTx7aOCyy8QNHaN70Ci+udrVy3J4PF4chEe21bO
         x6ow==
X-Gm-Message-State: AOAM531j/6D1sPX/1pOD0Vud34vQXE5gaWQ7UvGPf7+2pSifOv17Bn+/
        Vhw8zDqn4vmlNBQapWgHcQmCvH+wG2dlBeE/sIlgWw==
X-Google-Smtp-Source: ABdhPJzUO+/e0DOzlIZo6jFnET7GsZQ/L0fBGv8nPlnA9/St3q9sCF/WrH6T8skaKiygeR5B50ZO59PGXMGCaUuHcCg=
X-Received: by 2002:adf:df0e:: with SMTP id y14mr5014796wrl.6.1589995530474;
 Wed, 20 May 2020 10:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
 <pull.539.v13.git.1589226388.gitgitgadget@gmail.com> <96fd9814a6753e87fb99c6f9d55a0728d3dba6cb.1589226388.git.gitgitgadget@gmail.com>
 <xmqqeerfzitt.fsf@gitster.c.googlers.com> <CAFQ2z_OazuU32Nm3geLCbu_R2u_JKTqCXX0NF35C0=9xV7Ow0g@mail.gmail.com>
 <CAFQ2z_P-cf38yR-VyvfDSgPUO_d38mgsi32UkRSPWMZKJOmjZg@mail.gmail.com>
In-Reply-To: <CAFQ2z_P-cf38yR-VyvfDSgPUO_d38mgsi32UkRSPWMZKJOmjZg@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Wed, 20 May 2020 19:25:18 +0200
Message-ID: <CAFQ2z_NWT+Xp0zGc0OfjDd-=js5v9M9nqb3fbDFAtx_r21Jp=w@mail.gmail.com>
Subject: Re: [PATCH v13 04/13] reftable: file format documentation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 20, 2020 at 7:20 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
> Jonathan Nieder said that this is used for git-stash, but I have never
> understood why this is necessary, and would love to clarify this
> better.

The doc says this:

"The `log_type =3D 0x0` is mostly useful for `git stash drop`, removing an
entry from the reflog of `refs/stash` in a transaction file (below),
without needing to rewrite larger files. Readers reading a stack of
reflogs must treat this as a deletion."

I should probably look at the code for git-stash to see how this plays out.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
