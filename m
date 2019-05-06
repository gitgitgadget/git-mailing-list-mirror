Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15D061F488
	for <e@80x24.org>; Mon,  6 May 2019 23:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfEFXXX (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 19:23:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36059 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfEFXXW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 19:23:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so1196396wmj.1
        for <git@vger.kernel.org>; Mon, 06 May 2019 16:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c9RiZqqic8E8uFmrWnWecNYUnsy7t1tFb5Mt5ZxLuJI=;
        b=oOdmMQeR0fRQcHRj89W5QstGZGawWx3DHlPmzUrZFrRXViBggW7Kg/aa9CWWpnCRBU
         bN+i4zLEVUVoVpLn2Kl/0lBn8/HheIEN7mGvmw2HIZq8+rpl2FI84TINC57UXhwFdCcY
         6WE5hoaX3Vi/BHGhxNNBQ6mhOkoPJ63KNB1WzANIARVAC2ts50hRna5EcEa6uDPtNhLQ
         RRTpFek113nyrUMYoEsXikxLeZ5gXTdqutU5bpKPf7o+DMX+HqmtaMkJUpT27V0jq/sT
         T24im1fiQ1PfZw3FLH4opseywZpuFxXQ9BhYqXrBkSSGjguqkeqr66ZVUwGkY+I7Pkb1
         o2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c9RiZqqic8E8uFmrWnWecNYUnsy7t1tFb5Mt5ZxLuJI=;
        b=kUbn0wiEX/efIT5V/YXlbbHIUDkV9GL/xmev5lC9YqFlQW9b3OyFfmoaQYAXNll4+O
         9xZaReVbAubwmYuokls5PxWmkqSlF+LpUfkpqijpcsdzYzakUjXG2Rb7yEstgkEsoayp
         RrrE0usW5cgLaGywH9l9zqFkUtp+JL8Hln3ZndEZrozoTnk3siG8hcRupjMjU8GE8zVI
         Twp9oOnFLT3gSvhFqPLDzvS5MxG3ve8cdPISS2v/p7vEzcTVv7yb7RlCQ9QNCodk9KG7
         B5cCAtmjOh70N3tBvxs5QD/bl7rifN6UuU2YMbeYF2FLrzZIPDD1kzlV2EvVLWJY3KSN
         QNmg==
X-Gm-Message-State: APjAAAX3QHfChMbCmgA7CC4aVkdS10js/Qd+t3KrkHyt3pQKWsRfnRD7
        obxlSIHVX4erb5TJFwPDRy5yGLq/Sv0=
X-Google-Smtp-Source: APXvYqxmfoU/St4rWXexAbkwrADuOmiqFqRI1ifyg7ivt55u59M5D+TFREYHBVW/D+7LtE0lw15Jow==
X-Received: by 2002:a1c:7f97:: with SMTP id a145mr18993427wmd.139.1557184998518;
        Mon, 06 May 2019 16:23:18 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c131sm9094436wma.31.2019.05.06.16.23.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 16:23:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/2] perf-lib.sh: fix 0baf78e7bc regression, refactor & fix bugs
Date:   Tue,  7 May 2019 01:23:07 +0200
Message-Id: <20190506232309.28538-1-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18
In-Reply-To: <20190506202451.GA19850@sigill.intra.peff.net>
References: <20190506202451.GA19850@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 06 2019, Jeff King wrote:

> On Mon, May 06, 2019 at 09:16:11PM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> Perhaps there's some better way to fix this, but it seems to me that
>> the best solution is to just make this behavior less magical. We know
>> in run_dirs_helper() that we're about to run performance tests on a
>> given <revision>, so let's just set GIT_TEST_INSTALLED to an absolute
>> path there, and then make getting logging target from a previously
>> relative path less magical, we'll just explicitly pass down the
>> relative path as a variable.
>> 
>> This makes e.g. these cases all work:
>> 
>>     ./run . $PWD/../../ origin/master origin/next HEAD -- <tests>
>> 
>> As well as just a plain one-off:
>> 
>>     ./run <tests>
>
> Doing this naively would break anybody doing:
>
>   GIT_TEST_INSTALLED=some-relative-path ./p1234-foo.sh
>
> but I doubt that actually matters in practice (notably this already does
> not work with non-perf tests, as test-lib.sh does not do any
> normalization).

