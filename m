Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5605DC433F5
	for <git@archiver.kernel.org>; Sun, 15 May 2022 10:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiEOKiS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 May 2022 06:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiEOKiR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 May 2022 06:38:17 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766351D32C
        for <git@vger.kernel.org>; Sun, 15 May 2022 03:38:16 -0700 (PDT)
Received: from host217-43-165-125.range217-43.btcentralplus.com ([217.43.165.125] helo=[192.168.1.168])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nqBde-0007LR-Bq;
        Sun, 15 May 2022 11:38:15 +0100
Message-ID: <e5a7937c-eae0-c30a-9894-c217e4ba904d@iee.email>
Date:   Sun, 15 May 2022 11:38:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: sudo: git describe during GIT_VERSION_GEN not as expected..
Content-Language: en-US
From:   Philip Oakley <philipoakley@iee.email>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <7bb71920-b840-5133-ceac-664c09942772@iee.email>
In-Reply-To: <7bb71920-b840-5133-ceac-664c09942772@iee.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

couple corrections.

On 15/05/2022 11:12, Philip Oakley wrote:
> Hi,
>
> I have run into a problem with make/install of git on my old travel 
> laptop. While trying to make / install git with some patches on top of 
> yesterdays next (coincidental timing) I'm finding that the generated 
> git version is the default value rather than that of a regular 'get 
> describe' as used in GIT_VERSION_GEN.
>
> Commit tree state:
> ~/repos/git (die_preserve_2)$ git log -4 --oneline --decorate
> dd96dd88c3 (HEAD -> die_preserve_2) rebase: note `preserve` merges may 
> be a pull config option
> 53d93c1c94 rebase: help users when dying with `preserve-merges`
> 65721c069b rebase.c: state preserve-merges has been removed
> 7e84679e2a (junio/next, gitster/next, gitgitgadget/next, git/next) 
> Merge branch 'cb/ci-make-p4-optional' into next
>
> After a make/install of the above I'm getting a version string is the 
> default, rather than referencing the current hash as below. I've 
> already tried setting the safe.directory as advised. The second 
> describe invocation is from GIT_VERSION_GEN
which, in this case, is invoked by the sudo in the `make install`
> . Note how it fails to provide the expected output.
>
> ~/repos/git (die_preserve_2)$ git version
> git version 2.36.GIT
> ~/repos/git (die_preserve_2)$ git describe --match "v[0-9]*" HEAD
> v2.36.1-165-gdd96dd88c3
> ~/repos/git (die_preserve_2)$ sudo git describe --match "v[0-9]*" HEAD
> fatal: unsafe repository ('/home/philip/repos/git' is owned by someone 
> else)
> To add an exception for this directory, call:
>
>     git config --global --add safe.directory /home/philip/repos/git
> ~/repos/git (die_preserve_2)$ git config --global --get safe.directory

Bad cut & paste. The response was:
/home/philip/repos/git

>
>
> Is this a temporary position, as the sudo safe.directory problem is 
> still to be added to next? Or is it a secondary side effect of the 
> install method as per [1,2]?
>
> Philip
>
> [1] 
> https://www.digitalocean.com/community/tutorials/how-to-install-git-from-source-on-ubuntu-20-04-quickstart 
>
>     see `sudo make prefix=/usr/local install`
> [2] 
> https://www.digitalocean.com/community/tutorials/how-to-install-git-on-ubuntu-20-04
>

