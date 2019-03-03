Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6300720248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfCCBYU (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:24:20 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40640 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCCBYU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:24:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id g20so1457823wmh.5
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 17:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=bK4q2m14zUmuUXLQZ2Rbrb9sNQcNqpDAMMgZjULKcuY=;
        b=fIEkhy1Ja/nXoxscSW4BUmgabkWWMNL5UIu9LyxRMzlSlPiJ2btiwlWNDbyewYa9ra
         w41wyxk97L98fLbdpcEwPauAng/MEPcO9rnsjomWp43u906JvXjMoZ5vXAE8/6Zd+fhB
         ZDj+u3JCVpfXwsT+erFUNaF4sTEJ86BNPD8iyctUKCBQkytmoQVtAy3a6cS9TEfuLXBi
         9XjibQQH/1HkKmOVNqjqVv4fHd79U3nSAYGvHgVkSXRrET8oP+HHnIlhiB4vGF4XHFQV
         ppd2erHssi0OBavOCkG64kawuWlPqLPkGnD7G8fGQIcuExZ4IXZwwOX3g1YplIPV+xEi
         Wb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=bK4q2m14zUmuUXLQZ2Rbrb9sNQcNqpDAMMgZjULKcuY=;
        b=lAh9zz4H4uaWc28cDXygsmwGXXdV3C3VwI66HC8BZqIvMwtx42INRgEkTzm33CnSsT
         qIRCmSQv1dl12hW3+MegOGmKEEX0bYQAzlrcWp8CYfOfGWPCVDX0n6Naz0/p2umrcPcp
         nXtGRFAKjjsAF7bFipFwNkB20XcuUBmPLwfRhev2g1O1MTAviIhX7hpl5u7EEU/Q/Oe7
         eSXg6BnJT009IzWi/5LAnXIFLDgIpj44svihkfxK0bNNBh3VocnYLmPI5WgDIsSEhdGg
         yeoNRU+FkTwrU2MxOlgGijTYMqEEZUGkrp6Bs8iWZL7vD5AO8/7IlsEpWFBI4SI31bhI
         CZVA==
X-Gm-Message-State: APjAAAXhF0BofJ0Q7TCruPaoazi754enTIaydgTXUxRSIWiLRkrvy54o
        4/oKKd8+12VnBFF2y3dUYtY=
X-Google-Smtp-Source: APXvYqyT2onak6lKR1C6KZbtGpY6G9/Pl8HMwEbieF/wdXyJ8/Pus0oh++aVEeCYq/XXkwMOhrKUeQ==
X-Received: by 2002:a1c:80d6:: with SMTP id b205mr7493475wmd.109.1551576257965;
        Sat, 02 Mar 2019 17:24:17 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s3sm2552087wrt.81.2019.03.02.17.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 17:24:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v13 00/27] Convert "git stash" to C builtin
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
        <20190225231631.30507-1-t.gummerer@gmail.com>
Date:   Sun, 03 Mar 2019 10:24:17 +0900
Message-ID: <xmqq8sxw4uny.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> One thing that came up in the latest reviews, was to keep the stash
> script intact throughout the series, and to not re-introduce it after
> deleting it.  I did however not do that, as that would make the
> range-diff quite a bit harder to read.

Of course, if you start from a suboptimal ordering and reorder to
make it right, the range-diff that tries to match and compare the
steps will become larger and harder to follow.  What else is new?

That is refusing to think clearly hiding behind tautology.  

> In addition removing the
> script bit by bit also allowed us to find the precise commit in which
> the missing 'discard_cache()' bug was introduced, which made it a bit
> easier to pinpoint where the bug comes from imo.

In an ideal ordering, you would do a command line parser first and
dispatch the rewritten commands piece by piece to the C
reimplementation while diverting the remaining unwritten parts to
scripted "legacy" one.  That would allow us to find the precise
commit that was faulty the same way.

Having said all that.

I do not care too deeply about seeing this particular series done in
the right order anymore.  Everybody's eyes are tired of looking at
it, and I do not mind to see you guys declare "nobody can review
this, so let's keep it in 'next' and patch breakages up as they are
found out", which seems to be happening here.  

We can divert our review cycles to other topics that haven't faced
reviewer fatigue; they still have chance to be done right ;-).
