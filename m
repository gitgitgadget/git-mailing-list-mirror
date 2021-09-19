Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B005DC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 15:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868AE610EA
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 15:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhISPtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 11:49:21 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:30656 "EHLO
        ext-mx-out002.mykolab.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233428AbhISPtU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Sep 2021 11:49:20 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Sep 2021 11:49:20 EDT
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 0BAD7A46;
        Sun, 19 Sep 2021 17:38:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1632065926; x=1633880327; bh=1AruIWLAy8hgN26MtNf
        hoEelt+lJvEql237GF8IaCRc=; b=phv43ltC9hS0mXEPWpVaZRumgvJhKfH1RgZ
        Bm1SpQ3hL3iJ4pcYP9Koaly0viHA9SC4o3/hpyQt/8NvUjys1a7dpB48h4FaN+BZ
        W6YzgINtFi7T+RN7FSjXdbaUkUF5WsKGeBfBEjtdAuz95Vha+1LWG9DZQjq7G2TX
        LQleBiPpRJqALBdTnx/b7YX3Z2P6jtT40FGYyMp/sV9ahe1BGKe5x1/UQANybnmE
        c0cUB/O/d05pcShc+6xC+3lTnn9KFJoIZzZN8w/0BXqzWluvM4xaHnpI05+Vutko
        LRwmmXasGtY8BQUdIdLCMg05iDletY+STHJ05ECwh3c0oi8LCC6XXL+bLucXTNbp
        O5Vf7tuvarNTZvXiaCfwzqiA7fKLzzLo//5lRI64QD+Dkiq2RBA85y9dHAAXVGpP
        Rf6BpfTj/dm82XAo1JOI+G25AyMAXD0L4XwbhOrPeWdZE7CIIPCYvUq/eFWWxOlj
        Q5lBYmDXx5L9jo5rL5oVLMRvL4chv8Q8l2yCUDD3dZAn+BznNcjVq+T4y+YJ9MGn
        FgB/tNoeJggCN/T2Zy+NBKhtUfjsF+5ER5GVsDTRFzZEHZIVTpNR7l5bF3GL/Jp4
        v0cRQ2rCNLpbNkXM9lMsa9jmdEptByP9T+Uirl/XVXYa/QWAcNmuE0rYgEEBeIy1
        OWoAsgJE=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from ext-mx-out002.mykolab.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3MgQqgpipNvB; Sun, 19 Sep 2021 17:38:46 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 9FDEB874;
        Sun, 19 Sep 2021 17:38:46 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id E8FA031D;
        Sun, 19 Sep 2021 17:38:45 +0200 (CEST)
Subject: Re: [PATCH 0/2] Squash leaks in t0000
To:     Carlo Arenas <carenas@gmail.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
 <CAPUEspjjBAr07VB7XqGFVXDcKWkkX4OUTCxUf+VJaEAX8KTAyw@mail.gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <05754f9c-cd58-30f5-e2d3-58b9221d2770@ahunt.org>
Date:   Sun, 19 Sep 2021 17:38:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAPUEspjjBAr07VB7XqGFVXDcKWkkX4OUTCxUf+VJaEAX8KTAyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/09/2021 19:28, Carlo Arenas wrote:
> 
>> Here's a series that I've sat on for a while, which adds some UNLEAK's to
>> "fix" this situation - see the individual patches for a justification of why
>> an UNLEAK seems appropriate.
> 
> While I see that UNLEAK in this specific case, might be an ok "fix", I
> have to admit that not finding a repo_clear_revisions() (or equivalent
> function) that could be used to clear revs seems like a problem worth
> fixing as well for the future.
> 
> Will reply with my WIP so we can see if it could work either as an
> alternative to this, or at least lay some foundations so that a long
> running process that needs to use a `struct revision` or some of this
> logic can in the future without having to deal with leaks.

Great - in this case I think it's best to ignore my patches since 
actually fixing the leaks is obviously a better solution :) !

ATB,

Andrzej

