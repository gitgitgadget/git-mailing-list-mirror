Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B977C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51AEB23435
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 16:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbhAGQpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 11:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbhAGQpD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 11:45:03 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59179C0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 08:44:23 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id p2so2456659uac.3
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 08:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jpPhS8ASyPU1K4Mjw7Lnwsy2i2BWPaFMhwFBOQgq1LI=;
        b=IxsMHrDQ33+gvyVjz+rJnfYpn7NOuhlXqWTTRgdPp1ToJ/b1NQSSGvdRdkVo0fegrv
         P2Vn1DSYE0ceqYoq4MVJ1h8IfMkuoSLLCzoQTZH9w4uMY1OKms3sEMCG2aQMSYaHIh7k
         NbA+8lZJYWRKo3H5iONswVpoyD9zxjbidB0/LOCHXG3Gmhf7R+i6Z10JSsBLEZfUpU5x
         LVt8hHj4saZsg8asz+oCwGVjlXAPK+tV2IvnY3ZxUFb21LdYUl11SfgJ6eGR/KytM1tB
         7tu6294iMKd6Qf4LJjVhHYDoKEcDWjKOmb7kRzxWXxsT7T4Vw+SyUI0LFODPVrlXn2A+
         Eoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jpPhS8ASyPU1K4Mjw7Lnwsy2i2BWPaFMhwFBOQgq1LI=;
        b=srBTvF6IwDf5NY5fR6JghWxH7mmmMGGRYy4Wi17ubyaVWGy220pIJO213IfYky0oaS
         mDoDYYPzrz4bPzKEaj6XWTA2EBwPx38czgHnjkAoEV7Jn2lYt7xAA42LRDNFn8YQalhb
         OCW5qJbXE+IaIEI5pojiYfVW3uGLNof6EUldKhjJ72OEVH3FygVyHLUZKFJww2S+7nt1
         h/QfE5rNZvTPV293CmkeektVuNId3MjHtM5lJs4kKGQCiqD5jy4z5GujDfgffIYCOR5D
         W2QHnmi/Rd0McXA7O+8OW78df1cFXPu7uKZKCXRSAcVQ5ngsyOHS5Jn2J+hNtckWsy37
         ZxRw==
X-Gm-Message-State: AOAM530ER9tbhN72D6tPWPR79lqaTXdfPKFqRL+m8vMrV7jQGQ4aMoUQ
        1Tqhsmh1w9dDOp9LBIpw7n6Ucg2KxpeGtY0vwQuAaefDGgFZFA==
X-Google-Smtp-Source: ABdhPJwylmZwtcRyUEMEiMG4cHfELNoQuEtWlFLzrQgmhTB+ZauUj3r0fFCniSWgXwqvRhN3rILyo/1HBH5w0Ndy2j8=
X-Received: by 2002:ab0:240c:: with SMTP id f12mr8206012uan.117.1610037862272;
 Thu, 07 Jan 2021 08:44:22 -0800 (PST)
MIME-Version: 1.0
From:   Jon Sagotsky <sagotsky@gmail.com>
Date:   Thu, 7 Jan 2021 11:43:45 -0500
Message-ID: <CAJamm=+Z=88G6cH3DRkttGQkrf9tng310+p=4cKiy-GvdCG3zg@mail.gmail.com>
Subject: Feature request - git add --patch should have an option to discard or
 drop a hunk Inbox
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I frequently make changes to a number of files.  I use `git add -p` to
select a number of changes and wrap them up in a commit.  Then I run
it again to build another commit.  Wash, rinse, repeat.

Sometimes I make a change I don't intend to keep.  Maybe it's a typo,
or some debug code, or my linter does something naughty.  As
described, I have to skip that hunk once per commit I'm building.
Usually this is merely inconvenient, but each pass through `git add
-p` runs the risk of me mistakenly adding unintended changes to my
commit.

I could use `e` to edit away that hunk, but for some odd reason that
feels too tedious.  What I'd really like as a small quality of life
enhancement is the ability to discard a hunk so that it's deleted
immediately and I don't have to skip it again.  `d` is taken, so I
suggest `x` as a shortcut.

Thanks!
Jon
