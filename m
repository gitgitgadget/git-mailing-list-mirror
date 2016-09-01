Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52E1C1FBB0
	for <e@80x24.org>; Thu,  1 Sep 2016 08:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbcIAIdo (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 04:33:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33766 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752452AbcIAIdn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 04:33:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id w207so7278689wmw.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 01:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IUgaZzZpfPH/QjQji6o995xI0DuqaCbyETb0whQWoYU=;
        b=mnPSVq4Gqtt5PDuXXkEhp93+72qhQd15fb+R7+cA8vb8pYqfdmdEicpH6iEZdE4bxz
         OKd/2Rdb2tCNU/pKSx//OlVMkmRC/eQd0NmN9IKNSgOfDTYNRq//J0JngZbipm6rro7t
         +9GbZFNB6qLGtMeLUhk+Cl/yvbNWUAlWzs2ZUlWRpAyifWGRTtxt9geRcXfjc0HkWR/S
         nXWyD7AEedHBfpVVahs/DuQBZsYAk9d+oFUDbaUqxJzS4fLdUJFs6EUrATS4eHYOMbl2
         oq64jp2r+eEBzJHk3+bcMgqUDRveNRnNE22zDPsc6URpvBmjN+3vPo0o4mDQWNaECD7n
         7Rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IUgaZzZpfPH/QjQji6o995xI0DuqaCbyETb0whQWoYU=;
        b=hebc2YC4Q7o2QY46m4tBuq5jK0MXDBTzTj5mTgrHlhPPvWGTBZCG8yIRZ8vG/VM1Fa
         L4faT2tmz+nOD5pt/wMiPrW9ytkxprfLN69yhAG0SX6rdrkCq6y6T2j6u6TaVOdAZuNL
         3mzcikqB2LpnYs1/sb59CxPyrgRAnUJSAKPbYGxAwmbzTgCRuMY2Pfb3jDLQCQdpbO4A
         cvaquPg4N2FHV1X8BhbjCYgFE2cNOaxAggyLgxO0wPHY/kvourHuN3z9zTw40Dtliye7
         wwMdUfSjdyai9WXPSmx7iO9BsWdc69TgfJTREW1CVznaPbn9iEJ3wkhHmxXUczGxciuk
         BUEg==
X-Gm-Message-State: AE9vXwMbjaqRMnXcj+sP96NyA0jPqrdG/INGHj3staeD7y5d8TK36/LPD/2laxx+OcGbYQ==
X-Received: by 10.194.176.69 with SMTP id cg5mr12491048wjc.52.1472718816718;
        Thu, 01 Sep 2016 01:33:36 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id 4sm27821672wmu.2.2016.09.01.01.33.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 01:33:36 -0700 (PDT)
Message-ID: <1472718815.4680.21.camel@kaarsemaker.net>
Subject: Re: [PATCH 27/34] sequencer (rebase -i): differentiate between
 comments and 'noop'
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Thu, 01 Sep 2016 10:33:35 +0200
In-Reply-To: <736bcb8e860c876e32e8f89f68b0b901abedc187.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
         <736bcb8e860c876e32e8f89f68b0b901abedc187.1472633606.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On wo, 2016-08-31 at 10:56 +0200, Johannes Schindelin wrote:
> diff --git a/sequencer.c b/sequencer.c
> index 51c2f76..4c902e5 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -763,7 +763,8 @@ enum todo_command {
>         TODO_SQUASH,
>         TODO_EXEC,
>         TODO_NOOP,
> -       TODO_DROP
> +       TODO_DROP,
> +       TODO_COMMENT
>  };

(picking a random commit that touches this enum)

In a few places you now make comparisons like "< TODO_NOOP", so I think
it would be good to have a comment near the definition of this enum
that says that ordering matters and why, so people don't attempt to add
a new TODO_FOOBAR at the end.

D. 
