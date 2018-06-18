Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25D281F403
	for <e@80x24.org>; Mon, 18 Jun 2018 16:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755273AbeFRQVS (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 12:21:18 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38282 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755249AbeFRQVR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 12:21:17 -0400
Received: by mail-wr0-f193.google.com with SMTP id e18-v6so17493155wrs.5
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mIfhVqcQVYV5SM8HG+Skn0/xQZENjHT6YJPg984xvpM=;
        b=aALEzkhLcGeEtfA8Tl69Mu2sKQYOfOaNMr+djnkom+xohZXHhHlNdMUVyVso8WKXc3
         rwjTn4CIdjnkox1XvOBflQzYNyTqIwfyxFDzjZ1sPrJ+VSiJkYcb5X2ClUJG/9aD4DVO
         EkL/+PZ1iTcYBfU9GI9e37bNuK5FPLBeQuOvQM3tYDO8xKwrNzzFrZeCbEyQjxsboMLY
         W3xFxqCmURiW2UDHYWyNN4mjzGNoMvhvsNpdI0owLFCjRbfCYPRd0ggZaxO01rWvb/by
         6DGSXT1ZsUZe2PoyfKkLol6tfUt0oYHkFuEOYUTH5qpPZoXUvBihoBjvFt3RDh3foyy0
         U5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mIfhVqcQVYV5SM8HG+Skn0/xQZENjHT6YJPg984xvpM=;
        b=aQwulm7O4OpzUkM6pq/clTeyxM1Ss7SrnZBGsBVLsdep51FKI0J4lrg2gaduaSd4dU
         aDO4IMlFDvtMbNhQ97ngKVf3d73Q57+zAg8uyYj8hR61RbFF3ug08j0BACPUdpHWL7OH
         vPP/4ncWVhkgCH/FOuxeclpwMdwwBHX1Zy0GRMNzczz21RoblbMTxMqq82RymBgMUweP
         9WAQIMHl9EShQcLBLTwOYMzfLoAcOb1j19Hn5nD8m8ZWkkZLOTuxI7cxq7TfV44vTzO8
         wp+Qm1+OsJoOHDlEZ5TzZe6RDV8rwPCfgx/5/+UtWz0CMoDU3nPGEaDQVocvLt/jJuds
         uFQA==
X-Gm-Message-State: APt69E0XtQsnrziLGHA8XMF5JqcHFgNtdir4TMAmwrlxUQjIm64rGgh9
        s415CU2K3t+W5a7J/GK/xpQ=
X-Google-Smtp-Source: ADUXVKJZ4sJSuf4IgVBDUElWDwyzs7dEg4uBLgMu3D0kKepLNArwyiq05ZDTppRUJbjz/XC6D15+Qg==
X-Received: by 2002:adf:8e30:: with SMTP id n45-v6mr10481434wrb.27.1529338875771;
        Mon, 18 Jun 2018 09:21:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n71-v6sm12083667wmi.14.2018.06.18.09.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 09:21:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] rebase --root: fix `reword` on a root commit
References: <pull.3.git.gitgitgadget@gmail.com>
        <20180616201143.GH11827@zaya.teonanacatl.net>
Date:   Mon, 18 Jun 2018 09:21:14 -0700
In-Reply-To: <20180616201143.GH11827@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Sat, 16 Jun 2018 16:11:43 -0400")
Message-ID: <xmqqd0woxdz9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Hi Johannes,
>
> Johannes Schindelin via GitGitGadget wrote:
>> From: GitGitGadget <gitgitgadget@gmail.com>
>> 
>> Todd Zullinger reported this bug in
>> https://public-inbox.org/git/20180615043111.GS3094@zaya.teonanacatl.net/:
>> when calling git rebase --root and trying to reword the
>> root commit's message, a BUG is reported.
>>
>> This fixes that.
>> 
>> IMO the bug fix is trivial enough to qualify for inclusion into v2.18.0, still.
>
> It does indeed fix the issue.  I agree it would be nice to
> see it in 2.18.0.  As a fix for a minor regression
> introduced in this cycle, that seems reasonable.

Offhand it is not clear from the proposed log message where the
original breakage happened, but if this is to fix a regression
between v2.17.0 and v2.18.0, then let's have it.  As -rc2 slipped
for a few days, it is reasonable to delay the final by a couple of
days as well, if only to give the last minute fixes and translators
reasonable time to breathe.

Thanks.


>
>> Johannes Schindelin (1):
>>   rebase --root: fix amending root commit messages
>> 
>> Todd Zullinger (1):
>>   rebase --root: demonstrate a bug while amending root commit messages
>> 
>>  sequencer.c                   | 2 +-
>>  t/t3404-rebase-interactive.sh | 9 +++++++++
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>> 
>> 
>> base-commit: 68372c88794aba15f853542008cda39def768372
