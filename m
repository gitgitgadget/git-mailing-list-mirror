Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0258DC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 23:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58A461355
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 23:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhGJXZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 19:25:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:45340 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhGJXZv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 19:25:51 -0400
Received: (qmail 7413 invoked by uid 109); 10 Jul 2021 23:23:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 10 Jul 2021 23:23:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27543 invoked by uid 111); 10 Jul 2021 23:23:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 10 Jul 2021 19:23:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 10 Jul 2021 19:23:03 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Gregory Anders <greg@gpanders.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Wong <e@80x24.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 02/13] send-email tests: test for boolean variables
 without a value
Message-ID: <YOor1ztKLGvfk68i@coredump.intra.peff.net>
References: <cover-00.13-00000000000-20210524T074932Z-avarab@gmail.com>
 <cover-00.13-00000000000-20210528T092228Z-avarab@gmail.com>
 <patch-02.13-16277bd1082-20210528T092228Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-02.13-16277bd1082-20210528T092228Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 11:23:41AM +0200, Ævar Arnfjörð Bjarmason wrote:

> +test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer' '
> +	test_when_finished "test_unconfig sendemail.xmailer" &&
> +	cat >>.git/config <<-\EOF &&
> +	[sendemail]
> +		xmailer
> +	EOF
> +	test_config sendemail.xmailer true &&
> +	do_xmailer_test 1 "" &&
> +	do_xmailer_test 0 "--no-xmailer" &&
> +	do_xmailer_test 1 "--xmailer"
> +'

Is this test_config call in the middle of the snippet meant to be there?
It seems like it would wreck the test, since it will rewrite the file to
"xmailer = true". I'm guessing it's just leftover cruft from adapting
the earlier xmailer=true test?

(I wasn't looking carefully again at this series, but just happened to
be resolving a local conflict involving this hunk and noticed it).

-Peff
