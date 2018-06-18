Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B73291F403
	for <e@80x24.org>; Mon, 18 Jun 2018 21:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936938AbeFRV1b (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 17:27:31 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40618 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936935AbeFRV11 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 17:27:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so18199376wmc.5
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wfSNFjgsNyX9aWrUIyPE4xu5PsOJRZJinet0Hm+j0hs=;
        b=HFho5q0ad9EOwCoWO99nC7gdJW1lNxs+A1uIH5au7OTJYWvvgKek8nf6/HF0IysSlD
         qFVahnho9gyQaLYklx3qIljP6mGHDTNmi7jLikt88i42vSjmOIzHM4XIGQBQFjlVAxKT
         FpipGrep8FYDQ/TMm4fyFRto9FA0KXow627gudzgmlUvuVkW5529Z0Ybc44E27tT4fkd
         9nukR5PQ0JsIRkEg5iNJIRdofH/SNg0L0o2lP/SajIFUebC41fX2wM9IDjYtq2WFnZuA
         opYy35GhBiIspX8iVKA6ND2OZjU2G64JFvExK8WGm9PQzrBUb8NC0YU0qI3TVWL1Hqw2
         BJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wfSNFjgsNyX9aWrUIyPE4xu5PsOJRZJinet0Hm+j0hs=;
        b=VeAXfF3KkzrdgJ5CF+eXnBxE/srT+JpGFZlmNHGr5hQemIwysmJPkD/fZfojepCtJM
         5cTnXB8sbXNm6vp+d3yu425YiFSV1N120p3f/1Zts1sTmjpevV9wCaXtdueFLh0NAhlc
         yQ0CHWI1QF7prLLla6sZ86URCvxWBV/4CY91i66zeX3uC5f46rIwYzgT1L/rEyYI0H34
         +4IdqyhOoH6Vh04rxB9tqHH2nA32CX4fM9YrnN8Ho9KIYhzQXHBwqm4mDyyqfiept+2J
         eKyvIp+NDy7ZeqpJIlMDgwUx/zy6PaGPkPxyFLlWkhDupUtjIVT3k3FPEozPEOqFNga+
         yh/w==
X-Gm-Message-State: APt69E1k9ZQ3DNbx2opJoHE5iHT1VlKcnFe3CaA16PYeTJXxCHxKFWnc
        awb0Qrk3MauJ9T9Xoi15cJ+PF12b
X-Google-Smtp-Source: ADUXVKJ3SjjcW/Ax40zymf0pxhn89fQiZZ4yu6w3hZirDBNhwP3+SEH2s0cW8nP3sVM7RcH345zdQQ==
X-Received: by 2002:a1c:992:: with SMTP id 140-v6mr10032878wmj.86.1529357245970;
        Mon, 18 Jun 2018 14:27:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r123-v6sm11769789wmb.21.2018.06.18.14.27.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 14:27:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com
Subject: Re: [PATCH v2 2/2] fetch: send "refs/tags/" prefix upon CLI refspecs
References: <xmqq1sd3yii2.fsf@gitster-ct.c.googlers.com>
        <20180618210731.152140-1-jonathantanmy@google.com>
Date:   Mon, 18 Jun 2018 14:27:24 -0700
In-Reply-To: <20180618210731.152140-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 18 Jun 2018 14:07:31 -0700")
Message-ID: <xmqqwouvwzsz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> Wouldn't that allow us not having to advertise the whole tags
>> namespace only to implement the tag following?
>
> Yes, it would, but as far as I can tell, it would add an extra burden on
> the server to walk all refs requested in the ls-refs call (in order to
> determine which tags to send back in the response). Also, this walk must
> be done before any negotiation (since this is a ls-refs call),...

My comment was that I doubt the "must be done" part of the above.
How would refs-in-want be responded where client-supplied "I want
'master' branch---I am not asking for the exact object the first
server I contacted said where the 'master' is at" gets turned into
"So the final value of 'master' among these servers that are not
quite in sync is this" by the one that gives you the pack, not
necessarily the one that responds to ls-refs upon initial contact?
Can't we do something similar, i.e. let the client say "I want tags
that refer to new objects you are going to send me, I do not know
what they are offhand" and the server that actually gives you the
pack to say "here are the tags I ended up including"?  The
"include-tag" process to generate pack with extra objects (i.e. the
tags that point at packed objects) has to involve walking for
reachabliity anyway, so as long as the feature is supported,
somebody has to do the work, and if you want to cut down the
transfer cost of the refs/tags/* enumeration, it needs to happen on
the server end, no?

Or perhaps v2 fetch should implement the automated tag following
without using include-tag and instead as an extended feature of
ref-in-want.  I think that is merely giving a different name to the
same idea outlined above, though ;-)
