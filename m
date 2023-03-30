Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DF6C6FD1D
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 17:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjC3Rvd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 13:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjC3RvV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 13:51:21 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B6FC678
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 10:51:20 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id nu18-20020a17090b1b1200b0023fbe01dc06so9569421pjb.8
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 10:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680198680;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPVTkaxazFMR8SN3Sdcu69npouVdaMeDaC6sPx/Jiy0=;
        b=LnX2RaEWFsCVdVZ9llEactPrgonahC1o1/P524WHNvFN1l1V7qEbzT+aLw0XvfT11A
         m4XyLgPfx9WMrU6XPw78NsJRKWCtCar6RWdbRlcL23HZqOBhZJRmw7OoqPFYcOVP1CeT
         ZtkqdoqPUs55SHuddyTktqkjC38v3oFkpUxobi9RgVOSkYiezas3ttNTAB3AoQ+pca2w
         XpWui9wnOGIPNdAcg5E7Woh5Kx//rwUqDaxmBWoJnYOEFDz1jk8uSnnSJ9LI1IitLi8W
         bozJx9gyZQxHg+Xzyt3JysWhqdvyCY620fdy2v6+szWvK6K6nhAkCC2wDhLPe3SzTrpp
         kwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680198680;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gPVTkaxazFMR8SN3Sdcu69npouVdaMeDaC6sPx/Jiy0=;
        b=6K7saik9cA4RkKHYvBbseVkkbNQ34HYi9c5S9o7Dvtv0KMmx5N9Ct5TjH9ywA0Y+y1
         On1szQ2uXL0rYYZi9QCOHVVsUgNj3jf1TizogsiMUaC1v3iq1fflXr4FymXTxyQ6aW0O
         scEe2B/S7Uo+Cfx7v8TqBwap655hRJxCOvl7QUs6ewwgh92GFFRQuerltBqsNxhJyWrM
         SjLmPOUYG4i7hnM5h5gFjH5fySxPNJBbuQ0dOqYYJhNt53f50edSsGgAVEvYQnLWqOB5
         O1kXWbvBANi3KfovrnLDfZhLlJlsK3ZsWurRR50Ir7HyCpmFnaxiOK8tO804sqLyAwVh
         iZCw==
X-Gm-Message-State: AAQBX9cY6LLAh+CiA2SbhMUnybnUJlg/ebd+IPxGRvlNWXPjRhev1INr
        5Sv4KKH1birBlBmxTz62L2MYAa+z988BMg==
X-Google-Smtp-Source: AKy350bw3inQhzPbGYWIcMHyKEezIN5zCQ5byPCeTc0Qld+8EgECupMQ1anA/QK8JXAm+WnK3tYFhxMbCLIKPA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1388:b0:625:ccea:1627 with SMTP
 id t8-20020a056a00138800b00625ccea1627mr13110157pfg.5.1680198680399; Thu, 30
 Mar 2023 10:51:20 -0700 (PDT)
Date:   Thu, 30 Mar 2023 10:51:11 -0700
In-Reply-To: <230329.86sfdnvlke.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
 <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com> <72774fd08f3eb9ff1d449814637e584692ba2bfc.1680025914.git.gitgitgadget@gmail.com>
 <230329.86sfdnvlke.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lcz4qcels.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 3/8] config.c: create config_reader and the_reader
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Mar 28 2023, Glen Choo via GitGitGadget wrote:
>> A more typical approach would be to put this struct on "the_repository",
>> but that's a worse fit for this use case since config reading is not
>> scoped to a repository. E.g. we can read config before the repository is
>> known ("read_very_early_config()"), blatantly ignore the repo
>> ("read_protected_config()"), or read only from a file
>> ("git_config_from_file()"). This is especially evident in t5318 and
>> t9210, where test-tool and scalar parse config but don't fully
>> initialize "the_repository".
>
> [...]
>
> But I think this paragraph still does a bad job of justifying this
> direction with reference to existing code.
>
> Why? Because from reading it you get the impression that with
> read_very_early_config() and read_protected_config() "config reading is
> not scoped to a repository", but "scoped to" is doing a *lot* of work
> here.
>
> [...]
>
> So, so far the reader might be genuinely confused, since we already have
> a "repo" in scope why can't we use it for this cache? Even if just
> reading the system config etc.
>
> For *those* cases I think what I *think* you're going for is that while
> we have a "struct repository" already, we don't want to use it for our
> "cache", and instead have a file-scoped one.

I was probably unclear, bleh. I intended "repository" to mean 'the thing
users interact with', not "struct repository". At any rate, the major
use case I'm concerned with is 'reading config from a file', where the
repository really isn't relevant at all (more on that later).

> Personally, I don't see how it's cleaner to always use a file-scope
> rather than piggy-back on the global we almost always have (or provide a
> fallback), but let's not get on that topic again :)

