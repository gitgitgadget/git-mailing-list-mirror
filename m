Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE55C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 01:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349260AbhLBB4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 20:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347426AbhLBBzD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 20:55:03 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B77C061758
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 17:51:40 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id w23so52947861uao.5
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 17:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7ZDI70fK3LRFZvQAjQ7sEFnEKJia4/LjVs6Lxm6+GaI=;
        b=pCkv2uWiZQFbD6UxcUwJQJmk8Xuv842ie/NscEelmAlGVLbez9tHIa2R7Nu6uiEl+9
         sW1AbcB9voYCcmLcoVCV+s7nsbcqxgqV3XYaP4zxnloPZcIaNnqLztkR2gwexvAjrlHC
         TJU2E2oPRQgLpzSagmaAb1tMny0xft4urMqZOvm9vNjQhH1hrFDMxb7ux0vlcm2S97uc
         u4x+VNaEaTfBMWPhalsb4yMBzXfnEJdLvroOWJP3n5Kajqw+zcUGFy/QQxTcP6TiSkaa
         V8Tt7vGFHNicZaRd3m+QuXWi00Py9bhdkryF3GDuipBqxtpf/w2c9inkiqkxw7uTS7wQ
         wuaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7ZDI70fK3LRFZvQAjQ7sEFnEKJia4/LjVs6Lxm6+GaI=;
        b=sXmu2XuWhtP8/ihRUb0qVJwoTiKPU+XQeVNsY4uWImSCjYMOdWWlf/aebgiHPmRaXd
         tAf2hWxX1gTobTzDKh1W4zUAxO/qV/E2CuKfcz8P5wvLkEXDOfBTq0MOv6DSSrBR9u3U
         GEy56TVDjRs7Rn1vTnQECIniqLUAlgRPIQX5MG6ayre2r0aCZN9UfGXi2omnBpbUn/Ej
         xBs+sRBayZak1L+wMZ5T6cMHLz4MGoljTFQckStP6meU+E3CREl17c57Xt+BXy+rBaYh
         lbPtHo8nhpnWuCBMcla0/OPYuLzNeEXm62voycgV5IeQawbkEEMXrE3W9T50kp/Ne4iG
         4MLA==
X-Gm-Message-State: AOAM531vYYJYI9S5gyeU1SB/A4e9rgKbsN7ClLK9cL7EcNPNLLFORz3q
        B626MFwtTrUEfe2exQ93UGdUvwzAKxO/EQrUdsU=
X-Google-Smtp-Source: ABdhPJwaW4wrBQnPRqhBIH78WtVSkPTLYGLisiLIq8j/dToe0omctM/rUU1hLLS/G0djHNBQDHjCFw3ZBfWbBiheghQ=
X-Received: by 2002:a67:bb11:: with SMTP id m17mr12170610vsn.5.1638409899717;
 Wed, 01 Dec 2021 17:51:39 -0800 (PST)
MIME-Version: 1.0
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
 <20211122222850.674-1-carenas@gmail.com> <b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com>
 <CAPUEsphP2GRaHJa0Qnvf22WUnNB+GnnfG8TgHqwJvSGdYfUQGA@mail.gmail.com>
 <7138fa14-02b2-b123-4d8d-df73763f8431@gmail.com> <CAPx1GvcML9TvmP1BSLN0vKWD++8LBj-68Xwmz-KrZM32Q=0_Ug@mail.gmail.com>
 <xmqq35nc15nr.fsf@gitster.g> <xmqq7dcnyh5o.fsf@gitster.g>
In-Reply-To: <xmqq7dcnyh5o.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 1 Dec 2021 17:51:28 -0800
Message-ID: <CAPUEsphktbdxeV7hvF52Or3CVHS8oOk5-WV=xfEZa8kfCVVnVg@mail.gmail.com>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a tty
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Torek <chris.torek@gmail.com>, phillip.wood@dunelm.org.uk,
        Git List <git@vger.kernel.org>, thomas.wolf@paranor.ch,
        Alexander Veit <alexander.veit@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 4:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >  - Add a multi-valued configuration variable whose value is the name
> >    of an editor program that needs this save/restore; optionally, we
> >    may want a way to say "don't do save/restore on this editor",
> >    e.g. "!emacs" may countermand an earlier value that would include
> >    the editor in the list.
> >
> >  - Around the program invocation in launch_specified_editor(), check
> >    the name of the editor against this list and do the save/restore
> >    as necessary;
> >
> >  - When the variable is not defined in the configuration, pretend
> >    that "vi" is on that list (coming up with the list of editors is
> >    left as an exercise to readers).
> >
> > That would give us your flexibility to apply the save/restore on an
> > arbitrary editor that is not "vi", Dscho's convenience to special
> > case "vi" out of the box when unconfigured, and an escape hatch for
> > "vi" users for whom it hurts to do the save/restore on their "vi".
> >
> > Hmm?
>
> That's an overkill.

Ha!, I was going to say that before, but instead went and implemented
(most of) it, discarding my simpler version[1] that was instead using
a boolean config and is otherwise similar to yours (but instead with a
default of false, and obviously not as good looking).

I was assuming the user would know better when the feature was needed
or not (obviously not if their editor is not even terminal based,
which we can't figure out programmatically anyway), and it was on Git
for Windows users that want to also use vi, to enable it[2]; instead
of "affecting" all vi users from all platforms by default, even if we
have reports[3] of some of them being affected before.

A couple of things that are still missing here IMHO are :

* need to also disable if not in the foreground (which was really the
root cause of the reported regression, and needed to address Phillip's
related report[4]; I cover this in my 1/2, so no need to change this
one)
* probably still should do the isatty(2) to disable (at the editor
level), as another way to protect against people scripting around
this, but also because it just doesn't make sense to protect a
terminal from corruption that is not being seen by a human, and as you
pointed out, git doesn't need to be that protective of the tty as bash
does (which will likely fix it itself, or let the user run `reset` to
do so).

Will prepare a new series including your patch for review and a third
one with proposed changes to yours from the second bullet point, that
might be worth squashing instead, or that at least could be used as a
discussion starter, or discarded if you already thought about those
and decided against.

Carlo

[1] https://github.com/carenas/git/commit/910c158b42994132de2480c018b44616962a2a20
[2] https://github.com/git-for-windows/build-extra/pull/399
[3] https://lore.kernel.org/git/xmqqwnmswxs7.fsf@gitster.g/
[4] https://lore.kernel.org/git/b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com/
