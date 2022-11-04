Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0290C4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 17:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKDRC4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 13:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiKDRCy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 13:02:54 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C22326C3
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 10:02:53 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id c207-20020a624ed8000000b0056e3714b62cso2755230pfb.23
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 10:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbPBpzy8HKAR89C/dysSeSq6XHsE7gj58J+eLnl2csE=;
        b=qbeZQO6W1AKFHKZDj5CwUOPuejWcoF7+oZRO+7okDaIA+UxQTCKp+JnpDtHJZa8/L4
         8vQ74L0NmR1WUmPunHkHw3mw0ORggorNfYyB9JYWB8211CvjXKffSmqMzijh5V7vOGgv
         ESyN1dwJPzOR+EMaaKZmsOuugJnEgQIfihG/yPFhyH0KRrKAQKYMaMqx8uuBRp8IHkiF
         cgG7WqCyC3PC9lvl/LETMHJ7an73wQiK1rnf6vB0U+cnT9jU7ppAqWrMG7hunKY5j+Xt
         D+xBhSnJA5Wx0Up7t4YFsvwMS7KWAdww+nVqpKUnAPmwnGTMX0xJx4skDuNac3C2Ls3T
         XtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jbPBpzy8HKAR89C/dysSeSq6XHsE7gj58J+eLnl2csE=;
        b=mw2wODd4yrOE3PcIEUCQuUJkEaDSvD6F5zdpPVvOOKHEasigprIVyy1GlElUvlF+6q
         ZbwOsbTz6XCHycARUSvNncWWPSGdr1onwcxGWp9/LspAufq1lCHQ7AY9FPW1158iTyGV
         2ohoC66MFf0mOolbmACmTKbb8nlI5QXzGTZk8Y7ll1KggRZGAj7J8ZlJH822vXYRCJD2
         RETmI0+1EVlaa/6ERvseRTsOjO75vdoWqw5CS2xU/gnSQLXep/FcUmbnhCo/JOfA/Ry+
         OERVdBJTCDtSS0VMCJDsLM56JdsIW+HHrrwXpdDx4oNKk5loDXP6/Yst6JnfvtUyr74j
         KeDQ==
X-Gm-Message-State: ACrzQf10puXWPP0c07oUdjGgZqgoYrGM0r4KG1+d+JW9sH0goD6qpvVa
        xwT6Xghrithh/CvSPvYOzb6NPHY5AvtGug==
X-Google-Smtp-Source: AMsMyM5M+PWtEmts1k514PyGjQDziUgXMpKkH8cyXD9Wxx1iSHCcIQcvZGKwjo5CXjBY7VCSQs3UcpPQtG5/ng==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1687:b0:565:a932:f05a with SMTP
 id k7-20020a056a00168700b00565a932f05amr20097803pfc.21.1667581372904; Fri, 04
 Nov 2022 10:02:52 -0700 (PDT)
Date:   Fri, 04 Nov 2022 10:02:51 -0700
In-Reply-To: <221104.86wn8bzeus.gmgdl@evledraar.gmail.com>
Mime-Version: 1.0
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
 <patch-8.8-105853cd358-20221102T074148Z-avarab@gmail.com> <kl6l7d0bobt0.fsf@chooglen-macbookpro.roam.corp.google.com>
 <221104.86wn8bzeus.gmgdl@evledraar.gmail.com>
Message-ID: <kl6l8rkqy7no.fsf@chooglen-macbookpro.roam.corp.google.com>
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

