Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8461FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 19:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbcLETbA (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 14:31:00 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:36334 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbcLETa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 14:30:59 -0500
Received: by mail-qt0-f172.google.com with SMTP id w33so324187568qtc.3
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 11:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DA3aBYvfBG8cdPZvQNjeqyh9/qJzCRIt5Y5Y+auIDk4=;
        b=U3+HKec8ERKWMR+o1wSiMX+enTRvQHGC3jLU7tTz3A6BJ07aydYeavKi6xVYf0TG5G
         gSo/IMv9ec0AQZ2qtIrPysSd+Rx9E+PsItra5Eu/g8hSfSSjod+d84JGTE1yp51wiIu+
         wSGAGbwc9S2V8P9kVDKYoBxRSUkm/+ccRwACb/IGHJ6lVf15JuEsbTBk+aPVoOc2C/aI
         2mWpG+SFVa3fHn0CH+YOnfeo3ICpDiISG7N9pp7jx+F4c4Gc+pc3TRj+GJqiyemMdV1P
         hABuiGzqpjVOXeb69vM0bR0Jrv40e9OOkuedNV4taQUOn0iCy+w8Z7ymnIUcuRxin4dY
         zTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DA3aBYvfBG8cdPZvQNjeqyh9/qJzCRIt5Y5Y+auIDk4=;
        b=eNueV1lYsRRvhJS2f/1cgsHIicTzzS0hMcR2bt3+AV+Ko/sdpqq+nBIF4+qNDAFxQv
         9yWgzttH8dMNjWrdPQMleMUG+J4GIhH+KYmBW5qNBuhJDapECJp9R6ATncApXVT67qjg
         cx1/Rm4Hql6g3ueVXr4z39m7s6jo85ZBpmxIE4bdCyWf4/BHvMPPdAdLLT4TTlJFq8Cc
         JVcMrXWMYa3103kvJuB+vDNYO12IuUFNmJVZcLIlE6KefXqaoCXYDuo9ecxTPwSt7vw4
         FPCvN8GsSdsdcYFTJq1LCW8pe5+yitQ9rmpJQ/h1CNF/HfOy9NWEnjHbw0zmdopWPMst
         dkXA==
X-Gm-Message-State: AKaTC02kFvfRoXJI9ECcam+tAZvBetMmRwuY0yAODs4oFYjomIksfarthMb+i/sp/+pd+dR4TWzLu0JKG1VjBNrb
X-Received: by 10.200.53.9 with SMTP id y9mr50186657qtb.176.1480966257990;
 Mon, 05 Dec 2016 11:30:57 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 5 Dec 2016 11:30:57 -0800 (PST)
In-Reply-To: <20161205192527.GA68588@google.com>
References: <20161203003022.29797-1-sbeller@google.com> <20161203003022.29797-16-sbeller@google.com>
 <20161205192527.GA68588@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Dec 2016 11:30:57 -0800
Message-ID: <CAGZ79kbEtR7_6ZvBsjkc=8q+nnq9FoPv9HNWdRyuR2CQGqQ2oA@mail.gmail.com>
Subject: Re: [RFC PATCHv2 15/17] checkout: recurse into submodules if asked to
To:     Brandon Williams <bmwill@google.com>
Cc:     David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 5, 2016 at 11:25 AM, Brandon Williams <bmwill@google.com> wrote:
> On 12/02, Stefan Beller wrote:
>>
>>  test_expect_success '"checkout <submodule>" honors diff.ignoreSubmodules' '
>> @@ -63,6 +70,260 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
>>       ! test -s actual
>>  '
>
> Should you use test_must_fail and not '!'?

We use test_must_fail for git and '!' for non git thigns (test, grep etc),
as the test suite is about testing git.

The test_must_fail expects the command to be run to
* not reurn 0 (success)
* not segfault
* not return some other arbitrary return codes
  indicating abnormal failure (125 IIRC)

So in a way test_must_fail translates to:
"I want to run this git command and it should fail
gracefully because at this state, it is the best git can do"

The '!' however is just inverting the boolean expression.
We assume test, grep, et al. to be flawless here. ;)

Stefan
