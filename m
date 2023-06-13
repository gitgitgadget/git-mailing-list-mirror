Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312F7EB64D8
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 18:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239369AbjFMSZ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 14:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbjFMSZz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 14:25:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F4319BC
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 11:25:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56ff697b86cso7665327b3.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686680753; x=1689272753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/wC7OxYLVlpkpjdnTvG5wk34KxCGp6Z9lpRvV4Sdi0k=;
        b=NS6raMSTq6IJwoyAF9hoVnhvJ2TgdaZvPKR8oGHBsG7p7qr+H2EibaIET9kP5OiWE+
         QzjsuCR1sL/255Czh22R6L8FLF3QEv0lObiVQ6j9EN++Gl9jxwMDdS1my1AFBcY6YX/x
         rl5IosMS6R2fKjO9yFO7O/dalyCEwR0bRt9sZXIF1E9Ujg0vvScMVYfXMER+/tQhpV2X
         GPQZvpxeym/pKmCwpYzaCIUIsEYxGjS4JuMzI1/3arqfMW/WlPnJIe02sc9hWU3IdqVY
         Ef5s+UkxgaNkiFeCFRSr6qHW9IvdD3+7a+yPkYjAOzeZILJfsJXrtut6FR5ksiYNKenT
         hYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686680753; x=1689272753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wC7OxYLVlpkpjdnTvG5wk34KxCGp6Z9lpRvV4Sdi0k=;
        b=YvvQ5/TJdwxpVdSOiDVSbC5e4kVPRdX+Nnm3SMcihHrDa/237Q9a+r4LcfWIb9PaVv
         fX57aCZD+iYz0QEB26VEfKTiNeGNQywtHi0C+JsIuP3FMnBWA1tvZ97+dInnkw67pNT/
         aCHcB53Nm2KVqJwfgfnDSAsCnFNXJLr7s1ZwGbaYEinKopfGv6nxd56m1p/aeTLnKe4X
         otpO9ziyr7OADkozTqj/VWwzFKzmOs6fJ8BJxLjmtqlBPUyn6QmNIMvL5+rnMdzLLP28
         2QUHTxWPuXIqv3wM/81afcp2NSmqVFTyjUX9YWgIv8Rd2qAYsdPfMRAdWzoiIg1mtzMP
         59lA==
X-Gm-Message-State: AC+VfDzTqSMesCD/zXHJlAsUOCij8j6t+YVu5wSNEVxaPzGqnodOsnm9
        q52FaP3DcfAWba6U5Y5ixIYH7OtARwF27Q==
X-Google-Smtp-Source: ACHHUZ6fQ9w93JBMabetgswF7CQkv12yPPJuJsHgnZMmbHeSJ9Zkp7NTQ8UqEZioO8yAq4lFapqfjSjSW+xeEg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:4102:0:b0:56d:791:d1a4 with SMTP id
 o2-20020a814102000000b0056d0791d1a4mr1237034ywa.7.1686680752898; Tue, 13 Jun
 2023 11:25:52 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:25:51 -0700
In-Reply-To: <9fb6d7b1-00b6-93ee-efec-9dd0ab91a66d@github.com>
Mime-Version: 1.0
References: <kl6lr0qgfmzo.fsf@chooglen-macbookpro.roam.corp.google.com>
 <20230612230453.70864-1-chooglen@google.com> <9fb6d7b1-00b6-93ee-efec-9dd0ab91a66d@github.com>
Message-ID: <kl6llegnfccw.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] setup: copy repository_format using helper
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        derrickstolee@github.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

