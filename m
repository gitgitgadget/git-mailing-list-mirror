Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11EAC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 17:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiKGRQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 12:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiKGRQF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 12:16:05 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B3E1FFA7
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 09:16:03 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d18-20020a170902ced200b001871dab2d59so9533182plg.22
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxnOfJhLa79BvZJryLRx96AP/soFuDpoNq8EuEtnnNo=;
        b=OrgrzsPMPGMmoaBBwa4l4GRCZkZJX1mr+5kYanJg4/BXK+d5EsmH8G+jjqv73+5TNO
         hZIvXVwC51D1qcrITNDd8MGNuboSJf7fjKTe7Owmwc2uzVfUFSvuZGs3/+g7+Lt7t0Ef
         ulS66uYXHpm3Zjl3Nq2cxXZMN72fWaRKDCObDMg4tknwo/MQ/0Y2gMVDtO1ChvlPwJrr
         B/NeHt9R8Ji87NVFafJ4kh1ebkv4k3eeGPd1dwkkZbzIgT2HLRABSJG4mgLrzH8iY8F5
         B9xS1fanfR5k2rVtTtqk9q3Fj/+tTkA/Jm6H49szGg58BAHF31FT2ZTkcgsomrT8W+Ga
         9naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VxnOfJhLa79BvZJryLRx96AP/soFuDpoNq8EuEtnnNo=;
        b=PBE9dQUzv3CnjBKoTZNVMeZkXPsM/O+LCOCJbgt4XkHr32OMZ5bt0TkCx3kd9vssBc
         oaGKyRYmA51JVOGxg4ZCz99lNlvirysOEDw++1KXoNhL6hKTC7Af0Kbt9p+Th+I/BCD0
         xhqQC6q12PNYsRnPrgkFktiLrYNem+Q4E/xDkv89Elv/FTv7f5PDmdY/gEShN+MPW8xf
         y+K9lo6g7Gz0kkOoP/Fscy7gLMD3tIBpCjgfZ9728VXg3UcSnBD/tzP2xnoSTwZDXBcd
         WnUqnsXGLAjf0itLJsh0Y29Gkkt2gCP14WWt2GNdRNz7t5ceQUWrWwKavCV1a+rEoStf
         VsYw==
X-Gm-Message-State: ACrzQf1ld8wXPJQxxMx1uTvyYKGDgIY5+XoRmGMKY3vcYlh2rPnuidfs
        /WxaCxmZCACQBClSQHlIOY1FCGurMETMIg==
X-Google-Smtp-Source: AMsMyM6EECl1PPj/swuz/8Va5/WveZwq+yt+6mMblZNe78I0naEZX4PpxCFaM1sBP07KPoBE6ol6Yz6OPJfnaQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8246:0:b0:56b:830d:e9b8 with SMTP id
 e6-20020aa78246000000b0056b830de9b8mr51511738pfn.46.1667841363328; Mon, 07
 Nov 2022 09:16:03 -0800 (PST)
Date:   Mon, 07 Nov 2022 09:16:01 -0800
In-Reply-To: <221105.86wn89wk4e.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
 <patch-8.8-105853cd358-20221102T074148Z-avarab@gmail.com> <kl6l7d0bobt0.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221104.86wn8bzeus.gmgdl@evledraar.gmail.com> <kl6l8rkqy7no.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221105.86wn89wk4e.gmgdl@evledraar.gmail.com>
