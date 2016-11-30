Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541491FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 18:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbcK3SEz (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 13:04:55 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:33510 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753106AbcK3SEy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 13:04:54 -0500
Received: by mail-qt0-f171.google.com with SMTP id p16so195414836qta.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 10:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OOjLbZQPHgoq7teCNBFkRrS1aaYJne+QdwdweEz9Aj0=;
        b=SRcC24kSA/FxivklpYLqP2RAzrX2yuFXPHs4XUDE1fYdIg/6v/GRY++RzMfOI1MvXc
         MYwtAbLFhR+E0HlR+KvoO1A96O82qd0QN66sQt6OFroOBYm2kCK0PM2+UNDbxG712VVa
         JkigV0vNGDkNYaQNlGAzlZr45dK3QPqgcHY+DnuCl53xCmyqXR0zsJOKp91VHX+U5TE1
         P2hrN4pU6gFi6on2PUEsTxtZxhXd6Th/29AKGRoUHDO5L7E6iJYMZfzVHr5il2dduhmH
         mmCI0jqHFIz2BF1dgSPtbWVz3KrwF4Wx80WszB84/JHuNAAhK1QrkKrzVCUaJCo5YFrq
         Js0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OOjLbZQPHgoq7teCNBFkRrS1aaYJne+QdwdweEz9Aj0=;
        b=Lgrr9m0P4VwamJL2XiObb+dU7r58AZBu506OZTdXAYMHqt4XrycU6FJbQ4S70tsQTe
         KdUz7KfRRuYEd7RjQA9Ofx2DP5LMm93NUXVCXK+qUHDxAYWWW0UIcq4u4Eis3ndEWlWh
         Gu+i0vn2geyY2OSCVLH3+UzETRJNM16HGJR6QltGBzDLQ0aCq/k4rPASpe0F+NCkePv1
         Nx0s69+sI3g1I0m/abc5N6gpxsVzHDIsZe5wBpmCk+ee1xBeCfyPriBgskie6pBBDJbi
         t+O87nymjF4+mB+OIX3O3+GCL2Y92/Hl0VocC064kSUYfUnBgpYMmaOt/9EJhnY6UP8m
         Ui4g==
X-Gm-Message-State: AKaTC02EN0HtQj0sWloaJ0HFUDu//h1uiLZDep6ESS/GImTp16nMT4k/fi9opK9KyVIyhLBrq3QOybbiAJH8aX9n
X-Received: by 10.200.53.9 with SMTP id y9mr29109601qtb.176.1480529092877;
 Wed, 30 Nov 2016 10:04:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 30 Nov 2016 10:04:52 -0800 (PST)
In-Reply-To: <CACsJy8Ce3Oa-xJ4BwgRRy6neM=Jxkfqq7yboHZDXLDG2tu9GzQ@mail.gmail.com>
References: <20161122192235.6055-1-sbeller@google.com> <20161122192235.6055-5-sbeller@google.com>
 <CACsJy8Ce3Oa-xJ4BwgRRy6neM=Jxkfqq7yboHZDXLDG2tu9GzQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 Nov 2016 10:04:52 -0800
Message-ID: <CAGZ79kbvey_f8+R16yYT_qsF0RErOh8own8n-RRApTM0dS-+ag@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] submodule: add embed-git-dir function
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 3:14 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Nov 23, 2016 at 2:22 AM, Stefan Beller <sbeller@google.com> wrote:
>> +/*
>> + * Migrate the given submodule (and all its submodules recursively) from
>> + * having its git directory within the working tree to the git dir nested
>> + * in its superprojects git dir under modules/.
>> + */
>> +void migrate_submodule_gitdir(const char *prefix, const char *path,
>> +                             int recursive)
>
> Submodules and worktrees seem to have many things in common.

Yes. :)

> The first
> one is this. "git worktree move" on a worktree that contains
> submodules .git also benefits from something like this [1].

That patch is a sensible approach. :)
(By checking all files to not be submodules a worktree would not run
into problems like
a127331cd81, mv: allow moving nested submodules)

> I suggest
> you move this function to some neutral place and maybe rename it to
> relocate_gitdir() or something.

ok tell me where this neutral place is found?
(I'd prefer to not clobber it into cache.h *the* most neutral place in git)
Maybe dir.{c,h} ?

>
> It probably should take a bit flag instead of "recursive" here. One
> thing I would need is the ability to tell this function "I have moved
> all these .git dirs already (because I move whole worktree in one
> operation), here are the old and new locations of them, fix them up!".
> In other words, no rename() could be optionally skipped.

In the non-main working trees you'd also have a .git file linking
to the actual git dir and you'd only have to fix them up instead of moving.


>
> [1] https://public-inbox.org/git/20161128094319.16176-11-pclouds@gmail.com/T/#u
>
>> +{
>> +       char *old_git_dir;
>> +       const char *new_git_dir;
>> +       const struct submodule *sub;
>> +
>> +       old_git_dir = xstrfmt("%s/.git", path);
>> +       if (read_gitfile(old_git_dir))
>> +               /* If it is an actual gitfile, it doesn't need migration. */
>> +               goto out;
>> +
>> +       sub = submodule_from_path(null_sha1, path);
>> +       if (!sub)
>> +               die(_("Could not lookup name for submodule '%s'"),
>> +                     path);
>> +
>> +       new_git_dir = git_common_path("modules/%s", sub->name);
>
> Why doesn't git_path() work here? This would make "modules" shared
> between worktrees, even though it's not normally. That inconsistency
> could cause trouble.

I thought that was a long term goal?
(I actually think about reviving the series you sent out a few weeks ago
to make worktree and submodules work well together)

So for that we'd want to have at least the object store shared across all
worktrees.

>
>> +       if (safe_create_leading_directories_const(new_git_dir) < 0)
>> +               die(_("could not create directory '%s'"), new_git_dir);
>> +
>> +       if (!prefix)
>> +               prefix = get_super_prefix();
>> +       printf("Migrating git directory of %s%s from\n'%s' to\n'%s'\n",
>> +               prefix ? prefix : "", path,
>> +               real_path(old_git_dir), new_git_dir);
>> +
>> +       if (rename(old_git_dir, new_git_dir) < 0)
>> +               die_errno(_("Could not migrate git directory from '%s' to '%s'"),
>> +                       old_git_dir, new_git_dir);
>> +
>> +       connect_work_tree_and_git_dir(path, new_git_dir);
>
> Another thing in common is, both submodules and worktrees use some
> form of textual symlinks. You need to fix up some here. But if this
> submodule has multiple worktreee, there may be some "symlinks" in
> .git/worktrees which would need fixing up as well.

We could signal that via one of the flag bits?
(e.g. FIXUP_WORKTREE_SYMLINKS )

>
> You don't have to do the fix up thing right away, but I think we
> should at least make sure we leave no dangling links behind (by
> die()ing early if we find a .git dir we can't handle yet)
> --
> Duy
