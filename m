Return-Path: <SRS0=mvrS=AI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BA0C433E0
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 22:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDDC20768
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 22:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcogsTtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgF0WrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Jun 2020 18:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgF0WrT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jun 2020 18:47:19 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0D9C061794
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 15:47:19 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y17so4284492ybm.12
        for <git@vger.kernel.org>; Sat, 27 Jun 2020 15:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dSgJWWkMlRJYs2Yc85KJ3TaGWJ+u9OSULGPzqcfaEMM=;
        b=tcogsTtFl2jDob4fpUweGf+ocC+eE9EOHPeDIG8+XEoxWnBQxOLh/dekEoN5sF0zy9
         IlVlPEwQazpBzTqC7i2MwZlOZsltIMVZPtXoudwertzpLPELE9Gl6mLRnA3/vex0AC+F
         Us+dqrfUB7m5ZCLLufHTZt+A7KgzyKItDw9nojcX8Sh23y9GaFXVBoEKcNrPNRslzBq/
         Hq10w3ljSk2nHMMWV6apEZ+jGMVXCY1Y2s+OR3kKEbpEOS7mbuJFKgba2V3NwemaWg7J
         FAsKi+zv9IHOZAN+/GYWFDNrn5n4KcYEDEBQC3UwJLXJ2unvub5R4GFYwQhOuN7thZk9
         2mCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dSgJWWkMlRJYs2Yc85KJ3TaGWJ+u9OSULGPzqcfaEMM=;
        b=RxJsYY/RJ0ZiqzSgGTIXKglyBvS4CkZoLjAImhJEO1MII8E1zsgscO9fbwYdaLec5o
         AQIcNzCilxWG5FESsp9YJesJ4S1rHBBCdg1carcokuLRsOjMzcd7xLOBEPF5SwQrYKVs
         VmLZDWwHWqjPAKOwMU22g5ygziKz5C6KPn0qyTkWTus8PDSkx94f0kHieXW3LVPX4IMO
         igyq5RWYoY80o58fGF8TeQPTkq+f0r9+viOp2enSQnUEW8GBdKF5Z+x4sWPnyJeZcvAi
         zrsl/O6+QtbLx8pyz+x9EA6zM2jzcgqO7d3qZfSrmoDvu76QDuJIJK3icwSwzzEjDAlS
         N2ig==
X-Gm-Message-State: AOAM530D5E3LJEKp1uuRNFGj4SB82nqqE7C8wSjAkBkCzw4e7QYFARZS
        kV6wz5D2J2i04+BLDEDB2iMZtS7huWhMz4HU6V7hYG9X
X-Google-Smtp-Source: ABdhPJzYx2YmyuWFrJ2sR+PJVvKiU+BjehZCVdicSAbXiJp/gv28/290lLt9hmsqLXN9wbECQDy3zG3QjzsQCG9NT3M=
X-Received: by 2002:a25:5504:: with SMTP id j4mr4790668ybb.469.1593298037643;
 Sat, 27 Jun 2020 15:47:17 -0700 (PDT)
MIME-Version: 1.0
From:   bruce <badouglas@gmail.com>
Date:   Sat, 27 Jun 2020 18:47:06 -0400
Message-ID: <CAP16ngrfrvXxN=xwFDmqnY6z3sXwG+Lqsh_9JyECdVJ_f8hrzQ@mail.gmail.com>
Subject: "gh" question -- perhaps off topic
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I realize this is more for "git", but maybe someone can point me in
the right direction.

Running centos 8
When installing gh, used the
https://github.com/cli/cli/releases/download/v0.10.1/gh_0.10.1_linux_amd64.rpm.

yum install -y gh_0.10.1_linux_amd64.rpm

gets the "gh" cli installed.

However, there should be a
~/.config/gh/config.yml file <<<

I can't find any process where this gets created. Should this be
created/inserted by me?

Again, I apologize if this is off topic!

thanks-
