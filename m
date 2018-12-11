Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6526820A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 02:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbeLKCX6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 21:23:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38454 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbeLKCX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 21:23:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so12488962wrw.5
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 18:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rVKLf45evzKHpZaQdKPOCylwcsX89AA8N0rDQlZO2QY=;
        b=QROZYu9Ovyhnt2moCJ7zUFtT4h1XCOGw7uQbF6NnTYxIwJyHFnTg9rt10lKHx8c/nM
         YMeUEc8qnUVA2yycEcwBWuvcXDy3k/mPPQ8V7M3US/kTK30oIoM8aFDJk1yEboAypfwf
         i9qN7Rj976h51baWIcLqjugboNVlxwV43zwZUkHEPjkJCBtS9c9V7qXq7IWSfyD5aS2t
         saethsZ26YcATAHMLgyrYmogCnklpIfs66G/3UlrCn2E34NFxFmDYtXf9jQ3jdq+3BVC
         c12omGfHh84ufGUnmEHz/CWDWtkvu3NpddMNuPweF4B+qbTGBlNvfHdl/Lil5ftaYKtD
         bBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rVKLf45evzKHpZaQdKPOCylwcsX89AA8N0rDQlZO2QY=;
        b=dmvobDAlmc3YgdsVcv712arjGPpKr4DoosKaubc17npIAS/qNP9VndyBSao+3prksC
         zdX8Qo7g6PIp9NBQvhvhOSh0ezJMYTigPl55VZjiCH5DJxce2KTXUjWBa0XO4sWd6skk
         cWCdaByLsHveS4fwhe1UqmqVTRJPK+KpQ04cTo95qpuA0o3NdAe5D0b45jnU9pxODh9K
         3OGChD8HQJ+7JvhBMMo8ytBBxuMwBqb5NOKMYL9ISuFWZy/uIFjNt69gJ2/DTdDe5F6u
         QhiSE6SSJ1s24DHPmzYEdOigJgUv/kSXfywcX4stszXLS+hgDsXPYGaZesmREzv6s8iV
         Kalg==
X-Gm-Message-State: AA+aEWZMQ1EuJuJEpcM+1WUAxQriwzuNaLbo3OPmAvAQnV4teowq7Q9R
        p8AKfN9/8bwh7g4+nwWt+M8=
X-Google-Smtp-Source: AFSGD/UUuIensAhrzrbPbU6MFzQe5u6Pm5gMOicZJ6qqQhKvyHE2Lpg55YB574YTI8noWm6CNCs/ag==
X-Received: by 2002:a5d:4ec4:: with SMTP id s4mr12319652wrv.187.1544495035898;
        Mon, 10 Dec 2018 18:23:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d16sm304104wru.52.2018.12.10.18.23.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 18:23:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/8] entry: factor out unlink_entry function
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-3-t.gummerer@gmail.com>
        <CACsJy8AGerhjnT0O6vT264tND78N5cbgFREzYtdmriXERu0Jtw@mail.gmail.com>
Date:   Tue, 11 Dec 2018 11:23:54 +0900
In-Reply-To: <CACsJy8AGerhjnT0O6vT264tND78N5cbgFREzYtdmriXERu0Jtw@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 10 Dec 2018 16:49:57 +0100")
Message-ID: <xmqqftv4n6md.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I wonder if we should move the 'removal' variable in symlinks to
> 'struct checkout' to reduce another global variable. But I guess
> that's the problem for another day. It's not the focus of this series.

Before any such move, I think it is important to notice that the
thing is not thread friendly and devise a way to deal with it.
