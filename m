Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28415C64ED8
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 20:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjBWUbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 15:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBWUbp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 15:31:45 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4320F5AB43
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 12:31:44 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f18so15311592lfa.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 12:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w27eieeXs9mXAbmk8+LY5Gd/1WeC0J2idgSVUFzHFDQ=;
        b=CDgpXfELX878zRixTGXQuzBYF4Enql3wS0xVVSwExbrnp5la5ORy78jZWc6xVh6+GO
         uEb7FJ8p9Ml0k35/ZaKMT6dkslHaNDguck/VW7yeE6+9+/CRr6gg0+em5By9SPEVMUYZ
         j4ngOz2qm02VqosqVhTobx9vg2gd0ymsU36LXs+1mHagnLmyI1NI0C1j3lT7VkHsTt/+
         YxSRLe3IRiSANbeAT4nnwcKlGz0s7hgwjKr94Zu6l3p826Y0DEuMqmbE8bIX3uVP2+Mb
         LRENKbUPx141Vhmw9Ul8PJ13gPLyh8dkJc++vuuiCyz/UdjYyeUTq/VbPKJ8Acr92TTv
         YOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w27eieeXs9mXAbmk8+LY5Gd/1WeC0J2idgSVUFzHFDQ=;
        b=cIhFW5MKP2khC3Dg71+rtQlQuLJSVL9FtsX49rK/RscyCvoRIJRLCMI57rlbD9zTBW
         pB+wunAc7B6Bdu98/P92CnJAHTbCLQhlMZo72aSqO87HyXlBiW2AWt7nJ5r3jeyeBX1W
         9SUvzY9TXa1TnNdaxBA2mICOFmX6590/g6ot2EsCISqrrC0VXIrwCnNixYkDv6gJLZfI
         XULd7PKkY2FFPl49V9uD/kBj0ijYVMqnaHx4AdHbtKYhbKfVekoLM2YQQnZaDo8+1EuL
         l3dDlaqVdXJmuDBlFL/+sz1redJh3jgOa549J5NSZDiKUb4M2d5nYjw15cF2WUBMtgoL
         /VDQ==
X-Gm-Message-State: AO0yUKUzjJWlI9/2yZ/sdNJl0M0qzFvODenf1/w1ykw18dN/M99KcAa7
        Ruff0teGbmBP/j5lMeaRkX7dAuOl6cHWp0IKZByIBxvpnwQk1Q==
X-Google-Smtp-Source: AK7set9ty5OPiQG64d36mmjcwOAB6UVfR3/sPABOL5ly2GGJwf7H2FGhN3lC6HnCyswfE5OYhfdvTi4DMC20ORAQj3w=
X-Received: by 2002:ac2:5206:0:b0:4db:3501:5d66 with SMTP id
 a6-20020ac25206000000b004db35015d66mr4202446lfl.2.1677184302394; Thu, 23 Feb
 2023 12:31:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com> <16ff5069-0408-21cd-995c-8b47afb9810d@github.com>
In-Reply-To: <16ff5069-0408-21cd-995c-8b47afb9810d@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 23 Feb 2023 12:31:29 -0800
Message-ID: <CABPp-BF06RLazEjNfe0E=arM+q=dw9r478Q1ZLMeY-OxUf2CLg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Clarify API for dir.[ch] and unpack-trees.[ch] --
 mark relevant fields as internal
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2023 at 7:18 AM Derrick Stolee <derrickstolee@github.com> w=
rote:
>
> On 2/23/2023 4:14 AM, Elijah Newren via GitGitGadget wrote:
> > This patch is primarily about moving internal-only fields within these =
two
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

In addition to the guarantees that others won't muck with those
fields, such an approach would also buy us the following:

  * The implementation can change and internal data structures be
modified/extended/appended-to, without requiring recompiling all files
that depend upon our header.
  * Related to the last point, the ABI doesn't change when the
implementation and internal data structures change.  Might be helpful
for libification efforts.

For all three of these reasons, I pursued this alternate strategy you
bring up in merge-recursive and merge-ort (they both use a "struct
merge_options_internal *priv" and then define _very_ different "struct
merge_options_iternal" in their respective C files).  I thought about
using this strategy you suggest here, but was worried at the time I
created this patch that it might create more friction for =C3=86var who was
pushing his struct initialization work and memory leak cleanups in the
same area heavily at the time (and back then we had a few long threads
back and forth because our work was overlapping and clashing
slightly).  But I figured that doing at least this much was good,
because of what you point out:

> The best news is that your existing series makes it easier to flip
> to the internal pointer method in the future, since we can shift
> the 'd->internal.member" uses into "d->internal->member" in a
> mechanical way. Thus, the change you are proposing does not lock us
> into this approach if we change our minds later.
