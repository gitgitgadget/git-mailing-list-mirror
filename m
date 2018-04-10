Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79E601F404
	for <e@80x24.org>; Tue, 10 Apr 2018 03:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeDJDK6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 23:10:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54107 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDJDK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 23:10:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id 66so16674876wmd.3
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 20:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aaV9sbpCzYG5DUM8az1U0NwpFqJZWMfg1vk9qvTzqys=;
        b=HkJ3HMezCFEM0jnXymkjMnJYaTpfGKYxewde++1C0w53qMmeShQacjUu0gSOnqYjVw
         TP2ixDy+SgdklQI3OcZkVJIWar4KgX4/VGrAryp//QKzCSjkyNxByFHfNOXmdszymNaU
         cfJIsZBhC6i6f+vadgISw8JtxqUdiQ5m6x3URe26t9/RUctAvlnCM9eChdxuwLw4D5pj
         vApHjm1XYjqCflOXZRLAW+iY0FmsgOjceT2Rl9o0P7JB7Xqh6klHrTYPFeTd4JlBqSSt
         z7kiCRkwi8wkQdIMbjmSnSV9Ml1aA76z429YAEIoxtIFNXDcDf2gyusxEQje5Ps4u2Ry
         CLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aaV9sbpCzYG5DUM8az1U0NwpFqJZWMfg1vk9qvTzqys=;
        b=X39P6+xALPEqjCjCR7eZrU3hg213i/OeJQvkncqz2XpSyS41E0BXzgw2726JPgzt0Q
         aAT1yqwWpvc0M+zfy6o40NJ3cMD9MQ2qipL/JOfrfDMxtZWeU385kNzmdo/XSJhnnsAn
         KAf7raL8liko42xDrM/tSujBrtBdTZbzlTXeglkKsfOTjJupmQATi7i8YCrB5xvz8bV4
         kSfLx5Wi61yb3JnY2CdwyD810AqpnGcLltfqXsUfaTBPTvMhxONWo+nB01htlrxed0fX
         Ccyf7BR2xrqbV286jWe2HnkKQy+/dGD/ZqQmcuUCd4B9gnXpbQ93FnP9iqlxSBfSDIy4
         rdpA==
X-Gm-Message-State: ALQs6tB8VDlmKRFn+YhLUTFz8lu8GW+NlT+tzoFiAGhQKP7BbgOGxs4i
        ChozrHSio/USHefPOFTYjSo=
X-Google-Smtp-Source: AIpwx4/oWLZkh4gAwEkrUsW0mc9F5x+kvUm4jRmhPy/KCX4AZam9WFMconEcWNrwZGk9izr12RfpUw==
X-Received: by 10.28.129.86 with SMTP id c83mr222551wmd.37.1523329855958;
        Mon, 09 Apr 2018 20:10:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g185sm1775672wmf.40.2018.04.09.20.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Apr 2018 20:10:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 03/16] replace-object: move replace_map to object store
References: <20180406232136.253950-1-sbeller@google.com>
        <20180409224533.17764-1-sbeller@google.com>
        <20180409224533.17764-4-sbeller@google.com>
Date:   Tue, 10 Apr 2018 12:10:54 +0900
In-Reply-To: <20180409224533.17764-4-sbeller@google.com> (Stefan Beller's
        message of "Mon, 9 Apr 2018 15:45:20 -0700")
Message-ID: <xmqq4lkj4uyp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  object-store.h   |  8 ++++++++
>  replace-object.c | 17 +++++++----------
>  replace-object.h |  9 +++++++++
>  3 files changed, 24 insertions(+), 10 deletions(-)
>  create mode 100644 replace-object.h

With this, the relationship between an object X and another object Y
that replaces the object X is defined only within the scope of a
single repository.

The exception in reachability rule around these replacement objects
is also local to a repository (i.e. if traversal from refs reaches
X, then both X and Y are reachable and need to be kept from gc), so
I think this is a reasonable way to arrange things.
