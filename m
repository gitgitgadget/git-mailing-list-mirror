Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12B501FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 21:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbdBJVpC (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 16:45:02 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36529 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750874AbdBJVpC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 16:45:02 -0500
Received: by mail-pg0-f66.google.com with SMTP id 75so3943118pgf.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 13:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tndhsC6NMewYowTYBtOoUpQtDyYPcCmS+6sroz1gbqY=;
        b=rlb23bKsbiRDvd5203EqO2ElMGGFKt4n5s7VprtodW7Xa4mNjdKyRMAQG/C9JnvOX9
         ihQ3uOae1uW6oYAozwFM6r84d32ziOMfFPE1/Tt9NK8/caNw8jv6zRw1HW19QQGqOJ/6
         Chu65TRvOmVbVFuzVQHEmkY2wI2Il5YIQDccykHAtaxoKkMp3pY9ouDdlYQ3YgGVkHGU
         l2sLYfXk04nZV+wk8L83JUPTJHTl6jmGJorSLHM2d1LcpeVRCbC94bJGXQZwdiIdfloA
         OkE6bGtEEAUvDfzhS7vxaA5pBNX+prSLOdRMk6TP/Is3ferVBwLj9K5RnO0snxcARI3e
         f10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tndhsC6NMewYowTYBtOoUpQtDyYPcCmS+6sroz1gbqY=;
        b=NLl+WdFbXc4UdqP23Y1X3L2C5/f3YOFQOfvUehhtWsG0/A6YNXw+9KKTdFug5OwHeX
         i2ZPq2aDMRdmxe54kC0oCcJPYJb0xRQc0vsoLHYsGzAdFEPodFQAFWUjXBAeY/hn3R/j
         nPk/uGRGz2epb3cLWqWcGfW8ZMabQ6RQu+PTTjfAL0migqk1OUCzY9QgmGgwPEpearWP
         bCu2aWLLzrDSS7RVgHYvyDkXCtWEn64qFEmiN6mon7dX6Zdy8+jVZF9uPkwZs8qabjzo
         8OHqxRqUuPgJkgvPgHMOcqJ1OtticIQwdFwwSICp9aIDpyesiKLBTrkGHNdw42LAg3/j
         O4uA==
X-Gm-Message-State: AMke39nzWsPvHZ+2Zg+w8j2Fyjt4otc49oOqWwOG+HUd28769Bb4DlXezwTFrOpVzXDUxA==
X-Received: by 10.99.247.83 with SMTP id f19mr13140872pgk.158.1486763101362;
        Fri, 10 Feb 2017 13:45:01 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id x2sm7376405pfa.71.2017.02.10.13.45.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 13:45:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] squash! completion: fill COMPREPLY directly when completing refs
References: <20170203025405.8242-13-szeder.dev@gmail.com>
        <20170206181545.12869-1-szeder.dev@gmail.com>
Date:   Fri, 10 Feb 2017 13:44:59 -0800
In-Reply-To: <20170206181545.12869-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 6 Feb 2017 19:15:45 +0100")
Message-ID: <xmqq7f4xk9es.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Care should be taken, though, because that prefix might contain
> 'for-each-ref' format specifiers as part of the left hand side of a
> '..' range or '...' symmetric difference notation or fetch/push/etc.
> refspec, e.g. 'git log "evil-%(refname)..br<TAB>'.  Doubling every '%'
> in the prefix will prevent 'git for-each-ref' from interpolating any
> of those contained format specifiers.
> ---
>
> This is really pathological, and I'm sure this has nothing to do
> with whatever breakage Jacob experienced.  The shell
> metacharacters '(' and ')' still cause us trouble in various ways,
> but that's nothing new and has been the case for quite a while
> (always?).
>
> It's already incorporated into (the rewritten)
>
>   https://github.com/szeder/git completion-refs-speedup

Should I expect a reroll to come, or is this the only fix-up to the
series that begins at <20170203025405.8242-1-szeder.dev@gmail.com>?

No hurries.
