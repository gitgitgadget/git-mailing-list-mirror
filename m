Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B066B215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 21:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756051AbcJLVmk (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 17:42:40 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35881 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbcJLVmi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 17:42:38 -0400
Received: by mail-qk0-f173.google.com with SMTP id o68so102732891qkf.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0n26vgjXMtZvkUYJh7NkSdFLJddwXFR7m0ATD7zfAuM=;
        b=j6CzjDUUzJWcW91jMI/aFVcGC602OnTxD1bP9aUxugLAUqE/buZg611bygkhM4aEoE
         bdolfWcAc6wLT7d8ZEy3hRcOnlJdWU3EjCsPphe4xYeZS+BIIMeb0ivr/s3n8KfWMe/H
         bCQG7Ng+5+WOsdKXE3NZ37MWiTGXCYk+kzPjFO8GzJXzQneiuVN1m3BFA5a5/AxcgFzg
         DwLjnGsxDVNxWwqBskSHHj8aW664Cg5ya2rOwLn1WptRxxtOQmH+/tLZ69ithljP+DOW
         BYIvNrEVIoFQp7PVAHSN7wF0gdcpxBK6pGvJZmYrzaWxIFK28nHQ4oAsfod5OwTyP/n5
         3SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0n26vgjXMtZvkUYJh7NkSdFLJddwXFR7m0ATD7zfAuM=;
        b=IGLg6/4u9E8H2yaXC2syAxCazSrw2jHNlEkrMe4LPtmProf3Z3LPmiVzj2mta0nTHt
         7vyxjiIu0xIrwXXSOOKwGmkub2EswVgG+YFkoKAygBLlmzqGx1E/zGaKEUEFdTppBfYB
         DO4JoVb/DwKUpL4ycXhbrJGRnslVWUF4hEQBUdNhgh61eeMTXx8ZuvzGswqsa6hZsQ/m
         f8/GlTgKU/XAGTp9u7iGYlEZFGZkjQcv+mdxlzkDo9zeoQfmhexU8OblIXj2kZbWmE+d
         Q7R+/qoSnOhk+nlXilAEOoFK+0dR0ulYfecY6jixtrPvxZPKl1kDfbhfdih/xIfdn7eY
         5ZzA==
X-Gm-Message-State: AA6/9RlMRFkzleObUfGsvp1nNb7yKuCpzH/njwgpbONLWipruadvTcX3ZC9HTE3OsGiYOnNQsZc8zVpp+zL/C5H4
X-Received: by 10.55.56.11 with SMTP id f11mr3213446qka.255.1476308557820;
 Wed, 12 Oct 2016 14:42:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 12 Oct 2016 14:42:37 -0700 (PDT)
In-Reply-To: <xmqq8ttt2qpp.fsf@gitster.mtv.corp.google.com>
References: <20161011235951.8358-1-sbeller@google.com> <44c554b8-7ac1-047d-59f0-b4d5331ed496@kdbg.org>
 <xmqq8ttt2qpp.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Oct 2016 14:42:37 -0700
Message-ID: <CAGZ79kb-xKDNG-LC56i8Y-FAaYZwr8zzXuC9snj1PavnQ6cdCA@mail.gmail.com>
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Sigh. DCLP, the Double Checked Locking Pattern. ...
>> I suggest you go without it, then measure, and only *then* optimize if
>> it is a bottleneck.
>
> That comes from me in earlier discussion before the patch, namely in
> <xmqqeg3m8y6y.fsf@gitster.mtv.corp.google.com>, where I wondered if
> a cheap check outside the lock may be a possible optimization
> opportunity, as this is a classic singleton that will not be
> deinitialized, and once the codepath gets exercised, we would be
> taking the "nothing to do" route 100% of the time.
>

Having followed that advice (and internally having a DCLP), I think
we have Triple Checked Locking Pattern in this patch.  Nobody wrote
a paper on how that would not work, yet. ;)

In the reroll I plan to reduce it to a Single Checked (inside a mutex)
Locking Pattern, though I would expect that performance (or lack thereof)
will show then. But let's postpone measuring until we have a working patch.
