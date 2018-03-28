Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FB741F404
	for <e@80x24.org>; Wed, 28 Mar 2018 00:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeC1AnB (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 20:43:01 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:39995 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeC1AnA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 20:43:00 -0400
Received: by mail-yw0-f173.google.com with SMTP id r145so251824ywe.7
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 17:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y93yQNrQOH9hEbEmHzn2rVDoDjVa2byLZy0ZwJGFlz4=;
        b=hVZa/aXzMUk4B7dCLYXwP/xga/xdBKNHzdZ71BBa38Ll3FvH+N8ZPRPGYDDeP5Vzkh
         IwUMI3Uq74uetafeOq38yHWj4Or9tb3oMAYHNqK6ZjJVUHIVgA8laEb6DLZXyzKoFmeW
         NUU6+c3ytpUkJ5Ph9FZ516DxvnNb2J1c6vwyTsGQD8g4ptrGPzQ1Vk8IEzlJIe2gQNcW
         i7RrJfNpdqEUGvwVQPS2sm0DePpUmjFAeOOv6lQyYCmMGBZTHdwSEOVdEIvjPmsEJRo2
         pRB2Iq55/jHglpks5bAazQ53y9wFCxZG3To9l+f1uX8rqIr4jbvMzIIkUe2+dZAM+80k
         JnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y93yQNrQOH9hEbEmHzn2rVDoDjVa2byLZy0ZwJGFlz4=;
        b=Df2f8tZtGvCWAkKWiCP5J2wL6o/97ucHZib3xj/qoCECITf46Ohr27F3CkSLfisEtE
         QTZYnow5P4/nMCMMCdz8e4Q58BkLIFg9661Oj2H9QD0dMhHe9Xuyj/7fsUcRd6o1Vv8A
         9Pd2aEAJCmwK9efVW/OTiR/zpXzIb2iC+STT49lPEHt3sc1vJ55Xr30uCqZQVhTHhetD
         L7nqzUZdrigGK+ybTY72dnR4HI1j/XtL1hisMHVqZkkApgjcX5PrnwbCUCrA8aGt6sF8
         CChP8CDRuHL6+ZvQkocFI0N4Aj2usIQLUTFVVvYm9zn6yBeB3FRukccH9BoJkuYL8GD5
         EuRg==
X-Gm-Message-State: AElRT7FbTeI+9b9P174mLFIN7N0iJ2LP7SuQenOObTclDtRaqH8+OGh0
        9h4J7cfbfHmHmW0ZthmqUSf+DesWgxTFD67yZUUnF2eKrqY=
X-Google-Smtp-Source: AIpwx4/rrwS6XS5Ozd1//5M5HiuMF6QSOzoNWP4jDe7yvm+wDqFxQaWVqa6Km83BKc8n+vu27vezLxA5LfhLfAmBcT4=
X-Received: by 10.129.84.66 with SMTP id i63mr1022646ywb.340.1522197779400;
 Tue, 27 Mar 2018 17:42:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 27 Mar 2018 17:42:58
 -0700 (PDT)
In-Reply-To: <20180327170714.81b37f84cb4c544d76f34701@google.com>
References: <20180327213918.77851-1-sbeller@google.com> <20180327213918.77851-6-sbeller@google.com>
 <20180327170714.81b37f84cb4c544d76f34701@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Mar 2018 17:42:58 -0700
Message-ID: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
Subject: Re: [PATCH 5/5] submodule: fixup nested submodules after moving the submodule
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, seanwbehan@riseup.net,
        Brandon Williams <bmwill@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 5:07 PM, Jonathan Tan <jonathantanmy@google.com> wrote:

> s/submoduled/submodules

> s/superprojects/superproject's/

> s/and //
>
> s/force/forcing/

All wording fixed.

>> +     sub_path = sub_worktree + strlen(super_worktree) + 1;
>> +
>> +     if (repo_submodule_init(&subrepo, superproject, sub_path))
>> +             return;
>> +
>> +     repo_read_index(&subrepo);
>
> From the name of this function and its usage in
> connect_work_tree_and_git_dir(), I expected this function to just
> iterate through all the files in its workdir (which it is doing in the
> "for" loop below) and connect any nested submodules. Why does it need
> access to its superproject? (I would think that repo_init() would be
> sufficient here instead of repo_submodule_init().)

Testing validates your thinking (for now).

If we ever want to have good error reporting (see bmwills hint to
check for index corruption), we may want to have all the repos constructed
as submodules from the_repository, as then the error messages might
be better (e.g. in the future we could display the
"submodule nesting stack").

I'll remove the superproject argument for now.

>> +
>> +             strbuf_reset(&sub_wt);
>> +             strbuf_addf(&sub_wt, "%s/%s/.git", sub_worktree, sub->path);
>> +
>> +             strbuf_reset(&sub_gd);
>> +             strbuf_addf(&sub_gd, "%s/modules/%s", sub_gitdir, sub->name);
>> +
>> +             strbuf_setlen(&sub_wt, sub_wt.len - strlen("/.git"));
>> +
>> +             if (is_submodule_active(&subrepo, ce->name)) {
>> +                     connect_work_tree_and_git_dir(sub_wt.buf, sub_gd.buf, 0);
>> +                     connect_wt_gitdir_in_nested(sub_wt.buf, sub_gd.buf, &subrepo);
>
> The modifications of sub_wt and sub_gd should probably go here, since
> they are not used unless this "if" block is executed.

Thanks! I also cut out the setlen call by giving the correct format string.
(The code presented here is not very old, I just fired it off as soon as the
test passed)

>
>> +void connect_work_tree_and_git_dir(const char *work_tree_,
>> +                                const char *git_dir_,
>> +                                int recurse_into_nested)
>
> How is this function expected to be used? From what I see:
>  - if recurse_into_nested is 0, this works regardless of whether the
>    work_tree_ and git_dir_ is directly or indirectly a submodule of
>    the_repository
>  - if recurse_into_nested is 1, work_tree_ and git_dir_ must be directly
>    a submodule of the_repository (since it is referenced directly)
>
> This seems confusing - is this expected?

In the next revision of the series connect_wt_gitdir_in_nested
will no longer have a third argument for the repo, as we use repo_init.

That eases the handling a bit here.
