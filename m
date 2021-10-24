Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1118C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 06:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB40560FC3
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 06:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhJXG4i (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 02:56:38 -0400
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:36354 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhJXG4h (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 02:56:37 -0400
Received: from [79.233.232.241] (helo=[192.168.2.202])
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1meXOJ-00029D-MM
        for git@vger.kernel.org; Sun, 24 Oct 2021 08:53:59 +0200
Message-ID: <da952e81-70f9-886b-42ff-2ec850f55fa0@mfriebe.de>
Date:   Sun, 24 Oct 2021 08:54:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
From:   Martin <git@mfriebe.de>
Subject: Re: changing the experimental 'git switch' (was: [Summit topic]
 Improving Git UX)
Cc:     git@vger.kernel.org
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211150290.56@tvgsbejvaqbjf.bet>
 <211021.86wnm6l1ip.gmgdl@evledraar.gmail.com>
 <9c6b3041-a5c0-6fe1-860e-7bfcb292ae81@mfriebe.de>
Content-Language: en-GB
In-Reply-To: <9c6b3041-a5c0-6fe1-860e-7bfcb292ae81@mfriebe.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/10/2021 16:04, martin wrote:
> Unless there is more, than the copying of the reflog, wouldn't it be 
> better to add an option "--copy-reflog"

Ok, I found the answer (actually 2 / see other mail)
> The |-c| and |-C| options have the exact same semantics as |-m| and 
> |-M|, except instead of the branch being renamed, it will be copied to 
> a new name, along with its config and reflog.
As for the "config" being part depends on which part of the man-page one 
reads.

But, anyway on the topic of "git switch"

Copying a branch (and maybe moving too) could be seen as an extension to 
creating a new one.
After all, after the copy operation there is a newly created branch. 
Only it has some more data with it.

So one could do
git switch  --settings-from <branch-with-reflog-and-conf> --create 
<new-branch>   <commit>
git switch  -s <branch-with-reflog-and-conf>   -c <new-branch>   <commit>

"settings-from" is just an example, there may be better names for it. 
Ideally not starting with a "c".

And using a name different from "copy" may be more accurate, because 
unless it is created on the same one <commit> to which the 
<branch-with-reflog-and-conf> points, then its at best partially copied.

On top of that options could be brought in, to copy only reflog or only 
config.

Using the above with an --force-create / -C would make it a "move branch".
In this case there could be a shortcut, if <branch-with-reflog-and-conf> 
and (the old) <new-branch>  are the same.


