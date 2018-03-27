Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64981F404
	for <e@80x24.org>; Tue, 27 Mar 2018 16:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755641AbeC0QoE (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 12:44:04 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36229 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755636AbeC0QoB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 12:44:01 -0400
Received: by mail-wr0-f194.google.com with SMTP id y55so2498815wry.3
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 09:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/1qyVT0fGzopqLTDV1hGkNYdMVq61/wHhcXQHgCUDnw=;
        b=mrZvfQ9bxwsB4l9GkZ/peq3eWX5gjkKLOc0UMU0nbuqmtwxELZJGZqCCOr9fVw6QSc
         EuGWMyA4wUJ2H4Fo4ja8/zD+FvV38NlAqmu0MeV5zopvwC0fhmO+zz7G1WLT5ODglU/4
         MmqEYbFDh4Ia4kR9Xq2/tg+UoEAhcrJ3smLgC90H0O4727NRRioGddZmcgoYOd7VUptu
         9MhStP+uTenswjaX/UoULHExnelx11e0IpzzeDGdckGLv19sF21sn6Hh38NOls9+F4Od
         bAWYQsanJhV+4SnK3IpB3VsYCWLhJieDjkSv9D1v0w31gE1eIcKOO6bSk/xtQ2YKPcQl
         yWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/1qyVT0fGzopqLTDV1hGkNYdMVq61/wHhcXQHgCUDnw=;
        b=lLsKp0soeUD5yY1Us+uKhjfwxo4Qqlv0xLRPkN6jJAT5gFYOst+xuecCDOtNRrArYi
         w3BzuvI48GDJuaJ7iL/MX/PtNPb9jrkoEuyhbBKHloXqOcJ0zZqhSbGhEZuPKJAQJDfp
         176YjD65BeUL23iYXdbr1oV+AUGZzR9/8R5JZP5cPiuHd2l0RN8MhzRndt9IKzqtmuOq
         jyNNWvwhG66LE0S2Cw/aXmV+E/6Cy3/Cto9rZcgV79vZubfiMh7gMa68AwLDYm4kMLm3
         L9QySGqO6ufUBicbHAGA1FIL9yetgxQIcHbOA2V5TkB8fwTJCPjAyaBWKBSAlS3AOTz/
         SCpQ==
X-Gm-Message-State: AElRT7FRAhtJziwgRXbJlpZWzXypsdumCoepxy+34uhOAu9wac9rt3wU
        jnc29CkgcYMdc5sjGVZtnMc=
X-Google-Smtp-Source: AIpwx4+G0MsLNE0XWJ7hfdVUPkKl57MPANEngfRIl7RIrdPdmKZOAp/wtyHWO5ev7FJw0Ach/aPoLw==
X-Received: by 10.223.131.229 with SMTP id 92mr49200wre.249.1522169039976;
        Tue, 27 Mar 2018 09:43:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t196sm2211593wme.35.2018.03.27.09.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 09:43:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 3/3] Move reusable parts of memory pool into its own file
References: <20180321164152.204869-1-jamill@microsoft.com>
        <20180326170351.197793-4-jamill@microsoft.com>
Date:   Tue, 27 Mar 2018 09:43:58 -0700
In-Reply-To: <20180326170351.197793-4-jamill@microsoft.com> (Jameson Miller's
        message of "Mon, 26 Mar 2018 13:03:51 -0400")
Message-ID: <xmqqlgeda2pd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> This moves the reusable parts of the memory pool logic used by
> fast-import.c into its own file for use by other components.
>
> Signed-off-by: Jameson Miller <jamill@microsoft.com>
> ---
>  Makefile      |  1 +
>  fast-import.c | 70 +----------------------------------------------------------
>  mem-pool.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++++
>  mem-pool.h    | 34 +++++++++++++++++++++++++++++
>  4 files changed, 91 insertions(+), 69 deletions(-)
>  create mode 100644 mem-pool.c
>  create mode 100644 mem-pool.h

OK.  This is indeed straight-forward line movements and nothing else,
other than obviously a few static helpers are now extern.

I said I'd anticipate that the allocation that bypasses the pool
subsystem would want to become traceable by the pool subsystem,
which would allow us to free() the pieces of memory allocated
directly with xmalloc() in mem_pool_alloc() instead of leaking.  I
am OK if the structure of this series is to make that change after
these three steps we see here.  When that happens, it will start to
make sense to bill the "this is too big so do not attempt to carve
it out from block, and do not overallocate and make the remainder
available for later requests" to the pool instance mem_pool_alloc()
is working on, as that piece of memory is also known to a specific
pool instance.

After I wrote review for 2/3, I found out that you changed the
meaning of total_allocd (which should probably be described in its
log message).  Unlike the original that counted "total", it now is
used only for memory that is allocated directly by fast-import.c and
does not account for memory obtained by calling mem-pool.

The output routine is changed in 2/3 to add fi_mem_pool's pool_alloc
to it, so billing oversized allocation that does *not* belong to any
specific pool to _some_ pool and ignoring total_allocd would cancel
things out.  It still feels a bit fishy, but I think it is OK.

So all in all, I think we are in no worse shape than the original
(we call it "bug-to-bug compatible" ;-)), and successfully extracted
a reusable piece in a separate file in a clean way so that we can
refine and extend it further.  Nicely done.

Will queue; the proposed log for step 2/3 may want to be a bit
polished, though.

Thanks.

