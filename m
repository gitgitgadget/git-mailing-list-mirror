Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B551FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 05:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752557AbdD0FmB (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 01:42:01 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35495 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbdD0FmA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 01:42:00 -0400
Received: by mail-pf0-f193.google.com with SMTP id a188so6302625pfa.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 22:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=asrZMwuJFVd/yth06tuYsHooRVeerBlkWu1qsA4CbEo=;
        b=OZXrUIUsJSSVRikPW8N8LxqlH38Kne4T6I8NdtlZtMOrH8V7xw+2IduOwL38Hyd19o
         lyP0vmjCGaRh6uDOym3BKx8uTAL1qSM7djps9k4xLu1ztNS1gBwRMg/byMqT/d9BWm9h
         K80itrUp02a6EixNBJE0Yq/4ORbCg7yYJO15H1wW3YrhJskk8fvnW0OZupohUCPZi6m9
         8e6gTqCmdaIU0vgrf3VuQQj2qf02y1d/fcjO2lJDkITem8Pgjj4pVG2GNomwfGqa/M5a
         3DOjQ5mru1gpy5uJoNDHdHXyutr05VoeNMU4UoK5fHYzqRFQa+3UTPwFdfJVPcIw5w1E
         nCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=asrZMwuJFVd/yth06tuYsHooRVeerBlkWu1qsA4CbEo=;
        b=aoDPBvagJy1o5EQHkNsI1ekS5OZH5VzHI5OTyNKcqWDWI+NOQ/GkkUNvVHr75DXnf6
         jgYCZxEm6K2Vybup14EGzLjezWNs0NWclaW46ATeyUsucd4XrUOkE+ngbzLaPopWBmzw
         RCW/3Y9HPA0nuzJUBQ0Ndj2BHMHFjs/vMYxB6xBnVuKe+svrIT+XpO4zvRhtMIszEDMW
         jTCv57BVSRJy3YVsWK8zGKyALM32f0ednDOirvU6RzJzNxqsnHgQRajur7FNRhy7fyZ0
         CqkL3Jj3tcWAwMG4HVpRzh137DJtBlhY/UXUJXwjH2FSn5219HtHbNJmYB54fqPJhyBS
         uWWA==
X-Gm-Message-State: AN3rC/4y1O+9jmIj/qJFx17IUWSbIZwkKLyLWFfJT15BKTYJfFTbDW9k
        iLbwTKcXftVPHqCyaJHJVQ==
X-Received: by 10.99.104.199 with SMTP id d190mr3685479pgc.141.1493271719356;
        Wed, 26 Apr 2017 22:41:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d550:ca2:cfe6:6d97])
        by smtp.gmail.com with ESMTPSA id g22sm1940023pfd.22.2017.04.26.22.41.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 22:41:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] fix memory leak in git-am
References: <20170427032503.rgz3bnctnxdn3hin@sigill.intra.peff.net>
Date:   Wed, 26 Apr 2017 22:41:57 -0700
In-Reply-To: <20170427032503.rgz3bnctnxdn3hin@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 26 Apr 2017 23:25:04 -0400")
Message-ID: <xmqqd1byo196.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This was noticed by Coverity. The leak isn't new, but I think was
> "re-found" by Coverity because some nearby code did an unrelated
> s/sha1/oid/ change, throwing off its heuristics.
>
> I also checked whether this was in Dscho's big pack of Coverity fixups
> from earlier today, and it's not.
>
> The first one is the actual fix. The second one is pure cleanup, but I
> think worth doing. The final one is arguably just churn, and maybe
> people even like the end result less. I'm OK to drop it.
>
>   [1/3]: am: fix commit buffer leak in get_commit_info()
>   [2/3]: am: simplify allocations in get_commit_info()
>   [3/3]: am: shorten ident_split variable name in get_commit_info()

All looked sensible.  Thanks.


