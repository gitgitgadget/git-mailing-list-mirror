Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE572C433DB
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAA160238
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 18:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbhBQSmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 13:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBQSmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 13:42:09 -0500
X-Greylist: delayed 97 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 Feb 2021 10:41:28 PST
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E7EC061574
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 10:41:28 -0800 (PST)
Received: from sas1-0c1ceed184e2.qloud-c.yandex.net (sas1-0c1ceed184e2.qloud-c.yandex.net [IPv6:2a02:6b8:c08:f80:0:640:c1c:eed1])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id 6926633800A0;
        Wed, 17 Feb 2021 21:39:48 +0300 (MSK)
Received: from mail.yandex.ru (mail.yandex.ru [81.200.17.53])
        by sas1-0c1ceed184e2.qloud-c.yandex.net (mxback/Yandex) with HTTP id kdh0w20IRmI1-dlIO0rQF;
        Wed, 17 Feb 2021 21:39:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1613587188;
        bh=nDtblCeagrRN5JN59UwtZxAyiVHe+qd2WJ7Ku9F/jHM=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=ICI62YlECu8NgAO3FyTGvPR4kNbGLe0YlrTDlTbphSbBOcKiv1ur+HPYWMnbp3Ggj
         aZb0ue3b92/vudWGCH+gNCtRt6/gIfb9of3glrQILcA9Yl+JYKzSngZOY2vs6f2kR6
         K+pQhCebjWoiRLMRhP9QvcK01VNOlz4tzXXTGLCo=
Authentication-Results: sas1-0c1ceed184e2.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas8-75f070ddfcf3.qloud-c.yandex.net with HTTP;
        Wed, 17 Feb 2021 21:39:47 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     Alireza <rezaxm@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CAD9n_qiN+qXqR79z_4d+_8_mxa9eTFB42sTUT8CTF8=oQArQaA@mail.gmail.com>
References: <CAD9n_qiN+qXqR79z_4d+_8_mxa9eTFB42sTUT8CTF8=oQArQaA@mail.gmail.com>
Subject: Re: Considering merge --dry-run to foresee conflicts ahead of time
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 17 Feb 2021 21:39:47 +0300
Message-Id: <526751613587054@mail.yandex.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



17.02.2021, 20:25, "Alireza" <rezaxm@gmail.com>:
> I have a half baked alias for this and it proved to be extremely
> useful even in this state.
>
> ```
> check = "!f() { BRANCH=${1:-HEAD}; BASE=${2:-origin/master}; git
> merge-tree $(git merge-base $BRANCH $BASE) $BRANCH $BASE | sed -n
> \"/+<<<<<<< .our/,/+>>>>>>> .their/p\"; }; f"
> ```
>
> Of course with large conflicts it gets less useful. Getting only file
> names from the patch isn't straightforward either.
>
> So my question is what are the downsides to introducing a `merge
> --dry-run` option and what would it look like?

As a git user, I would very much welcome this addition, and similar for cherry-pick,
provided they don't modify any files in working copy.


-- 
Regards,
Konstantin
