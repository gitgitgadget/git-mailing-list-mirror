Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDED61FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753143AbdFMRAE (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:00:04 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35259 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMRAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:00:03 -0400
Received: by mail-pg0-f68.google.com with SMTP id f127so19834057pgc.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ii4FJXCaZ86HMqg2rpm+uVWra9WgO+2KDRv8v9O3flo=;
        b=Mz5PgBPF0xYWJE8mRxGPBjJSYtIAdb56tkzP3XnTxwArNzHWYncjqLpBMftQTrCePA
         4b2J1XlEtbRVetaUUroOv93HttCG/mW52dEpXStfIVDdH1NnbdlLccobJmXIfK+z4hB0
         ATzygAzJzhv/UIcY18HY210pmR+nYw2jG/ghjI3ANehZBe1sEjElOFHu7gO4xyM7eCzV
         xYIi7dj8hwFpYcLvsJLedMfvF6QPmqzwpzVjUGcTia+lecbBQUktkKT+EYiX+X2tLwhI
         PstlOi0GNHu5ICyWRoPawD6LCIDzpzHMYEfCCJsHsOPlnTO6v0sQxL4OqvnqjWE3P6Du
         Rhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ii4FJXCaZ86HMqg2rpm+uVWra9WgO+2KDRv8v9O3flo=;
        b=QpxfYRSIdIpNHLsn4AaOFZUUIAY8xp8Y/BmSZ0nGzgWuQZbtTFntu2Bg45JWfPmnPX
         b6PR8BXon/BQ8fDqraVSlDl/uUClO5zSmiS5qRVMyZIgs2yDkMGnJeDX91weOjteXetW
         IEBeTrTz0r9iDdIYnx1ZDPJgB1n69+yB68ZpzqS2JlGCxWgSSSwyQ+B/zHxe88fsvQq5
         Jra6Z3JCQYpyrPafbYfxOpw2PPB1m+Owm1n18Cwh6py5eQkbPvIAOtOsWwhgvfmwsUx8
         VT7ISC/20mq2gQNjhz0S5GMteMIXBIRFUjWOrjvPT2zN+/cfItkZUWI4UH/ahXfU3L4E
         e0SQ==
X-Gm-Message-State: AKS2vOyjTsSHTKqoHdIrsG+T/4VPWlletdDmZfdIubQP2x8WZTryd5Ps
        L9mfNJJNZLXkeA==
X-Received: by 10.84.172.1 with SMTP id m1mr698532plb.134.1497373202652;
        Tue, 13 Jun 2017 10:00:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b4c1:e9f6:bf2b:dcec])
        by smtp.gmail.com with ESMTPSA id t82sm25481756pfe.88.2017.06.13.10.00.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 10:00:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
References: <20170613023151.9688-1-sbeller@google.com>
        <xmqqvanz9afq.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYR+qh1X-dQixdpDbcr5z-DJ2mkdncaVn_8y90kNco9tw@mail.gmail.com>
Date:   Tue, 13 Jun 2017 10:00:01 -0700
In-Reply-To: <CAGZ79kYR+qh1X-dQixdpDbcr5z-DJ2mkdncaVn_8y90kNco9tw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 13 Jun 2017 09:21:04 -0700")
Message-ID: <xmqqa85b9626.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> * As you have an individual color setup, maybe you can fix this
>   for you by setting the appropriate slots to your perception of
>   dimmed?

I do not think it is possible with only {new,old}{,alternative} 4
colors.

Consider this diff:

         context
        -B
        -B
        -B
        -A
        -A
        -A
         context
        +A
        +A
        +A
        +B
        +B
        +B
         context

Two blocks (A and B) that are adjacent are moved but swapped to form
a pair of new adjacent blocks.  

We would like the boundary between the last "-B" and the first "-A"
to be highlighted differently; all other "-A" and "-B" lines do not
disappear but go elsewhere, so they want to be dimmed.

The newly added 6 lines are actually moved from elsewhere, and we
would like the boundary between the last "+A" and the first "+B" to
be highlighted differently, and others are dimmed.  

So I'd think you would need at least two kinds of highlight colors
plus a dimmed color.

         context
        -B		dim
        -B		dim
        -B		highlight
        -A		highlight
        -A		dim
        -A		dim
         context
        +A		dim
        +A		dim
        +A		highlight
        +B		highlight
        +B		dim
        +B		dim
         context

If old_moved and old_moved_alternative are meant for highlighting
"-B" and "-A" above differently, while new_moved and
new_moved_alternative are for highlighting "+A" and "+B"
differently, you'd need a way to specify "dim" for old and new moved
lines, which seems to be impossible with only 4 new colors.
