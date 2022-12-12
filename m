Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75642C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiLLVoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiLLVoB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:44:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E2318B22
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:43:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so1368413pjj.2
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gDXnqxdzDZ8NBP8P4U3dJSZAzvIcjsWsnj59M0UoTEc=;
        b=AVxyA6fczGJgkyc3hkVqrSLaH+0WIS70EmUuu2elXCvFCwUrqBN1IUvNzgh/Xj13HW
         U8wRLzPBgLvYLNibdpvwn1BoOY1ACJOBO4c0umGXkREwrvzwcFsFlSxs77KMqRNukzrZ
         hXdy2GNBBEQPwqehXsKJ7E1NvOr482NaW39jZvmXCf8tnJi4bat76szEEAzLKgMvkIxP
         EDgbJNBhvMaO/rpf2rbbhuhhl4f5JHwcuueMhTfuL55nEnwtn47JLmWlHZ3ez9R2vscg
         9rd81RI5w+Ll1+Lv+c4NTkd/6QSz895tuvdBbYD8dvWvKwX9hI9WRbChL1jmDqi7sv6k
         VKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDXnqxdzDZ8NBP8P4U3dJSZAzvIcjsWsnj59M0UoTEc=;
        b=JBV32CpD1L7tBMssi2GURK7Je2uWMZ5W466VAqEVjsxPhUOFRd7HiXFgc8kbh0H8vy
         1RhPis0XU/yYuJluIDH47HOeewMd3iZw6Ky5ctFRYI1I6YmU6lIJhO2393KWJcZkk8Hq
         c4rWTYE5gAEBzqh5+AnGU+jHN3TUENslBnLCd+cC4SFGHaW9mOLMmTYmqXQ0O+c9f5X1
         QtDziuRcKOPcbpwcF4I/oAKlUf+dhvmNIqwOmid6FPlTU6pbTBW0N9KFkQR6FuUBOa43
         RshE+VKqlbYL+q7xGsfFH0wfSQXhhnf4LPqsAOBEp9wBI3Ieo8t06I46xnpHIbAXB+rc
         ibuQ==
X-Gm-Message-State: ANoB5pnjYKMGogEzRYk30LouMgIwJ92Kws80S4Hnxmy3xoVPn8J12XEM
        Rav0rDHWapHX3PDvkYSVfPFb0VUu6lommg==
X-Google-Smtp-Source: AA0mqf4DqyTzw8gFBOxaGISDlBa1696DNOZet9M3I+cwbKh97IGoKgCWIa9obDTeIMhOhtuERxn57g==
X-Received: by 2002:a05:6a20:4c1c:b0:a5:6b98:499e with SMTP id fm28-20020a056a204c1c00b000a56b98499emr19223219pzb.6.1670881438702;
        Mon, 12 Dec 2022 13:43:58 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id x19-20020a633113000000b00478dad38eacsm5661759pgx.38.2022.12.12.13.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:43:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/drop-mingw-test-cmp, was Re: What's cooking in git.git (Dec
 2022, #03; Sun, 11)
References: <xmqqpmcqv7qh.fsf@gitster.g>
        <o428pr88-sn2p-o715-52ns-1r6750762572@tzk.qr>
Date:   Tue, 13 Dec 2022 06:43:58 +0900
Message-ID: <xmqqa63ss3fl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> There is a new iteration available here:
> https://lore.kernel.org/git/pull.1309.v5.git.1670339267.gitgitgadget@gmail.com/

Thanks.

IIRC the review comments hinted that MinGW specific test_cmp that
equates CRLF and LF are no longer needed, so unlike the previous
"let's do 'git diff --no-index --ignore-cr-at-eol'", the final
version can just use "diff -u" like everybody else, hopefully?  That
would be an ideal endgame.
