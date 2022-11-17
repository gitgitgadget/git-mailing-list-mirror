Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78805C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 18:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiKQSPX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239670AbiKQSO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 13:14:56 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2617FC0D
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 10:14:49 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ud5so7158535ejc.4
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 10:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p35YpdqtCNmr9r7JQEsw3JxsKE82EYOf3+YHPljQNik=;
        b=TWSL3qMSX4D9/qEceQ4EFIkX0AHuiGENi69hZbj0YuBxgTSXnpinCT3J4qFYGbsfIA
         bs6kDxMHFIqL56KhwmyiyMNGxWRaucOOZNqhdq8SP42cdIiQxxk/AlV228e/FF+6DocR
         jpk3kNTWdM/Jm1mBRd0KBX+ll6iYsmDxnJnJt1HuYpt3XX/qIu8xEP1Irn9HdQWRcowJ
         8Mcjj++8jMYm8R7DbbnGTqiA9wJL7/w8FidDltfen9ffI6gPtho74RZmMcGoNxOdBj0h
         I0NT4auNbbV0wByZ2DQqaY2jyDRPpkvJ7XlhXflfDQln3vCFOqeH2Xc2QAQMjkOdy2wk
         kxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p35YpdqtCNmr9r7JQEsw3JxsKE82EYOf3+YHPljQNik=;
        b=NPlrj0YI7AzgK57dOkbj5c4fYjqFxTAflDlIjheD2q78auujK5BdnMn6HAgivZQyaH
         8AOj85yTRkKjmZ5NjHqqp9jVmbKY7V/2SDNj+e6vngVo9prc71MPuLWimr8Svh8rjJ/j
         Ret3RdcjQmSQ6/BPqabRJReeLajFkflyG9mQCCYsxUfyL5KKRNAAwlPSmSsWD6aknkps
         Oytd4+T7bT/aDEDXcXfSTExKnxaehv3C/WAwe/rBPDeDvIKBNiz3R7WTKMHuOxTlytVc
         G9w9dwmQOBuXRVAB8YbL1J0xfJy1+/L2gs6uf04Rqy0rgNuON/pV4CXAczO8akyHkqaQ
         OAWQ==
X-Gm-Message-State: ANoB5pkAxFi/B1Hf7P5z69ENRjeUwzW881ZJRsv9OMEGHeLWLylqyAEG
        FT28t8uImq+3VXsM8va7+D0=
X-Google-Smtp-Source: AA0mqf7d2WgSpxpQWiIw1J1o+aF/f4AmOTB5coNaLNTuCIo/OQ8IO8aONNQaM1XKGi9DxyQ07dCkDw==
X-Received: by 2002:a17:906:3bce:b0:7aa:6998:ad72 with SMTP id v14-20020a1709063bce00b007aa6998ad72mr3182996ejf.763.1668708887449;
        Thu, 17 Nov 2022 10:14:47 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ku4-20020a170907788400b007306a4ecc9dsm690852ejc.18.2022.11.17.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:14:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovjPS-004wnL-0b;
        Thu, 17 Nov 2022 19:14:46 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 02/10] submodule--helper: don't use global
 --super-prefix in "absorbgitdirs"
Date:   Thu, 17 Nov 2022 19:10:02 +0100
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
 <patch-v2-02.10-5a35f7b75b3-20221114T100803Z-avarab@gmail.com>
 <kl6la64tp6xc.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <kl6la64tp6xc.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <221117.86tu2xh2i1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 14 2022, Glen Choo wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> The "--super-prefix" facility was introduced in [1] has always been a
