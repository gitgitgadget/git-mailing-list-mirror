Return-Path: <SRS0=WCE0=5E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CC2C4332B
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D812072D
	for <git@archiver.kernel.org>; Thu, 19 Mar 2020 17:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8YFhKSq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgCSRpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:45:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35686 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgCSRpr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Mar 2020 13:45:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id u12so3527582ljo.2
        for <git@vger.kernel.org>; Thu, 19 Mar 2020 10:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZ3/A2dlptHfzUjSKQ2alqrHXuiEqM06fab0N08JuHM=;
        b=j8YFhKSq5Jy64bhBe03KPsombDjsrBH/zHvyzxeGGXwQEwX7nks6nSQQFa876VWnyj
         LSnaADCjuVxgy1tVWy9IFTaqGRRGc+VVxtqSO1G3TGiEWXWHzHSIIDpi4wWlo1u0iF3M
         Ix98mnOP7JIU0NqO06E0mI90ua8KP62cs+cynPbzYU+FJShEQ62GYnuZ/OL/Drd3KQI5
         SwxlFjYwenP1Rbjgzx5LF1TtKLfrYESB1nPlqmzBnQjJh/oQVoyMndGNcQDoGrahx2Wf
         ItlIB4AvKGSxx5O3Uj9qU5hVoD941Ktxb5R1ZwZ+QXhwZHG/Kz/oPPMobGh1IGvhF8KX
         KUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZ3/A2dlptHfzUjSKQ2alqrHXuiEqM06fab0N08JuHM=;
        b=PKv05X+mNixj/A55ZWBkGOVEELKfk/OQVUTYqcT7Xaqr0rqzq1/0u4+anQlJMpHYU5
         +ShvSghVY35ddBnYFvJ+FgQfA7fs+U3LUtyYb7NJhko8zlEyG8b6EX0vzEH2Db5nAE5K
         FzxM8WqRvoIvNIkrq3qfNMHAJxI8XLuBhGVOSlC2NsN/RBlIUYHCjzVwfVhBgTxEygz9
         bTkaZi3Bl6cnIv/Muy3f9H3mgMFLHcD6oM+zFNhrOdJfrdAEfCfBjdGflN0xjJF9WdVQ
         xo2/R7WmrjwLhrS7YB7+++PmGhfM3uh/Cp4JJJBePgknzVT2h7Q6gy+0GAeYjXgsa35d
         HQNQ==
X-Gm-Message-State: ANhLgQ24WnAPeWeIWc5xQg5VCFTjO5jtYolHnUtLSeraiU/nu+/tt9HR
        614+xtn5GyX9T810FifJSj2zVOdXCGF5SwZfHZJhqaJU
X-Google-Smtp-Source: ADFU+vtlpOyo3rYp2kzk7PC9qjhF5a8yVKy2l1E5r67jf9KI+w2fkqgYCRxBMnmFuHqujXlWS4a53RDDnABYkVmdPpo=
X-Received: by 2002:a2e:3a01:: with SMTP id h1mr2756391lja.161.1584639944507;
 Thu, 19 Mar 2020 10:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200319132957.17813-2-harshitjain1371999@gmail.com> <20200319163817.4239-1-shouryashukla.oo@gmail.com>
In-Reply-To: <20200319163817.4239-1-shouryashukla.oo@gmail.com>
From:   Harshit Jain <harshitjain1371999@gmail.com>
Date:   Thu, 19 Mar 2020 23:15:32 +0530
Message-ID: <CACuU+s9WbKyg3P+ai8pnQqvRJDv+OoyqU-730K=1R7uasc=09g@mail.gmail.com>
Subject: Re: [GSoC][PATCH 1/2] t4131: modernize style
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shourya,

> > The tests in 't4131-apply-fake-ancestor.sh' were written a long time ago, and have a few style violations. Update it to adhere to the CodingGuidelines.
>
> Maybe add a commit title and then have a body? To do so, do a 'git commit' instead of 'git commit -m "message"'. This will open a text editor
> in which you can edit your commit message. You may refer to this answer I gave on StackOverflow on commit messages:
>
> https://stackoverflow.com/a/60755299/10751129

I used 'git commit' only and not 'git commit -m "message". But
apparently, the git format-patch tool takes the first line of commit
message i.e. the
commit title as the file name and the lines after that as the text for
the body. And hence, the patch emails, just start with the commit
description
and not the commit title.

So, should I explicitly add the commit title in the patch files
generated or else how to handle this?

> Also, commit messages are generally around 72 characters per line. What are the
> style violations you are talking about BTW?

The git coding guidelines says that we shouldn't have a space after
the redirection operators, hence I corrected this in the test file.

Regards,
Harshit Jain
