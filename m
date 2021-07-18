Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E2C636CA
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 14:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2459561182
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 14:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbhGROPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 10:15:31 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55015 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230486AbhGROPa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Jul 2021 10:15:30 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 28B425C0048;
        Sun, 18 Jul 2021 10:12:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 18 Jul 2021 10:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furrypaws.ca; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type; s=fm3; bh=wHJq+wv1tENk/H/Puoiyf67e0f
        IYMbt6riAfB6+3lgQ=; b=tzk9MjYGCozq0CPU5zAMlaGaNMxCnNWFGF9y1ogBjC
        Z6WAllJZNlkKhwJnYIDpTi0S9JBgIJVL35EWADnB9AGCRZ3oReQZpIDkwHEygJ4p
        XeRDASeAUMZlgBGT66ZdkJ/TpG7hL/5dbgaIWklAleJVxHDHk9+NnnnfGMdAbcs6
        Q/9fq+2TrZiKX29X84iGOM2XcrszF/YPGynfEa5Y2qI2hwtinpBP1MxRhrNneyyz
        rbslp8ORKcgqwdhBgI4DpUqCynw2YZC5sWeJvhvF4jtRG6+Ei8TNkzjr1YXf/y3a
        arcpdNXO+Uw8oSLCN9yd8rQgkdky6qZOCtQ1NWRzHK2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=wHJq+w
        v1tENk/H/Puoiyf67e0fIYMbt6riAfB6+3lgQ=; b=HWstUV2jiQn5Jnkhx8Bzok
        eZP7Lv1FE1zXXCor5RKprsW4a99dEAOhudOp9k6I9R9p9zAh1kCpb5zCokZ2L/pc
        E2mV2xcGc78JeWo3bOfYoVG3P9bCCu+R16NvahbrvUBOegggOp+qyBp08uAp/4lT
        LaZpzFxWhLOMY4t465f/zCaJK7RpSaD3eNNKk/a1e7ejjX9jFTHkO1KivjBt0Scz
        NMwvzjuaLTnFkoGNfVuplTmZv88sJV/cE4Ju6pMt7BDZKVM0LntTFLT3XZ0wHFzg
        wXc+crpPq+5pe09zqAK8a4qn8O0PbTSUWJvSFKT9Alh3IIKk7ofSdcr/c1AjrBJA
        ==
X-ME-Sender: <xms:zTb0YA-7L5UC7qHR3L-2s3iEwYJPMrwGGaUVpXKC5oMcRWFpP0IELA>
    <xme:zTb0YIs7LCOxmHJoZIP4C2rASLhoN3gSZVfr9daanDE2WTOigPClniGh58pvPsno5
    LHzZGFia0DtYlrhlQ>
X-ME-Received: <xmr:zTb0YGCU2BxPzWgxUClNEXQw5QC1ZASxDIEdqieQ-Cia4r1Kl8GKsojfmzMym5HH0X36IKcmZGuFUGmBqHvArWB3oj_X3xnu0FqMCGnu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvdekgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffoffkjghfgggtsehttdhmtd
    ertddtnecuhfhrohhmpedftehnughrvgifuceuvghrrhihfdcuoegrnhgurhgvfiesfhhu
    rhhrhihprgifshdrtggrqeenucggtffrrghtthgvrhhnpeffueeiuedtvdehheevfffhtd
    evhffgheeggeefvdevhefhiedugeejgfffteefveenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesfhhurhhrhihprgifshdrtg
    gr
X-ME-Proxy: <xmx:zTb0YAfZ6CoscBK86M8GXnJTefSZSetL6f8QO7w14NuD-i-zdzL_oQ>
    <xmx:zTb0YFN22NiRaOkWv8c-mVXC5jjSBKXjxhKapHp_wo424-B-vfOMUA>
    <xmx:zTb0YKmP410ZiHXbgDm79r8E7Z-dxJMOZiN2M2aYS_39Syj2UOGuCg>
    <xmx:zjb0YI2rBmJyabcEzWV_b4IRZBHmiAbyYE2VyQgux83nMXXXCHotAw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Jul 2021 10:12:29 -0400 (EDT)
From:   "Andrew Berry" <andrew@furrypaws.ca>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com
Subject: Re: [PATCH] docs: .gitignore parsing is to the top of the repo
Date:   Sun, 18 Jul 2021 10:12:28 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <52880F2B-FAD4-4E36-8662-A798B91B5C94@furrypaws.ca>
In-Reply-To: <xmqqk0m3gl6a.fsf@gitster.g>
References: <20210706205439.75015-1-andrew@furrypaws.ca>
 <20210706205712.75270-1-andrew@furrypaws.ca> <xmqqk0m3gl6a.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 Jul 2021, at 17:57, Junio C Hamano wrote:

> If you do "toplevel" -> "top-level" while at it, perhaps we would
> want to correct "work tree" -> "working tree".

Rather than think of this as a one-off fix, I thought to look to see how 
many instances of each are currently used.

toplevel: 246
top-level: 119
work tree: 538
working tree: 2610

Since many of these instances are in translated strings, and that the 
text is understandable with any of the variants, I don't think it's 
worth changing. "Our standard is no standard" etc.

That leaves bringing the note about the work tree earlier in the 
sentence. Here's a hopefully easier to read word-diff. Look good?

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 53e7d5c914..b4c8b9c0de 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -27,12 +27,11 @@ precedence, the last matching pattern decides the 
outcome):
    them.

  * Patterns read from a `.gitignore` file in the same directory
    as the path, or in any parent [-directory, with patterns in the-]
[-   higher level files-]{+directory+} (up to the toplevel of the work
    [-tree)-]{+tree), with patterns in the higher level files+} being 
overridden by those in
    lower level files down to the directory containing the file. These 
patterns
    match relative to the location of the `.gitignore` file.  A project 
normally
    includes such `.gitignore` files in its repository, containing 
patterns for
    files generated as part of the project build.

  * Patterns read from `$GIT_DIR/info/exclude`.
