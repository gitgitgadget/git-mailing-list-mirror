Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55B1C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D51A60C3E
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 23:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhH0XVu convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 27 Aug 2021 19:21:50 -0400
Received: from shark2.2a.pl ([213.77.90.2]:60559 "EHLO shark.2a.pl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232365AbhH0XVu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 19:21:50 -0400
Received: from wrasse.2a.pl (wrasse.2a.pl [213.77.90.7])
        by shark.2a.pl (Postfix) with ESMTP id 99663175083A;
        Sat, 28 Aug 2021 01:20:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 2a.pl
Received: from shark.2a.pl ([213.77.90.2])
        by wrasse.2a.pl (wrasse.2a.pl [213.77.90.7]) (amavisd-new, port 10024)
        with ESMTP id fW74I2cbQ_Ul; Sat, 28 Aug 2021 01:20:53 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.8.1.26])
        by shark.2a.pl (Postfix) with ESMTPSA id 5BF3A1750828;
        Sat, 28 Aug 2021 01:20:54 +0200 (CEST)
From:   Krzysztof =?utf-8?B?xbtlbGVjaG93c2tp?= <giecrilj@stegny.2a.pl>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christopher Yeleighton via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Christopher Yeleighton <ne01026@shark.2a.pl>
Subject: Re: [PATCH v2] pretty-options.txt: describe supported encoding
Date:   Sat, 28 Aug 2021 01:20:53 +0200
Message-ID: <1659256.Cefek1SpHl@localhost.localdomain>
In-Reply-To: <xmqq5yvqbz0j.fsf@gitster.g>
References: <pull.1079.git.git.1630013668862.gitgitgadget@gmail.com> <2247912.lYO0ccLKhl@localhost.localdomain> <xmqq5yvqbz0j.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dnia piątek, 27 sierpnia 2021 19:03:56 CEST Junio C Hamano pisze:
> > +       The encoding must be a system encoding supported by iconv(1),
> > +       otherwise this option will be ignored.
> > +       POSIX character maps used by iconv(1p) are not supported.
> 
> This paragraph is a bit hard to grok.
> 
> I think it is saying that the "-f frommap -t tomap" form in [*1*]
> that can use arbitrary character set description file is not
> supported, but "-f fromcode -t tocode" form, which also is what
> iconv_open() takes [*2*], is supported.  Am I reading it correctly?

Yes

> 
> Is there an easier-to-read way to explain the distinction to our
> average reader?

It is not our job to explain what POSIX character maps are.  The takeaway is 
they are unsupported; if you do not know what they are, why should you bother?

> 
> What I am getting at is this.  Imagine average users who need to see
> their commits recoded to iso-8859-2.  They see "git log" has
> "--encoding=<encoding>" option, read the above paragraph and wonder
> if they are on the supported side or unsupported side of the above
> paragraph.  I want to make it easy for them to stop wondering.
> 
> For that purpose, "iconv(1) vs iconv(1p)" would not help them very
> much, especially considering that not all Git users are UNIX users
> (they probably do not even know what (1) and (1p) means).

I am sorry, as a UNIX user I have no idea what iconv, being part of the GNU C 
library, means and how it works on a non-UNIX system that does not contain 
one.  If you know, could you enlighten us please?

> I think our end-user facing manual pages tend to avoid the latter.
> We do use "shall" in the RFC2119/BCP14 sense on the technical side
> of our documentation where we give requirements to the third-party
> implementations so that they can interoperate with us, but this is
> not such a description.
> 
> Thanks.

I shall revert it after we have come to an agreement about the POSIX stuff.

BR,
Chris




