Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82798C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 05:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5F66052B
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 05:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhHEFgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 01:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhHEFgK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 01:36:10 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A99C061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 22:35:56 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j18so3936969ile.8
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 22:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qqg0lKPdA/hLZ5hmSFCFEpihQxIs9gvnMouY6xbiAZk=;
        b=U3CdgZrSm0vO7ob6bCEW6EHMtuqd83+bp4i8GwMFj81AJ6zF+ow66yH2IdNUhqbiMj
         IYYmed98WCkH6gYpWmhW/sKzOoGHtaoXyZ2Z6440FYTYxog0cuHZfOR/o0ze3k/F4H3s
         3E7ltSOeTzjeCCgsxfbGcuowrR6b+mEVTGhCr7BzdummTjc1VFd7BkRRQ0jYSNXDcvJu
         dYhPriT0owL0ujDpuKvxhwAZVwRyXR0zwocaNEFKf/vNQ90Vg0VdE+2Y240JMnd1MTFX
         6rq34Z64FdLkFDFLWVS3MXEEameuFADt2pm9EkJc9p7Yh3bSLLRpflxZlwAjFgwLmPD7
         1sIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qqg0lKPdA/hLZ5hmSFCFEpihQxIs9gvnMouY6xbiAZk=;
        b=YxJUH6y71EsU6huj2cBaXa9p1mL4LJdyErse9Arumc1vLr6RanT7cnwtRurjuJNa8j
         dkfR6TM2LttFXo/gQ/TfU1LyQhqT3yUvmuyQllgI3ZpTznWSc+IpsekMepIREqxLk5n/
         BHKmf8ao4sEdKgjJt/B5mczAhuI52FkbS6DhWXvtEV7r80OZNnNIzox65OZ3yTEz1Q7L
         6Z01/V1tzmSAmwei2QB3QpduN/0fVmM37evo5/AWnNz+aZMdjktixFUwyGEvhjTdeLSv
         JdzRqEuoVHqPMHugWl6YGKv+PHLO+aUNTNOE/SE8eHBjEW+2P1Rg1Sz4wCY09lAHmJGv
         Fwew==
X-Gm-Message-State: AOAM533tSfOU9bpHZf46ZVUIRz4ZSNZ6I7L3M+zQ7JKxI8BOxSYf0R/0
        2jlGnHc419wqYgVdVgvDLPz1VEVPbXha1lnzNXU=
X-Google-Smtp-Source: ABdhPJzbJBE9hRLVLPGuFyRfz2gkyA+icl1Qggug9HYwfZtbC0YUTxIZCWy+sGzCaQm6ZR7zGOvAKqVu5ZzOyJXHviw=
X-Received: by 2002:a92:6809:: with SMTP id d9mr93568ilc.174.1628141755546;
 Wed, 04 Aug 2021 22:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1010.git.1627714877.gitgitgadget@gmail.com>
 <pull.1010.v2.git.1627953383.gitgitgadget@gmail.com> <5d2fd55c580abc2057f2e6fe9f7d9c94748bf8de.1627953383.git.gitgitgadget@gmail.com>
 <xmqqa6lytat9.fsf@gitster.g> <CAOLTT8SkbNMcVocU9Lg3PfqTGHVEX8y27BMcP55HytfWH60w6g@mail.gmail.com>
 <2e3e8379-99e3-521b-1666-30fcf0e7909b@gmail.com> <xmqqsfzpp15j.fsf@gitster.g>
In-Reply-To: <xmqqsfzpp15j.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 5 Aug 2021 13:36:41 +0800
Message-ID: <CAOLTT8S+x3aGRopiXwWcNYsyQtiGWChR+f8u+7nM5A0xpusR3A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] [GSOC] cherry-pick: fix bug when used with GIT_CHERRY_PICK_HELP
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=885=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=881:31=E5=86=99=E9=81=93=EF=BC=9A
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> You mean that cherry_pick with GIT_CHERRY_PICK_HELP suppresses
> >> CHERRY_PICK_HEAD is not even a bug?
>
> I think that it is what the existing test is telling us.  Of course,
> with a good reason, an earlier design can be updated as long as we
> make sure we won't hurt existing users who may rely on the current
> design, but ...
>
> > Looking at the history I think it is fair to conclude that
> > GIT_CHERRY_PICK_HELP was introduced as a way to help people writing
> > scripts built on top of 'git cherry-pick' like 'git rebase' that want
> > to have a custom message and do not want to leave CHERRY_PICK_HEAD
> > around if there are conflicts. I don't think it was intended as a way
> > for users to change the help when cherry-picking and has never been
> > documented as such. I think we'd be better to focus on improving the
> > default help that cherry-pick prints as the second patch in this
> > series does.
>
> ... I think that is a reasonable stance to take [*1*].  If the
> default help message can be improved, that is a good thing to do
> regardless.
>

Well, this is indeed a bit strange, but maybe your and Phillip's
intuitions are right,
then I will delete the content of the first patch and keep the second.

> Thanks.
>
> [Footnote]
>
> *1* Tying the "here is a custom HELP text" environment variable to
> "having a customization means whoever is driving the cherry-pick
> machinery is ALSO responsible for sequencing and we will remove
> CHERRY_PICK_HEAD" is a rather unfortunate design, but as long as
> that is documented, it is a workable design.

Thanks.
--
ZheNing Hu
