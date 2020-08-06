Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90662C433E1
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E09192311C
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 16:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgHFQns convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 6 Aug 2020 12:43:48 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44483 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgHFQmq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:46 -0400
Received: by mail-ej1-f66.google.com with SMTP id bo3so28401973ejb.11
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 09:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ogNv/cqmribw52Uf1vGAIaHJXoBqHuMJN5cSDKeN5c=;
        b=Wufv29SC+a4exwMEVaaWaYwovRQzMLOjS6HYnjkhC5QeePULNm2/6+qRGS2jPbkrrM
         jM09uPrlQ2YSfILQtboPIiLkg8Asggyknx9IET/wDVOwORLMVmlhxLbGtUSUsGg+UFCG
         Z+LPgxyffwjn/xIP+EX1izTQ4Le9btFssLbOgwSb3daf3AUq+MLFOJMW3Nj30xRTQlox
         SPk2wlYpf43hPeR6xTcWh2tuvqljzz/+hlFjiX4UcwtYhzlknL1hIGFhyFii7txLa9KZ
         R5h+IrvycEOTUWUT/rVOFB0ZS9MBIEIFIeZwUeisW9dFlO2DeMbryYVvKuJHMuC1PbtB
         9org==
X-Gm-Message-State: AOAM530maH8AKzCJbfWAjk5+rjIQx3xiobHiXqqYYfOSGpVTbV0RATPe
        q++YT253nBquUooeCa79nNUGNW7qt0E8hE/3aIGJh3aTHCo=
X-Google-Smtp-Source: ABdhPJyIKSTVJ6UjpADP0HXj6oR/iJX80KLYVklI/7WO1nDXwwpw++FdLPe4V+oGBA9G7FTSfqeYTobJz13lyv9gtX8=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr8747206wrs.226.1596730638688;
 Thu, 06 Aug 2020 09:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
 <37090d232221415b227c165bd44f6711d21f376b.1596634463.git.gitgitgadget@gmail.com>
 <CAPig+cSn7pGzr+PYBMAgbp9V0z+OVUGgW=SDWV33HbqjMiiKhA@mail.gmail.com> <CAALaSc=U65aqgK95zWG2=qSNguHLYkve4Hu=30WxyVOFYPUX+w@mail.gmail.com>
In-Reply-To: <CAALaSc=U65aqgK95zWG2=qSNguHLYkve4Hu=30WxyVOFYPUX+w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Aug 2020 12:17:07 -0400
Message-ID: <CAPig+cTgkD02VfvGnECRdkiZDS1jLEXXPveY2h61DY83n5rMnw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mergetool-lib: give kdiff3 prioirty in KDE environments
To:     =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Cc:     =?UTF-8?Q?Marco_Trevisan_=28Trevi=C3=B1o=29_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 6, 2020 at 8:37 AM Marco Trevisan (Treviño) <mail@3v1n0.net> wrote:
> Il giorno mer 5 ago 2020 alle ore 23:16 Eric Sunshine
> <sunshine@sunshineco.com> ha scritto:
> > Wouldn't this change the behavior for people running old KDE which
> > doesn't have XDG_CURRENT_DESKTOP, giving "kdiff3" much lower priority
> > than it had before?
>
> Yeah, true.. So to avoid this we can just also check for
> KDE_FULL_SESSION, that has been introduced by KDE 3.2, and this should
> be enough I think.

I'm not a user of git-mergetool or KDE, so I can't speak as an
end-user. My comment was made merely as a reviewer of the code.

If it is easy to avoid the behavior change by also checking
KDE_FULL_SESSION in addition to the new check of XDG_CURRENT_DESKTOP
without it being a maintenance burden, then that sounds like a good
choice. On the other hand, if there wasn't a good way to avoid
changing behavior for users of older KDE, then explaining that in the
commit message would be expected.
