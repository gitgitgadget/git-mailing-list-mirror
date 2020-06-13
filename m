Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3E2C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 12:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB432074D
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 12:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrKXh3Jj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgFMMIq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 08:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgFMMIp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 08:08:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40068C03E96F
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 05:08:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mb16so12699508ejb.4
        for <git@vger.kernel.org>; Sat, 13 Jun 2020 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LCBPK1kBy+er/QWEV6yTkG+J+IWXl2aFnZSt87UblbM=;
        b=PrKXh3Jj+uU4buu2ScetBtQUyvlWN30N1cZffDjceXCY7AMh/N6rUXIvwAoL7dCv37
         qZDDpmN1bH8aCZpX33+sDioa6Lsap0zEF0CPNrzdzURv0ajbYk2HxNB0RD15JPkdvQYR
         Pi56IRn5VzQNfL/LWJ7070CUSMc25JcAn6jpP72dsMRSKO59ShPy2BnL9GYRTrwtoNgP
         FNW7GptqG10fiG2+6uwe4egG+Ev8N/iBSwRkrLRZ/YaCRX1tI1wS1N9JX9fde1QlgMdH
         GU7BW+iJlXWhCeWQ/K9LymQzjCr5kHFQ33JsT5Dzsk0SbM+aPkVEM9VjsEEdIkB9PBnN
         O9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LCBPK1kBy+er/QWEV6yTkG+J+IWXl2aFnZSt87UblbM=;
        b=aOGiZQnObQi+vQZzOwkDidR9Lj9FcLPFr7YXGQsdA9c18uUVE+CYMGD4ovu0XC/iUS
         6vQPT7LMgA2RtuPZoHfDMSR9aX/tHWGnipF3qtjWgEf5mycT1lR7QDS9u9jhyAeKJiDI
         06tSYGNTThrDjCCGTIaMt480qWXV8ogVZcpGZ5epkyY2Q3Z0RZ/8tJ84Qzvo8NbHs3lF
         LaBfkPw7j9ms2Ytuo1aZ/UP3lKYjF9B5e3JCIQZoY1I5dKdvd5oEt9DopGyr9p+GcqLt
         4yn8IOD0taHXSXGUeCUYfHATJ5G1TMeew9u903mQq2Ng9eK0cU+ASP7rHuTYhFaCrkyC
         ZDHQ==
X-Gm-Message-State: AOAM532NXYmo7WxDh+XfTtuYsVmpM0qKYQbMnc0ZFL/tuk2nWI78LVgL
        OsBfXaZwWZRrnmiCUWGZd7nz0tQyQUxX6jSmVeM=
X-Google-Smtp-Source: ABdhPJxK24UT00h7cVM6VidqP8HcAxaBy2ULAxyqcv/JS7IsfWao42cjpDciyczZ6AU63DqQRr1UG5LQIRH3GW39a6w=
X-Received: by 2002:a17:907:685:: with SMTP id wn5mr18388919ejb.283.1592050123861;
 Sat, 13 Jun 2020 05:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
In-Reply-To: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 13 Jun 2020 14:08:31 +0200
Message-ID: <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
Subject: Re: Collaborative conflict resolution feature request
To:     "Curtin, Eric" <Eric.Curtin@dell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "Geary, Niall" <Niall.Geary@dell.com>,
        "rowlands, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jun 12, 2020 at 4:11 PM Curtin, Eric <Eric.Curtin@dell.com> wrote:

> Is there any existing or upcoming feature in git that could help make conflict resolution a more distributed, collaborative kind of task?

You might want to take a look at Michael Haggerty's 'git imerge':

https://github.com/mhagger/git-imerge

> I also opened this as an issue in github as I feel it could be solved by either tool potentiall:
>
> https://github.com/isaacs/github/issues/1816

I also made the same suggestion on the issue.

Best,
Christian.
