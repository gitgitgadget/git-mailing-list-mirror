Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FC861F45F
	for <e@80x24.org>; Mon,  6 May 2019 19:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfEFTq3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 15:46:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33309 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfEFTq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 15:46:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so1000004pgv.0
        for <git@vger.kernel.org>; Mon, 06 May 2019 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bbPXZ2y5DOuY6vWVfWIRHUdDO9XRnicvosSHOKolzHY=;
        b=QzfDHfC7qe0vxTgyg9wyTc1lTxHysXP73RK7sqfZwn1keLY702Nx96p28bj9nQoNKd
         kEPptNbPf2ux6L6/nZwQQNYYwl+yBnNdG5O/tskaYJb/C2X5AuPuaxhNucDO65jq5FG6
         10BlK+O48TtJ540YLLqCnSenoVQpNHR+GbhNVXgxPhhD64BBaK2JZ17w22XZZPN/lUqI
         gJZ7C9ahqIm2oCk0Ghsgai6070C7pdBGSpScmSg33QcsOKX9CqsJ0lgOc2W/ZlO1NWDR
         7yBcHyqE4+gLe3CVtnGlSJAlsAyNHCj3V3URawdjrJeyKyghxq0gdI4Li3IxYmPWNGoe
         HKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bbPXZ2y5DOuY6vWVfWIRHUdDO9XRnicvosSHOKolzHY=;
        b=UeevhQyPncOXgsLuF3twRQa2xHiCCpAPi0ZSDZdMH3AbgstRTPv5gwpoB3j6NwlfHz
         GcapKo3VT/mHI18WeG6drEiDk0qjNcuxXruP2o8LK8vaDxFOogtE6RmNrBvk+mDFjNlG
         TNkoqWgyQglAWMQquenghaj1jAQUH7RZ9h6VWMhQ3boqq6bBxojYmBRbTT2ScO7gPwId
         LtU4CnABZzaFGYGIbmofClKp7xlHKtyCMsECZmFDOGF5NkOsopS5hmoGUTEF5Wx/F27m
         F+7eXFdxv1xpshQ3DiN2V/YHk5rU4MQ8l9dlbAg+7sccAdJyKfl1W3UXjtKgG39MG3OL
         +3jA==
X-Gm-Message-State: APjAAAUmGXG0GT4SoyMUArZ5EEO/8TSA233P2ddFAIVUm3pvUUBO6zqq
        GEJjvAkMSabpmzAvQTniXU8=
X-Google-Smtp-Source: APXvYqxJH0tWuAzIxRCRwpkEPgY/JUUrqyeq9MNteqseXqcMBS9Mm/NyFs/w92JNCwja9L+YMlqCcQ==
X-Received: by 2002:a63:6103:: with SMTP id v3mr34783910pgb.48.1557171987897;
        Mon, 06 May 2019 12:46:27 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id a129sm14145039pfa.152.2019.05.06.12.46.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 12:46:27 -0700 (PDT)
Date:   Mon, 6 May 2019 12:46:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org
Subject: Re: Proposal: object negotiation for partial clones
Message-ID: <20190506194625.GB57368@google.com>
References: <CAMfpvhKYRVwTVNLfRJYcjhHtg=FNLNPbnw8xtY93nJu228v6=g@mail.gmail.com>
 <20190506192800.213716-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506192800.213716-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:
> Matthew DeVore wrote:

>> I'm considering implementing a feature in the Git protocol which would
>> enable efficient and accurate object negotiation when the client is a
>> partial clone. I'd like to refine and get some validation of my
>> approach before I start to write any code, so I've written a proposal
>> for anyone interested to review. Your comments would be appreciated.
>
> Thanks. Let me try to summarize: The issue is that, during a fetch,
> normally the client can say "have" to inform the server that it has a
> commit and all its referenced objects (barring shallow lines), but we
> can't do the same if the client is a partial clone (because having a
> commit doesn't necessarily mean that we have all referenced objects).

Ah, interesting.  When this was discussed before, the proposal has been
that the client can say "have" anyway.  They don't have the commit and
all referenced objects, but they have the commit and a *promise* that
they can obtain all referenced objects, which is almost as good.
That's what "git fetch" currently implements.

But there's a hitch: when doing the fetch-on-demand for an object
access, the client currently does not say "have".  Sure, even there,
they have a *promise* that they can obtain all referenced objects, but
this could get out of hand: the first pack may contain a delta against
an object the client doesn't have, triggering another fetch which
contains a delta against another object they don't have, and so on.
Too many round trips.

> And not doing this means that the server sends a lot of unnecessary
> objects in the sent packfile. The solution is to do the fetch in 2
> parts: one to get the list of objects that would be sent, and after the
> client filters that, one to get the objects themselves.

This helps with object selection but not with delta base selection.

For object selection, I think the current approach already works okay,
at least where tree and blob filters are involved.  For commit
filters, in the current approach the fetch-on-demand sends way too
much because there's no "filter=commit:none" option to pass.  Is that
what this proposal aims to address?

For blob filters, if I ignore the capability advertisements (there's
an optimization that hasn't yet been implemented to allow
single-round-trip fetches), the current behavior takes the same number
of round trips as this proposal.  Where the current approach has been
lacking is in delta base selection during fetch-on-demand.  Ideas for
improving that?

Thanks,
Jonathan
