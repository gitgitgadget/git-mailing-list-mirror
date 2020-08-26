Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D49BC433E3
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 12:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CE72076C
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 12:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgHZMmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:42:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:41922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729915AbgHZMmm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 08:42:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 21F19B17A;
        Wed, 26 Aug 2020 12:43:13 +0000 (UTC)
Date:   Wed, 26 Aug 2020 14:42:40 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/7] [RFC] Maintenance III: background maintenance
Message-ID: <20200826124240.GO21928@kitsune.suse.cz>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.680.git.1597857408.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 19, 2020 at 05:16:41PM +0000, Derrick Stolee via GitGitGadget wrote:
> This is based on ds/maintenance-part-2, but with some local updates to
> review feedback. It won't apply cleanly right now. This RFC is for early
> feedback and not intended to make a new tracking branch until v2.
> 
> This RFC is intended to show how I hope to integrate true background
> maintenance into Git. As opposed to my original RFC [1], this entirely
> integrates with cron (through crontab [-e|-l]) to launch maintenance
> commands in the background.
> 
> [1] 
> https://lore.kernel.org/git/pull.597.git.1585946894.gitgitgadget@gmail.com/
> 
> Some preliminary work is done to allow a new --scheduled option that
> triggers enabled tasks only if they have not been run in some amount of
> time. The timestamp of the previous run is stored in the 
> maintenance.<task>.lastRun config value while the interval is stored in the 
> maintenance.<task>.schedule config value.
This changes the config file from read-mostly to continuously updated. Is
that desirable?
In particular it significanly increases the risk of race with the user
editing the file.
I think timestamps are not configuration and should be written to some
other file.
Or is there already a core git feature that continuously updates the
config file?

Thanks

Michal
