Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E5361FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932226AbcLHSzi (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:55:38 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33474 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbcLHSzh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:55:37 -0500
Received: by mail-qt0-f176.google.com with SMTP id p16so419104523qta.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Lw7vlLjr9WVZ+TDOesQXMZI349ziwVPBNRQr4tuKUcE=;
        b=aWUHonMofttihsA7f43S/xembIgc6wEK+v7kRqyn4hEnYN7s1hgh3J/Gxd1243Z9qA
         rlhHRNENsCz09X/H8opLMeAWXUQc92BZDPNPj0wtc1+Snfl7e8AVheym07cSmChvdPH4
         3PVc5AL3MXPQYTVGjbVGYi8seOJw8S8VXvZQQQLs3ZQtT9JfAE0gvwEOjKLnYZ3oIOJy
         nvZqPCMvcRqv5ufhUhKabPmPqLsNLg6MehGgmwDkvIy13R5IyZDmdJiUY6+he28MApHc
         H75oNaLRxClGhtvmLbqujimYrEcPuppk0i2MCnUjJYKvEMDc3y9OvovKz5RX0V1t+OkL
         FVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Lw7vlLjr9WVZ+TDOesQXMZI349ziwVPBNRQr4tuKUcE=;
        b=MNm4a8QtH1H8+CGXg7qv1H3KW1QYVb55/TIW2CYzglfHAbKm0Mo5x7seYKuE3mnCh7
         UiuXmNa2qRa4LXKRn+Pz666CaBILVjlUQFZ7BJk6XjAQV5AfQ0B5u1sTndR2/0o2qJ9k
         6yB6cWkZJDiFxaD9X+WJZiq5m1+Nf0x4YJgo48+saglfWciX7c/UvTdTIoxiHjSfjKCS
         uDkGFOrTHAeJ+PRhWzk2zhda6k0jUQBaFYh2FYugjDa8yYYacS01hMwQtOJFRQBjRTr0
         NYdFSNpN3Y7qm6u278qr1iRS1FqTzLsh1s9/N5xvWcywOepPAK4jzs6jY6bMnJZFmDc7
         Ezmw==
X-Gm-Message-State: AKaTC01PYf1PCP33HCuuV/CUBaDViILy8vzJuDkAncbmPLspieb/bXHwn00KbUwuaZ3ivAWaY0VxN/gQGb/Zn9u6
X-Received: by 10.200.53.9 with SMTP id y9mr64211504qtb.176.1481223336371;
 Thu, 08 Dec 2016 10:55:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Thu, 8 Dec 2016 10:55:35 -0800 (PST)
In-Reply-To: <CACsJy8Bs78ywGq5p6yAFGi1KACAXFEeroyQSJye5-RL5gqOS+Q@mail.gmail.com>
References: <20161208014623.7588-1-sbeller@google.com> <20161208014623.7588-5-sbeller@google.com>
 <CACsJy8Bs78ywGq5p6yAFGi1KACAXFEeroyQSJye5-RL5gqOS+Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Dec 2016 10:55:35 -0800
Message-ID: <CAGZ79kYtEUvuTX09sJm3C0rG0-BrBz4bN0FCs6E5d2jHhtKN6w@mail.gmail.com>
Subject: Re: [PATCHv6 4/7] worktree: get worktrees from submodules
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 2:09 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Dec 8, 2016 at 8:46 AM, Stefan Beller <sbeller@google.com> wrote:
>>
>>         worktree = xcalloc(1, sizeof(*worktree));
>>         worktree->path = strbuf_detach(&worktree_path, NULL);
>> @@ -101,7 +101,8 @@ static struct worktree *get_main_worktree(void)
>
> All the good stuff is outside context lines again.. Somewhere between
> here we call add_head_info() which calls resolve_ref_unsafe(), which
> always uses data from current repo, not the submodule we want it to
> look at.

Unrelated side question: What would you think of "variable context line
configuration" ? e.g. you could configure it to include anything from
up that line
that is currently shown after the @@ which is the function signature line.

As to the add_head_info/resolve_ref_unsafe what impact does that have?
It produces a wrong head info but AFAICT it will never die(), such that for the
purposes of this series (which only wants to know if a submodule uses the
worktree feature) it should be fine.

It is highly misleading though for others to build upon this.
So maybe I'll only add the functionality internally in worktree.c
and document why the values are wrong, and only expose the
"int submodule_uses_worktrees(const char *path)" ?

>> @@ -209,6 +211,30 @@ struct worktree **get_worktrees(unsigned flags)
>>         return list;
>
> Right before this line is mark_current_worktree(), which in turn calls
> get_git_dir() and not suitable for peeking into another repository the
> way submodule code does. get_worktree_git_dir() called within that
> function shares the same problem.

It actually works correctly: "No submodule is the current worktree".


>
>>  }
>>
>> +struct worktree **get_worktrees(unsigned flags)
>> +{
>> +       return get_worktrees_internal(get_git_common_dir(), flags);
>> +}
>> +
>> +struct worktree **get_submodule_worktrees(const char *path, unsigned flags)
>> +{
>> +       char *submodule_gitdir;
>> +       struct strbuf sb = STRBUF_INIT;
>> +       struct worktree **ret;
>> +
>> +       submodule_gitdir = git_pathdup_submodule(path, "%s", "");
>> +       if (!submodule_gitdir)
>> +               return NULL;
>> +
>> +       /* the env would be set for the superproject */
>> +       get_common_dir_noenv(&sb, submodule_gitdir);
>
> Technically we need to read submodule_gitdir/.config and see if we can
> understand core.repositoryformatversion, or find any unrecognized
> extensions. But the problem is not specific to this code. And fixing
> it is no small task. But perhaps we could call a dummy
> validate_submodule_gitdir() here? Then when we implement that function
> for real, we don't have to search the entire code base to see where to
> put it.
>
> Kinda off-topic though. Feel free to ignore the above comment.

ok I'll add a TODO/emptyfunction for that.

Thanks for the review!
Stefan
