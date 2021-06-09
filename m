Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03B6C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82B761246
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 04:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhFIEaE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:30:04 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:37564 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhFIEaD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 00:30:03 -0400
Received: by mail-pj1-f74.google.com with SMTP id fu20-20020a17090ad194b0290163ff5d5867so746991pjb.2
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 21:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aUzCTNY38s4lfYqX8OVjXSJZwYmjccP1CBCyRtPw97o=;
        b=vR/h5izdnsDIBSoQHmnTFd4JFW3IFRbSp5NJlRJyO3whpAynD1HUn4KwxMhe8qrvb1
         FtuDhMFHEecRo5HV8kDKmu8Wa1dpw97cShOjbOpaZifa5P8+JXZX1GhVmp03zfGilnzI
         EjbwBG8h+gYJmkn1S4egjh5UB1+VOSG1CHeZYDDKcLzVy3R8fIB/ouddSEjwmB32fOzu
         x7PwLO+blOzuQ8OBvBuPF/7KaoP/j+V8PMUhcSCRFzewUhSape8SGBtQo1yVyaEUFW4y
         aHIfIBcpjqilejRIHlqAqeCDPy2yiSaemNK0xxwtQrARWtyvMtb03jDoosN1xOIoOnn5
         aTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aUzCTNY38s4lfYqX8OVjXSJZwYmjccP1CBCyRtPw97o=;
        b=a/qEk1Mp1Sxmh3So6A/VXWfqIhjbQYWQNZ4GTIc3lG3VMBd6N2hKmSVFJstKOLOWlB
         W8SUMs0GXWxbcxJbt7C2/0KHa78LhQMgoFb1BYnj3lXa/VtfsSO7Iqh4Fne+ZB4i8Jdn
         RjYBiDiVpT4s+UkIJaYa4Kv25AjKL5OkJss83i7TV03nddqQwi5wY4QGKespSKnORQci
         uouUuCYoo3f8u0G/O4FH4h9I+KDhYDJkHGIw5K3ts0rk377Q8mLH0UEooPWHbovARWY2
         SAulbwW7qd4aOegZIwCR6gFr7PjOTYbn0xXdGICy/sGV088mmBrDkwedbTjzxQsMVNCS
         KDiA==
X-Gm-Message-State: AOAM530VPMEa4AFiZceXzuQcG2lI1Ar4HO8mxyHfrpbBQgU5bkX6Bgu1
        ao2AC1hPb2mXblsz7wiOaT4k60agRtwuRZPdhASa
X-Google-Smtp-Source: ABdhPJyoOXPxOwEQl7Qs5E4PTTV7/19TXb5lyW/FlFaDpTfWMIO9xtNvs4ZfE00fzzQcK9tVq4XjIwZX6vb+twrHkvqT
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90b:3796:: with SMTP id
 mz22mr8609209pjb.177.1623212813465; Tue, 08 Jun 2021 21:26:53 -0700 (PDT)
Date:   Tue,  8 Jun 2021 21:26:49 -0700
In-Reply-To: <xmqq35ttrqmj.fsf@gitster.g>
Message-Id: <20210609042649.2322758-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqq35ttrqmj.fsf@gitster.g>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH v2 1/4] promisor-remote: read partialClone config here
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > Currently, the reading of config related to promisor remotes is done in
> > two places: once in setup.c (which sets the global variable
> > repository_format_partial_clone, to be read by the code in
> > promisor-remote.c), and once in promisor-remote.c. This means that care
> > must be taken to ensure that repository_format_partial_clone is set
> > before any code in promisor-remote.c accesses it.
> 
> The above is very true, but I am puzzled by the chosen direction of
> the code movement.
> 
> Given that the value in the field repository_format.partial_clone
> comes from an extension, and an extension that is not understood by
> the version of Git that is running MUST abort the execution of Git,
> wouldn't it be guaranteed that, in a correctly written program, the
> .partial_clone field must already be set up correctly before
> anything else, including those in promissor-remote.c, accesses it?
> 
> > To simplify the code, move all such config reading to promisor-remote.c.
> > By doing this, it will be easier to see when
> > repository_format_partial_clone is written and, thus, to reason about
> > the code. This will be especially helpful in a subsequent commit, which
> > modifies this code.
> 
> So, I am not sure if this simplifies the code the way we want to
> read our code.  Doing a thing in one place is indeed simpler than
> doing it in two places, but it looks like promisor-remote code
> should be using the repository-format data more, not the other way
> around, at least to me.
> 
> Perhaps I am missing some other motivation, though.
> 
> Thanks.

I'm reluctant to add more fields to struct repository_format. Right
now, the way it is used is to hold any information we gathered (e.g.
hash type) while determining if a repo is one that we can handle. Any
information we still need is copied somewhere else, and the struct
itself is immediately freed.

If we were to use it for promisor remote config, we would have to
read config into struct repository_format's fields and copy those fields
into struct repository in setup.c, and then access the same fields in
promisor-remote.c. It seems more straightforward to just do everything
in promisor-remote.c - for example, if we needed to change the type of
one of those fields, we would just need to change it in one file instead
of two.

I acknowledge that there still remains the duplication that setup.c
needs to know that extensions.partialClone is a valid extension, and
that promsior-remote.c needs to interpret extensions.partialClone.

Having said that, I don't feel very strongly about keeping everything in
promisor-remote.c, so I can move it into setup.c if that's the reviewer
consensus.
