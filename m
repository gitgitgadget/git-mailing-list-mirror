Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8EE51F453
	for <e@80x24.org>; Fri, 28 Sep 2018 17:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeI1XzI (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 19:55:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41900 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1XzH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 19:55:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id j15-v6so7199606wrt.8
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=n1uH+2udrmEwUG1Ar8RlIvw1hyEjNvbQfqbYj1IeSWw=;
        b=p5OoRBUNK0syEoQmIJRbutm+6f+LJ/Re8d1rSj/DQa7wvI6rwGa2nwxqF5Lta5IM9E
         be/VFBYE/rB5oFKZkvRX8pz35W+21fI+tWuHBDFZlOW7TGATZjuZUcIHxmoFW66Bir5m
         /XislKX3Jt9igp+ts/olLtQ4KuAr7Z63wKvk//CPLQ2HajTS1b5j3MM+jKLyqkmNxBhq
         cRGExJDYVoPSKDGglfph1zDeivrx7/cNP0AbyUumhDFeFPzGTDo8ARHC69hVuJ3TsKw7
         qsvwWYaPsrhkc+fm8D0vc+uzbibUeqvxA/uZC3XgIe0a/Tr6NWN8kKN7oeFQyZZ+snmY
         UMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=n1uH+2udrmEwUG1Ar8RlIvw1hyEjNvbQfqbYj1IeSWw=;
        b=os1piM29BcYV8gF6ZvTZtAySFdvGniRHHl5bl54TTm0hf7QjBANSsF0y3Db0OHX8bL
         cJVEBqv6BoqDWdt4ZKTE0oQs62IUyAGWMagJbEqjEPYrl9TUcZV++pdPKsd5n5DFukhx
         EpjUlDrcv09mVAol73wSeSPwqV97VD33QlNSl6tVcZHnqs2Z5vJ3hlx8UHbzvbfGZYCn
         wbd2KJ24D65+TWRimQ45Qmr0xza++3z7ScP1upvbDkHIczQeLstSm00++7UcMhNwltvI
         7KPwQK4KM1NrVEB9xXD9nhspIysyNoOlOl+WJ/JzI7u9zTOVmUaKSszBFqlbO/aRzQit
         iutg==
X-Gm-Message-State: ABuFfoj3sdKzYI/GtUj94JNsuitfuTEimdi1Xn/QtYGW8hc4wYf05OQl
        18LaZ/uGjBd3h9aCRkoa29g=
X-Google-Smtp-Source: ACcGV62hmDpXPZpWemldc6VPDqPT+WaBiSMNF6QrMrHHl5V02oI4IzSs+qbBOrPWYVvtLeqnipDmPQ==
X-Received: by 2002:adf:dd4c:: with SMTP id u12-v6mr2341069wrm.2.1538155818140;
        Fri, 28 Sep 2018 10:30:18 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p8sm1703614wrx.9.2018.09.28.10.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 10:30:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Subject: Re: [PATCH v2 1/5] split-index: add tests to demonstrate the racy split index problem
References: <20180927124434.30835-1-szeder.dev@gmail.com>
        <20180927124434.30835-2-szeder.dev@gmail.com>
        <20180928004843.GP27036@localhost>
Date:   Fri, 28 Sep 2018 10:30:17 -0700
In-Reply-To: <20180928004843.GP27036@localhost> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 28 Sep 2018 02:48:43 +0200")
Message-ID: <xmqqo9chcyxi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> Junio,
>
> On Thu, Sep 27, 2018 at 02:44:30PM +0200, SZEDER Gábor wrote:
>> diff --git a/t/t1701-racy-split-index.sh b/t/t1701-racy-split-index.sh
>> new file mode 100755
>> index 0000000000..ebde418d7e
>> --- /dev/null
>> +++ b/t/t1701-racy-split-index.sh
>> @@ -0,0 +1,218 @@
>> +#!/bin/sh
>> +
>> +# This test can give false success if your machine is sufficiently
>> +# slow or all trials happened to happen on second boundaries.
>> +
>> +test_description='racy split index'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup' '
>> +	# Only split the index when the test explicitly says so.
>> +	sane_unset GIT_TEST_SPLIT_INDEX GIT_FSMONITOR_TEST &&
>
> Please note that this patch adds another use of the environment
> variable GIT_FSMONITOR_TEST, while the topic 'bp/rename-test-env-var'
> is about to rename that variable to GIT_TEST_FSMONITOR.

I think the most sensible thing to do during transition is to set
(or unset) both consistently (and leave a note in t/test-lib.sh near
check_var_migration that t1701 has done so and the dup should be
corrected when transition is over---but that is optional).


