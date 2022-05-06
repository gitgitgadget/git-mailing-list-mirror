Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2EDC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 00:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381211AbiEFAyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 20:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiEFAyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 20:54:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23DC165BF
        for <git@vger.kernel.org>; Thu,  5 May 2022 17:50:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id x17so10117360lfa.10
        for <git@vger.kernel.org>; Thu, 05 May 2022 17:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0w+kbq012XrYmYU90GuN1laAHApHGoNqH/XFXoyniIM=;
        b=Rqh/ggsLEgL8N6LUtvKt+zpymKlBQhyuQmQ76JWCY+K0IE/NPS/pzMmnGYA6kZB8yo
         XgQBhl6muziPilF9G4iifpBJ3pNTHW6fkfoQsWDL3vjs1iRMDI0ZvktdSEXpKWmnZYDo
         74oDhcffiI+tkeYT9HM+UiKOzaImw3J4Tm7lo2++hz6Rd9fZbyOyX2mLIpfmiiXCXjy9
         8Uek1+4SRCE83TI3bNBwDqTQ5AFW63yTd1qSTq3lS2+Up+IgHXjpy7944725SGu+hjVs
         oLYvFuHDFyi7/H/+QsFQcYgpSgwYsAlV+pSsaDMsKsCRp3o2aSTZCFABWV8HdJeeKLpU
         KPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0w+kbq012XrYmYU90GuN1laAHApHGoNqH/XFXoyniIM=;
        b=leJssw/zUyJWIkpKkHjj9S4Dl2BV5D/EwYdu1W0bWxVHqsRZDrXJmUmWo43RXLshEr
         /2IkiS9K44E3YHDmPX+A2IFfSo0EW5bKtvuGPLd1cWvou7/7wUSn9nRuOoBW2ZoZtYVu
         tT/srNelEhJSa8QCJQO8/S6JmpQGzn6nBKFCyx/l3BOr+HrspM5BhFkcgTemhzjB8n1F
         OJLrK39r4BZgJzHACXKDhgJCarqIPSjkFig3WXg6wSuHU1FnCgb0421wjPZoMytPGJYJ
         S9fguZqOU1hdus+QgUFvAfUwMtwvkzLbnLG+Gubx89+hEOJz6VNSEfbRR/4jK/vN/o85
         TMSw==
X-Gm-Message-State: AOAM5336+vN9mEKVq6gtvrDOGs+6Fnnj4a1O7MnDQ+jxoaoL/BUP3taI
        Ecq+YfnfOME8qukI0rnsByKjCFLP0LaVnOBDfYU=
X-Google-Smtp-Source: ABdhPJzc6OrwHRxQcRvjI6tuGVWcfmuRZumJNCqn7R1klzZETiviMyX+L5SfQPTcRiUqy7t8lsoADb3lAhsTn8t78nM=
X-Received: by 2002:a19:4f53:0:b0:472:1714:61f1 with SMTP id
 a19-20020a194f53000000b00472171461f1mr686232lfk.473.1651798225909; Thu, 05
 May 2022 17:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220503132354.9567-1-worldhello.net@gmail.com>
 <xmqqtua5nz61.fsf@gitster.g> <YnKS1zIr0YAUJ6N4@acer> <CANYiYbFDm+aYE9avabnffcTNR4HT6rv77bQiWbAWSzzxeFxUxw@mail.gmail.com>
 <YnRI6u+dV5GNHoD9@acer>
In-Reply-To: <YnRI6u+dV5GNHoD9@acer>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Fri, 6 May 2022 08:50:13 +0800
Message-ID: <CANYiYbH++nachBO_JU0zEcDkbkJYCkPQ3HTivwsNpaD7UvgsqQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Incremental po/git.pot update and new l10n workflow
To:     Daniel Santos <dacs.git@brilhante.top>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?Q?Matthias_R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?Q?Christopher_D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Fangyi Zhou <me@fangyi.io>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 6, 2022 at 6:01 AM Daniel Santos <dacs.git@brilhante.top> wrote:
>
> On Thu, May 05, 2022 at 08:20:13AM +0800, Jiang Xin wrote:
> >
> > A new git clone of git.git is about 150MB in size, while the "po/"
> > history occupies 28MB. By removing the location line numbers,
> > the size can be reduced from 28MB to 6MB.
> >
> > See: https://lore.kernel.org/git/20220504124121.12683-1-worldhello.net@gmail.com/
>
> That is an improvement of size only for few people. On GNU/Linux
> install of git by most users is done through packages, and most git
> users of other OS, also will not receive this improvement.

We, l10n contributors, only need to make a small setup to our local
repository, and we can avoid uncontrolled growth of files under "po/",
resulting in more than 50% of the Git repository capacity coming
from l10n a day. See patch 9/9 or this link:

 * https://github.com/jiangxin/git/blob/avar/new-l10n-workflow/po/README.md?plain=1#L160-L171

> Have you considered how the removal of these lines from the po files
> will affect the quality of the translation work?
> For new translator, not having these lines might make them less prone
> to understand po files usage in C?
> And probably make them contribute less to i18n C code?

The location numbers will always be there in your po/pt_PT.po.
Please read:

 * https://github.com/jiangxin/git/blob/review/avar/po/README.md?plain=1#L133-L158

> Has these implementation upgrade better benefits than counter effects?
>
> It is worth discussing this.

The new l10n workflow is open for discussion, see patch 9/9 or this link:

 * https://github.com/jiangxin/git/blob/avar/new-l10n-workflow/po/README.md?plain=1#L60-L95

--
Jiang Xin
