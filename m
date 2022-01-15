Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A5AC433EF
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 15:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiAOPiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 10:38:10 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:21179 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231941AbiAOPiK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 10:38:10 -0500
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Jbj411JlXz5tl9;
        Sat, 15 Jan 2022 16:38:09 +0100 (CET)
Message-ID: <9a7eac53-79fe-24f5-225a-d00d26e67259@kdbg.org>
Date:   Sat, 15 Jan 2022 16:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: A new feature command request `cmd_ignore`
Content-Language: en-US
To:     Jaydeep Das <jaydeepjd.8914@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <11860e44-beff-39e6-2efc-53324223caee@gmail.com>
 <CABPp-BFY2issEqOj1Oj71k=494vc8E563CndxPZfXYrteFoNhw@mail.gmail.com>
 <5f6f1dba-a923-4bb9-70a7-4936566f46e0@kdbg.org>
 <9a3837b4-8c67-e114-e977-f6c7b729ba45@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <9a3837b4-8c67-e114-e977-f6c7b729ba45@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.01.22 um 11:45 schrieb Jaydeep Das:
> 
>> I think that is a paraphrase of the suggestion to
> 
>    git rm --cached settings
>    echo settings >> .gitignore
> 
>> when changes to a file 'settings' that was already tracked (and often
>> contains user-specific settings) should be ignored. This misguided and
>> short-sighted "solution" is repeated numerous times on Stackoverflow.
>> Not something that we should encourage.
> 
> So what should be done in this scenario? And why is it a discouraged and
> misguided thing?

It is misguided because if you commit the removal of 'settings', others
who pull/merge this change will either see their 'settings' be removed
(when they did not change the file) or their pull/merge will fail with
an error about a modified file being in the way (when they did modify
it). It causes a whole lot of grief for others.

There are different ways to address this problem.

- One is to commit a 'settings.template' file that must be copied to
'settings' and is adjusted as necessary, but not `git add`ed.

- Another is to have a mechanism that can include local files that carry
the user-specific settings.

- Yet another is to generate the final file from a tracked template and
a local, untracked, file during the build process.

-- Hannes