>> transitory hack, which is why we've made it an error to supply it as
>> an option to "git" to commands that don't know about it.
>>
>> That's been a good goal, as it has a global effect we haven't wanted
>> calls to get_super_prefix() from built-ins we didn't expect.
>>
>> But it has meant that when we've had chains of different built-ins
>> using it all of the processes in that "chain" have needed to support
>> it, and worse processes that don't need it have needed to ask for
>> "SUPPORT_SUPER_PREFIX" because their parent process needs it.
>>
>> That's how "fsmonitor--daemon" ended up with it, per [2] it's called
>> from (among other things) "submodule--helper absorbgitdirs", but as we
>> declared "submodule--helper" as "SUPPORT_SUPER_PREFIX" we needed to
>> declare "fsmonitor--daemon" as accepting it too, even though it
>> doesn't care about it.
>>
>> But in the case of "absorbgitdirs" it only needed "--super-prefix" to
>> invoke itself recursively, and we'd never have another "in-between"
>> process in the chain. So we didn't need the bigger hammer of "git
>> --super-prefix", and the "setenv(GIT_SUPER_PREFIX_ENVIRONMENT, ...)"
>> that it entails.
>>
>> Let's instead accept a hidden "--super-prefix" option to
>> "submodule--helper absorbgitdirs" itself.
>>
>> Eventually (as with all other "--super-prefix" users) we'll want to
>> clean this code up so that this all happens in-process. I.e. needing
>> any variant of "--super-prefix" is itself a hack around our various
>> global state, and implicit reliance on "the_repository". This stepping
>> stone makes such an eventual change easier, as we'll need to deal with
>> less global state at that point.
>>
>> The "fsmonitor--daemon" test adjusted here was added in [3]. The
>> comment added in that commit has been out-of-date from the beginning,
>> and the "have_t2_error_event()" was being overly specific in testing
>> for a bug that we *don't* have. Let's instead test for the stdout and
>> stderr that we *do have*.
>
> I didn't understand this bit initially, because I read this as
> "have_t2_error_event() isn't catching bugs", which isn't true. But I see
> what you mean after inspecting the test_cmp output:
>
>   @@ -1 +1,2 @@
>   Migrating git directory of 'dir_1/dir_2/sub' from 'dir_1/dir_2/sub/.git=
' to '.git/modules/dir_1/dir_2/sub'
>   +fatal: fsmonitor--daemon doesn't support --super-prefix
>
> IOW, it doesn't make sense to inspecting the tr2 output for stray
> warnings when our stderr is so obviously broken. But at the end of the
> series, I don't think we even need this test at all because if we don't
> have a global "--super-prefix", there's literally no reason for
> fsmonitor--daemon to worry about absorbgitdirs or "supporting" the super
> prefix. That's why I removed it in [1].
>
> Wondering aloud, that stderr suggests that the "git submodule absorbgitdi=
rs"
> invocation failed. I wonder why the test didn't catch a bad exit code
> (and resulting in us inspecting stderr unnecessarily). I think it's not
> worth looking too closely at right now, but we could revisit this after
> we get builtin/submodule.c.
>
> [1] https://lore.kernel.org/git/20221109004708.97668-5-chooglen@google.com

I'm prepping a re-roll where I'll keep some of this test, as testing
fsmonitor+absorbgitdirs is worthhwile, but the commit message etc. is
rephrased.

>> diff --git a/git.c b/git.c
>> index 10202a7f126..b1b7e1a837e 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -539,7 +539,7 @@ static struct cmd_struct commands[] =3D {
>>  	{ "format-patch", cmd_format_patch, RUN_SETUP },
>>  	{ "fsck", cmd_fsck, RUN_SETUP },
>>  	{ "fsck-objects", cmd_fsck, RUN_SETUP },
>> -	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, SUPPORT_SUPER_PREFIX | R=
UN_SETUP },
>> +	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
>>  	{ "gc", cmd_gc, RUN_SETUP },
>>  	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
>>  	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
>> diff --git a/parse-options.h b/parse-options.h
>> index b6ef86e0d15..50d852f2991 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -369,6 +369,10 @@ int parse_opt_tracking_mode(const struct option *, =
const char *, int);
>>  	{ OPTION_CALLBACK, 0, "abbrev", (var), N_("n"),	\
>>  	  N_("use <n> digits to display object names"),	\
>>  	  PARSE_OPT_OPTARG, &parse_opt_abbrev_cb, 0 }
>> +#define OPT__SUPER_PREFIX(var) \
>> +	OPT_STRING_F(0, "super-prefix", (var), N_("prefix"), \
>> +		N_("prefixed path to initial superproject"), PARSE_OPT_HIDDEN)
>> +
>
> Could we default to "" instead of NULL? (possibly via a callback). I
> think there's never any good reason to have NULL instead of "", e.g.
> since this is internal, we don't care to distinguish between
> "--super-prefix=3D''" and not passing "--super-prefix" at all...

