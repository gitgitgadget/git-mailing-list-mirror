Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35C991F462
	for <e@80x24.org>; Mon, 10 Jun 2019 17:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbfFJR4s (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 13:56:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56034 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388174AbfFJR4s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 13:56:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so223719wmj.5
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 10:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0Iz3FIXKko0MbFr7f26iDIEVEi2hR63t6ZOaV9tZ21I=;
        b=TS8jmoJYBtmGmLZ639EtZtufJr1H74lnTZMlSMSnsy5TrW68AonFqTIlsulKKHeP5I
         zp6ssgXp4r3U8sAyJW5ysWBZHqI8GvFMypkZ6vWOTjSYZzVUXL++TIdUMRyFlgAswB5O
         o45v6K0bVUGn+V506iYUInyTH1TjpoIw4gpeVQoEAb/82g9PEVpiYa/tObDZvdYR/4t+
         s6g7GZVPmo9D4edQmztSVOSO/tULTByBXWZ951mqwKPtnk4AYZtZH7MsO9Nx3cPLAd8h
         RwqV2en5MSoQFCElpPqhAaljUa1HLYuA7H3wERbhWQ+4KUKuph+YR5tFM+QxmjQ/lXVr
         4ggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0Iz3FIXKko0MbFr7f26iDIEVEi2hR63t6ZOaV9tZ21I=;
        b=H3Z6ZaEsbVJ02NnrskVAnU8EidZXpLnnDbfjhOmEKhDqo9Z8KwP2N3WjDz9c49D5QB
         z7hwfKeSNWYpLN1NgJoD3iHi+zqvmp1N2hS6dKhzuGsVcPq7QTZ++vgM73FnZNfpgh24
         MjWQl2ux+NYdEthIVIDt3ospuLh8YVikY4TkFDNhPCqTwPi8svcr4pPMhnKfwLiKoBI7
         9aDgwJfXw37zv73XheZbIEqYn+V026Zd5mfJPQC+EGdo0T8JtHpGmLGKqxj3q8oGhnG7
         QA1b5lOndN1BVbzFpt5hFxD6gGOZtCZ19B474vHxHbCWc4Dx6eCDDpKjAA3FCHD7BSPL
         dHQg==
X-Gm-Message-State: APjAAAXA5SEtUmz/mTUdc3lgtommO7zwnYQPpqAN1+TGD5mAkMU+Ptqv
        11c7RKqS+ggLgp2JAQ86AGNNohM6
X-Google-Smtp-Source: APXvYqwtm2Q4sB9jgh0J+CyPEUlwB/PrEMWaY1eo/g+DNkN7KaJLN5B7YYbt83ok6aaNknF4uHsaig==
X-Received: by 2002:a7b:c5ca:: with SMTP id n10mr13316334wmk.136.1560189406071;
        Mon, 10 Jun 2019 10:56:46 -0700 (PDT)
Received: from szeder.dev (x4d0c1d42.dyn.telefonica.de. [77.12.29.66])
        by smtp.gmail.com with ESMTPSA id y16sm9857299wru.28.2019.06.10.10.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 10:56:45 -0700 (PDT)
Date:   Mon, 10 Jun 2019 19:56:42 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] t7610-mergetool: do not place pipelines headed by
 `yes` in subshells
Message-ID: <20190610175642.GB4012@szeder.dev>
References: <cover.1560152205.git.j6t@kdbg.org>
 <75c812bd4838f6f35b6f42b97ae396ebb28d8b95.1560152205.git.j6t@kdbg.org>
 <20190610095942.GA19035@szeder.dev>
 <xmqq36khnyky.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq36khnyky.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 10, 2019 at 10:23:57AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > turn these
> >
> >   test "$(cat file1)" = "that"'
> >
> > checks into
> >
> >   echo that >expect &&
> >   test_cmp expect file1
> >
> > because 'test_cmp' on Windows first compares the two files in shell
> > and runs 'diff' only when there is a difference to report.
> 
> Needs measuring.  Is two extra file I/Os that inexpensive?

Compared to subshells and external processes, yes.

I run this on Linux:

  --- >8 ---

#!/bin/sh

test_description='test'

. ./lib-bash.sh

test_expect_success 'test' '
	echo "master updated" >file1 &&

	echo "original:" &&
	time for i in $(seq 1000)
	do
		test "$(cat file1)" = "master updated"
	done &&

	echo "using test_cmp:" &&
	time for i in $(seq 1000)
	do
		echo "master updated" >expect &&
		test_cmp expect file1
	done &&

	echo "using mingw_test_cmp:" &&
	time for i in $(seq 1000)
	do
		echo "master updated" >expect &&
		mingw_test_cmp expect file1
	done
'

test_done

  --- >8 ---

And it produced:

  original:
  
  real    0m1.888s
  user    0m1.491s
  sys     0m0.532s
  using test_cmp:
  
  real    0m1.233s
  user    0m0.877s
  sys     0m0.432s
  using mingw_test_cmp:
  
  real    0m0.344s
  user    0m0.298s
  sys     0m0.026s
  ok 1 - test

It's faster even on Linux, so it should be much faster on Windows,
where both external commands and subshells have much higher overhead.

However, there are only about 50 "$(cat ...)" in t7610 that can be
eliminated this way, which is not all that much compared to the
several thousand processes shown in the cover letter...

Anyway, there is still the better developer experience in case of one
of these checks were to fail without '-x' tracing... :)

