Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CE2C433EF
	for <git@archiver.kernel.org>; Sun, 17 Apr 2022 12:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiDQM2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Apr 2022 08:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiDQM17 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Apr 2022 08:27:59 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DF2BF40
        for <git@vger.kernel.org>; Sun, 17 Apr 2022 05:25:21 -0700 (PDT)
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.90,267,1643670000"; 
   d="scan'208";a="32083955"
Received: from 209.56.68.91.rev.sfr.net (HELO [192.168.1.28]) ([91.68.56.209])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 14:25:20 +0200
Message-ID: <c6b48fba-c950-bb3a-3fdb-6d420a4cdfbc@univ-lyon1.fr>
Date:   Sun, 17 Apr 2022 14:25:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 0/1] Documentation/ToolsForGit.txt: Tools for
 developing Git
Content-Language: en-US
To:     COGONI Guillaume <cogoni.guillaume@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Cc:     "derrickstolee@github.com" <derrickstolee@github.com>,
        "git.jonathan.bressat@gmail.com" <git.jonathan.bressat@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>,
        "shaoxuan.yuan02@gmail.com" <shaoxuan.yuan02@gmail.com>
References: <xmqqlew554ye.fsf@gitster.g>
 <33d2087c66e44037b03db818dae60fea@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
In-Reply-To: <33d2087c66e44037b03db818dae60fea@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/17/22 11:35, COGONI Guillaume wrote:
> MOY Matthieu wrote:
> 
>>> +In particular, this script enables using the VS Code visual debugger, including
>>> +setting breakpoints, logpoints, conditional breakpoints and more in the editor.
>>
>> I don't think the last sentence is needed, and if it is, it would be
>> better within contrib/vscode/README.md (so that someone reaching this
>> README directly do see the information too).
> 
> I think so too. However, I already make a PATCH last week for
> contrib/vscode/README:
> (see <20220407204001.112287-2-cogoni.guillaume@gmail.com>).
> And, I see that in What's cooking in git.git (Apr 2022, #04; Thu, 14)
> it will be merge in Next. So, do I take this PATCH from the last week
> and I add it this part in contrib/vscode/README or I just add this part
> here in this new PATCH but where the subject is different?

I think you can just drop that sentence. For someone a bit familiar with 
either VS code or any other IDE, it's no big surprise that the debugger 
integration allows such feature. For someone not familiar with VS code, 
the patch about to land in next already contains a link to a page 
explaining that.

If you want to add more explanation, then I think it should be added to 
contrib/vscode/README. You will probably want to add in next to the 
lines touched by the previous patch, hence either Junio will have to 
solve a conflict, or you need to write your patch on top of the previous 
one.

>> - For Emacs, it's useful to put the following in
>>     GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
> 
>>      ;; note the first part is useful for C editing, too
>>      ((nil . ((indent-tabs-mode . t)
>>                    (tab-width . 8)
>>                    (fill-column . 80)))
>>       (cperl-mode . ((cperl-indent-level . 8)
>>                      (cperl-extra-newline-before-brace . nil)
>>                      (cperl-merge-trailing-else . t))))
> 
>> Actually, the Linux kernel's CodingStyle contains more relevant stuff
>> (for C, not Perl):
> 
>> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#you-ve-made-a-mess-of-it
> 
> I add this part directly in ToolsForGit.txt and not in the README in contrib/emacs.
> But, from this document in Documentation/RelNotes/2.18.0.txt, I read this:
> "The scripts in contrib/emacs/ have outlived their usefulness and have been
> replaced with a stub that errors out and tells the user there are replacements."
> So, for the next version of this PATCH, can I replace what is in the README by the
> configuration that I write in ToolsForGit.txt?

contrib/emacs was really not meant for developers hacking on Git. Since 
it contains only pointers to obsolete stuff, we may want to just discard 
its current content and make it the place to put documentation for 
people hacking on Git with Emacs, just like contrib/vscode/ is for VS 
code and Git. But we probably have only a few (tens of) lines of 
documentation, so adding the doc directly in ToolsForGit.txt is probably 
better.

> OAKLEY Philip  wrote:
> 
>> I'm of the view that a README is a positive indicator that there is some
>> informational value regarding the tool's use for developing Git being
>> made available. It doesn't always have to be code before it is of
>> assistance in developing Git.
> 
> I agreed with OAKLEY, the README is good indicator to say that we have some
> information besides the scripts.

A good indicator, yes. But reading only the summary ...
>  == Summary
>   
>  This document aims to gather tools that have a README and/or scripts in
>  the Git project.

I have no idea whether this document's audience is "people hacking ON 
Git's codebase" or "people using Git (somewhere else)". I believe the 
first sentences of the document should answer "is this document for me?" 
(i.e. "shall I continue reading?"), and currently it doesn't.

Saying instead something like

This documents gathers tips, scripts and configuration file to help 
people working on Git's codebase use their favorite tools while 
following Git's coding style.

would make the target audience much clearer IMHO.

> +- To follow rules of the CodingGuideline, it's useful to put the following in
> +GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
> +----
> +;; note the first part is useful for C editing, too
> +((nil . ((indent-tabs-mode . t)
> +	 (tab-width . 8)
> +	 (fill-column . 80)))
> +	 (cperl-mode . ((cperl-indent-level . 8)
> +			(cperl-extra-newline-before-brace . nil)
> +			(cperl-merge-trailing-else . t))))
> +----
> +
> +- The version for C:

The version for Perl already contains some configuration applicable to C 
(indent-tabs-mode, tab-width and fill-column).

> +(add-hook 'c-mode-hook
> +	(lambda ()
> +		(let ((filename (buffer-file-name)))
> +		 ;; Enable kernel mode for the appropriate files
> +		 (when (and filename
> +			(string-match (expand-file-name "~/src/linux-trees")

This works only if the user checked out Git's source code in 
~/src/linux-trees, which is unlikely ;-). I guess this path is not to be 
taken literally (i.e. it's more clearly "adapt the configuration to your 
actual directory layout"), but using linux-trees here won't make it 
clear that it should be the place to Git's source code.

> +				       filename))
> +		 (setq indent-tabs-mode t)

This one is redundant with the above for example.

Actually, while the tips given in Linux's kernel CodingStyle are 
relevant for us, I'm not sure copy-pasting them in Git's tree actually 
has added value. We may as well just link to them, like

For a more complete setup, since Git's codebase uses a coding style 
similar to the Linux kernel's style, tips given in Linux's CodingStyle 
document can be applied here too.

(Plus a link to the file on kernel.org)

If you copy paste here, you should cite the source and say stg like 
"This is adapted from Linux's suggestion in its CodingStyle document".

> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -492,17 +492,6 @@ For Perl programs:
>   
>    - Learn and use Git.pm if you need that functionality.
>   
> - - For Emacs, it's useful to put the following in
> -   GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:
> -

I agree that removing Emacs-specific code from a general document is 
nice, but then you should replace it with a link to ToolsForGit.txt like 
"Tips to make your editor follow this style can be found in 
ToolsForGit.txt" (without being specific to Emacs, that's the point of 
the document, it also applies to VS code and may be extended in the 
future to other editors).

Cheers,

-- 
Matthieu Moy
https://matthieu-moy.fr/
