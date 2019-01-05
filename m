Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D621F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 20:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfAEUfC (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 15:35:02 -0500
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:63166 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfAEUfC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 15:35:02 -0500
Received: from [192.168.1.12] ([92.29.14.220])
        by smtp.talktalk.net with SMTP
        id fseqgUEb6AGVrfseqgfEAO; Sat, 05 Jan 2019 20:35:00 +0000
X-Originating-IP: [92.29.14.220]
X-Spam: 0
X-OAuthority: v=2.3 cv=DtN4Bl3+ c=1 sm=1 tr=0 a=iGBlNkCVnKJDjRvOkgwXUw==:117
 a=iGBlNkCVnKJDjRvOkgwXUw==:17 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=5rxgeBVgAAAA:8 a=4RBUngkUAAAA:8 a=1XWaLZrsAAAA:8 a=BHGKXxJdLFtyDyueHZ0A:9
 a=QEXdDO2ut3YA:10 a=h-qQF1Zau7IA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=PwKx63F5tFurRwaNxrlG:22 a=_sbA2Q-Kp09kWB8D3iXc:22
Subject: Re: [git-users] git checkout file with custom mtime
To:     git-users@googlegroups.com,
        Daniel Fanjul <daniel.fanjul.alcuten@gmail.com>,
        Git List <git@vger.kernel.org>
References: <951cafaa-877b-4815-862f-5ffc43e6976a@googlegroups.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <1413fbaa-8a83-0f43-afcb-5cb67683b505@iee.org>
Date:   Sat, 5 Jan 2019 20:35:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <951cafaa-877b-4815-862f-5ffc43e6976a@googlegroups.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfNolVVdpkz35CeumP2Jw9/NZ9AfwQ6MPhWG+6yTymWFXlJfqV9vW3rYRfaNwSska2Cr2ZJuzCW1EBiHy3Dh/PgPy8PmvwAi3cQj2tiDPfCfrBQEK3GqC
 llHeGIDzPPZasaj+3uMDLH/xP8zVUfT7ekzGJcI5KZVYVX/8mDjhdvU6Vw1fhVo1KAjvX6Pfk4oZdsdYx6fTpu8KnI33s5IMMorH9ED8gwTp34ey0sa2l3yy
 mD6l+bkR17A7HvGEwGsilA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel,


Do you use the Git LFS (Large File System) add-on?, are you on Windows 
or Linux?, and what tools need mtime (or is it something about the 
process of using the tool..)?

The Git viewpoint is that the mtime shouldn't be important for the 
version storage & control aspects, though it maybe for the external 
compiler tooling, so they do tend to try to keep the mtime/ctime consistent.

I'm not aware of specific capability to do what you ask, but it may be 
worth discussing this on the git mailing list "Git List 
<git@vger.kernel.org>" (which only accepts 100% plain text, no HTML, 
messages). The mailing list archive is at 
https://public-inbox.org/git/?q= where you can search for mtime/ctime 
discussions.

There will be a Git developer conference at the end of the month, so it 
is worth raining it soonish, even if it becomes an add on the fires via 
a post checkout hook that updates the mtimes from a stored file of 
'true' mtimes (plus updates the index's view of those mtimes.

Philip

On 05/01/2019 13:33, Daniel Fanjul wrote:
> Hi all,
>
> I have some large files tracked in git and I have to track their mtime 
> because of some legacy software. With another tool I save and restore 
> their mtime. When I restore their mtime git status rereads the files 
> to update the mtime in the index. I would like to improve that because 
> there are too many files, the whole I/O is too slow and the whole 
> process is triggered too often.
>
> I would like a way to tell git to checkout a file and set a given 
> mtime at the same time so the index is updated with the mtime but the 
> file is not rewritten because the working copy is clean. This would 
> solve my problem. Do you know a way to do this?
>
> Do you know any other way to handle this properly?
>
> Thanks in advance, and happy new year,
> Daniel.
> -- 
> You received this message because you are subscribed to the Google 
> Groups "Git for human beings" group.
> To unsubscribe from this group and stop receiving emails from it, send 
> an email to git-users+unsubscribe@googlegroups.com 
> <mailto:git-users+unsubscribe@googlegroups.com>.
> For more options, visit https://groups.google.com/d/optout.
