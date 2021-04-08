Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0900FC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 19:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97D6610E6
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 19:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbhDHT7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhDHT7E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 15:59:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0D8C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 12:58:53 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id g17so2285205ejp.8
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uiHuwLgfPhILGLYxmwIV3Bp1g7biSWXi4cvpClyGv08=;
        b=mQ+h2ui9Z9XnAMwpBZJc1/U7dRZ3BqzDh0X0Aw4kggnSwGtj9Aq2FAyzTi0Vtswc+i
         s/OnLLMelCn3Eot3WOtBSGeYIGWV2gJQSbHWCEeahJTLMsohzGMGSLo70h9h6gFgFywV
         XjCtUV1BKyVoeFwa5KEk4igH5dm11/Bf5yy0GkGmU47/dWZ3PFOm7VhtD5IIQai4YnOJ
         VtiMHxTgEJ48L9yjogaNVF4VAkWlEzlz5uhBN5hW43fV3BaHsoPMxMhqsqlRjz2QujU8
         zScN/fKxJW6bHgAKx9ML3Y0kQnAVhHaDXyj3+mP8hIC4G3zkBbQSjQ5wHsQQo/o4BZgf
         r/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uiHuwLgfPhILGLYxmwIV3Bp1g7biSWXi4cvpClyGv08=;
        b=GpoVnkQ3dpdGDCWNYrFMARpcupOJboj4gFnKYMCGLkfcYV61cuK9ccWAAjaL3IojLG
         2fjUZZwwfE9HB7prDD8qM4DWTDamIJbdYH74p74IMWV6cTc/GbKbx5f5ul8D6KeDoFcI
         OrzUISn2a/ikqn3PIlwW44RANfF00WfKNlMX3bRtrxoSJNUkyDmI+PiDanfIalc7drBN
         +FvdyQS5DjE3Uk/nT82FN/JFVyc5htDU0xh87cG02WeDirimm8sNjVR5LxdOeJ8RFwFX
         V/VqCPe2c5oBFcDtFhQQid0bgvEQCwzEqXGtSGweJ5wyEKCigSAKim+zrbZKH32aZkPC
         mX+w==
X-Gm-Message-State: AOAM532bSesjq7b7oLsE/U7akXsUWmNEilYu62RmYT7zcF3VyOHX5w1t
        GyEMGIayFi7Rnxins3s6mkchNTyNZ+90XaEn5Ns=
X-Google-Smtp-Source: ABdhPJwkYewahCdmQMtuKMdcf8t5HXtNsJlVrTid/9bjxaHCrhgXKgKXuyrbBtEDjrhLUQkco+HfJ5xrHUsX5HAKN9I=
X-Received: by 2002:a17:907:3fa8:: with SMTP id hr40mr10541620ejc.283.1617911931958;
 Thu, 08 Apr 2021 12:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.988.git.git.1616742969145.gitgitgadget@gmail.com>
 <pull.988.v2.git.git.1617070174458.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2103301200020.52@tvgsbejvaqbjf.bet> <CABPp-BGwAtpsQJ8U5N1q21PMkideptY2MB2PNgbPqvya+XuyHg@mail.gmail.com>
 <nycvar.QRO.7.76.6.2103311533340.52@tvgsbejvaqbjf.bet> <3b117e65-bf9f-af13-b093-28bbbd6f9bb3@gmail.com>
 <xmqqa6qg4d0i.fsf@gitster.g> <CABPp-BEzayZkEZ36CFNBGz9X3jv0MNUnWa2EhzKKmWcb83yRmw@mail.gmail.com>
 <xmqq7dlk2ug9.fsf@gitster.g> <nycvar.QRO.7.76.6.2104080438080.54@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2104080438080.54@tvgsbejvaqbjf.bet>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 8 Apr 2021 21:58:40 +0200
Message-ID: <CAP8UFD1WsjB_shHnRUcH3rnQjwh0yodrETq6zh39vnZnHQpVyw@mail.gmail.com>
Subject: Re: unifying sequencer's options persisting, was Re: [PATCH v2]
 sequencer: fix edit handling for cherry-pick and revert messages
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Apr 8, 2021 at 2:22 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Fri, 2 Apr 2021, Junio C Hamano wrote:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > Even if others now disagree with the above, I know I can get a huge
> > > speedup by changing sequencer to stop per-commit wasteful work (stop
> > > forking processes like "git commit", don't write control structures if
> > > the rebase hasn't ended or hit a conflict, don't update the working
> > > copy or index or reflog).

It would be interesting to know which of these updates (working copy,
index or reflog) is the most costly. Of course the best would be to
compare the costs when updates are done at each step vs only at the
end.

Some years ago I worked on the split index as some tests showed that,
for really big repos with a big index, it could significantly speed up
rebases. So I have the, perhaps wrong, impression that most of the
gain would be related to the index.

> > > It's enough of a speedup that if backward
> > > compatibility won't allow such a method to be used by default, I'd
> > > still make yet another backend that could be optionally used.  And I'd
> > > have the default rebase and cherry-pick start printing annoying
> > > deprecation notices so that users become aware of a faster option.
> >
> > A faster and less powerful interface is good; I doubt deprecation
> > would work well. If a workflow depends on things like post-commit
> > hook, the affected users deserve some way to migrate to --exec or
> > whatever method to compensate the loss of functionality.
>
> I could imagine that there is opportunity to "persist on disk only when
> needed". For example, if no `pre-commit` hook is installed that needs to
> be run, there is no need to update the worktree nor HEAD until the rebase
> is done.
>
> And this type of `only write to disk when needed` functionality could
> probably be abstracted away so much as to make the rest of the code
> look elegant again.

Yeah, I agree with this approach too.

If the split index could also become the default one day, I guess we
could be doing pretty well even when some hooks are installed.
