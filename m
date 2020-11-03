Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237FEC388F9
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE13B20E65
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 17:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/awlJXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgKCRLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgKCRLm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 12:11:42 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979A4C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 09:11:42 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n15so16626161otl.8
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 09:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QvHQ8xW6m5Pg6N4i9ViNig7+v9dX+/shyVE/1Kxnzcw=;
        b=A/awlJXwxoedF0yptIsIf4fqsztpbwrOBHL6yF457j4fzjOrmb1hsxf2WHq9zchObM
         dE21ZDKgu7dPqvbjXvw21GPn++N5VzbQwDierdvXRC3VQGpgT+Clcc+D/xxyvv+y8pRo
         so/8Xc3zCOhFr2jzR0O6kOYQ7L65mN7Cu4ya5UkiGReNZUDCWB06HyztNojB7twYBQ9s
         2t9uSOMx4soQLlJ0D6oBm2uyUynMVsjeZgkTOzV2oq9wjSj7KYGHpPJ/LrIwguQlB9PO
         2mTbPJ4GJQVToc0NM1UH8ie+pTVQtUCXB8labNGso+icmzZtpb+LrBDZNkWSDwS4WghI
         zTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvHQ8xW6m5Pg6N4i9ViNig7+v9dX+/shyVE/1Kxnzcw=;
        b=lEmZzRihL1td/Ijg5OHir35QuPW/O/+BHqBT7K1xsN0itgaFjK/1u7lNwjAf2YaDBB
         pJGNjtLhzEvvsa+Z7kZh0JjmBOkQDGZQgwqRlp65lRi/NFzzpzwY4t1iTPvy/7zxuwlK
         pvfGIExKOX73VceClnEXxrrMJ0r6TG1BE3RkleM9Vp45EqdnxYHzEHf5/tqjb2utW0ow
         ODdIgT6Hso+gR5eRoiYBbi7jpVjaWjG0FAyLyJxge8FGMISxvblLTxcZOfkJUsJGY+Qy
         3mskjMFpPWiKZgQDIgMCoaru2/jonnhT6mtIJEpv/Lnje21T/rRunZevi9w7x2Ad8E0o
         TbyQ==
X-Gm-Message-State: AOAM532aaPWgKUFQa+sl/G0dZPjjXAx5F4PIX2br/jYQccuqJEeUamlN
        Ulaeiye5GDHvluCzXrNEbZhYZ+hrz5912LoHtd8=
X-Google-Smtp-Source: ABdhPJxNud0Tf1q9zN48evCXww3pla6uD/CCC8be5x/gQ68IVdShbbrZOGEyxtenX3aS13ClxbrFEiPQRjcogZ44ll4=
X-Received: by 2002:a05:6830:208d:: with SMTP id y13mr2706352otq.162.1604423501959;
 Tue, 03 Nov 2020 09:11:41 -0800 (PST)
MIME-Version: 1.0
References: <CAHqVHwt1QJjXCAbDD5ViZ1E_rD8u+H_XeJ=FOv4VFPTS8y3xjg@mail.gmail.com>
In-Reply-To: <CAHqVHwt1QJjXCAbDD5ViZ1E_rD8u+H_XeJ=FOv4VFPTS8y3xjg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Nov 2020 09:11:31 -0800
Message-ID: <CABPp-BEF2wqP+Cx5-6yq6cfQ1Pa+8iOXWR11DNBH02yh-D8oFg@mail.gmail.com>
Subject: Re: git clean -Xdf doesn't clean ignored files in subfolders
To:     David Besen <dbesen@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 2, 2020 at 2:46 PM David Besen <dbesen@gmail.com> wrote:
>
> Hi!
>
> I'm seeing some unexpected behavior with git clean:
>
> git init test
> cd test
> echo "ignored.txt" > .gitignore
> mkdir folder
> touch folder/ignored.txt
> git clean -Xdf
>
> I'd expect this to delete folder/ignored.txt, and instead it doesn't.
> I'm in git 2.29.2 on osx.
>
> I saw that git clean -xdn does delete the file, so if this is a bug
> it's limited to -X.

Is this the same issue as reported at
https://lore.kernel.org/git/4F1384AE.1050209@pcharlan.com/?
