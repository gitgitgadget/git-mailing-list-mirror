Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF22C43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 07:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiKHHhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 02:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbiKHHgu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 02:36:50 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3634317C6
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 23:36:41 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id b29so13036524pfp.13
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 23:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoOBDY7O3Iorq+482FZXgP5W67Srd279xS2M/eTyBkc=;
        b=AM8/Km3d5kfmBwDqIwzQsd60rXq8pjgcprrfRwdLk27rq2rFQPQ9uUilAkj8fxYBSg
         4Vv4y/EYLBKmfKgfyu7GxlAes/El4xaxuOXw1Zi6WADlxaXbivbznviFQIwEJFRhDL0J
         ed9126b2w00lyLndb/2iuPIDA6vEPd1hcxSlGD8bnEM6qns0YCv4kqp66wpLGyWqA6MK
         83FZi9fYP+m8png7sXCrfbJDN20dqAr6NNvzro40JjOq4zKiZyXEBTjbaEb4USreGSkP
         vX7nFdx7xfbSno7Y+STUPb7yPkhHHpY6fpwfsE01wh8HC1mkYQLnZ5L/k95zLy3bvVAq
         kmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZoOBDY7O3Iorq+482FZXgP5W67Srd279xS2M/eTyBkc=;
        b=UY9HKSJsEGdSykg+0zacZ5D2hlsmI3gngcmyBxbtDb6VeVXecMPw+b+tX5dhe2I+SK
         7dAAjjC13fyhAk/IxsUcnNEYF83eOiQC2gMHX7LjXTjgQh8Yi9a9fVXtYsW0UM6k7BcE
         26OuistvVHVE6ilgLZMGeDpvIrx4uyN+8vzgJWbDzZjCJkJq5YiSJcc4lHHzY1vfLCvU
         vhGWhiZu6dpfRA902QweidfMYpwxiH6Tu554DlY9labu+qoKKrqewbZSro3ALJbO3ctu
         naocmCvj0Vuepd/WsPDyE7fDTx0CT1TUWfzbzSNZlN0ThjhNOA5E9iDszCzaTfeWTQ62
         +FKQ==
X-Gm-Message-State: ACrzQf1FL/YXJE4dwcJ/njVJlSFd37mT4of4QLI/rKA7PjsoZ6u76z0h
        7uUItQEbUBYysNYuXOOIjn8=
X-Google-Smtp-Source: AMsMyM7Mbs5msCIYQJl51fWPCfRSljpj1D40FcxTyAX63qrlKvSWaJZFn6NTvp/ewvkrnp7tZktTAQ==
X-Received: by 2002:a63:1e21:0:b0:43a:b17f:cd13 with SMTP id e33-20020a631e21000000b0043ab17fcd13mr46541347pge.553.1667893001240;
        Mon, 07 Nov 2022 23:36:41 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902bd9700b001784a45511asm6202858pls.79.2022.11.07.23.36.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2022 23:36:40 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Date:   Tue,  8 Nov 2022 15:36:34 +0800
Message-Id: <20221108073634.19887-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.382.g8ae58934a1d
In-Reply-To: <Y2l86Cvbv8nSlN4X@nand.local>
References: <Y2l86Cvbv8nSlN4X@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

* Actually that's my suggestion, because I found when I use "git notes appends"
to append new content to an existing note. It will always insert a blank line
between the existing and the new. Does "append" represent "a blank line first
then the content"? If the user does not want it, there may be no way to
circumvent this on "append" at present. For example:

--------example start-------

Here is a commit with notes (from a openstack community repo), the notes is as:

commit ...(HEAD -> master, origin/master, origin/HEAD)
Author: ...
Date:   ...

    .....
    Change-Id: ....

Notes (review):
    Code-Review+2: yatin <ykarel@redhat.com>
    Code-Review+2: chandan kumar <chkumar@redhat.com>
    Workflow+1: chandan kumar <chkumar@redhat.com>
    Verified+1: RDO Third Party CI <dmsimard+rdothirdparty@redhat.com>
    Verified+2: Zuul
    Submitted-by: Zuul
    Submitted-at: Wed, 28 Sep 2022 12:58:46 +0000
    Reviewed-on: https://review.opendev.org/c/openstack/tripleo-quickstart/+/859516
    Project: openstack/tripleo-quickstart
    Branch: refs/heads/master

So, if user wants to append this notes, actually will add a blank line, maybe a
surprise. But I may not represent most users, so I added this compatible option,
maybe better to let the use choose, then send this as a RFC patch.

--------example finished-------

* Another reason is, I found that if I append nothing to a commit (here on my case
is HEAD) which doesn't exist notes on it, the output "Removing note for
object" shows something a little intesting to me, because there is no note to
remove, that's what 2/3 does. The following are specific examples:

--------example start-------

➜  git-notes-test git:(tl/test) ✗ git --no-pager log HEAD -n 1
commit d5a0127568e89239bb02f78d44dfa0427e726103 (HEAD -> tl/test)
Author: tenglong.tl <tenglong.tl@alibaba-inc.com>
Date:   Thu Oct 20 18:09:16 2022 +0800

    111
➜  git-notes-test git:(tl/test) ✗ git notes append -m ""
Removing note for object d5a0127568e89239bb02f78d44dfa0427e726103

--------example finished-------

Thanks.
