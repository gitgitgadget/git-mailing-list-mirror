Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1A5C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 03:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhLND6v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 22:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbhLND6r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 22:58:47 -0500
Received: from confino.investici.org (confino.investici.org [IPv6:2a00:c38:11e:ffff::a020])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA73C061370
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 19:58:46 -0800 (PST)
Received: from mx1.investici.org (unknown [127.0.0.1])
        by confino.investici.org (Postfix) with ESMTP id 4JCl3h5zTSz1142;
        Tue, 14 Dec 2021 03:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onenetbeyond.org;
        s=stigmate; t=1639454320;
        bh=HfMupro9Hx8sr48hdkvkrMimksRmEqL6jfAq6NoGU2M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C/prYgW1iLH2pgcSC2JqzaJbPpHZ6Yboyrlu49d4O6EENIfluPN8po9nwQyL1l9hd
         zur56cCgMfSBdFRsHJjM34aL3efvTCOf3Ypy5ywGhSHx+aXD6GQsRMucfcEXh56XnD
         X0wB/8rL5YVMamQEoh7teU9inzLQhdZaU8qymQ9o=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250]) (Authenticated sender: kumar@onenetbeyond.org) by localhost (Postfix) with ESMTPSA id 4JCl3g2hbLz1141;
        Tue, 14 Dec 2021 03:58:39 +0000 (UTC)
Message-ID: <71d21b15-a5db-dd7e-bc81-06bbef995e31@onenetbeyond.org>
Date:   Tue, 14 Dec 2021 03:58:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101 Firefox/91.0
Subject: Re: List all commits of a specified file in oldest to newest order
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <c3932b3c-323a-39d6-26a7-ba0c3d17378b@onenetbeyond.org>
 <211105.86a6ijhujg.gmgdl@evledraar.gmail.com>
 <182017f6-5dcd-70f0-e0bc-98721c433bf3@onenetbeyond.org>
 <211109.864k8lvesb.gmgdl@evledraar.gmail.com>
From:   Vipul Kumar <kumar@onenetbeyond.org>
In-Reply-To: <211109.864k8lvesb.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, sorry for delay reply. I was busy with some other works and couldn't 
find the time to look into it.

On 11/9/21 9:42 AM, Ævar Arnfjörð Bjarmason wrote:
> 
>> Thanks, I didn't know "reverse" would change the traversal order. When
>> I looked for "--reverse" option in git-log(1), this what I found:
>>
>>    --reverse
>>        Output the commits chosen to be shown (see Commit Limiting
>>        section above) in reverse order. Cannot be combined with
>>       --walk-reflogs.
>>
>>  From this, I inferred that "--follow" would choose the commits and
>> "--reverse" reverses those commits order. Can we improve the wording
>> here? Especially, about "reverse" changes the traversing order.
> 
> Yes, definitely. Suggestions most welcome :)

   --reverse
       Traverse the commits chosen to be shown (see Commit Limiting 
section above) in reverse order. Cannot be combined with --walk-reflogs.

If we don't want to disallow combination of "--follow" and "--reverse", 
just like "--walk-reflogs" as combination doesn't make any sense[1]. We 
could do this:

   --reverse
       Traverse the commits chosen to be shown (see Commit Limiting 
section above) in reverse order. Cannot be combined with --walk-reflogs. 
Combination of --follow and --reverse won't produce an expected output, 
if we also want to follow renames. If there is nothing to follow it 
should behave as expected.

[1]: 
https://public-inbox.org/git/6c6ef97c-9de5-176f-f328-c4dffd96d495@onenetbeyond.org/

Does it sound good to you?

-v
