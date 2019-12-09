Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE15AC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51CE2071E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 22:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfLIWuc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 9 Dec 2019 17:50:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51760 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIWua (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 17:50:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id g206so1113157wme.1
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 14:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h4qZZBd3EM8yBizXqLLIVxaabh+ANMLKnYkRrtQ7GM0=;
        b=hPBR21+Ek46oXeUkfR9VFuoIorIycP4hu5Pu1Cmlo4328ZLatrx1ulb6lmWQH6eBzf
         kZ+A9DQpGTeO/v9yWGeKvfb0CADHFpKeO1ec/gus1l3mWG4tkhEkfsIePGjTCRdeRrAL
         LOD96htRmtKeyB4SHnj5C77ZwdVKsGfuGSB3BUmIRuHqFxIFb51KqW/+lP9Pyl7EvK8K
         laulOScTTSDZIcVaDwecK8TA0JGhuJD1GhTJ0oNzd0Kkoh9LSeTMcWk/lCgCOnn2jMDl
         AyjzT0MUCm9FIah6FND8kXo/hiZmyr2Y+a6LhWlEy45iIaq2BS7AfVJMhCiBYGNT3Dcr
         Nrvw==
X-Gm-Message-State: APjAAAVr91aQIE0hgkXjQBh2ukBU+u5ByvXZ02iuuJmkH7NEnbJ8wpxA
        Nvzz5bMw9+f35NkoOvL75AJQHpvO+Tk1s34jgnE=
X-Google-Smtp-Source: APXvYqy7hLJUGcNhLuYjEjbcCSyfrmZDL2RgiebXM5EwUWr9V6Fr9D4WQ/ODsef+fHEJ/57fU70YTedljSm7qEqjHtk=
X-Received: by 2002:a1c:1b88:: with SMTP id b130mr1419387wmb.4.1575931828402;
 Mon, 09 Dec 2019 14:50:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.483.git.1575466209.gitgitgadget@gmail.com>
 <pull.483.v2.git.1575901722.gitgitgadget@gmail.com> <e65375c528bdcdcc928dce8159edfccddcf77070.1575901722.git.gitgitgadget@gmail.com>
 <xmqq1rtdt9rc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rtdt9rc.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Dec 2019 17:50:17 -0500
Message-ID: <CAPig+cR2=LZtsMtAR-0b5mvL6B161eGyM5th6CM3TQxLYmifxg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] "git lfs" allows users to specify the custom
 storage location by configuration variable lfs.storage, but when "git p4"
 interacts with GitLFS pointers, it always used the hardcoded default that is
 the .git/lfs/ directory, without paying attention to the configuration.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     panzercheg via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        panzercheg <panzercheg@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 5:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> >Subject: Re: [PATCH v2 1/1] "git lfs" allows users to specify the custom storage location by configuration variable lfs.storage, but when "git p4" interacts with GitLFS pointers, it always used the hardcoded default that is the .git/lfs/ directory, without paying attention to the configuration.
>
> Oops, what happened here?
>
> I wonder/I wish if GGG can be a bit more helpful when seeing a
> commit that looks "strange".

There is an open issue[1] regarding that.

[1]: https://github.com/gitgitgadget/gitgitgadget/issues/120
