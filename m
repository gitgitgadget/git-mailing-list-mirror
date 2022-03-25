Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E69C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiCYTvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiCYTvP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:51:15 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2087410F6E
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:35:20 -0700 (PDT)
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.90,211,1643670000"; 
   d="scan'208";a="9642601"
Received: from unknown (HELO [IPV6:2a04:cec0:111b:84e:2844:68e1:9f1b:727c]) ([80.214.144.111])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 19:27:35 +0100
Message-ID: <7a522ccc-0a45-47fa-509c-a7a8b159041d@univ-lyon1.fr>
Date:   Fri, 25 Mar 2022 19:27:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: contrib/vscode/: debugging with vscode and gdb
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Jonathan Bressat <git.jonathan.bressat@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Cogoni Guillaume <cogoni.guillaume@gmail.com>
References: <CANteD_wDSRmwLQiYV1x133WEtVaRK__c584E3CbXN1tPOquitg@mail.gmail.com>
 <2a7eecb4a0b247ef8f855f1c4fb5d510@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
In-Reply-To: <2a7eecb4a0b247ef8f855f1c4fb5d510@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/25/22 14:19, Derrick Stolee wrote:

> Jonathan and Guillame reported that flipping this setting to "false"
> allows the VS Code debugger to work with Git. I verified that the
> debugger did not work by default but now does with this change.

FYI, I got the same problem, and I can reproduce the issue on a hello 
world program, so "externalConsole": true, is broken at least for me 
regardless of the Git codebase.

I couldn't understand what exactly the option was supposed to do. If I 
understand correctly, it should launch another window to show the git 
program output, but I don't know which window actually (xterm? 
x-terminal-emulator? a terminal program that isn't installed on my system?).

>   contrib/vscode/init.sh  |  2 +-
>   t/test-lib-functions.sh | 34 ----------------------------------

I guess the test-lib-functions.sh part is a leftover from another work?

> -            "externalConsole": true,
> +            "externalConsole": false,
I'd actually remove the line completely, to mean "let VSCode decide what 
to do", i.e. either VSCode's default, or the user's configuration 
("launch" section in settings.json, see e.g. 
https://code.visualstudio.com/docs/getstarted/settings ). If some user 
has a non-broken externalConsole: true VSCode and likes this behavior, 
then the best place to configure it is in a user-wide config file IHMO.

Cheers,

-- 
Matthieu Moy
https://matthieu-moy.fr/
