Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCACC433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 13:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiDPN2S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiDPN2R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 09:28:17 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEBC36B52
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 06:25:41 -0700 (PDT)
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.90,264,1643670000"; 
   d="scan'208";a="32013508"
Received: from 209.56.68.91.rev.sfr.net (HELO [192.168.1.28]) ([91.68.56.209])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 15:25:39 +0200
Message-ID: <0f8dbbd6-4d7b-4530-ec85-2eddfcdc9825@univ-lyon1.fr>
Date:   Sat, 16 Apr 2022 15:25:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/1] Documentation/ToolsOnGit.txt: gather information
 about tools
Content-Language: en-US
To:     COGONI Guillaume <cogoni.guillaume@gmail.com>
Cc:     "derrickstolee@github.com" <derrickstolee@github.com>,
        "git.jonathan.bressat@gmail.com" <git.jonathan.bressat@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>,
        "shaoxuan.yuan02@gmail.com" <shaoxuan.yuan02@gmail.com>
References: <CAA0Qn1tZxGR0cUi2JSJtTFYe2Nk9xoGuHkruji1-53-Fhokmig@mail.gmail.com>
 <20220416123433.28391-1-cogoni.guillaume@gmail.com>
 <63d7dc69656e47f7bc7bce4839711f32@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
In-Reply-To: <63d7dc69656e47f7bc7bce4839711f32@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/16/22 14:34, COGONI Guillaume wrote:
> This document aims to gather tools that have a README and/or scripts in
> the GIT project

We usually spell the project name as Git, and the command name as git. 
And nothing as GIT ;-).

> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -93,6 +93,7 @@ SP_ARTICLES += $(API_DOCS)
>   TECH_DOCS += MyFirstContribution
>   TECH_DOCS += MyFirstObjectWalk
>   TECH_DOCS += SubmittingPatches
>  +TECH_DOCS += ToolsOnGit

If the goal is to document tools that can be used to develop Git itself, 
probably ToolsForGit would be more appropriate...

> --- /dev/null
> +++ b/Documentation/ToolsOnGit.txt
> @@ -0,0 +1,35 @@
> +Tools on GIT
> +============

... and "Tools for developing Git" a better long title?

> +== Summary
> +
> +This document aims to gather tools that have a README and/or scripts in > +the GIT project.

I don't think having a README should be the criterion here. To me the 
criterion should be "tools that may not work out of the box, but for 
which some explanation, configuration or script allow using the tool 
properly".

> +[[author]]
> +=== Author
> +
> +The Git community.
> +
> +[[table_of_contents]]
> +== Table of contents
> +
> +- <<vscode>>
> +- <<emacs>>
> +
> +[[vscode]]
> +=== Visual Studio Code (VS Code)
> +
> +The contrib/vscode/init.sh script creates configuration files that enable
> +several valuable VS Code features. See contrib/vscode/README.md for more
> +information on using the script.
> +
> +In particular, this script enables using the VS Code visual debugger, including
> +setting breakpoints, logpoints, conditional breakpoints and more in the editor.

I don't think the last sentence is needed, and if it is, it would be 
better within contrib/vscode/README.md (so that someone reaching this 
README directly do see the information too).

> +[[emacs]]
> +=== Emacs
> +
> +See contrib/emacs/README for more information.

This README starts with "This directory used to contain ..." (note the 
"used to". There's no reason to point the user to obsolete scripts.

Also, the stuff that used to be in this directory do not fall in the 
same category. They were targeted at users of both Git and Emacs, but 
not specifically to develop Git itself.

OTOH, CodingGuidelines's suggestion to configure Emacs like this is IMHO 
typically something that could appear in this document:

  - For Emacs, it's useful to put the following in
    GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:

     ;; note the first part is useful for C editing, too
     ((nil . ((indent-tabs-mode . t)
                   (tab-width . 8)
                   (fill-column . 80)))
      (cperl-mode . ((cperl-indent-level . 8)
                     (cperl-extra-newline-before-brace . nil)
                     (cperl-merge-trailing-else . t))))

Actually, the Linux kernel's CodingStyle contains more relevant stuff 
(for C, not Perl):

 
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#you-ve-made-a-mess-of-it

(But aren't all Git devs former kernel developers? ;-) )

Cheers,

-- 
Matthieu Moy
https://matthieu-moy.fr/
