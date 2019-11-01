Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB7AC1F454
	for <e@80x24.org>; Fri,  1 Nov 2019 20:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfKAUn0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 16:43:26 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:45877 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfKAUnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 16:43:25 -0400
Received: by mail-pl1-f201.google.com with SMTP id c8so7018574pll.12
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=38+9Rf0S7OOpu9Zlr3E3x6uMvKYVOJGg/b/508JZA38=;
        b=Btw+dwzIEj5tz8XZq9uP1PAnWlkvjg9/l35JNjKFX+bxUj2b/uidRTBgGIuOEtGog0
         4iENGcvBsHk33WgOK1mm8kGYfb+RsRHgjf+K1ORsjKPlrzlF8irzBG4XOFj0XOObq2Qt
         XKdh5thGUF4aEtelo0IKkZLXhiU5PuZ4SbfmaI4PN+22cTdyeLRKTroHUWmUtfRMaQVt
         wgkAwWeINA6TLN2XuUuX//IGTDFAkqcIFD7oaIzIeBg9hUhAYPQxaJhh9Ql9HhovhQAL
         kOXfC6oLru8kbl4RuJPaPgCrnd9HAhAelV7+tJbNGFyci3AU6LceJgcXHoxqllcNMBgD
         ttvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=38+9Rf0S7OOpu9Zlr3E3x6uMvKYVOJGg/b/508JZA38=;
        b=rtVtzB5yRE8T2PEBJ3ahDyT91JrrtAkf8LU6d0Xbg6w2PCwiaINeO9bPvMhHHnFJ5k
         5x5KJb7+G0fH4OGREsYZiqcnsPubzH3ey+ntyg48Fw9iTtd32QIRaPif24erNnJLtX2v
         uD3KnRe5mjtp8crQDL4sw/K8j5tgnZ/jZRhql9NpWg/yKkQ/lZZrGTiD98hghZhxM+MD
         KTiWnst6o4OCGvJ9qAyoM8MM5NxdwQ1XG+YW2c8PHq0BUQ+iW8l3sdD3OEV4VL5qTAGx
         Fu8ercB7PCQWbgPvHf13X4Aqm0GgCuq60QshqT73oeCpEw2IOXw0AiK0duWDbg1P6MDv
         sq9w==
X-Gm-Message-State: APjAAAVTEhgKqaDHLGUfWxGsGrGsO/OB2v7lUSeckMFjj61HJht6l6F8
        UR3Olu0CjD3YkkHpxri3a+MBmgJPi6KBXi1YWfcP
X-Google-Smtp-Source: APXvYqx32ahFeSHqZo06CgLgoTOcF0iD0eAHHZ9UYob0Gm1ap2IbFGZG7ivYxNFFbcsL0sMBAY3T04KBcx5WcbGQSQTN
X-Received: by 2002:a63:480c:: with SMTP id v12mr11347821pga.385.1572641004819;
 Fri, 01 Nov 2019 13:43:24 -0700 (PDT)
Date:   Fri,  1 Nov 2019 13:43:21 -0700
In-Reply-To: <xmqqh83s8h3m.fsf@gitster-ct.c.googlers.com>
Message-Id: <20191101204321.234006-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqh83s8h3m.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: Re: [PATCH v3] fetch: delay fetch_if_missing=0 until after config
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> >> > Instead, we can control whether a region of code lazy-fetches...
> >> 
> >> The approach "from here to there, we can set global to forbid
> >> lazy-fetch" may prolong the life support of the quick-and-dirty
> >> mechanism, but it has to assume you can say "from here to there"; it
> >> would mean that we cannot go multi-threaded until we get off of it.
> >
> > By "from here to there", I meant, for example, creating a struct
> > repository in cmd_fetch() that has fetch_if_missing=0, then passing that
> > repository to fetch_pack() (once fetch_pack() and all functions it calls
> > support a repository object).
> 
> I know---but that means the struct cannot be shared among threads
> that are calling object layer, some of which want to lazily fetch
> missing objects while others only want to check the existence, at
> the same time.

That's true. Mixing lazy-fetch and non-lazy-fetch in a function is rare,
but admittedly it does happen - in particular, when fetching, the server
may send us objects delta-ed against a missing object, and we need to
lazy-fetch those missing objects.

> Compared to that, judicious use of OBJECT_INFO_SKIP_FETCH_OBJECT and
> other flags by callers can tell the underlying machinery why we are
> interested in the object, which I think is the right direction to go
> in the longer term.  What I am not certain about is if we are ready
> to move to the right direction for the longer term, or we should still
> be relying on the big-hammer global bit for expediency a bit longer.

I've taken a look at this and figured out tests that can demonstrate
what exactly is being lazy-fetched (and hopefully will be good enough to
prevent future code changes from adding extra lazy-fetches). In this
way, maybe we can at least reduce the scope of the big-hammer global.

I just sent out a patch [1].

[1] https://public-inbox.org/git/20191101203830.231676-1-jonathantanmy@google.com/
