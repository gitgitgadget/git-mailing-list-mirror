Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCF6C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 15:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiCCPly (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 10:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiCCPlx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 10:41:53 -0500
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DF9195313
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 07:41:06 -0800 (PST)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nPnZd-0004wg-BR;
        Thu, 03 Mar 2022 15:41:05 +0000
Message-ID: <f66fada7-cd94-880d-be7a-bc097d016908@iee.email>
Date:   Thu, 3 Mar 2022 15:41:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 05/11] worktree: use 'worktree' over 'working tree'
Content-Language: en-GB
To:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "Elijah Newren [ ]" <newren@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA_=5b_=5d?= <jn.avila@free.fr>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <a6a8eb8e7bb4520bfe37d3a79329cce7886af59c.1645379667.git.gitgitgadget@gmail.com>
 <d9394947-f545-2dd9-b788-38fd7202243d@iee.email>
 <545f0248-89ad-3194-02ae-2f1a47f949db@github.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <545f0248-89ad-3194-02ae-2f1a47f949db@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the delay in replying. I had some family matters to attend to.

On 24/02/2022 15:53, Derrick Stolee wrote:
> On 2/24/2022 9:33 AM, Philip Oakley wrote:
>> On 20/02/2022 17:54, Derrick Stolee via GitGitGadget wrote:
>>> From: Derrick Stolee <derrickstolee@github.com>
>>>
>>> It is helpful to distinguish between a 'working tree' and a 'worktree'.
>>> A worktree contains a working tree plus additional metadata. This
>>> metadata includes per-worktree refs and worktree-specific config.
>> Doesn't this need a clear call-out in the text to highlight the
>> distinction, so that it is obvious at first glance to the casual reader?
>>
>> I'd ended up with something like:
>> - worktree
>>     A directory whose files and sub-directories are (selectively) under
>> Git revision management.
>> - working tree
>>     The working tree comprises Git revision management meta-data for the
>> worktree,
>>      and the worktree itself.
>>     The meta-data may be independently located away from the worktree's
>> data.
>>
>> The key feature is to have a layout structure that shows the distinction.
> See below where I mention that the first paragraph points out this
> distinction. Your use of bullets makes it even more clear, and I think
> that would be more valuable if this wasn't the very first thing in the
> document.

I don't really buy the "first paragraph points out this distinction"
because it's still part of a wall of text, so not easy to locate.

It's not helped by the top line NAME which uses both `worktree` and
`working tree` as if they are equivalent. Though that could be easily
solved by making it:

    git-worktree - Manage multiple working trees and their meta-data

which would highlight the two distinct parts. (could also add the
`git/user` distinction as below)


You'll probably also have noticed how even in my original suggestion,
I'd still misread the partition and got worktree/working-tree swapped
over, so it is easily done.

If we are trying to have clarity on the worktree/working-tree 
distinction, I still think it needs to be made very obvious, with
perhaps even the naming of the _git_ meta data part, or at least calling
it out as being the independent of the _users_ working tree .

Philip
>
>> Or are we trying to remove all references to "working tree"? Or have I
>> misunderstood?
> ...
>>>  A git repository can support multiple working trees, allowing you to check
>> Are we removing the above "working trees" phrases as well?
> This one is important to keep. The worktree feature is how Git manages
> multiple working trees.
>
> The reason for switching most of the other references is because the
> discussion applies specifically to worktrees, not working trees.
>
>>>  out more than one branch at a time.  With `git worktree add` a new working
>>> -tree is associated with the repository.  This new working tree is called a
>>> -"linked working tree" as opposed to the "main working tree" prepared by
>>> -linkgit:git-init[1] or linkgit:git-clone[1].
>>> -A repository has one main working tree (if it's not a
>>> -bare repository) and zero or more linked working trees. When you are done
>>> -with a linked working tree, remove it with `git worktree remove`.
>>> +tree is associated with the repository, along with additional metadata
>>> +that differentiates that working tree from others in the same repository.
>>> +The working tree, along with this metada, is called a "worktree".
> This first paragraph is all about the distinction between working tree
> and worktree, so it hopefully handles the concerns you had above.
>
> Thanks,
> -Stolee

