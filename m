Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD48C77B78
	for <git@archiver.kernel.org>; Thu,  4 May 2023 13:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjEDNqa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 09:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjEDNq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 09:46:26 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C4583C3
        for <git@vger.kernel.org>; Thu,  4 May 2023 06:46:15 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-b97ec4bbc5aso481828276.3
        for <git@vger.kernel.org>; Thu, 04 May 2023 06:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683207974; x=1685799974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PSfK1hNg2nfb1MmcdEh+NEKkXyvEWa2q+wMzy7WkoT8=;
        b=FCqwLda923NgvuS1BaSbVr00095EXKDtwmBNwiMUknla+TtM9xKybJU/tP/4FFDrHL
         i85uUElRULNe65/KI49sRW9TF3bb9oBThyJWP4cKYtl9ZYO2tezWyiKt9dTmlzikBxmz
         OvN9XBFIRygflRw3IVjJPnhg63OX6QetggyINhEREO/tMdCJDxxrb2kMbnW5lg8zegjB
         igJn/tbLfugPV35lvzMYx4/kswKbrHnHgYdImEqzaYTO4LkyehbqtpsRrZd+Kno25yJc
         B0T/kjl6otEWL0/qI9Ftl5YGs4PGm83efEb+LmbxLoATCTjwj3wMEJtMQdZqbEsj8los
         snSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683207974; x=1685799974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSfK1hNg2nfb1MmcdEh+NEKkXyvEWa2q+wMzy7WkoT8=;
        b=X12gCt7h1Rva7HOLO1wBnLSdwcXJH97nDeaSAPqe6OYLNhFLvaIvBLs3UI0vHLJDZZ
         0i9OD8Itp8zYaFoLsstZhjgMIU+761CN/3/3jwxAZHg6vYYMqPvKnIU5vVNrzW6fqMd0
         NrXQPPpSKa4USfzi8WI5pMsrOJIcGEaH9PAFHVepH4Mtop1Tlk9DKqYyo1HX605mbR09
         v5KrtUXhh4at2l7zG/7R7nvKImht3mFnZsE99e/jraSWI1/24bRtIRoUcbrHNe3O2cMm
         ErvYtIE+Xyc/eEsUQIvfMN5qTwy/sGqR7quP/1i9dUQ/H+FjkUz++PgcEBaM0sAfddXZ
         rc8g==
X-Gm-Message-State: AC+VfDx7B/R4o8BGYSdIcmap/D/QRdQEWTzcwy0E3O3vh8AUREL9l/9v
        Q8Oy4XosXjM8x4xP2hs3gga4
X-Google-Smtp-Source: ACHHUZ6ga8mp8dLrgUBZpSgZNJn3brA+FNzvVfwUF7pM9ywuoKxKwQgR5pDgtMMvsVTA0FlurqSDzw==
X-Received: by 2002:a25:42c5:0:b0:b9d:8a50:e709 with SMTP id p188-20020a2542c5000000b00b9d8a50e709mr17943371yba.5.1683207974327;
        Thu, 04 May 2023 06:46:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8cb:9a54:52c4:914c? ([2600:1700:e72:80a0:8cb:9a54:52c4:914c])
        by smtp.gmail.com with ESMTPSA id h16-20020a25e210000000b00b9f1992112dsm1193940ybe.0.2023.05.04.06.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 06:46:14 -0700 (PDT)
Message-ID: <3ba50e8c-16c1-8fe2-f6b9-4113bbebe8e0@github.com>
Date:   Thu, 4 May 2023 09:46:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/3] revision: support tracking uninteresting commits
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <a643678c0ff7d1a910b1d6c33a839166e2a6a7b2.1682380788.git.me@ttaylorr.com>
 <0b8884ea-f37b-b7d4-6edb-825ca935a893@github.com>
 <ZFLWwTAIxRnNUKDp@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZFLWwTAIxRnNUKDp@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/2023 5:48 PM, Taylor Blau wrote:
> On Tue, Apr 25, 2023 at 02:15:49PM -0400, Derrick Stolee wrote:
>> On 4/24/2023 8:00 PM, Taylor Blau wrote:
>>> The boundary-based bitmap walk will want to know which commits were
>>> marked UNINTERESTING in the walk used to discover the boundary.
>>>
>>> Track which commits are marked as such during list limitation as well as
>>> the topo walk step, though the latter is not used.
>>
>> I was surprised to see this as an addition to revision.c, and
>> only specific to limit_list() (and its iterative copy). I would
>> expect this to work for non-topo-order, too. I suppose we couldn't
>> completely trust that the first visit to a commit includes the
>> UNINTERESTING flag if there is clock skew in the commit history.
> 
> Yeah, the distinction between limit_list() and the --topo-order code
> makes things a little funky here. But I think that's OK, since
> `--topo-order` is not likely to be used here, since this is all
> bitmap-based traversal. IOW, I think that it would be reasonable to ban
> the revision args combination of --use-bitmap-index with --topo-order.
 
I think there is a miscommunication here, since the limit_list()
code will only be run if there is a need to "walk to the end" before
outputting results. --topo-order is an example of something that
triggers this need, but it is disabled by default.

It seems that revs->collect_uninteresting would be a condition that
should signal to enable revs->limited so this code is actually
executed.

Taking a look at how this works with your current patch, the only
thing I can think is that since your initial commits include some
UNINTERESTING commits, that actually triggers revs->limited = 1
in handle_commit(). It's an indirect use, and without such a
commit the boundary would be empty, anyway.

Thanks,
-Stolee
