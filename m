Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4911C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 21:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDF020721
	for <git@archiver.kernel.org>; Thu, 28 May 2020 21:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cMpE43dR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436526AbgE1VVv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 17:21:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53248 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436527AbgE1VVr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 17:21:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5CBDECE541;
        Thu, 28 May 2020 17:21:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0OnsmjOlYmv4rTJC+KPqfuppFFU=; b=cMpE43
        dRUxZNdz/gVA1AD1fp+9K0pgdnstOpl0SNmDIAq4tN/bjtsCq3/Wn8zUZGvqEDse
        w3og9u8jS/Y3osPWq6gGVWvakn/k90diikBaEBNKivZc0u8wlN4k1bwacjyMigYI
        GzLtGlDUA89JmMUhYTyTjJXNnOdOyArFjc99o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kmObs5ewV4Uty1jzBudtSvTqM8hqJJfV
        hsFhv7hmMlK9tTXJrJ9BJKP1k2dNaX/s59Leyvq/BmOmLiENYspfnS6WySF6g0hc
        cRADjV3qRy/d4IwtCEB0a0/+E2QFzNCaa+Sdetxp552qPk06L0LeKkNbTcLQPxVf
        HtHvPEhqTdI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 554F7CE540;
        Thu, 28 May 2020 17:21:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 93041CE53D;
        Thu, 28 May 2020 17:21:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v15 00/13] Reftable support git-core
References: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
        <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
Date:   Thu, 28 May 2020 14:21:38 -0700
In-Reply-To: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Thu, 28 May 2020 19:46:36
        +0000")
Message-ID: <xmqq8shb3gd9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38C1E7EE-A129-11EA-AE8E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This adds the reftable library, and hooks it up as a ref backend. Based on
> hn/refs-cleanup.
>
> Includes testing support, to test: make -C t/ GIT_TEST_REFTABLE=1
>
> Summary 20479 tests pass 1299 tests fail

Testing without GIT_TEST_REFTABLE=0 gives a few failures, too.  I
haven't taken a look into them, though.

Thanks.


*** log for hn/reftable ***
HEAD is now at 341a26d318 Add reftable testing infrastructure
GIT_VERSION = unknown.g00000000
    * new build flags
    CC fuzz-commit-graph.o
    CC fuzz-pack-headers.o
    CC fuzz-pack-idx.o
    CC bugreport.o
...
[14:11:46] t7112-reset-submodule.sh ........................... ok   141577 ms ( 2.43 usr  0.95 sys + 661.06 cusr 464.38 csys = 1128.82 CPU)
[14:11:50] t9402-git-cvsserver-refs.sh ........................ ok    41912 ms ( 0.61 usr  0.17 sys + 260.43 cusr 177.60 csys = 438.81 CPU)
[14:12:03] t9001-send-email.sh ................................ ok   129424 ms ( 1.47 usr  0.57 sys + 576.18 cusr 387.33 csys = 965.55 CPU)
[14:12:03]

Test Summary Report
-------------------
t3510-cherry-pick-sequence.sh                    (Wstat: 256 Tests: 50 Failed: 0)
  Non-zero exit status: 1
  Parse errors: Tests out of sequence.  Found (14) but expected (13)
                Tests out of sequence.  Found (15) but expected (14)
                Tests out of sequence.  Found (16) but expected (15)
                Tests out of sequence.  Found (17) but expected (16)
                Tests out of sequence.  Found (18) but expected (17)
Displayed the first 5 of 39 TAP syntax errors.
Re-run prove with the -p option to see them all.
t3404-rebase-interactive.sh                      (Wstat: 256 Tests: 118 Failed: 0)
  Non-zero exit status: 1
  Parse errors: Tests out of sequence.  Found (100) but expected (98)
                Tests out of sequence.  Found (101) but expected (99)
                Tests out of sequence.  Found (102) but expected (100)
                Tests out of sequence.  Found (103) but expected (101)
                Tests out of sequence.  Found (104) but expected (102)
Displayed the first 5 of 22 TAP syntax errors.
Re-run prove with the -p option to see them all.
Files=906, Tests=22755, 360 wallclock secs (10.16 usr  3.35 sys + 1318.97 cusr 996.62 csys = 2329.10 CPU)
Result: FAIL
make[1]: *** [Makefile:52: prove] Error 1
make[1]: Leaving directory '/usr/local/google/home/jch/w/git.cycle/t'
make: *** [Makefile:2799: test] Error 2
