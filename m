Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA66C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 16:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhKWQjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236142AbhKWQjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 11:39:13 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC17C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:36:04 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id l24so45060955uak.2
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 08:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ysJZKxCRaqb1HUlbspm2TnBdDBc6OLEi2DUOacrEp+M=;
        b=PFeF1Dp6uZX0hP/J9SydK4Z8x6s8s4c8F6b0Y1JImUPTLSDDX6DppnMMG2JdezjqAt
         w/e0nSp6RrPH4G5AHIANcPuP1ubNUjH6GXJxrivbvJMtw/o7T34nm9VboLugSNRVo7Te
         9zbUmRIEzh9Ru+f99yBrJy44y5BAF4NvscnIlQAvvUAQLNdSCoJG8CZmpCxlckTWygT0
         C5CqALUkyNv+Kqy8YoULsOW2wtAHXdNcEzwK7w6qZPesnmlUDMIgSh9/cO7yDXAnvtzt
         /Ktsp1XVEMmwVRrjELBT3+xWZVcezeeQpvMaq8S3gNk5F+yVjf05mwk4ZTPw5/P3f2QZ
         CbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ysJZKxCRaqb1HUlbspm2TnBdDBc6OLEi2DUOacrEp+M=;
        b=Vuv/GkRT8ForeJUSSmtFHXYeybObnL/Ox07pyyzXywLyRIDlkeAuxnDIMa9rWgcc0B
         wS/kgkmeyp2UBBCxQdTc+A22wmv99KMwxfaA1DLFj+vPjglnktA2/Fp1eg9x0eizIaNw
         MKZPLNLabTh49TcQoYvRvAS8OKROEjVhrQs7sgENU9zgStlYt6ZEBV065LIOhaF3kEdP
         HigaF2GSaz0YnLlb16mCQh4SKMjehklUm5WPtvKdUSSOj361Fs2ViVx65iffH6LfJajX
         4jKGWZf2Ypj3ITpP/kKFX5hleoObrlXmWbnzIPPlke0iAo/Kves6tvLcYIGRCXiijO+0
         dZew==
X-Gm-Message-State: AOAM532fXOgxUVWsBjfgodl2dhMZV+mg6CLPzvZhs+7z7qFjddCexHFf
        bHhuENOvIT7PSh+SwBpHxQ15i4Dc8vuO5a9wSc75VA==
X-Google-Smtp-Source: ABdhPJw7gG6lc/sFN9kTcri/uJNfW05ZOuOqWB7qRQZSVBMO3sSXWG2YEGa+LzxpJ+XGAq2fGYy2fs6VUWFnFufLO3o=
X-Received: by 2002:a05:6102:160f:: with SMTP id cu15mr10199224vsb.11.1637685363557;
 Tue, 23 Nov 2021 08:36:03 -0800 (PST)
MIME-Version: 1.0
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
 <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
 <xmqq35nnddw7.fsf@gitster.g>
In-Reply-To: <xmqq35nnddw7.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 23 Nov 2021 17:35:52 +0100
Message-ID: <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 11:27 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Commit 523fa69c ("reflog: cleanse messages in the refs.c layer") standa=
rdizes
> > how write entries into the reflog. This commit standardizes how we get =
messages
> > out of the reflog. Before, the files backend implicitly added '\n' to t=
he end of
> > reflog message on reading, which creates a subtle incompatibility with =
alternate
> > ref storage backends, such as reftable.
> >
> > We address this by stripping LF from the message before we pass it to t=
he
> > user-provided callback.
>
> If this were truly "user-provided", then I'd argue that all backends
> should follow whatever the files backend has been doing forever---if
> the files added LF implicitly, others should, too, because that is
> pretty much what these "user-provided" callbacks have been expecting
> to see.

I think it's just wrong. If you pass `msg` to a storage API, you
should get `msg` when you read it back, not (msg + "\n").

> Ah, the $RUN is hiding what is really going on; it is running the
> "test-tool ref-store" helper, and we did not adjust that helper.  So
> if we make a compensating change to the test-tool then we do not
> have to have these changes at all?  But that point may be moot.
>
> In any case, in order to lose 5 lines from show-branch.c, and 2
> lines from reflog-walk.c, I see that we had to touch 30+ lines in
> refs/files-backend.c.  I find it a bit hard to sell this as an
> improvement to the API, to be honest.

The test-tool ref-store adds its own '\n', so you always get a blank
line in the output. That serves no purpose, and leads to the

  tail-n2  | head -n1

in order to read the last log line. I think it's silly, and should be dropp=
ed.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
