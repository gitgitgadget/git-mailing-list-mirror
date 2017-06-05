Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E20320D09
	for <e@80x24.org>; Mon,  5 Jun 2017 01:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbdFEBzs (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 21:55:48 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35268 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751225AbdFEBzq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 21:55:46 -0400
Received: by mail-pf0-f179.google.com with SMTP id l89so1313207pfi.2
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3Z8zckjB6OmON+nluujOJ4fplCvg2FwbPizdIedF4wQ=;
        b=UVORqqT8bP0vXuHMAerasnmVwWLvkLF+MfDb6IA7P1zPgvt0D2FTEe3LNPyfRDC9f4
         t5sVvf4ysALiEMC3p/3aeyVFl2Xh7OLfHSrKqXQ5v+kvtaqRlEs5UzUDx8nr+ykZUJb3
         o5U5fegylO0oKepaNyKD2rAEnYdbg6s6k6wq5nammMWJPGlSBqEV79yaJmaNfCuNasLr
         WxOw1O6m7N8Jecif7AkzTYJwKr1Fo2BtQhDf+kTuut9grKIiF9pR1wCAsXRgIAL6vINd
         u/EUgw3pTgH8Ni3C2tMvQmNQrCBM8wzJ9MAa7ioTOnAYtFyfcWYvcQrxYzvC+8prr32a
         lKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3Z8zckjB6OmON+nluujOJ4fplCvg2FwbPizdIedF4wQ=;
        b=YMZEQpaTHQJexWMKvQmMXGf0rKFBEZ3TnZHHKoTvwUpxzfEji/7aXGf0yImzT9f4cE
         8QKNdm8n3G/qwCzPzFY+lHydFmT4ZQnFHCltRAamtD1h8gaz+1D3X6sT4bJhWh4VhhUl
         oujemDoD4cIgvmjaoPoKncOUZvDMtwpVKzt1AaySIiTXSQupB3Fa6d6suTUGDjK/NYfH
         PiS6FglHR2DtgO9oP2k3nqh/Xz+XSnglrPifMXenWbxPi9w/UiGNrGh95xkTxperl0/1
         ny1FHPoHtqdIvEaKtxDAI4Cy6QyO3Ex7CUE9gkUF78zLs7E/4y/vGgmbOk5LczJu47Oc
         zq5w==
X-Gm-Message-State: AODbwcAVKaLsz1R2l1X73MnXIXqn8dc5T3y8bZqv59ADEBruQMsLXRBL
        JOEiSGQKaaTuoA==
X-Received: by 10.99.125.2 with SMTP id y2mr18571404pgc.10.1496627745836;
        Sun, 04 Jun 2017 18:55:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a83a:973:bb14:324a])
        by smtp.gmail.com with ESMTPSA id h84sm56935416pfh.45.2017.06.04.18.55.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 04 Jun 2017 18:55:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] test-lib: add ability to cap the runtime of tests
References: <20170603221335.3038-1-avarab@gmail.com>
        <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com>
Date:   Mon, 05 Jun 2017 10:55:42 +0900
In-Reply-To: <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 4 Jun
 2017 09:29:22
        +0200")
Message-ID: <xmqqefuzurj5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> I certainly understand that but in the longer term, I'd prefer the
>> approach to call out an overly large test.  That will hopefully
>> motivate us to split it (or speed up the thing) to help folks on
>> many-core machines.
>
> The reason I didn't document this in t/README was because I thought it
> made sense to have this as a mostly hidden feature that end users
> wouldn't be tempted to fiddle with, but would be useful to someone
> doing git development.
>
> Realistically I'm going to submit this patch, I'm not going to take
> the much bigger project of refactoring the entire test suite so that
> no test runs under N second, and of course any such refactoring can
> only aim for a fixed instead of dynamic N.

I do not expect any single person to tackle the splitting.  I just
wished that a patch inspired by this patch (or better yet, a new
version of this patch) made the tail end of "make test" output to
read like this:

   ...
   [18:32:44] t9400-git-cvsserver-server.sh ...... ok    18331 ms
   [18:32:49] t9402-git-cvsserver-refs.sh ........ ok    22902 ms
   [18:32:49] t9200-git-cvsexportcommit.sh ....... ok    25163 ms
   [18:32:51]
   All tests successful.
   Files=785, Tests=16928, 122 wallclock secs ( ...
   Result: PASS

   * The following tests took longer than 15 seconds to run.  We
     may want to look into splitting them into smaller files.

   t3404-rebase-interactive.sh ...    19 secs
   t9001-send-email.sh ...........    22 secs
   t9402-git-cvsserver-refs.sh ...    22 secs
   t9200-git-cvsexportcommit.sh ..    25 secs

when the hidden feature is _not_ used, so that wider set of people
will be forced to see that some tests take inordinate amount of
time, and entice at least some of them to look into it.

> Collecting the skipped ones is easy enough to do with a grep + for
> loop, so I don't think it's worth making the implementation more
> complex to occasionally answer the question of how many tests were
> skipped due to running into the timeout

"Easy enough" and "made to stand out so _NO_ effort is needed to
see" are very different things.

> Or you can just run in a mode where you stream out however many tests
> you're going to run as you go along, and then print "1..NUM_TESTS" at
> the end.
>
> We use the latter, so we can abort the entire test suite at any time
> with test_done, that's what this change does.

cf. bf4b7219 ("test-lib.sh: Add check for invalid use of 'skip_all'
facility", 2012-09-01)

>> Oh, by the way, is "date +%s" even portable?  I thought not.
>
> The lib-git-p4.sh lib says not, and shells out to python's time() is a
> workaround, I could replace this with perl -e 'print time', but
> thought it wasn't worth bothering with for an obscure optional feature
> like this.

Let's do the right thing, because doing so is easy.

I personally think that filter-branch being broken is not noticed
only because it is not very often used, as opposed to that we want
to encourage those who are following along with us, especially those
who are on minority platforms, to run our tests every day.  Let's
not spread sloppyness unnecessarily.
