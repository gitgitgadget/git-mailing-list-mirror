Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47555C677F1
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 05:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBXFyN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 00:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXFyM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 00:54:12 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB2E5E868
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 21:54:11 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id w7so15054354oik.13
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 21:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677218050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RBUb5/+4oonLl/7KSyiAQnGloi1KktW2plvKyQKVzqg=;
        b=NO2SChFWK0ZW7cSc5E3Lzj3HUInB5eWFqivCU26CUZ/QtYa7j1mzwtPX25CjmKToT2
         0VEVRVS4cRUbLbKotdqugx9YS5e+2oh7CYxLuaS1cT9oKrDUC59R6sZ0zRhswv/ODYbq
         TyLLluJK4frHwtb76Xf44ZIZnZlgdT9Nm5+2PiK+T34+OPeZoHVIYAVMotPQlesHNpls
         ri8QT70mTt9QHtibhrWGrBwwi5XfYjofmERRoNMgsWCotsFJkxIqVRnY9P1Susmv+W8l
         eeY4KKkXsBIFj8WeIzCUWcZGiZozqOi/OH+sbvrRH9HNzgJ9swGpKjjpuDBMBEQN5HYs
         IpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677218050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBUb5/+4oonLl/7KSyiAQnGloi1KktW2plvKyQKVzqg=;
        b=EIh0oFHVJ8Lql0z/aM5ipx2E8+CicNdSky233sXGyJSue3n7CwSZSafQfNL87y6VkI
         zAVJK6OPxkz9oaY8EVmHQNe6gCKRcJ8dce4ZddJP3SOeyzM7c5+PlbGOyMVzFFNg//eN
         8Jg8WZpe3QK+3DxUAKeIgK3GeahsijeLXjBU3zfDTWqX7NdmOOT/05GXQ/2A9WNa+k21
         /Dua78WPINBWLRXkNt+ESXNiVOrC2odhN2dTzOKy7XufvKwEIjwZfW11l8siLoEcXND8
         nIbdybpurrQMifRwgIUbCMuaAuEd0Y58CaYD0SIGq/KI/PttBWTtc4DxXX3WbllRQMON
         ZikQ==
X-Gm-Message-State: AO0yUKWeMFb8nJBAALvWjBtWrBN4C61Fq30QCM/22f9VKWxWdA9XxPWm
        K6q0lZW55nVMeQwedqYi1zmQTm0Dwx82f5HbOnY=
X-Google-Smtp-Source: AK7set+4ZLgnjvKMJKn+S4KHIxDgCxb+S1dccVq4w43KvOBykNNara/ozf27QYCAE5So0V1mFgTjne4Rod2M0q0pTZE=
X-Received: by 2002:a54:4105:0:b0:378:80e1:cdf2 with SMTP id
 l5-20020a544105000000b0037880e1cdf2mr769462oic.5.1677218050214; Thu, 23 Feb
 2023 21:54:10 -0800 (PST)
