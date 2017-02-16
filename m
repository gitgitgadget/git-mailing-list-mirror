Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2074D1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 21:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933593AbdBPVQh (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 16:16:37 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:36357 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbdBPVQg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 16:16:36 -0500
Received: by mail-it0-f48.google.com with SMTP id h10so5576488ith.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 13:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=htuiXAXmOX08xtAoBGG4B4TsplxhunIw33ln/E2iCUA=;
        b=Gd9eMi4VQGt2W/LKyzABIsRn7tt2jX3YFYgahNltWkrhHRKgNaWMdT+q6K1krvvx7S
         KGpZoUOQS9h2geVl2DOC95mpDijupiZo4JtR1Cr8E93rYbIgToYD/FyPoxutYP4aJWcz
         +WJ4Phe2aU+K4j40+PEfv9qPsxUm6hvxwu6PlNo1eGV1LtNNjOqhTOOpuWv32QIH6HUL
         W5WVX4aONbhv8fPfFEuONpvHqMuc+dK3R2Nup+suabXdkYo5pdFDhGMTZRAzvJkNZ5mc
         roDgRTGl/IAwk91spK9ils5YGl6d3UacY4TxZ1hxejtffMnQuav9EkvqKQzbcNb/alsa
         SVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=htuiXAXmOX08xtAoBGG4B4TsplxhunIw33ln/E2iCUA=;
        b=qOr9v9Bb3QFGpUxRUpaTIh/fZHdPrW54SycdXrbcOFWZe5iAbWKGy/NBohhL+kRjbP
         tlv12F6ZYsUBFoVWCYsfKmGnZ8SRt6752PsvAKMBaSUbqnhd2e1MrjDZzCKaNwlNXmVe
         P116ig9OkQko3+szevDRPSMA9qThMKmdBkyAX0lT8RyFzhUZNaoXyJY9hP4Y3/G+U9Sd
         cDDZmbHF0fhkigChN0SArq16IHTMA+pgUvO50jolwUz2IJcBdrmLimby0ZcX6oxwNziy
         pdytkp9VR2DouqmfMcYZsylruIKXjFvd4yUyHXHtRGNyh9fksSdUGxXEAkIBWStsijnA
         5LYg==
X-Gm-Message-State: AMke39n8SEokUUJm+F8Te2Oro896egSlxBtOjCh58aM2ycFRVg5jNUqNvgbKqFBzgTItdDOfqOGd3cqnKmaTv7Sm
X-Received: by 10.107.16.14 with SMTP id y14mr4021525ioi.164.1487279795075;
 Thu, 16 Feb 2017 13:16:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Thu, 16 Feb 2017 13:16:34 -0800 (PST)
In-Reply-To: <xmqqh93tx3f3.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-6-sbeller@google.com> <xmqqh93tx3f3.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 16 Feb 2017 13:16:34 -0800
Message-ID: <CAGZ79kbMmPQ1ZxtdaoFof36g1An-xsAx85etiskirJfY4tGHaQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] connect_work_tree_and_git_dir: safely create
 leading directories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 12:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> In a later patch we'll use connect_work_tree_and_git_dir when the
>> directory for the gitlink file doesn't exist yet. Safely create
>> the directory first.
>>
>> One of the two users of 'connect_work_tree_and_git_dir' already checked
>> for the directory being there, so we can loose that check.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  dir.c       | 32 +++++++++++++++++++++-----------
>>  submodule.c | 11 ++---------
>>  2 files changed, 23 insertions(+), 20 deletions(-)
>>
>> diff --git a/dir.c b/dir.c
>> index 4541f9e146..6f52af7abb 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -2728,23 +2728,33 @@ void untracked_cache_add_to_index(struct index_state *istate,
>>  /* Update gitfile and core.worktree setting to connect work tree and git dir */
>>  void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
>>  {
>> -     struct strbuf file_name = STRBUF_INIT;
>> +     struct strbuf gitfile_sb = STRBUF_INIT;
>> +     struct strbuf cfg_sb = STRBUF_INIT;
>>       struct strbuf rel_path = STRBUF_INIT;
>> -     char *git_dir = real_pathdup(git_dir_);
>> -     char *work_tree = real_pathdup(work_tree_);
>> +     char *git_dir, *work_tree;
>>
>> -     /* Update gitfile */
>> -     strbuf_addf(&file_name, "%s/.git", work_tree);
>> -     write_file(file_name.buf, "gitdir: %s",
>> -                relative_path(git_dir, work_tree, &rel_path));
>> +     /* Prepare .git file */
>> +     strbuf_addf(&gitfile_sb, "%s/.git", work_tree_);
>> +     if (safe_create_leading_directories_const(gitfile_sb.buf))
>> +             die(_("could not create directories for %s"), gitfile_sb.buf);
>> +
>> +     /* Prepare config file */
>> +     strbuf_addf(&cfg_sb, "%s/config", git_dir_);
>> +     if (safe_create_leading_directories_const(cfg_sb.buf))
>> +             die(_("could not create directories for %s"), cfg_sb.buf);
>>
>> +     git_dir = real_pathdup(git_dir_);
>> +     work_tree = real_pathdup(work_tree_);
>> +
>> +     /* Write .git file */
>> +     write_file(gitfile_sb.buf, "gitdir: %s",
>> +                relative_path(git_dir, work_tree, &rel_path));
>
> The above does somewhat more than advertised and was a bit hard to
> grok.  Initially I thought the reason why pathdup()s were delayed
> was perhaps because you pathdup() something potentially different
> from the given parameter to the function (i.e. new code before
> pathdup() may tweak what is pathdup()ed).
>
> But that is not what is happening.  I suspect that you did this to
> avoid leaking allocated memory when the code calls die().

That is not what is happening, either.
AFAICT real_pathdup resolves a path to its real path. But the path
*must* exist already (except the very last part, i.e. the file name).
So the SCLD must come before the real_pathdup, which has to come
before its consumers, which are the relative_path calls for write_file
as well  as git_config_set_in_file.

So structurally we need to:

1a) construct $GIT_DIR/modules/<name>/config
1b) SCLD 1a)
1c) get absolute path of 1a)

2a) construct <submodule path>/.git file
2b) SCLD 2a)
2c) get absolute path of 2a)

3) compute relative path of 1c and 2c
    both ways, write to appropriate places.

I chose to structure it as:

1a
1b
2a
2b

1c
2c
3

because the a/b steps seemed very related and the order is valid.


>
> If the code was written like so from the beginning, I do not see a
> reason to move the pathdup() up to deliberately make it leak [*1*].
> But as a part of this change, I found it distracting and getting in
> the way of understanding the change.  If you really care, it is
> nicer to do it to reviewers as a separate preparatory clean-up step,
> or follow-up standalone clean-up patch after the series settles.

I considered doing it in multiple patches as we have different things
going on here:
1) as the commit claims have SCLD in connect_work_tree_and_git_dir
2) keep the dependencies of SCLD and real_pathdup in order.  C.f.
  the deleted lines of code in submodule.c

> It is a good thing to do to make sure git_dir_ exists and it should
> be mentioned in the log message.  Adding "Do the same for the place
> where the per-repo config file is created". at the end of the first
> paragraph should be sufficient.
>

will do.

Thanks for thorough review!
Stefan
