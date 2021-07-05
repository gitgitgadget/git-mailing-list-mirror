Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393CAC07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9276196C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 17:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhGERdf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 13:33:35 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:38305 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbhGERde (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Jul 2021 13:33:34 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 555653200942;
        Mon,  5 Jul 2021 13:30:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 05 Jul 2021 13:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furrypaws.ca; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=fm3; bh=CNOI4OhlzLrB+tK36CP5M5bcbg
        mU3qjiVa6mxetkU3M=; b=eA0chMxgRT/wBbeU4PexUHsdHW8COqcbgM/0/VkOlh
        xwoCzvaJjJp3SvyFzTPHt8WRbgLe/aDNdGLnMaIYZnjFL/6yJ/ZArzcXDo64h8Oy
        gHi/HO6HGwT3Bm8DVs/1tj8yf1KXbE3sorfvb7htL+WBkuGMGUtpORu4t5uXgn3t
        SRqtxh3nS3Vr7gFOr0jAUOS0TS5H+b2P+GB/taaZtQOEAE5yrnummid9MvDG+XfB
        cfwG1LXArGjbkuUqYGlpie1zArfsLgku3PtzRiqDsXSVPkvM5cdHEQfMnH25xOiJ
        h7RSHmjt6KWTHaNr+6nHhepbDnoawAhAzZ4iQHgvQmag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=CNOI4O
        hlzLrB+tK36CP5M5bcbgmU3qjiVa6mxetkU3M=; b=rdqx2Qfj1ll/vhWhUv+n+q
        obWtto8KJ7326HrHdoTQqiwQLZHSLvFbgfEHYuxMt7+vrQVNRXtA403gy+k0guF/
        By5OgepKhqWpguz66Z8TB49WbDNIkH9UUJ7TdKusO76W9iBUfCWXH+uAy9BL9gmq
        OOpmnbg41TwrcdMP6J9WbwKFsT5G70EZ8DthDBxMRsBujShRiK9E7kvKU8EVs3rs
        AG0kKunYYxZ4FZLkrXxhmFpKAL1Ji3ekxgDRK6ppON+e6LDstTtwhbz77UpuEVcz
        ryP78eIZpic1tug0uAsze0ZyQQAM4FC1WuW7D0t17KZqvSqKriMve6z+REAQWIgw
        ==
X-ME-Sender: <xms:0EHjYKQAjjgEMsDqtiWIlaL2tvGKNRG6_NJeQPh1K7sjziPIuuhhSw>
    <xme:0EHjYPy5L8CqBBy1krXXRC7-wN9JPka6oFsplKzw-hJxjPrbh2dkU6uhRp456eq23
    qJZ3hr25ncBiKVkzw>
X-ME-Received: <xmr:0EHjYH3wGqnCZNk70iEjThliG3SnG_xDhUuDS6wTdXXw9VmiUs0kY3n4afZ6O4BOOPNG0QJNJOzr6PdY0xXKwfeYZGrW0Ssg6-IE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeejgedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffoffkjghfgggtsehttd
    hmtdertddtnecuhfhrohhmpedftehnughrvgifuceuvghrrhihfdcuoegrnhgurhgvfies
    fhhurhhrhihprgifshdrtggrqeenucggtffrrghtthgvrhhnpeffueeiuedtvdehheevff
    fhtdevhffgheeggeefvdevhefhiedugeejgfffteefveenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesfhhurhhrhihprgifsh
    drtggr
X-ME-Proxy: <xmx:0EHjYGAfqJIXRf4Lk_QKauuMshe_02f10Jb3-SLJA83fh006eJDWaQ>
    <xmx:0EHjYDhgieYoiqINOLY1y11E_XkiWOuTmGYQLhug_BNnK4GflEue-g>
    <xmx:0EHjYCrkdln36zEl6MUwpQLrG5cMDXGeZIhINLbeVej0LHncvQayfw>
    <xmx:0UHjYJZyQ4LB9CD7zdSpgkHs5iETJvJ5vd6ZgefpvKn0a5jIj1RaWg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jul 2021 13:30:56 -0400 (EDT)
From:   "Andrew Berry" <andrew@furrypaws.ca>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, "Bagas Sanjaya" <bagasdotme@gmail.com>
Subject: Re: [PATCH] docs: .gitignore in parents is current repo only
Date:   Mon, 05 Jul 2021 13:30:50 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <889D9AD1-1114-49B4-ADB0-BF78160743E4@furrypaws.ca>
In-Reply-To: <b9da43a8-897b-7cce-ecbc-ea56078f0f09@gmail.com>
References: <20210702222044.72767-1-andrew@furrypaws.ca>
 <b9da43a8-897b-7cce-ecbc-ea56078f0f09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2 Jul 2021, at 20:06, Junio C Hamano wrote:

> I would have thought that "up to the toplevel of the work
> tree" would be sufficiently clear where the upward traversal of the
> directories ends, i.e. at the repository boundary.

Seems reasonable. What if we move that note to come after "any parent 
directory"?

On 2 Jul 2021, at 20:21, Bagas Sanjaya wrote:

> So for example I have `something/foo` in ../.gitignore, but .gitignore 
> (in current directory `something`) has `foo`. Is .gitignore from 
> current directory or ../.gitignore takes effect?

In this case, both rules resolve to the same path, so I don't think it 
matters? But in practice I'd expect it to be `something/.gitignore`, 
since you can negate the pattern from the parent ignore file.

> Also s/toplevel/top level/

That showed up in the diff due to word wrapping. If no other changes are 
accepted, I'll file a followup after to get this fixed on it's own.
