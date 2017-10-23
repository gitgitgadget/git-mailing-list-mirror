Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F27A202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 18:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbdJWSFU (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 14:05:20 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:50040 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbdJWSFT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 14:05:19 -0400
Received: by mail-qk0-f182.google.com with SMTP id q83so23078983qke.6
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+24z+vuKP/rFIyOljXILorcn/OaZn+423HqwW90LHqg=;
        b=etJ5MA0BskC+I8Y9G5ac9O25MX7WIs3ARKVsIA1Hglw/GALW8HDVJODpOXBCmFCfyD
         er72RskjbzhfavRBhkx7sragt5w/Hr42aqz56H1ZhYJno8wZsKvfV+bvlxXfCb1rmgmj
         r42UahhendwDw5PRYb83lVf9SYOdd8d+eKaQCMOflzvcWIsOpwHo2bVVppVEB/0FZa8o
         nHmNrfG0UvjplWCTdGtPhzMsj6uQZrvjsqJhqiSD8TvqyDKQiqlbek+mrAQJW1GTuFi5
         F0IBKmPK+4kr7LUcWAy/q8HdEIwd46q3nuJNVKqyMoFADBmOolRbJRXROIIuPagP8Qhd
         9WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+24z+vuKP/rFIyOljXILorcn/OaZn+423HqwW90LHqg=;
        b=RZoLd40SliY8Y1wIp6qbROggALCq07yrzk3rvTouMmDazlqATT737q7Li8LX5uPEpN
         upxjSe6IxOt8ds42CUeywYEc27ynsWoKUzanRj3Hhdc8huUFLoiHYvG5Z5Lca95bpxEY
         8MfqEIT3V3NzaFlz898wFYZUNfs+bLrmgWiBsfjdaGcuWV1rii1Ry1LGcHj/xuIUd725
         GtNqsi1RWkGnlxxauAR3welflBr7IG3ckKoIWt9P7UuIjpmWQV30Ve48iuTkbLwKfSn8
         qnE5OU2/5IvXle0ZS9cdcT50vovdSzyc7/CLCpHjY3eHsg/sS0wQmrDTe+dS5+9vNhMz
         S3Qg==
X-Gm-Message-State: AMCzsaXNAfPrZk2WrP7h6iZgJ7QlVIWqPYlOOoGq3LSBcYXunnD/wmhU
        ICu67Z+ISRHWltSyqJyeRRpHB+MVEKh2xYkj8bZh6A==
X-Google-Smtp-Source: ABhQp+SVy4+045MFR1rUhBrggfEE7L3Cqf3k+xwJGUzkSeFttWpdVLCxz+JqTkYlQD6VwHj344aiTAfMcwSGKhyPyXU=
X-Received: by 10.55.129.70 with SMTP id c67mr20812821qkd.230.1508781917251;
 Mon, 23 Oct 2017 11:05:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 23 Oct 2017 11:05:16 -0700 (PDT)
In-Reply-To: <20171023141259.GB85043@book.hvoigt.net>
References: <xmqqwp3sj7ov.fsf@gitster.mtv.corp.google.com> <20171019181109.27792-1-sbeller@google.com>
 <20171019181109.27792-2-sbeller@google.com> <20171023141259.GB85043@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 23 Oct 2017 11:05:16 -0700
Message-ID: <CAGZ79kYcvcEe2-K94BSB0j3ig-fgr9xvTg5q4H6vak1H6LkE+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] fetch, push: keep separate lists of submodules and gitlinks
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 23, 2017 at 7:12 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Thu, Oct 19, 2017 at 11:11:09AM -0700, Stefan Beller wrote:
>> Currently when fetching we collect the names of submodules to be fetched
>> in a list. As we also want to support fetching 'gitlinks, that happen to
>> have a repo checked out at the right place', we'll just pretend that these
>> are submodules. We do that by assuming their path is their name. This in
>> turn can yield collisions between the name-namespace and the
>> path-namespace. (See the previous test for a demonstration.)
>>
>> This patch rewrites the code such that we treat the 'real submodule' case
>> differently from the 'gitlink, but ok' case. This introduces a bit
>> of code duplication, but gets rid of the confusing mapping between names
>> and paths.
>>
>> The test is incomplete as the long term vision is not achieved yet.
>> (which would be fetching both the renamed submodule as well as
>> the gitlink thing, putting them in place via e.g. git-pull)
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>  Heiko,
>>  Junio,
>>
>>  I assumed the code would ease up a lot more, but now I am undecided if
>>  I want to keep arguing as the code is not stopping to be ugly. :)
>
> So we are basically coming to the same conclusion? :) My previous
> fallback approach basically did the same but with the old architecture
> (without parallel fetch, ...) and was already ugly.

It depends on the conclusion you drew. ;)
Here is my conclusion:
* It would really be nice to have this fallback separated out.
* However for the current state the ugliness of such code trumps the
  more maintainable, long term oriented thing with path/names not
  clashing. I could not spend more time polishing these patches,
  so I could not ask you to do it either
-> I think your patches are fine as is for inclusion
-> We may have #leftoverbits here to clear up the confusion around
  path/names, as well as making the code more pleasant to read.

> With the fallback on submodule default names approach we can keep most
> of the old functionality and keep the code that handles that minimal.
>
> Since there is only a small (IMO quite unlikely) cornercase that could
> break peoples expectations I would like to have a look whether anyone
> even notices the behavioral change on next or master. If there are
> complaints we can still extend and add the two lists.

That sounds good to me.

>
>>  The idea is to treat submodule and gitlinks separately, with submodules
>>  supporting renames, and gitlinks as a historic artefact.
>>
>>  Sorry for the noise about code ugliness.
>
> Why sorry? For me it is actually interesting to see you basically coming
> to the same conclusions.

I thought I might come off awkwardly criticizing code for ugliness without
having a better alternative to show.

Thanks for working on this,
Stefan

>
> Cheers Heiko
