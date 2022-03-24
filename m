Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A0CC433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 12:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350333AbiCXM5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350331AbiCXM5q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 08:57:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7F36E2A8
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 05:56:14 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPQCl2NR6z67xwN;
        Thu, 24 Mar 2022 20:54:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 24 Mar 2022 13:56:11 +0100
Received: from [10.202.227.197] (10.202.227.197) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 12:56:10 +0000
Message-ID: <f80bac33-7864-8f31-d81f-78cf7cb2987d@huawei.com>
Date:   Thu, 24 Mar 2022 12:56:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [Question] .git folder file updates for changing head commit
To:     Taylor Blau <me@ttaylorr.com>
CC:     <git@vger.kernel.org>
References: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com>
 <YjuCSpAHD6xHkb5G@nand.local>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <YjuCSpAHD6xHkb5G@nand.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/03/2022 20:25, Taylor Blau wrote:
> On Wed, Mar 23, 2022 at 03:19:06PM +0000, John Garry wrote:
>> For building the linux perf tool we use the git head commit id as part of
>> the tool version sting. To save time in re-building, the Makefile rule has a
>> dependency on .git/HEAD for rebuilding. An alternative approach would be to
>> compare git log output to check current versus previous build head commit,
>> but that is seen as inefficient time-wise.
> Having a Makefile recipe that depends on $GIT_DIR/HEAD seems strange to
> me.
> 

Yeah, as mentioned, the idea was the we can check a rebuild on this 
rather than running a relatively time-consuming command like "git 
describe". Wasn't my idea :)

> Presumably your Makefile rules would map out which parts of your program
> depend on each other, and would get invalidated when the source itself
> changes, no?

Correct, they do. It's just the part which constructs the app version 
tag which depends on this.

> 
> Perhaps you also care about the commit you're building from in order to
> embed something into your program. But it seems like you could inject
> the output of "git rev-parse HEAD" when you construct the version
> identifier whenever you do need to rebuild.
> 

ok, so I think that we may need to run a git command always one way or 
another.

Thanks,
John

