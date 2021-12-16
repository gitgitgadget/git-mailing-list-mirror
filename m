Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274BFC433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 15:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhLPPzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 10:55:21 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:46937 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhLPPzV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 10:55:21 -0500
Received: by mail-pj1-f54.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so23044415pjb.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 07:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rRcZ6XJVSzPhBPXzs7jV7iWLVm8atKzEP0sq1evAXFo=;
        b=vtMr/9G2CGe9a5bt60j6Ax89aA/X/3L1XdjvgG6Cjs2I+NPQ7E/aFz256wJWTShVJ7
         pRfHzgEtaXITZTjqfzo6BNgXBDeSAFURY5U8XmCv19xs3t6w2p8XIBKBqU2SH/sdMSRs
         jw9ndG00Ad26s4VFDd8NmzUY1oM+QEae3QUu9pRZ2g13SUngwwpkZ4MXhI8vw5OAeEAm
         Y4LySSKLaPFQQEkyuxGNa9w41eEdCRCjCSG48tjT9jWSKNsJ3WfAjR16Ptn1SSkRSyO6
         Gp6goktfW5/hItfAdYOV2qAguTyNmgtBpSfcim34+p7M37aolM/GrXJChpDS6zVh+8RM
         6lxw==
X-Gm-Message-State: AOAM53219hscYyx+GndeQF1w/+2LpON1juJP97AtVw6S92tP+OALhaLN
        s7pVP6Mv4HMeA9dBrR03uOKjDMcSjYTcxetco55SINgQVUG8Ag==
X-Google-Smtp-Source: ABdhPJyW2sL0jD7tpaXGM1SkQDtmVJN3H4sZuUFUeJCBDDF23jZck5whT9QK4mvGUB/J8EDr33P29Q5HHkh60mI29bM=
X-Received: by 2002:a17:90b:783:: with SMTP id l3mr5107691pjz.104.1639670120770;
 Thu, 16 Dec 2021 07:55:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.1166.git.git.1639604468498.gitgitgadget@gmail.com>
 <xmqqh7b933ej.fsf@gitster.g> <20211216062709.b4tcagi6qcqhasrh@gmail.com>
In-Reply-To: <20211216062709.b4tcagi6qcqhasrh@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 Dec 2021 10:55:09 -0500
Message-ID: <CAPig+cQ9zFE+83e4fwxLfL18Pf5=SOoDKD7RqhmJ3DmYUDKfow@mail.gmail.com>
Subject: Re: [PATCH] help: add space after autocorrect prompt
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        kashav madan via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        kashav madan <kshvmdn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 16, 2021 at 6:18 AM Johannes Altmanninger <aclopte@gmail.com> wrote:
> On Wed, Dec 15, 2021 at 02:32:36PM -0800, Junio C Hamano wrote:
> > you'll notice that existing message given to git_prompt look like
> > these:
> >
> >     yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
> >
> >     yesno = git_prompt(_("Do you want me to do it for you "
> >                          "[Y/n]? "), PROMPT_ECHO);
> >
> >     strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
> >     answer = git_prompt(msg.buf, PROMPT_ECHO);
> >
> >  - It does not leave a SP before where the end-user input goes;
> >  - It append (y/N) _after_ question mark;
>
> I actually prefer this one;
>
>         Run 'status' instead? [y/N]
>
> sounds better than
>
>         Run 'status' instead [y/N]?
>
> but that's not a strong opinion.

For what it's worth, I also find "Run 'status' instead? [y/N]" more
sensible, and (at least based upon memory) it also seems to be the
typical way it's done in other software (including software I've
written). That said, it's a very minor point which needn't hold up the
patch if kashav isn't interested in redoing this as a single patch
which normalizes all callers to use a common format.
