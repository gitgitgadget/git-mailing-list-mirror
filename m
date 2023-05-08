Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B4C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 21:01:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjEHVBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 17:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbjEHVA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:00:56 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08B7A97
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:00:53 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-643fdfb437aso11639433b3a.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 14:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683579653; x=1686171653;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10v/B2VuxF0Cx1Q06dsd8BmLAVWPWNZHc1AOV3HCdXU=;
        b=7nOUBYzsJU0KglCzEMo0/xQO3WspJXazhH2ow3E3T+IqWTHNlmhRezHw4+DovDmA0f
         isijyd/EhPSMKFqHsP3ng3tAR1g15cQcXM/9Zxc/QTtH17MfrVxV9SX+qNu04FRtUG9D
         eKhHeBoU3c1l/DXTxgvNIcJhzKofste8WsDVUugcMdy8ay5vQDTwd03zSox+zdytRMTc
         kF7P35GfzWmWpKuQqrIwgMlyCJ9de86uUb8mHX4rzqbF6WnI/u5IBUrmm1/QyXxFszC3
         Gu19MCyRKGY27ulaZaoZqTN95RK3uQA27PYCB6JEXJIKqt32LPRCJBo1soTnzDI7QPlW
         APNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579653; x=1686171653;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=10v/B2VuxF0Cx1Q06dsd8BmLAVWPWNZHc1AOV3HCdXU=;
        b=l4VTET7BIvyoPMWZjHF5YMtoO9LPkx+/UhGViubIoSGBB83qhivkL/3+6HEHHfbIRN
         MznLaL12R0iGHH5G1GiMkppi+3cvYCnWZa1r7JFEUUbskW8RSd25d9xGKemVBRbVhobS
         /XeSKC3WlLhwj4FHTcxxmANA/AWCL31z/B4e+4kG1M2qWCGq6XVX3OJ9awlllbNAdZ1d
         slPUZ7BqhSZO/ZmVFkBxfvCGSg96ZoDJ83a080jzF8W7vsXcnnmlQpYwkBgvmCpTA5G/
         OFe5PbCllOj6yHsqw6NI4CtPDlWaoyf0eIgMLwOIgPJaLgzt1/I4erqZ7HenU/LEoXU7
         +t4w==
X-Gm-Message-State: AC+VfDykdyMuIDspkMn3MYCrfpULthsnXJ7FPHubelj4uxNMUZsxUM7F
        imxZe6uJfHOk4graQdncchqPII2H+qFxFw==
X-Google-Smtp-Source: ACHHUZ7PitMSNAWk1jIH0FGLFavKEsBWN+UxPXNEjAdhDwZu17n5CWf7x5FHAYtDkSPWbOAj/5RCgN1qRpcn9g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:2806:0:b0:51a:7d6a:65c9 with SMTP id
 bs6-20020a632806000000b0051a7d6a65c9mr3506524pgb.6.1683579652812; Mon, 08 May
 2023 14:00:52 -0700 (PDT)
Date:   Mon, 08 May 2023 14:00:51 -0700
In-Reply-To: <230501.868re8jna4.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <pull.1497.git.git.1682104398.gitgitgadget@gmail.com>
 <1071e70c92892166e1ed2cf22bcd7eb49bdf3b20.1682104399.git.gitgitgadget@gmail.com>
 <230501.868re8jna4.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lr0rq1qt8.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 10/14] (RFC-only) config: finish config_fn_t refactor
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Apr 21 2023, Glen Choo via GitGitGadget wrote:
>
>> From: Glen Choo <chooglen@google.com>
>
> I like the general goal of this series, i.e. to get rid of the "reader"
> callback, and pass stuff more explicitly.
>
> But as I pointed out in
> https://lore.kernel.org/git/RFC-cover-0.5-00000000000-20230317T042408Z-av=
arab@gmail.com/
> I think this part (and the preceding two commits) are really taking is
> down the wrong path.
>
> To demonstrate why, here's a patch-on-top of this topic as a whole where
> I renamed the "kvi" struct members. I've excluded config.c itself (as
> its internals aren't interesting for the purposes of this discussion):
>
> [Patch showing used kvi members...]
>
> So, as this shows us your 08/14 has gone through the effort of passing
> this "kvi" info to every single callback, but it's only this handful
> that actually needs this information.

The attached patch misses the majority of "kvi" users, which use it in
die_bad_number(). This change happens in Patch 13/14, where the whole
"kvi" is passed into config.c machinery. It's still a much smaller
number of config callbacks than the ones changed in these few patches,
but it's more than a handful, I'd think.

> So, even if we *can* get this to work I don't think it's worth it,
> especially as this would preclude giving these config callbacks some
> "lighter" API that doesn't take the trouble of recording and ferrying
> this information to them.

I assume the "lighter API" refers to the current API?

If I'm reading this correctly, your concern isn't primarily about
reducing churn, it's YAGNI - since most callers don't need this info,
they should be able to reap the benefits of an API that doesn't provide
that info. Thus, you're proposing to having both the current API and a
new kvi-based one?

If so, I don't think that's a good route to take:

