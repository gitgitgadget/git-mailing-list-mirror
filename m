Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A83C9209FD
	for <e@80x24.org>; Sun,  4 Jun 2017 00:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbdFDAbj (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Jun 2017 20:31:39 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33557 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbdFDAbi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jun 2017 20:31:38 -0400
Received: by mail-pg0-f44.google.com with SMTP id f185so6297407pgc.0
        for <git@vger.kernel.org>; Sat, 03 Jun 2017 17:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QuaRSkb4JdpgC1rX/t8gdMPYmgP9zIDpnlzKakBlvE4=;
        b=iKQPQ49gVm5/jiIjpRXTpAXz9VVxu4TJknAi7puyxsBZ/gkAQ9ryabqV6st/cRAVd3
         BRpYI/TQ2xbn6iMXc5MtccBMWYMPqXpxWbq1dCqK4cGUOsC2d6OnVI31b9DVZq4sjqtN
         OJJMSWn5m4hvmsoOX7/qEGrx8YZ610LiX3TtqACTdl4KEdVJo5vdHQomySEIL7nhesSD
         d34Eam6E3JriWvwaDsl8qO773qNNXp/D89RGaHjxWLCnL0CqiDCcZL7uVcaVLztbawsA
         CpqmKeaw+w/RrxzkaP3edogT+7Dt7ts0CN9bUKj7HhKJFGRWqMijB/+I6A0hrzczooD6
         YjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QuaRSkb4JdpgC1rX/t8gdMPYmgP9zIDpnlzKakBlvE4=;
        b=RQnB93OsUmiFJH1w1ZSq9Dg+AnKQifybl9gUkJwisJ6Y5eWau3fMMV0BI1PZh67JQQ
         QX/T640ovGXJNr6GHzfpLCiPv+PVQptnJxYaveka9EtthAJQjy0gUVM/D9ia+wl/uA6B
         9pMi0q0pdxju1D6PRrilkFMB/Ybx0FLYcdLqfxbT64EeRf3w3vm0OMMeGclNlD++NkgL
         JhQQIYWzK11K74oBgDHNEbKngKycVRCXLVumNIUxWyGKvSQvferXRoIZxr5Gzq8BPWJw
         bgUj83FXMU9eWgZBOnKcWAXxNB2kgo+90ITRf9j6uv6use2I2Z4ZYmbYFzDbJd0mEHos
         dZng==
X-Gm-Message-State: AODbwcDckIsR0shAQ0Z8TU+W90ALumuzwqmSc2iCFS2hEWJR+vEw4vKL
        aYO6/X9gpnYtcQ==
X-Received: by 10.84.209.175 with SMTP id y44mr7187235plh.54.1496536297499;
        Sat, 03 Jun 2017 17:31:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:e94b:f1cf:5772:ec43])
        by smtp.gmail.com with ESMTPSA id v64sm50176788pfk.86.2017.06.03.17.31.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 03 Jun 2017 17:31:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib: add ability to cap the runtime of tests
References: <20170603221335.3038-1-avarab@gmail.com>
Date:   Sun, 04 Jun 2017 09:31:36 +0900
In-Reply-To: <20170603221335.3038-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 3 Jun 2017 22:13:35 +0000")
Message-ID: <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Speeding up the test suite by simply cataloging and skipping tests
> that take longer than N seconds is a hassle to maintain, and entirely
> skips some tests which would be nice to at least partially run,
> e.g. instead of entirely skipping t3404-rebase-interactive.sh we can
> run it for N seconds and get at least some "git rebase -i" test
> coverage in a fast test run.

I'd be more supportive to the former approach in the longer run for
two reasons.

Is it even safe to stop a test in the middle?  Won't we leave
leftover server processes, for example?

    I see start_httpd at least sets up "trap" to call stop_httpd
    when the shell exits, so HTTP testing via lib-httpd.sh may be
    safe.  I do not know about other network-y tests, though.

Granted, when a test fails, we already have the same problem, but
then we'd go in and investigate, and the first thing we notice would
be that the old leftover server instance is holding onto the port to
prevent the attempt to re-run the test from running, which then we'd
kill.  But with this option, the user is not even made aware of
tests being killed in the middle.

> While running with a timeout of 10 seconds cuts the runtime in half,
> over 92% of the tests are still run. The test coverage is higher than
> that number indicates, just taking into account the many similar tests
> t0027-auto-crlf.sh runs brings it up to 95%.

I certainly understand that but in the longer term, I'd prefer the
approach to call out an overly large test.  That will hopefully
motivate us to split it (or speed up the thing) to help folks on
many-core machines.

I am afraid that the proposed change will disincentivize that by
sweeping the problematic ones under the rug.  Perhaps you can
collect what tests are terminated in the middle because they run for
too long and show the list of them at the end, or something?

Also, I thought that it was a no-no to say "to_skil=all" with
skipped-reason in the middle of a test when the test is run under
prove?

Oh, by the way, is "date +%s" even portable?  I thought not.



