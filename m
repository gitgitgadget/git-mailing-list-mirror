Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6EBC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238754AbhKVRKU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238230AbhKVRKU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:10:20 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783F6C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:07:13 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id n6so38051879uak.1
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WQkeCb8OV7w9+CcOws9SJQcfY05pMtsIdguHozMlNTw=;
        b=mdxF0vRVCdzzfeW+hCwGZ9ff2KKbVhzrEIFjXAgffGLcwgnQV2PlZCkHWFfRPkVvAa
         pmlC5e+TQCIj6ptzHnewfSxyRYqtcVTSwvfs8wEym3J8DV56nHHBxZdpeMlqpLGS9glR
         9N401BbvY6cIAC/RKlDLbshCIpX2xFLwEHqFVJd8weBX58kTKsJwhemQWBmkbNXsRDDB
         ToTUqK4s8ySt0hcj3OMNE00pQE55guqM6PH6cZfe3dAn5az4GHgmfRBTLKaTfSK3i7hs
         TpIzdsC8aFo7heMNDEhWlL378yt80xvmSRiAeFFKFnID49pC9h8Ug/KO3UXauktVGR4W
         82sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WQkeCb8OV7w9+CcOws9SJQcfY05pMtsIdguHozMlNTw=;
        b=JW+spmSQ9sqGMkHQgSHTLnVakJj9B7Iq1CZTGr0+SEZcdLkgSQ2Q/NKVFQUfqtcNcf
         jbLqPKwzKdKBs65XECiaj5xHs6tEyb0ngKiO0zoW7GTU0upbezlAbO8wWZBZr0ZzsyRO
         tTdqX1k8UqGJEdOlDIgXnSorlGZEjuGqqAJabmcS5mAnxLA4n4eetFI0/gC/uoCHhEBA
         w8imnFrqTXmqQ7jFLxK+9LnWTM2TmPhV4tQJAbAf6oP4QVuSVL0t6UkZ7kzpl5EwnDN6
         GGugmd4g0J//A3ULwLotSVCLJ6jZKcC7Ly9V3PyYj2lnRaZ4cv3z4ZDQRJ2MUQGkC0wg
         G5BQ==
X-Gm-Message-State: AOAM5332V8cZSqpo7SdMyT02HVo12i6Fc6ifnSuo9rphTe9iFW3ZKKhk
        hQOPadRmMdLxPoZaLHQfKiDv1td/bjhaXC109/ELcDYiDAdzyw==
X-Google-Smtp-Source: ABdhPJyt0ULnd8OfyeYoO8+KzFQ8mbsxBIZdTolDppyfmaaQqZU6m4QE0BmeZeVhOnPkYkYQDbakcUNc09Q4KxF2K6U=
X-Received: by 2002:a05:6102:5f2:: with SMTP id w18mr137004924vsf.6.1637600832448;
 Mon, 22 Nov 2021 09:07:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <4ba97a4e70aa437f9f710746fa7a8abad0732996.1637590855.git.gitgitgadget@gmail.com>
 <211122.86lf1gz05q.gmgdl@evledraar.gmail.com>
In-Reply-To: <211122.86lf1gz05q.gmgdl@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 22 Nov 2021 18:07:00 +0100
Message-ID: <CAFQ2z_MGVh6Yb5tE7V2wSSUh4tS4aEaqELTr=XUCF3Cy55hczg@mail.gmail.com>
Subject: Re: [PATCH 4/4] t1400: use test-helper ref-store to inspect reflog contents
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 4:21 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Nov 22 2021, Han-Wen Nienhuys via GitGitGadget wrote:
>
> >  Z=3D$ZERO_OID
> > +TAB=3D'        '
> >
> >  m=3Drefs/heads/main
> >  n_dir=3Drefs/heads/gu
> > @@ -318,11 +319,12 @@ test_expect_success 'symref empty directory remov=
al' '
> >  cat >expect <<EOF
> >  $Z $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000    I=
nitial Creation
> >  $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150260 +0000    S=
witch
> > -$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000
> > +$B $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150860 +0000$TAB
>
> So preceding commits added a trailing tab, or was that always the case
> with the alternate test utility?

log_ref_write_fd() only writes \t into the log message if there is a
non-empty message, and previously this was checking the log file
directly. The test helper tweaked in one of the previous commits
unconditionally prints a \t, which we now have to deal with.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
