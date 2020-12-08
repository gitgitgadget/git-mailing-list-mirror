Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8957FC2BB40
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5682323A53
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 20:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgLHUUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 15:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgLHUSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 15:18:15 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C13EC061793
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 12:17:21 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id h19so6174697lfc.12
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 12:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZlvqMx4/eRK4u7rzqp3nvG4T0CzpWkSYiHQ4tYYxHfo=;
        b=N41ksBBJIsxSsZAKfoW2VW5MKwRyYW0+/w/V7SF8+j6BOjy0pNcG2TdUV+fYMRXQBI
         o52BzZr97e7VUIa61W1vT1R8vIUkRDiSiClxsvpxv+U8E5CxcaK9W1GfcYoYyffkXgJY
         Ox9s/7cYYqt3js2TaTLdRnzqdP18P46o/KzN22+2Xw0U+1Ep3XGEApvGPl9rDk0V7N4h
         cGxYR/6VeWVDnTKvZleKyKtIo2jHivvycLHVG+sAVPp3f0lp3cMyMleaMgHUHMReHiAD
         6K0+jJNulHOI3dPhbSLJvtpPfkCUZXVkC84zmHtkfWpOlshm6a/5vHT5z+O1DMyDAeoH
         2LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ZlvqMx4/eRK4u7rzqp3nvG4T0CzpWkSYiHQ4tYYxHfo=;
        b=CczE/ZWSb1XPUWM+tlfCW8d5mqW7BdF06aIOaALz5vZNoiq0W98TlLpJPwZc3TqcNq
         L8HAZch/vGkUMQRlmfe17iw1yITEeCFskoQgTPHvqfeX0j7mNM5IRYfPKX3J6TTwH4E7
         PthMCIB3xhzmb7VEUvYi0OJE3G+cn2Mn7/a8VH8bokyzGWnrPY+RiLj0WOM8V6CyR/LV
         DdwwlFZ2n8xGxJoVjvD2unh6KobJ0tJneMoPqYFJprQSvI2USQCxRPP11qR2Ne8yOfK4
         YugT0dpi+PRW3m0WvQUAfoyJsFRS9ZI1zxo5mnWn4ob35RnbMq7kHT4v9rUBGPz6uO9V
         64aQ==
X-Gm-Message-State: AOAM530RJcBXb1JHwmqCMTpNQVKcNArnmDSjqFuZrpnHEudk3t6NpJU9
        D3+h4fWfCdMsWE69Uxct9OVVOVVbh2I=
X-Google-Smtp-Source: ABdhPJxnO65qdQEDdgmEU8gX5Qz9TSsk+dsOb4jEHh+sw1msw8n+Y/WdWE29ZAckRPLBnt5Xv2UFkA==
X-Received: by 2002:a2e:96d8:: with SMTP id d24mr1542670ljj.62.1607458058548;
        Tue, 08 Dec 2020 12:07:38 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id a11sm594422lfl.22.2020.12.08.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:07:37 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/26] git-log: implement new --diff-merge options
References: <20201101193330.24775-1-sorganov@gmail.com>
Date:   Tue, 08 Dec 2020 23:07:36 +0300
In-Reply-To: <20201101193330.24775-1-sorganov@gmail.com> (Sergey Organov's
        message of "Sun, 1 Nov 2020 22:33:04 +0300")
Message-ID: <87y2i8dptj.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:


[...]

> The series also cleanup logic of handling of diff merges options and
> fix an issue found in the original implementation where logically
> mutually exclusive options -m/-c/--cc failed to actually override each
> other.

Working further on this, I've noticed very irregular interactions
between -m/-c/--cc and --oneline:

1. --oneline disables -m output for 'git log', and leaves -m output enabled
for 'git show':

$ /usr/bin/git show -n1 -m --oneline 2e673356aef | wc -l
80
$ /usr/bin/git log -n1 -m --oneline 2e673356aef | wc -l
1

2. For 'git log', --oneline disables -m output, and leaves -c/--cc output
enabled:

$ /usr/bin/git log -n1 -m --oneline 2e673356aef | wc -l
1
$ /usr/bin/git log -n1 -c --oneline 2e673356aef | wc -l
16
$ /usr/bin/git log -n1 --cc --oneline 2e673356aef | wc -l
16

The question is: what's the right interaction between --oneline and
-m/-c/--cc?

I tend to think they should be independent, so that --oneline doesn't
affect diff output, and then the only offender is -m.

What do you think?

$ /usr/bin/git --version
git version 2.25.1

Thanks,
-- Sergey Organov