MIME-Version: 1.0
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com> <16ff5069-0408-21cd-995c-8b47afb9810d@github.com>
In-Reply-To: <16ff5069-0408-21cd-995c-8b47afb9810d@github.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 23 Feb 2023 21:54:00 -0800
Message-ID: <CA+P7+xo02dGkjb5DwJ1Af_hoQ5HiuxASheZxoFz+r6B-6cQMug@mail.gmail.com>
Subject: Re: [PATCH 00/11] Clarify API for dir.[ch] and unpack-trees.[ch] --
 mark relevant fields as internal
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 7:29 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 2/23/2023 4:14 AM, Elijah Newren via GitGitGadget wrote:
> > This patch is primarily about moving internal-only fields within these two
> > structs into an embedded internal struct. Patch breakdown:
> >
> >  * Patches 1-3: Restructuring dir_struct
> >    * Patch 1: Splitting off internal-use-only fields
> >    * Patch 2: Add important usage note to avoid accidentally using
> >      deprecated API
> >    * Patch 3: Mark output-only fields as such
> >  * Patches 4-11: Restructuring unpack_trees_options
> >    * Patches 4-6: Preparatory cleanup
> >    * Patches 7-10: Splitting off internal-use-only fields
> >    * Patch 11: Mark output-only field as such
>
> > And after the changes:
> >
> > struct dir_struct {
> >     enum [...] flags;
> >     int nr; /* output only */
> >     int ignored_nr; /* output only */
> >     struct dir_entry **entries; /* output only */
> >     struct dir_entry **ignored; /* output only */
> >     struct untracked_cache *untracked;
> >     const char *exclude_per_dir; /* deprecated */
> >     struct dir_struct_internal {
> >         int alloc;
> >         int ignored_alloc;
> > #define EXC_CMDL 0
> > #define EXC_DIRS 1
> > #define EXC_FILE 2
> >         struct exclude_list_group exclude_list_group[3];
> >         struct exclude_stack *exclude_stack;
> >         struct path_pattern *pattern;
> >         struct strbuf basebuf;
> >         struct oid_stat ss_info_exclude;
> >         struct oid_stat ss_excludes_file;
> >         unsigned unmanaged_exclude_files;
> >         unsigned visited_paths;
> >         unsigned visited_directories;
> >     } internal;
> > };
>
> This does present a very clear structure to avoid callers being
> confused when writing these changes. It doesn't, however, present
> any way to guarantee that callers can't mutate this state.
>
> ...here I go on a side track thinking of an alternative...
>
> One way to track this would be to anonymously declare 'struct
> dir_struct_internal' in the header file and let 'struct dir_struct'
> contain a _pointer_ to the internal struct. The dir_struct_internal
> can then be defined inside the .c file, limiting its scope. (It
> must be a pointer in dir_struct or else callers would not be able
> to create a dir_struct without using a pointer and an initializer
> method.
>
> The major downside to this pointer approach is that the internal
> struct needs to be initialized within API calls and somehow cleared
> by all callers. The internal data could be initialized by the common
> initializers read_directory() or fill_directory(). There is a
> dir_clear() that _should_ be called by all callers (but I notice we
> are leaking the struct in at least one place in add-interactive.c,
> and likely others).
>
> This alternative adds some complexity to the structure, but
> provides compiler-level guarantees that these internals are not used
> outside of dir.c. I thought it worth exploring, even if we decide
> that the complexity is not worth those guarantees.
>

Another approach, if you don't mind structure pointer math is to
create two structures:

a) the external public one in the public header file

struct dir_entry {
  <public stuff>
};

b) a private structure in the source file:

struct dir_entry_private {
  struct dir_entry entry;
  <private stuff>
};

In the source file you also define a macro/function that can take a
pointer to dir_entry and get a pointer to dir_entry_private:

struct dir_entry_private *dir_entry_to_private(struct dir_entry *entry)
{
  return (struct dir_entry_private *)(<calculate the offset that entry
inside dir_entry_private is, then subtract that from entry pointer>))
}

In Linux kernel this is container_of, not sure if git has this already
defined and its a common pattern.

Then you can set the code up such that the only way to allocate a
dir_entry is to call some function in the dir code. If a new entry
needs to be allocated, implement an alloc function that has the full
private structure definition.

This way you don't need an extra field in the dir_entry struct at all,
but at the cost of requiring special allocations. It works great for
code where the only way to get a dir_entry is already some other
functions that would ensure the private version is setup correctly.

> The best news is that your existing series makes it easier to flip
> to the internal pointer method in the future, since we can shift
> the 'd->internal.member" uses into "d->internal->member" in a
> mechanical way. Thus, the change you are proposing does not lock us
> into this approach if we change our minds later.
>

I think either approach is good. I like container_of because I'm quite
used to it in low level kernel code and its a good way to provide
private/public split abstractions there. The private pointer variation
is also a common approach to this problem and I think it sounds like
we already use it in a few places. Its perhaps better for those
reasons.

> Thanks,
> -Stolee
