Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E001C4338F
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 15:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 263C360D07
	for <git@archiver.kernel.org>; Sun, 25 Jul 2021 15:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhGYPA3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jul 2021 11:00:29 -0400
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:58823 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhGYPA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jul 2021 11:00:28 -0400
Received: from [87.152.157.21] (helo=[192.168.2.202])
        by smtprelay04.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m7gDF-0003AP-O4
        for git@vger.kernel.org; Sun, 25 Jul 2021 17:38:45 +0200
Subject: Re: Files modified, even after: git reset --hard
From:   Martin <git@mfriebe.de>
To:     git@vger.kernel.org
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
Message-ID: <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de>
Date:   Sun, 25 Jul 2021 17:40:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/07/2021 17:04, Martin wrote:
> I have some files, that will show up modified. Always.
>
> If I just switch to a commit, with clean worktree before, then those 
> files will be modified.
>
...
> But I *suspect* that the blob contains either CrLf, or mixed 
> line-endings.

Also, if that is the case, what can I do to resolve the issue?
The file has been fixed in the meantime. It is about the old commits....

filter branch is not an option. All commit hashes must be kept. No force 
pushes to the repro...

That also means I can not use .gitattribute, because I could not amend 
it for the old revisions.
I might be able to use my local $GIT_DIR/info/attributes.
But then I risk to make new commits to that file, and introduce new 
wrong line-endings.

Maybe git replace?
I figure if I do not replace the commit objects, but only the blobs to 
which they point. Then all commits should keep their hashes. (so 
references to any commit by hash would remain working)

But it's thousands of commits, between the introduction of the issue, 
and the commit where it's fixed.
So I guess I need to create as many new blobs, and replacement entries.
- Is that practical? How does git perform with such many replacements
- Is there an easy way to create them?

Are there other, better solutions?