Yeah this has never worked and GIT_TEST_INSTALLED has been documented
to take an absolute path when used with the normal test suite.

I've noted as much in the 1/2 here.

> I don't think your patch does, because it leaves the extra absolutizing
> in perf-lib.sh. But then it doesn't feel like it's really simplified
> anything. ;)

Yeah, v1 didn't because I was trying for a minimal regression fix
without digging us fully out of that GIT_TEST_INSTALLED hole, but as
2/2 here shows we can fully get rid of it from perf-lib.sh, which I
think makes things much simpler.

>> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
>> index 169f92eae3..b15ee1d262 100644
>> --- a/t/perf/perf-lib.sh
>> +++ b/t/perf/perf-lib.sh
>> @@ -32,6 +32,10 @@ TEST_NO_MALLOC_CHECK=t
>>  if test -z "$GIT_TEST_INSTALLED"; then
>>  	perf_results_prefix=
>>  else
>> +	if test -n "$GIT_PERF_DIR_MYDIR_REL"
>> +	then
>> +		GIT_TEST_INSTALLED=$GIT_PERF_DIR_MYDIR_REL
>> +	fi
>>  	perf_results_prefix=$(printf "%s" "${GIT_TEST_INSTALLED%/bin-wrappers}" | tr -c "[a-zA-Z0-9]" "[_*]")"."
>>  	GIT_TEST_INSTALLED=$ABSOLUTE_GIT_TEST_INSTALLED
>>  fi
>
> So we reset GIT_TEST_INSTALLED to the relative path here (ignoring
> what's in it!), and then afterwards set it to the absolute path. That
> still seems rather magical. :)
>
> What if instead we:
>
>   - taught test-lib.sh to make GIT_TEST_INSTALLED absolute (since after
>     all it is the one who is planning to chdir and wreck the relative
>     path)
>
>   - let callers pass in $GIT_PERF_RESULTS_PREFIX instead of guessing at
>     it ourselves from the path name. Then the "run" script could quite
>     reasonably just pass in the tree oid it already has instead of us
>     trying to decode it. And nobody would care about whether
>     $GIT_TEST_INSTALLED has been mangled.
>
> I thought about going this route for my original patch, but I wanted to
> fix the regression (which I agree is quite serious and embarrassing) as
> quickly and simply as possible.

It seems simplest after the changes I've made here to just make a
relative GIT_TEST_INSTALLED be an error in test-lib.sh, why bend over
backwards to support it?

Re GIT_PERF_RESULTS_PREFIX: Depending on what you mean we now have
that in 2/2 as PERF_RESULTS_PREFIX.

But if you mean the user can pass it in that doesn't make sense, since
we need to pick a different prefix revision we test, so it's a
many-to-many relationship.

As seen in 2/2 modifying some of the shell & associated Perl code it's
a bit nasty that we need to duplicate the logic for picking these
PERF_RESULTS_PREFIXes in the shell code and Perl code. Ideally the
shell code would pick it, and pass the mapping to the Perl code
somehow. But that's another "has sucked since forever, future TODO"
item.

Ævar Arnfjörð Bjarmason (2):
  perf-lib.sh: make "./run <revisions>" use the correct gits
  perf-lib.sh: remove GIT_TEST_INSTALLED from perf-lib.sh

 t/perf/aggregate.perl | 13 ++++++-------
 t/perf/perf-lib.sh    | 11 +----------
 t/perf/run            | 41 +++++++++++++++++++++++++++++++----------
 3 files changed, 38 insertions(+), 27 deletions(-)

-- 
2.21.0.593.g511ec345e18

