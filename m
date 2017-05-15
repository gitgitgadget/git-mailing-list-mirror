Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 780D1201CF
	for <e@80x24.org>; Mon, 15 May 2017 08:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757232AbdEOI7Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 04:59:25 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33425 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756920AbdEOI7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 04:59:23 -0400
Received: by mail-pf0-f195.google.com with SMTP id f27so4702660pfe.0
        for <git@vger.kernel.org>; Mon, 15 May 2017 01:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GRUZs50vOtSL9opLPA8FOXPhTR9FldWNq7n4qsf9Xy8=;
        b=RSg51tFpbmz/Z9kx+ZP4Mea7MOJCCwSgU9aWgzdpFesCg9E2e0z64fDXkPczyMnuIt
         ZlZLgK9wdzbm8044Y4h7f+0Hfke4f17q3aQZFYmV/jcVnMIOSD1d6WvfoXwwklH6JwHm
         Ln0cY2CJM8km2PbU3ANEWrEv/prDaLkcHCsaFDoKoEgB7F1IgYp6wZXehBJCDCCHCHbA
         I9LQXbNCE/QEtSqioGEEgscgTe1JQ3OZY11tcRLC8ODMCIENgO1ddbMI4VeaeReW48M+
         fs773l1LcCvR/JbFiwjSsb3XCUbfHa19ZpslnreBLOq7KBKd91GRbXeYmSgw4iswGrTu
         6I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GRUZs50vOtSL9opLPA8FOXPhTR9FldWNq7n4qsf9Xy8=;
        b=Kuc80HD/67dczE2XSSDmex0IqsHeczLgnsl88zCqJzxeEY6V5iYia6aib340oeVlZa
         ojtwlGxeOJ/hshuu0IXf1pf0qSQ/ivGcg2Nd1fZubD2VszqdDofjP9HpjWt4tA229qts
         mYR5s0Wermy2WeAndQFNHor2BuODle65Qkr5qFyC/EpgaF//LTZfRU/6OGZg0yQKC73U
         pkTkQrpAS0DscUFezCTxrTEebxxX3wzLyv57e+tSUeGud7mF1EaAJLTXM5fp0eySnmQ+
         np02l5rV8f9Q1Hn+DGcJPcnaGru0BBbO2zMHGw1y96EnpT0qJPFUXfdJid1Hx/8FT9AX
         GZNQ==
X-Gm-Message-State: AODbwcCyH0H9Iui8FH/w9PEvXpRb06k+ulmVIZnVqjiWubGF82EbqI0e
        Evlg62uPmcy3vg==
X-Received: by 10.99.98.65 with SMTP id w62mr4989056pgb.207.1494838762200;
        Mon, 15 May 2017 01:59:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id r64sm17625490pfr.38.2017.05.15.01.59.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 01:59:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 27/29] pack-objects: fix buggy warning about threads
References: <20170513231509.7834-1-avarab@gmail.com>
        <20170513231509.7834-28-avarab@gmail.com>
Date:   Mon, 15 May 2017 17:59:20 +0900
In-Reply-To: <20170513231509.7834-28-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 13 May 2017 23:15:07 +0000")
Message-ID: <xmqqfug6v6l3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Fix a buggy warning about threads under NO_PTHREADS=YesPlease. Due to
> re-using the delta_search_threads variable for both the state of the
> "pack.threads" config & the --threads option, setting "pack.threads"
> but not supplying --threads would trigger the warning for both
> "pack.threads" & --threads.
>
> Solve this bug by resetting the delta_search_threads variable in
> git_pack_config(), it might then be set by --threads again and be
> subsequently warned about, as the test I'm changing here asserts.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/pack-objects.c | 4 +++-
>  t/t5300-pack-object.sh | 3 +--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 0fe35d1b5a..f1baf05dfe 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2472,8 +2472,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
>  			die("invalid number of threads specified (%d)",
>  			    delta_search_threads);
>  #ifdef NO_PTHREADS
> -		if (delta_search_threads != 1)
> +		if (delta_search_threads != 1) {
>  			warning("no threads support, ignoring %s", k);
> +			delta_search_threads = 0;
> +		}
>  #endif
>  		return 0;
>  	}
> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index 1629fa80b0..0ec25c4966 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -445,8 +445,7 @@ test_expect_success !PTHREADS,C_LOCALE_OUTPUT 'pack-objects --threads=N or pack.
>  	git -c pack.threads=2 pack-objects --stdout --all </dev/null >/dev/null 2>err &&
>  	cat err &&
>  	grep ^warning: err >warnings &&
> -	test_line_count = 2 warnings &&
> -	grep -F "no threads support, ignoring --threads" err &&
> +	test_line_count = 1 warnings &&
>  	grep -F "no threads support, ignoring pack.threads" err &&
>  	git -c pack.threads=2 pack-objects --threads=4 --stdout --all </dev/null >/dev/null 2>err &&
>  	grep ^warning: err >warnings &&

Commenting on both 26 and 27.

The usual way we document a known breakage to be fixed is to write a
test that checks for the desired outcome with test_expect_failure,
and when a patch corrects the behaviour we just flip it to expect
success instead.  On the other hand, when we document a behaviour
that is accepted/acceptable we would have a test that checks for the
then-accepted behaviour with test_expect_success, and a patch that
improves the behaviour would update the expectation.

This follows the second pattern, even though the log message for the
patches claim this is about an existing bug and its fix.

Now, I am not saying (at least not yet) that 26 & 27 violates the
established practice and they must be changed to expect seeing only
one line of output in warnings with test_expect_failure in patch 26
which is flipped to test_expect_success in patch 27.  Yes, it does
not follow the usual pattern, but it gives a good food-for-thought.

Perhaps our usual pattern may be suboptimal in illustrating in what
way the current behaviour is not desirable, and the way these two
patches document the current breakage and then documents the fixed
behaviour may be a better example to follow?  With our usual way, it
is not apparent until you actually run the tests with the current
code what the questionable current behaviour is, but with the way
patch 26 is written, we can tell that two warnings are given,
instead of one.

I dunno.  What do others think?
