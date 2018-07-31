Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CBF21F597
	for <e@80x24.org>; Tue, 31 Jul 2018 20:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeGaVyQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 17:54:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46700 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeGaVyQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 17:54:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id h14-v6so17897115wrw.13
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 13:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=39qt5TyDvDH9U6/ZRvS2K4niXgUJw44d0WJE8bPynGs=;
        b=g8w1XpRBJ8Vtgkz3RWN18Vs0rqc9JSM7cJ76SrhgNFaNiS5Cv+EP5i0jqJ+PKlo5dk
         vPemnRQP7QEsoMwF1xQFyoCJgVLahOF+62tFjaQ4mBQNbHfqcZ/yvPwiD7LrQL+tAlRi
         2wJMZ/K7/lp28TlCm8P9+aUOqZFMNp9jvCkOJu7L93YfQyAiCMMPl5bltqCgVCAOjblo
         lw6IYEXe3a+MQ9dXzcrGHjs0xM7vCq0Npr/b63n7Pc9ZcSZSM4FeGWgF9sKmFMg+TiUO
         esDyYcVR8AEYsCZSvkTSvG8gL0L3b9PnOroVewIhlQFlvNkTQuH6h59g/MutBkKbWOsa
         XzMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=39qt5TyDvDH9U6/ZRvS2K4niXgUJw44d0WJE8bPynGs=;
        b=cxaNDw6t7WF/f2xiEOSvi1G+DIIYaC4orQuCUeiN9LfC6yda9vaqRAqTTL26YI0PFC
         lnTuvbHLC6WUtWnfTI6lvBVzFU45QMmTrvhspvuqGMNjceqS3QB+cQqSkv+eRnV/3T0w
         txdGlAuv+PHAWtSgCZbc5KcAuqdgXIhxElqyUVDTan98ptiKdfNQTn/sej6dzTdlasAd
         0PXLRklIXqItDnN7kv3t2Otn6PT0n8RNNYutKv5cNmu4xu5eNbzFqw9iSSxkBVfl8KQq
         L+lUrFjHlkzH5uWraO6D6U/4T+Z2L3NbC0qE+lwys/wlFhOKRbteIoxSXMKWjLCxkb3i
         4KGg==
X-Gm-Message-State: AOUpUlHZRTzs1DGwNXJd27wKbrkeoWm3x43vjopl0naANcxT8gO6/69l
        FyYLL0GgHwW1Bi8/xlnTgiE=
X-Google-Smtp-Source: AAOMgpeRIUaQPyaal++OsCVNFvg3jB2lUFOu6K6yhZ9Evw6SVJYKY3J0ifiGJN8owu+6y4Wwy9MPXg==
X-Received: by 2002:a5d:6345:: with SMTP id b5-v6mr22526076wrw.266.1533067935826;
        Tue, 31 Jul 2018 13:12:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 139-v6sm5960674wmp.4.2018.07.31.13.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 13:12:15 -0700 (PDT)
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
Date:   Tue, 31 Jul 2018 13:12:14 -0700
In-Reply-To: <20180731192931.GD3372@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 31 Jul 2018 15:29:31 -0400")
Message-ID: <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Jul 31, 2018 at 12:12:58PM -0700, Junio C Hamano wrote:
> ...
>> collapses two (or more) paths if we go that way.  We only need to
>> report "we tried to check out X but it seems your filesystem equates
>> something else that is also in the project to X".
>
> Heh. See my similar suggestion in:
>
>   https://public-inbox.org/git/20180728095659.GA21450@sigill.intra.peff.net/
>
> and the response from Duy.

Yes, but is there a reason why we need to report what that
"something else" is?

Presumably we are already in an error codepath, so if it is
absolutely necessary, then we can issue a lstat() to grab the inum
for the path we are about to create, iterate over the previously
checked out paths issuing lstat() and see which one yields the same
inum, to find the one who is the culprit.

