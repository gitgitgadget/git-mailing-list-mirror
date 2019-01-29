Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54F821F453
	for <e@80x24.org>; Tue, 29 Jan 2019 22:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfA2WIL (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 17:08:11 -0500
Received: from siwi.pair.com ([209.68.5.199]:19411 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbfA2WIL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 17:08:11 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 170033F4015;
        Tue, 29 Jan 2019 17:08:10 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D51193F4000;
        Tue, 29 Jan 2019 17:08:09 -0500 (EST)
Subject: Re: [PATCH v2 14/14] trace2: t/helper/test-trace2, t0210.sh,
 t0211.sh, t0212.sh
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com
References: <pull.108.git.gitgitgadget@gmail.com>
 <pull.108.v2.git.gitgitgadget@gmail.com>
 <851aa8f34d7223a3d872033abf2f2a95517b3b23.1548712060.git.gitgitgadget@gmail.com>
 <xmqqd0oga0b6.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <180fc774-d080-0ff4-72a5-c54dd77bc59b@jeffhostetler.com>
Date:   Tue, 29 Jan 2019 17:08:09 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0oga0b6.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/28/2019 5:23 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +test_expect_success 'perf stream, return code 0' '
>> +	test_when_finished "rm trace.perf actual expect" &&
>> +	GIT_TR2_PERF="$(pwd)/trace.perf" && export GIT_TR2_PERF &&
>> +	$TT trace2 001return 0 &&
>> +	unset GIT_TR2_PERF &&
> 
> Do not do this.  Stoppage in any different one of these steps would
> leave the state of the process in different state and affects later
> tests (e.g. TR2_PERF may or may not be exported).
> 
> Is $TT always "test-tool" (i.e. the binary, not a shell function)?
> If so, consider using a single-short export, i.e.
> 
> 	GIT_TR2_PERF="..." test-tool trace2 001return 0 &&
> 

I'll redo the fix for this to use the inline form
and send a new version tomorrow.

Thanks
Jeff
