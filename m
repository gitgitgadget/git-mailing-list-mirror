Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00ACB207D6
	for <e@80x24.org>; Mon,  1 May 2017 23:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750971AbdEAXdV (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 19:33:21 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36814 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbdEAXdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 19:33:19 -0400
Received: by mail-pg0-f66.google.com with SMTP id v1so18106258pgv.3
        for <git@vger.kernel.org>; Mon, 01 May 2017 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E1uwS/vjLm1xJJhprwiEP1fNQQ4ZPge3Jc6zvwniLSo=;
        b=PMFP93jdSkahUriTMUWCeA82hJWbLJXt84SGKVX/g+IR5sYCoJPef6wLJ/d0AFVnrJ
         OyWYeRpRX0IozxgO+T+guQJ1l0V4rx7X07V3bNGpeHSjRtWdIyc1OY0e3Mwg8QCaWf8o
         bVMcQ7IJ2/k4OeJhwGfvUtamMckLuQL9Cq36ufuLcm5Xj+aIC3SOZpPA5e32cscq7hG+
         lsILHspaX+0MpQDBXfHxxYO6lIUGD5OVHbOvkTaPBHlDQqfnm4L+OTRyWVYSUWyfR1e1
         psRwu0O3UgPBUQkfjkJjq8X3Uy3lKqV79Ap+itI7pln9fy23h2VTS6nMBZlH21yXnLOV
         xi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E1uwS/vjLm1xJJhprwiEP1fNQQ4ZPge3Jc6zvwniLSo=;
        b=LWPrdQMKsChTdw1z/UESYGuFYiI8zIoXPp1r+we9jW0VNWBq7LXiwAd/khnD8lilpv
         gxLLrBgRGA7IuAnDl0OXtwuWqNOk0X2cSwMu3c836D8zLkfJm/QfU5m1xYg7tTLBeVsr
         S2ub+oV8Dqjt7PJx85HJRHs85L8tIo164mV6mauvd+N3S8RBEFIRPoHj56PoqBOVSmQh
         6CXqjFpFZdnSYBuoYMm4lk68lzWn3Wtr5r9jxRGhGFI/e5wDTHmGvYSzBqlLUqfmGs13
         2P8Vmv85JNuXJ7tnQnESR9We1PQwo8i1wlSD5BOld3jNehKnr+fZuzsMeUNXdZBlTH5Q
         /6/A==
X-Gm-Message-State: AN3rC/7Lti/zN/VK+3euZm6NvFltGX+B+D+5BUvYWJifiocg8VHSvwcC
        9SKjG7Fo8FFH8w==
X-Received: by 10.84.236.7 with SMTP id q7mr36410733plk.176.1493681598601;
        Mon, 01 May 2017 16:33:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id n126sm24754157pgn.32.2017.05.01.16.33.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 16:33:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nikita Orlov <fatemail@mail.ru>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org
Subject: Re: git loses a commit after reordering.
References: <1493278996.239768474@f402.i.mail.ru>
        <20170429225642.GA25902@alpha.vpn.ikke.info>
        <1493643894.701604094@f346.i.mail.ru>
Date:   Mon, 01 May 2017 16:33:17 -0700
In-Reply-To: <1493643894.701604094@f346.i.mail.ru> (Nikita Orlov's message of
        "Mon, 01 May 2017 16:04:54 +0300")
Message-ID: <xmqqwpa0f8zm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nikita Orlov <fatemail@mail.ru> writes:

>>On Sun, 30 Apr 2017, 1:56 +03:00 from Kevin Daudt <me@ikke.info>:
>>Not sure if this is the case here, but it at least confirms that rebase
>>--preserve-merges was not meant to reorder commits.
>>
>>See [this][1] thread for more background on this limitation.
>>
>>[0]: https://git-scm.com/docs/git-rebase#_bugs
>>[1]: https://public-inbox.org/git/1mtveu4.19lvgi1c0hmhaM%25lists@haller-berlin.de/
>
> This is it. As I understand git-rebase--helper is an attempt to fix the bug.
> But it's still in development, isn't it?

The impression I have been getting is that "rebase -p" was abandoned
by its author, and the recent rebase--helper work is solely for
re-implementing the performance sensitive part of "-i" (interactive).
