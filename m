Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E73320209
	for <e@80x24.org>; Fri, 30 Jun 2017 07:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbdF3H4J (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 03:56:09 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33262 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbdF3H4I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 03:56:08 -0400
Received: by mail-qt0-f177.google.com with SMTP id r30so92862866qtc.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 00:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=V9ng5c5YUGqfGL7m+VJ8n+F0kZj/NAW8EQ6YVc4aLTw=;
        b=VFZvXPjwq+Lv6qt+siSImONFWa3eybi0H0G14ecyv0kSeuKeyTWMSBmqgmt/SFI8n9
         WCX0Ca+k0xMNUKHm+0TCMoKUoNCdp4poFfwH6pIy50+/VSm2de8J0igKgYAeD0M3qgGq
         QBQXJIKmfbjXK9oTkD6ILLqFOcsC1bTiC9zA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=V9ng5c5YUGqfGL7m+VJ8n+F0kZj/NAW8EQ6YVc4aLTw=;
        b=pB8rw9cIhKZRHol69Welj1kGjPLm+Mn5tX++9WTTkPbV8WZbs8QyHN71PHz+v416Oe
         tzhBboLHrJkr/l2Qnn4nWP6NtVHZrhoDCLGUQX1NysrSUgLQzKncjHT1MoWwluQGU5oB
         89tZ53Uj+/ZbyRS+UYI96+F6euHjfFfPJDP7zOLYgBMP2ZmiinEIm3ik4vnwEOzMzUTV
         Cxif10Di18Ud6kFf2lyRKmPrPYdlEhBisvaIf2QId8+dIk47edI1mJ5I0zdLwo/Yiwa9
         3ZsCCzqYt/I43j9GM9gbltR4gtVQF7qFxmN4gPu6FuTnYw0AG5hTV7ApXME+YQlpCetc
         M4FQ==
X-Gm-Message-State: AKS2vOwy1FktApZGlU4LC4dDWT7i9SWl5yT7yahydhpRwn2x5VeOZvWR
        HFrEYbQn5V7vsfjpERxfOoPQwXHWfk9E
X-Received: by 10.200.52.129 with SMTP id w1mr24344644qtb.77.1498809367849;
 Fri, 30 Jun 2017 00:56:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.33.102 with HTTP; Fri, 30 Jun 2017 00:56:07 -0700 (PDT)
In-Reply-To: <CAKYtbVaZ85LAvgz4+p29Q_n7wN0s0ocnXO4LtLDzjS7pnNmZXw@mail.gmail.com>
References: <CAKYtbVY_=aMjcS=r2YyhcxKiUAaJUJA=OELTvXfau4GGz7Lz4Q@mail.gmail.com>
 <20170627191704.4446-1-miguel.torroja@gmail.com> <xmqqk23wycso.fsf@gitster.mtv.corp.google.com>
 <CAE5ih78VwBVT+XHnwgnt-JcLB-c4d_Gf+9Wfb_bL=LcgkjDrUQ@mail.gmail.com>
 <CAKYtbVaLkt6_rFgehgSsrLzo-oO3sEVoMLBtS5XX59ymYYS7=w@mail.gmail.com>
 <CAE5ih7-x45MD1H6Ahr5oCVtTjgbBkeP4GbKCGB-Cwk6BSQwTcw@mail.gmail.com> <CAKYtbVaZ85LAvgz4+p29Q_n7wN0s0ocnXO4LtLDzjS7pnNmZXw@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 30 Jun 2017 08:56:07 +0100
Message-ID: <CAE5ih7-go9PampG3Ltbx2-vYUezbN4QDHEVEHwpfXkpvUfLCaQ@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     miguel torroja <miguel.torroja@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29 June 2017 at 23:41, miguel torroja <miguel.torroja@gmail.com> wrote:
> On Thu, Jun 29, 2017 at 8:59 AM, Luke Diamand <luke@diamand.org> wrote:
>> On 28 June 2017 at 14:14, miguel torroja <miguel.torroja@gmail.com> wrote:
>>> Thanks Luke,
>>>
>>> regarding the error in t9800 (not ok 18 - unresolvable host in P4PORT
>>> should display error), for me it's very weird too as it doesn't seem
>>> to be related to this particular change, as the patch changes are not
>>> exercised with that test.
>>
>> I had a look at this. The problem is that the old code uses
>> p4_read_pipe_lines() which calls sys.exit() if the subprocess fails.
>>
>> But the new code calls p4CmdList() which has does error handling by
>> setting "p4ExitCode" to a non-zero value in the returned dictionary.
>>
>> I think if you just check for that case, the test will then pass
>
> Thank you for debugging this,  I did as you suggested and it passed that test!
>
>>>
>>> The test 21 in t9807 was precisely the new test added to test the
>>> change (it was passing with local setup), the test log is truncated
>>> before the output of test 21 in t9807 but I'm afraid I'm not very
>>> familiar with Travis, so maybe I'm missing something. Is there a way
>>> to have the full logs or they are always truncated after some number
>>> of lines?
>>
>> For me, t9807 is working fine.
>>
>>>
>>> I think you get an error with git diff --check because I added spaces
>>> after a tab, but those spaces are intentional, the tabs are for the
>>> "<<-EOF" and spaces are for the "p4 triggers" specificiation.
>>
>> OK.
>>
>
> In the end, ,the reason t9807 was not passing was precisely the tabs
> and spaces of the patch. the original patch had:
> <tab><tab><spaces>....., as I explained, the tabs were supposed to be
> ignored by "<<-EOF" and the spaces were supposed to be sent to stdin
> of p4 triggers, but when the patch was applied to upstream the
> <spaces> were substituted by tabs what led to a malformed  "p4
> trigger" description. I just collapsed the description in one single
> line and now it's passing
>>
>> Luke
>
>
> I'm sending a new patch with the two changes I just mentioned.

Looks good to me, Ack. Can we squash the two changes together?

Luke
