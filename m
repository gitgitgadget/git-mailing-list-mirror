Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA0842013A
	for <e@80x24.org>; Wed, 15 Feb 2017 23:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbdBOXdb (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:33:31 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:16612 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbdBOXd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:33:29 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id e94gcuqbEgKste94gcP0C0; Wed, 15 Feb 2017 23:33:27 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=pIiNZIo2QrxxUPUvUv0A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <72ADDC07AFEF4BD88EADCDAF75DFB2CB@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Christian Couder" <christian.couder@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        <git-for-windows@googlegroups.com>, "git" <git@vger.kernel.org>
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox><xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com><alpine.DEB.2.20.1702142150220.3496@virtualbox><xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com><CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com><E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley><xmqqshng5osz.fsf@gitster.mtv.corp.google.com><7EA15219331242ABB08B9A9AA9F08CBE@PhilipOakley> <xmqqvasb2li8.fsf@gitster.mtv.corp.google.com>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
Date:   Wed, 15 Feb 2017 23:33:27 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfI3mSkL6WLZrSXtAu2GY7CL2qkKzTdv6vLpUZEx4lN8CsSJ3lKlz3scBJe3NXYt/oanTmN6+gufsDuQn/FAJxkvl9TKNCVIIuG2ASM8esoQwfoCVHlYG
 scW+yz0jEJPJyGZAkCFpx8B+dut6GgS8sZ+k474ce8J/boBjdi6q7aC2aSMzm8HQjZoLNzPuy1AIdwkPbu6ZjBdWc8KI/qCIukPtzdSbBfmGyGcLZo4YlSLY
 7c884bxzvT2UrWXRAwjLSscJMo/ENMiBkPaLxpEpEz1TvAmY/8u2o65sTsGcSWpREW0QaW0EWdDGI2Re6pF1CQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[sorry for the repeated emails - I'd prepared it off line, and then suffered 
a number of auto send actions]
From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> In the next..pu case the abstraction is in the other direction, we
>> have potentially multiple points of infection (from feature branches),
>> and a broad test (the whole test suite). In this case I believe we
>> would like to investigate initially the --first-parent line with a
>> classic bisect for the first point of failure (obviously including
>> feature branch merges). This would identify which feature merge, or
>> regular commit, created the first breakage.
>
> If you are going first-parent, you would limit the bisection to a
> single-strand-of-pearls, and I agree that it is a good strategy to
> find which topic branch merge broke the tip of 'pu'.
>
> If we assume that there is no funny interaction among topics that
> cancel a breakage brought in by one topic with another breakage by
> another topic, then no matter how many broken topics there are, I
> agree that we would get to the first broken topic.
>

> A good thing that comes once we assume that topics are more-or-less
> independent is that we could rebuild 'pu' minus the broken topic
> identified by the above procedure and repeat it to find other broken
> topics, still using the --first-parent bisection, because master..pu
> is a linear sequence of merges of individual topics.
>

For an integrator, or especially a CI tool, simply checking the second 
parents of each topic merge (post fail) should at least indicate if the 
basics of the feature actually passed the tests, though it doesn't check for 
interaction issues. This could give direct author feedback!
--
Philip 

