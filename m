Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808E2C4708C
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 01:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiLFBf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiLFBf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 20:35:56 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC24F1DDFA
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 17:35:55 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r18so12033541pgr.12
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 17:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzGJIEJa2c4ZyzbrZkgtBSq7sJW+iNDetuJ/8lHQKfE=;
        b=bUDL8OsnjLJtQErfFiHgj5GmyZyVOSnhoeL32iBapS+usq023z0qTjkujZd+4EVSdn
         3ukzOI1kmlQyvPpFFG1MVUjkcYvdWG4JQor78PRMUQPUNGo4wMYYFRyiZxAc3AHCosM9
         QBPGvU/LkT9idH48vcqqN/4CMk2imIbYn2u9W5B4MQ64l+GU0ZisYlKvxK2mWmDLxY+Q
         yU6xKFfVbnltrUaP9EyHm7XzUCWDGjzBfw116delYI5iWkewBIYMDI/q3xWH2uZ8dSBD
         YNp4IXWD/VczLa69vZkyV6l0PXsfKLGDRr+CgMPZU9JKq/i0uRe9UO57btPk/2peDDHj
         UVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MzGJIEJa2c4ZyzbrZkgtBSq7sJW+iNDetuJ/8lHQKfE=;
        b=2JoX8f1nIsU560TrACqloY/707WaANOaiFzeRlrz6YcyIDo0ZN10lP+R4uIq9/8UDz
         HZ73j+5uDdvDfbbfprYUtYk0PzXjXKG4ZD/e1fy4E5M4gUmbgAlMEQSBPAg/ZWlMrbt8
         UQL6hFU+m/mTVzvaZ4RMMljIbcSWZy85qSRD3UiONaZJ7Mm2sg2t9BJj8kEhqEwdxqEC
         LzHehq221wRlTlid5RDs+aWxwBL3WjAKDmj+wHVUz4GXxKUyfHsnAiOutfS9X2fLrRp9
         Q0DGTSi4WiuvCKjDaK+XwHlYEjR+u/vo1QtIm8IOBkPxmQVASf6FIqOOCreCMosgwMr9
         qJ8g==
X-Gm-Message-State: ANoB5pnh6ah/0WmzgW89fVFjivGgMN8QB3H1JB+UB50QRNz96SzXsM3x
        p9XAt7wli0W2D/+iIU0KK2CHb1ean2i3EA==
X-Google-Smtp-Source: AA0mqf56/pWNPmWUZUBecgRx+BToZy1HQjaqCvANdw9SH2WCpreX2tihCSPdG8nTsvKbsPlL6w0alA==
X-Received: by 2002:a63:e30c:0:b0:470:8098:f0de with SMTP id f12-20020a63e30c000000b004708098f0demr56987980pgh.527.1670290555037;
        Mon, 05 Dec 2022 17:35:55 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z6-20020a6553c6000000b00478bd458bdfsm2220477pgr.88.2022.12.05.17.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 17:35:54 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: introduce CALLOC(x)
References: <6694c52b38674859eb0390c7f62da1209a8d8ec3.1670266373.git.me@ttaylorr.com>
        <xmqqedtdpfoe.fsf@gitster.g> <Y46M4oksPQkqwmTC@nand.local>
        <Y46ZJUsyp8UW5rFW@coredump.intra.peff.net>
Date:   Tue, 06 Dec 2022 10:35:54 +0900
In-Reply-To: <Y46ZJUsyp8UW5rFW@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 5 Dec 2022 20:21:41 -0500")
Message-ID: <xmqqv8mpnwjp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So you can think of "allocate this one element and zero it" as "calloc,
> but don't multiply" or as "malloc, but zero". Naming it CALLOC() is
> thinking of it as the former. If we think of it as the latter it could
> perhaps be MALLOCZ() or something. I don't know if that name is too
> subtle or not. We have xmemdupz(), which is basically the same thing;
> it's only a zero-terminator, but that is because we are writing non-zero
> bytes in the rest of it. Mostly I'd worry that it is easy to glance past
> the "Z".

I think the name for the former would be CALLOC_ONE(), as I would
rephrase it as "calloc, but just one element".  I agree MALLOCZ()
would be fine for the other interpretation, and I do not have much
problem as much problem with the name as calling it CALLOC().

Thanks.