>> - All of them 'copy' .partial_clone. Most perform a shallow copy of the
>>   pointer, then set the .partial_clone = NULL so that it doesn't get
>>   cleared by clear_repository_format(). However,
>>   check_repository_format() copies the string deeply because the
>>   repository_format is sometimes read back (it is an "out" parameter).
>>   To accomodate both shallow copying and deep copying, toggle this
>>   behavior using the "modify_fmt_ok" parameter.
>
> Do you have a specific example of this happening? I see two uses of
> 'check_repository_format()' in the codebase:
>
> 1. in 'enter_repo()' ('path.c')
> 2. in 'init_db()' ('init-db.c')
>
> The first one calls 'check_repository_format()' with 'NULL', which causes
> the function to create a temporary 'struct repository_format' that is then
> discarded at the end of the function - no need to worry about the value
> being cleared there.
>
> The second one does call 'check_repository_format()' with a 'struct
> repository_format' instance, but the 'partial_clone' field field is not
> accessed again after that. The only subsequent usages of the 'repo_fmt'
> variable in 'init_db()' are:
>
> - in 'validate_hash_algorithm()', where only the 'version' and 'hash_algo'
>   fields are accessed.
> - in 'create_default_files()', where only 'hash_algo' is accessed.
>
> So, shouldn't it be safe to shallow-copy-and-NULL? But as I noted earlier
> [1], if you do that it'll make the name 'check_repository_format()' a bit
> misleading (since it's actually modifying its arg in place). So, if you
> update to always shallow copy, 'check_repository_format()' should be renamed
> to reflect its side effects.

My understanding of check_repository_format() is that it serves double
duty of doing a) setup of the_repository and b) populating an "out"
parameter with the appropriate values. IMO a) is the side effect that
could warrant the rename, and b) is the expected, "read-only" use case.
From that perspective, doing a shallow copy here isn't really
introducing a weird side-effect (because the arg to an "out" parameter
should be zero-ed out to begin with), but it's returning a 'wrong'
value. You're right that it's safe because the NULL-ed value isn't read
back right now, but it's not any good if this function gains more
callers.

Your point about not having side effects in check_*() is a good one
though, and I'm starting to feel doubtful that we should be doing setup
there either....

>> If you're comfortable with it, I would prefer for you to squash this
>> into your patches so that we don't just end up changing the same few
>> lines. If not, I'll Reviewed-by your patches (if I don't find any other
>> concerns on a re-read) and send this as a 1-patch on top.
>
> Reading through the commit message & patch, I'm still not convinced this
> refactor is a good idea - to me, it doesn't leave the code in a clearly
> better state. If you feel strongly that it does, though, I'm happy to leave
> it to others to review/decide but I would prefer that you keep it a separate
> patch submission on top.

Okay. Given how weird check_repository_format() and
discover_git_directory() are, I think we haven't done enough
investigation to properly consolidate this logic, and doing that
introduces quite a lot of scope creep. It feels very unsatisfactory that
we are propagating a pattern that is suspicious in some places and
outright wrong in others instead of cleaning up as we go and leaving it
in a better state for future authors, but this series does leave some
_other_ parts in a better state (removing the global), and I think it's
still a net positive.

The helper function might not be a good idea yet, but I'm convinced that
removing the setup from discover_git_directory() is a good idea. I think
this series would be in a better state if we get rid of the wrong
pattern instead of extending it. Unfortunately, I forgot to include that
change in the patch I sent (ugh) but here's a patch that _just_ includes
the discover_git_directory() change that I hope you can squash into your
series (and you can use whatever bits of my commit message you see fit).

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

  diff --git a/setup.c b/setup.c
  index 33ce58676f..b172ffd48a 100644
  --- a/setup.c
  +++ b/setup.c
  @@ -1422,14 +1422,6 @@ int discover_git_directory(struct strbuf *commondir,
      return -1;
    }

  -	the_repository->repository_format_worktree_config =
  -		candidate.worktree_config;
  -
  -	/* take ownership of candidate.partial_clone */
  -	the_repository->repository_format_partial_clone =
  -		candidate.partial_clone;
  -	candidate.partial_clone = NULL;
  -
    clear_repository_format(&candidate);
    return 0;
  }

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

You can see that this patch based on top of yours passes CI

  https://github.com/git/git/commit/9469fe3a6b0efbe89d26ef096a2eebabea59c55f
  https://github.com/chooglen/git/actions/runs/5258672473

> I think you may be missing changes to 'discover_git_directory()'? Like I
> mentioned above, though, if you don't think 'discover_git_directory()' needs
> to set up 'the_repository', then those assignments should just be removed
> (not replaced with 'setup_repository_from_format()').

Ah sorry, yes they were meant to be removed. I somehow missed those as I
was preparing the patch.

