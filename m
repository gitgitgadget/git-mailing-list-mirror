Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DAA41F667
	for <e@80x24.org>; Thu, 10 Aug 2017 23:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753479AbdHJXR4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 19:17:56 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:34391 "EHLO
        homiemail-a111.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753322AbdHJXRz (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 10 Aug 2017 19:17:55 -0400
Received: from homiemail-a111.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTP id 57AFF3C001C16;
        Thu, 10 Aug 2017 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
        :to:cc:references:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=jupiterrise.com; bh=5
        tqrCcA9Iaj9mAI+hrP41NyypdQ=; b=Eu78P/GtnsxKdUG39/5h+gxh3gRXyU0sL
        W8VzZbHfionubG6JYQ/kSO2OhEiFQHk0bGUxsUY6+bgmaAEHN56HTVcM4aiWfieF
        ol13HN71FLT9DDm5R65p0OVato4VxMTS69EmZtkS/zNIsi98eZdBOeLOJwdJMOtj
        dzCl/xd3xY=
Received: from merlin.tgcnet.jupiterrise.com (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tgc99@jupiterrise.com)
        by homiemail-a111.g.dreamhost.com (Postfix) with ESMTPSA id 235073C000741;
        Thu, 10 Aug 2017 16:17:55 -0700 (PDT)
Received: from odin.tgcnet.jupiterrise.com (router.tgcnet.jupiterrise.com [192.168.20.58])
        by merlin.tgcnet.jupiterrise.com (Postfix) with ESMTPSA id 7E15E605F0;
        Fri, 11 Aug 2017 01:17:52 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by odin.tgcnet.jupiterrise.com (Postfix) with ESMTP id EEEE1E800D0;
        Fri, 11 Aug 2017 01:17:51 +0200 (CEST)
Subject: Re: [PATCH 0/4] dropping support for older curl
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
 <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
 <873e1f31-2a96-5b72-2f20-a5816cad1b51@jupiterrise.com>
 <20170810213236.dej4ibsag2lxf5w2@sigill.intra.peff.net>
 <fbd7e636-0087-9c2b-746f-e2413c6d2133@jupiterrise.com>
 <20170810225428.jubkaistxz33ykco@sigill.intra.peff.net>
From:   "Tom G. Christensen" <tgc@jupiterrise.com>
Message-ID: <c8a2716d-76ac-735c-57f9-175ca3acbcb0@jupiterrise.com>
Date:   Fri, 11 Aug 2017 01:17:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170810225428.jubkaistxz33ykco@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GH
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/08/17 00:54, Jeff King wrote:
> On Fri, Aug 11, 2017 at 12:23:42AM +0200, Tom G. Christensen wrote:

> Er, sorry if I'm being dense, but how? Are you suggesting that by
> removing the callsite of get_curl_allowed_protocols(), the compiler
> might elide the now-dead code completely? I could certainly see it being
> dropped after the compilation, but I'm surprised that it wouldn't
> complain about the undeclared identifiers in the first place.
>
You're right, that should not be able to handle it.

>>> Can you please double-check that you're
>>> building against the correct version of curl, and that you are building
>>> the HTTP parts of Git (which _are_ optional, and the test suite will
>>> pass without them).
>>
>> I use a mock buildroot and there is no other curl than the vendor supplied
>> 7.15.5 installed:
>> [...]
> 
> OK, thanks for double-checking. I'm still puzzled why your build
> succeeds and mine does not.
> 

I know what's going on now and it's so simple.
Red Hats version of curl 7.15.5 includes a number of patches including 
one that backports support for CURLPROTO_* (as part of a fix for 
CVE-2009-0037).
I haven't checked el6 but I would not be surprised if there where 
similar things going on there.

So in conclusion version based #ifdefs are misleading when used with 
curl as shipped with RHEL.

-tgc
