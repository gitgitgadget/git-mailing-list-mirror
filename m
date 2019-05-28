Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7871F462
	for <e@80x24.org>; Tue, 28 May 2019 13:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfE1N4O (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 09:56:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:33292 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfE1N4O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 09:56:14 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7B33A3F40F0;
        Tue, 28 May 2019 09:56:13 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:98c8:dc56:b85b:909] (unknown [IPv6:2001:4898:a800:1012:49fc:dc56:b85b:909])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F072B3F40CB;
        Tue, 28 May 2019 09:56:12 -0400 (EDT)
Subject: Re: [PATCH] compat/vcbuild/README: clean/update 'vcpkg' env for
 Visual Studio updates
To:     Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190528120846.1056-1-philipoakley@iee.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a48d5f62-081a-de14-5dbb-4726908a4179@jeffhostetler.com>
Date:   Tue, 28 May 2019 09:56:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190528120846.1056-1-philipoakley@iee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/28/2019 8:08 AM, Philip Oakley wrote:
> When the user installs an updated version of Visual Studio, the previously
> generated MSVC-DEFS-GEN will need to be deleted to allow updating.
> 
> Alternatively the whole vcpkg download may be cleaned allowing it to be
> reloaded, though this may take much longer on slower connections.
> 
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> 
> In response to discussions at:
> https://github.com/git-for-windows/git/issues/2186
> 
> cc: Jeff Hostetler <git@jeffhostetler.com>
> cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
>   compat/vcbuild/README | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/compat/vcbuild/README b/compat/vcbuild/README
> index 81da36a93b..40695fc1cc 100644
> --- a/compat/vcbuild/README
> +++ b/compat/vcbuild/README
> @@ -18,6 +18,13 @@ The Steps to Build Git with VS2015 or VS2017 from the command line.
>      Makefile:
>         <repo_root>/compat/vcbuild/MSVC-DEFS-GEN
>   
> +   - If you update your Visual Studio version, then delete the MSVC-DEFS-GEN
> +   file so that fresh environment variables can be discovered.
> +
> +   Or clean the "vcpkg" environment with:
> +
> +   $ make MSVC=1 clean
> +
>   2. OPTIONALLY copy the third-party *.dll and *.pdb files into the repo
>      root to make it easier to run and debug git.exe without having to
>      manipulate your PATH.  This is especially true for debug sessions in
> 

Did you mean to send this upstream or to Git for Windows?

I didn't think that the VS2015/VS2017 vcpkg-aware version of
compat/vcbuild/* had made it upstream yet, so this patch might not
apply upstream.


BTW, the Makefile (when MSVC=1 is defined) will take care of deleting
the MSVC-DEFS-GEN, so all we really need to say here is to do:

     $ make MSVC=1 clean
or  $ make MSVC=1 DEBUG=1 clean

after upgrading to a new version of VS.

Jeff

PS. I have a TODO item to fix the Makefile to automatically detect
and take care of this.