Piggybacking is probably less intrusive, but I'm not sure it results in
a coherent interface. The _only_ use of git_config_source.repo is to
read config from blobs in config_with_options() (which we need to read
.gitmodules from commits, not the working copy). After that, we don't
actually propagate the "struct repository" at all (because it's not
needed), and I think it makes sense to keep it that way.

> Now, the case that *is* special on the other hand is
> git_config_from_file(), there we really don't have a "repository" at
> all, as it never gets the "struct config_include_data inc", or a
> "git_config_source".
>
> But if we dig a bit into those cases there's 3x users of
> git_config_from_file() outside of config.c itself:
>
>  * setup.c, to read only repo's "config.worktree"
>  * setup.c, to read only repo "config"
>  * sequencer.c, to read "sequencer/opts"

We should also include git_config_from_file_with_options() (which is
basically the same thing), which adds one more caller:

* bundle-uri.c, to read bundle URI files

> For the former two, I think the only thing that's needed is something
> like this, along with a corresponding change to
> do_git_config_sequence():
>
> 	diff --git a/config.h b/config.h
> 	index 7606246531a..b8a3de4eb93 100644
> 	--- a/config.h
> 	+++ b/config.h
> 	@@ -85,7 +85,10 @@ typedef int (*config_parser_event_fn_t)(enum config_e=
vent_t type,
> 	=20
> 	 struct config_options {
> 	        unsigned int respect_includes : 1;
> 	+       unsigned int ignore_system : 1;
> 	+       unsigned int ignore_global : 1;
> 	        unsigned int ignore_repo : 1;
> 	+       unsigned int ignore_local : 1;
> 	        unsigned int ignore_worktree : 1;
> 	        unsigned int ignore_cmdline : 1;
> 	        unsigned int system_gently : 1;
>
> I.e. we actually *do* have a repo there, we just haven't bridged the gap
> of "ignore most of its config" so we can use config_with_options()
> there.

I'm ambivalent on this. On the one hand, you're not wrong to say that
there probably _is_ a repository that we just happen to not care about,
and maybe it makes sense for config_with_options() to see a "struct
repository". On the other, I'm still quite convinced that the "struct
repository" that we already have just happens to be there by accident
(because "struct git_config_source" is a union of unrelated things), and
I don't think we should be piggybacking onto that.

> The sequencer.c case is trickier, but presumably for such isolated
> reading we could have a lower-level function which would return the
> equivalent of a "key_value_info" on errors or whatever.

bundle-uri.c falls into this case of 'read a file in config syntax' too.
For this reason, I see at least two layers to the config API:

- Parsing a file in config syntax, i.e. the "lower level" API
- Reading Git-specific config (understanding where config is located,
  caching it, etc), i.e. the "higher level" API

We have in-tree callers for _both_ of these layers, and I think that's
appropriate. IOW I don't think we necessarily need to hide the "lower
level" API inside of config.c and expose only the "higher level" API
in-tree [1], which was the impression I got from some of your RFC
patches.

Separating the layers like this also makes it possible to expose the
"lower" level to out-of-tree callers in a sensible way. To parse a
file in a given syntax, a caller shouldn't need to know about
repositories and whatnot. That's exactly what this series is trying to
prepare for, and being principled about the 'config reading cache' is
essential to get this sort of separation.

> I.e. are we assuming no "repo", but per the above we really do have one,
> but we just don't pass it because we don't have a "read only the
> worktree config part", or whatever?

This was addressed above.

> Ditto the line number relaying for builtin/config.c, which as my RFC
> showed we have one or two API users that care, which we can just
> convert...

builtin/config.c is a weird case that I think needs some refactoring,
e.g. there's

- git config -l, which will list all of the git config ("higher level")
- git config -l -f <file>, which lists config from just a file ("lower
  level")

but it uses config_with_options() in both cases! It works because
config_with_options() can switch between "read a subset the git config"
and "read just this file", but it's pretty gross, and we sometimes get
it wrong. (see https://lore.kernel.org/git/xmqqzg9kew1q.fsf@gitster.g/
as an example of how --global is a bit broken).

Your suggestion to convert that (also made upthread, but I can't find
the link for some reason...) to something that uses config_set sounds
pretty reasonable [1].

> Anyway, I'm fine with this direction for now, but given the above & my
> previous RFC
> https://lore.kernel.org/git/RFC-cover-0.5-00000000000-20230317T042408Z-av=
arab@gmail.com/
> I can't help but think we're taking two steps forward & one step
> backwards for some of this.

Thanks. I appreciate the feedback, nevertheless; I think it's bringing
us closer to a good conclusion.

FWIW I'm working on a followup that will take _many_ steps forward by
adjusting config_fn_t. I don't know how that will pan out, so I
appreciate checking in this series, which is at least a marginal
improvement over the status quo.

[1] "struct config_set" doesn't fall very neatly into the "lower" and
"higher" level API discussion. It's useful to be able to read config
into some in-memory cache (in-tree and out-of-tree), though that isn't
as "low level" as parsing config (without caching). That will probably
be a good follow up to my work to _just_ parse config.
