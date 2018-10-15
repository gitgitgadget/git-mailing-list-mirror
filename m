Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAD481F453
	for <e@80x24.org>; Mon, 15 Oct 2018 05:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbeJONCc (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 09:02:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50965 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeJONCc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 09:02:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id i8-v6so17373824wmg.0
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 22:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GQ7aNwAAq9VGh5n7m18HYss6KJxK+0o848xctaieLSQ=;
        b=J8+/KjF0jtyN2wQEOeSmqJOkWCFERcMTIym5X5GwXupq6eraBv6ujcycLiKbLAV1J9
         iLhu2pJwVqKbhkxrH7kz7jnzLpNYzxzcJHs4Bbv6dyLPLzH+8H558VL2n4X8Z5QMTyot
         O7aaPvvC27E+30VcJpCGyI/Y6lxRyfjY2LwZK4Yu8LFaV7Ivt3cD0rmCXaW5NDj+VGjX
         syUAbeJXwpvnstW5z7gEtcnTgBxsORpnh0+VNNlevgKvWrz8Q7/qXkzDp4zzJAMY0Z+V
         MrDv7v6qEpGzF1mtBEvDm60pFQJc2iiwQafAQfMqjEw/3ucSMmv2r6fOOGhQlNs2lLa4
         LvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GQ7aNwAAq9VGh5n7m18HYss6KJxK+0o848xctaieLSQ=;
        b=rugi5hJ9JEgARqOA+tRnrrWGsF+J+oK7o4wEizLxuqfAVxxCjEGWfWrWbGXOD+6X8r
         xXa4If9ujkxIQKhSgbwRXTApkuhw2PxSc4e3dppMK0hoZfqqa5LBMJ8Gg9wLdeDa52KA
         osrBKO9GOccplQ31bHam8F94eAYfK3zUPXpecOYXOSx+SzrnvFqMXia907bmkPWhzNCP
         +KSMK73wpcyOhQ/ZVVWff7VGIiwQM+HAj3wIzbmFDX89EWEt/NsXuV5+lvhyU9vorzqr
         wKxtk7lUzSuEpRexaTOzLfByicQL65MVJ4ajhMYkDfdhEPL9wVRE4TAKU/sZ+zehrum7
         G6Tg==
X-Gm-Message-State: ABuFfohpJMaI/f+N9KoWFTIG8qCjPSPIFCImsy66udPWr+8eHQlmPcZe
        vgMb56frQ/Z95uRowX5x6G2RdT74z3U=
X-Google-Smtp-Source: ACcGV626e0twm745bklrKBrPvT4NIYfCbX7BMnUiQTeKH55hZ17RSQm7DLFLtoS1AkbomlGbkKIOUw==
X-Received: by 2002:a1c:1782:: with SMTP id 124-v6mr12297773wmx.133.1539580733015;
        Sun, 14 Oct 2018 22:18:53 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a11-v6sm13129877wrp.3.2018.10.14.22.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 22:18:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] merge-recursive: improve auto-merging messages with path collisions
References: <20181012212551.7689-1-newren@gmail.com>
        <20181012212551.7689-4-newren@gmail.com>
Date:   Mon, 15 Oct 2018 14:18:51 +0900
In-Reply-To: <20181012212551.7689-4-newren@gmail.com> (Elijah Newren's message
        of "Fri, 12 Oct 2018 14:25:50 -0700")
Message-ID: <xmqq4ldn6b44.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Each individual file involved in a rename could have also been modified
> on both sides of history, meaning it may need to have content merges.
> If two such files are renamed into the same location, then on top of the
> two natural auto-merging messages we also have to two-way merge the
> result, giving us messages that look like
>
>   Auto-merging somefile.c (was somecase.c)
>   Auto-merging somefile.c (was somefolder.c)
>   Auto-merging somefile.c
>
> However, despite the fact that I was the one who put the "(was %s)"
> portions into the messages (and just a few months ago), I was still
> initially confused when running into a rename/rename(2to1) case and
> wondered if somefile.c had been merged three times.  Update this to
> instead be:
>
>   Auto-merging version of somefile.c from somecase.c
>   Auto-merging version of somefile.c from someportfolio.c
>   Auto-merging somefile.c
>
> This is an admittedly long set of messages for a single path, but you
> only get all three messages when dealing with the rare case of a
> rename/rename(2to1) conflict where both sides of both original files
> were also modified, in conflicting ways.

Yeah, that does look mouthful, but definitely is more
understandable.
