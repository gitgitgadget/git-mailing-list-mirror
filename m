Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E88BC433E1
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 21:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 738732074B
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 21:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTAOECh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgFKV0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 17:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgFKV0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 17:26:25 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7789C08C5C1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 14:26:24 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x22so4333610lfd.4
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bDlxOJbdeZgQKXsXMqxtwCvPUJjC5jo8lcxd6n9pgxo=;
        b=KTAOECh1fRJ4zLoZc+SKpxfPPyfG66VKh0OAuhGwdMAXPU6prC7DrnVQJ2S68WDmXL
         UB9EHPaTo7hPPCzvAHCPQTXDkla6PCc7YZUfu47v4XsuU9WOp8c6lNY9eKtKRLAfOWf5
         5UpcJWQ/i2zG4NT8pGIDlUtTwLKNgAbotCgaJ+Bp5wriXqkkBH0VlhD6TP4g71GFedVM
         jpBryJTlnmzZGqcKJjrdxuxiz7cvr5gXGY304TE3nFNfKsevKfLicBeQH1XCfkxnRkbq
         EcaejegLn6vA0fgOzFNS241+Df03I+cnkqeqf7WdjzsaIO1PTu5M9En+tWbGbExdLTp5
         xs0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bDlxOJbdeZgQKXsXMqxtwCvPUJjC5jo8lcxd6n9pgxo=;
        b=puevxNsqgKMty1Gf+SIYzFbeQ2fCEXqfVjPuJRogeFO5iWsTvsd18sEUk2M9fa3oOy
         KeRFc3jiKUX/cPMa2gjCtmfcTcSNUv81hyuc20e5ja0rBelN0cC4zNGwxrVGb1YvgaDK
         VK5AJf3W7sAlQFBPha5pltR91NAP5t9o5VZQS/THhtwDdBvfI6KUtBDaBzsQ31bFEa9I
         GpX+LjKV7dsNPXFvrFfk5j1OaEjO5oYFEKdRpT4Ub6sNEvSDJYHwyzbLdHa/bXC7uj+b
         t1gM0pO48TEkOFdcQ6Oj7GX40fksOMv0MJ1LIXdiJ7zKouSpt84HhPeYX7SYx8uVo4ZW
         JKZA==
X-Gm-Message-State: AOAM532fi03JrXF+07xcKvD9npf7LFvoXj5tdKFWIr1lRhoI/omr1sQW
        +0zrK/+Aho3W07fhqN2FPteePwjfxWXlAx73JlBxi0xKzZU=
X-Google-Smtp-Source: ABdhPJzsyXxj4+/II9YDbG186r9fpOgzay/n3XmT5CX99sefu41RZQpZ25f5QEKeLGT/jfLMnFa0rmB1SSY+Ib9qCxE=
X-Received: by 2002:ac2:51a7:: with SMTP id f7mr5063308lfk.13.1591910782115;
 Thu, 11 Jun 2020 14:26:22 -0700 (PDT)
MIME-Version: 1.0
From:   Shreya Malviya <shreya.malviya@gmail.com>
Date:   Fri, 12 Jun 2020 02:55:45 +0530
Message-ID: <CAEqpqjGNANrCX0wMDUP+dZ+_PdMveSJf6XFyiCpJdUH5t6jXvw@mail.gmail.com>
Subject: Question: Setting the Email Address in ~/.gitconfig
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!


I was playing around with git when I realized that it's possible for
me to commit something to a repository as another user (explained a
scenario below for a better understanding of what I mean) and it is
not considered a security vulnerability, understandably so
(https://bounty.github.com/ineligible.html#impersonating_a_user_through_git_email_address).

For example, let's assume I have push access to some repository called
AAA, and my email address is abc@xyz.com. I can simply edit
~/.gitconfig on my system and set the email address as some other
person's email address: def@pqr.com. Then, I make some changes in my
local repository and commit them (reminder: it's with the email
address def@pqr.com since git tracks commits by email address). Now,
if I try to push to the remote repository, it asks for the username
and password. I put mine and since I have push access to AAA, it goes
through. I've successfully pushed commits on behalf of the owner of
the email address: def@pqr.com.

So basically, in this way, I can impersonate people and add commits on
their behalf. BUT AGAIN, this is not considered a vulnerability (link
for reason attached before).

My question:
It would be much easier if git didn't allow changing the email address
so easily. Why hasn't git implemented OAuth, or something of that
sort, for every time that the email address is changed in
~/.gitconfig, yet?


Shreya Malviya
