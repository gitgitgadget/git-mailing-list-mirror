Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35DD61F453
	for <e@80x24.org>; Thu,  8 Nov 2018 05:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeKHO7K (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:59:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42052 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKHO7K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 09:59:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id y15-v6so19770083wru.9
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 21:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=guRUBOeSJ9zHED1HA9eXbdWXs5XN5/j1ducvPOkzkKg=;
        b=tvm5+x9VhdiO5JZNPdVTMneuJJOzBxTdyj+V1TMcsoEeUv4hRSRsCTCCuxY3C6Bbu0
         8/rzL9ZrjvnqZjK0+AOqSQTQfzymBUoT6cZ1RBnCIF1sCnqX8W/V2hzsZ9h6fsiOUfmZ
         PRpu5FUliXP1KMY8VB82VMV6Sdl5fIM+eut/G2kag46QBb45CqAxuN1zq2I8IkO2yOyN
         uSkU8Tgh07S+kE2F9VCaRITzdD704kqFHs/4iV5Dsz5+dPu4rud29frOfKt0dSRV7FUs
         hyBG4SgTGOq6RzTP9hGfq7lt4GnWqCYgRN562nZox9EDTPYn9QjuNr+NgWCfeM5GOV3B
         Uu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=guRUBOeSJ9zHED1HA9eXbdWXs5XN5/j1ducvPOkzkKg=;
        b=pYCD6bMlZGlxniVcvQfw3mAlzAfg29lcbqYWTpBZrFk+OQHPY3u33jEg5FTPdC8vwE
         dx59apPodv5e2XMK7OJBejKMrQ4bu1WU23mc4F4E4vaWicEQj6DSyoqYY+vsBu3Ms5r8
         mvWfo3YNXxxOU+ejP9fEF8CFFzyvoSsWJeV4LQoL1DgRmdHtw4SBjhZm+e3A/pI5AVdD
         2hR4NVDUuDaQvFL0QRcBuFbOWIJgtfodLiJmls0qevGEdNjWiIPOiP9LesoG3IfoYt/g
         hRwhRRgkizr3HSLBvcga+sE6lcDcws95CdTLPv92WY7PBziG/V5ZiUcn/m1c3YX9Lwva
         CA3A==
X-Gm-Message-State: AGRZ1gJOJWSm7QGg47U9FPUA8mv53hMMcbrolvLofTscbXrVPU6w06y+
        SRGdUzdNr41KSLYeRT/J2Yk=
X-Google-Smtp-Source: AJdET5dbXx0v2wUgy3aig7eC0vl+vBiNj9Vl95i3xyLL9KD+xB6n+thhbkJsJKIvoZlHPlyn+yxfAA==
X-Received: by 2002:adf:9bd6:: with SMTP id e22-v6mr2439696wrc.295.1541654725916;
        Wed, 07 Nov 2018 21:25:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b10-v6sm1964298wrt.49.2018.11.07.21.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 21:25:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     <git@vger.kernel.org>, <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v5 10/10] merge-recursive: combine error handling
References: <CABPp-BG2rFEeKVe8ok+a-jLFvPBfnZs1b3Mp2Jfi2JgNZcO8gA@mail.gmail.com>
        <20181108044031.25885-1-newren@gmail.com>
        <20181108044031.25885-11-newren@gmail.com>
Date:   Thu, 08 Nov 2018 14:25:24 +0900
In-Reply-To: <20181108044031.25885-11-newren@gmail.com> (Elijah Newren's
        message of "Wed, 7 Nov 2018 20:40:31 -0800")
Message-ID: <xmqq8t2487jv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> In handle_rename_rename_1to2(), we have duplicated error handling
> around colliding paths. Specifically, when we want to write out
> the file and there is a directory or untracked file in the way,
> we need to create a temporary file to hold the contents. This has
> some special output to alert the user, and this output is
> duplicated for each side of the conflict.
>
> Simplify the call by generating this new path in a helper
> function.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 53 ++++++++++++++++++++++++-----------------------
>  1 file changed, 27 insertions(+), 26 deletions(-)

Thanks, both.

Let's advance these patches to 'next' soonish.
