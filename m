Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE229C433E3
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 15:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B9C206E7
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 15:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gCtKSibQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbgG0Pl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbgG0Pl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 11:41:28 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C026C061794
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 08:41:28 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id o184so8557399vsc.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 08:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OL6upaWVjFKoq5hi6i7HJQQ81LXkFAE0x0LfJSdLM4E=;
        b=gCtKSibQDSoZ0qBfkwcxZINe5TWsP5On/DP2ibiyPUsm6AbmGiApzAUlVXEA7JMVVP
         DZnbxcmCXDVsLEb9bv9ZUW/rL9Gk89LTifZPb+Y2rRoymjHGPkXQI+nQc/aXAx3V2kAF
         MsvpoWMRSQWH0QdPMpIdsU0L/zoQFGqg0DR3kPEvLanScBLfpB8K7x2EJWA5YUvCtKfp
         F/7ttFZKS1suFmTB4WJ667jWzJThEJogjJ0ORtPA3n8Chrd6/E5YOsLjKRQzDUXQqMRj
         VHhTWWDFc3yiU2AmGJLnEDtW4YpzMUHWisJLXnc1vbX72jCYfgoQRsnTK3Kr3f4rO/zE
         zPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OL6upaWVjFKoq5hi6i7HJQQ81LXkFAE0x0LfJSdLM4E=;
        b=iLEDzwcncWlc3k2rk0OprZ3hL3BeW4iay2vF6NIwOamrwjFMiV4yPktU8hiQiDFkuw
         E36PSvfZglKpk/HrS67TERLkIiRuzU3qgODO/9r/INJJFA5rMGmGO+hCv9s5xsZTOriJ
         P/vUkMLB+3JfZMLILiOoOTy/ttsTe85/WwpfoLgikXVNyXY/BbJ+ACj4A4KjDzDt2kia
         F2P0saV3LKUpe/p5jLTuniyL/psCehaVlojluSHaVhDHm56hQ1ermSiyvR2Y9PzwqvLd
         ytdVXR6gRLKhMwd+vlXFFqb+8E/OBFxIFNHwrZ1LDAfFMPLVCM2KjgbNUoyxaC9JvtJS
         /y8A==
X-Gm-Message-State: AOAM533t6C30OuSx1NxJK5uCAIu0wbOxvvWSUIXkavceheslUsnRm0YA
        zOJ/FLGgczavwu/T+gBG0l5AZN/mqupyz+7N7JA4oA==
X-Google-Smtp-Source: ABdhPJyQg1bItGHrT/oG2wSh+qA1Kk5n6L+rEeEyNPcAX0E41kyrlc0gPWDgZsybGjI8qTirmKBj3BE3EUkDw1jbrM0=
X-Received: by 2002:a67:2f8d:: with SMTP id v135mr3783249vsv.134.1595864485901;
 Mon, 27 Jul 2020 08:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.673.v2.git.1594329108.gitgitgadget@gmail.com>
 <pull.673.v3.git.1594925141.gitgitgadget@gmail.com> <79cd5dd480a4218d4563120c03046375594cc23e.1594925141.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2007171042461.54@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2007171042461.54@tvgsbejvaqbjf.bet>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 27 Jul 2020 17:41:14 +0200
Message-ID: <CAFQ2z_M-OcJA_a3QZ2QfzREM2JHN6G89HKPuccUUSwKWbp_Fdw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] Modify pseudo refs through ref backend storage
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 17, 2020 at 12:18 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> The reason is that there exists a `refs/heads/foo` _and_ the symref `FOO`
> (which points to `refs/heads/master`, which is at 1e995a).
>
> An earlier symptom of this bug is visible on Linux, too, though: when
> you run t1405.4 'delete_refs(FOO, refs/tags/new-tag)', it shows this:
>
>         + git rev-parse FOO --
>         warning: ignoring dangling symref FOO
>         fatal: bad revision 'FOO'

Thanks, this was very helpful for debugging.

The reason is that we do split_symref_update(), where a transaction
that modifies SYMREF (pointing to REFERENT) without REF_NO_DEREF is
changed to a transaction that modifies REFERENT and a reflog-only
update for SYMREF. In this case, that leaves the FOO symref in place.

This seems very specific to the test (is there any use of symrefs
beyond HEAD?) , and I fixed it by passing REF_NO_DEREF to the
delete-refs call.

It would also be nice if this behavior was lifted out of the files
backend and into the generic layer, but it's not yet clear to me if
this is possible.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
