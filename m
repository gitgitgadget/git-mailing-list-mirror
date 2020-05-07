Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF72C4724C
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E529208D6
	for <git@archiver.kernel.org>; Thu,  7 May 2020 23:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAm3INu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEGXMX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 19:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726514AbgEGXMX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 19:12:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B109CC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 16:12:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z22so5956477lfd.0
        for <git@vger.kernel.org>; Thu, 07 May 2020 16:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnwsgSmN0OCEbZJp2MYPB7uosaUEZmgtuk4x+aq0/wQ=;
        b=aAm3INu1iLerlFFg1sJRNaxYulsJQ/BkJeH56VePqAOE2YsPeHmoy7XYRTTOJAmVTG
         i3gKpBasdGfDn6lpWwJUhc6Gr8G5bXjIwBRfCOiShEILzb5+5eXfz/srcKvR1DqQbFO6
         QlFf6huQkEQzMRzsh7dYeQi1dLurFzA6Le/UOdTK2Vl7/zycJcCeYWaJP/Y4XTskJYKZ
         FzS/E+foomnSI8zfjWRZ6pDK+hKHI7dK5MQg6EGmhZcPDn1btHKIaJ5l++TTnELxrHw6
         eAnx479d6vO5ta4IZAVx5K9uOeDMy9LS+HuVmbRHjRRG8gLKkMzC+0WBUAgSztHp6Oj3
         2FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnwsgSmN0OCEbZJp2MYPB7uosaUEZmgtuk4x+aq0/wQ=;
        b=f9HaDyjgmeq4dIKJz/rVHRSFslb279ct9IUq5/ste6SPApZQBjNOL2U8fnWLwNY59L
         FPgL/0eiUMLJMtj8J8QLO7zE2kt3QNlKAtlmIcCYEuLvY2qoRQOGlQchHQMWR5ZQFNur
         uP1ZwTLbRSL8eQbJvDXtuWI5JcI4rbBoLLam7POeP8imFvRDboDAMJ4NnU+dGM8T4nia
         BZr72T+zBHjcP5nWefHAXz6NXjnVb7TYIFPA0xaMDEWJCj9TyrBDzNyc1Y+z8rdn0Epb
         0ZHa0cjGAKaWB0t1B+Xy2AWNee6ygrtuDGtun51gjUo7QUI6N5nLqSVq4KzMxzUUuf6D
         7AMw==
X-Gm-Message-State: AGi0PuYVLulWHz7zXoX0Td16aIYlWjC3mTVrQzr4B7gSd8u2BP8YkJ5u
        OXeefZTlou6WHXGeKvylqr+5kVYGUUI7t0lSU+9zteIzlNg=
X-Google-Smtp-Source: APiQypJLEE/wdaOPCi//LpofFik55cu/mOp9ywWp/XIwytV6W7hpdGdojo/bS3vLBZxpedmEB3LC/QuvhUnggwvEYEw=
X-Received: by 2002:a19:4a05:: with SMTP id x5mr10424043lfa.17.1588893141001;
 Thu, 07 May 2020 16:12:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+KyZp7TELrswPjNgB99BXXHEXi5pRr5bO3g_wy7zBvv1R4Kww@mail.gmail.com>
 <xmqq1rnv2vi2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rnv2vi2.fsf@gitster.c.googlers.com>
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Thu, 7 May 2020 16:12:09 -0700
Message-ID: <CA+KyZp6pvqqNnOOj0ap9ekPdv9mZg2u_NQuwFgMXfwfV17SrYQ@mail.gmail.com>
Subject: Re: check if one branch contains another branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

so it would be:

feature_branch='my_branch'  # the branch that I want to ensure is
completely merged into origin/dev
git merge-base  origin/dev --is-ancestor "$feature_branch"

that won't work?  since git merge-base only works with current branch?

On Thu, May 7, 2020 at 4:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alexander Mills <alexander.d.mills@gmail.com> writes:
>
> > I am looking for a command:
> >
> > 1>  if branch x contains branch y
> >
> > right now all I can find is
> >
> > 2> if current branch contains commit y
> >
> > can someone please accomplish #1 ?
>
> Study "git merge-base --is-ancestor" perhaps?



-- 
Alexander D. Mills
New cell phone # (415)730-1805
linkedin.com/in/alexanderdmills
