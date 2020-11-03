Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0620C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E3020757
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 18:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ87kssN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgKCSev (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 13:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgKCSev (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 13:34:51 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632FCC0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 10:34:51 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 6so10232474oiy.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 10:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=KF3LfjaXQWtEqx5a1Pbvipz+WMiOlp862bqEqiOP5Tc=;
        b=eQ87kssN31SfmM6Ad5O7j9zUIs4x/FujEq+VsNGMpOgIXqoL+FySnD3voFHozeEFYj
         jLdBJwT7hNwlGHEynu7T5wfL+O5CJYc4ttlLU7HnaH73yPfX5HF0YhbHbnC8xsW9Ty5N
         WmPgDH/fqfZA7mHIUm4Hn5i6YMGsqX4riLcAh910J3s7Y3HaCIGukxix29n95SZQpo0F
         YYkPIDl91Qatha6NfBkbcAdSGylKTyp6MnZtTkATpF9LC5Brkk9kgDqbnvyFGYh5MtyI
         zdfVSggBevss5pwzNz3sS/WdrE5LHTfwX2yJl8tNZApT6c20vGbf2zF3ZNkQl1IsKk/+
         xVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=KF3LfjaXQWtEqx5a1Pbvipz+WMiOlp862bqEqiOP5Tc=;
        b=CSQl9Xaa8pHRzx01mpdh//zZUFAGvygm2srTuvm0ZtPf7ZbSp6OzCXQMInaE2Wb1ap
         PbXecFIMC1YuLjX4Zh2BHpJZYqoVN2Msz3hTpuM9cFzQMWLySmC6S2trvMCJGbgKd9ya
         sh2Q3x5t7xuEeUfCXyAzbR+xtc5OIIzx65BYnuM3BNlhdKXPFzck6nKp45CLLlPyYia4
         ykFt/PplxGXt2p7FQYdHg3X/b1J8+uprvzRuDSZ6IWUIgaRAWBeuYxVbJ+PrjVLqdXKO
         i/hmSl6xMrjeQx4fDJU4W3IgucwpkJoMhszU3SzH4q9XTSjtoGtVpvoSnvIfINMYN7Vj
         IByQ==
X-Gm-Message-State: AOAM5321Ihx/vRNUasEwpzjcSqraxYbwraqYX+mRT0yZlXuFvy7StWwz
        k6Gg0SDcXFk8y6RZzQ/Co+NFSvuRCBLAcP3d4gXi8keDUpyWog==
X-Google-Smtp-Source: ABdhPJw2cUoW6o5TyDOeRRkNOT4ZrPIOEOQzr8Tt20K95AxiMQ5Bmtmgpg6kmvOroU46O5NteloMYYtxwdc7rSr6sag=
X-Received: by 2002:aca:5a43:: with SMTP id o64mr274502oib.89.1604428490538;
 Tue, 03 Nov 2020 10:34:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHqVHwt1QJjXCAbDD5ViZ1E_rD8u+H_XeJ=FOv4VFPTS8y3xjg@mail.gmail.com>
 <CABPp-BEF2wqP+Cx5-6yq6cfQ1Pa+8iOXWR11DNBH02yh-D8oFg@mail.gmail.com>
In-Reply-To: <CABPp-BEF2wqP+Cx5-6yq6cfQ1Pa+8iOXWR11DNBH02yh-D8oFg@mail.gmail.com>
From:   David Besen <dbesen@gmail.com>
Date:   Tue, 3 Nov 2020 11:34:39 -0700
Message-ID: <CAHqVHwv4BC-OnfCvXySvksGHCx_+URQedz-BT6CqGbndDTM8Tw@mail.gmail.com>
Subject: Re: git clean -Xdf doesn't clean ignored files in subfolders
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Is this the same issue as reported at
> https://lore.kernel.org/git/4F1384AE.1050209@pcharlan.com/?

Yes, I believe so.  I am indeed using git clean as a substitute for make clean.

But, I still think a fix would be appropriate.  Ideally I could trust
git to remove all auto-generated files regardless of whether or not
the project even has a Makefile.
