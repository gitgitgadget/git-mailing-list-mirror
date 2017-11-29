Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ED2820A40
	for <e@80x24.org>; Wed, 29 Nov 2017 17:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935197AbdK2R6x (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 12:58:53 -0500
Received: from avasout04.plus.net ([212.159.14.19]:58930 "EHLO
        avasout04.plus.net.plus.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935063AbdK2R6v (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2017 12:58:51 -0500
Received: from [10.0.2.15] ([80.189.70.158])
        by smtp with ESMTPA
        id K6dDeD0p9zbmWK6dEeJGoF; Wed, 29 Nov 2017 17:58:49 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=P6pKvmIu c=1 sm=1 tr=0
 a=bpDj9VLvXCYHU65eeb/Fiw==:117 a=bpDj9VLvXCYHU65eeb/Fiw==:17
 a=N659UExz7-8A:10 a=EBOSESyhAAAA:8 a=fhO8jbZuyFlTnU2aL4oA:9 a=pILNOxqGKmIA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] repository: fix a sparse 'using integer as NULL pointer'
 warning
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <69fdc850-da71-6df3-5299-eb67ef5d74df@ramsayjones.plus.com>
 <20171129013518.GB598034@genre.crustytoothpaste.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <423b4a07-dac3-20f2-ad60-d87fa08968f9@ramsayjones.plus.com>
Date:   Wed, 29 Nov 2017 17:58:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171129013518.GB598034@genre.crustytoothpaste.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP5li87lHEl9oH623+IAkfOcKJ37TTn3d4F8K5oihLtgLcEF1jUxFVjNoY/E7CsI0lD3YZhMDxhHsTXw2uj+t43km8IbNTWnnHbCCi1MedPOIYEAgt03
 KBj3zZWXrU++aTw/fGriBtS3a5SOmPoavuiGs5ruxrJ/jy94Ukc7aR2UiH6hBbjhOvsU2n6mrF5CZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 29/11/17 01:35, brian m. carlson wrote:
> On Tue, Nov 28, 2017 at 03:01:19AM +0000, Ramsay Jones wrote:
>>
>> Commit 78a6766802 ("Integrate hash algorithm support with repo setup",
>> 2017-11-12) added a 'const struct git_hash_algo *hash_algo' field to the
>> repository structure, without modifying the initializer of the 'the_repo'
>> variable. This does not actually introduce a bug, since the '0' initializer
>> for the 'ignore_env:1' bit-field is interpreted as a NULL pointer (hence
>> the warning), and the final field (now with no initializer) receives a
>> default '0'.
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>
>> Hi Junio,
>>
>> I don't recall Brian doing a re-roll of the 'bc/hash-algo' branch[1], but
>> now that it has been merged into the 'next' branch, sparse is barking on
>> that branch too. This patch (slightly different to the last one) applies
>> on top of 'next'.
> 
> Thanks for the patch; it's obviously correct.  I'll get sparse set up
> for future patch series.

Heh, at this point I usually remark that you would need to build
sparse from source, since all the packaged versions are so old
as to be virtually useless (to run over git).

That may still be the case, depending on your distro, since there
was a new release a couple of months ago. However, you know how
long it takes to get into some distros! ;-)

[I _think_ it may be in Debian Unstable]

Oh, the release (v0.5.1) was tagged on 17 Aug 2017.
(I'm currently running v0.5.1-30-gf1e4ba1, built from source).

ATB,
Ramsay Jones

