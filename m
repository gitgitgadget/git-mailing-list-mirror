Return-Path: <SRS0=LEOb=ZX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A13C432C0
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 23:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 196E22146E
	for <git@archiver.kernel.org>; Sun,  1 Dec 2019 23:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfLAXly (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Dec 2019 18:41:54 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:57070 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfLAXly (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Dec 2019 18:41:54 -0500
Received: from [79.66.3.179] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ibYqe-0000HW-9z; Sun, 01 Dec 2019 23:41:52 +0000
Subject: Re: [PATCH 1/1] contrib/buildsystems: fix Visual Studio Debug
 configuration
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.348.git.gitgitgadget@gmail.com>
 <525669b3b38ed57d6d4f188dfe0bb8fe10b63749.1569227313.git.gitgitgadget@gmail.com>
 <c89cc506-b515-b913-bb0a-353b04fe4210@iee.email>
 <8e7ff0b2-9f62-8ec6-5316-eb9cee25024e@syntevo.com>
 <70bc64f6-3513-2924-9ba0-0e38e0e9d308@iee.email>
 <0b2124b5-6d40-08bb-6cc5-a8cef2b7a9b1@syntevo.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <021de37a-5317-6c96-eae3-d0228a193d8b@iee.email>
Date:   Sun, 1 Dec 2019 23:41:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <0b2124b5-6d40-08bb-6cc5-a8cef2b7a9b1@syntevo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/11/2019 10:07, Alexandr Miloslavskiy wrote:
> On 28.11.2019 1:34, Philip Oakley wrote:
>
>> Hmm, 45 minutes of cloning and rebuild, but finally it compiled clean 
>> (both Release and Debug)
>
> I understand that the issue is resolved now.
>
> Probably your old repo was missing the libraries for whatever reason 
> (like antivirus deleting them, etc), but build script thought that 
> dependencies are properly built, so didn't attempt to rebuild them.

I was searching for how Visual Studio managed to decide if the vcpkg 
needed installing. I think I've found it in 384a61bc6a 
("contrib/buildsystems: add a backend for modern Visual Studio 
versions", 2019-07-29) where dscho says:

    we initialize the `vcpkg` conditionally, in the `libgit` project's
    `PreBuildEvent`. To allow for parallel building of the projects, we
    therefore put `libgit` at the bottom of the project hierarchy.


What's not clear is if the conditional pre-build can have an if-else 
option so that we can have an 'update' check if already installed. 
Adding the vcpkg update to the vcpkg_install.bat didn't work :-(

Philip

PS. the https://github.com/CoatiSoftware/Sourcetrail visualiser is 
looking nice.


