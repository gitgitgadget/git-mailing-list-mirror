Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF6CC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 18:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbiCJSkB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 13:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbiCJSkA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 13:40:00 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A19718CC6E
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:38:58 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id s25so9031272lji.5
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 10:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lS3zuSzcL9+SQNLx8g2nmG7lsU3ebZo1WKd+wyFWURA=;
        b=aC8lGArTAsSsvwntmDZdRKBGhgZBH4bVf9UrhwCNxq9NztqqyfebMK+8PN8QpR3NmH
         qIpDmPUBo4rnVsx19EYk+WXk2HsnI+lYssmSWLOyYHL/mGiCmRMrxwxA69FR9hCUKEtX
         cgc25aSuOAlwVo0S5xdXdDqGCa1o9lL41oQ7R2LvoFzEd2XRj5vVFPOO7uptKe2pPKLs
         mkYoEKtS6tgRVzUgE5PoDwo91xaaUNlpssezrJrpDhHj5SypWpKOUO3dpJ2+n3mLlkla
         mrlLeNAP63+I5X5nKkSGUBbFJkGtw1ZlrXjwlmLD+xPflPXQZa7ii2EEn3uHCc5xlAJf
         q1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lS3zuSzcL9+SQNLx8g2nmG7lsU3ebZo1WKd+wyFWURA=;
        b=VRXPLbm+hvaCd1//uLTHyWuyup4cQf2RLrFIMcpghopfTZ/2sIOwrdZ10O2RVwIOIQ
         IY4L+ZUWQdDzSsHntr63a4N43juR6jXPsibVAQdouLTQp2vnM94y3tU0ye0wTmDZ8f4h
         BiY+DTnveZIfF2C37iInTtQguh2Hmk8MZ0ziCjim+Rc4qVU9DRBOBCyhx8GhV4zJXL7N
         48l08uSf4CF4msmGIJQ2caxzQEbmuE/ffLjD50nULpVxM3M8RUP5Ix1nAnAKgPoQbWm4
         BPc9955DPQ0AXuftbeNww70stgxp33zCcHJALSLZvOiGKY8qEnlKAmmvRYx7B9QuzldX
         GYFQ==
X-Gm-Message-State: AOAM532EfGpoYfDDLlwKjAeqYnTv1CTWE5v/gFR6SILp8Lv7+X3PrOYz
        /8MeynKoK2aFcQleFZWmdN8tKY9vr6qGo8rQdB8=
X-Google-Smtp-Source: ABdhPJyO17nP1eF+4ogGxBc70mBWD1B9/Z3QaCQeJVp/HC4QTrg8uXiakuTjVFI56irj2+v2QCbJGaAIIphyUXBe6mw=
X-Received: by 2002:a2e:9c01:0:b0:247:e785:49cf with SMTP id
 s1-20020a2e9c01000000b00247e78549cfmr3885204lji.413.1646937536687; Thu, 10
 Mar 2022 10:38:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
 <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com> <e31886717b42837f4e1538a13c8954aa07865af5.1646866998.git.gitgitgadget@gmail.com>
 <xmqqo82eirnv.fsf@gitster.g> <CANQDOddU_WXD-6ncDGBrgpsuKT-XDGC=SeaaQTNQFdODFZ7TkQ@mail.gmail.com>
 <xmqqcziugtpw.fsf@gitster.g>
In-Reply-To: <xmqqcziugtpw.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 10 Mar 2022 10:38:45 -0800
Message-ID: <CANQDOdcDbYHyRuJj0hV_LcYPJdkoJjF_EGN4CXpndc4VQ9dVAA@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] core.fsync: introduce granular fsync control
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 9, 2022 at 11:19 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > This is modeled after whitespace_rule_names.  What if I change this to
> > the following?
> > static const struct fsync_component_name {
> > ...
> > } fsync_component_names[]
>
> That's better.
>
> > At the conclusion of this series, I defined 'default' as an aggregate
> > option that includes
> > the platform default.  I'd prefer not to have any statefulness of the
> > core.fsync setting so
> > that there is less confusion about the final fsync configuration.
>
> Then scratch your preference ;-)

