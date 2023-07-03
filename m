Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43890C2FC17
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 16:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjGCQqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 12:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjGCQqw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 12:46:52 -0400
Received: from anquietas.itsh.dev (anquietas.itsh.dev [116.202.218.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC80E69
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 09:46:50 -0700 (PDT)
Message-ID: <1e79047e-944c-0112-ffd0-ca52e31226c3@mschiffer.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mschiffer.de;
        s=mail; t=1688402807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xhM3AIEIdCqrIMX724cVnMLNYyxKRsbrL1O7z+VVLBs=;
        b=ejulmmzAfWTWQGQoO4JmV8Qush+BQDpU4uifwlL19t+mtbkG5wqu7CBn7jytNWpGmMLlNF
        FIyL9deV8BA7PCZc5OVk8r9vXMcYHupbZnOO6Vk9Cdmp2ZLm+Nw0h82n9oyLPX9JZTB/QI
        jaIpRAYir9NAnxUbMJ/G+hxe+Ts7oJPI0Q9mRMTqTlyqExjOngAL4v+N4pwLcZ5yt5qQWP
        9hRRwBntvsrD+VP24UmmixEoEgiKi0JlvNiQThRyL3YjBsEedw88kzmrpy3eNQMN94+QPP
        ReRjae1sNdtnAr2tzDC2iuRoDGo8Z+vo6Zw8CcFjlj0nI2IRhP7eWhFxQNzhgqGhnys4NR
        OQG9gJtE4yrbH98MKxW1HIyQnTXi+ozBTaUhz/CNw2MTk0HGmAVNAmE1COdpza6RghAR3L
        nCcV1WQuoA/lb1Hu+FA94bAdXp4o1wQ74bOWSNKwSAM5jiS2Ci8IJEF6QbMj+0dE7IHFjQ
        fedeVE0GwqfBYmLe7jrCqhSwuIfYvf31FhGNzId/pGiJ0pNU5s/hlSEdtYCpm/WCkshFpr
        809164ahyvZD41th0ArtJ1ZcwLf4AbOqfENRkqlsSmE+AOxVf2sY2G4oRFivORCCkPb9U2
        JhBwnnw+veMYRdMZEY3MOXUh1rWQhWBwi0QQNg8OYhfyyXrfoSRtU=
Date:   Mon, 3 Jul 2023 18:46:45 +0200
MIME-Version: 1.0
Content-Language: en-US
To:     git@vger.kernel.org
From:   Marius Schiffer <marius@mschiffer.de>
Subject: Bug report: AM 3-way patching fails with partial cloning
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When applying patches with git am on a repository cloned with 
filter=blob:none, the patching sometimes fails when it can't find the 
required SHA1 information.
Applying the same thing on a normal clone works.
I'm not sure yet what exactly i s missing that is not fetched, but I 
guess git should be able to fetch the missing blobs. I would also be 
very happy to hear workarounds, as I really love git partial cloning.

Using git v2.41.0.

To reproduce:

1. Download this patch: 
https://raw.githubusercontent.com/projectceladon/vendor-intel-utils/master/bsp_diff/common/kernel/linux-intel-lts2021/0007-9p-freezing-aborts-when-use-wait_event_killable.patch

2. Clone this repository: git clone --filter=blob:none 
https://github.com/projectceladon/linux-intel-lts2021

3. Apply the patch: git am -3 
../0007-9p-freezing-aborts-when-use-wait_event_killable.patch


--
Marius


