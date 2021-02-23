Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A40DC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C629764DE9
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhBWCCU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhBWCCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 21:02:16 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D956C06174A
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:01:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l30so5316408wrb.12
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dQLYC/oOygnlcSu9mWRkApHAialolgMyk+ESOoiBzeQ=;
        b=SWCTNRniWjlbx1P3TgPRxs7rmDBch5r6mrPEf135EA0oP9MmFtCVhD1bSLfGXR9mjH
         W4mkNXVYpY6KKpoy+3AFXVpsZkz/ZzafklZMfX2+f9GKiDHwxUrgNDlxLzkTp/4mPub9
         6d6US3HWWNViBAX6CnAvn85i4uiFJnI6LIdMMaDYRsfQomGX7sI4Rmnx3n5EBG+WYd2z
         xk9/S/mQJzk1XbNLPgZi/tTRklcfgvy9emqTAR4aMTcVtiBdDvzWCKIAn0hAVDyAY3Gh
         Yd7dz3fxqF2da+65At/NhMAHYHp7KEydxjOeT43Cs439VGLYQtr9BOjY4yGY25Jw9iPZ
         PmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=dQLYC/oOygnlcSu9mWRkApHAialolgMyk+ESOoiBzeQ=;
        b=gYRwy4pRnd295YK5YIl6HQ1cW9y+LaPfeCtugatkbHQTZLRnDidIABZP7/lJQEuxGz
         LIefJMJUx1Z5HVEoDPE6KdHIRT5mjaenk5OFc+rUyeATB6RaZkiMgqhE+2bzbh6HlyEF
         OZqruPQM2xELbx/r3cVMf3RkVWfyjO2E+E/659ESHS79AGodouDlnTLtZEx4aalCVcC+
         U0bwC89cbBLTO3MnCRMvqtnVq9kK4f6nqIK7sRfHzFrpHRkx4xRtcWYoa4UCINzzzqzB
         cIkEpFY7VB6Sw93ZC3xv/2orz0ndEXJgqQ4kQTOQ16blBfS4OvY6NJKIH2IsjBNO+qNP
         /SMw==
X-Gm-Message-State: AOAM530gOWgyz+sOTtrJQcEwnVMKUXIox/nbWXl4oMr7q6cN3Gpixifw
        Ei7zpTLdY1a7cDx/QPwo+GKKiSnjxsk6HWSDQ1u5/ODTzPA=
X-Google-Smtp-Source: ABdhPJyUjXB9FAXfMhwFZ30IBekSTGzHdKOOWxv1Ycu2HS+IaWQpF/ZXPBtgUYugtcRbR3PhawNhRr0KRJl0WxBIeSA=
X-Received: by 2002:a5d:60c8:: with SMTP id x8mr21835722wrt.227.1614045695166;
 Mon, 22 Feb 2021 18:01:35 -0800 (PST)
MIME-Version: 1.0
From:   Clement Moyroud <clement.moyroud@gmail.com>
Date:   Mon, 22 Feb 2021 18:01:24 -0800
Message-ID: <CABXAcUzRhkeQhVtwtx-NBR0hbkoo=aCTwN464Dsj8680GPMDxw@mail.gmail.com>
Subject: 'git maintenance' won't work on bare repos
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Because we have a fairly large repository, our developers rely on
worktrees created off a bare mirror clone. I'd like to enable
maintenance, and since the worktrees are rather short-lived instances,
we cannot point 'git maintenance' to it.
So the proper solution is to do it from the bare clone itself.
However, 'git maintenance register' silently fails (with an 0 exit
code). There are two tell-tale signs:
1. 'git config --global --get maintenance.repo' returns '.'
2. There are no Crontab entries inserted.

Running 'git maintenance register' from a worktree created off the
bare clone works as expected.

To reproduce:
git init --bare test-me
git -C test-me maintenance register
git config --global --get maintenance.repo

The workaround, for now, is to run this from a worktree, then use 'git
config' to reset to the corresponding bare clone location.

Thanks,

Cl=C3=A9ment
