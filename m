Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2735C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DE1613EE
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 00:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbhD2A1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 20:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbhD2A1w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 20:27:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E73C06138B
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 17:27:05 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id j28so12424450edy.9
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 17:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9HUE8JyoDPl/zYOwrx+y1fI2jnpLr7zP5DtHQvPpgLE=;
        b=Q2F2IY3a2bbXZyFG1PWWHhK+3mvDw1G2yyMlMQ8sXafJ8PHrSP0WVX7cagyQQehx+Y
         AECyg85IqdXDWk0ETNTEu04aRJjmwojvhJ5S8bFMXdXaNTzH4lp3+lAxazMEplfbtYu2
         060ROKhSsFOxGE0Ec27d8asIIjOcHrwk5UdwN/YEzZZ/IqD3xxkY8CEG68I0au921GqY
         chbpv4mosgROYh7dqgt9T1HP4D2x2uIrTXyczApZrLQ3fVhJlN6IKeatMPM0y37MWB9P
         Z6VXqYnXf6qrgZqiEs/uWJbM7HC6plFus+J1iTHsDRoB9oTjIt0s4sEi0CDdVG19Zy6r
         9gIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9HUE8JyoDPl/zYOwrx+y1fI2jnpLr7zP5DtHQvPpgLE=;
        b=Aj2J+/SoG+LxO5QIZl0C2nizrPnx4qCvY/UVLjzCuHcQmA8HLjwBOScc3oVtYGUIAK
         KoFBKAacA2TMBM2g+inlg2D5KW2KX5br/6i5aAFdeEERREiVxXhvxB4nki9yBEC7bumg
         I7BRz9uk1W62QHdF7XnKR/kjjEqpBGuh4xAdnLjc1EJ7LB2rqqxdRJ6O0t0ZlyWilBYB
         96IGaTIMn6M2Zkb9GfFm1jzZS82WNP8vW0dg7IwfyRH8hGoVJ2sL2wM4GuJbHQrYSHm5
         /vhOtEX5pZiOW0JCc4H/DgUgE5btPaqKDIKjaUEaIxfvlYj6W9jnIGGs5nEoRS4dgpX7
         mQiQ==
X-Gm-Message-State: AOAM530BxFValEsHi4LRRJfFuwP5BE+aouwtyGvBCYvN1k4DrlYuQHrR
        EMncuaICHj67UZT/ceGckV4Y1U1a+pX2cA==
X-Google-Smtp-Source: ABdhPJxDuruq0q3ocpbwKsWg3Q3AqzZUn7Lky+tzZ4+BmvoqBDn+BagyNcmwiDj/WbtcG3O/2JzOxg==
X-Received: by 2002:a05:6402:5a:: with SMTP id f26mr14885590edu.285.1619656024060;
        Wed, 28 Apr 2021 17:27:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c19sm1087601edu.20.2021.04.28.17.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 17:27:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     dwh@linuxprogrammer.org
Cc:     git@vger.kernel.org
Subject: Re: pkt-line and LF terminated lines of data
Date:   Thu, 29 Apr 2021 02:12:00 +0200
References: <20210428222219.GA982@localhost>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210428222219.GA982@localhost>
Message-ID: <87bl9yylyg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 28 2021, dwh@linuxprogrammer.org wrote:

> I was just reading the Documentation/technical/protocol-common.txt
> description of the pkt-line format. One detail that is left out is how a
> receiver of pkt-line encoded data determines if a line is binary data or
> contains non-binary data.

They don't. The "is it binary" is a client convention / awareness of the
consumed payload.

> The documentation says:
>
>> A non-binary line SHOULD BE terminated by an LF, which if present MUST
>> be included in the total length. Receivers MUST treat pkt-lines with
>> non-binary data the same whether or not they contain the trailing LF
>> (stripping the LF if present, and not complaining when it is missing).
>
> It seems like a pkt-line with binary data could easily end with 0x0a
> (LF) and a receiver would strip it off even though that is a legitimate
> byte in the binary stream. I don't think receivers should be trying to
> determine if the pkt-line is binary or non-binary and never strip off
> any 0x0a bytes at the end of a pkt-line.
>
> The client code that relies on the pkt-line receiver is where the logic
> should reside that figures out what to do with strings that end with LF.
> The pkt-line receiver just parses the pkg-line length, reads the correct
> number of bytes and passes them along for further processing.
>
> What am I missing? What should be added to this documentation that gives
> more detail on when/why/how a pkt-line would be determined to be
> non-binary and the LF stripping would occur?

My reading of the quoted documentation is that it already matches what
you're suggesting it should say.

I.e. it doesn't anything about how binary data is handled, what it does
say is that if a client knows that a line is non-binary it should be
treating "foo" and "foo\n" the same, i.e. being lenient and interpret
both as "foo".

See PACKET_READ_CHOMP_NEWLINE in pkt-line.c, and the entirety of the
commit that introduced the blurb you're quoting: 1c9b659d983
(pack-protocol: clarify LF-handling in PKT-LINE(), 2015-09-03).

If you tweak the pkt-line.c code to do PACKET_READ_CHOMP_NEWLINE
unconditionally you'll get a lot of test failures, digging into those is
a good starting point to see how the binary v.s. non-binary cases are
handled.