> On Thu, Nov 03 2022, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>> [...]
>>> +	struct option options[] =3D {
>>> +		OPT_SUBCOMMAND("clone", &fn, module_clone),
>>> +		OPT_SUBCOMMAND("add", &fn, module_add),
>>> +		OPT_SUBCOMMAND("update", &fn, module_update),
>>> +		OPT_SUBCOMMAND("foreach", &fn, module_foreach),
>>> +		OPT_SUBCOMMAND("init", &fn, module_init),
>>> +		OPT_SUBCOMMAND("status", &fn, module_status),
>>> +		OPT_SUBCOMMAND("sync", &fn, module_sync),
>>> +		OPT_SUBCOMMAND("deinit", &fn, module_deinit),
>>> +		OPT_SUBCOMMAND("summary", &fn, module_summary),
>>> +		OPT_SUBCOMMAND("push-check", &fn, push_check),
>>> +		OPT_SUBCOMMAND("absorbgitdirs", &fn, absorb_git_dirs),
>>> +		OPT_SUBCOMMAND("set-url", &fn, module_set_url),
>>> +		OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
>>> +		OPT_SUBCOMMAND("create-branch", &fn, module_create_branch),
>>> +		OPT_END()
>>> +	};
>>> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>>> +	subcmd =3D argv[0];
>>> +
>>> +	if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
>>> +	    strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
>>> +	    strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
>>> +	    get_super_prefix())
>>> +		/*
>>> +		 * xstrfmt() rather than "%s %s" to keep the translated
>>> +		 * string identical to git.c's.
>>> +		 */
>>> +		die(_("%s doesn't support --super-prefix"),
>>> +		    xstrfmt("'%s %s'", cmd, subcmd));
>>
>> FYI I'm preparing a series to get rid of the SUPPORT_SUPER_PREFIX checks
>> in both the top level and in submodule--helper (i.e. revisiting my
>> complaints from [1]), but I haven't sent it out yet because I haven't
>> found the right way to motivate that change. Feel free to chime in on
>> that series when it comes out.
>>
>> [1] https://lore.kernel.org/git/20220630221147.45689-5-chooglen@google.c=
om/
>
> Maybe you have different plans, but keep at the WIP re-roll of what I
> have after this, I've also removed all of that.
>
> Basically, ending up with:
> =09
> 	--- a/builtin.h
> 	+++ b/builtin.h
> 	@@ -224,7 +224,14 @@ int cmd_sparse_checkout(int argc, const char **argv=
, const char *prefix);
> 	 int cmd_status(int argc, const char **argv, const char *prefix);
> 	 int cmd_stash(int argc, const char **argv, const char *prefix);
> 	 int cmd_stripspace(int argc, const char **argv, const char *prefix);
> 	+int cmd_submodule(int argc, const char **argv, const char *prefix);
> 	 int cmd_submodule__helper(int argc, const char **argv, const char *pref=
ix);
> 	+int cmd_submodule__helper_clone(int argc, const char **argv, const char=
 *prefix);
> 	+int cmd_submodule_absorbgitdirs(int argc, const char **argv, const char=
 *prefix);
