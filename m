Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8CEC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2A8611EE
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbhIPWpq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhIPWpp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:45:45 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939FBC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 15:44:24 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id c28so7617753vsh.11
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 15:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3BH7/b3oTxsYdNo2iy+xeYAF741qqawn4FLOfxq6cLc=;
        b=cDcUz9TE8X2valGFlW2ctIhCVkI4mHplcB/CKLMvA5YLbMHHt4vGKizFHEErOdWopH
         ZafN45a4yOsUMQPqhD4+6TuuSqftpiSk1w9ZXKdhoQ6vxIwvG85XXEFPS0RR67+58s27
         tp30+bH7BtUQ8bBg47/PwGs0z67Y19BMvh8AwS2GK2Ije2Ge7m5jPaXoHMfcrPtveEnB
         31WIRH92oO8Iss4hBsAvZMxX57kV70BKVaSxVUM8AzhFTfoDSF6HXqUxGhSyyy30cvNE
         KNmYAEFu2F+u7ukWSrcBH0v5IfsMA+msPaSm7tjy4a6YPQ15z4jX/tG5uDmiLdkdSnju
         sqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3BH7/b3oTxsYdNo2iy+xeYAF741qqawn4FLOfxq6cLc=;
        b=bWDxdRFfFwn+t8WPvk69MSBhrRfqzv6GqznCnc6RL+G1ADN+F460N+z1lxab7nnGqb
         3X6hy7LtQ95waObvqnPYrDR9XbiuP89DCAoIh3vUXy87N33SXEDxmkjVLsEEW5UecVzk
         /1pNHm+PI6tbpS7zxweqNjJjldn6VtCpp2Wl5UdGTXA8VP10AZXZCHBw00EDU0f7coeQ
         raH9lLEx9+GJxXGmfY4JJBjlqbiKNb7GEQuv2RAxw2Hz5fgs2zxtNPGd1875AHUNH0UW
         58Jl2vrB0ZNefNNeXfEcqHFMcdMs7iGHvIf6mollVFn1f51cHmk3bYGB7q5cYiT/tcsy
         j1ng==
X-Gm-Message-State: AOAM533VLXUyt37MHAe36K8xQpqUCbgFN5JLcbbF4T90D1ALndrv/bGY
        9zGQcSPvSIevHMxv9tb7nJgF9dR+fOsetWSWik7PPkVx
X-Google-Smtp-Source: ABdhPJzRqwnSd0YTi3hd6wPpNLRtai86ALpuhimQuKmtEegnd33ZuS9mzM7h6vE1U98fwiRQiuOLpyFdSowijP2Tl8M=
X-Received: by 2002:a05:6102:518:: with SMTP id l24mr6326678vsa.57.1631832263668;
 Thu, 16 Sep 2021 15:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210915080948.11891-1-carenas@gmail.com> <20210915080948.11891-3-carenas@gmail.com>
 <xmqqczp8rx1c.fsf@gitster.g>
In-Reply-To: <xmqqczp8rx1c.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Thu, 16 Sep 2021 15:44:10 -0700
Message-ID: <CAPUEspjqD5zy8TLuFA96usU7FYi=0wF84y7NgOVFqegtxL9zbw@mail.gmail.com>
Subject: Re: [PATCH 2/3] git-cvsserver: protect against NULL in crypt(3)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sam@vilain.net, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 16, 2021 at 3:11 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > -                if (crypt(descramble($password), $1) eq $1) {
> > -                    $auth_ok =3D 1;
> > +                my $hash =3D crypt(descramble($password), $1);
> > +                if (defined $hash) {
> > +                    $auth_ok =3D 1 if $hash eq $1;
> >                  }
>
> It is not wrong per-se to separate the two checks into two separate
> parts of the conditional, but because we check for definedness only
> because comparison of it with $1 makes sense only when it is
> defined, writing it either like this,
>
>                 if (defined $hash and $hash eq $1) {
>                         $auth_ok =3D 1;
>                 }
>
> or even like this,
>
>                 $auth_ok =3D (defined $hash and $hash eq $1);
>
> may be easier to read, no?

yes, let's go with the earlier; I was trying to mimic the original
code, but agree on a second read that it looks confusing.
assuming there are no more comments, would you want a reroll?

Carlo
