Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD5A20136
	for <e@80x24.org>; Fri, 17 Feb 2017 17:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934496AbdBQRLa (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 12:11:30 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33632 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934122AbdBQRL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 12:11:29 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so4463782pfg.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 09:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zceTp7/S6XhKO+Tc7eTInp2zTmrG0HwCxloAgS/qYXM=;
        b=eHmkNYGEuiKFXncPrdgF6uqMNVO34LUJGdQLBq4dNZ2Mk3STkPf5s+u6jE+ti5B5P2
         bMG6fKM8fE6f1CWJbD8o/kDxvZmbvyzo/PQLIub5b8WnW6WY+em4uiZnRXP7qyYqrg0G
         qPLynEhKWOWRxB4PXrHcBV8KCxGW/uTfPbV12WXYmAR6oRbKLWT5gSW2Wnx1cqyoVsHA
         rjlTJj5LKYOa/WYo2Q8bIfyO/SqrhCNOp6qqpxyd6pijH2kSKJwEvgkt9TbVkKggrWCo
         vkXbFUZFlFfIArtyqnuOkEXbx1Bujw00HnrQJfNkuqITgzSa0VitW0Vln/o6znBSpNLE
         zm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zceTp7/S6XhKO+Tc7eTInp2zTmrG0HwCxloAgS/qYXM=;
        b=R0vZ9PRylGOBF6xEXbtYGMMoh+F/I9rMXR1bxKlbUTZ81V3b+i/D2JytkKY/YF+ac+
         yxaO+BdD+E+sjC99UhjPgCQyoN2/Pr2n/5/wD9rdy5RuQ5nMqFMD59KzSByMGwgEfj08
         sLO0mdK3MzTMZcz3O8Oz9MtWMDL7lPUQkSXYfR55w/W/U2vAP4Agswpgs9Lfqec0GVLt
         npT4Y6PosFgSHoQODd0gTeSuxO0PvIjJe/MmCGlD9lnESw2I6auZDmZvPb+a/K0RKB1c
         0PS9SizpvsAttKWzVYzmPjKHZ9QMchWuZuJjbseHuN5kReMIzYa2hrW1mHHY6gulE4xF
         D26A==
X-Gm-Message-State: AMke39krLegIjpxidOzlHTwE4RXIbm94hE1BgXSdS9J5Xrm8E2hvlpuWmfqatxBW1BKwsQ==
X-Received: by 10.98.78.66 with SMTP id c63mr10715795pfb.138.1487351488861;
        Fri, 17 Feb 2017 09:11:28 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id b67sm20694103pfj.81.2017.02.17.09.11.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 09:11:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] update-ref: pass reflog message argument to delete_refs
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
        <20170217035800.13214-1-kyle@kyleam.com>
        <20170217035800.13214-3-kyle@kyleam.com>
        <20170217082253.kxjezkxfqkfxjhzr@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 09:11:27 -0800
In-Reply-To: <20170217082253.kxjezkxfqkfxjhzr@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 17 Feb 2017 03:22:54 -0500")
Message-ID: <xmqqo9y0u4hs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...

All good review comments.

I briefly wondered if recording the deletion of the current branch
in HEAD's reflog has much practical values (Porcelain "git branch"
would not even allow deletion in the first place), but because it is
a rare and unusual event, it probably makes more sense to have a
record of it.
