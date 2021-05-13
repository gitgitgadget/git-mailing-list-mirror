Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D439DC433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ECD06143A
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbhEMIGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 04:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhEMIGc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 04:06:32 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A68C061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 01:05:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id h202so33802847ybg.11
        for <git@vger.kernel.org>; Thu, 13 May 2021 01:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vakm0QaWtl2PDSTM7RrJKvmKjw6+Us17iK7fUmFMaaM=;
        b=Ra9TeA/56T4CUrC5+7jNIHllPmeYG1cubQUmyRfOnWbd+HNj9z7WIZTLNpqcfEzc7E
         xoixEPOf/g21r93UOCvN4FDdXgY/dBrjJ5bziXbZCrROlTYOjBxjHALPUyOXinvZ0r1c
         kw4ngj/e8NES6CuMcJkl+0NnYM+Ynw4ZzvEEqtOw3hZYhprIWtbTaf59KPcNIEL7cJZI
         XLgWDlpWA9OCwEc0URfHy4DOrXfJoZbeB+pytCczMZm8xkKS0DbQHxc6eCNgP68S03Wk
         C0G1d7/ZuDRuAEGTfBy/BNCRdXGDeJYpAwZtT/4JjEaw+5YtLoy9QaFO29wp56njxK2v
         1K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vakm0QaWtl2PDSTM7RrJKvmKjw6+Us17iK7fUmFMaaM=;
        b=BDYHKzU4j4jNQxQW/FV/mZsUocd1neVpy3BKwARLrSZS/Qwi/CgAh8eSIkPKzasYms
         KUsdjS8mwP15WXoOHRutdtTiTk1SD2bXYxMrzqIN21J/Zf7ApXLcZDCi92z4YQWAQX8F
         7aStONj339DJLIAiE3UZy95omjOLaX5R0zkgxau13t5BqcmQjYCLkR2Nss+kY7c/GYFz
         LN9khlq2aN8JKpcyk2jXCqtINgRUhaLyqRW13WK4NGd2n3iuBhyfaKQ3DXGN7e03tgEZ
         Tsfmmz7Dl89HJlZD9bvsILjJRTbWsiPu74tNwVy/RG1Ug0kYlrMso5Uj791IrM7ICAD3
         zkbA==
X-Gm-Message-State: AOAM530myUumvRjbsRXqk57pv2KNmU7WQncBUFdQzgGl6ITOCxFD0L1n
        TQN3MlwOS/T3nT5JIveAFvEmgu7UjA4mgRIQxSVYLPzhCQ==
X-Google-Smtp-Source: ABdhPJxSa2JlxXjYdIdpVGUnCrkpNPUPAa+W0ZnirTn1Syz1Z9vDKyp2lLY78IP03Yc/phEoNQ9MpQsAnmC4Cn0gvv0=
X-Received: by 2002:a5b:50e:: with SMTP id o14mr54408444ybp.43.1620893121734;
 Thu, 13 May 2021 01:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAKToE5BnzXd_2pjhJY13E=e6b1ZgOV=NmXr_WfpCQd+LxXsO3A@mail.gmail.com>
 <81d06db6-fd91-7ec5-6aa5-84f69a227204@kdbg.org>
In-Reply-To: <81d06db6-fd91-7ec5-6aa5-84f69a227204@kdbg.org>
From:   Alexandre Remy <alexandre.remy.contact@gmail.com>
Date:   Thu, 13 May 2021 10:05:10 +0200
Message-ID: <CAKToE5DgtW1Kuw4AE5+Am_=9gATN-S=xk1kYXMZUWvtdtNy_PQ@mail.gmail.com>
Subject: Re: Git pathspecs difference in behavior between linux (wsl) and windows
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you, that was that. I was misled by the doc and the single-quote
which indeed is specific to the linux platform.

Thank you again for your prompt reply.

Le jeu. 13 mai 2021 =C3=A0 09:49, Johannes Sixt <j6t@kdbg.org> a =C3=A9crit=
 :
>
> Am 13.05.21 um 08:57 schrieb Alexandre Remy:
> > Hi,
> >
> > I do not understand why the same command works on linux and not on
> > windows. Is the pathspecs syntax differ or there is a problem on the
> > git windows version?
> >
> > * On windows (git version 2.31.1.windows.1)
> >
> > git status -- 'src/test.js'
> > On branch master
> > nothing to commit, working tree clean
> >
> >
> > * On linux (wsl: git version 2.25.1)
> >
> > git status -- 'src/test.js'
> > On branch master
> > Changes not staged for commit:
> >   (use "git add <file>..." to update what will be committed)
> >   (use "git restore <file>..." to discard changes in working directory)
> >         modified:   src/test.js
> > A classic git status gives the same result between linux and windows
> > (with correct file detected).
>
> Which shell did you use to invoke the Windows version? If it was from
> CMD or PowerShell, then you must not put the name in single-quotes:
>
>    git status -- src/test.js
>
> The reason is that the single-quote does not have a special meaning for
> CMD and PowerShell like it does for a POSIX shell.
>
> -- Hannes
