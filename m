Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A77FC433EF
	for <git@archiver.kernel.org>; Fri, 15 Apr 2022 11:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352702AbiDOLp6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 07:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiDOLp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 07:45:57 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5568B644D0
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 04:43:28 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nfKMI-000AJ6-8T;
        Fri, 15 Apr 2022 12:43:26 +0100
Message-ID: <3a02bf6c-54c1-39c8-5f3e-9f246c9e87b8@iee.email>
Date:   Fri, 15 Apr 2022 12:43:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: safe directory on shared drives
Content-Language: en-GB
To:     Andrew Noblet <andrewbnoblet@gmail.com>, git@vger.kernel.org
References: <CAO=QCg5+M-=dOf=AFTDL8z9-LrK-7vau+=JV-7QJfVOhdFp1Aw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAO=QCg5+M-=dOf=AFTDL8z9-LrK-7vau+=JV-7QJfVOhdFp1Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andrew,

On 15/04/2022 11:14, Andrew Noblet wrote:
> The new git security rules creates an issue on Windows systems where
> the git repository is hosted in a shared folder.
>
> $ git status
>
> ```
> fatal: unsafe repository ('//192.168.0.120/config/' is owned by someone else)
> To add an exception for this directory, call:
>
>         git config --global --add safe.directory //192.168.0.120/config/
> ```
>
> $ git config --global --add safe.directory //192.168.0.120/config/
> $ git status
>
> ```
> warning: encountered old-style '//192.168.0.120/config/' that should
> be '%(prefix)//192.168.0.120/config/'
> fatal: unsafe repository ('//192.168.0.120/config/' is owned by someone else)
> To add an exception for this directory, call:
>
>         git config --global --add safe.directory //192.168.0.120/config/
> ```
>
> There seems to be no way to add a shared drive path to the safe directory list.

This (instruction clarification) is being discussed / sorted at
[git-for-windows/git] Include trailing slash in prefix migration
instructions (PR #3790)
https://github.com/git-for-windows/git/pull/3790

The key point being that for a `//server` path you will need three
slashes. (IIUC) One for magic prefix string, and then two as part of the
server name.

There is now also the `*` option that permits all as safe directories. 
Worth checking how the user and group security is being handled locally,
especially for accidental failures.
Philip


