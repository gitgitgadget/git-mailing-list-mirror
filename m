Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6CDC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 19:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjBWTfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBWTfn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 14:35:43 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420371633A
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:35:42 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id cb13so6464201pfb.5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 11:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIQdVXDk6fL+lxjW/laPS0XMbGzjYxa7jkibGaaKjbA=;
        b=WP0WkVobWaN46d6FVTTpXoyDx+8T/ZzWud2NBrwVF4B2nyAwyM5nAqq5UPqPFOukxJ
         jIvWHuAUB+E1O7rrNsTXUcZh3yDmr4B5WZ3ixB+K4BDJEOy4+K1xNLma0MkTA9L1YX/B
         /zKzfynUV8BxfWBs3NGq/kWMo+jJh72bXIw09xW1cZSW5d/c5scCkon6lUPvhxzIes2a
         NsiDYn3VnwXCYGhKjJnUZWNJeUWyY09RIc2ANN0RROwYSavxM4cX3G/z3qbx7ZsMMekY
         Eo3S2BB+ENLU+5gS8l7v6Zh04MLN/IHZPBaDS69x7MjKVeqO7bI9eIz6Zsyx4hGQ9q7Q
         +D5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AIQdVXDk6fL+lxjW/laPS0XMbGzjYxa7jkibGaaKjbA=;
        b=QnKnqX7Kl49KUHQe65R41IBoFJzOPhGpVuxk2ThUbKsDZJH+YYG6WSP0IkiduyVzmk
         OIzXpKNLKK9Gtj23sLnzJ5F4xx7+O3vzhjP596Vs0JHEOeIagBD2uExPQnuSqbpvqpNu
         bxPPEJgDhAW4JFnpsfYOwBMLrt2z1a2zw8brB6bIdd4LEvxMSLpvdmxF09Fdo7KCqfg9
         xSgRiYJc/4rIC9tJoD3EiDc/NVGVQ1I+4O3ZwL+CX1SUUdQllHB/8XLuugAuZDdOTQt2
         Edg7VH4vuM/ggJ30U0f454D7xrtF6a5rCdUlfML7rogkV0xb72ccnKUY2VAu0ZS2by3c
         Mh+Q==
X-Gm-Message-State: AO0yUKW05TeF0b0IS+v9lw0lvgvacovXFHOznM6Ml23AyPLFyqWLp24B
        +2hC8FzZYUfo9YjQa85umwo=
X-Google-Smtp-Source: AK7set96IpJn0StZOe0cENnQnRhG1PgSpETgS5gL8dE7JBdk8DICq0uesGDdK5gxN0XM2ArIh33Ezw==
X-Received: by 2002:a62:5214:0:b0:5dc:7548:60c2 with SMTP id g20-20020a625214000000b005dc754860c2mr3125969pfb.9.1677180941572;
        Thu, 23 Feb 2023 11:35:41 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id n19-20020a637213000000b0050300e81eb9sm539303pgc.54.2023.02.23.11.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:35:41 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 02/16] treewide: remove unnecessary git-compat-util.h
 includes in headers
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <adafa655432dd13d1c727522377ac9a4b515b76a.1677139521.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 11:35:40 -0800
In-Reply-To: <adafa655432dd13d1c727522377ac9a4b515b76a.1677139521.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 23 Feb 2023
        08:05:07 +0000")
Message-ID: <xmqq1qmg899v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> Since git-compat-util.h needs to be included first in C files, having it
> appear in header files is unnecessary.  More importantly, having it
> included in header files seems to lead to folks leaving it out of C
> files, which makes it harder to verify that the rule is being followed.
> Remove it from header files, other than the ones that have been approved
> as alternate first includes.

Hmph, doesn't this cut both ways?  

I like the idea that the removal of compat-util from other
header files may increase the likelihood that a C file that includes
such header files without including compat-util fail to compile,
because it would fail to find what is defined or declared in
compat-util.

But from "include what you use" point of view, shouldn't a header
that defines or declares its own stuff using what is defined or
declared in compat-util be including compat-util itself?

Or do I misunderstand what "make hdr-check" is trying to achieve?

Granted that the check does not fail with this patch in place, but I
suspect that it is by accident (i.e. there happens to be nobody who
depends on what is defined/declared in compat-util for their own
definition or declaration).  Also I am not sure how to interpret
the fact that "make hdr-check" succeeds with this patch.  Does it
mean C files that include these header files while forgetting to
include compat-util may not be caught by the compiler after all?

So, I dunno.


