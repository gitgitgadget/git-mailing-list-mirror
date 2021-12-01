Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFD6C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 20:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353469AbhLAVC7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 16:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353169AbhLAVBH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 16:01:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC714C0613B7
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 12:56:47 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so107005401edv.1
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 12:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IcErk62aq6sx+2j0rUV38xWUsd5yKaV+zCwaMoCUqJ0=;
        b=i4PKOhZZzsLEm2FpBmXLW6kIQNfQyMqeQX8sNpRucuqxTSsHpMRWt0jwswtbazVV/j
         m5McAsEXJKMHvAJORqmIst62RzuuHYs3KJUO3eT4Yb/KOs/R/ev6YlAMRhXaJL+ZFo3M
         jhux+PshapxSSPn5x7l2W29avFEK29cy80ecnNAJRn5cX0ik5WFk0at8UssbVqufLndU
         wCOOtZCxYyYSBbQ46jJYJeUlxccV1zsODbPHrbccBVj1vF8blB+w66w8gbZtx1444MSo
         h/pg9/dpxgxDMKQnXaAufZodua9aSv0r2LDt5J3Ptkdv2huU0GM4f7cjcXJizTElhVs1
         izgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IcErk62aq6sx+2j0rUV38xWUsd5yKaV+zCwaMoCUqJ0=;
        b=RB++63v5m2Ol+uEbFqpUQsuhpIj4b2BmSSIdsyy11+mci77PRTuc08v/i/KyG9g5mb
         zX3x3flGEiif/Z5rK0khmXHgLHqm1VPhBaUe6h+BUB0wxQXwjVrJs6yDAarwQbltaJJM
         eQh6SRwA7aBbutglgcjq5kUKwbYLWrqQKuFqk6iyETib6LCYr9bf2EMYWg3xL2FAQUuE
         1VoC53+Mo9oPFj/aY2JeecR0x8mdjkFbWj9uzz+QuL5t7xTwM2K/XUFNmnKu9SpoJ+uW
         uNeCuICloirmIblq+yACg+//gs5ccv2Ag19BDu12fFFifwfjQhitL7XCkmV+Hmfjxbk2
         Qf3g==
X-Gm-Message-State: AOAM532XmhJQdDBrs3lCANlg6bMyOKpxxgwFilYALIp7bE+0VNbO9jSE
        jKpHs80OfNV6MOVQirmr7c8k4ZthTf6qdbozsP8=
X-Google-Smtp-Source: ABdhPJzkUhyShVQgl34Rq8qRT7cO0TkHELy6rz6aDoluw53nqloZbmCd/zHWsM9+DyaUn7i6c42+v8PaArewiWvHVhQ=
X-Received: by 2002:a05:6402:5cb:: with SMTP id n11mr11901644edx.279.1638392206289;
 Wed, 01 Dec 2021 12:56:46 -0800 (PST)
MIME-Version: 1.0
References: <xmqqzgpm2xrd.fsf@gitster.g> <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
 <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
In-Reply-To: <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 1 Dec 2021 12:56:34 -0800
Message-ID: <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
To:     =?UTF-8?B?QWxlZW4g5b6Q5rKb5paH?= <pwxu@coremail.cn>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>,
        Aleen via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 5:42 PM Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwxu@cor=
email.cn> wrote:
>
> > Please don't, at least not this version.  There have been newer
> > submissions with three commits.
> >
> > I also still find the word 'die' confusing, since to me it suggests
> > aborting the whole am operation, and the documentation does not dispel
> > that concern.  Even if you don't like 'ask' (for consistency with
> > git-rebase), I think 'stop' or 'interrupt' would be much better
> > options than 'die'.  If you really want it to be 'die', I think the
> > behavior needs to be explained in the documentation, rather than just
> > assumed that users will understand it (because I didn't understand it
> > until I read the code).
>
> Dears Newren,
>
>     I don't think 'stop' and 'interrupt' words are better to explain more=
 than 'die'
>     because they still indicate that it will stop or interrupt the whole =
am session,
>     rather than stop in the middle of it.

Since you've been through several rounds of revisions already, if this
is the only remaining issue with your series, I wouldn't try to hold
it up for this issue; I just thought it could be fixed while you were
working on the --allow-empty stuff.

However, while I don't think it's worth holding up your series for
just this issue, I would definitely submit a follow-up RFC patch to
fix the wording, because I do disagree with your assertion here pretty
strongly.  Let's look at the meanings of the terms:

die: connotes something pretty final and irreversible -- people tend
not to revive after death as far as recorded history goes; most such
recorded instances tend to be causes for people to debate the
definition of 'dead'.

stop: could be final, but is often used in a transitory setting: "stop
and go traffic", "stopped to catch my breath",  "the train will stop
at this station", "stop! I want to get out", etc.

interrupt: seems to nearly always be used as a transitory thing

Now, in the computer science context, all three terms come up relative
to processes.  You can interrupt a process (the kernel does all the
time), but it'll usually continue afterwards.  Or you can give it a
SIGINT (interrupt from keyboard signal), which the process can catch
and ignore.  You can stop a process (and SIGSTOP cannot be caught),
but you can also continue it later.  die essentially means the process
is going to be gone for good (at least short of some kind of black
magic like a reversible debugger such as rr).

So, I think it's much more likely that 'die' will be misunderstood to
mean abortion of the entire am-process, than that 'stop' or
'interrupt' would.

>     It may be a good choice to just add an
>     additional description about the behaviour when not passing the '--em=
pty' option
>     or passing '--empty=3Ddie'.

That would be good.
