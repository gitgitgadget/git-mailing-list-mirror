Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C459AC636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 01:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBPBp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 20:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBPBp4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 20:45:56 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95655D2
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 17:45:55 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id c29so333954pgm.5
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 17:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxBgU/1DarP+ITC9ariijlksTe30PxW/BqwHfeXtYtc=;
        b=o9zqHIZB1yDxJ38wrDVilJFMCknqnFp0UyDVrZ3xYJVNMCATH5nnMbtOu/w1XWI3SZ
         zQf3LQoeRT6veUw2aCog9iJdVUmk+xt4BIHDmuUyWTfJdNVcb4kIpR3017lAvrCnZV8T
         kCgIUHyqPz0AJ+4ix4PFLjl6SRrX5WflhbYYpeQy9o288/5IC5ziF/pdgjDa53UfHxeE
         +xbEarg/lL0T344gvpoLWjhu/4+6Eo/nztYsW56juxkXzMslA2dO9VqBi7ayO25FIWuY
         yeGNUwW1ORaR5etZ8RIO2Y4dPzBoNGUzesygAptmoRkPZuUaddpiAOiBfciOjyWBwHWK
         ioMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dxBgU/1DarP+ITC9ariijlksTe30PxW/BqwHfeXtYtc=;
        b=F1Cyr9ZicCwABT0Gbey4290Ebr++CRz9ZLL6Da7g9drLivvEECD8MHNJFQbx0vSRcx
         lZKxHA75wun63H7P5+tjrkGhFOptlmJrd60DjX+YSmK7WTai96oM++qd6ScP06fAM352
         SZ4zDEE6jQmoded0/FCJvnmZgrXLBrKx6I0vnKv2KBnGTVGazYf2DiqlR+Sv7KBN6ht0
         uvIvizqLQm9cPJ8xhg/lhi7AAtAUtJFsB+5iBsByK/+5DFlZGe/6WGrDtbSrzzQ2gJRf
         OaWjqvNEq+6u1rQR9JiJBuvLJ1zVmcC6QNoCdcvPYFBSOoWfenE64pkvjea6/HM2+TjL
         lJHg==
X-Gm-Message-State: AO0yUKXD3fjbkNJQpRcBqWnSMj58+Xa9NhauG+Sc5S7qxJ59RWIQkYMd
        GbfQV1Ao4aTuGU4hmjdrH/M=
X-Google-Smtp-Source: AK7set+ttcHZ1VlW6dEpLwz72wVnVaA6t0RkO7/RR/KFpgvmCm1xBWbopoFkxDD1WKw9bnG3vKdBaQ==
X-Received: by 2002:a05:6a00:150c:b0:5a8:d438:c72 with SMTP id q12-20020a056a00150c00b005a8d4380c72mr646191pfu.5.1676511954925;
        Wed, 15 Feb 2023 17:45:54 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id j26-20020a62b61a000000b00592626fe48csm8558pff.122.2023.02.15.17.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 17:45:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     rsbecker@nexbridge.com, 'Git List' <git@vger.kernel.org>
Subject: Re: [Bug] Test 1450.91 Fails on NonStop
References: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com>
        <Y+0eIlsIxRr+1RYp@coredump.intra.peff.net>
        <000801d9416e$4bf844b0$e3e8ce10$@nexbridge.com>
        <xmqqwn4iycbt.fsf@gitster.g>
        <Y+05tTHdj2Jzenge@coredump.intra.peff.net>
Date:   Wed, 15 Feb 2023 17:45:54 -0800
In-Reply-To: <Y+05tTHdj2Jzenge@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 15 Feb 2023 14:59:49 -0500")
Message-ID: <xmqqwn4itmb1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So yeah, this seems like an obvious good fix. Using write_or_die() might
> be even better, as it would report errors rather than quietly returning
> non-zero.

Maybe.  Let me cook up a version with a proposed log message.
