Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E41BC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 08:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333FF60FE8
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 08:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbhH3IEQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 04:04:16 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:37248 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234371AbhH3IEO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 04:04:14 -0400
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4GyjVv18YQz5tlD;
        Mon, 30 Aug 2021 10:03:18 +0200 (CEST)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>
From:   Johannes Sixt <j6t@kdbg.org>
Subject: diff-index --cc no longer permitted, gitk is now broken (slightly)
Message-ID: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
Date:   Mon, 30 Aug 2021 10:03:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 19b2517f95a0 (diff-merges: move specific diff-index "-m" handling
to diff-index, 2021-05-21) git diff-index no longer accepts --cc. This
breaks gitk: it invokes

   git diff-index --cached -p -C --cc --no-commit-id -U3 HEAD

to show the staged changes (when the line "Local changes checked in to
index but not committed" is selected).

The man page of git diff-index does not mention --cc as an option. I
haven't fully grokked the meaning of --cc, so I cannot tell whether this
absence has any significance (is deliberate or an omission).

Is gitk wrong to add --cc unconditionally? Should it do so only when
there are conflicts? Or not at all?

-- Hannes
