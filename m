Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8627D1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 21:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfA2Vzr (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 16:55:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38391 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfA2Vzq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 16:55:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so19580034wml.3
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 13:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gDyu2gRL5YmMxJJzTUDd1Nh2ZjKkHbXIBj7BRCtamcw=;
        b=UwGpG0du5kzBtIj2dF2lbON6BkaWynCbDPS7CXBk7kQjseggiYVRQq3VYPS5rdLiQu
         Z+qz3uSPBY+iN2KMr5UNUa2EyB3CZXF4da2ZFNWDFRrvLUZyrD7SETnxTWz/kOdpedL+
         D/dqk5XJUOcH9xJ6bXTiH8pNjnE9LYDraXgaF76i7BgNhvmIEQMP/pnlUdi4ZNDAixcY
         7VGa/abQoq4DAxL4YPy3jVyCXqswwQ8NcTX3gTTWUGvpFy7pwBwdz8qYMuhC5yGXEPzs
         PEiCBgv00/P7mvFike6uZM1RFVeMcrG0dIHtPtLuyohaIaLfuWTkp0shYsg2qG9WgqaC
         TWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gDyu2gRL5YmMxJJzTUDd1Nh2ZjKkHbXIBj7BRCtamcw=;
        b=rjPHZ/2BVTsKlO1j2WF2Q3AXQvdaxCYeKnTLqmNpQbZKtkqHCYnCJsEmSQDoohAKz+
         fuQujdranJMlbbeCW+l6mFndyCZ4FOXyRWmnNVHz7jheyfdKnPekBj7uSHPcuFadT9Xd
         6PR6OXRYi5+WZhHI+mGRSKRc3XhcbUoG84ldWgtcmY6hiBYFAqhG6pKjAMlie13fCa1L
         R7TH69yDljZ3rfsIGCNaieRAATB9av0xWaP4m21z2ym6voc5SQIzDnnhuH2srtsENYfo
         3TTq5U04E9eVDmbfaeVWBAqTwQmGlb7ZFQ/r8KlbsQayGTtDGfQ7k/DE2KrJcjNqvL53
         MKxg==
X-Gm-Message-State: AJcUukd8OKcOIl0uIM3GnSTZ3Ct46WhSKhx7hYH9QkhW395QF1tcVR9c
        Y6mAsl27xlVtn5p4mFwaork=
X-Google-Smtp-Source: ALg8bN53cmSrt55GtbzwWQylqN7/HiGC2vxKNUZ3+40fXvl+7sBWtn3qsVlJokHBIlQq9o5NEaYaeA==
X-Received: by 2002:a7b:cf0f:: with SMTP id l15mr18720389wmg.30.1548798944377;
        Tue, 29 Jan 2019 13:55:44 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w80sm33689wme.38.2019.01.29.13.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 13:55:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v6 10/16] sequencer: change complete_action() to use the refactored functions
References: <20190123205821.27459-1-alban.gruin@gmail.com>
        <20190129150159.10588-1-alban.gruin@gmail.com>
        <20190129150159.10588-11-alban.gruin@gmail.com>
        <xmqqo97z6x2v.fsf@gitster-ct.c.googlers.com>
        <822aa023-1603-a5c4-7693-9653a492b9a0@gmail.com>
Date:   Tue, 29 Jan 2019 13:55:43 -0800
In-Reply-To: <822aa023-1603-a5c4-7693-9653a492b9a0@gmail.com> (Alban Gruin's
        message of "Tue, 29 Jan 2019 21:33:48 +0100")
Message-ID: <xmqqfttb6sdc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> Indeed, this semicolon was removed by 29d51e214c ("sequencer.c: remove a
> stray semicolon", 2018-11-03).  But this commit isn’t part of nd/the-index.

I thought you said it was based on nd/the-index, so I've been
queuing the topic since earlier iterations on top of cde55548
which is where nd/the-index was merged to 'master'.

