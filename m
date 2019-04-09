Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81EE20248
	for <e@80x24.org>; Tue,  9 Apr 2019 09:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfDIJno (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 05:43:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40781 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfDIJno (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 05:43:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id z24so2516499wmi.5
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 02:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YmJbzORutEFj40awrTB2bpfliqxr9pdTZNiiB4WhfTQ=;
        b=D3cdANCddSG13oG1Gu8yQDqkk9MRvQbjklmIFmoSHE/qNKtweQPLDQ8Uxip1VqBFHm
         8I9K8qFyPC0VgWkQ8VMNmOqWt1OrncXEMMZUjjuVQ3mqryRkCCkFm1cCYCsfDD55hFTS
         1pGWKaaL8LBxhbzj17u+5QKXofa3nNiFSw9AAOayyOX2/hCE1h28y06/qOVL7dy9LkXH
         Gn+11lpaQytipGRQKZcU6Y9NcdMDWR/xNpCv/eWuJFuC7gUh9mQAyWOY8ZpvDEPw/s1M
         DW/8+BwVxq+CDiIoU/eQPL6c678kAd6HRmy65ghxhrHVC250bQDJQZEHqYLNxE0E3+Wr
         873Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YmJbzORutEFj40awrTB2bpfliqxr9pdTZNiiB4WhfTQ=;
        b=V2IhDo51/I1rmOIFrfUGwHlcg3lh+rew+FFObEfywpFOFOMsLrkTMyP/UguY/jMfmy
         gTPTxjGqkPLmjlTVAnbQ/y2aQjfGyE1JjlfR3+9czuazR4ABU1MPXoHI6hnDNOL2SyCc
         iUMVc4rGdRMrI/U5FnrZWSMcLOPNXr2J5JL69ntrLuyTjBIHpWNZppwbkEnF2mXJD5Vb
         kz351atfCMlNQcjq4C85+u+tUzj/5AvVOcDXOEHHcRwYnLjPOKuwO6DNwxFb7sW4+1IW
         NPbR3QOLveAWNMy3B3vURzhvGl/7ESarW6vjtlNaS66QU1LC45mPZ6z8A8ju6+mZVp1h
         xhmA==
X-Gm-Message-State: APjAAAUl1gGKdO8xpKZ/PNJgZUVbs17+U2MTGXCWSn8KEj8XNMlDI++f
        MYkavpXbgBjTPTZ5EPy8WAqguBAT4v4=
X-Google-Smtp-Source: APXvYqzVU8NY9C0g2KOE1MD06Ifk7/SH8htmTXp2YMMegpQ90gc9S7D1A7vwZO1GFjjY0M+mYhXYag==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr21850336wmh.9.1554803022458;
        Tue, 09 Apr 2019 02:43:42 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j7sm45575524wrt.96.2019.04.09.02.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 02:43:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] sha1-file: test the error behavior of alt_odb_usable()
References: <20181204132716.19208-2-avarab@gmail.com>
        <20190328200456.29240-1-avarab@gmail.com>
        <20190329134603.GB21802@sigill.intra.peff.net>
        <87pnq9aipl.fsf@evledraar.gmail.com>
        <874l78a3rz.fsf@evledraar.gmail.com>
        <xmqqimvn7fnt.fsf@gitster-ct.c.googlers.com>
        <8736mra7nq.fsf@evledraar.gmail.com>
Date:   Tue, 09 Apr 2019 18:43:41 +0900
In-Reply-To: <8736mra7nq.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 09 Apr 2019 10:45:45 +0200")
Message-ID: <xmqq5zrn7bua.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I'll leave it up to you if you want to queue just the test patch or drop

As I said in a separate message, I think it is good to make sure
that fsck does not crash.  I do not think it is good to grep in its
output.

> it. I figured I'd re-send just that since I figured just fixing the
> blindspot of the current behavior would be a good thing on its own, not
> as an endorsement of the current behavior, just a "this is the current
> known behavior" regression test.

If the behaviour is undesirable one, we could document the current
"breakage" with "test_expect_failure", whether we plan to fix it
immediately.  It is OK if readers cannot tell between a bug that is
expected to stay forever with us, or a bug that somebody is actively
working on.  

But unfortunately, there is no separate "test_merely_documenting",
that is different from "test_expect_success", so even if we claim
"this is not an endorsement, but is merely documenting the current
behaviour" when we add such a test, there is no way for future
readers to tell between the two, short of going back to "git blame"
and seeing the log message.

For that reason, I do not think it is a good practice to document
the "current behaviour that happens to be" the same way as "the
behaviour we desire" in test_expect_success.
