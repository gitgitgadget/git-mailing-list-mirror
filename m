Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09DFD203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 11:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbcLJLQk (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 06:16:40 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:33671 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcLJLQj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 06:16:39 -0500
Received: by mail-io0-f195.google.com with SMTP id p13so11918407ioi.0
        for <git@vger.kernel.org>; Sat, 10 Dec 2016 03:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=epBGnU6BIEOPwX2nFVDRX48CJIeu7mU4Ce9lyFxN7rU=;
        b=iviKY5Bw3psyGsYMt6nyytlygAAx3ZNS5EFkF2sjfPunNx0ILpYKCa15Tf1OcB9U/5
         J/ETtPYHkKgA5pqlw2gS7pwxSWhWGNYcVUT9dpr0RdTHsJDhLQBwV03neTzXQc5DTlWT
         Td1dbp4+DRRl6lK34ssmS5TCx4uJXQbwzFy6xNWMPiDNPYeXWEX0jbh2nQNaz9nncGg6
         5nm8qPHYwUCazGce52/DCCA6xNJPwEGjyer+k+UJ8bmI3HVcL9Vq14vERKaOAy1iIVO0
         LqQf9bxZZRxLo3eCglc9MQjDr/KnRstAU75GGkyMnBG+j9T/d8sD6+wCFXaPUA61XHgm
         hMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=epBGnU6BIEOPwX2nFVDRX48CJIeu7mU4Ce9lyFxN7rU=;
        b=OSn8oUkaHiIoRASTPUsWcZfZu+KWhGMwQliYgk2g7fGe6P67rK5je+CqHSygcIkVkh
         7D3Yrf7fAaoj0lWHdS8Ysn1SDiGNoT+DPbktZN06SmJXHd/I7q5QxFJKfzW1gzROcpZ3
         XsqJmIm42f2347VT9NgdYETCMDGfpCQwt4RdsQEwQKz9aa7lNOJHyXmOGbZEc+ADTEim
         bSJzyWelaUacdZjEnzkqHQmre78GFwGQ/JhLC2wx3F6fnfVQKSa4yB9VZopmUUHe0BZQ
         BGe0+UGm1jOL1ghf3qWPKPyg6vugU3eevKPjOXgAf9enYoohu/hElOE/hHclZUf1qaJ6
         aF7Q==
X-Gm-Message-State: AKaTC03dB3PkRD0jBL1M+oeagSPqyuAnashyQL3DBf6v5QDgOOC7BctPDn9Ft87MKs3jhBEqUEhjd4pb8JReag==
X-Received: by 10.107.132.74 with SMTP id g71mr73950351iod.19.1481368598863;
 Sat, 10 Dec 2016 03:16:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Sat, 10 Dec 2016 03:16:08 -0800 (PST)
In-Reply-To: <CAGZ79kaV4FYZEbRWQxKBHJg1jVzOkte1QxLZgu75=Jja_BMRGQ@mail.gmail.com>
References: <20161208210329.12919-1-sbeller@google.com> <20161208210329.12919-5-sbeller@google.com>
 <20161209120006.GA6609@ash> <CAGZ79kaV4FYZEbRWQxKBHJg1jVzOkte1QxLZgu75=Jja_BMRGQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 10 Dec 2016 18:16:08 +0700
Message-ID: <CACsJy8CQD9QOhJzN7Dm8-=bjrZSEWM_03ETgroin-Lm6vKMuRw@mail.gmail.com>
Subject: Re: [PATCHv7 4/6] worktree: have a function to check if worktrees are
 in use
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 10, 2016 at 1:49 AM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, Dec 9, 2016 at 4:00 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>
>> int submodule_uses_worktrees(const char *path)
>> {
>>         struct strbuf path = STRBUF_INIT;
>>         DIR *dir;
>>         struct dirent *d;
>>         int ret = 0;
>>
>>         strbuf_addf(&path, "%s/worktrees", path);
>>         dir = opendir(path.buf);
>>         strbuf_release(&path);
>>
>>         if (!dir)
>>                 return 0;
>
> The submodule may be one of the linked worktrees, which would be
> caught if we use the code as I sent it out?

I think I simplified it too much, there should still be a
git_common_dir_noenv() to retrieve the correct common dir in the
submodule from gitdir. Then, if the repo in question has any linked
worktrees, you probably can't handle it. It does not matter if the
submodule gitdir in question is a linked or main worktree.

> If this is one of the linked worktrees, we'd rather check if a file
> "commondir" or "gitdir" exists?

Well, in theory yes. But we're apparently not ready for that. If you
check the files exist, but the files are not valid, then it's still
not considered a worktree. Which is not much different from what we do
here (if the directory exists, assuming it's a worktree). It should
catch all the valid worktrees. But yes it could give some false
positive. Since we're just using this function to stop the aborbing
git dir operation, i think this is acceptable.

(It goes even trickier, even get_worktrees() won't detect if the
linked worktree is already dead, .e.g. deleted manually, I believe.
Those have to be cleaned up by 'git worktree prune' which does even
more checks before it declare "this directory is garbage").

> I ask that because I would not know how to relocate such a linked
> worktree gitdir?



-- 
Duy
