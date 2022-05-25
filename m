Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A36DC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 17:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245680AbiEYR3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiEYR3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 13:29:09 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B394EAF1D6
        for <git@vger.kernel.org>; Wed, 25 May 2022 10:29:07 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D58113F412C;
        Wed, 25 May 2022 13:29:06 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 7847A3F4129;
        Wed, 25 May 2022 13:29:06 -0400 (EDT)
Subject: Re: [PATCH v8 00/30] Builtin FSMonitor Part 3
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
 <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
 <xmqqy1yp8ta2.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5224e941-af0d-d478-00f0-cf6639e3a726@jeffhostetler.com>
Date:   Wed, 25 May 2022 13:29:05 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqy1yp8ta2.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/25/22 12:35 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This version addresses the new t/helper/test-hexdump utility to emit an LF
>> at the end. I also updated the test scripts to write hexdump output to a
>> file and then grep that file to avoid having the tool being in the middle of
>> a pipeline.
> 
> https://github.com/git/git/runs/6583917870 shows t7527 is not happy
> in "win test (9)" job with the previous version.  It is unclear if
> that has been addressed, but we'll see soon.
> 
> Will replace.  Thanks.
> 

I'll investigate.  Thanks.

An earlier version had a "mv .git foo; sleep 1; mv foo .git"
and then tested to see if the daemon had noticed the change
and automatically shutting down.  That was a little racy on
very slow build machines (well, that was the only place that
it was seen).  So added `verify_implicit_shutdown()` to try
to make it less sensitive.  Looks like it might need a little
more help.

Jeff
