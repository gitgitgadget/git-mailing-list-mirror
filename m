Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0D1C433E1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2673206A1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d6Pm+0GT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgF2S5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbgF2S52 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:28 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A089AC031C40
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:28 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id z47so5675664uad.5
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=giu4eHA2PeZR+CAGfrVjtHZY1+ySz2xByZrgLfUXOHc=;
        b=d6Pm+0GTi26g4xi7mxl919SHSpIIRa9TwDSzwMDxiesxHQDus1Jawml742W0pfdrCI
         gjtokERasweS5ICAIl33M+3cg12VMr2YI2uWIEwgJGbhi+Qc2nK4pSFTkR44gw0M6ULd
         B1jMizfvNajv/h0SPQlyjrr7XAvgns3u1jWp+8+Sf+Un1bGOQYl5ELLgaHJH+wMLGCrF
         0zUWWSgGq7wIPIRTdvq7AXZ0VzKfzjyvlHIHL/SQVTLDwx0uxncAegS9O1JHP+BFdTxs
         1quJEImJnJK0hI/R5s/oqBw6tIkj1iIZG2S1CcHxQEh6DskVHSDDkG0jXiZ90cNPgvnh
         KzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=giu4eHA2PeZR+CAGfrVjtHZY1+ySz2xByZrgLfUXOHc=;
        b=G/7IsyKC8Cz2KgLo/HMDW6qGi14eQfBlds9ovXlPegKI9Eit4+uWf/QTZtMSCMv3VZ
         VfYWU5P5hvBj2YO8/96pbp7PWbeppGhmlZic7Qg4U9WirHsXq/I9gLQLyYCyhnNy/FnZ
         6IUArJg6IKGYFQZUwnYBWWqKeFuJ4AHCLoNdydFd1djFA8dUTK4naJHs7sAR9CzME/jJ
         46Ka5mEoKCsW22M0FVdn2botg65Gqf0kXgr7VpwT3g9XgUAW0Ba237ADbzHxfqrxQ/cy
         bOKLSukB33uNTTiymBu07n9txZQPG6XM/VP1Jro0l5SuKuvoc7VXKdDvIbAuTOKWkBT8
         QkWg==
X-Gm-Message-State: AOAM533UDh5hZJ2WNs6tsoow6S0d1iKycM/237DeLmu58YMoNBOUDv1x
        QJeQfaAi3waWUcxzic3VNtelgDN5lG62bDit7+V/1FTodcI=
X-Google-Smtp-Source: ABdhPJyXlE38jxJj4onOXzX3j0gS92LiaQjmGI/WJcp8Qkq3eRC3UBYnTtyT+S5Ah7Hp+QgiQNt9pL2j3GYgS3NqihM=
X-Received: by 2002:ab0:4821:: with SMTP id b30mr11459136uad.83.1593457047274;
 Mon, 29 Jun 2020 11:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ2z_NZbg4YoTo1vPaikfwYLMRZrx59bDMaeuczuJW2OG86DQ@mail.gmail.com>
In-Reply-To: <CAFQ2z_NZbg4YoTo1vPaikfwYLMRZrx59bDMaeuczuJW2OG86DQ@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 29 Jun 2020 20:57:15 +0200
Message-ID: <CAFQ2z_Ohp29=Txu9ikn1i_GJQ8eYV9HNrKqSpAOMNamL92YZYQ@mail.gmail.com>
Subject: Re: Reftable progress
To:     git <git@vger.kernel.org>, Junio C Hamano <jch@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 12:03 AM Han-Wen Nienhuys <hanwen@google.com> wrote=
:
> The bottom 2 commits should be OK to merge as is into next.
> ("checkout: add '\n' to reflog message", "lib-t6000.sh: write tag
> using git-update-ref")

The patch t3432: use git-reflog to inspect the reflog for HEAD can
also be merged as is.

> The major open question is how to handle per-worktree refs.  My idea
> is that, on creation, the reftable backend can figure out if it is
> running in a worktree or in the main repository. If it is running in
> worktree X, we could read/write pseudorefs as ~X/PSEUDO_REF.

I figured out a better way to do this. See the series that I am  posting to=
day.

Test failures are down to 556.

> Could we discuss next steps for merging at least the library? I think
> that would solve one of the major complaints, which is that history is
> kept in a separate repository.

anyone? Junio, Jonathan?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
