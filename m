Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E71EC433FE
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 11:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C4D611C8
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 11:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhISKyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 06:54:21 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:32729 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhISKyU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 06:54:20 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mRuRJ-0003b6-3n; Sun, 19 Sep 2021 11:52:53 +0100
Subject: Re: [PATCH 6/6] Documentation: call out commands that nuke untracked
 files/directories
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1036.git.1632006923.gitgitgadget@gmail.com>
 <6ea23d165cf1f9433831cb4a01abf6f483a8bc29.1632006924.git.gitgitgadget@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <05be2442-d4e7-6007-a3ed-5f49f1b3d806@iee.email>
Date:   Sun, 19 Sep 2021 11:52:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6ea23d165cf1f9433831cb4a01abf6f483a8bc29.1632006924.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

truly minor nit.
On 19/09/2021 00:15, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> Some commands have traditionally also removed untracked files (or
> directories) that were in the way of a tracked file we needed.  Document
> these cases.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-checkout.txt  | 5 +++--
>  Documentation/git-read-tree.txt | 5 +++--
>  Documentation/git-reset.txt     | 3 ++-
>  3 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index b1a6fe44997..d473c9bf387 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -118,8 +118,9 @@ OPTIONS
>  -f::
>  --force::
>  	When switching branches, proceed even if the index or the
> -	working tree differs from `HEAD`.  This is used to throw away
> -	local changes.
> +	working tree differs from `HEAD`, and even if there are untracked
> +	files in the way.  This is used to throw away local changes and
double space after full stop?
> +	any untracked files or directories that are in the way.
>  +
>  When checking out paths from the index, do not fail upon unmerged
>  entries; instead, unmerged entries are ignored.
> diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
> index 5fa8bab64c2..4731ec3283f 100644
> --- a/Documentation/git-read-tree.txt
> +++ b/Documentation/git-read-tree.txt
> @@ -39,8 +39,9 @@ OPTIONS
>  
>  --reset::
>  	Same as -m, except that unmerged entries are discarded instead
> -	of failing. When used with `-u`, updates leading to loss of
> -	working tree changes will not abort the operation.
> +	of failing.  When used with `-u`, updates leading to loss of
Is the single space to double space change desired?
I had the impression that the project had decided on single spaces, but
I can't see anything in SubmittingPatches or CodingGuidelines. I don't
think there are DocumentationGuidelines.
> +	working tree changes or untracked files or directories will not
> +	abort the operation.
>  
>  -u::
>  	After a successful merge, update the files in the work
> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 252e2d4e47d..6f7685f53d5 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -69,7 +69,8 @@ linkgit:git-add[1]).
>  
>  --hard::
>  	Resets the index and working tree. Any changes to tracked files in the
> -	working tree since `<commit>` are discarded.
> +	working tree since `<commit>` are discarded.  Any untracked files or
as above,  s /.  /. /  ?
> +	directories in the way of writing any tracked files are simply deleted.
>  
>  --merge::
>  	Resets the index and updates the files in the working tree that are
--
Philip
