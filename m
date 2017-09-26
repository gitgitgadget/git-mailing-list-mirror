Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2843420A26
	for <e@80x24.org>; Tue, 26 Sep 2017 00:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936533AbdIZAN7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 20:13:59 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35746 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935704AbdIZAN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 20:13:58 -0400
Received: by mail-pg0-f68.google.com with SMTP id j16so5744438pga.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KB42eKMGAelNQF7poJ6NDUa47tOhKAXkmP0MqShb/ho=;
        b=RalomUCk/Fs1c7KMPtbKTNf/9fuhDfM5vOsHXH8+ID7BM2r+gEwmbq8ZNDYCji+Cq/
         ELoX2DnjQCDH28SCC6KdsAjGMdlAuv679vQFU/w5n+gR+hYzR8EhsNuf4PM51umrCK3E
         7YlXG/XLZhJ+7Z+CXCrTWEMxYZTdZMUbJ77W0DXeRM0VWYnd5Hkdqk5tQwZQW0GQMJiT
         xvPJ0JNL+ufWw4JYpxiXCevxw5Wr4+Puk+wDdCgDtnK2BZ60ccAU0JLAJsd2PHEgvub7
         QiijmptagknPXbvVke0nc3fKuf1hESmJpb7Z3q3mTIsDoSmRt42dm4iSLKgwmWsVw4tN
         s7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KB42eKMGAelNQF7poJ6NDUa47tOhKAXkmP0MqShb/ho=;
        b=TvyDuRR0FKTUWFcKGK99QD7SGyf5/HAli7ZU0hh4IWl8gw5lyzuIHQ+f/8Bd5oIqa5
         tQ6WnXmrs/3qp3xV3TlvD7REq2Xg/cx8v5R1q5djXXsYHxzwWrerQjILSbIFoq/3PUMm
         hW6Nf6NsKd3Zv54Rbi7Xi2LT5niA0E1xS3F5f56LKfUZEAJ+gHTO3Gr+p/psua2Kvu0o
         kaX8F2+WaORIZnoRA/pnYuMo3qehyV68i4IIX1qYSjJCHw4ndetG6AyutW7qYPmcXRLP
         rQkDmKex872tgd7q2y0+sdL8AlJVPOY/2HjJxZG+H8dLTatXupSrG80p52P2EEVwreaE
         9EZA==
X-Gm-Message-State: AHPjjUgyb35ke2dmZ8spQttu1E0qG8Lpo0elADbmlcyOi384hkJgElXQ
        wAsGdKxCaIB9q9z43Dof/czwzc7Y
X-Google-Smtp-Source: AOwi7QAl5z6ES4kkNSKXzzvJuLOyId3CT31UyKr07C130AuXtCCbSCTJHg4vsxVWhcHd+AmtQAG04Q==
X-Received: by 10.99.98.131 with SMTP id w125mr9351684pgb.214.1506384837529;
        Mon, 25 Sep 2017 17:13:57 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id e87sm13350577pfl.46.2017.09.25.17.13.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 17:13:56 -0700 (PDT)
Date:   Mon, 25 Sep 2017 17:13:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170926001354.GN27425@aiede.mtv.corp.google.com>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
 <20170925233316.GI27425@aiede.mtv.corp.google.com>
 <20170925233732.4lqavl56qwpfjuxy@sigill.intra.peff.net>
 <20170925234541.l6qcislhfwtnxf5m@sigill.intra.peff.net>
 <20170925235510.GL27425@aiede.mtv.corp.google.com>
 <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170926000117.y3solltovyueq3zc@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Sep 25, 2017 at 04:55:10PM -0700, Jonathan Nieder wrote:

>> All that really matters is the strerror() that the user would see.
>
> Agreed, though I didn't think those were necessarily standardized.

The standard allows them to vary for the sake of internationalization,
but they are de facto constants (probably because of application authors
like us abusing them ;-)).

[...]
>> Of course, it's even
>> better if we fix the callers and don't try to wedge this into errno.
>
> Yes. This patch is just a stop-gap. Perhaps we should abandon it
> entirely. But I couldn't find a way to fix all the callers. If you have
> a function that just returns "-1" when it sees a read_in_full() error,
> how does _its_ caller tell the difference?
>
> I guess the answer is that the interface of the sub-function calling
> read_in_full() needs to change.

Yes. :/

>> If you are okay with the too-long/too-short confusion in EOVERFLOW, then
>> there is EMSGSIZE:
>>
>> 	Message too long
>
> I don't really like that one either.
>
> I actually prefer "0" of the all of the options discussed. At least it
> is immediately clear that it is not a syscall error.

I have a basic aversion to ": Success" in error messages.  Whenever I
see such an error message, I stop trusting the program that produced it
not to be seriously buggy.  Maybe I'm the only one?

If no actual errno works, we could make a custom strerror-like function
with our own custom errors (making them negative to avoid clashing with
standard errno values), but this feels like overkill.

In the same spirit of misleadingly confusing too-long and too-short,
there is also ERANGE ("Result too large"), which doesn't work here.
There's also EPROTO "Protocol error", but that's about protocols, not
file formats.  More vague and therefor maybe more applicable is EBADMSG
"Bad message".  There's also ENOMSG "No message of the desired type".

If the goal is to support debugging, an error like EPIPE "Broken pipe"
or ESPIPE "Invalid seek" would be likely to lead me in the right
direction (wrong file size), even though it is misleading about how
the error surfaced.

We could also avoid trying to be cute and use something generic like
EIO "Input/output error".

Jonathan