> 	+int cmd_submodule_foreach(int argc, const char **argv, const char *pref=
ix);
> 	+int cmd_submodule_status(int argc, const char **argv, const char *prefi=
x);
> 	+int cmd_submodule_sync(int argc, const char **argv, const char *prefix)=
;
> 	+int cmd_submodule_update(int argc, const char **argv, const char *prefi=
x);
> 	 int cmd_switch(int argc, const char **argv, const char *prefix);
> 	 int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
> 	 int cmd_tag(int argc, const char **argv, const char *prefix);
>
> And changes like:
> =09
> 	@@ -366,7 +365,7 @@ static void runcommand_in_submodule_cb(const struct =
cache_entry *list_item,
> 	=20
> 	                strvec_pushl(&cpr.args, "--super-prefix", NULL);
> 	                strvec_pushf(&cpr.args, "%s/", displaypath);
> 	-               strvec_pushl(&cpr.args, "submodule--helper", "foreach", =
"--recursive",
> 	+               strvec_pushl(&cpr.args, "submodule--helper-foreach", "--=
recursive",
> 	                             NULL);
> 	=20
> 	                if (info->quiet)
>
> I.e. when we call "foreach" we dispatch to cmd_submodule_foreach(), but
> when "foreach" needs to recurse it doesn't invoke a "git submodule
> foreach", instead it invokes "git submodule--helper-foreach".
>
> The reason for doing that is that we can't promote the helper to a
> built-in without also leaking implementation detail that we support the
> now internal-only --super-prefix in the command itself.
>
> So this code becomes:
> =09
> 	@@ -3352,43 +3304,17 @@ static int module_add(int argc, const char **arg=
v, const char *prefix)
> 	=20
> 	 int cmd_submodule__helper(int argc, const char **argv, const char *pref=
ix)
> 	 {
> 	-       const char *cmd =3D argv[0];
> 	-       const char *subcmd;
> 	        parse_opt_subcommand_fn *fn =3D NULL;
> 	        const char *const usage[] =3D {
> 	                N_("git submodule--helper <command>"),
> 	                NULL
> 	        };
> 	        struct option options[] =3D {
> 	-               OPT_SUBCOMMAND("clone", &fn, module_clone),
> 	-               OPT_SUBCOMMAND("add", &fn, module_add),
> 	-               OPT_SUBCOMMAND("update", &fn, module_update),
> 	-               OPT_SUBCOMMAND("foreach", &fn, module_foreach),
> 	-               OPT_SUBCOMMAND("init", &fn, module_init),
> 	-               OPT_SUBCOMMAND("status", &fn, module_status),
> 	-               OPT_SUBCOMMAND("sync", &fn, module_sync),
> 	-               OPT_SUBCOMMAND("deinit", &fn, module_deinit),
> 	-               OPT_SUBCOMMAND("summary", &fn, module_summary),
> 	-               OPT_SUBCOMMAND("push-check", &fn, push_check),
> 	-               OPT_SUBCOMMAND("absorbgitdirs", &fn, absorb_git_dirs),
> 	-               OPT_SUBCOMMAND("set-url", &fn, module_set_url),
> 	-               OPT_SUBCOMMAND("set-branch", &fn, module_set_branch),
> 	-               OPT_SUBCOMMAND("create-branch", &fn, module_create_branc=
h),
> 	+               OPT_SUBCOMMAND("push-check", &fn, cmd_submodule_push_che=
ck),
> 	+               OPT_SUBCOMMAND("create-branch", &fn, cmd_submodule_creat=
e_branch),
> 	                OPT_END()
> 	        };
> 	        argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> 	-       subcmd =3D argv[0];
> 	-
> 	-       if (strcmp(subcmd, "clone") && strcmp(subcmd, "update") &&
> 	-           strcmp(subcmd, "foreach") && strcmp(subcmd, "status") &&
> 	-           strcmp(subcmd, "sync") && strcmp(subcmd, "absorbgitdirs") &&
> 	-           get_super_prefix())
> 	-               /*
> 	-                * xstrfmt() rather than "%s %s" to keep the translated
> 	-                * string identical to git.c's.
> 	-                */
> 	-               die(_("%s doesn't support --super-prefix"),
> 	-                   xstrfmt("'%s %s'", cmd, subcmd));
> 	=20
> 	        return fn(argc, argv, prefix);
> 	 }
>
> I.e. for all the "super-prefix" ones we dispatch directly (and maybe I
> should just do that too for those two stragglers).
>
> It's ugly, but it's only ugly on the inside, but if you can think of a
> better way to do it...

If we _really_ wanted to keep the check, an alternative might be to
teach the subcommand parser about SUPPORT_SUPER_PREFIX. But frankly, I
think this SUPPORT_SUPER_PREFIX check is far more trouble than it's
worth, and I wouldn't want you to spend your time trying to find ways to
keep it only for it to be dropped altogether.

Here's a snippet from the cover letter I'm working on, which will
hopefully convince you that we don't need to worry about this any more.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

  When we introduced the internal-only "--super-prefix" in 74866d7579 (git:=
 make
  super-prefix option, 2016-10-07), we specified that commands must prefix =
paths
  by it, and pathspecs must be parsed relative to it. That commit also incl=
udes
  safeguards to ensure that "--super-prefix" is used correctly, namely:

  - Only commands marked SUPPORT_SUPER_PREFIX can be invoked with "--super-=
prefix".
  - The super prefix is propagated via the GIT_INTERNAL_SUPER_PREFIX env va=
r, so a
    non-SUPPORT_SUPER_PREFIX command cannot be invoked by a SUPPORT_SUPER_P=
REFIX
    one.

  However, its use is inconsistent, which is a strong reason to consider us=
ing
  better-scoped flags instead. For example..

    - Of the 4 commands that are SUPPORT_SUPER_PREFIX, only "read-tree" and
      "submodule--helper" do anything useful with it. "fsmonitor--daemon" h=
as it
      to avoid the SUPPORT_SUPER_PREFIX warning [1]. "checkout--worker" doe=
sn't have
      a documented reason, but since it can be invoked by "read-tree", it's
      presumably also a workaround.
    - "read-tree" and "submodule--helper" use different values for the supe=
r prefix;
      "read-tree" passes the path from the root of the superproject's tree =
to the
      submodule's gitlink, while "submodule--helper" passes the relative pa=
th of the
      original CWD to the submodule.
    - "submodule--helper" doesn't use "--super-prefix" to parse pathspecs, =
only to
      display paths.

  This series fixes replaces "--super-prefix" with such better-scoped flags=
, and
  fixes some bugs resulting from the SUPPORT_SUPER_PREFIX check.

[1] 53fcfbc84f (fsmonitor--daemon: allow --super-prefix argument, 2022-05-2=
6)

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----

I figured out all the details, but it would look something like:

- Add an internal-only "--tree-super-prefix" flag to "git read-tree",
  which sets a global variable that is read from unpack-trees.c.
- Add an internal-only "--wt-super-prefix" flag to "git
  submodule--helper", which sets a global variable that is read from
  submodule.c. Unlike "--super-prefix", this won't be gated behind a
  SUPPORT_SUPER_PREFIX for each subcommand, since AFAICT, every
  subcommand is using this "--wt-super-prefix" correctly, so we can just
  make sure that new subcommands do too.
- Remove the global "--super-prefix", the corresponding env var and
  SUPPORT_SUPER_PREFIX.
