Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3636C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 10:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC9E20776
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 10:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="py3HnX0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgJOKBE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgJOKBE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 06:01:04 -0400
X-Greylist: delayed 343 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Oct 2020 03:01:04 PDT
Received: from forward500o.mail.yandex.net (forward500o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4E7C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 03:01:04 -0700 (PDT)
Received: from mxback11q.mail.yandex.net (mxback11q.mail.yandex.net [IPv6:2a02:6b8:c0e:1b4:0:640:1f0c:10f2])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 007D7608D4;
        Thu, 15 Oct 2020 12:55:18 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback11q.mail.yandex.net (mxback/Yandex) with ESMTP id BM58ylNzEP-tHgagJgO;
        Thu, 15 Oct 2020 12:55:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1602755717;
        bh=ScTVaHmoTYw/Y+amlXA7eS8wChAsVSyYWFacgo1CTj4=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=py3HnX0ZYSdZKaeaB6rzjTqoX2ohEM60yieG2G4oj4YCIaPue0kUx4IMmH5D51yaL
         Qt7kHfZHkxA0QbNUarPyDSbbe18O5xZBPAqJCMoF0qVCS2v2wdTnfKoV6EpO1C41P1
         GmN1BYb7bRt5D7VUczD1GCd7rj/JzxO7zVnzLSxY=
Authentication-Results: mxback11q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla1-fadba9086fdf.qloud-c.yandex.net with HTTP;
        Thu, 15 Oct 2020 12:55:17 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Leam Hall <leamhall@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <595540a9-0000-8dcd-c555-3168d1b2d066@gmail.com>
References: <595540a9-0000-8dcd-c555-3168d1b2d066@gmail.com>
Subject: Re: Branch Management questions
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 15 Oct 2020 12:55:17 +0300
Message-Id: <2011231602755586@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



15.10.2020, 12:51, "Leam Hall" <leamhall@gmail.com>:
> 1. Two developers.
>    Dev A is working on Branch A, off a release_candidate branch.
>    Dev B is working on Branch B, off the same release_candidate branch.
>    Branches usually run 1-4 weeks.
>    Dev A does some work that would help Branch B.
>    How does Dev A get the Branch B work that is needed, in a
>      way that does not confuse the merge process at the end
>      of the release cycle?

Avoid long-living branches and integrate atomic parts of work into base
branch as soon as it's done and reviewed.

>
> 2. One developer.
>    Working on Branch P, realizes that a new functionality X is
>      needed.
>    X isn't specific to Branch P, but critical to it.
>    What is the best way to deal with X, knowing that further work
>      on X will need to be done?

Rebase P to the top of parent branch after X is integrated (see above).

-- 
Regards,
Konstantin
