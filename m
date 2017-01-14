Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E495520756
	for <e@80x24.org>; Sat, 14 Jan 2017 00:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750733AbdANAAK (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 19:00:10 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:38141 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdANAAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 19:00:09 -0500
Received: by mail-it0-f45.google.com with SMTP id x2so49320691itf.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2017 16:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yQkmGfKdkaeCiq7RXS6thVZPAIq1qenvVJq2d+2sRUE=;
        b=V+9s3tfSCJCEfYLpMivly/J44sy1/IL2ZjayKABTI7lMMtW51sPyCj9KQKiAdK7hip
         xoc1pTtFd8wsVv9rdt/aeuQuAoHSsKOBpl8PzoIcHhTlvlQDzDTeMqgqXWf7Dqc3l+6W
         ufc0EEXsdCHjgbB0POVEuY9zvKSfXYwSQiKmLPlc3LSseur9eVjC9/eJJLq1MdaXQmWP
         EccWqV4QC1k5sID3KHtPmMnFVPfz2xOIAlpc34vv6jTLGFUgDW5KjCy4pufXMjCIB6YL
         M0xFjDS3FYPaHSbbL0XEY4HCAFKVuenRNsJ8SEdSAQgqTBfxmTQERlvg/diw9D1g7Fh/
         iYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yQkmGfKdkaeCiq7RXS6thVZPAIq1qenvVJq2d+2sRUE=;
        b=Z28bve3hk9top1ou3m/Se6b0XWjTm+hoJsHRmjw2gfmMmNRbd5col3tD96ZYAb8o9g
         0r+uqAUbz85T29+uzEQ8s706YDlLPp+nxVTng5rMenUs0453elybW1Jc9dVuaTrcGwCw
         XnQgCm7fOjuN27rhCiGidLlDsr8UH13KKltze3vx1G/heZ81977ZtgCj2Lb9rCtZSRZ+
         zkPVhHLVSRjqlv+88jtLpNhE914Y71t30icd/tNetH1m9ORu5+LfI+JDWWe5W2irGk8Y
         68qA9FEQX0uMvN8Q4TRXKu42/DsJ9M9f/OWHsZwYr/DkzNONkM/qRvvr8Kv8DDtZqci/
         2brg==
X-Gm-Message-State: AIkVDXIylLN28w78bFi+xv4+uzC8qBNFYgjF05CQ/WElG2HWVaOOCqBHf1wg0HX0Yd2is7F5aiPHsmLF7tBmZX25
X-Received: by 10.36.141.2 with SMTP id w2mr5058504itd.114.1484352008452; Fri,
 13 Jan 2017 16:00:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 13 Jan 2017 16:00:07 -0800 (PST)
In-Reply-To: <xmqq7f5yeclw.fsf@gitster.mtv.corp.google.com>
References: <20170113194326.13950-1-sbeller@google.com> <xmqq7f5yeclw.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 13 Jan 2017 16:00:07 -0800
Message-ID: <CAGZ79kbi-cweTe-ydcRYFFnGT4EmN+O1TZDiGYFyg8-Ex8abUw@mail.gmail.com>
Subject: Re: [PATCH] submodule update: run custom update script for initial
 populating as well
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Chris Packham <judge.packham@gmail.com>,
        Spencer Olson <olsonse@umich.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +                     if test "$update_module" = "merge" ||
>> +                        test "$update_module" = "rebase" ||
>> +                        test "$update_module" = "none"
>> +                     then
>> +                             update_module=checkout
>> +                     fi
>
>         case "$update_module" in
>         merge | rebase | none)
>                 update_module=checkout ;;
>         esac
>
> Shorter and probably easier to update.

agreed, want me to reroll or squash locally?

Thanks,
Stefan
