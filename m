Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68DD1F51C
	for <e@80x24.org>; Mon, 21 May 2018 18:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbeEUSLy (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 14:11:54 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:34544 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753209AbeEUSLx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 14:11:53 -0400
Received: by mail-yb0-f175.google.com with SMTP id i1-v6so5389055ybe.1
        for <git@vger.kernel.org>; Mon, 21 May 2018 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BUnUWY0AojvWC5tgLbeKkrkp7unu5W0GLznyb1oSgIw=;
        b=anLXhxLOK5z6hqNtEbCwg6bhj0e3Ky/Thl4NcBpDCz1iBnxlLOGV/u0zdut/cWJX03
         yujs41Biz8xw4J3/7Nn/tFgzLQP9G6yTMr6nQClLMD1dnBFHkBq4sbiMbvRMLpMbrAgx
         sNfzbGajfnrH9CZzxHVIT6JEE8cWw3XK1m6aS8c4+KRjjstWruwieKRfCeqzC503kIz4
         4jpLZhsbEiMOk9SdvdeFL6wmpMIFuG/wSOy4cqBtej0m+F7FjuG6AjpZlz6nL9NGPK24
         gDYMqzoNlHT2VbsfCG/9tv1u9Ryh96+yHulLbjfuJZ0wpOBnTEZK/2wnqiUo8pVv0Kkr
         35mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BUnUWY0AojvWC5tgLbeKkrkp7unu5W0GLznyb1oSgIw=;
        b=AFy5AQv+rQaARGprBcuyj2PBMLUvjRqhsnyLn5QmALYqwhMH0v0U9ayGZmpWft/xoJ
         VGmdTRcmYucfZl424wyhpTz2N44VOmxr696DkHOq44KOLri3yCt6Bb0Dac4DctMCr17Z
         FOPGbTqV9sNs+Z/Laea+Yyg7XxLnh8fMEem01gwoIqaA7WPcgMUivTmrGGkkgMuvwNIs
         eKsEnGoxot7v9wEUYtTSeFkUX+oVAEmAVR3yFRACS6ziNoL14skOZot5jg32fxpn/cZd
         abqlctm0TGBCQVWhvb/a9DgBo/rmAAqGXJvjvgj6GBtjS3NHS9u+iJh4WTwCXO3XNXCL
         RLsQ==
X-Gm-Message-State: ALKqPwf4PgcvOuiSpy53E7xZlEsOEPRLPhCmQLzPVb2PfrivbhNHiDvF
        VGWtpwPsDQpsHbdJQoQWKQEg/hubjf0femfu0FRN2oBftDQ=
X-Google-Smtp-Source: AB8JxZrWgQeJNBYSqbULaCLBzXQwsyKZKWgYNPeUPGK8Zd/4wS+R0+t6DWGjBzUb9ipmxIpk0qg8c+MX3dRstMpCidg=
X-Received: by 2002:a25:a526:: with SMTP id h35-v6mr1103980ybi.515.1526926312375;
 Mon, 21 May 2018 11:11:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Mon, 21 May 2018 11:11:51 -0700 (PDT)
In-Reply-To: <20180519015636.GA32492@sigill.intra.peff.net>
References: <20180519015444.GA12080@sigill.intra.peff.net> <20180519015636.GA32492@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 May 2018 11:11:51 -0700
Message-ID: <CAGZ79kYZ9HSCC95qCZ4Zix1oEFLscsU1HZe64s--6KuWEz2ojg@mail.gmail.com>
Subject: Re: [PATCH 1/5] http: use strbufs instead of fixed buffers
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Fri, May 18, 2018 at 6:56 PM, Jeff King <peff@peff.net> wrote:

> @@ -2421,4 +2426,5 @@ void release_http_object_request(struct http_object_request *freq)
..
> +       strbuf_release(&freq->tmpfile);

Do we need an equivalent in release_http_pack_request as well?
