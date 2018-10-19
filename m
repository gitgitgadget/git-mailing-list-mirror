Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E21E1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 02:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJSKKX (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 06:10:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39994 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSKKX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 06:10:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id z204-v6so2136683wmc.5
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 19:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cLw0z1HGKZvjjenE2hVtwf7Qt7rhKF7rJf7g2aSD+Vw=;
        b=fsbhWCsF0WCpEdNQMPjf94aDqqh11j2Z7MjeoaBKZkpfWJxyimJiZyaTeUjVvumtpU
         8TUn24XT41bZ7FOYWW/ajbJ+MIhVaKeStKji/kCkGE/9UiHoW9BAusw9V5yJQHY6ZaDJ
         s4KCGTai1/Fnz88o5L98ZVDDEKhf8LRKebH6l9GEmMeFsI2bk3Q+1cUayTrkBAUm9UwJ
         w4lbT7aUXv8DZv/55H9lb/oCpXFWL8Zv8Ow0nMA4EqeBGgmtHxf3qod2H4SHpKzYuU+s
         Vge721uHUBy/Aoddimo/HJMJgbAv+lNPrLoeTXbleuGuCSCVndhSA+tNJy8qTpfcy1Kj
         BlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cLw0z1HGKZvjjenE2hVtwf7Qt7rhKF7rJf7g2aSD+Vw=;
        b=CpqW2pY/PZtnriDdBlPFBGjprmdEgSRBJTiIFznKc1668grwI4iGX7D/qEEpz427JA
         PqS5WlEhERBUtSNC9VGnUqATFLZRuiLtoKbAl7jkRsrhDWMvvdZK6v3fAw+L21caZlr1
         9aZzWmDX+aRAdFuII+u1FHLEn7janklh1jllhDNSHV86u5hrLzcWOVxUjyaIXA7uR5RP
         LelVmtIIQ9qBvhqhvX97TIdouFJe+zcyEFVrxGdLK3+H8FiCUlytNK1Blt/sty6U4pxp
         W9TW2O0PpXKBXBjKxe6EtBAh773teUCROj9c+J398QwaR43jB3luGu78gbKdztD6bFa9
         Cevw==
X-Gm-Message-State: ABuFfohIBlixLfC6Iz0cCqjkm40edaJ9gVL4MzxGcvGO0iik+Drae8G1
        eKmAOL07+m+tu0uOllA3uRE=
X-Google-Smtp-Source: ACcGV63DRpIJ7CnMJVGB4JxAAjdOnqGgQmHK/hMHw93r4pZhfXCeI/JFbREuCac97asJzkPWTJ3eIA==
X-Received: by 2002:a1c:b9cf:: with SMTP id j198-v6mr2606745wmf.57.1539914787280;
        Thu, 18 Oct 2018 19:06:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e133-v6sm1434161wma.42.2018.10.18.19.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 19:06:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 02/13] ci/lib.sh: encapsulate Travis-specific things
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
        <815152e0f57d545ae2fae7429c16e5be497746be.1539598316.git.gitgitgadget@gmail.com>
        <20181018220106.GU19800@szeder.dev>
Date:   Fri, 19 Oct 2018 11:06:25 +0900
In-Reply-To: <20181018220106.GU19800@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 19 Oct 2018 00:01:06 +0200")
Message-ID: <xmqqy3au3d26.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Mon, Oct 15, 2018 at 03:12:00AM -0700, Johannes Schindelin via GitGitGadget wrote:
>> diff --git a/ci/lib.sh b/ci/lib.sh
>> index 06970f7213..8532555b4e 100755
>> --- a/ci/lib.sh
>> +++ b/ci/lib.sh
>> @@ -1,5 +1,26 @@
>>  # Library of functions shared by all CI scripts
>>  
>> +if test true = "$TRAVIS"
>> +then
>> +...
>> +	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>> +	export GIT_TEST_OPTS="--verbose-log -x --immediate"
>> +fi
>
> Please set all these variables ...

Do you mean "VAR=VAL; export VAR" is kosher, "export VAR=VAL" is
not?

>> @@ -81,7 +102,6 @@ check_unignored_build_artifacts ()
>>  # and installing dependencies.
>>  set -ex
>
> ... after we turn on 'set -x', so the variables' values will be
> visible in the logs.

Ah, no, you didn't.  Although I think both are valid points, I think
ci/lib.sh is expected to be used only inside a more predictable
environment (e.g. we know the shell used is not a random POSIX shell
but one that is happy with "export VAR=VAL"), so it should be OK.
Showing the values of these variables in the log may still be good
idea.

> (Or move this 'set -ex' to the beginning of the script?  Then we
> could perhaps avoid similar issues in the future.)

Sure (provided that it is an issue to begin with---if we are
interested in the value of TRAVIS_BRANCH, for example, being able to
see it only because "CI_BRANCH=$TRAVIS_BRANCH" assignment is made
feels a bit sideways---we'd be better off explicitly logging
anything we are interested in in the longer term, no?).
