Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5848C433FE
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 16:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352098AbiBCQDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbiBCQC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 11:02:59 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25759C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 08:02:59 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a24so5943591uat.10
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 08:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LCzIdva4ZlBiw/0K0GYywGOqaPWGRLIoMiTyaoq4PWU=;
        b=XfUga6b4o5HlwVljH5wRzvHZvpWazeTrUlGIb1JG6y90nF0PPfsYYBv3kagV70HDjp
         G0Wg37sPAExnzQj39Tel/47zlIuv3rTO+wgz3hcgzyVgdxNjqie3vfOvcbhNkJWzAGoM
         St63ZDdI+XoiRftWxplNO9EWGJf/HLK36bsQv8s6Nc6jy+PGrInmuodSgeVNDodu/Lc7
         IzhpBfz14QawfPBizxSVFnv6ZAd0ocyBxlLYrvQCRc+2b21FqiiNRKO4JSSoTsLjFwgO
         t4P9o3mMaWSnp6NyicLmQHgmetgjDp0eKXaki1aGECMlEAueC4dEIrJcw8oCpYsL8BGJ
         SQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LCzIdva4ZlBiw/0K0GYywGOqaPWGRLIoMiTyaoq4PWU=;
        b=I+6LPbUsL76LrLuK2zmOV6qwAcUAz9qCDLvqE606LDV4Lp4ZhHWrral3BRj7Mb0leZ
         YJEKnoOXqiThPNFvueuoD1vByGY/Yn7SZULDj91qUtRn3ziW+a+chmyKsAHGgd2kPBlJ
         7vnfDCq+PwxVop0SzNzm3WEskeg1QKFknOx2sShnjm8C9HefAZ1HS3rznOfV3ebeZP32
         jr0sXPwBz8pd9hplqgSVIdDjX+pGPGHucNsqbLOddx2iDoWvgr84H2n/iBjwUc1sJnVI
         bRzGC8lbf7VFcKSQ77maJYDtPV3xEvpRwdTvtrR2/PxFJkKSOkfsEIeEgH6LKZiaoYPu
         34BA==
X-Gm-Message-State: AOAM532JxNHJOAlDxDLpB6IO7J1kYzw1F4Gq2rmVRBjpf9AgGZMIFREk
        zynYAYOKEmDZSmcCzjkusSPe31+0yuXzJiLb00MPLkr3kgU=
X-Google-Smtp-Source: ABdhPJww0vMoNbJ6WMemJDsDYoX01AtQXNtDY/I8gq0+WC6TR4t10q1VncW1KJuYnHcskiU33//2cP2PpRX5FxU1jBE=
X-Received: by 2002:a05:6102:5596:: with SMTP id dc22mr14515161vsb.70.1643904177966;
 Thu, 03 Feb 2022 08:02:57 -0800 (PST)
MIME-Version: 1.0
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
 <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
 <YfhUIJuO70va6gr8@nand.local> <xmqqzgnbh7rv.fsf@gitster.g>
 <CAFQ2z_OFRJh9cwxnbDzrshYPGOvJC6Rz1eHTF-aKURno+41Cvw@mail.gmail.com>
 <xmqqa6facn9i.fsf@gitster.g> <220201.861r0m9t8n.gmgdl@evledraar.gmail.com> <xmqqsft2b5jl.fsf@gitster.g>
In-Reply-To: <xmqqsft2b5jl.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 3 Feb 2022 17:02:47 +0100
Message-ID: <CAFQ2z_NSCvRbj1bxirxhqSWD+LadzCa8VNOsxGCmFCNT3GUU0g@mail.gmail.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 1, 2022 at 11:12 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > We could surely add magic record types, but how would such a dance be
> > performed while keeping compatibility with existing JGit clients?
>
> Yes.  It is exactly the point of the question I asked.  If it is
> simple and easy to add such a new type that is ignored/skipped by
> existing clients, then we can go that route.  If it is simple and
> easy to add a new bit per ref that existing clients would not barf,
> we can use that as an alternative implementation strategy.

I'm not sure that there are any JGit clients: I committed reftable
support at the end of 2019. Before that time, we were running it
internally at Google, but only ref storage, and without the posix
part. Reflogs were never stored in refable, and I actually found a
couple of bugs in Shawn's Java code.

Gerrit has increasingly started using Git as a database, and the
packed/loose system is just not a very good database, so that
motivates the work reftable in general. But the folks who run Gerrit
on a POSIX filesystem want to be sure that isn't a fringe feature, so
they only want to start using it once Git itself supports it. So there
is a chicken & egg problem.

It's sad that we have to introduce an existence bit to make things
work, but overall it is probably easier for me to do than trying to
make sense of sequencer.c and how it uses refs/stash@{0}.

Technically, the only obstacle I see is that we'd need to treat an
existence entry especially for the purpose of compaction/gc: we can
discard older entries, but we shouldn't discard the existence bit, no
matter how old it is.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
