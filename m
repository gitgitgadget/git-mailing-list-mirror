Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFAFC1F404
	for <e@80x24.org>; Sat, 11 Aug 2018 21:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbeHKXf6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 19:35:58 -0400
Received: from mout.web.de ([212.227.17.12]:45865 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeHKXf6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 19:35:58 -0400
Received: from [192.168.178.36] ([79.237.241.252]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LilJB-1gKLRi1yNJ-00d1eY; Sat, 11
 Aug 2018 23:00:23 +0200
Subject: Re: [PATCH 1/2] fsck: use strbuf_getline() to read skiplist file
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <20180811164856.GB27393@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <e3c1290a-27d9-0aba-76f7-0d4b8c11c045@web.de>
Date:   Sat, 11 Aug 2018 23:00:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180811164856.GB27393@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YCIYvUqMaJp42Z2OgmSHv1Ne2nBHi1HkNLQlig3mDYXZt/TpRTu
 OlIFtwsamDfRCbQiWGA1SjlefAaZ7FbS+nzJa7ZEHk1uoiAxypf/Qk7lWzwE+NBPhi9u2g3
 IvFQDkKYZw0GG/05mpqnkOkSR+3AVfFcim21Hk+7sTVVykrntB7c3VRc3MxKg0PvfZyGrXI
 7+wKSbKJ7s3s+vr/1XkMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TDB3nkAEyYo=:fD7XBYFF3irfLuELqkfi9y
 +e15KZ4jcS4wWQCAoefPyZ5KDvVR4WgY8QUwDJcaRsr9mfrEd5cleWpkTd1zsjo69UB2+Aomn
 bTBle36BywgJnWuVY8aKHKQEZ3AvA2/gxVnMzCafPqEZ6vpykyFR1IurFDcZHzN4uY8VTlZ7t
 NdtMklBUIDjjtzfG53rfa8cXvoqqKLDR55be7EW+SnHuh9SjRlbMscyaDOfjBQxKpQe3ZR+GA
 W9VcEfd7deQH3tc1N4J02JsJC1+bHynsO5OhUYK2XdnwlQ+sjEP1QT6WcodejGH/SAFtGZC7L
 yyM0HTBhwklUfndx0ZuNG3NVD92wUXOR/gWKe63XzIhikgadKN1o8YucxjjlEFDRZmlEeT5fB
 wN8FDCRmi+cfuI50DD6XJF+4RxsmMNWk+VMY92Vu1WDAzwFl/led3eIFUBsRXq/EkCtoNN2Zb
 gIhydyjCKwpD0melwgfeVFGeK4uKw6YPm5jrKd12bw9cA1CCUAkv0GBLrQB37JWaWSD4gLvzy
 dsEf5g3dlM8IWhh5hD+5CIH6AykD9DrGBQIYFshpjY9Yri/EPyx7v82la/S6JNKy9eO3ohYIs
 p4YddbG/D7GA2AdMI4cqFjgpODobCN6j3CmwF5bkeVDNnAoGgX0501pRNNKr8RX4WwVru6hcU
 7CZH9KLhltGT1FIvid6xHL4uEVcOqSGalyD2/41V5ofZwq406Y2HnX1bniuYeWNRIPbOJnfwr
 6Wsf/SKmMPGM42spNqk1FKO+PKAxjKYG8fDCCLRj3MIgejz4cRTtqiXJkZ6uay5VzNocUKBZt
 ruVNN02
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.2018 um 18:48 schrieb Jeff King:
> And one I'm not sure about:
> 
>   - a read() error will now be quietly ignored; I guess we'd have to
>     check ferror(fp) to cover this. I'm not sure if it matters.

I'm not sure, either.  It would catch media errors or file system
corruption, right?  Sounds useful, actually.  We should check the other
callers of strbuf_getline and friends as well, though, as reporting such
errors seems to be omitted in most cases:

	$ git grep strbuf_getline | wc -l
	99
	$ git grep ferror | wc -l
	35

René