I saw this comment on another patch, I think I'll keep it for now, but I
updated the reason: It's because the "prefix" is either NULL or a
non-zero length string, so we're doing the same here to be consistent
with it.

I think that makes sense, but ultimately it's an arbitrary choice, but
as they're sibling variables in the cases they're used doing the same
seems worthwhile...

>>  #define OPT__COLOR(var, h) \
>>  	OPT_COLOR_FLAG(0, "color", (var), (h))
>>  #define OPT_COLUMN(s, l, v, h) \
>> diff --git a/submodule.c b/submodule.c
>> index c47358097fd..d9fd0af81b6 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -2268,7 +2268,8 @@ int validate_submodule_git_dir(char *git_dir, cons=
t char *submodule_name)
>>   * Embeds a single submodules git directory into the superprojects git =
dir,
>>   * non recursively.
>>   */
>> -static void relocate_single_git_dir_into_superproject(const char *path)
>> +static void relocate_single_git_dir_into_superproject(const char *path,
>> +						      const char *super_prefix)
>>  {
>>  	char *old_git_dir =3D NULL, *real_old_git_dir =3D NULL, *real_new_git_=
dir =3D NULL;
>>  	struct strbuf new_gitdir =3D STRBUF_INIT;
>> @@ -2302,7 +2303,7 @@ static void relocate_single_git_dir_into_superproj=
ect(const char *path)
>>  	       real_old_git_dir[off] =3D=3D real_new_git_dir[off])
>>  		off++;
>>  	fprintf(stderr, _("Migrating git directory of '%s%s' from '%s' to '%s'=
\n"),
>> -		get_super_prefix_or_empty(), path,
>> +		(super_prefix ? super_prefix : ""), path,
>>  		real_old_git_dir + off, real_new_git_dir + off);
>
>
> Which would make sites like these a bit cleaner.
>
> Tangentially, 'default to "" if NULL' sounds like a common pattern. Is
> there a good reason not to have a macro or inline function to do that?
> e.g. we think the ternary expression is good enough?)

See above.

