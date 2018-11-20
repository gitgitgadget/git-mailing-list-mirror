Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038901F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 06:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730621AbeKTQgr (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 11:36:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42481 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeKTQgr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 11:36:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so462435pfr.9
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 22:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R5Q7egNvFWSAG4whZ4zqy6GbXbTzmBOrAmoSslw6SFY=;
        b=abpRdm62bh/RL9+jDAW1GaAKyECOKN9M8aKibg2+Wz1JwKgCSCmIDsKJvzA1pp3n5H
         FglBLSgAIvRBHr0X8Nfgg0uQEifvjV3024NTa500aOix6+etlwg0mwAmYvWNiE+Igr4q
         RmG5mXV0THHhQSoVSCyzPoDmpwkIGN15gNFiP7h1mCmR5Z1DeW0QQ7Zbu7zT3dhE9mSV
         bbPmyhwwGynJ8NFmYBjsLpVyz8wr2+HAdiWs5yzVedsYVaA59qJkC0RtQ+qECBVFya4U
         iZOJluvIKXbvS4E1gYpLYpWu17At2qFpaVvY1Qti27Z3yUKAyrzeSCsgq/90lp1v6qx1
         8i4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R5Q7egNvFWSAG4whZ4zqy6GbXbTzmBOrAmoSslw6SFY=;
        b=IfejIalI9jtlRKogRuv+FR8r92ta6i3v7SsP5ZTbneuXOWDvVGQWctJ8Kkyzo9mN0v
         VAYKZyOODhJnxhmXtzOAOj3bmSMQIRrOyigGkTICRX68mYFwmYAZP+f3UvT2NiAAJGOo
         tkdVGLDTYBudNzyq4Z1EF5GvvYgb6T+YZFfdE8/MhF4TtgecaAvig2Uttsbf2isD/Ird
         k8C3visqCVpFftETO8G5m5Dwmz9+wxgeE7Ao78oB9Y90W9BWmWPMWuXh8eSxmeoy5oBg
         7QgW8Wvnix7vFMDBFXbY6iVVmyYW9fLiABAMbtJRkmItMS0wb9ivsV+cLJ3LzM+CpCwo
         YbCA==
X-Gm-Message-State: AA+aEWZGEq7ogteyZT49JIraTDg9GQDUyGgVPgJOPIUd2tJWgKIfI+F8
        VkSrulQIetOTo+A277P1B2ndjy6G
X-Google-Smtp-Source: AFSGD/W6WRspldTfQPXQG6fuyq4Yi+0TIrsZpYfaWrR4zZ+iCoHVNSdmC2l38OqUNowUc1MLSaB9+A==
X-Received: by 2002:a63:ef0b:: with SMTP id u11-v6mr722056pgh.283.1542694163370;
        Mon, 19 Nov 2018 22:09:23 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id g15sm100919171pfj.131.2018.11.19.22.09.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 22:09:22 -0800 (PST)
Date:   Mon, 19 Nov 2018 22:09:20 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>,
        jonathantanmy@google.com
Subject: [PATCH v2 0/5] Avoid confusing messages from new index extensions
Message-ID: <20181120060920.GA144753@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:

>> Why introduce a new setting to disable writing the IEOT extension
>> instead of just using the existing index.threads setting?
>
> But index.threads is about what the reader does, not about the
> writer who does not even know who will be reading the resulting
> index, no?

It affects the writer, too, since it affects the number of blocks, but
from an end user's point of view, I agree.

Here's an updated version of the series.

Patches 1-3 are as before, except that they are rebased to avoid
conflicting with nd/config-split.

Patch 4 allows enabling the new index extensions with a single config
setting, to address the feedback above.

Patch 5 revives the noisiness when encountering an unknown index
extension, guarded with an advice setting.

Sorry for the delay in getting this out.  Thoughts of all kinds
welcome, as always.

Sincerely,
Jonathan Nieder (5):
  eoie: default to not writing EOIE section
  ieot: default to not writing IEOT section
  index: do not warn about unrecognized extensions
  index: make index.threads=true enable ieot and eoie
  index: offer advice for unknown index extensions

 Documentation/config/index.txt | 16 ++++++++++
 advice.c                       |  2 ++
 advice.h                       |  1 +
 config.c                       | 17 ++++++-----
 config.h                       |  2 +-
 read-cache.c                   | 54 +++++++++++++++++++++++++++++-----
 t/t1700-split-index.sh         | 11 ++++---
 7 files changed, 84 insertions(+), 19 deletions(-)
