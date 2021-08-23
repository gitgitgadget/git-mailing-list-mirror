Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7377CC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 01:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8F361185
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 01:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhHWBL6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Aug 2021 21:11:58 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17321 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhHWBL5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Aug 2021 21:11:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629681075; h=Content-Type: Content-Transfer-Encoding:
 MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Cc:
 To: From: Sender; bh=9Z6G7olkS6uE1EoeQBk2swtZ0Ns1VFDQzo5gPEkS2fE=; b=KrdOsFZmGGwoUIATe9T1sHnurGsfQTLYyVWxjlXLhUAzT3PFMsovr8LoLEKE7nIiVjRGXaPq
 fEg5CpXNS7EpFcs12v2qtsQSj2g0IvAW1N/TedcKU2voce2hegUFJV05ziLFbNPpIaPl730v
 LzTpTXn30RPyNv6gSj4zjy0t/Kk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 6122f5b089fbdf3ffeecb640 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Aug 2021 01:11:12
 GMT
Sender: mfick=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDEC8C4360D; Mon, 23 Aug 2021 01:11:11 +0000 (UTC)
Received: from mfick-lnx.localnet (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mfick)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CFDA0C43460;
        Mon, 23 Aug 2021 01:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org CFDA0C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Martin Fick <mfick@codeaurora.org>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>, git@vger.kernel.org,
        bup-list@googlegroups.com
Subject: Re: [RFC PATCH] multi-pack-index: allow operating without pack files
Date:   Sun, 22 Aug 2021 19:11:09 -0600
Message-ID: <3649958.14eQuSAvaI@mfick-lnx>
User-Agent: KMail/5.2.3 (Linux/4.4.0-210-generic; KDE/5.36.0; x86_64; ; )
In-Reply-To: <edb9c412-70c8-4fc6-04ab-417eca05ee15@gmail.com>
References: <20210820195558.44275-1-johannes@sipsolutions.net> <edb9c412-70c8-4fc6-04ab-417eca05ee15@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday, August 22, 2021 8:34:43 PM MDT Derrick Stolee wrote:
> On 8/20/2021 3:55 PM, Johannes Berg wrote:
> > Technically, multi-pack-index doesn't need pack files to exist,
> > but add_packed_git() today checks whether it exists or not.
> 
> Having a multi-pack-index is supposed to indicate that we have
> these objects in the objects/pack directory within the specified
> pack-files.

Hmm, isn't it a normal supported use case for repacking to potentially delete 
packfiles which are in the MIDX (I'm specifically thinking about when someone 
runs git gc with an older git version which knows nothing about MIDX files)?

 -Martin

-- 
The Qualcomm Innovation Center, Inc. is a member of Code 
Aurora Forum, hosted by The Linux Foundation

