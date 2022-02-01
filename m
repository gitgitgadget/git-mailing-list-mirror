Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65327C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 20:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiBAUGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbiBAUGV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 15:06:21 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E301C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 12:06:21 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id b16so15235011uaq.4
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 12:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lnvANn3CZAJ7mr1DlyQ0YVzAdpifqDYXbgeSUKkMmNw=;
        b=RmSwPVR6LG567SpDGkoD7vDGegAGsq0ezS0T0gjRHr2GLRSnGXmq50xbCMuyqshh7w
         Vrbyg9uF9qR4ucCfBvPQpVLpH8LIdmPt6GpbXlQAzh1Pr/1cSWgVtPg2tLdRtAvtAPfS
         ltYS4K4SWNZ18Y+YZDE6irbu2pu0BkQG2jjilg+ovKjtbLJTQRIQ0lXJA46CoNBROXZO
         P33ygk/BOPC7NPFlckn8L+fHYhT+5t/gokyZ8U6qVSMnZ/RcmNL+E6tYqCb3weNMK+At
         u7dhVNrSatD+UIxpMnueG69CAP8sQe9ZXgXYeH20Ba/ZHk0xHPGLnwMRLhA1kcAemw3C
         TrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lnvANn3CZAJ7mr1DlyQ0YVzAdpifqDYXbgeSUKkMmNw=;
        b=12L5/JCNXhxSrkm19J9JfoJi2VJF/xk7RJyHKvygThOz29imRdF11oXJM9jgAEArdn
         ownL9bJ7Q9Tdb0Em4mAaVkIinYq+tsOPOCx6pt6tcYk3P4xCXpHtjdBYjWiLzy+bydeD
         gQ5lhCuWlUpTcoSAVtXr/3eWydlpUv/0h5QqgRf1HICGR1sFJuG5qhUeETCtQ3hXIS75
         VkSeqbI+oDMVbYzJDmo7HFsw14q/c5BMJ+VJbmvm2fFQoRKxJtWQNnF1Dk3nk/C+bGpa
         5YM7TqcYn6mtd5wZXkcdRQAPMeYPb0yyz7c2+zUWw3cVbhg5GzvzJvN/DXvtyCgjHVFO
         azYw==
X-Gm-Message-State: AOAM530qb1yafjmN/5JSehz/NOVNudDtm0LpMkOIWGsM+n5FJGgJs5ym
        3Hnm+j+Lvqm1bbHTuiNMVrun+Tioo3g/XSEitRAyjQ==
X-Google-Smtp-Source: ABdhPJxoPI7HS5RmxFZcBoxlUykTt07z6OXvwXeQjgxYkAugxMnwt2wK3Z0wyeDDiGOPTUfLRtjLJrCp3F53m57hyVU=
X-Received: by 2002:ab0:71c7:: with SMTP id n7mr10411072uao.15.1643745979998;
 Tue, 01 Feb 2022 12:06:19 -0800 (PST)
MIME-Version: 1.0
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
 <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
 <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
In-Reply-To: <xmqqzgnbh7rv.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 1 Feb 2022 21:06:08 +0100
Message-ID: <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 11:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Mon, Jan 31, 2022 at 05:50:19PM +0000, Han-Wen Nienhuys via GitGitGa=
dget wrote:
> >> From: Han-Wen Nienhuys <hanwen@google.com>
> >>
> >> The reftable backend doesn't support mere existence of reflogs.
> >
> > Perhaps I'm missing something obvious, but this and the previous patch
> > seem to be conflicting each other.
> >
> > My understanding of the previous change is that you wanted a reflog
> > entry when the REFFILES prerequisite isn't met. But this patch says wha=
t
> > matches my understanding is that reftable and reflogs do not play
> > together.
> >
> > If reflogs do not interact with the reftable backend, then what does
> > this patch do?
>
> One difference between the files and the reftable backend is that
> with the files backend, you can say "I am not adding any entry yet,
> but remember that reflog is enabled for this ref, while all other
> refs reflog is not enabled", and the way to do so is to touch the
> "$GIT_DIR/logs/refs/heads/frotz" file---this enables reflog for the
> "frotz" branch, even if core.logAllRefUpdates is not set.
>
> Because there is no generic reflog API that says "enable log for
> this ref", a test that checks this feature with files backend would
> do "touch .git/refs/heads/frotz".

There is refs_create_reflog(), so the generic reflog API exists. The
problem is that there is no sensible way to implement it in reftable.

One option is (reflog exists =3D=3D there exists at least one reflog entry
for the ref). This messes up the test from this patch, because it
creates a reflog, but because it doesn't populate the reflog, so we
return false for git-reflog-exists.

It also turns out to mess up the tests in t3420, as follows:

++ git stash show -p
error: refs/stash@{0} is not a valid reference

I get

  reflog_exists: refs/stash: 0

and "git stash show -p" aborts with "error: refs/stash@{0} is not a
valid reference".

So I now went with the other option, ie. (reflog exists =3D=3D true), ie.
every conceivable ref has a reflog (but most are empty). This makes
t3420 pass.

This behavior also confuses t1405, because in

  $RUN delete-reflog HEAD &&
  test_must_fail git reflog exists HEAD

the last command now always returns true.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
