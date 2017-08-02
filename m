Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BAE820899
	for <e@80x24.org>; Wed,  2 Aug 2017 17:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbdHBRqU (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 13:46:20 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34438 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdHBRqU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 13:46:20 -0400
Received: by mail-pf0-f181.google.com with SMTP id o86so20401000pfj.1
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aXcoS/eura1ITrdvUU98cMC4UMkejt5K8pLyz3ZucOQ=;
        b=OIMJCe6TTtMKDij631X1BjNrHHtE1Punh3cZVxlGoxlXZw5EFrlahmI9846tolEzhX
         c2Y2sxveKOD707TSAYWmi8M24mppc9Rqj+kscFtDT9NEFxS2rPNbrPgZ6Y2eK0CKU3bU
         qpkyoKmq6EmDDYr/kFOeipsM5WVxMqt/f5GuZfx8YxhEiAfG3BvgcH74cvD0vmDpKc4N
         tDUSNfgPnq9dBJdQ4NhZQkUvXjkdN7HE/QTHknMu3CLghBVCmlGoYNSqgi0Y5mA+FX4d
         buAi8kRAsKWinEOWduV5//vAw/rJxiF7GOyHbrdhztm5EXMDqQUO6gVRJlG0QZQJz0v2
         /CkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aXcoS/eura1ITrdvUU98cMC4UMkejt5K8pLyz3ZucOQ=;
        b=BIug2gEyIdGavxhCGwoYC7uw3569C9+MI8c9QiWjciPEmcZENlB++o9recMD/ntIBt
         pQtNTrRNqSzKv8+aAcVDzt7Cd/sy5AFcxjIx2PA04ZyQiVfk3Zp/n07Xyj1xk9oSkawU
         wkIKwj2zWFsX+Nu0ZUBY3vNlO7Tlx/6g9Bg+dhqzfLQ1YFFtZzvVbJ5o+i5akVNG9n6s
         ZLOSVaIBhIiAD2AIEiclu+EsDxovV75RqypfmBCBTXPnLtlz70I2mPFoYbQTwFB2dRol
         e+ypcd7xFsTdHVrLYtnFwGYSWZCZAKHtfj7Pdz/vvx+NNjq+l8oDQwrwWmGo/ugHk652
         WtGQ==
X-Gm-Message-State: AIVw111RSlO/RuXQVNHIO7IqJTPdXew0J9fUaiRZyNmbc2AM1TZIkRzn
        XzAzuCFteM6AiAt34wVfRw==
X-Received: by 10.84.170.67 with SMTP id i61mr25711397plb.114.1501695979416;
        Wed, 02 Aug 2017 10:46:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:5415:3cb1:21dc:39fd])
        by smtp.gmail.com with ESMTPSA id m186sm59307082pfc.54.2017.08.02.10.46.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 10:46:18 -0700 (PDT)
Date:   Wed, 2 Aug 2017 10:46:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] convert any hard coded .gitmodules file string to the
 MACRO
Message-ID: <20170802174617.GC36159@google.com>
References: <20170718190527.78049-4-bmwill@google.com>
 <20170731231142.15053-1-sbeller@google.com>
 <413e4f55-5f8b-a80f-775b-b456c4de8a46@jeffhostetler.com>
 <CAGZ79kY-H7rWW_h-k4fHXkwqfMJvd8MtGBooNH8J7PaA2Gj1Yg@mail.gmail.com>
 <xmqq4ltrf30q.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ltrf30q.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/01, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> >>>   @@ -233,18 +233,18 @@ void gitmodules_config(void)
> >>>                 strbuf_addstr(&gitmodules_path, "/.gitmodules");
> >>
> >>
> >> Did you mean to also change "/.gitmodules" ??
> >
> > Goog point. We should pick that up as well. However as we do not have
> > a macro for that, we'd have to have 2 calls to strbuf API
> >
> >     strbuf_addch(&sb, '/');
> >     strbuf_addstr(&sb, GITMODULES);
> 
> Ehh, doesn't string literal concatenation work here?  I.e. something
> like:
> 
>     strbuf_addstr(&gitmodules_path, "/" GITMODULES_FILE);

Also this doesn't really matter much since this line is removed latter
on in the series, but I'll go with the string literal concatenation for
the intermediate state.

> 
> 
> >>>                 if (pos < 0) { /* .gitmodules not found or isn't merged */
> >>>                         pos = -1 - pos;
> >>>                         if (active_nr > pos) {  /* there is a .gitmodules
> >>> */
> >>
> >>
> >> It might also be nice to change the literals in the comments to
> >> use the macro.
> 
> The reason you want this patch is not like we want to make it easy
> to rename the file to ".gitprojects" later, right?  The patch is
> about avoiding misspelled string constant, like "/.gitmdoules",
> without getting caught by the compiler, no?
> 
> Assuming that I am correctly guessing the intention, I think it is a
> bad idea to rename these in the comments.
> 
> 

-- 
Brandon Williams
