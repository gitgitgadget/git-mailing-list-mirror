Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2F8C433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 14:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF2D660F25
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 14:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhJWPAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 11:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWPAV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 11:00:21 -0400
X-Greylist: delayed 81874 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Oct 2021 07:58:02 PDT
Received: from srv1.79p.de (srv1.79p.de [IPv6:2a01:4f8:222:1281::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883DAC061714
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 07:58:02 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:ea:2738:ef00:e116:f70b:b16d:6d5b] (p200300ea2738ef00e116f70bb16d6d5b.dip0.t-ipconnect.de [IPv6:2003:ea:2738:ef00:e116:f70b:b16d:6d5b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sven@cs-ware.de)
        by srv1.79p.de (Postfix) with ESMTPSA id D584A600695;
        Sat, 23 Oct 2021 16:57:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2021; t=1635001079;
        bh=Yijig5k8zaMfQVMtEvtEvSpVKxrpclts3N6PZJXdr1s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=u4SivCzaQ2FOVhH3ctW4axwFJd19TbNMiz6RrCaC6KoS5zO/3pfJDqsKGQHpjhtlQ
         uARICEV3Y8OCj5Fs4Di0ucIGVtsjA52ZgdLqx+0G5QTn/XFNBo/juapZmu915wE1ut
         TChzDSg23R+qaHuknNZlkqaAV1TaNl6BFhK1ZFrxJYnJFexdo6zpublX2CmWYrcZX8
         Anq0plaMNTlBwEyf9eGThJRD54bx3bPR+FOPeVMBed9jMFnzyn7AClTOFt99gG3gwU
         avTzZYDcCjUf4AZ6mfvuwn7hQ5XkzwaUASVCc+xiwvUDgFwTgF80YFb2RYqRzXvyk8
         9qlRbFg3w+6eQ==
Subject: Re: Git silently broke push-options over ssh?
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
References: <4aef40f2-43f8-eab3-a840-6e76c8b4afbb@cs-ware.de>
 <YXMku8V9cdHLfXt6@coredump.intra.peff.net>
From:   Sven Strickroth <email@cs-ware.de>
Message-ID: <ff7ff6ca-2941-c61e-f36d-0732b367fc64@cs-ware.de>
Date:   Sat, 23 Oct 2021 16:57:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YXMku8V9cdHLfXt6@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.10.2021 um 22:53 schrieb Jeff King:
> On Fri, Oct 22, 2021 at 07:27:14PM +0200, Sven Strickroth wrote:
> 
>> If I understood <https://opensource.googleblog.com/2018/05/introducing-git-protocol-version-2.html>
>> correctly I have to enable the Git protocol version 2 and then the push
>> options should work.
> 
> I don't think that is true. There is no v2 push protocol yet, so the
> push options must work over v0.

You are right. After enabling GIT_TRACE_PACKET I see that the 
push-option gets transmitted correctly.

I got confused was because a GitLab CI pipeline run despite I passed 
ci.skip. The reason why the pipeline ran despite of that flag is that 
some external push hook triggered a CI pipeline action manually - when I 
look at GitLab immediately after the push I see that the pipeline is 
skipped and then the external hook fires...

Thanks for the hint for enabling GIT_TRACE_PACKET  Peff and sorry for 
the noise.

  Sven
