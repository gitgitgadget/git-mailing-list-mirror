Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5E741F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbdARVkp (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:40:45 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34297 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbdARVjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:39:52 -0500
Received: by mail-lf0-f46.google.com with SMTP id v186so22688474lfa.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 13:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=weuRFRwl9ncAqE6jpIz/9Wqb9YaU3bhEFmpDrDm4Lq8=;
        b=R0reMGHkn4NQcELJ6l6txpaOiKbhybucibomuXjw0gxUGpwDddpTsqjPNK0hCCgFoR
         6e9wk+c1kPf/9GEe1jCRB8pDnCdNgZte5djNe+54wK4SBhtNypEKAjEXdXBggxmMC9oI
         y+V+cCbdyDsZLC8DT6S2J1xgfrVHBSs9hZlRipV8AaxdJmqLvClSmg36IzDMhDtiI5ue
         AIJh6t1qgSmP5AUqa+pEkIwfYm/W6N6LlfoPRZaA/pCqubx6JLwoNRRjGrnYYvg43TJZ
         Pg+Ucw7oK4Q8oG/Gb926vC246k5zdTn+FSvzTYj7c3itL2JPg/kYyXKR0UMEgjiyQ7ze
         gpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=weuRFRwl9ncAqE6jpIz/9Wqb9YaU3bhEFmpDrDm4Lq8=;
        b=buTTxiG0ZRE4Nxu/qHe9SFZ+/uX5ySs88h4poy8Eb4ZIFftY43uJiJEVLkj3KfUiYu
         cWzBYjSo7O60Y7HD/ck6mUZ71zQGneG6ZRTS3srnpZgkz7gRfRtFIgp4r11WNfr755qN
         v2Xg2GGj5I5tLDddan5ra5u3o6nQt7cZl9FYOt5ZeyXh4XfAYQDtpj9cj/ZrAjfhdevL
         kuAZ/VY3Hzicn/xu0XkGtGwYjvm0o/mT0G+Mrhi4qPnoIEWfFNzKbzCSYQEApVCQauBa
         hDprHl7o7gTcjV/etz/3IS6Qq0jTeCzcTteG+yYIw0xw4NRmwYn+ympsFmSpksu0LgGL
         QmCQ==
X-Gm-Message-State: AIkVDXKFHzUX9NecWuGdbQC2DJYEq88lg62fDs+JBVDtxhiTcPV2PlYZLrFz3cfRBdsWj7ReriQfCSHhnVYYHw==
X-Received: by 10.25.141.147 with SMTP id p141mr2054370lfd.147.1484774031503;
 Wed, 18 Jan 2017 13:13:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 18 Jan 2017 13:13:30 -0800 (PST)
In-Reply-To: <xmqqtw8w86xc.fsf@gitster.mtv.corp.google.com>
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
 <20170118000930.5431-4-jacob.e.keller@intel.com> <xmqqtw8w86xc.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 18 Jan 2017 13:13:30 -0800
Message-ID: <CA+P7+xo4-45je995LLoyh-LbGTTf3EZUVW-UV+Dd=Wg0EGRvVA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] name-rev: add support to exclude refs by pattern match
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 12:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Extend name-rev further to support matching refs by adding `--exclude`
>> patterns. These patterns will limit the scope of refs by excluding any
>> ref that matches at least one exclude pattern. Checking the exclude refs
>> shall happen first, before checking the include --refs patterns.
>
> I do not think we should have this "exclude first and then include"
> written down here, as it is an irrelevant implementation detail.
> The desired end result is that only refs that match at least one
> include and none of the exclude survive.  You could implement it by
> first checking with include and then further narrowing that set by
> filtering those that match exclude (I am not saying that "include
> first then exclude" is better---I am saying that it is far less
> important than "at least one include and none of the exclude" to
> mention the order of application).
>
>> +--exclude=<pattern>::
>> +     Do not use any ref whose name matches a given shell pattern. The
>> +     pattern can be one of branch name, tag name or fully qualified ref
>> +     name. If given multiple times, exclude refs that match any of the given
>> +     shell patterns. Use `--no-exclude` to clear the list of exclude
>> +     patterns.
>
> Perhaps insert
>
>     When used together with --refs, only those that match at least
>     one of the --refs patterns and none of the --exclude patterns
>     are used.
>
> before "Use `--no-exclude` to clear"?
>

Yes this makes sense. I'm still looking at whether the alternative
implementation suggested based on the git-log style would make more
sense or not, but if we keep this as is, the added text you gave is
important.

Thanks,
Jake
