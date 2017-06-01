Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FED520D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 23:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbdFAXry (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 19:47:54 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35400 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFAXrp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 19:47:45 -0400
Received: by mail-pf0-f181.google.com with SMTP id n23so40399469pfb.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 16:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Z9IfH20gebo1WFBy3Vg8BsJedMM0fj1GQTsCoq5SNqo=;
        b=djbYT7YJG+8MNkcsGfYd7y1tZBeqdwJf7Qn7ruQKoLhJshk0+ob1MAYp4VCyn2qO60
         6GS0xPijYWxKDtkAKx3fQWpINriVkTQS+oAReTBoJ88aGsBQ5KK5PYIHtrArQtvyscGt
         tU6SXyuFuGB+mdi1PtoPN4KyXtHqKxSPZk8Z4H06RV/z3GvcsxyKzkOaa/bShsPkMM0n
         VL+vQLEdPfTplE0uTeWFgAb24N0DppjltqjnJvEvqTHZ+os5Q3+/xj3PKrz9oCDA2u3r
         jimWIkdTSLc07BMsNO8LABS7WWbCMUWgsfXE1c/PsYupB/1KlIFdXXjFsvQH/erMUN3O
         Kamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Z9IfH20gebo1WFBy3Vg8BsJedMM0fj1GQTsCoq5SNqo=;
        b=qa706aJTenj2BY7/YEr4RgXb0bFRoeGIQ3pBqm5RdXUYPQRjDKmGaAG5Vs/8a0iZ2l
         bJHxXdrW2vS+3gVyzEhLF5c9pigRxSMNcoyzgAKjlSFxMA12gGf7AtAEir8G62HLnsyD
         ILmsxAmLWptr3t2cVjrZVHOc4B+6TBgH8HAlW6g6L2hfJm68nn6HsoLWO731Q5K1Sdwi
         j9Z1HBjByxLsabjs0YXAMBzlD8+0kuQ6iJT6d7K6u3KlMWQRi8p3CUF8jLwzUvC0Zf4x
         p23G0DIk/qYXeNvPV0S00ULHW6UQdMYkqTq3KSSbkjg1MNm1nVkOMSb10d1+jp2rXisu
         0AKw==
X-Gm-Message-State: AODbwcA+/7REpbCty+Rxv2y1/Q9qmNuDWbTdEotZCh1tJm3Wr8R7HIhK
        xZMfE8PfoIE8K6RIHKOqiKVVqa5mVbpdfHr+Qg==
X-Received: by 10.99.188.9 with SMTP id q9mr3733706pge.178.1496360864566; Thu,
 01 Jun 2017 16:47:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 16:47:44 -0700 (PDT)
In-Reply-To: <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
 <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 16:47:44 -0700
Message-ID: <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] rebase: Add tests for console output
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 4:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Also, about the commit IDs. As long as the tests are consistent (i.e. they
>> use test_commit rather than plain `git commit`, or at least call
>> `test_tick` beforehand), the commit IDs should actually be identical
>> between runs and not depend on the time of day or the date.
>>
>> The only exception to that rule is when some previous test cases call
>> `test_commit` but are guarded behind some prereq and may not be executed
>> at all. In that case, the precise commit IDs depend on the particular set
>> of active prereqs.
>
> Good observation.  The tests written such a way may make later
> introduction of new hash function troublesome, though (we already
> have tons of them, and it is already a hassle just imagining that we
> will have to migrate them X-<).
>
> And what you gave below is an excellent suggestion to even solve
> that future headaches.
>

We had a discussion off list how much of the test suite is in bad shape,
and "$ git grep ^index" points out a lot of places as well.
