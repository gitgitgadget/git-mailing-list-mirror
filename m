Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFACC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 20:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbhLGUui (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 15:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbhLGUui (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 15:50:38 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370EEC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 12:47:07 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d10so1136089lfg.6
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 12:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7W4q3ZJQn0AFcsz+4yKGptggGtHot5+f584UokrUKIo=;
        b=Ng0yxIC2nPPEnP51WAIZfH2JWL4FGILyaczIFX7bU3uFd5jns6IifgYEQpPb+nd3YU
         ONgLNrg8duv9VN+VIFyOhHbcTFAIyL6DzEauw4aay1E1FL1ydsd+pEY1qbXAF9Cn4XVr
         iO355Wx8koZPzYsHaNNkucfzQ2EXCobvSN2eXG1OgZCcqGLyvR0t3/FFI5HAliIYNBZJ
         6pQeco3HCg1uCwZ3DZ8/Ji8/1rq7KYuLy8PP+KgpcAOKitXkVD6cegGjd/CHcXyLW7Wy
         7A786fNoY+pQCzd2K/owYzs4l+YiM0uQs9Ge88Qo3G6EPFbZZnGc1kgWFX+xejI7ENbT
         6Phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7W4q3ZJQn0AFcsz+4yKGptggGtHot5+f584UokrUKIo=;
        b=JLkYLzr3H5c8mV3+EhJHjtyfMQ1vZm+R8qlg0RsCaf6lvcJYUWetwC6jB4CDiAk7m5
         k98fBiS1WnMHOHhCs7ijMgu1VYfIVlAWVT9Smoc+1hCFPGZTlcWDfjqp1RnbM7cMsHBY
         47i8PmBw8FBLWFMCzUbma5478mHB1YZ10CaeWRM8KiZ5TvMixxZegQ2KpWxkAG1rVcNC
         sK8GJOTba/xLsyBbcJ+DGSNqUQdBgWGWjSKcFLz24wQotXJiHrZymW6/M8tAWcK2f8gX
         qu7hkoD4qCAQopvYcIxVOvPz0HWALhkcyh6THU7oB2JLpY3SxhDd66NF5AIj6DTSXwhe
         8lzA==
X-Gm-Message-State: AOAM5315lKg6tF1RdEZCtlDlYLJBzO/6wHl2zzyff7cWpSIiJQbnI7G4
        hzCi6SOd1KoWEc3iIybmb8YmZa32CG/CP8N6n+0=
X-Google-Smtp-Source: ABdhPJzVGNQ/lbY9rpm6j84UlcgGLDvNJGibManwAPxAdA9MEMOwv36opRfPgExS5H8VquL1BjXU/Q5c0Kmj9gUDYGg=
X-Received: by 2002:a05:6512:3182:: with SMTP id i2mr41490771lfe.241.1638910025295;
 Tue, 07 Dec 2021 12:47:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.git.1638588503.gitgitgadget@gmail.com>
 <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com> <ff80a94bf9add8a6fabcd5146e5177edf5e35e49.1638845211.git.gitgitgadget@gmail.com>
 <Ya9LPOseu8geBi4v@ncase>
In-Reply-To: <Ya9LPOseu8geBi4v@ncase>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 7 Dec 2021 12:46:54 -0800
Message-ID: <CANQDOddgwc4X2snAGvoz0KFaCWcx+k2U3qfoLywcUS=6yF=Htg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] core.fsync: introduce granular fsync control
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 7, 2021 at 3:54 AM Patrick Steinhardt <ps@pks.im> wrote:
>
> On Tue, Dec 07, 2021 at 02:46:50AM +0000, Neeraj Singh via GitGitGadget wrote:
> > From: Neeraj Singh <neerajsi@microsoft.com>
> [snip]
> > diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> > index c23d01de7dc..c32534c13b4 100644
> > --- a/builtin/index-pack.c
> > +++ b/builtin/index-pack.c
> > @@ -1286,7 +1286,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
> >                           nr_objects - nr_objects_initial);
> >               stop_progress_msg(&progress, msg.buf);
> >               strbuf_release(&msg);
> > -             finalize_hashfile(f, tail_hash, 0);
> > +             finalize_hashfile(f, tail_hash, FSYNC_COMPONENT_PACK, 0);
> >               hashcpy(read_hash, pack_hash);
> >               fixup_pack_header_footer(output_fd, pack_hash,
> >                                        curr_pack, nr_objects,
> > @@ -1508,7 +1508,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
> >       if (!from_stdin) {
> >               close(input_fd);
> >       } else {
> > -             fsync_or_die(output_fd, curr_pack_name);
> > +             fsync_component_or_die(FSYNC_COMPONENT_PACK, output_fd, curr_pack_name);
> >               err = close(output_fd);
> >               if (err)
> >                       die_errno(_("error while closing pack file"));
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index 857be7826f3..916c55d6ce9 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -1204,11 +1204,13 @@ static void write_pack_file(void)
> >                * If so, rewrite it like in fast-import
> >                */
> >               if (pack_to_stdout) {
> > -                     finalize_hashfile(f, hash, CSUM_HASH_IN_STREAM | CSUM_CLOSE);
> > +                     finalize_hashfile(f, hash, FSYNC_COMPONENT_NONE,
> > +                                       CSUM_HASH_IN_STREAM | CSUM_CLOSE);
>
> It doesn't have any effect here given that we don't sync at all when
> writing to stdout, but I wonder whether we should set up the component
> correctly regardless of that such that it makes for a less confusing
> read.
>

If it's not actually a file with some name known to git, is it really
a component of the repository? I'd like to leave this one as-is.

> [snip]
> > diff --git a/config.c b/config.c
> > index c3410b8a868..29c867aab03 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1213,6 +1213,73 @@ static int git_parse_maybe_bool_text(const char *value)
> >       return -1;
> >  }
> >
> > +static const struct fsync_component_entry {
> > +     const char *name;
> > +     enum fsync_component component_bits;
> > +} fsync_component_table[] = {
> > +     { "loose-object", FSYNC_COMPONENT_LOOSE_OBJECT },
> > +     { "pack", FSYNC_COMPONENT_PACK },
> > +     { "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
> > +     { "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
> > +     { "objects", FSYNC_COMPONENTS_OBJECTS },
> > +     { "default", FSYNC_COMPONENTS_DEFAULT },
> > +     { "all", FSYNC_COMPONENTS_ALL },
> > +};
> > +
> > +static enum fsync_component parse_fsync_components(const char *var, const char *string)
> > +{
> > +     enum fsync_component output = 0;
> > +
> > +     if (!strcmp(string, "none"))
> > +             return output;
> > +
> > +     while (string) {
> > +             int i;
> > +             size_t len;
> > +             const char *ep;
> > +             int negated = 0;
> > +             int found = 0;
> > +
> > +             string = string + strspn(string, ", \t\n\r");
> > +             ep = strchrnul(string, ',');
> > +             len = ep - string;
> > +
> > +             if (*string == '-') {
> > +                     negated = 1;
> > +                     string++;
> > +                     len--;
> > +                     if (!len)
> > +                             warning(_("invalid value for variable %s"), var);
> > +             }
> > +
> > +             if (!len)
> > +                     break;
> > +
> > +             for (i = 0; i < ARRAY_SIZE(fsync_component_table); ++i) {
> > +                     const struct fsync_component_entry *entry = &fsync_component_table[i];
> > +
> > +                     if (strncmp(entry->name, string, len))
> > +                             continue;
> > +
> > +                     found = 1;
> > +                     if (negated)
> > +                             output &= ~entry->component_bits;
> > +                     else
> > +                             output |= entry->component_bits;
> > +             }
> > +
> > +             if (!found) {
> > +                     char *component = xstrndup(string, len);
> > +                     warning(_("unknown %s value '%s'"), var, component);
> > +                     free(component);
> > +             }
> > +
> > +             string = ep;
> > +     }
> > +
> > +     return output;
> > +}
> > +
> >  int git_parse_maybe_bool(const char *value)
> >  {
> >       int v = git_parse_maybe_bool_text(value);
> > @@ -1490,6 +1557,13 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
> >               return 0;
> >       }
> >
> > +     if (!strcmp(var, "core.fsync")) {
> > +             if (!value)
> > +                     return config_error_nonbool(var);
> > +             fsync_components = parse_fsync_components(var, value);
> > +             return 0;
> > +     }
> > +
> >       if (!strcmp(var, "core.fsyncmethod")) {
> >               if (!value)
> >                       return config_error_nonbool(var);
> > @@ -1503,7 +1577,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
> >       }
> >
> >       if (!strcmp(var, "core.fsyncobjectfiles")) {
> > -             fsync_object_files = git_config_bool(var, value);
> > +             warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));
> >               return 0;
> >       }
>
> Shouldn't we continue to support this for now such that users can
> migrate from the old, deprecated value first before we start to ignore
> it?
>
> Patrick
>

That's a good question and one I was hoping to answer through this
discussion.  I'm guessing that most users do not have this setting
explicitly set, and it's largely a non-functional change. Git only
behaves differently in the extreme corner case of a system crash after
git exits.  That's why I believe it's okay to deprecate and remove in
one release.

If we choose to keep supporting the setting, it would introduce a
little complexity in the configuration code, but it should be doable.
I think the right semantics would be to ignore core.fsyncobjectfiles
if core.fsync is specified with any value. Otherwise,
core.fsyncobjectfiles would be equivalent to `default,-loose-object`
or `default,loose-object` for `false` and `true` respectively. I'd
prefer not to do this if I can get away with it :).

Thanks,
Neeraj
