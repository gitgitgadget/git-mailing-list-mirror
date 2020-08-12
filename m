Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B4C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB8120855
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 16:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHLQ5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:57:45 -0400
Received: from siwi.pair.com ([209.68.5.199]:23352 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgHLQ5o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 12:57:44 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 3CD8C3F4147;
        Wed, 12 Aug 2020 12:57:43 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0BF633F40BC;
        Wed, 12 Aug 2020 12:57:43 -0400 (EDT)
Subject: Re: [RFC PATCH 00/21] [RFC] Parallel checkout
To:     Matheus Tavares <matheus.bernardino@usp.br>, git@vger.kernel.org
Cc:     stolee@gmail.com, jeffhost@microsoft.com
References: <cover.1597093021.git.matheus.bernardino@usp.br>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a927c55a-3e5a-b5f9-04d2-3d5e1d298b7a@jeffhostetler.com>
Date:   Wed, 12 Aug 2020 12:57:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1597093021.git.matheus.bernardino@usp.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/10/20 5:33 PM, Matheus Tavares wrote:
> This series adds parallel workers to the checkout machinery. The cache
> entries are distributed among helper processes which are responsible for
> reading, filtering and writing the blobs to the working tree. This
> should benefit all commands that call unpack_trees() or check_updates(),
> such as: checkout, clone, sparse-checkout, checkout-index, etc.
> 
> This proposal is based on two previous ones, by Duy [1] and Jeff [2]. It
> uses some of the patches from these two series, with additional changes.
> The final parallel version was benchmarked during three operations with
> cold cache in the linux repo: cloning v5.8, checking out v5.8 from
> v2.6.15 and checking out v5.8 from v5.7. The three tables below show the
> mean run times and standard deviations for 5 runs in: a local file
> system, a Linux NFS server and Amazon EFS. The number of workers was
> chosen based on what produces the best result for each case.
> 
 > ...
> 
> The first 4 patches come from [2]. I couldn't get in touch with Jeff yet
> and ask for his approval on then, so I didn't include his Signed-off-by,
> for the time being.

This looks like an interesting mixture of our efforts.  Thanks for
picking it up.  I got re-tasked earlier this summer and had to put
it on hold.  I've given it a quick read and like the overall shape.
I still need to give it an in-depth review and run some perf tests
on Windows and on the gigantic Windows and Office repos.

Please feel free to add my sign-off to those commits.

 > ...

Jeff
