Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0548A202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 13:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754668AbdKANAU (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 09:00:20 -0400
Received: from mout.web.de ([212.227.15.14]:63970 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751525AbdKANAT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 09:00:19 -0400
Received: from [192.168.178.36] ([91.20.50.251]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCZTG-1e1fQq08Sw-009Oh1; Wed, 01
 Nov 2017 14:00:14 +0100
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101110715.e4s7td2weisog4wt@ruderich.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <22afeefa-cdd5-cd32-0a7c-6bad4de79f05@web.de>
Date:   Wed, 1 Nov 2017 14:00:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171101110715.e4s7td2weisog4wt@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ZzG15YYLrKUBY7lYOW+cMwyyz/tK90cfTsOLOPaj5ws0/cTFxGj
 sfgYxTC9mGrw1soE+jSQRfOp6MP5WdGm9WuqElAhOWJjuWr0OaI5lCclLVPxpk/mpkQAio1
 yUMn7q5v1niTNT5MebW8ctJS1AuyVN+PQk0SVM/3AwcsxguA2pLr98vf2gVhL368LFWLSdE
 KoLSL71594q7+0V0i+RTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sEyLsSX0wAE=:hL5oUekifGDENgUfmOnwXD
 2AEiht7OoPuNSEALFBivmRdN/zfy1ll6AKYA1yCDVOyXL5gStUpgLV3SVtcFyEKRsqkvMwfv6
 zqESeTeEF2D3L1o96qIs4CImpqvSlLZDF6Y/oW65OUwzzmws/GFbcxPhFoeik0kwWdNLM8oTp
 00UlaC11YYin/v97ioMYYkrR/XIVW8oMS2gYN/NqMWrTY8HpDHau+TRiYMoQ1qfgwItsjNcQF
 4PzlPPR0E70hr6qngDr400APQCABfwvVn5HWKWeQbNbb9FzF5dDRu4kx6bYAXNQ5DGS2/S94x
 tp/vhoyd5Sizv+uMH5JJM5FxDgYy2Hp6FVb7IIKD4PXLJzJm8YtNhAXN9WP6Etgb0arYp/psa
 UsnqhVyENuYNRprOD1d6VHO6Gdyo/uunZIEDbZgUfg7QI748m0tvx61tgIBXnCd0rfg7JD4tA
 ec469l7K6aN4mgFh2mbHtNx9uHLL8vuutVxnJhF2Xcc8QZf7RWGJLc/3RBHH5D+N6sorWS+s7
 z0znlPCOe1ggXOke0AS2ihH7PTXy8bPY/Oq3AG3ba9ul6OcHsHskhxhDLcjG4VkLjUNKtSZOe
 HwZteBlZM4h3tsyPinrCwZTf4ri7c+Tw4UkyjjFVxLCQ4YQH3+EDfSnY990usHNhMXIUAEavd
 oa0BfRd0ou9Y2xRECAlR8s4/KNvOxsWQezl5StQHzlMyUBWDMv9razpJc/RqdlgQlCVT3loMY
 WziCO2rCBV8UP4tV2x3/rZbVS94QMaSXF5Q4hrvreYzjexbKE0JlWTCkJ87JdjgJ2JenO2nx0
 HC+bOQ685uUqnFL8o+HtGPN4Klwj8lAMpXFTMyOJVEWHlwBrZ8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.11.2017 um 12:10 schrieb Simon Ruderich:
> On Tue, Oct 31, 2017 at 10:54:21AM +0100, René Scharfe wrote:
>> +static int rewrite_file(const char *path, const char *buf, size_t len)
>> +{
>> +	int rc = 0;
>> +	int fd = open(path, O_WRONLY);
>> +	if (fd < 0)
>> +		return error_errno(_("could not open '%s' for writing"), path);
>> +	if (write_in_full(fd, buf, len) < 0)
>> +		rc = error_errno(_("could not write to '%s'"), path);
>> +	if (!rc && ftruncate(fd, len) < 0)
>> +		rc = error_errno(_("could not truncate '%s'"), path);
>> +	close(fd);
> 
> We might want to check the return value of close() as some file
> systems report write errors only on close. But I'm not sure how
> the rest of Git's code-base handles this.

Most calls are not checked, but that doesn't necessarily mean they need
to (or should) stay that way.  The Linux man-page of close(2) spends
multiple paragraphs recommending to check its return value..  Care to
send a follow-up patch?

René
