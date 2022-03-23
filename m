Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD08C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 15:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiCWPUk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 11:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiCWPUi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 11:20:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690E3554BB
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 08:19:08 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KNsQV5PSfz689QQ
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 23:16:50 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 23 Mar 2022 16:19:04 +0100
Received: from [10.47.85.68] (10.47.85.68) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 23 Mar
 2022 15:19:04 +0000
Message-ID: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com>
Date:   Wed, 23 Mar 2022 15:19:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
To:     <git@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Subject: [Question] .git folder file updates for changing head commit
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.68]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys,

I have a question about which files in the .git folder are updated as we 
change the head commit. I could check the codebase myself but prob will 
make a mistake and maybe some expert would be so kind as to just kindly 
tell me.

For building the linux perf tool we use the git head commit id as part 
of the tool version sting. To save time in re-building, the Makefile 
rule has a dependency on .git/HEAD for rebuilding. An alternative 
approach would be to compare git log output to check current versus 
previous build head commit, but that is seen as inefficient time-wise.

The problem is that actions like git cherry-pick and git reset --hard 
HEAD^ may not update .git/HEAD (so don't trigger a rebuild).

Is there some more suitable file(s) which we could use as a dependency? 
 From my limited experimentation, .git/index seems to always update when 
the changing head commit.

Thanks,
john
