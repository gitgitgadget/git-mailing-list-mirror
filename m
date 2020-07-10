Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA02C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 01:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62DCC20708
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 01:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl8LYAlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGJBSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgGJBSr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 21:18:47 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D465CC08C5CE
        for <git@vger.kernel.org>; Thu,  9 Jul 2020 18:18:46 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c16so4349453ioi.9
        for <git@vger.kernel.org>; Thu, 09 Jul 2020 18:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1aBtbhV2f4/Xf/LGYJ0Nq8jb6/tCtudqSErFRnHv2Tk=;
        b=Xl8LYAlbhy6afCYQ6y+HUPe0VFQaCl7j03CufTJX3/CqD2XwpPTyTS389/y5GUy/xN
         bUOhHk06z7eGkEm6kMd9Wk1qZNB8BEBF6egIhW03CzuTGbC91Jeo+UWPX0ga6d7Upshs
         nFSQj0IJSJvJ/ZoakGjR/e2Fs9nFuPfPUVP+y88+Rd8hVueL11Q6eb+8QGM6QgamjiyK
         Hwl2Y4a40L1jWMZwvyoKB/mkeTB9uu2H265kC///bat+m/bimK2RFpaypcmcETvp2NWO
         xKqV07Uw2Ou/MXkF18gGpqbeVaB9QgbjBU5rUW4R2l2f8tYrYfy1BNPDQy6L4qLGjMth
         GOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1aBtbhV2f4/Xf/LGYJ0Nq8jb6/tCtudqSErFRnHv2Tk=;
        b=sh988Qdwd6Fl4D8YwQpS9xRLv7nOr3cWJkMxofjgJrS8YMcwxaQDnk2V1A64Rv0YNi
         UkmHeC9NLeJ8zl/PZDVr9k/4BaV0CkbiCh+Fqzvl+Q50qd2XZRw3z40kbE3JAU+jg+b+
         BEqYvvZzsIaQDRIOQyd3hD2RDUGQPzv8qFza9j4P8cA9wU7/BDxJsvgWbeNKAOLfYXX1
         XC5ttAbsV5UNuiXs8/oWurW+o9wI2q3iVnobQUT6dhiPQFBuNF6HE60orOjDIIvmFM10
         auGehiaqjXJEB2LcQYtvm6LcnXwr2jyD94tziFq6kmhBckQaD8ALt/pJ0Gv/K+N0aZWj
         5ENg==
X-Gm-Message-State: AOAM530XuCNYUpE/AhAy3HOq7YIoQuENsqP16FPyAMYW9Y2dl7sLUSCM
        69nJFBxnGfM0U0fRBxFxSDJs4+fiXcR47Odb9X0=
X-Google-Smtp-Source: ABdhPJwDsFaWaaQpqQfhdCGkM2d3xpjPcCkWkaqQ3U2sLExP0Zrh1Q2DC9ymldFf3YCo6SaoN9PGGHet9uPmZI+in1E=
X-Received: by 2002:a05:6602:1225:: with SMTP id z5mr45298840iot.64.1594343926088;
 Thu, 09 Jul 2020 18:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.667.git.1592784835441.gitgitgadget@gmail.com> <xmqq366ndkey.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq366ndkey.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
Date:   Fri, 10 Jul 2020 09:18:35 +0800
Message-ID: <CAKO26MsKK5Eu=aNtOkMr3v_VBm_TR8_vZOFz=fNMzax8RxntYQ@mail.gmail.com>
Subject: Re: [PATCH] bash-completion: add git-prune into bash completion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I saw this integrated into master. Thanks.

Best,
John Lin

Junio C Hamano <gitster@pobox.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8823=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:28=E5=AF=AB=E9=81=93=EF=BC=9A
>
> "John Lin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: John Lin <johnlinp@gmail.com>
> >
> > Sometimes git would suggest the user to run `git prune` when there are
> > too many unreachable loose objects. It's more user-friendly if we add
> > git-prune into bash completion.
>
> Yes, but it does not suggest all the time, and there is a reason.
> Most of the time "gc" is more appropriate, but there are narrow
> cases where "prune" is more appropriate and that is when the users
> will see suggestion to run "prune".
>
> Isn't it too much to type p-r-u-n-e while seeing that message,
> typing as you read it?
>
> I do not think it hurts to complete "git prune", in the sense that
> we would want to avoid completing potentially destructive operation
> to those who do not understand the implications, because the command
> is pretty much benign.  But I am not sure it forces users to type
> too many keystrokes too frequently that it requires a tab
> completion.  I dunno.
>
> Will queue for now.
>
> Thanks.
