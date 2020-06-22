Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A349C433E0
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 20:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522D62073E
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 20:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=smartsoftwareinc.com header.i=@smartsoftwareinc.com header.b="Jues4orV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgFVUwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:52:54 -0400
Received: from mail.smartsoftwareinc.com ([24.230.151.194]:43922 "EHLO
        mail.smartsoftwareinc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbgFVUwy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 16:52:54 -0400
Received: from mward.lin.pirsss (unknown [10.0.0.166])
        by mail.smartsoftwareinc.com (Postfix) with ESMTPSA id CFF936213A;
        Mon, 22 Jun 2020 15:52:50 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smartsoftwareinc.com;
        s=default; t=1592859171;
        bh=H5+V22XBD1MoktFmscmVoDSPo03N+X7ZCyBFqCJ47pM=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Jues4orVMG0ABj2dQ0+3WaF28NN+6jWdA65oIv2MSLZuzDzIfg6HL9Ibzy1nFX7E3
         IEHZKnsiNqNQMIWTbR/epJXajQEV/MKZJ1zcwPwtFIGxBfAozGmZWJjNg7KVheg4/1
         xvE5D2i3M/CcEdmZbaUImerUV4hajp/rVR6MyZLA=
Subject: Re: Git 2 force commits but Git 1 doesn't
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <dea24348-770c-1228-115d-23153fbecebd@smartsoftwareinc.com>
 <20200622202122.GO6531@camp.crustytoothpaste.net>
 <a42d038f-bf14-8f1a-927e-7488796e7710@smartsoftwareinc.com>
 <20200622204346.GP6531@camp.crustytoothpaste.net>
From:   Michael Ward <mward@smartsoftwareinc.com>
Organization: Smart Software Solutions, Inc.
Message-ID: <8ad16219-2426-6127-b41d-bb3007a9b993@smartsoftwareinc.com>
Date:   Mon, 22 Jun 2020 15:52:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622204346.GP6531@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-smartsoftware-MailScanner-Information: Please contact the ISP for more information
X-smartsoftware-MailScanner-ID: CFF936213A.A7E33
X-smartsoftware-MailScanner: Found to be clean
X-smartsoftware-MailScanner-SpamCheck: not spam (whitelisted),
        SpamAssassin (not cached, score=-0.3, required 4, autolearn=not spam,
        ALL_TRUSTED, BAYES_50, DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU)
X-smartsoftware-MailScanner-From: mward@smartsoftwareinc.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using the steps from my original email for how I had the repository set 
up (any user authentication scheme works), clone 2 copies from that 
repository (call them A and B). Make, commit, and push a change in A. 
Then make, commit, and push a change in B (without first pulling). With 
the 1.8 client, B will prompt that you're out of date and need to 
update. With the 2.26 client, B's commit will be pushed and be forced.

Thanks for your help.

Michael

On 6/22/20 3:43 PM, brian m. carlson wrote:
> On 2020-06-22 at 20:30:06, Michael Ward wrote:
>> Versions in use are 2.27.2 and 1.8.3.1. This behavior is seen with regular
>> pushes.
>>
>> I'll look into the http-backend functionality. If that will help control
>> that, we'll definitely want to use that instead. What surprises me, though,
>> is that even with DAV a 1.8 client appears to work correctly in that it will
>> warn the user that their push is about to clobber the head, but 2.27
>> doesn't.
> If you can provide a set of reproduction steps for this, I'd be happy to
> write a patch to fix it.  We should do the right thing for non-force
> pushes in both cases.
>
> I will say that overall, few people use the DAV-based protocol, since
> it's significantly less efficient than the smart protocol, so it doesn't
> surprise me that there may be bugs there.
