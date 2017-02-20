Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77606201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 19:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdBTTjx (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 14:39:53 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33054 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbdBTTjw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 14:39:52 -0500
Received: by mail-pg0-f67.google.com with SMTP id 5so14178321pgj.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 11:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CabXiO49CdD7yB2dJm2LcOMbFpuFHiRKY0mOrkXWGTY=;
        b=oFuqxmCG5cBFriNyZ60Xqx4c9g0gvfGBICToDE4lxYBT6ioAU4RCeHpT3oRfqwPBw/
         xaz8R/X1QDhoRa+UnGmS+rA/NTU94e3MjJOzQ9soTVDZVeyTzrquM2Ib2CnHhBsGIdlC
         kPnmJrPlQ6coiR5F0rEWo7ra3Xnq4U64e2gBTQmHrc8XGsFDZxpUftar/Dhzvo7GntGI
         eKKLhZNc/+4VDOfvSTr5HKkLi4BE9qPRNE9FlbLG2IDQKKh+c2aTa3VQsqxmG8GD/fEk
         SwwU9KmseLPYHq/dSv0/eROe0nVG6f3Y+pi2C9pmX0Iq9brGan4/e2rxV56umapJ3G+7
         d/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CabXiO49CdD7yB2dJm2LcOMbFpuFHiRKY0mOrkXWGTY=;
        b=fUbSFBIFektbwILCY+ip2+lGtCYOFBGfmZ5i03mje6WbfwqSJQazYEMO0xQfhaqOvR
         ljjrdchW+2JsVOKXnIjQeg/xFpxm0fUxxGsEjOj/dkg13ntSG0fKxctYiPBKykHLcHgQ
         Q5YSSUFt2lIBhFrzQLGsHFtArfbN4ypP2qOXOUCQ2N3zvxTQ6rtkK5YZ6/qrMbHgQ2ph
         WU9BfFafE/Ixh/Be2vkKoeUirIsa8dPrOX62saC8Aj/hSflsN5R5YFYicKXKdlvdC3sa
         mHvn5hZgDy2Kn7phZWAyfIASneWe1ZL5pWphG+z64HnKD5uZkGkSEkS3H395EbXehcL4
         Xp9A==
X-Gm-Message-State: AMke39nP/iCD+ovFDg9vIXU4HzblsY9Nx8RxsLmWoo6oKjBjUJwM+C87Jo63auoSVtR15Q==
X-Received: by 10.99.61.202 with SMTP id k193mr29629391pga.154.1487619591776;
        Mon, 20 Feb 2017 11:39:51 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:71d2:895f:c7:4f5e])
        by smtp.gmail.com with ESMTPSA id m6sm36546484pfm.22.2017.02.20.11.39.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Feb 2017 11:39:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?=C3=98yvind_A_Holm?= <sunny@sunbase.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 0/6] stash: support pathspec argument
References: <20170217224141.19183-1-t.gummerer@gmail.com>
        <20170219110313.24070-1-t.gummerer@gmail.com>
Date:   Mon, 20 Feb 2017 11:39:50 -0800
In-Reply-To: <20170219110313.24070-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 19 Feb 2017 11:03:07 +0000")
Message-ID: <xmqqd1eck5x5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> @@ -55,10 +53,13 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
>  
>  	Save your local modifications to a new 'stash', and run `git reset
>  	--hard` to revert them.  The <message> part is optional and gives

I didn't notice this during v5 review, but the above seems to be
based on the codebase before your documentation update (which used
to be part of the series in older iteration).  I had to tweak the
series to apply on top of your 20a7e06172 ("Documentation/stash:
remove mention of git reset --hard", 2017-02-12) while queuing, so
please double check the result when it is pushed out to 'pu'.

Thanks.
