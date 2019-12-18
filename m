Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAF4C43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A719C24679
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 19:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfLRTeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:34:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34844 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRTeT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Dec 2019 14:34:19 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so3572853wro.2
        for <git@vger.kernel.org>; Wed, 18 Dec 2019 11:34:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mbv/hmAm1K9EmUuhdb4oi7Drcc2H1Wz7UPzggdTWW3I=;
        b=Zu5hF3VAt0FAPExETTUhacZxxMSp+oA9DKb5xRtDaXENQVsBiwcssz9Lt2ywxhOdFz
         e4Zt/mEnuYIR5flnys07axgV8jejGKNCL/Z8tvvFOWdp0pg1XnVdNFNwuVigrtfXCRYO
         EYpft24vvmN3PKUerLd3WSRVtTUPscJhCd1B+vG7PnBBorU7ZDsh3EBH+tge8qoT+S+v
         56Khrg44HSY0r3DUSwcG/blxeBsDRWj7zcQT1Zh3TbEtwMJw2IQmEQUpY3RAPBNKC+g5
         uu4oP/WlaUVg2f5fbQo61dhENUXVbuo6Iid9ENLCf5b9bC2ksuwqTw6WTNEL9LV8+XSR
         CDPw==
X-Gm-Message-State: APjAAAW0td3pc2KgxaG/73gDLK6bPx0TWYYXEDk/RxFty4fjA3KsH2Cq
        oF6h9o3OopOeypjsYbIgGv7H7XXtFIP6Td4i9Ch0jnF5
X-Google-Smtp-Source: APXvYqx29xofpzxVjIKhJt0u1X7OFFcHJ1lvrGdtCZf//4Wmft6LI9UJXDUhVX7A1+RITTg1xCOkR66ZuDH3LZ88/Rc=
X-Received: by 2002:adf:f18b:: with SMTP id h11mr4528050wro.56.1576697657799;
 Wed, 18 Dec 2019 11:34:17 -0800 (PST)
MIME-Version: 1.0
References: <20191214161438.16157-1-me@yadavpratyush.com> <20191214161438.16157-2-me@yadavpratyush.com>
 <20191218193129.hnvaetebih4y2slt@yadavpratyush.com>
In-Reply-To: <20191218193129.hnvaetebih4y2slt@yadavpratyush.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 18 Dec 2019 14:34:06 -0500
Message-ID: <CAPig+cQjL3Q0JFFK86+5Ee_-g_gmuiAD8f_kx5Z5NxG2ZEP7+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree: delete branches auto-created by 'worktree add'
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 18, 2019 at 2:31 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> On 14/12/19 09:44PM, Pratyush Yadav wrote:
> > When no branch name is supplied to 'worktree add', it creates a new
> > branch based on the name of the directory the new worktree is located
> > in. But when the worktree is later removed, that created branch is left
> > over.
> >
> > Remove that branch when removing the worktree. To make sure no commits
> > are lost, the branch won't be deleted if it has moved.
>
> Ping?

I scanned the patch when you sent it and will have a number of
comments to make when I find time to review it formally.
