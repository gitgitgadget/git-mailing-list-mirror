Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DFDC433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE08D61056
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 19:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbhKJTh5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 14:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbhKJTh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 14:37:56 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E55C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 11:35:08 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id p13-20020a63c14d000000b002da483902b1so1981232pgi.12
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 11:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :content-transfer-encoding;
        bh=2KqZFYtJFUCYTpIEEenHB3RqfexKi0Nn9T2FriS+Qfg=;
        b=cPh1jtv+RemRDC5Oolje2aDc1Nsva8WRF83/eZPgO+uhmWSiGGf0QO1mOulJmFWnC/
         P8GFkoMVQGzslF24DpJbQoVqEsTcPE+jA0O9taSloBusgZjguPa+/8ze1bag3HGg7UE5
         MacE0ylSiiLyQIxJBVltOYTmn/xPcQdlJDx9Sg2m0SbpfTov2wbck9EFQNlwBM4xWbeZ
         F8R+l4aoRjQuNqcQBbQ9TWL8cVN49APajxcS7FSH0XulIdkumTKS8CQPAP+Z+tv0cD7H
         Yg8PgV7MBJEOV/D9kHVtB+0WmDmevR6Dwc3eNu+SMHZH/VZDdtQqUXWRVAiSTHazpRet
         wVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:content-transfer-encoding;
        bh=2KqZFYtJFUCYTpIEEenHB3RqfexKi0Nn9T2FriS+Qfg=;
        b=dfg0PXX1npwH0cmbwO4gXd6VJH6nHXEhooEjklFzQbaOyqh+5pA8dkvIMVzrtn6DUM
         mX6LyuCCrYZgGJNPfk2gmjxX9WkBh1cExwK2eyNbNjw56uDLSjyuiPjEiAxUW7vrBdzS
         jyNMZ/jV4WG7eugUa+L3bc8f6WSE7jMacBvP7ZjTjB9Ggzj5Oj2wQ6D+t27o7YnBoCW/
         yCtR569Bp0LvEQ5tVHuLC+nHCFZzzW/ORjfT19MfiXjXzKutx8uwvPsILAFg4KSSuHX6
         VCtsTV3oBs8JmMLJDCAYkTAYRm0sPvkZLUEjrUB/BXQhlycKkGdsA+jqqqr5mpiQR9JM
         EHQw==
X-Gm-Message-State: AOAM532ANEXuCJYW7CNxockUzvWIFinlV8dU3onko5BxEYCy7bQfQGXY
        D04jDTZ2XEOwVKpCpBmSOifwrMnZ0hSI4Q==
X-Google-Smtp-Source: ABdhPJw2DKdMGpeWdGy2S5jhj/DnOoIto+hantfMD1rrCnxCGss1bDum4HwJGk90R4aiaWVFbkmj/jN4BXOKtA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:74cb:b0:143:6fe9:ca4 with SMTP id
 f11-20020a17090274cb00b001436fe90ca4mr1381506plt.2.1636572908159; Wed, 10 Nov
 2021 11:35:08 -0800 (PST)
Date:   Wed, 10 Nov 2021 11:35:06 -0800
In-Reply-To: <000101d7d661$cbfa4fb0$63eeef10$@nexbridge.com>
Message-Id: <kl6lee7nvm6t.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com>
 <kl6lh7cjvpm3.fsf@chooglen-macbookpro.roam.corp.google.com> <000101d7d661$cbfa4fb0$63eeef10$@nexbridge.com>
Subject: RE: [RFC] Branches with --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     rsbecker@nexbridge.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overall, I think your workflow is not too dissimilar to the UX we are
proposing :)

<rsbecker@nexbridge.com> writes:

> 4. If working on the submodule, use a branch, not a commit - typically of=
f main.

With the proposed UX, step (4) would happen automatically when using
"branch --recurse-submodules". Users would get a safer and more
convenient default.

> What I could see as a possible improvement is to add the branch ref to th=
e submodule ref file - not replacing the commit but adding to it. I do worr=
y that there are unintended (unforeseen) side-effects that will result from=
 this, however, including potential merge conflicts. Two people working on =
the same commit but different branches may mess the ref file, so not really=
 a good idea.

It's an interesting idea, but as you noted, it is quite thorny. I would
also like to see more information being captured by the superproject
tree (instead of just .gitmodules), but I'm also not sure how we might
do that.

> Just my musings.

I appreciate the effort taken :) Thanks!
