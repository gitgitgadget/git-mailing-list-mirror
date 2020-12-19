Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73003C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 19:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3D1238E8
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 19:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgLSTBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 14:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgLSTBL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 14:01:11 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE29C0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 11:00:26 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id p12so2582694qvj.13
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 11:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StE5wQxgOYHwse1P05jhe1I7vfA5VYRNlyxkI+YKheA=;
        b=fdSt9JzZMZfCtK2wnJfXVE3aHt0/ui5uwPovneEz764Ppm/VVeY450SGu3RzKZ1uHC
         hbeUTyok3AGivUBNJheUHR4Vs419ybKvkG/KouZgvQE4ifnTfW7oI2/VBE+5ZKY3r65z
         AkAE/LelVfd1ic+INdhmjuxx7MLj0/rsLjsiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StE5wQxgOYHwse1P05jhe1I7vfA5VYRNlyxkI+YKheA=;
        b=a6Qe9ar4uMbOnTVcsMalf2735LorwqNlyyXfc6T1/b7DfIU0ySfOAzxUoneP3PiROc
         RB/nCEMVtXc9tUILKeihFA27ohjB/eGblisg/NCg8Dm2UaQtxUiOPwBOaHtYW7mWPGI5
         r7u/M41aylephqem+mEfupe4PG5UHtJMc+nnFx/N0vNBtVSxpJ0VaFZ3anpo2NvWdv0j
         PJpji942Xpm1DwqriRE+AMGTVGJPyVo9pBP62ZrNyCwf/MKBYHA8opSHQUDN9K0VSoWW
         9X96W88YzEchGZf/1LT149hxS6tLNYUaRUk/t1rC94vbQ5ATlSkKzUK4LD5kyEeEAgf9
         phgg==
X-Gm-Message-State: AOAM530ZT2pQTR7TF4u6fCIUrZL/MIVqLzyXng/CRzBr2PgiC2P0YTY7
        XyNiAfEIXbBMC1a52bfLoPRN8RLZYCi6WVmBRhXtXA==
X-Google-Smtp-Source: ABdhPJzkLm25WIYNGx0PVUQAA2qXoRkyPk72dM3w8kXy3GWBbDSC9CZ9O/EkO6osIpXgMFB9lC1tJkHhwoEP71qepPE=
X-Received: by 2002:ad4:4f11:: with SMTP id fb17mr11108809qvb.46.1608404425258;
 Sat, 19 Dec 2020 11:00:25 -0800 (PST)
MIME-Version: 1.0
References: <xmqqpn3tqugm.fsf@gitster.c.googlers.com> <3f0403b84ab06b9deb7c5c189792bebe1db586a7.1606866276.git.matheus.bernardino@usp.br>
 <CA+kUOamDD_SDNLk3sPSwNAojrAAP+g38MjkfG4JMPRTGOVAKAQ@mail.gmail.com> <xmqqtushoeaf.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqtushoeaf.fsf@gitster.c.googlers.com>
From:   Adam Dinwoodie <adam@dinwoodie.org>
Date:   Sat, 19 Dec 2020 18:59:50 +0000
Message-ID: <CA+kUOanL3Kix4iH8dvsj1sf75y_3+v4qYwDWseMtaRFBqKkNwg@mail.gmail.com>
Subject: Re: [PATCH] apply: don't use core.sharedRepository to create working
 tree files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 19 Dec 2020 at 18:13, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Dinwoodie <adam@dinwoodie.org> writes:
> > Extract from the relevant section of ./t4129-apply-samemode.sh -x
> > output, when run with that commit checked out, below:
> >
> > expecting success of 4129.10 'do not use core.sharedRepository for
> > working tree files':
> >         git reset --hard &&
> >         test_config core.sharedRepository 0666 &&
> >         (
> >                 # Remove a default ACL if possible.
> >                 (setfacl -k newdir 2>/dev/null || true) &&
> >                 umask 0077 &&
> >
> >                 # Test both files (f1) and leading dirs (d)
> >                 mkdir d &&
> >                 touch f1 d/f2 &&
> >                 git add f1 d/f2 &&
> >                 git diff --staged >patch-f1-and-f2.txt &&
>
> ... "point X" (see below) ...
>
> >
> >                 rm -rf d f1 &&
> >                 git apply patch-f1-and-f2.txt &&
> >
> >                 echo "-rw-------" >f1_mode.expected &&
> >                 echo "drwx------" >d_mode.expected &&
> >                 test_modebits f1 >f1_mode.actual &&
> >                 test_modebits d >d_mode.actual &&
> >                 test_cmp f1_mode.expected f1_mode.actual &&
> >                 test_cmp d_mode.expected d_mode.actual
> >         )
> > ...
> > +++ diff -u f1_mode.expected f1_mode.actual
> > --- f1_mode.expected    2020-12-19 16:50:20.169378700 +0000
> > +++ f1_mode.actual      2020-12-19 16:50:20.249126000 +0000
> > @@ -1 +1 @@
> > --rw-------
> > +-rw-rw-r--
>
> This tells us that we are getting the umask (set to "me only")
> ignored by "git apply".
>
> What would we see in the "t4129-*.sh -x" output if we inserted
>
>                 ls -ld f1 d d/f2 &&
>
> at "point X" above?

Additional output as below:

++ ls -ld f1 d d/f2
drwxrwxr-x+ 1 Adam None 0 Dec 19 18:57 d
-rw-rw-r--+ 1 Adam None 0 Dec 19 18:57 d/f2
-rw-rw-r--+ 1 Adam None 0 Dec 19 18:57 f1
