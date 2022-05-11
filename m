Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2E5C433F5
	for <git@archiver.kernel.org>; Wed, 11 May 2022 23:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349199AbiEKXY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 19:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349256AbiEKXYF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 19:24:05 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20E35931A
        for <git@vger.kernel.org>; Wed, 11 May 2022 16:22:05 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 15-20020aa7920f000000b0050cf449957fso1745274pfo.9
        for <git@vger.kernel.org>; Wed, 11 May 2022 16:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=3Mh7KQWokOGZsvCxbC3ZLIjM+Qpw84oiHo6vxlR5TIE=;
        b=L3cybDwZjELCUQ78myTmOJwZo3SsgdL5hBW5tQylzYK/AilssPxcwcwQAiqirjJFxW
         tN5pPJZ/pttvdB9pDewH0Z0ls8G8W5PKB9yWwgxnrZYIfhkrEIHkuM+hC+jb62T6bxyn
         3sdiX+0ZPBRZYvnpqjeB6uZ7fEobyNLPX5TF8aHzFmYIjc1vCzAmM/Mnaj/8zlFC8cZj
         FB3u4cx0T2Z75SpDwxOAeVmwgpJ5FeXIJsOOO9iS+E2c2F8BI7GsfK5xJMmZkMu6f1qH
         e4Bj0zbpBpORkxsTet3up+X5rRAdOqL/1C7ype6I8Yu5jEXRHXwxmv4O7tv8klBV28Ft
         UjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=3Mh7KQWokOGZsvCxbC3ZLIjM+Qpw84oiHo6vxlR5TIE=;
        b=FhnQhU3Vu6XhaRRQHYM10yPtQOQeK9kfRqlUcfI/hxPkoRMdsSGxZn3P6wiOqScyYc
         KouXKD8nGYmbr7KnZtgGuY0QoBdtL3uNYeufOOhFjcb9FtUt4kA5LItm7O+kOEkCGim8
         k6hU2Dw497rhOpoWk95JLipVcoGMAkH20SUOK6cpW3RqcXXWDpAzY7059EBGikgGzGIK
         q0GyYqTycBzg0saaAb+ZnsOJvvgihnMkhZ0Vx1RC9bcgmqmqRypfWC56rc1yPd//BmiO
         Az8hbYnf2WCYgQHmJxUTy26bNXSPAtsYjFb7TwoJVUwXwf0NJ5vQNKu/aEJZkLfSCmP+
         NxvQ==
X-Gm-Message-State: AOAM532dlP5sRUo/xlJ1kBXr/oaBcjhWd1qdhca1jPaE68ZvU0FtKBxH
        yEUFWcxZrXJPF9eJITxWRLI5GJ6qRz/OLw==
X-Google-Smtp-Source: ABdhPJyu0XOQAXhrsadoGRl6tEwDHsF6fuWNB3GaU2f1mc6kRJEJpMt8jXtiC/wDZSAEdwoSHh5Eq/ndfjTVXg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:88c2:0:b0:510:543c:3f51 with SMTP id
 k2-20020aa788c2000000b00510543c3f51mr27490084pff.2.1652311325228; Wed, 11 May
 2022 16:22:05 -0700 (PDT)
Date:   Wed, 11 May 2022 16:21:55 -0700
In-Reply-To: <6e59a82c-22cc-8f0c-f7f7-94da59e8da89@gmail.com>
Message-Id: <kl6ltu9vy7sc.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
 <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>
 <deafd5db-6303-46b3-a5d5-b4117ba16781@gmail.com> <xmqqzgjnhf5u.fsf@gitster.g> <6e59a82c-22cc-8f0c-f7f7-94da59e8da89@gmail.com>
Subject: Re: [PATCH v2] pull: only pass '--recurse-submodules' to subcommands
From:   Glen Choo <chooglen@google.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Le 2022-05-11 =C3=A0 18:34, Junio C Hamano a =C3=A9crit=C2=A0:
>> Philippe Blain <levraiphilippeblain@gmail.com> writes:
>>=20
>>>>     pull: only pass '--recurse-submodules' to subcommands
>>>>    =20
>>>>     Thanks for the debugging help :)
>>>>    =20
>>>>     Changes since v1:
>>>>    =20
>>>>      * add a test that actually tests the precedence of the config val=
ues
>>>>        * I've kept the previous test; it has always worked, but it sti=
ll
>>>>          seems like a useful smoke test
>>>>      * reworded the commit message slightly
>>>
>>> Thanks, this version looks good to me. I don't feel to strongly about t=
he=20
>>> title either, so as you wish :)
>>=20
>> Perhaps
>>=20
>> 	pull: do not let submodule.recurse override fetch.recurseSubmodules
>>=20
>> more clearly expresses what it wants to do (not passing the command
>> line option is "how" we achieve that goal)?
>>=20
>
> I like that title, yes.

Hm, yes that makes more sense. The commit message leads with the bug, so
it's more consistent to mention the bug in the title too.

It's arguably more _correct_ to say that passing only the CLI option is
the desired result, and we just so happen to be fixing a bug along the
way. But meh, the bug is roughly 90% [1] of the motivation for making
this patch, so leading with the bug is ok.

Will reroll.

[1] The other 10% or so is some upcoming work with `git rebase
--recurse-submodules` and supporting that in `git pull --rebase
--recurse-submodules` :)