>>=20=20
>>  	relocate_gitdir(path, real_old_git_dir, real_new_git_dir);
>> @@ -2313,7 +2314,8 @@ static void relocate_single_git_dir_into_superproj=
ect(const char *path)
>>  	strbuf_release(&new_gitdir);
>>  }
>>=20=20
>> -static void absorb_git_dir_into_superproject_recurse(const char *path)
>> +static void absorb_git_dir_into_superproject_recurse(const char *path,
>> +						     const char *super_prefix)
>>  {
>>=20=20
>>  	struct child_process cp =3D CHILD_PROCESS_INIT;
>> @@ -2321,10 +2323,11 @@ static void absorb_git_dir_into_superproject_rec=
urse(const char *path)
>>  	cp.dir =3D path;
>>  	cp.git_cmd =3D 1;
>>  	cp.no_stdin =3D 1;
>> -	strvec_pushf(&cp.args, "--super-prefix=3D%s%s/",
>> -		     get_super_prefix_or_empty(), path);
>>  	strvec_pushl(&cp.args, "submodule--helper",
>>  		     "absorbgitdirs", NULL);
>> +	strvec_pushf(&cp.args, "--super-prefix=3D%s%s/", super_prefix ?
>> +		     super_prefix : "", path);
>> +
>>  	prepare_submodule_repo_env(&cp.env);
>>  	if (run_command(&cp))
>>  		die(_("could not recurse into submodule '%s'"), path);
>> @@ -2335,7 +2338,8 @@ static void absorb_git_dir_into_superproject_recur=
se(const char *path)
>>   * having its git directory within the working tree to the git dir nest=
ed
>>   * in its superprojects git dir under modules/.
>>   */
>> -void absorb_git_dir_into_superproject(const char *path)
>> +void absorb_git_dir_into_superproject_sp(const char *path,
>> +					 const char *super_prefix)
>>  {
>>  	int err_code;
>>  	const char *sub_git_dir;
>> @@ -2377,14 +2381,14 @@ void absorb_git_dir_into_superproject(const char=
 *path)
>>  		char *real_common_git_dir =3D real_pathdup(get_git_common_dir(), 1);
>>=20=20
>>  		if (!starts_with(real_sub_git_dir, real_common_git_dir))
>> -			relocate_single_git_dir_into_superproject(path);
>> +			relocate_single_git_dir_into_superproject(path, super_prefix);
>>=20=20
>>  		free(real_sub_git_dir);
>>  		free(real_common_git_dir);
>>  	}
>>  	strbuf_release(&gitdir);
>>=20=20
>> -	absorb_git_dir_into_superproject_recurse(path);
>> +	absorb_git_dir_into_superproject_recurse(path, super_prefix);
>>  }
>>=20=20
>>  int get_superproject_working_tree(struct strbuf *buf)
>> diff --git a/submodule.h b/submodule.h
>> index b52a4ff1e73..e5ee13fb06a 100644
>> --- a/submodule.h
>> +++ b/submodule.h
>> @@ -164,7 +164,12 @@ void submodule_unset_core_worktree(const struct sub=
module *sub);
>>   */
>>  void prepare_submodule_repo_env(struct strvec *env);
>>=20=20
>> -void absorb_git_dir_into_superproject(const char *path);
>> +void absorb_git_dir_into_superproject_sp(const char *path,
>> +					 const char *super_prefix);
>> +static inline void absorb_git_dir_into_superproject(const char *path)
>> +{
>> +	absorb_git_dir_into_superproject_sp(path, NULL);
>> +}
>
> Is there a reason you chose to go with _sp() instead of changing the
> original function signature? I tested out that change, and it seems
> rather small (absorb_git_dir_into_superproject() only has 4 call sites).

I've just changed that, so no more *_sp()...

> Crucially, changing the signature catches a "git read-tree" call site:
>
>   diff --git a/submodule.c b/submodule.c
>   index d9fd0af81b..e79a04d3e3 100644
>   --- a/submodule.c
>   +++ b/submodule.c
>   @@ -2139,7 +2139,9 @@ int submodule_move_head(const char *path,
>           if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
>                   if (old_head) {
>                           if (!submodule_uses_gitfile(path))
>   -                               absorb_git_dir_into_superproject(path);
>   +                               /* Pass super_prefix properly later. */
>   +                               absorb_git_dir_into_superproject(path,
>   +                                                                get_su=
per_prefix());
>                   } else {
>                           struct strbuf gitdir =3D STRBUF_INIT;
>                           submodule_name_to_gitdir(&gitdir, the_repositor=
y,
>
> which would otherwise be broken since we used to read the global super
> prefix, but we don't do that in this patch. This has no test coverage
> (bleh), but it shouldn't be too hard, something like:
>
>   git init super &&
>   cd super &&
>   # Create an unabsorbed submodule right in the worktree
>   git init sub &&
>   test_commit -C sub "foo" &&
>   git add sub &&
>   git commit -m "Add submodule" &&
>   test_commit "bar" &&
>   # This should invoke "git read-tree" and absorb the git dir.
>   # Or maybe we should invoke "git read-tree" directly?
>   git checkout --recurse-submodules HEAD^ 2>err &&
>   # Search for the shortened message
>   grep "Migrating submodule sub from sub to .git/modules/...." err

Ah! Yeah that is a good catch, and a great reason to do it this way.

I tried to come up with a test case that actually tested this. I.e. I
set a "here =3D 1" at that absorb_git_dir_into_superproject() in the diff
above, and then if BUG()'d out in that function, but the part where
we're about to recurse.

I couldn't get it to trigger, but I didn't look at it very
long. I.e. doesn't this require not this sort of test, but something
where it's being absorbed, *and* we'd walk and absorb it recursiveyl?

At least with checkout we then run into an error (can't remember the
message, sorry, this was earlier), and I haven't found a way to trigger
it.

But I'll poke it some more, but if you happen to have a test case for it
that would really help...
