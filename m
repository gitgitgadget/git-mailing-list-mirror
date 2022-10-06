Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9FAC433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 18:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJFSdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 14:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJFSdM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 14:33:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46546AA34D
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 11:33:11 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a25so1506670qtw.10
        for <git@vger.kernel.org>; Thu, 06 Oct 2022 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrFI9v28doHTs7lWkKPrzte6Pq87lCUrKefBTd/dI6s=;
        b=RVtQ7K6jvzgYlBYC1+DtrYeTX9LGn6ixyprr9yPQcoia6Q1NUEFZt4dc5rijmnaWPS
         F3vBNr62DznefPyZgbC3mgqGaVa8dBbj22I96NBhndEbQQ/x0SjuvqmES22Ewbi3ycqv
         S7jU6yH8AV/DHabyvOT/N3VfHUAZeyF1hmCpiyLFsSeY7H9zzY+l4PUr665n+vByebj4
         mEv8XrFFRViyuH8qVaCWYvkjfNwM90oEgVCP3vFgEJXMwoXnyiqGUtkbsStzZYlhFDaK
         pPVP1vPcZ5RehFvsPUfVvW9GzxnDxUFh3FO59iz0Nk51g8rEiF3HQu9sXNmwwPPTHP7I
         kuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrFI9v28doHTs7lWkKPrzte6Pq87lCUrKefBTd/dI6s=;
        b=0v+xJUNK/Qu7Q8lgtrtlVhsAHtiZ301GvC6tumSaKbJROgc3YtjrUCzRPjRSGBz0ZE
         UCauMj2Pog1CdVdm1B/tUnJOLkRGpvfk2hpuxf2hm2Yq6Fo4MgmVRgAk45hfdRbMRnmJ
         BrZty5XiDxWT+Qt1JQIniE2WTCM99fnEx0OtI18v4h4XUBRnkzx1Pq9rHI7s42KxSf8h
         wHYIDj1TPjbE8nfgrqmZS0IHiagKh+IG6y0cAvM1ssgZ1qerBdAD9WAQo9Zql2RDZ4EV
         bN16QqvXkfif9cPNvn7kadeaX+VE7RCpMTJqRnPfhtxEnT0ONQMBXlH5CdaPrvMtEqsA
         Ivfw==
X-Gm-Message-State: ACrzQf2HRIPPS3yXi+LPZQR9H8qOkeZ1Id61xD7VfxmRC5863szz5IXX
        Z+jB69CGFJei6HY50LvT+BuLUDWXkTtE
X-Google-Smtp-Source: AMsMyM5oQA+j0PUw8HUsaCobKGnjvH3xD/DFyyyBqllO7lVvXxURj3OJsuSd/Z8yCWoFD/f1Fq7OAQ==
X-Received: by 2002:a05:622a:144e:b0:35d:1a25:7c2a with SMTP id v14-20020a05622a144e00b0035d1a257c2amr1303114qtx.509.1665081190381;
        Thu, 06 Oct 2022 11:33:10 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2185:e582:857d:e0db? ([2600:1700:e72:80a0:2185:e582:857d:e0db])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a111200b006b98315c6fbsm4244904qkk.1.2022.10.06.11.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 11:33:09 -0700 (PDT)
Message-ID: <fb4cfbd3-e738-f1e8-18f7-d4e90050b8b5@github.com>
Date:   Thu, 6 Oct 2022 14:33:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 4alt/4] attr: drop DEBUG_ATTR code
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
 <Yz7UhYXvNl6+1GbZ@coredump.intra.peff.net>
 <Yz7Wx4kVbrZFfm0s@coredump.intra.peff.net> <xmqqwn9clwba.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqwn9clwba.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/22 1:02 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Thu, Oct 06, 2022 at 09:13:41AM -0400, Jeff King wrote:
>>
>>> The other obvious option is to just delete this debug code, and remove
>>> the unused parameter. I'm not sure if the trace would ever be useful or
>>> not, and I am mostly retaining it out of the logic of "well, somebody
>>> bothered to write it". I think the const issue has been there since
>>> e810e06357 (attr: tighten const correctness with git_attr and
>>> match_attr, 2017-01-27).
>>
>> And here's what that would look like.
> 
> I highly suspect that I was the one who bothered, and while I admit
> it was useful while developing the attribute subsystem, I haven't
> needed it for the past 10 or so years.
> 
> So unless there are some folks who want to throw everything into the
> trace2 floodstream, I would prefer this alternative over the other
> one.

Are you implying that you want to use the second version, that
deletes the information entirely? I'm leaning towards deleting
it.

If not, and we should keep using traces, I do notice that the
original version of the patch uses trace_printf_key() instead
of a trace2 method. I think this is fine, too, since it's
likely only to be used by Git developers, who could look for
which type of trace to use.

Thanks,
-Stolee
