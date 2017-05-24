Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643F020281
	for <e@80x24.org>; Wed, 24 May 2017 02:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937947AbdEXCpm (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 22:45:42 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33278 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937917AbdEXCpg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 22:45:36 -0400
Received: by mail-pg0-f67.google.com with SMTP id s62so15369549pgc.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 19:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=0U8ZcysRznBJ4uMYDPrnMH4D8+ojOyH3FTgOgYnQoEI=;
        b=M6DcHEhhDZlAfqY0RdX0D/ZABXe41eb4sXNeWL7AiTwWpMZCIRU+re70b0d0uDAbiZ
         yDv8s0VFbvkaFkzn+nKeU7xBwZG/vPZJGTaCEnNfTTvGCso8oKfWjarmj+RyQo1lCc7r
         40UwGt7E1CHDfEGtiUY6MbttFYvp7r6ISuc/KQ6jLjvbTHFPv2X76J/sQU5HM3ivmKnd
         cIrxzxOxotm9dmEcxaJpoQXjoRYinRsgq9MMMzpB615IioxB3Hzb+HspEw3kG3rSw3vN
         ako1qwp1q/DDvKNOCgnWlSaCcxx3Y2oFncsJ1VuxmwiPM445/B/eUJC5YVoKSUZaVrcK
         eRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=0U8ZcysRznBJ4uMYDPrnMH4D8+ojOyH3FTgOgYnQoEI=;
        b=GsbYQRU6RAPL+kBQ2WURqHR+vqtRuNj0FZqKrFBNOR3ED3iLKkBVjoTn6ZiCgaWhu+
         /miILzCCtZwjtTXotgGm+QKqMaGcoHJiHrjbKTgnBImagYhAdmP2ucLwxvPauTg2BV2L
         wjp/tmpxWeKzEbWxpMROPNFOa3R8qX4xtYq9Lhel8WYZS1eIqYM/bQE3jwY8E5roM07V
         jUYJEPynYikU/RfeT2PTiT5345u9M8TdATOl++YSHsMzPnHxzABlpqYIJ21OkOJfi0KM
         n20CsHZpXbNqIyNa3VEBDhXBMSLklUwnA7ewbCr0DT6dyCpVQhccKGT0NHzgxlVIY12s
         xhZA==
X-Gm-Message-State: AODbwcCROLgYS4JxroQzzyKvulcKGwh3S6Gid42Crn65dF7moKEpBvDZ
        eGfV5hQX/eQQ5w==
X-Received: by 10.99.103.7 with SMTP id b7mr36396920pgc.2.1495593935995;
        Tue, 23 May 2017 19:45:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:167:7063:293b:a24d])
        by smtp.gmail.com with ESMTPSA id o76sm4212909pfi.119.2017.05.23.19.45.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 19:45:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/25] Prepare to separate out a packed_ref_store
References: <cover.1495460199.git.mhagger@alum.mit.edu>
Date:   Wed, 24 May 2017 11:45:34 +0900
Message-ID: <xmqq7f17ht0x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * Since v1, branch `bc/object-id` has been merged to `next`, and it
>   has lots of conflicts with these changes. So I rebased this branch
>   onto a merge of `master` and `bc/object-id`. (I hope this makes
>   Junio's job easier.) This unfortunately causes a bit of tbdiff noise
>   between v1 and v2.

Heh, that gives me an excellent excuse to procrastinate, as I am
planning to merge that topic to 'master' by the end of this week ;-)

Jokes aside...

> * Patch [01/25]: in t3600, register the `test_when_finished` command
>   before executing `chmod a-w`.
>
> * Patch [04/25] (new patch): convert a few `die("internal error: ...")`
>   to `die("BUG: ...")`.
>
> * Patch [05/25]: Use `strlen()` rather than `memchr()` to check the
>   trim length, and `die()` rather than skipping if it is longer than
>   the reference name.
>
> * Patch [08/25]: Name the log message arguments `msg` for consistency
>   with existing code.
>
> * Patch [10/25]: Rename the new member from `packlock` to
>   `packed_refs_lock`.
>
> * Patch [13/25] (new patch): Move the check for valid
>   `transaction->state` from `files_transaction_commit()` to
>   `ref_transaction_commit()`.

All of these feel familiar ;-)

> * Patch [14/25]:
>
>   * Add more sanity checks of `transaction->state`.
>
>   * Don't add `ref_transaction_finish()` to the public API. Instead,
>     teach `ref_transaction_commit()` to do the right thing whether or
>     not `ref_transaction_prepare()` has been called.
>
>   * Add and improve docstrings.
>
>   * Allow `ref_transaction_abort()` to be called even before
>     `ref_transaction_prepare()` (in which case it just calls
>     `ref_transaction_free()`).
>
> * Lots of improvements to commit messages and comments, mostly to
>   clarify points that reviewers asked about.

Overall this looked like quite a quality work to me.

> These changes (along with the merge commit that they are based on) are
> also available as branch `packed-ref-store-prep` in my GitHub fork
> [2]. If you'd like to see a preview of the rest of the changes (which
> works but is not yet polished), checkout the `mmap-packed-refs` branch
> from the same place.

Thanks.