Just to clarify, linguistically, by 'scratch' do you mean that I should drop
my preference (which I can do to get the important parts of the
series in), or are you saying that that your suggestion is in line with
my preference, and I'm just not seeing it properly?

> Our configuration files are designed to be "hierarchical" in that
> system-wide default can be set in /etc/gitconfig, which can be
> overridden by per-user default in $HOME/.gitconfig, which can in
> turn be overridden by per-repository setting in .git/config, so
> starting from the compiled-in default, reading/augmenting "the value
> we tentatively decided based on what we have read so far" with what
> we read from lower-precedence files to higher-precedence files is a
> norm.
>
> Don't make this little corner of the system different from
> everything else; that will only confuse users.
>
> The git_config() callback should expect to see the same var with
> different values for that reason.  Always restarting from zero will
> defeat it.
>

Consider core.whitespace. The parse_whitespace_rule code starts with
the compiled-in default every time it encounters a config value, and then
modifies it according to what the user passed in.  So the user could figure
out what's going to happen by just looking at the value returned by
`git config --get core.whitespace`.  The user doesn't need to call
`git config --get-all core.whitespace` and then reason about the entries
from top to bottom to figure out the actual state that Git will use.

> And always restarting from zero will mean "none" is meaningless,
> while it would be a quite nice way to say "forget everything we have
> read so far and start from scratch" when you really want to refuse
> what the system default wants to give you.
>

The intention, which I've implemented in my local v6 changes, is for an
empty list or empty string to be an illegal value of core.fsync.  It should be
set to one or more legal values.  But I see the advantage in always resetting to
the system default, like core.whitespace does, so that a set of unrecognized
values results in at least default behavior. An empty string would mean
'unconfigured', which will be meaningful when we integrate core.fsync with
core.fsyncObjectFiles.

I'll update the change to start from default, with none as a reset. I'm still in
favor of making it so that the most recent value of core.fsync in the
hierarchical configuration store stands alone without picking up state from
prior values.

> >> > @@ -1613,7 +1684,7 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
> >> >       }
> >> >
> >> >       if (!strcmp(var, "core.fsyncobjectfiles")) {
> >> > -             fsync_object_files = git_config_bool(var, value);
> >> > +             warning(_("core.fsyncobjectfiles is deprecated; use core.fsync instead"));
> >>
> >> This is not deprecating but removing the support, which I am not
> >> sure is a sensible thing to do.  Rather we should pretend that
> >> core.fsync = "loose-object" (or "-loose-object") were found in the
> >> configuration, shouldn't we?
> >>
> >
> > The problem I anticipate is that figuring out the final configuration
> > becomes pretty
> > complex in the face of conflicting configurations of fsyncObjectFiles
> > and core.fsync.
>
> Don't start your thinking from too complex configuration that mixes
> and matches.  Instead, think what happens to folks who are *NOT*
> interested in the new way of doing this.  They aren't interested in
> setting core.fsync, and they already have core.fsyncObjectFiles set.
> You want to make sure their experience does not suck.
>
> The quoted code simply _IGNORES_ their wish and forces whatever
> default configuration core.fsync codepath happens to choose, which
> is a grave regression from their point of view.
>
> One way to handle this more gracefully is to delay the final
> decision until the end of the configuraiton file processing, and
> keep track of core.fsyncObjectFiles and core.fsync separately.  If
> the latter is never set but the former is, then you are dealing with
> such a user who hasn't migrated.  Give them a warning (the text
> above is fine---we can tell them "that's deprecated and you should
> use the other one instead"), but in the meantime, until deprecation
> turns into removal of support, keep honoring their original wish.
> If core.fsync is set to something, you can still give them a warning
> when you see core.fsyncObjectFiles, saying "that's deprecated and
> because you have core.fsync, we'll ignore the old one", and use the
> new method exclusively, without having to worry about mixing.

Is there a well-defined place where we know that configuration processing
is complete?  The most obvious spot to me to integrate these two values would
be the first time we need to figure out the fsync state. Another spot would be
prepare_repo_settings.  Are there any other good candidates?

Once the right spot is picked, I'll implement the integration of the
settings as you
suggested.  For now I'll stick it in prepare_repo_settings.

Thanks for the review.  Please expect a v6 today.
