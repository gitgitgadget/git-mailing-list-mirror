Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8215A1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 22:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeCNWYd (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 18:24:33 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:43611 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeCNWYc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 18:24:32 -0400
Received: by mail-pf0-f181.google.com with SMTP id j2so2030791pff.10
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X4ykaOMg4c4ZOr9Ao3aPtJQEF0pGi5A8SMLnu7DOjD4=;
        b=Wgrm+NEn0fs3+S0JVD//+77/tignX16zIdLD1thQsHzYAGY3wroMjc5x9zwP2skl1C
         mQKVfGZVF1wO/Iml6njTBKyIFIVwmkfMMt4C/sxeGtUDE8ENmSiNGEB6SgyfJybgrV7m
         kopm2CJhDDC878IMa0XetPwnb9puYnN6G9wQhuXZthZavbwxzbm98f1IyqhjISRkKeM0
         DrwFqasrlAvkTK+ixRlw9nutO15WrchUKm1x7dcuOnQ6qRudfoLk2hhdb2gSQlvE+i3J
         VaJC/trkSYxgXs3s/cadRm38YeZBx7xUGejwoXRyrO9pJr3dndyzVw1w9WOAgasKPZst
         Qnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X4ykaOMg4c4ZOr9Ao3aPtJQEF0pGi5A8SMLnu7DOjD4=;
        b=MNwPI4QoSNrkmnb9OQFIyGWZyNDpQD5Oih1imMBGxRHwga1UKsCSbF5Fb24H62FTWZ
         Bvd/T2o49e+3d6AWwzWVkEKGbKUQKCveZSf1369mjCjXB0WvQet3BMiMte3/sqqp/xVw
         FOjTqIiJsbgF7xQmx7LW3PVy65YjNGTvnTTS7aGhh3gmovFxF8E1+0uakIyfTq3bCq2y
         tOqhkJElW2Kn0UPZOOJpVsDDIf9fFSraBQD/OjrW7IhCkL9N5hsPei24fTxcsfYq2W2L
         Uta5KR+XILV1Z3tsrAwHydKo5J8ZaSvSKNkwKZsrCz6/SMj4DM4XL7b6DF9oKcAah3L8
         zSIQ==
X-Gm-Message-State: AElRT7FClEbTl+GlS822dS8dNA9YWuIVYodfkK45NAYz1dpxfVGEEWND
        SEd/5KOs2S37R5DuQdwg4xPm1A==
X-Google-Smtp-Source: AG47ELsAEXpK6IXIfWwDzLLS8SUphowHhVOlwOiIP8HIr1xWbhx6I6Il36aaLi6kDQqdxAn/Ng9ifw==
X-Received: by 10.98.225.2 with SMTP id q2mr5695773pfh.23.1521066271707;
        Wed, 14 Mar 2018 15:24:31 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m9sm7330558pff.143.2018.03.14.15.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 15:24:30 -0700 (PDT)
Date:   Wed, 14 Mar 2018 15:24:29 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH 2/2] fetch-pack: do not check links for partial fetch
Message-Id: <20180314152429.df14adfb49b028e2e2a9001a@google.com>
In-Reply-To: <xmqqwoyexqy4.fsf@gitster-ct.c.googlers.com>
References: <cover.1521052825.git.jonathantanmy@google.com>
        <cover.1521052825.git.jonathantanmy@google.com>
        <c2f59866a1b1dc5f11713e1922eac2521ef98b07.1521052825.git.jonathantanmy@google.com>
        <xmqqwoyexqy4.fsf@gitster-ct.c.googlers.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 14 Mar 2018 14:55:31 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > When doing a partial clone or fetch with transfer.fsckobjects=1, use the
> > --fsck-objects instead of the --strict flag when invoking index-pack so
> > that links are not checked, only objects. This is because incomplete
> > links are expected when doing a partial clone or fetch.
> 
> It is expected that _some_ links are missing, but this makes me
> wonder if we can do better than disabling the connectivity check
> altogether.  Does "git fetch" lack sufficient information to attempt
> the connectivity check, and when (and only when) it hits a broken
> link, see if that is because the connectivity check traversal is
> crossing a "partial" fetch boundary, or something along that line?

Our only definition (currently) for the "partial" fetch boundary is
whether an object in a promisor packfile (a packfile obtained from the
promisor remote) references it, so I think that checking for crossing a
"partial" fetch boundary does not add anything. This is because by that
definition, any missing links observed from objects newly fetched from
the promisor remote cross a "partial" fetch boundary (since all objects
fetched in this way "promise" all objects that they refer to).

But it is true that we might be able to do better in checking, for
example, that a packfile fetched using a blob size limit contains all
referenced trees (that is, only blobs are allowed to be missing).
