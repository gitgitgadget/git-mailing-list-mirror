Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72E80201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 16:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbdGCQ7D (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 12:59:03 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35457 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932407AbdGCQ67 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 12:58:59 -0400
Received: by mail-pg0-f65.google.com with SMTP id d193so5351493pgc.2
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xcZB2cZdxhdwgLQCiS8sAAW2MZGscwAQQeJIF5HorI0=;
        b=k75kUw5a0zRLMZya+IhiRnzFNfIbkUHrxO9MdJobquWasFTvCefq/YX0oXtfh2HQxm
         4GV7RIAimlsezvrd0Qfzw2c/xpLflPUjO3FfcziCHxmwGz9WsceAwh4BuBBpaFBcita5
         FwHb8NwPm+oHy2+g3yHK+0IcQnfdm8p295G9L4JX/JXAoXNmJO8tn8IsdSNKLikTwRfD
         7GUqnXgSnBwx1lEVPrT7EAd7GLj/MqwgoN6anojkXDWlI7jZTps5jUd8E/BCroH6rWW3
         mJRzSAjOoQ2TGZH/8VWSwTt0g/5HsQFgpR36t2T1qqDcj/vtSWaOjOOgoC9zP4CIU1VW
         pbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xcZB2cZdxhdwgLQCiS8sAAW2MZGscwAQQeJIF5HorI0=;
        b=LDUfKqTRICPWQj5U5GdwtALD/tHj191p164RO63NFpo6b/A4zjvx2kqvNjIdrVa4Sn
         N84A3peG/VUNG/aXy1vALNnxJVD75DBfqscmnhTQVJ2x+4zcg3No+4/VxjxcJGOcN8V2
         hEDUrujdEzaR1Tr5v4cp2tTE7mzQT2VWde99YRAnxy/3ihkHufTfJ4GtdrjyGTbag3fh
         LeSRBQPsq1WCJerivdM1yUb8C2YV/kTjrIqUV7AHVQJ8cHtWfuOQLEwyV350m9PQqjEu
         JhYj3Jr8x9jn2ElVXnrqYFlPAUGysajgAgwqTzQ6tNTAsaRvatv+F3jYN7K8nMRjq+U6
         XLTw==
X-Gm-Message-State: AIVw110rg03Q4LaWuJQRRR/sJTrhV/q2qJzohAqEMhGWhfMeB5/8wLPp
        se/F8JrF8OWJSaXYV/M=
X-Received: by 10.99.53.135 with SMTP id c129mr11428018pga.68.1499101139002;
        Mon, 03 Jul 2017 09:58:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:30:4739:ca21:b5b4])
        by smtp.gmail.com with ESMTPSA id r69sm38640364pfg.28.2017.07.03.09.58.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Jul 2017 09:58:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: "git intepret-trailers" vs. "sed script" to add the signature
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
        <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
        <1498918546.4321.1.camel@gmail.com>
        <1498925790.4321.7.camel@gmail.com>
Date:   Mon, 03 Jul 2017 09:58:57 -0700
In-Reply-To: <1498925790.4321.7.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sat, 01 Jul 2017 21:46:30 +0530")
Message-ID: <xmqqh8ytmp7y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> So, it seems that excepting for 'commit' it has quite a nice spacing. I
> guess we could add something like the following to fix that,
>
>     # Add new line after SOB in case of "git commit"
>     NEW_LINE='\
>     '
>     if [ -z "$2" ]
>     then
>       sed -i "1i$NEW_LINE" "$1"
>     fi

Isn't "sed -i" GNUism that is not portable?

> I'll send a typical patch that uses "git interpret-headers" as a
> follow-up.

When you say a "typical" patch, what do you exactly mean?  Does
anybody else send typical patches (or atypical ones for that matter)
to the list?



