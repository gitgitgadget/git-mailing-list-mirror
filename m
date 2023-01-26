Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AF0C54E94
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 16:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjAZQFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Jan 2023 11:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjAZQFV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2023 11:05:21 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEC3139
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 08:05:20 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id f11so1402596pfc.1
        for <git@vger.kernel.org>; Thu, 26 Jan 2023 08:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9V1EES7eAddyuMIokabgNUWd0hmCzVkNjaDVw/lPdHw=;
        b=eYrJsjmN3bpWjAreiGeSGMfDEfZ63uNTDRyekjPdyyXUQw4YM5GowRjFM3tCTEfVWz
         KGRp9tLHYcJRKYzy/4/Zn1CY9K/nhGZTjUEih8psLWkFre0WXHvPSRqibCbWE6XC2bRQ
         dafy+maTpFh39QnAC49NN6YCqPYMhTPoltkGoqEPUNgNkmzVx/QahOZjlHGor+7VlOTb
         OLK2/dFpbDc7Uv6X8hlOHt49X+2mL8nZ3go7ST/Avxy97w+zKrurOCXR2DvBqiwX3e4b
         Rwf61uap07OzeGygjhklqoMiUk7LmN6Cm/3j8vCGb3F0x9fKl69+bd15B6dPX+5p5Vw7
         JM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9V1EES7eAddyuMIokabgNUWd0hmCzVkNjaDVw/lPdHw=;
        b=HncGysSyMDazKY7CuGUYI+vxD2SSvddbezRdA7MXnlQPc2YZ/1olGmSmsntCPr67NH
         Asv+vY4UAY/WFETR4E1io9o2jLMmgvfD0ODRikgk/12NsAFudFfSmtScA9BP4L5ICfT7
         NeLFI6iTj/0E/5MVsGBlcsuo8E52zggtseqirjpYCrdqr47CZ7Rypv0bwwbxvew2V7H5
         TpCGSn9XulAXzSpkjdxBQ1LLEhfXVtsdSG+gTX1YNCAVzDyQBT62uFTZ6SXO7Ay/dRoo
         wgfb0cepsA0Z6zqGfVnKO0jN1enOOy3PnjAouqOLiPuU0kqjaUHQbU8GCOKva7Hb/RrS
         xpQg==
X-Gm-Message-State: AFqh2kpeHh9EA3BK4X3HOXUYlRbAT7Z1oM5SpjHif/9sCFkMr9D6o6aq
        i/t5mYVDENu3US79KZWUHF4=
X-Google-Smtp-Source: AMrXdXuPsHxoJ+nL2Mr0R/BiBePNlJSVsRZPCH6Ekef7Z/bN0lFQtvuZEH2kTRQdB8gZx0oWk22o0Q==
X-Received: by 2002:a05:6a00:1585:b0:578:8864:b25c with SMTP id u5-20020a056a00158500b005788864b25cmr44437782pfk.25.1674749119757;
        Thu, 26 Jan 2023 08:05:19 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id 136-20020a62178e000000b0058bc7453285sm975664pfx.217.2023.01.26.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:05:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
        <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
        <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com>
        <xmqqwn5bg695.fsf@gitster.g>
        <Y9JkMLueCwjkLHOr@coredump.intra.peff.net>
Date:   Thu, 26 Jan 2023 08:05:18 -0800
In-Reply-To: <Y9JkMLueCwjkLHOr@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 26 Jan 2023 06:29:52 -0500")
Message-ID: <xmqqfsbxcmdd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Thanks, both.  Let's merge it down.
>
> Sorry, I'm a bit late to the party, but I left some comments just now
> (this topic had been on my review backlog for ages, but I never quite
> got to it).
>
> Many of my comments were small bits that could be fixed on top (tiny
> leaks, etc). But some of my comments were of the form "no, do it totally
> differently". It may simply be too late for those ones, but let's see if
> Matthew finds anything compelling in them.

I do not mind reverting the merge to 'next' to have an improved
version.  Your "do we really want to add a custom server based on
questionable codebase whose quality as a test-bed for real world
usage is dubious?" is a valid concern.
