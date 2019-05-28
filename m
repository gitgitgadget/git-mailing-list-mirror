Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38681F462
	for <e@80x24.org>; Tue, 28 May 2019 14:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfE1Ocp (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 10:32:45 -0400
Received: from siwi.pair.com ([209.68.5.199]:38060 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfE1Ocp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 10:32:45 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6BC363F408A;
        Tue, 28 May 2019 10:32:44 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:98c8:dc56:b85b:909] (unknown [IPv6:2001:4898:a800:1012:49fc:dc56:b85b:909])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2AAFF3F4083;
        Tue, 28 May 2019 10:32:44 -0400 (EDT)
Subject: Re: [PATCH] compat/vcbuild/README: clean/update 'vcpkg' env for
 Visual Studio updates
To:     Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190528120846.1056-1-philipoakley@iee.org>
 <a48d5f62-081a-de14-5dbb-4726908a4179@jeffhostetler.com>
 <dbf74f4d-b63c-53f2-dbce-009da34d1050@iee.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <14a81e3e-248a-1ccc-6492-822011c2f78f@jeffhostetler.com>
Date:   Tue, 28 May 2019 10:32:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <dbf74f4d-b63c-53f2-dbce-009da34d1050@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/28/2019 10:09 AM, Philip Oakley wrote:
> Hi Jeff,
> 
> On 28/05/2019 14:56, Jeff Hostetler wrote:
>> On 5/28/2019 8:08 AM, Philip Oakley wrote:
>>> When the user installs an updated version of Visual Studio, the 
>>> previously
>>> generated MSVC-DEFS-GEN will need to be deleted to allow updating.
>>>
>>> Alternatively the whole vcpkg download may be cleaned allowing it to be
>>> reloaded, though this may take much longer on slower connections.
>>>
>>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>>> ---
>>>
>>> In response to discussions at:
>>> https://github.com/git-for-windows/git/issues/2186
>>>
>>> cc: Jeff Hostetler <git@jeffhostetler.com>
>>> cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>>>
>>>   compat/vcbuild/README | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/compat/vcbuild/README b/compat/vcbuild/README
>>> index 81da36a93b..40695fc1cc 100644
>>> --- a/compat/vcbuild/README
>>> +++ b/compat/vcbuild/README
>>> @@ -18,6 +18,13 @@ The Steps to Build Git with VS2015 or VS2017 from 
>>> the command line.
>>>      Makefile:
>>>         <repo_root>/compat/vcbuild/MSVC-DEFS-GEN
>>>   +   - If you update your Visual Studio version, then delete the 
>>> MSVC-DEFS-GEN
>>> +   file so that fresh environment variables can be discovered.
>>> +
>>> +   Or clean the "vcpkg" environment with:
>>> +
>>> +   $ make MSVC=1 clean
>>> +
>>>   2. OPTIONALLY copy the third-party *.dll and *.pdb files into the repo
>>>      root to make it easier to run and debug git.exe without having to
>>>      manipulate your PATH.  This is especially true for debug 
>>> sessions in
>>>
>>
>> Did you mean to send this upstream or to Git for Windows?
>>
>> I didn't think that the VS2015/VS2017 vcpkg-aware version of
>> compat/vcbuild/* had made it upstream yet, so this patch might not
>> apply upstream.
> Ah, that would be my mistake.
>>
>>
>> BTW, the Makefile (when MSVC=1 is defined) will take care of deleting
>> the MSVC-DEFS-GEN, so all we really need to say here is to do:
>>
>>     $ make MSVC=1 clean
>> or  $ make MSVC=1 DEBUG=1 clean
>>
>> after upgrading to a new version of VS.
> It (my suggestion) was the difference between a deep clean of all the 
> 1.05GB of vcpkg files, vs  the 847 bytes of just the MSVC-DEFS-GEN file 
> that was a concern.
> 
> The need to repeat the download of 1GB just because of a VS version 
> change felt a bit excessive, hence the initial suggestion.

Right, there is a separate compat/vcbuild/VCPKG-DEFS file that
controls if the third-party libraries need to be downloaded and/or
compiled.  Make clean doesn't touch that.

And yes, this area still needs a little polish.


>>
>> Jeff
>>
>> PS. I have a TODO item to fix the Makefile to automatically detect
>> and take care of this.
> Thanks.
> IIUC download of the vcpkg files are separate from the generation of the 
> MSVC-DEFS-GEN file - or are their inter-linkages?
> -- 
> Philip
