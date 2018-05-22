Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF7361F51C
	for <e@80x24.org>; Tue, 22 May 2018 02:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbeEVCqT (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 22:46:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42809 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752569AbeEVCqS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 22:46:18 -0400
Received: by mail-wr0-f193.google.com with SMTP id t16-v6so14661638wrm.9
        for <git@vger.kernel.org>; Mon, 21 May 2018 19:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5VNyJgS+K98StAjQ+JGXkBIUXunf250486upxS5zyE4=;
        b=DGsenvOdo46IRKa116oqkHQCw5wD8lS3hbq16aNqqJSXJJBhJf9aGmgLTa7UD7f7IA
         w/1eb1L+BG4ziRKY3T7dVcH49ugsTAB+RzOH/FoyW3Ive2jpLJsBT0itlOnzTpsNHTgK
         UV5th9q3CKYmH+Mt2Nuq4TFxG5ltaS9f4m1SDthv63geYZ+lTsDKNKzGDU79ltjQjWB4
         y4oAfKQt9YpCzeq3iKok8x0DBJ0lNxtifEvCcK/sbyqWQk2TwUXdsZNwvVQVSWQX0/p7
         Rx5lPI9N+MPH4pSVVbPjxpMnzD9SfJk7NDZF1O5SqM4NV83PqJdW47yt8MkDNMFd56au
         xg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5VNyJgS+K98StAjQ+JGXkBIUXunf250486upxS5zyE4=;
        b=F4MsqCLmLSQuUWIV4eJKMUCQH6ecv+xau+Qm6MH5DeYH6gjAXSr6d50dClWz/u4Vx6
         jAI/wZC3H9uiaAIqTJbwPpqCaCFsJFCbLkoBODHR/GbxaJkwl+vBzcVkT4OyBsJnW7Qf
         FtFmPb50bRs5eU9kC8x4RAfxl2mMmkqIbsr4BLNZsXfMUvKpD+eMyXdetN41XwHiSsDT
         7yQKRIEDKjDYiQldhc17nWXR51AADOU6D9BsnRBhrnUDuDCy0gXSG706kHu6dgbeHzLh
         PrsgMZT/nAi/Y0kYhoD/kkU+9S78muINgg8uIH+gvQ8Burk/5gdaHo0cio74osWtVET/
         dZDw==
X-Gm-Message-State: ALKqPwfwhYVgRcALCvx3xjp2G72do+gsxUUZ122P6dRP/4q+/i/mWnz1
        OSxCR327pil1ngxIqq7aCAM=
X-Google-Smtp-Source: AB8JxZp/CQkzpm+El66GvBRqLwRhqTJVTZIPqlcxYSi1WsXsRMo/4rb2Paq64TM/Kd8aGV5ADRQvRw==
X-Received: by 2002:adf:af41:: with SMTP id z59-v6mr1040wrc.250.1526957176689;
        Mon, 21 May 2018 19:46:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f8-v6sm10962786wrf.67.2018.05.21.19.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 May 2018 19:46:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/4] unpack_trees_options: free messages when done
References: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com>
        <cover.1526913784.git.martin.agren@gmail.com>
Date:   Tue, 22 May 2018 11:46:14 +0900
In-Reply-To: <cover.1526913784.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Mon, 21 May 2018 16:54:24 +0200")
Message-ID: <xmqqa7ssz9u1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> I've taken the six patches that Junio has queued and rebuilt the series
> to get rid of the new and possibly bug-prone function that no-one uses
> once the series is over.

Hmph, this unfortunately depends on 'next', which means we cannot
merge it down to 'maint' later to fix these leaks.  I guess it is
not a huge deal, though.  We've lived with these message leaks for
quite some time now and earth still kept rotating ;-)

