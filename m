Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FF911FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 23:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932140AbcLIXKW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 18:10:22 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:33315 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbcLIXKV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 18:10:21 -0500
Received: by mail-qt0-f170.google.com with SMTP id p16so29999417qta.0
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 15:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=klEW4Zhq1uak6nwApHOOnvSGjzcJbzg4F+Hv2UGzCmw=;
        b=azIrDbNrmMPk+2m3hDiLdHcTOzyw/MtAhjTiur5LkpDzzVgPSc17HUxHs+fA4evk1a
         57dHHhOFJpMbTCl+GYxEh6bn7cBUux3D2GTPySnpfNM91bgEdZowz1LB7vz8L9HZ+ZmO
         HX1xI9py7djUzgXw7q8QKRwouQSsmTI5dqOoZQgzvzg7C9nwQfucFaCLBGOKQlq3OCbb
         Sxsj/F9+WxMjWUfKyAOGvEmBEhAE7eL/Ap7q1EHedhJQ0/CtxYi0ZGy42eOPJsbf8dm7
         rvYXsFrbAWbZ6DhNK0lIKux7VYBTxhT2MTsfaNMFXIXb/RzLfPt1VrZnWh0SZDyEp/ql
         D8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=klEW4Zhq1uak6nwApHOOnvSGjzcJbzg4F+Hv2UGzCmw=;
        b=C5ULB+snY8Pk6hrvyF0Kmp44CVFdMhBwnhUhN9FpZpZk54C2g9ALsp5aVThzOPsJ2W
         6SJUtSzA22T/iinVhwLGN7oZE9evn9RMtSxHxE5QQH/oJqy2ejqun9xpIB4tAmt/XiF1
         d6y/2gIfLkls2Ny2EjbArcHAGJM/VGIHilWKtRt02dTzVaXI9akjstp/nK+MAg8LZvHl
         RuItJFg/NbyWuhrBnOObDFdT021mjgudP9SgctWIhGp86BiGIK1qGk6e8V5fIK3cieW3
         +Q85v/FWqKWn6rrt0zUyXwLbUcykH58Vifcd+1v/MHAqGLqnYVMzhjLkoVuR+Ddgwn//
         Lohw==
X-Gm-Message-State: AKaTC01aScPdHvYeDrGgwIcwMLCwObQUgaI3lwChrswp48DtRuYDaKhRIeUJBFMQk5sK7MtSS/iB2Ea6WsPi46wb
X-Received: by 10.200.58.65 with SMTP id w59mr69896572qte.54.1481325020231;
 Fri, 09 Dec 2016 15:10:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Fri, 9 Dec 2016 15:10:19 -0800 (PST)
In-Reply-To: <20161209230029.GF88637@google.com>
References: <20161208014623.7588-1-sbeller@google.com> <20161208014623.7588-5-sbeller@google.com>
 <CACsJy8Bs78ywGq5p6yAFGi1KACAXFEeroyQSJye5-RL5gqOS+Q@mail.gmail.com>
 <CAGZ79kYtEUvuTX09sJm3C0rG0-BrBz4bN0FCs6E5d2jHhtKN6w@mail.gmail.com> <20161209230029.GF88637@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Dec 2016 15:10:19 -0800
Message-ID: <CAGZ79kao0Ei_M8SERz0M8C+dbe=NeqRWFakcPd4ogAx3fk1Dtg@mail.gmail.com>
Subject: Re: [PATCHv6 4/7] worktree: get worktrees from submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 3:00 PM, Brandon Williams <bmwill@google.com> wrote:
> On 12/08, Stefan Beller wrote:
>> On Thu, Dec 8, 2016 at 2:09 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> > On Thu, Dec 8, 2016 at 8:46 AM, Stefan Beller <sbeller@google.com> wrote:
>> >>
>> >>         worktree = xcalloc(1, sizeof(*worktree));
>> >>         worktree->path = strbuf_detach(&worktree_path, NULL);
>> >> @@ -101,7 +101,8 @@ static struct worktree *get_main_worktree(void)
>> >
>> > All the good stuff is outside context lines again.. Somewhere between
>> > here we call add_head_info() which calls resolve_ref_unsafe(), which
>> > always uses data from current repo, not the submodule we want it to
>> > look at.
>>
>> Unrelated side question: What would you think of "variable context line
>> configuration" ? e.g. you could configure it to include anything from
>> up that line
>> that is currently shown after the @@ which is the function signature line.
>>
>> As to the add_head_info/resolve_ref_unsafe what impact does that have?
>> It produces a wrong head info but AFAICT it will never die(), such that for the
>> purposes of this series (which only wants to know if a submodule uses the
>> worktree feature) it should be fine.
>>
>> It is highly misleading though for others to build upon this.
>> So maybe I'll only add the functionality internally in worktree.c
>> and document why the values are wrong, and only expose the
>> "int submodule_uses_worktrees(const char *path)" ?
>>
>> >> @@ -209,6 +211,30 @@ struct worktree **get_worktrees(unsigned flags)
>> >>         return list;
>> >
>> > Right before this line is mark_current_worktree(), which in turn calls
>> > get_git_dir() and not suitable for peeking into another repository the
>> > way submodule code does. get_worktree_git_dir() called within that
>> > function shares the same problem.
>>
>> It actually works correctly: "No submodule is the current worktree".
>>
>>
>> >
>> >>  }
>> >>
>> >> +struct worktree **get_worktrees(unsigned flags)
>> >> +{
>> >> +       return get_worktrees_internal(get_git_common_dir(), flags);
>> >> +}
>> >> +
>> >> +struct worktree **get_submodule_worktrees(const char *path, unsigned flags)
>> >> +{
>> >> +       char *submodule_gitdir;
>> >> +       struct strbuf sb = STRBUF_INIT;
>> >> +       struct worktree **ret;
>> >> +
>> >> +       submodule_gitdir = git_pathdup_submodule(path, "%s", "");
>> >> +       if (!submodule_gitdir)
>> >> +               return NULL;
>> >> +
>> >> +       /* the env would be set for the superproject */
>> >> +       get_common_dir_noenv(&sb, submodule_gitdir);
>> >
>> > Technically we need to read submodule_gitdir/.config and see if we can
>> > understand core.repositoryformatversion, or find any unrecognized
>> > extensions. But the problem is not specific to this code. And fixing
>> > it is no small task. But perhaps we could call a dummy
>> > validate_submodule_gitdir() here? Then when we implement that function
>> > for real, we don't have to search the entire code base to see where to
>> > put it.
>> >
>> > Kinda off-topic though. Feel free to ignore the above comment.
>>
>> ok I'll add a TODO/emptyfunction for that.
>
> So is using resolve_gitdir not ok when trying to see if a submodule has
> a gitdir at a particular path?
>

Well it depends on the question that you are trying to answer:

Assume we introduce a new repository format in Git version 3.0.
By some means the submodule repository is converted to the new format,
but the superproject is not. (e.g. it is auto migrating repositories that have
a lot of large blobs/files)

Now for some reason you use the older git 2.X in the superproject.
(e.g. the code is on a shared network mount, or git3 has a bug, or ...)

Then the code above may tell that the submodule doesn't use worktrees
(as we cannot make any assumptions on the new crazy repository format),
but in fact it is, so in this case we technically we would need to:

1) read the config
2) check the repository format version (if larger than we know of,
   assume the worst or just die?)

As the function in this patch is used for safe guarding we may want to be
extra cautious, another function that is using resolve_gitdir may have other
assumptions on what is ok even for newer repository formats.
