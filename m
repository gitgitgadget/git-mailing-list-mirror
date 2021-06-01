Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC3BC47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 06:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35E861375
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 06:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbhFAGZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 02:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhFAGZp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 02:25:45 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02556C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 23:24:04 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id j1so6702768oie.6
        for <git@vger.kernel.org>; Mon, 31 May 2021 23:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=PLo9U+x/jJYZnWKjDB/tvvmvhHwR+KJ+NIa7vmle+jA=;
        b=HVwW2L67mdhI5MuOuCt+T9sJvzFr+sDO6WDX6yodm5qkyj7ogokI8vO28rnGyU3n5/
         frJUn9rcwWd0FN4Pka91gOop7FIfzt0MYilomrlcsRXU4d/W10r1/sUwNB0GPqvY3/9l
         vOS5DvavZht75g1xvdXKPW1f6ekNbVicbJXF8SOd8XWyRKLRLoKfWxAoN5+cgG6OT/7L
         6QKXggJAjnyotL4FcSQFFjyfvS9nygQ1eayD7Hx2ww/31ERqRETmi5aL7BYJsXPLs+KK
         J56SfZjlLXvNQx3j2x6dx5XXdCv0d6Ga7yDDxsxlvEufbyU2ucid0L4kVF+Cq8qTKjtw
         2+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-transfer-encoding;
        bh=PLo9U+x/jJYZnWKjDB/tvvmvhHwR+KJ+NIa7vmle+jA=;
        b=L0WsT0haMA63465Uf/iaJ/EWIQkD/WoZHGkAtorI7ItvgDXVvQvgSh2dEu44l+Nc0l
         O/j9OL5K9q8FRNEt0iwqEMSPaCWrQ/HoGwdNjF2ZcdcPmPta+PEJjEV5PI90sL9M0EqY
         X04/DjV4nAPs+mHjB0wavtKy5aBzvJIyvBv92cXuQ+Zl0Dh+TsvcbKRV+FB1Lk5zbgGs
         tZ/E+EiI27WpH4P9w5BpAyB/ckc5KhrcyIlLI30AKRxFO82qsTARH3YWldnPaueCrzOi
         XGG0l6J9NUxI/WeiVgLRZBX0ZOl/VxqICuej4sctgczzqjH6UFIP3fvE7fZc8vADtaMy
         xwNw==
X-Gm-Message-State: AOAM532IFE+Vrfaf5GUO+nsigqRa3NU+ZTitzlKEQmDQBdnBEla1LpTH
        o+p5JmiWJk2psUX8IhWypwZs8dx7mHl3kQ==
X-Google-Smtp-Source: ABdhPJwqJ5crJge+Y6cSXaTy6N0bZuSfDVzKXrUvXmRkPHPAsxaqeXSaPfbNt17Gt/4sD7+x9EVOqA==
X-Received: by 2002:a05:6808:1448:: with SMTP id x8mr16474805oiv.148.1622528643020;
        Mon, 31 May 2021 23:24:03 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id i4sm3554580oth.38.2021.05.31.23.24.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 23:24:02 -0700 (PDT)
Date:   Tue, 01 Jun 2021 01:24:01 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <60b5d281552d6_e359f20828@natae.notmuch>
Subject: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

The premise is simple: git.git developers are experts in git, and therefore
they have fine-tuned their ~/.gitconfig to a point that is pretty far
from what any newcomer will experience for a long time.

How long can you survive with a pristine configuration?

Plenty of developers take many things in their configuration for
granted, they forget what the default behavior is, or worse: they forget
they actually have configured log.decorate, and are surprised when they
discover the reason they could not reproduce a bug report.

Now and then I cleanup my configuration to be reminded of that fact.

Anybody remembers merge.defaultToUpstream, and what `git merge` without
arguments used to do? [1] What about sendemail.chainReplyTo? [2]

It's important that we force ourselves to experience what an
unconfigured git setup looks like, even if it's just for a little bit.

So the challenge is this:

  1. Remove all the configuration that is not essential (just leave
     user.name and user.email or equivalent)
  2. Pick 2 configurations you think you can't live without. You are not
     allowed to change them afterwards.
  3. Every day you can add 1 additional configuration (and update it the
     next day).
  4. The moment you add a 4th configuration you lose.

Once you've lost, reply to this message with the configuration you could
not live without.

These are the configurations I've chosen:

  [merge]
    conflictstyle = diff3
  [sendemail]
    smtpserver = /usr/bin/msmtp

If if not clear yet, I hope by the end of this little experiment we will
have at least one configuration that surely everyone can agree needs to
become a default.

Do you think you can survive one month?

Good luck!

[1] https://lore.kernel.org/git/1296231457-18780-1-git-send-email-felipe.contreras@gmail.com/
[2] https://lore.kernel.org/git/1369453492-20972-1-git-send-email-felipe.contreras@gmail.com/

-- 
Felipe Contreras
