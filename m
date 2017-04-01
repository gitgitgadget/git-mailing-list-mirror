Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A63D20958
	for <e@80x24.org>; Sat,  1 Apr 2017 13:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751661AbdDAN3b (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 09:29:31 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35354 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdDAN3a (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 09:29:30 -0400
Received: by mail-pg0-f52.google.com with SMTP id 81so90370555pgh.2
        for <git@vger.kernel.org>; Sat, 01 Apr 2017 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6Ad6H1Lv7JVS56tCI+Fb8m8yix0MhgK52v+oVZmwIRs=;
        b=HoZhi/aQiFjBoVSa23mFGmp/tJTHd/lSJm6IS1oEHEm86VSygJ8plm8kUq5BEUozeL
         AjoOhk9KbfkEWVWbjkbxW04tk7WoQT5gEhFGdPa1hK9qXH6DWe75uKgf7kdX+TvKxYZc
         D1C/njknjHxizd88xB1OkFMr1iwXeexOqdiMvqIgOOuDyBtg6yf0kePf7nOP7/kL5BC6
         sDAnia1K/HnTHdA5aGfl+z/mCHzApl/49zmECoEx/uHrTLmVoJDxNPQDqFGaFCF1a+gw
         HeqE4wN7Dr4rc+tkFc8+APjdCBSMMfMHh+q6bD4btG+yikfyfyI/YXneOnuXj9zQur6Y
         pSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6Ad6H1Lv7JVS56tCI+Fb8m8yix0MhgK52v+oVZmwIRs=;
        b=r4RLoaf8dsn3ytPn3N5A2bPb5ktQ/0Tl26owsD/6mSNTaLrdeQhdWcQtkel/LQ9Cdd
         /j1biX9hdDFqjWY1ejrdrXCtYXI7WZNMw5BZai01mFdf/9mb+pvHy1IKhxwp2xzBvegL
         Clw2B63R/yEZW6iAY7ECiJftFYte4dQa/1DstKHZEIIkV5l0xOQhewhKLtI29rMwCIcW
         5IuD5cNcNB126qusuLLKeFq7imIGWUSjfZGKuXKo1RN8XjJV6iVgOwtP/jX69ElQDp68
         zg37CwJQLWBgtoMebT2oHFh/39e8RWIPMcDzsIRTtTvwgIOcUxm7Vs7irndgVMyxkZ6S
         wLBw==
X-Gm-Message-State: AFeK/H1Bl/O2M9T4ERPmoiEI/nLMY2KVB4sRBbUOcLhDt+YbZ3qvE5e0Wn1P1xEviYyfpJSHKpDLmb39nXna+w==
X-Received: by 10.84.225.1 with SMTP id t1mr9191210plj.118.1491053370280; Sat,
 01 Apr 2017 06:29:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.161.15 with HTTP; Sat, 1 Apr 2017 06:29:29 -0700 (PDT)
In-Reply-To: <xmqqlgrkx3l5.fsf@gitster.mtv.corp.google.com>
References: <1491009687-10419-1-git-send-email-robert.stanca7@gmail.com> <xmqqlgrkx3l5.fsf@gitster.mtv.corp.google.com>
From:   Robert Stanca <robert.stanca7@gmail.com>
Date:   Sat, 1 Apr 2017 16:29:29 +0300
Message-ID: <CAJYcaSOMkoAnW82g=moQxz0H9t7C+F++V4Ob1-UiTLiw=gm_0g@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] prune_worktrees(): reimplement with dir_iterator
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 1, 2017 at 5:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Robert Stanca <robert.stanca7@gmail.com> writes:
>
> > Replaces recursive traversing of opendir with dir_iterator
>
> The original code for this one, and also the other one, is not
> recursive traversing.  This one enumerates all the _direct_
> subdirectories of ".git/worktrees", and feeds them to
> prune_worktree() without recursing.  The other one scans all the
> files _directly_ underneath ".git/objects/pack" to find the ones
> that begin with the packtmp prefix, and unlinks them without
> recursing.  Neither of them touches anything in subdirectory of
> ".git/worktrees/" nor ".git/objects/pack/".
>
> Using dir_iterator() to make it recursive is not just overkill but
> is a positively wrong change, isn't it?


Thanks for the review, and yes the commit message is misleading (my
bad there). I understood that remove_temp_files has no recursion
component to it and it removes all ".tmp-id-pack-" files from
/objects/pack , but shouldn't dir-iterator work even if there's no
recursion level?
My understanding of dir-iterator is that it is used for directory
iteration (recursive or not) and where are no subdirectories it's
basically recursive with level = 0 .
