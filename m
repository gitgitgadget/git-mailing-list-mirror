Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C702202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752802AbdGMTXs (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:23:48 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:32893 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbdGMTXr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:23:47 -0400
Received: by mail-pg0-f51.google.com with SMTP id k14so34314185pgr.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=0ATo9fSpxUoLs0zPLN5TK6ukQ6biRlPFbzxnAs96V68=;
        b=oBj7syenljETBe2gHZ1v/siAPnCHEE+CL3QrFP3Vecd/o6L9Wt4dfJdpQrtzg2rqum
         t2Jk0KbnVkK/bVBS0h6tVlWvPMQ5TkZFTuYgwRS6xwtPeRWuBmR9lNzGCY08Z/jOcRLt
         A59vm4myLEs4yMQBQRKsUX3WDAbHiSqks12IwS7Ap07S4Do3sRD/Mn+DEAsCxL/lpzEk
         f4S8EKloaTLy9zGmPtheyOu6Nxsuv1gLi9eoaVzRmJtU1jHbHDP+FvzAWz52ZMbMmBF5
         COIRsIDWkwzXCh9AySScYKUqlHEFgHZ0KJZcyDFxO6KKcvlgN7Wry/zl6WZeg2FQ08oo
         ApBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=0ATo9fSpxUoLs0zPLN5TK6ukQ6biRlPFbzxnAs96V68=;
        b=tz7fgY1dkouQVnkDaq9iskaLpkCSDxEi2PNB87fc70Jy8scOM8pS7gOVnR1nku6My1
         gLmbXXfXGeDeVoEaXKnfwEvWUnh+35c/fEMcIrt9TP+FdjBSO9JeGU8TPGWTM53Tnyrl
         hwyaXqHAvtYBM+R6PUko5cBQsh0j+9X7eTAk8ZlvFnpTsx9wBErC/MuECv/PZe0S57FW
         OEu1Ylfw9o/pH1BxADE3yneO2nm2OOo+EvYUWi5YtJvG4VLzu+4Tbr+ajS+b9LOf+0Fd
         imTX4fzPnbf7w29mSvXkof6EZIAc53yXMyFPA5QvSfXWUI0lq6MRzGPSHEwsu6Ukpip+
         cnXQ==
X-Gm-Message-State: AIVw112l+gq1bfWvWND4lr0SJfJCkD0VsYhS8ZVZQ5ENx+/ZCCTo+08b
        Uur2nwPmHdM7mg==
X-Received: by 10.84.225.129 with SMTP id u1mr11987534plj.70.1499973826454;
        Thu, 13 Jul 2017 12:23:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id t26sm15740429pfe.88.2017.07.13.12.23.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 12:23:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, me@ikke.info
Subject: Re: [PATCH] commit & merge: modularize the empty message validator
References: <20170706044640.GA11020@alpha.vpn.ikke.info>
        <20170711141254.7747-1-kaarticsivaraam91196@gmail.com>
        <xmqq8tju3eqp.fsf@gitster.mtv.corp.google.com>
        <1499969722.5973.2.camel@gmail.com>
Date:   Thu, 13 Jul 2017 12:23:45 -0700
In-Reply-To: <1499969722.5973.2.camel@gmail.com> (Kaartic Sivaraam's message
        of "Thu, 13 Jul 2017 23:45:22 +0530")
Message-ID: <xmqqiniww37i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> I have a few doubts for which I need clarification to move on with
> this.
>
>     1. If we abort when the <message> part is empty wouldn't it be too
>     restrictive ?
>
>     IOW, Wouldn't it affect users of "git commit -‍-cleanup=verbatim"
>     who wish to commit only the comments or parts of it ?
>     (I'm not sure if someone would find that useful)
>
>     2. Is it ok to use the "find_trailer_start" function of "trailer.c"
>     to locate the trailer? 
>
>     Note: It has a little issue that it wouldn't detect the trailer if
>     the message comprises of one trailer alone and no other text. This
>     case occurs while aborting a commit started using "git commit -s".
>     Any possibilities to overcome the issue?
>
>     3. Ignoring point 1 for now, What other helper methods except the
>     ones listed below could be helpful in the separating the cleaned up
>     commit message into the <message>, <trailer>, <junk-at-tail> ?
>
>         * ignore_non_trailer
>         * find_trailer_start

All good points; if it bothers you that "commit" and "merge" define
"emptyness" of the buffer differently too much, I think you could
persuade me to unify them to "the buffer _must_ contain no bytes",
i.e. not special-casing sign-off lines only "commit".

It would be a backward incompatible tightening of the established
rule, but it may not be a bad change.
