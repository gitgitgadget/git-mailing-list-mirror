Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD7C54E8D
	for <git@archiver.kernel.org>; Mon, 11 May 2020 15:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B5120736
	for <git@archiver.kernel.org>; Mon, 11 May 2020 15:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJOadyd9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgEKPLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 11:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729439AbgEKPLo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 11:11:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF979C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 08:11:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y3so11446525wrt.1
        for <git@vger.kernel.org>; Mon, 11 May 2020 08:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yRlKG1nSz25zVPdH3AtLIvV/Ic1+i/BcOqnzUAM4Npg=;
        b=rJOadyd9ITBycfhXwNIhwekQ8GR7CHjAV/OtF8UsNdsl3wjX7d5OlubkYcGZakiUHG
         Ttcffmg5vQsmTVJmdP5VbbwcBuHPxp0l2TDztTaaP23KkpJLGGUQ9yUn+CtamFW0Ru+3
         vKuldeYCNKzqX78b+IhscVRsCahaYeR21DwdyoeCjDWFf8O4yqDjgVFw7eeEvii5wwcn
         3apHTo+xhmYGBJjo3tMYeJn5KObq2it3zkV8dkFzenilK83ba3D9ergHnz3GUZlqdNx0
         oViXXzEa2xd3g/PpGAFOQ+Y1DKcw2232YqEz2CFdXlo5XXqLCxilES3AtIOOAKgUCsXw
         g6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yRlKG1nSz25zVPdH3AtLIvV/Ic1+i/BcOqnzUAM4Npg=;
        b=Qp19ZjP4X+lgxWeYtlQ7A2/1DCv3gNv/7kUSN+WIPvTVVkTdXtOgKtBwcTS2xQ1GrO
         OuFzFJtF1sc+y9ZrKeCEsOm/wbT2cwq95eCNc0lNCDGTae+LqFOOtnwaUpJb+ItWDSuF
         /imu/omdLc4ENop1aU5H9x1VKVQTPeYUnUtjRbO+CTh1OQO1LEbrczHndEQK7VC+NYm9
         0qYazsWkWEX3gduZArdkJ7jcZ4MwxbINSXH9ctciV4Fd6qFUeXWnCOXFK6fWJepUn4bB
         VU3M1oP5Zn8FZMPBlwoZ4JhnGjeCdoO2HEqVHDYBaKkmp2d/oOqwPhysJAeI4JLkSbsw
         IbSA==
X-Gm-Message-State: AGi0PubflJCUS7vW0Zl4jBWlUH6tjMrsS0fwsYXMxoz8cMC4gQq5PTa4
        dUTyPt6PiDSOSzyaDjc9PsA2B+koZhXAIMH0BbCvPA==
X-Google-Smtp-Source: APiQypKh+z11m8F1ix2Z2qA2WFTg2laGvAVNnStvrubBMokrNGlppOc8VSRg/cbpzmKOt1kJvolZKpHdE0zo0OwSVKs=
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr8901006wrx.219.1589209902193;
 Mon, 11 May 2020 08:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
 <pull.539.v12.git.1588845585.gitgitgadget@gmail.com> <6553285043b2f004cca646aefd59c509324d4da3.1588845586.git.gitgitgadget@gmail.com>
 <xmqqd07exnhs.fsf@gitster.c.googlers.com> <CAFQ2z_NQuSpCwqZM25KZL7AshZZD01Cn9tfWgEjT6A2N3bk3yA@mail.gmail.com>
 <xmqqwo5isf09.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo5isf09.fsf@gitster.c.googlers.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 11 May 2020 17:11:30 +0200
Message-ID: <CAFQ2z_Mov33P6VAj_U+3iSNwdmu2DDF1caLLcbo_bbsifjBHqw@mail.gmail.com>
Subject: Re: [PATCH v12 03/12] refs: document how ref_iterator_advance_fn
 should handle symrefs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 11, 2020 at 4:49 PM Junio C Hamano <gitster@pobox.com> wrote:
> > On Fri, May 8, 2020 at 8:58 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >> Makes sense.
> >>
> >> I wonder if I should take 1-3/12 as a separate "clean-up" series and
> >> merge it before everything else down to 'master'?  That would reduce
> >> the churn somewhat.
> >
> > That would be great. Do I need to send them separately, or do can you
> > cherry-pick the changes out of this series?
>
> For the past several days, my tree had two topics, hn/refs-cleanup
> (4 patches---1, 2, 3 and 11 from this series) and hn/reftable (the
> rest) queued separately.  If everybody (including you) is happy with

I think the following patches should be uncontroversial:

* refs.h: clarify reflog iteration order - I tweaked it to reflect your com=
ments
* refs: document how ref_iterator_advance_fn should handle symrefs
* reftable: file format documentation - I tweaked it to remove nbsp,
and fixed one phrasing nit.
* reftable: clarify how empty tables should be written
* t: use update-ref and show-ref to reading/writing refs

The patch "Iterate over the "refs/" namespace in for_each_[raw]ref" is
something I want to mull over for a bit. It may be unnecessary (stay
tuned).

> I am wondering if we can also throw the file format documentation
> into the "more or less uncontroversial" pile.  There may be a lot to
> dislike in the current "implementation" in reftable/*.c, especially
> when viewed in the context of this project, that makes it less
> appealing to review, but my understanding is that the feature as
> designed by Shawn and described in the format document is already in
> use in JGit, so even if the code may need a major update only to
> become viewable from some reviewers' point of view, the design it
> aims to implement, at least a major part of it, is more or less cast
> in stone.

Correct; I support this.

>   Unless we collectively decide that we will never support
> reftable in git-core, we need to adopt the format documentation and
> the way the subsystem is supposed to work as-is to be compatible,
> which makes it "more or less uncontroversial".  It may need some
> copyediting, though.  Also it is not clear to me if the base part
> (without "hash id" and incremented format version) is the only thing
> in such a "the other system already implements it, so compatibility
> concerns leave little room to change the design at this point"
> state, or the updated variant that allows us to support SHA-256 and
> other hashes is also in that state.

JGit supports version 1 of reftable only, and JGit doesn't do SHA-256
at all, so we have a little  wiggle room with SHA-256, but the
proposal I make here is the simplest way to also support SHA-256 that
is in line with how it has been decided on in general (with a 4-byte
hash ID).

The serialization format is set in stone from Google's perspective (we
have been using it in production for 2.5 years now). The repo layout
on disk is recent (Code submitted last November, and updated in
February to reflect Peff's compatibility advice), so we could get away
with minor tweaks if we want.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
