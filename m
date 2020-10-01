Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB3AC4727C
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 05:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451A621D7D
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 05:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qztGoX9U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgJAFmg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 01:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAFmg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 01:42:36 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A6C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 22:42:35 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o21so3436119qtp.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 22:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BK4LAQKsf6q23bHVP7zD+8rTfwkfG57qqGVZkmj5I54=;
        b=qztGoX9U/7wwxdNLY1Fz1fSGR5tPD9HWEZaT+rkz7dKziZ0LSmV7+3i8EtYWdfTGuA
         fB85zvu0ilCi6uLhtfRmBzZpZDdvmpJX33hUiQtHeXlkVbdjO9j1UOdV7NSIri696cH3
         Qm3W+A0vudoQlnLOKVTsQidDHk0iDaOXG0mQxOWxGS6M/Z98VqKpy+/9zIO97j2iQxvC
         KRtKUQKCD+u3GkJ9XW7H8Blfu3c9fje8mrUD+QDU/knehmnWgvtmwVWRLQoGp25bNQN9
         jkK9wAL5MP8oDjIoSLXzdkSaiTq7MLsxh6NmtDFlsJ8iC+sh899pMggG27MORc1PD3ZL
         ISNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BK4LAQKsf6q23bHVP7zD+8rTfwkfG57qqGVZkmj5I54=;
        b=FPvONnHe+JunfTenidYLf8abprTnrPNRnHxeLQdlOYf7id4cVLH/MdDjN6pFgK31Rn
         owVLUL5x23muqHdOcRlyydjsiMwTiVre9/BSAyHeXkDhvFtifhxnS2qwtfXTMdeMj+AV
         Gc8s5q6LST534w1ME5dSvoNESb83u2RBjYnMYQ67KnRXIeym5TxfrHBwoyXprTWetPi1
         VWtMXd/XMCB+wb822wjfmo3snhl/X/NomHv77fCkORrw+8P6kkqysASpAUq+8kiwbeM8
         1lxnpqHNLAExrnYx3uWjd8Sj+omYuJvWDjl4Z/di3vQyjzZtt6SfXuIRtAl/j3gy6Q8d
         L73A==
X-Gm-Message-State: AOAM532pbg4fkf9t2h1D8Dx59cbq5iunN0LtpWCzRPpwVgM1Nzlubwr9
        XzpNNbPh7OY9iDomV28+V4YCpS8uDFu8aiKf+FcSLRlIaWMHYg==
X-Google-Smtp-Source: ABdhPJxiNxoewPjuVxuM6C0LWrWbo/4GD3oNgsytGYtetWxu1cabuVW23OB1l1z4+NVwRiwrSXKfILN6acDutWLutUY=
X-Received: by 2002:ac8:5d4d:: with SMTP id g13mr6045774qtx.348.1601530954946;
 Wed, 30 Sep 2020 22:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200925170256.11490-1-shubhunic@gmail.com> <CAPig+cTwHuTA=puzPfpOiMcMUkYPsbOca1GQK=dS1hJJeZZBGg@mail.gmail.com>
In-Reply-To: <CAPig+cTwHuTA=puzPfpOiMcMUkYPsbOca1GQK=dS1hJJeZZBGg@mail.gmail.com>
From:   Shubham Verma <shubhunic@gmail.com>
Date:   Thu, 1 Oct 2020 11:12:23 +0530
Message-ID: <CAD=kLpvWo3AuBsY8-tQSiuTOnAt5hp-hyO90SzCX5fFmKfahuQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] Modernizing the t7001 test script
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 11:03 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Sep 25, 2020 at 1:03 PM shubham verma <shubhunic@gmail.com> wrote:
> > In this patch series modernize the t7001 test script by changing the
> > style of its tests from an old one to the modern one and by cleaning
> > up the test script.
>
> Thanks for tackling this task. I presume it was prompted by [1] or
> [2], as this series covers many of the items mentioned in [1].
> Overall, the series looks good. I'll leave comments in a few of the
> individual patches.
>
> [1]: https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/
> [2]: https://git.github.io/rev_news/2020/08/27/edition-66/

Eric, Actually I follow the Instruction that you pointed out in [1].
Okay, I improve the commits and make changes according to your comments.

Thank You!
