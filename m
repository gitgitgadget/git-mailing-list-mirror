Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FD4C433E0
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8040920659
	for <git@archiver.kernel.org>; Wed, 13 May 2020 21:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oH2u6o14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgEMVlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 17:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729196AbgEMVlO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 17:41:14 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34387C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:41:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id i5so934848qkl.12
        for <git@vger.kernel.org>; Wed, 13 May 2020 14:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pN56/oKLuVq9kPnIipSaoB+ChD4J+Fpx7uJzhdwOTbw=;
        b=oH2u6o14FAnSU6pYh5KgvqV1xvaUKabdMWj6unMVde3q3GL4E0yk7ej/uhszjrMYcs
         narHQk97t7GIsiXYuj12x9p8CPIxIDZX3E5/d/oTjIDJWqQRAki6/ISm0KvLufnxZjbs
         YUWLyS1ihDLD6NLXrSAnQJ+RZKIaOgg3CSDPLB64BbJG3hvoefFZ8UjR/qOlSYDDQ/5+
         xECbs9EhPu8An4pICqk91AWtRJHMWvQI360VdNhbk8tGS5rCtD3G78MYUEYSwsOIBYcM
         fkHXdASU9cvuepjpPXRiBDN5g69FZYdvcFnWjyoxdp609j0HPhSHuZDwIlbxkQ49s7oi
         2ZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pN56/oKLuVq9kPnIipSaoB+ChD4J+Fpx7uJzhdwOTbw=;
        b=U57G0cog2d9wgHd5bzPNZuhMnKtRmQlqTQme4sz9fs6tiHc2TZ2zGkXoyEUZ5bfTNj
         NAoQqgJrKlJhhQZiH0BBDac/9SPKyf8m5thvL5qlF0AuM+nL1nBswQPNgpstYsIz8HVh
         v3XgeRrqmwrhkBvECcWX1SfxvGrRthGTofS4Q32F36vEzomrsJif2Xq+yrEmK61+93V4
         5BM9BmpUhZgGcUKoqDKuqiN6XlYlrMj4ynSUkNTdGTZWRLam2cEMKe1tgZ2Sa0wmC/39
         m9qTXfds4UeFgZYREE3HD73f2+1gguw39ORnOZ/v9nS6BEskrTy7YxadTycQSWeVyW8t
         h3jw==
X-Gm-Message-State: AOAM533LKQFbdUfm2iHFYWe/VdUdsHVD8Lggo7bDJvx0F5KXdAtdoeKL
        LDdfa0w1YryWCEEspTO4sM9xDQPL4tc+U7u1UCuZyw==
X-Google-Smtp-Source: ABdhPJyz2SDzKlU03jrLmeGyR67G+2wf7d2ad8t0R14/WTsNKhET8M5lMSDBWLwLLKY25JGoWnH3IqM/1saV9wxGoNI=
X-Received: by 2002:ae9:e886:: with SMTP id a128mr1854959qkg.204.1589406071952;
 Wed, 13 May 2020 14:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200513200040.68968-1-delphij@google.com> <xmqqo8qrsh0d.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqo8qrsh0d.fsf@gitster.c.googlers.com>
From:   Xin Li <delphij@google.com>
Date:   Wed, 13 May 2020 14:41:00 -0700
Message-ID: <CAOhzdui-4KeOit74fTy=3YxSncHGZzy+cE+6njyjHPyJ8xFpMA@mail.gmail.com>
Subject: Re: [PATCH] fetch: allow adding a filter after initial clone.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The proposed change would allow converting an existing git clone to
use partial clones.  For example:

$ git clone --depth=1 https://android.googlesource.com/platform/bionic .
$ git fetch --unshallow --filter=blob:none origin

Previously, to allow this one would have to do the following manually
first; the existing code would handle the rest gracefully:

$ git config core.repositoryFormatVersion 1
$ git config extensions.partialClone origin

And the proposed change would have git do it for the user
automatically, the existing workflow remains otherwise unchanged.
