Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA394C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 22:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AB861DA0
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 22:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhF2WeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 18:34:12 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34600 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233056AbhF2WeK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 18:34:10 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D08F11F8C6;
        Tue, 29 Jun 2021 22:31:42 +0000 (UTC)
Date:   Tue, 29 Jun 2021 22:31:42 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [HOLD 3/4] check_packed_git_idx: attempt to handle ENOMEM from
 mmap
Message-ID: <20210629223142.GA20945@dcvr>
References: <20210629081108.28657-1-e@80x24.org>
 <20210629081108.28657-4-e@80x24.org>
 <20210629202101.GA18279@dcvr>
 <xmqqbl7owe2q.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbl7owe2q.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Something like this, perhaps?  You'd also need _() around the error
> message you added to object-file.c in [2/4], I would think.

I think I need to drop 1-3 of this series because it seems
impossible to account for the mmap-via-malloc cases that
still bumps into vm.max_map_count limitations under Linux.
