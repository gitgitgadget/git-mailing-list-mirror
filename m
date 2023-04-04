Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22352C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 20:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbjDDUgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 16:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjDDUf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 16:35:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCA219BC
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 13:35:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w4so32447997plg.9
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680640558;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mTuQ4RePGm5SVEAhqxaH2hKu948I5GDbPQcAqQWSW4=;
        b=FLjsDl40um7sWYDMjktrVlzT3HBXQmTquyGZ3qOCi+6eufWLXM3kD8T5ao97l7h+CZ
         RbhAdU7gU1zxr2+VaHJalDN+Xma4FsDgGRJOmTpEjs8MtMVAIybIkPIVlrS1lFvSJC3i
         Z+IjJfLfj5D28+VIj+Q3Ngm8A9cYQopPAOR3wtiy2ydyiEW1P+kp1pCaCcB7PiIGzqPK
         FGw9kJ5uFNK1Srf/XFqBw4cKbRKfx7wbc4kWJ9Yf1TRF0ApSSzDHWPV6aq2Xb1kqD1AB
         iWwATs0EJfYXFQbmfSZQ+YcZdflJfaqz48wiwDQAbgY/oUXmUs8cQ6tFOIMuURoXtB++
         CRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680640558;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8mTuQ4RePGm5SVEAhqxaH2hKu948I5GDbPQcAqQWSW4=;
        b=X9C1RCgqOZsh/hxzcSjUsC96HPIDXAyq45WsjCqGoKn06KWFNzVU8a6CSPCJzcABty
         3VVBoZ6udPOICCS3H1UdyEUvawLfX0KpOVh+3L58fL0SKyiHw3rIS1TjtL4DvvpvP32v
         uJ4BLSWLdwfjdHvChUCoyLXbUHhZs8eqp+sn0l9f3RBYqxZpy8WcDRSm2nRh+tjoXv1O
         lbQ8BHM7Pg+xju38+a64AiUifDstlk2R2uEAjN98O+ztzfh8gPQ50+IVdcNp1c5Jn2eQ
         8bfXgKP4/vew5+cCy4XFJxnZBGUaFRAEIqD3gKxIY44le6HAJXPuEjFCa1KstjEqIRuT
         PdGw==
X-Gm-Message-State: AAQBX9eKTqOfTGQ/bCF5D5XUeHzdFPF38/YbiLjps4rlAL8jnxnFs6Fx
        HghvxSA5a6Uk0hQIc292Jfo=
X-Google-Smtp-Source: AKy350alOu+7ivAstDh9qDBHm0xK8pGN4IQrtY9X1QSYtVez+JeseUJK9Axrg7PocXLSE2FrjIJXxA==
X-Received: by 2002:a05:6a20:4e1f:b0:d5:9216:9182 with SMTP id gk31-20020a056a204e1f00b000d592169182mr3528725pzb.9.1680640557624;
        Tue, 04 Apr 2023 13:35:57 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id a12-20020aa780cc000000b0062e26487e7esm2625849pfn.155.2023.04.04.13.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:35:57 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     David Aguilar <davvid@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
References: <pull.1381.v3.git.1666076086910.gitgitgadget@gmail.com>
        <pull.1381.v4.git.1679153263217.gitgitgadget@gmail.com>
        <ZCvx/REMF69xkXJg@gmail.com>
        <CAPMMpohtL2dG_Ody5zALhS5kOuLLTTRw7L0vc6SnpWym+usppg@mail.gmail.com>
Date:   Tue, 04 Apr 2023 13:35:57 -0700
In-Reply-To: <CAPMMpohtL2dG_Ody5zALhS5kOuLLTTRw7L0vc6SnpWym+usppg@mail.gmail.com>
        (Tao Klerks's message of "Tue, 4 Apr 2023 16:50:31 +0200")
Message-ID: <xmqq355fz8pe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> If you get it wrong, an inconvenient or even bad
> thing happens: If you're in a GUI context and you forget to say
> `--gui`, then you get the CLI tool - not the end of the world, you
> might argue. If you're in a non-GUI context and you say `--gui`, you
> get a (hopefully intelligible) error about not finding a display, or
> worst case, you hang - and git doesn't know what happened, the
> messaging has to assume you aborted explicitly.

The worst case I can think of is if you have a machine that allows a
persistent virtual graphical session (remote desktop).  You can go
there, open a terminal and create a screen session, which captures
the $DISPLAY in effect.  You may disconnect from the screen session
before you disconnect from the remote desktop.  As the remote
desktop is persistent, the $DISPLAY would be valid even after you
disconnect from there.

Then you ssh into the machine and connect to the screen session.  If
you say "xterm &" in that screen session, a new window with a
terminal will open and be shown on that remote display session,
which you cannot see until you reconnect to the remote desktop.
Running "git mergetool --gui" would be the same.

With the proposed patch, the experience would become even worse in
that scenario, I am afraid.  "git mergetool" (without "--[no-]gui")
would detect the presense of $DISPLAY and start a GUI mergetool that
you cannot view or interact with ;-).  You need to explicitly say
"git mergetool --no-gui" in such a case to force use of cli tool.

Even with that caveat, I think the proposed behaviour would be a net
improvement.  I almost always work in non-GUI environment, but I can
see many people work in both and depending on their environment wish
to use the best tool for the situation.

> If there were a way to get git to autoselect "--gui" by presence of
> the DISPLAY, as it does for the *default* mergetool, then this kind of
> flow would be much more intuitive, usable, etc.
>
> I'm not sure whether I'm explaining better, or just repeating myself,
> so I'll stop here :)

Hopefully your explanation was clear enough.  Others may be able to
offer solution better than "look at DISPLAY and choose --[no-]gui
when neither is given from the command line", but I think at least I
understand your motivation behind this change.

Thanks.
