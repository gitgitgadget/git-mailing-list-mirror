Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7914BC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 20:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F31D60EFE
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 20:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbhKDUQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 16:16:51 -0400
Received: from avasout-peh-001.plus.net ([212.159.14.17]:35263 "EHLO
        avasout-peh-001.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhKDUQv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 16:16:51 -0400
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id ij7fm1KdaCV4Tij7gmFTF6; Thu, 04 Nov 2021 20:14:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1636056851; bh=QS+w6vt8pOhCE8hHpXr/RpqjUTxIuY8iglxJMNm1C7I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EYidUKhAirvCtPgml5zLa3aaESeeTYhaSGF7BrheZz5oTQJnRImTXV78PFkWF/DLF
         6LdPypsVnIdbAAfQ/GGyTVFNOh/K/aAyYhFCj+jCxio36DTaaBIGyC6XbYYgYga2Hu
         5RvT4O4h4OHSoQYo20k/nc9jzihZzZiw+RxW4Vs7Mg6aOnEA7N+hElY8zVSUkFwuu1
         +RxhrDwMzbk+TMUa32kNPm/js4kd5AXfxWNJ03f6TMsKK8kvnZvOiYpJalo7jxIuFS
         pz6C4EIPuWHA+KOkZdSlhMUx6q+5a7z2CD5dReD/ryarV8FDvWK+eW4IrOBUHNl1Vs
         +RW6H/Emwe7bA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=Yrts+6UX c=1 sm=1 tr=0 ts=61843f13
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=yMhMjlubAAAA:8 a=JlIclTKqokGVGb9i5vwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
To:     Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
 <20211104194619.GA12886@dinwoodie.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <079bdbee-e1fe-83e0-f986-c5795ca20848@ramsayjones.plus.com>
Date:   Thu, 4 Nov 2021 20:14:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104194619.GA12886@dinwoodie.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDgcgVc2/tobDa9ylo9/Su+9XcWtQEcI26dPH8vgBiQrV14SnGdBE8UzrFnq6REuFc4bVKyCnBdI5keUkw9gBXGTBDFGvKy/2os5qc0+SeY9D8f4/2nX
 yehm43E1JycwVoaV8EIaH/yl4En4qEj61f/CWUiik6eLYSvZEF1aMiTvlOi2q31US0gRq351SUhAVcX1Md/zcWwQ3ASFwGNGlSQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam,

On 04/11/2021 19:46, Adam Dinwoodie wrote:
> On Monday 20 September 2021 at 03:36 pm +0000, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Convert test helper to use `start_bg_command()` when spawning a server
>> daemon in the background rather than blocks of platform-specific code.
>>
>> Also, while here, remove _() translation around error messages since
>> this is a test helper and not Git code.
> 
> As part of testing the v2.34.0-rc0 release candidate on Cygwin, I've
> found this commit -- 05881a6fc9 (t/helper/simple-ipc: convert
> test-simple-ipc to use start_bg_command, 2021-09-20), according to my
> bisecting -- is causing t0052.1 to fail on 32-bit Cygwin.  Somehow this
> is only affecting the 32-bit Cygwin build; the 64-bit build is working
> as expected.

Hmmm, I am seeing exactly the same, but on 64-bit cygwin!

I haven't found time to look at this in detail yet (except for
what you have already done). Unfortunately, about an hour ago,
I did a 'make test' for the '-rc1' build, so I won't be able to
take a look for hours yet, ... :(

ATB,
Ramsay Jones
