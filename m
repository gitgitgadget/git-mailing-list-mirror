Return-Path: <SRS0=zTfj=4Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1A8C10F00
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 13:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDDB206D5
	for <git@archiver.kernel.org>; Sat,  7 Mar 2020 13:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="I8VoVREn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCGNpr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Mar 2020 08:45:47 -0500
Received: from forward501p.mail.yandex.net ([77.88.28.111]:59791 "EHLO
        forward501p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbgCGNpr (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Mar 2020 08:45:47 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Mar 2020 08:45:45 EST
Received: from mxback22o.mail.yandex.net (mxback22o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::73])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id 6FDDC350055F;
        Sat,  7 Mar 2020 16:38:45 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback22o.mail.yandex.net (mxback/Yandex) with ESMTP id LjFnnVMrQb-ci5Gqpip;
        Sat, 07 Mar 2020 16:38:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1583588325;
        bh=BBY0Oa5XU3AqVKOb4lfC9fkuDYpHKjcBQskzGvsnaC4=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=I8VoVREnMVtIbGOigMIzyJeYbY7uV9mJEQYertQRJgrLEcXKkZw9yA4q/A4eeI95A
         LVNePDTqm39UAh5KCyOAWRHvrc1unu67465FaVpImvJqNHZv0bn+15BQeNAm7RC4tS
         wRMYsseHVf1nwJHGWjrd2/yPtW3KQRG9L2TgbA5M=
Authentication-Results: mxback22o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-8444b3b8f5de.qloud-c.yandex.net with HTTP;
        Sat, 07 Mar 2020 16:38:44 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
In-Reply-To: <CABPp-BHk0TyxEgudMX_-zzpFsUPHCmRkvZezN_49J2ivi2-N+w@mail.gmail.com>
References: <CABPp-BHk0TyxEgudMX_-zzpFsUPHCmRkvZezN_49J2ivi2-N+w@mail.gmail.com>
Subject: Re: Git Merge 2020 slides and reproducibility
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 07 Mar 2020 16:38:44 +0300
Message-Id: <3165171583586403@sas1-2bf44b70450e.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



06.03.2020, 18:00, "Elijah Newren" <newren@gmail.com>:
> Hi,
>
> Had a few different folks ask me at Git Merge about slides for my
> talk. I said I'd post them on github somewhere, but in case you were
> one of the folks and have a hard time finding it...they are up at
> https://github.com/newren/presentations/blob/pdfs/merge-performance/merge-performance-slides.pdf
> and steps to reproduce the speedups I got can be found at
> https://github.com/newren/git/blob/git-merge-2020-demo/README.md
> (though be forewarned that the code is has lots of fixmes & ifdefs &
> other problems, has awful commit messages, etc.; I will be cleaning it
> up soon).

Hello, I've just tried your branch on my repository and it seems like it can
be a salvation from all rename-related pain that I'm regularly facing when
doing merges and cherry-picks! Thank you very much, I hope it will be
integrated into mainline soon.

However, when testing my previous merges which had to be done with helper 
script, I've encountered case of

CONFLICT (directory rename split)

Is there any way to prevent conflict in this case if files are the same, and
merge their contents if there are differences? I think it would be reasonable
to assume that move done in newest commit should win, and allow user
to change strategy via command line option, provide explicit hint where files
should be moved, or maybe even decide it interactively.

-- 
Regards,
Konstantin

