Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F4EC6FA83
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 19:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiIGTPD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 15:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiIGTPB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 15:15:01 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62DA2D1F9
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 12:14:59 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C2C76CA123F;
        Wed,  7 Sep 2022 15:14:58 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1015:b110:85b0:55e7:e1f0:9407:9b6e])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6A93DCC833D;
        Wed,  7 Sep 2022 15:14:58 -0400 (EDT)
Subject: Re: [PATCH v4 4/4] fsmonitor: normalize FSEvents event paths to the
 real path
To:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <pull.1326.v3.git.1661280941.gitgitgadget@gmail.com>
 <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>
 <56cabf3be3b9e228bc948da372db4c9d11fd3926.1661962145.git.gitgitgadget@gmail.com>
 <bdf26d53-7068-87a6-484b-aeef99be35bd@jeffhostetler.com>
 <BYAPR05MB5573B477ED53CBC4C996729DD97A9@BYAPR05MB5573.namprd05.prod.outlook.com>
 <a583a787-1f54-74ba-add1-61f9e30d5c2a@jeffhostetler.com>
 <BL0PR05MB5571765C903A82FDD990956AD97E9@BL0PR05MB5571.namprd05.prod.outlook.com>
 <BL0PR05MB55712AAD73E0B82B84AC9640D97E9@BL0PR05MB5571.namprd05.prod.outlook.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c9e9b38d-b2a8-7c01-9978-0cb2fc29880f@jeffhostetler.com>
Date:   Wed, 7 Sep 2022 15:14:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BL0PR05MB55712AAD73E0B82B84AC9640D97E9@BL0PR05MB5571.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/6/22 3:33 PM, Eric DeCosta wrote:
> 
> 
[...]
> 
> This is informative:
> 
> https://developer.apple.com/forums/thread/120665
> 
> -Eric
> 
> 

How strange........

Have you tried the:
    fcntl(F_GETPATH)
vs fcntl(F_GETPATH_NOFIRMLINK)
vs realpath()

comparison suggested in the comments and does it return
anything sensical?  Such that we could record both spellings
when the daemon starts up.  I think we'd have to do it on
an open fd on the worktree root directory.

Jeff


https://developer.apple.com/forums/thread/120665
