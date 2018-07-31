Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1026B1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 21:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732374AbeGaXUs (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 19:20:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37015 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732325AbeGaXUs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 19:20:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id q10-v6so18089078wrd.4
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 14:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=790sClIbXqMxFlMGgTl/bMFlpv8YaFbMYx4VKX08DeE=;
        b=nD2hR0rM4GlxnW3UtXkk6xSMmYNMxlQ90yn6grhVkIEyB0JpX9ayObGyjQqzwS+3TZ
         d9gdG2dai2BmH5EihL3jP+ZFjb/QHc+ASoQEHw8abfV/t4H4Gp/Dzj0DAnRYczLmodnB
         7HKWnoupJrAlNHl/UktjrYDe8hEDblEJWaBxYum3wk/XIRqkIjpfr7j0Kjvre3JS9U+C
         KLMv9nTSn4P5/wRe+/ipxVSLjjf4Ctvi6mRms2wmbO5Yr9TAHwiNgfqG3dGhMgx2Xt43
         ZfmM2bvx/dfGsyGzS6s6lfAZRvxNN+aOnoOIqbu4gOkXWYEDG6dyTGUVrkqNx//0CMTC
         41FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=790sClIbXqMxFlMGgTl/bMFlpv8YaFbMYx4VKX08DeE=;
        b=R9aX5P3aT/iKRu76AK9GsT6LqC3p06MNOOVZDWHuVYxDdyVmOjNxujWjEVOaQeKy7E
         f/6csi5Uz6omejLd3MNkfXIGsMUzE5bwebLbdP1OYrOdPUXLa+perm6NLOynq/7hGYTN
         mO4XvscKvWZP9PHk8s5n2AKOOiAEgp2oZHvLMvST3lAErwKEH1GkFiZUprD9m4ZNXICS
         zp/gTxfbmMngsoD2NBfhyRxXnHqHVayeh1yMQw3l444DjPhCLVF7aiu2RPm3saL9R/zI
         GT0Q0OqdmpspHUkBzF7rJZhKs7fL4PmjkJNMrd7ISnm9jRh8+VEFWp1Aq6zkNvcXCIcd
         bKkA==
X-Gm-Message-State: AOUpUlEP+kf0b2DEFOAzAAJjnxMev48Wj8Mxa4n3YrCHe8O80feVx+SL
        JHRDkyhYaekAWzAQyZHM4uQS6crI
X-Google-Smtp-Source: AAOMgpf0jW/YSZU8u1gR/+JorOsUFlfV7sdBGz33VlWmgZMg5/6JxzHbtlzFWb6mMFhcv2ZnpeSWnA==
X-Received: by 2002:adf:b726:: with SMTP id l38-v6mr22709849wre.115.1533073107392;
        Tue, 31 Jul 2018 14:38:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a5-v6sm2244805wmf.3.2018.07.31.14.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 14:38:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] transport: report refs only if transport does
References: <20180729121900.GA16770@sigill.intra.peff.net>
        <20180730225601.107502-1-jonathantanmy@google.com>
        <20180731192415.GC3372@sigill.intra.peff.net>
Date:   Tue, 31 Jul 2018 14:38:24 -0700
In-Reply-To: <20180731192415.GC3372@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 31 Jul 2018 15:24:15 -0400")
Message-ID: <xmqqa7q79jcf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 30, 2018 at 03:56:01PM -0700, Jonathan Tan wrote:
>
>> Commit 989b8c4452 ("fetch-pack: put shallow info in output parameter",
>> 2018-06-28) allows transports to report the refs that they have fetched
>> in a new out-parameter "fetched_refs". If they do so,
>> transport_fetch_refs() makes this information available to its caller.
>> 
>> Because transport_fetch_refs() filters the refs sent to the transport,
>> it cannot just report the transport's result directly, but first needs
>> to readd the excluded refs, pretending that they are fetched. However,
>> this results in a wrong result if the transport did not report the refs
>> that they have fetched in "fetched_refs" - the excluded refs would be
>> added and reported, presenting an incomplete picture to the caller.
>
> This part leaves me confused. If we are not fetching them, then why do
> we need to pretend that they are fetched?

What leaves me even more confused is that the entire log message
does not make it clear what the end-user observable problem the
patch is trying to solve.

Is this "we sometimes follow and sometimes fail to follow refs while
fetching"?  Does it affect all protocol versions and transports, or
only just selected few (and if so which ones)?

In minds of those who reported an issue and wrote the fix, the issue
may be fresh, but let's write the commit log message for ourselves 6
months down the road.

Thanks.
