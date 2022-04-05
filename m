Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D4AC4332F
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 09:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiDEJyF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349296AbiDEJtf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 05:49:35 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906021572E
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 02:43:39 -0700 (PDT)
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.90,236,1643670000"; 
   d="scan'208";a="30105413"
Received: from dhcp-13-114.lip.ens-lyon.fr (HELO [140.77.13.114]) ([140.77.13.114])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 11:43:38 +0200
Message-ID: <6f4b924d-0a13-b267-6766-a3620936b686@univ-lyon1.fr>
Date:   Tue, 5 Apr 2022 11:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: contrib/vscode/: debugging with vscode and gdb
Content-Language: en-US
To:     Guillaume Cogoni <cogoni.guillaume@gmail.com>,
        Jonathan Bressat <git.jonathan.bressat@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <CANteD_wDSRmwLQiYV1x133WEtVaRK__c584E3CbXN1tPOquitg@mail.gmail.com>
 <2a7eecb4a0b247ef8f855f1c4fb5d510@SAMBXP02.univ-lyon1.fr>
 <7a522ccc-0a45-47fa-509c-a7a8b159041d@univ-lyon1.fr>
 <c1f255d7-6637-b6ac-0a64-1f64404a6f6c@github.com>
 <CANteD_yZ8de2i54EUWW=d6eVzpiKm5NNHGVEKrXOmo5KXnXUVQ@mail.gmail.com>
 <7b139f2c480e4ebc8dc6615b44cd5f24@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
In-Reply-To: <7b139f2c480e4ebc8dc6615b44cd5f24@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/22 22:18, Guillaume Cogoni wrote:
> Hello,
> 
> We don't know if we can revive this topic, but we still think that
> it's a good idea
> to talk more about "how it can be useful to use the debugging tool that gives
> VS Code".
> 
> So, we make a patch about it.
> We retrieve what Derrick Stolee did and add what we said in our previous mail.
> 
> Thanks,
> Cogoni Guillaume and Jonathan Bressat
> 
> --------------------->8-----------------------------------
> 
> Subject: [PATCH 0/1] contrib/vscode/: debugging with VS Code and gdb
> COGONI Guillaume (1):
> contrib/vscode/: debugging with VS Code and gdb

How did you generate this patch? It doesn't apply with 'git am', I 
suspect you copy-pasted incorrectly into your mailer. Using 'git 
send-email' helps sending properly formatted patches.

 > Remove "externalConsole" line in contrib/vscode/init.sh because it
 > seems to not work for everyone, and after a discussion with Matthieu
 > Moy and Derrick Stolee, we agreed that it is better to let the user 
choose
 > what to do with this line

I usually explain the problem first, and then the solution.

The externalConsole=true setting is broken for many users (launching the 
debugger with such setting results in VS Code waiting forever without 
actually starting the debugger). Also, this setting is a matter of user 
preference, and is arguably better set in a "launch" section in the 
user-wide settings.json than hardcoded in our script. Remove the line to 
use VS Code's default, or the user's setting.

 > (Add his own configuration).

Avoid using gender-specific formulation when not needed. It's easier to 
do in English than in French.

 > Add useful links in contrib/vscode/README.md to help the user to
 > configure his VS Code and how to use the debugging feature.

Likewise.

 > Add a mention to the README in Documentation/MyFirstContribution.txt
 > and a part "To convince a newcomer that VS Code can help him".

Why use double-quotes here? You're not quoting anything, right?

> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1265,3 +1265,15 @@ against the appropriate GitGitGadget/Git branch.
> If you're using `git send-email`, you can use it the same way as before, but you
> should generate your diffs from `<topic>..<mybranch>` and base your work on
> `<topic>` instead of `master`.
> +
> +[[Bonus-useful-tools]]
> +== Bonus - useful tools
> +
> +=== VS Code
> +
> +To see "how to use VS Code" read contrib/vscode/README.md.

Double-quotes look weird here too. And the document is not really about 
using VS Code, but more specifically on how to use VS Code on Git's 
codebase.

A set of scripts and instructions to use VS Code on Git's codebase is 
available in `contrib/vscode/README.md`.

?

> +If you want to try to understand "how git works internally", the debugging
> +feature of VS Code can help you. It will not give you all the keys to
> fully understand it, but
> +it can give you an idea of "how the information travels inside the code".
> +It can help you to isolate some parts of code, with this you are able
> +to ask more precise questions when you are stuck. (See getting-help sections).
> \ No newline at end of file

I'm reluctant to adding general programming tips in a Git-specific 
document. Perhaps shorten it to eg. just "Using the integrated debugger 
can be particularly helpful to understand how Git works internally"?

> --- a/contrib/vscode/README.md
> +++ b/contrib/vscode/README.md
> @@ -8,6 +8,11 @@ code editor which runs on your desktop and is available for
> [Linux](https://code.visualstudio.com/docs/setup/linux). Among other languages,
> it has [support for C/C++ via an
> extension](https://github.com/Microsoft/vscode-cpptools).
> +To understand "how works the debugging part" read:

"How the debugging part works" to get words in the proper order.

But the flow would be more natural continuing the previous sentence IMHO:

   it has [support for C/C++ via an 
extension](https://github.com/Microsoft/vscode-cpptools) with [debugging 
support](https://code.visualstudio.com/docs/editor/debugging).

> +To get help about "how to personalize your settings" read:
> +[How to set up your
> settings](https://code.visualstudio.com/docs/getstarted/settings)

Why not, but I don't think it's necessary here. People familiar with VS 
Code don't need such link, and people not familiar at all with is would 
better read a tutorial.

Cheers,

-- 
Matthieu Moy
https://matthieu-moy.fr/