Message-ID: <kl6lsfiuwur2.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 8/8] submodule--helper: use OPT_SUBCOMMAND() API
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Nov 04 2022, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Thu, Nov 03 2022, Glen Choo wrote:
>>>
>>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>> [...]
>>>>> +	struct option options[] =3D {
>>>>> +		OPT_SUBCOMMAND("clone", &fn, module_clone),
>>>>> +		OPT_SUBCOMMAND("add", &fn, module_add),
>>>>> +		OPT_SUBCOMMAND("update", &fn, module_update),
>>>>> +		OPT_SUBCOMMAND("foreach", &fn, module_foreach),
>>>>> +		OPT_SUBCOMMAND("init", &fn, module_init),
>>>>> +		OPT_SUBCOMMAND("status", &fn, module_status),
>>>>> +		OPT_SUBCOMMAND("sync", &fn, module_sync),
>>>>> +		OPT_SUBCOMMAND("deinit", &fn, module_deinit),
>>>>> +		OPT_SUBCOMMAND("summary", &fn, module_summary),
>>>>> +		OPT_SUBCOMMAND("push-check", &fn, push_check),
>>>>> +		OPT_SUBCOMMAND("absorbgitdirs", &fn, absorb_git_dirs),
>>>>> +		OPT_SUBCOMMAND("set-url", &fn, module_set_url),
>>>>> +		OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
>>>>> +		OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
>>>>> +		OPT_END()
>>>>> +	};
>>>>> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>>>>> +	subcmd =3D argv[0];
>>>>> +
>>>>> +	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
>>>>> +	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
>>>>> +	    strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
>>>>> +	    get_super_prefix())
>>>>> +		/*
>>>>> +		 * xstrfmt() rather than "%s %s" to keep the translated
>>>>> +		 * string identical to git.c's.
>>>>> +		 */
>>>>> +		die(_("%s doesn't support --super-prefix"),
>>>>> +		    xstrfmt("'%s %s'", cmd, subcmd));
>>>>
>>>> FYI I'm preparing a series to get rid of the SUPPORT_SUPER_PREFIX chec=
ks
>>>> in both the top level and in submodule--helper (i.e. revisiting my
>>>> complaints from [1]), but I haven't sent it out yet because I haven't
>>>> found the right way to motivate that change. Feel free to chime in on
>>>> that series when it comes out.
>>>>
>>>> [1] https://lore.kernel.org/git/20220630221147.45689-5-chooglen@google=
.com/
>>>
>>> Maybe you have different plans, but keep at the WIP re-roll of what I
>>> have after this, I've also removed all of that.
>>>
>>> Basically, ending up with:
>>> =09
>>> 	--- a/builtin.h
>>> 	+++ b/builtin.h
>>> 	@@ -224,7 +224,14 @@ int cmd_sparse_checkout(int argc, const char **ar=
gv, const char *prefix);
>>> 	 int cmd_status(int argc, const char **argv, const char *prefix);
>>> 	 int cmd_stash(int argc, const char **argv, const char *prefix);
>>> 	 int cmd_stripspace(int argc, const char **argv, const char *prefix);
>>> 	+int cmd_submodule(int argc, const char **argv, const char *prefix);
>>> 	 int cmd_submodule__helper(int argc, const char **argv, const char *pr=
efix);
>>> 	+int cmd_submodule__helper_clone(int argc, const char **argv, const ch=
ar *prefix);
>>> 	+int cmd_submodule_absorbgitdirs(int argc, const char **argv, const ch=
ar *prefix);
>>> 	+int cmd_submodule_foreach(int argc, const char **argv, const char *pr=
efix);
>>> 	+int cmd_submodule_status(int argc, const char **argv, const char *pre=
fix);
>>> 	+int cmd_submodule_sync(int argc, const char **argv, const char *prefi=
x);
>>> 	+int cmd_submodule_update(int argc, const char **argv, const char *pre=
fix);
>>> 	 int cmd_switch(int argc, const char **argv, const char *prefix);
>>> 	 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)=
;
>>> 	 int cmd_tag(int argc, const char **argv, const char *prefix);
>>>
>>> And changes like:
>>> =09
>>> 	@@ -366,7 +365,7 @@ static void runcommand_in_submodule_cb(const struc=
t cache_entry *list_item,
>>> 	=20
>>> 	                strvec_pushl(&cpr.args, "--super-prefix", NULL);
>>> 	                strvec_pushf(&cpr.args, "%s/", displaypath);
>>> 	-               strvec_pushl(&cpr.args, "submodule--helper", "foreach"=
, "--recursive",
>>> 	+               strvec_pushl(&cpr.args, "submodule--helper-foreach", "=
--recursive",
>>> 	                             NULL);
>>> 	=20
>>> 	                if (info->quiet)
>>>
>>> I.e. when we call "foreach" we dispatch to cmd_submodule_foreach(), but
>>> when "foreach" needs to recurse it doesn't invoke a "git submodule
>>> foreach", instead it invokes "git submodule--helper-foreach".
>>>
>>> The reason for doing that is that we can't promote the helper to a
>>> built-in without also leaking implementation detail that we support the
>>> now internal-only --super-prefix in the command itself.
>>>
>>> So this code becomes:
>>> =09
>>> 	@@ -3352,43 +3304,17 @@ static int module_add(int argc, const char **a=
rgv, const char *prefix)
>>> 	=20
>>> 	 int cmd_submodule__helper(int argc, const char **argv, const char *pr=
efix)
>>> 	 {
>>> 	-       const char *cmd =3D argv[0];
>>> 	-       const char *subcmd;
>>> 	        parse_opt_subcommand_fn *fn =3D NULL;
>>> 	        const char *const usage[] =3D {
>>> 	                N_("git submodule--helper <command>"),
>>> 	                NULL
>>> 	        };
>>> 	        struct option options[] =3D {
>>> 	-               OPT_SUBCOMMAND("clone", &fn, module_clone),
>>> 	-               OPT_SUBCOMMAND("add", &fn, module_add),
>>> 	-               OPT_SUBCOMMAND("update", &fn, module_update),
>>> 	-               OPT_SUBCOMMAND("foreach", &fn, module_foreach),
>>> 	-               OPT_SUBCOMMAND("init", &fn, module_init),
>>> 	-               OPT_SUBCOMMAND("status", &fn, module_status),
>>> 	-               OPT_SUBCOMMAND("sync", &fn, module_sync),
>>> 	-               OPT_SUBCOMMAND("deinit", &fn, module_deinit),
>>> 	-               OPT_SUBCOMMAND("summary", &fn, module_summary),
>>> 	-               OPT_SUBCOMMAND("push-check", &fn, push_check),
>>> 	-               OPT_SUBCOMMAND("absorbgitdirs", &fn, absorb_git_dirs),
>>> 	-               OPT_SUBCOMMAND("set-url", &fn, module_set_url),
>>> 	-               OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
>>> 	-               OPT_SUBCOMMAND("create-branch", &fn, module_create_bra=
nch),
>>> 	+               OPT_SUBCOMMAND("push-check", &fn, cmd_submodule_push_c=
heck),
>>> 	+               OPT_SUBCOMMAND("create-branch", &fn, cmd_submodule_cre=
ate_branch),
>>> 	                OPT_END()
>>> 	        };
>>> 	        argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>>> 	-       subcmd =3D argv[0];
>>> 	-
>>> 	-       if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
>>> 	-           strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
>>> 	-           strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") =
&&
>>> 	-           get_super_prefix())
>>> 	-               /*
>>> 	-                * xstrfmt() rather than "%s %s" to keep the translate=
d
>>> 	-                * string identical to git.c's.
>>> 	-                */
>>> 	-               die(_("%s doesn't support --super-prefix"),
>>> 	-                   xstrfmt("'%s %s'", cmd, subcmd));
>>> 	=20
>>> 	        return fn(argc, argv, prefix);
>>> 	 }
>>>
>>> I.e. for all the "super-prefix" ones we dispatch directly (and maybe I
>>> should just do that too for those two stragglers).
>>>
>>> It's ugly, but it's only ugly on the inside, but if you can think of a
>>> better way to do it...
>>
>> If we _really_ wanted to keep the check, an alternative might be to
>> teach the subcommand parser about SUPPORT_SUPER_PREFIX. But frankly, I
>> think this SUPPORT_SUPER_PREFIX check is far more trouble than it's
>> worth, and I wouldn't want you to spend your time trying to find ways to
>> keep it only for it to be dropped altogether.
>>
>> Here's a snippet from the cover letter I'm working on, which will
>> hopefully convince you that we don't need to worry about this any more.
>>
>> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>>
>>   When we introduced the internal-only "--super-prefix" in 74866d7579 (g=
it: make
>>   super-prefix option, 2016-10-07), we specified that commands must pref=
ix paths
>>   by it, and pathspecs must be parsed relative to it. That commit also i=
ncludes
>>   safeguards to ensure that "--super-prefix" is used correctly, namely:
>>
>>   - Only commands marked SUPPORT_SUPER_PREFIX can be invoked with "--sup=
er-prefix".
>>   - The super prefix is propagated via the GIT_INTERNAL_SUPER_PREFIX env=
 var, so a
>>     non-SUPPORT_SUPER_PREFIX command cannot be invoked by a SUPPORT_SUPE=
R_PREFIX
>>     one.
>>
>>   However, its use is inconsistent, which is a strong reason to consider=
 using
>>   better-scoped flags instead. For example..
>>
>>     - Of the 4 commands that are SUPPORT_SUPER_PREFIX, only "read-tree" =
and
>>       "submodule--helper" do anything useful with it. "fsmonitor--daemon=
" has it
>>       to avoid the SUPPORT_SUPER_PREFIX warning [1]. "checkout--worker" =
doesn't have
>>       a documented reason, but since it can be invoked by "read-tree", i=
t's
>>       presumably also a workaround.
>>     - "read-tree" and "submodule--helper" use different values for the s=
uper prefix;
>>       "read-tree" passes the path from the root of the superproject's tr=
ee to the
>>       submodule's gitlink, while "submodule--helper" passes the relative=
 path of the
>>       original CWD to the submodule.
>>     - "submodule--helper" doesn't use "--super-prefix" to parse pathspec=
s, only to
>>       display paths.
>>
>>   This series fixes replaces "--super-prefix" with such better-scoped fl=
ags, and
>>   fixes some bugs resulting from the SUPPORT_SUPER_PREFIX check.
>>
>> [1] 53fcfbc84f (fsmonitor--daemon: allow --super-prefix argument, 2022-0=
5-26)
>>
>> ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
>>
>> I figured out all the details, but it would look something like:
>>
>> - Add an internal-only "--tree-super-prefix" flag to "git read-tree",
>>   which sets a global variable that is read from unpack-trees.c.
>> - Add an internal-only "--wt-super-prefix" flag to "git
>>   submodule--helper", which sets a global variable that is read from
>>   submodule.c. Unlike "--super-prefix", this won't be gated behind a
>>   SUPPORT_SUPER_PREFIX for each subcommand, since AFAICT, every
>>   subcommand is using this "--wt-super-prefix" correctly, so we can just
>>   make sure that new subcommands do too.
>> - Remove the global "--super-prefix", the corresponding env var and
>>   SUPPORT_SUPER_PREFIX.
> So for the "submodule as a built-in" I didn't want to take it hostage to
> that

That's a reasonable concern.

> Are you proposing that you'll submit another clean-up topic that the
> submodule-as-a-builtin will need to be queued on top of, in addition to
> this topic?
>
> If so I'd really prefer we defer those cleanups, which should also be
> much easier once submodule's fully in C, unless they're much more
> trivial than I'm currently suspecting they are...

Yes, that is what I'm proposing (unfortunately). I don't like having
either of us blocked on the other's work, but it seems like it really
does work out better this way, e.g. this series makes it much easier to
replace "git --super-prefix" with "git submodule--helper
--something-else" because we now use the options parser, and removing
the "--super-prefix" check makes the eventual conversion simpler because
that's one less behavior to worry about keeping.

We can see if my proposal makes sense when I send something out
(possibly as RFC). I'll do that today/tomorrow.
