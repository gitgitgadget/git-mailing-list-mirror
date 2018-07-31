Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311741F597
	for <e@80x24.org>; Tue, 31 Jul 2018 20:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbeGaWkJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 18:40:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46910 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeGaWkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 18:40:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so18004888wrw.13
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8BqcfflOMSM8lnu/9w5WFUaKA+6wqRdYi0NsKcqx5i4=;
        b=YRjbR22tejFYVFgdVN7qUDV4/0UVKHQC4Y8a8oNNzbwIeLXvq2mHERXFCFv8ej0YcG
         W2EXa0ueokfFw/gKl6kdINqyhrl95prdk80NHLDDq2lC0zexOUrqQ438BMBOhEuKiimj
         81j0weTTABmgZbaiYXlNOXNPJHMUayqe+Wv+6sO8waNbSf6OQ7bN/TEaDxcYwmXp9th3
         F+UND039mfeu4/L9nQdcMgHqhWjI1xg12cO/TXxdHrq4lg2LxSHjqIfqd0DZhbZ2Ak6S
         e8QsGrDA3zzq2MF5Uyi2jritQlf9/66SdYu5xumI7V+Xm03UT6oXgdu6GbTc55Rqdvc/
         9mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8BqcfflOMSM8lnu/9w5WFUaKA+6wqRdYi0NsKcqx5i4=;
        b=q1o8vmWD2sb+pDBkyd9PD6K5Q0c14fRByWV628y8e+8aD0G647moT9gMM8NjIcSlOe
         Qjjf0V/9aV7W7S/xasyFC22APJlYQViQ342x+AL4r60+nfQ26jIZjRmpXvlod87lbATB
         5JnLRxEQ8Yzn9++x2nNukcRqPbwoRo9VsOdnLlxZHHqfDDvi45fB2JHvvomhvhwtO88y
         E9oaqzmjiXDok0UKiw+Y9PuZVAPd2yWyY+D7GPSK2k9hJilgIFgdD2cTz95a1g0DkQli
         B7sMS44Qyh/DhL3eSOujKaZO3QJbE0DISPnaxIprfJtdn9wyGz7U04p5VQmfZfCbJUrV
         tJXA==
X-Gm-Message-State: AOUpUlHIYYBHK152Jh3O76f3YhBoRRwuwOd+WcHTF+rS9XNIRFjVt2fd
        iCmluDKjbZnmoMZhS0FU9+k=
X-Google-Smtp-Source: AAOMgpf1OB9Eybu+sWdWegwJ003FCMWnAyJ+63LeeGnlU/AvdWGK6to/3pSJZ5E1e6WZ0GqcWe0I5g==
X-Received: by 2002:adf:9a0b:: with SMTP id z11-v6mr21649552wrb.47.1533070678196;
        Tue, 31 Jul 2018 13:57:58 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z8-v6sm28041711wrp.54.2018.07.31.13.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:57:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        pawelparuzel95@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
References: <20180729092759.GA14484@sigill.intra.peff.net>
        <20180730152756.15012-1-pclouds@gmail.com>
        <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
        <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
        <20180731192931.GD3372@sigill.intra.peff.net>
        <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
        <20180731203746.GA9442@sigill.intra.peff.net>
Date:   Tue, 31 Jul 2018 13:57:57 -0700
In-Reply-To: <20180731203746.GA9442@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 31 Jul 2018 16:37:47 -0400")
Message-ID: <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Presumably we are already in an error codepath, so if it is
>> absolutely necessary, then we can issue a lstat() to grab the inum
>> for the path we are about to create, iterate over the previously
>> checked out paths issuing lstat() and see which one yields the same
>> inum, to find the one who is the culprit.
>
> Yes, this is the cleverness I was missing in my earlier response.
>
> So it seems do-able, and I like that this incurs no cost in the
> non-error case.

Not so fast, unfortunately.  

I suspect that some filesystems do not give us inum that we can use
for that "identity" purpose, and they tend to be the ones with the
case smashing characteristics where we need this code in the error
path the most X-<.