- Having both *_kvi() and "old" variants will add bloat to an already
  bloated config API. Even without further changes, we'd need to add
  *_kvi() to at least config_with_options() and repo_config(), as well
  as all of the functions that config_with_options() uses under the
  hood (some of which are public).

  To some extent, this can be managed by shrinking the config API (e.g.
  like your suggestion to get rid of git_config_from_file() [1]), but
  IMO that needs more discussion.

- What benefit is the old API giving us vs the new one? It won't be any
  faster since the machinery will need to support the new API, and even
  if it were, the benefit would be tiny. In some cases it might be nice
  to use the config callback in a non-config setting, but this patch
  shows that those are rare and can be easily worked around.

- I strongly suspect that we'd already like "kvi" in more places, and if
  we made it readily available, we would add these additional callers.
  E.g. we already use it to give additional diagnostics when failing to
  parse a number, and there's no reason why we shouldn't do this when
  doing other kinds of parsing (e.g. date in git_config_expiry_date() or
  color in color_parse_mem()).

If your concern really is primarily about churn and we actually want to
move everything to the new API eventually, wouldn't it be better to bite
the bullet and take a one time, well-scoped churn cost instead of a
longer migration?

[1] https://lore.kernel.org/git/230307.86wn3szrzu.gmgdl@evledraar.gmail.com=
/

> I think this should also neatly answer some of your outstanding
> questions. Especially as the above shows that the only non-test caller
> that needs "linenr" is the builtin/config.c caller that my proposed RFC
> (linked above) tackled directly. Most of these callbacks just need the
> more basic "scope".

I didn't see where builtin/config.c was handled in the above link.
Perhaps you meant a different RFC,
https://github.com/avar/git/commit/0233297a359bbda43a902dd0213aacdca82faa34=
?

> So, in particular:
>
>> Here's an exhaustive list of all of the changes:
>>
>> * Cases that need a judgement call
>>
>>   - trace2/tr2_cfg.c:tr2_cfg_set_fl()
>>
>>     This function needs to account for tr2_cfg_cb() now using "kvi".
>>     Since this is only called (indirectly) by git_config_set(), config
>>     source information has never been available here, so just pass NULL.
>>     It will be tr2_cfg_cb()'s responsibility to not use "kvi".
>
> Just adding a "CONFIG_SCOPE_IN_PROCESS", "CONFIG_SCOPE_SET" or whatever
> you'd want to call it seems to make much more sense here, no?=20

CONFIG_SCOPE_SET makes sense.

>>   - builtin/checkout.c:checkout_main()
>>
>>     This calls git_xmerge_config() as a shorthand for parsing a CLI arg.
>>     "kvi" doesn't apply, so just pass NULL. This might be worth
>>     refactoring away, since git_xmerge_config() can call
>>     git_default_config().
>
> Another example of a caller which never actually cares about this data,
> so if it doesn't need to have it passed to it, it doesn't need to fake
> it up either.

Here's a case of YAGNI I mentioned above and I agree it would be nice to
not have to fake a "kvi". However, git_xmerge_config() can call
git_defualt_config() so this seems more like it's abusing the config
callback to parse a CLI arg. A better resolution would be to have a
function dedicated to parsing "merge.conflictstyle".

>> * Hard for cocci to catch
>>
>>   - urlmatch.c
>>
>>     Manually refactor the custom config callbacks in "struct
>>     urlmatch_config".
>>
>>   - diff.h, fsck.h, grep.h, ident.h, xdiff-interface.h
>>
>>     "struct key_value_info" hasn't been defined yet, so forward declare
>>     it. Alternatively, maybe these files should "#include config.h".
>
> All of these problems go away if you don't insist on changing every
> single caller, you'll just have a step where you remove the current
> global in favor of some "config callback with kvi" info, and "make" will
> spot those callers that aren't converted yet.
>
> Those changes will be trivial enough (just the callers I noted above) to
> not require the tricky cocci patch in 08/14.
>
>> * Likely deficiencies in .cocci patch
>>
>>   - submodule-config.c:gitmodules_cb()
>>
>>     Manually refactor a parse_config() call that gets missed because it
>>     uses a different "*data" arg.
>>
>>   - grep.h, various
>>
>>     Manually refactor grep_config() calls. Not sure why these don't get
>>     picked up.
>>
>>   - config.c:git_config_include(), http.c:http_options()
>>
>>     Manually add "kvi" where it was missed. Not sure why they get missed=
.
>>
>>   - builtin/clone.c:write_one_config()
>>
>>     Manually refactor a git_clone_config() call. Probably got missed
>>     because I didn't include git_config_parse_parameter().
>>
>>   - ident.h
>>
>>     Remove the UNUSED attribute. Not sure why this is the only instance
>>     of this.
>>
>>   - git-compat-util.h, compat/mingw.[h|c]
>>
>>     Manually refactor noop_core_config(), platform_core_config() and
>>     mingw_core_config(). I can probably add these as "manual fixups" in
>>     cocci.
>
> ditto.

Yeah, there was definitely more cocci trickery than I'd like. Btw, if
you comments on the .cocci file itself, feel free to share. I obviously
just hacked together something based on a very rudimentary understanding
of cocci and I'd love suggestions on how to improve.
