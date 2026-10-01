Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBE247DF95
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876653; cv=pass; b=HPjkVdjtmGJpHWbjCU4dly4EKiZRqtYEs/Jx+eGQcV6N766oh8tkoZelM7LbuB3z1twFtZ5c1SHTttGaNYt0YySOmGaSmacT1+lTeiffh8E1aVsl78IUeAgG1h+99bR5VahdvxZoZ8ltOE0jPuiWJkvapew+T9w9V6qoYmpYqI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876653; c=relaxed/simple;
	bh=wn/4/+20hwIJakKkvFcwn4dnaO77O3FnOtc13pbnfe8=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FToMkTq6pSB7GILbKADlmbqKtAADBlV6Ala0Ix08I7SNmlujPJ2R62pbu587Ckk31ttWwgoUgt4hAqA6L70qLmtm1J43DF7hgRQVg8qzJEXKvgxsnmxLVNCtggfJe6bezESfCDZO1Jz1zGbltQCItYeCaYYw/2zLDcy9EtRyODM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com; spf=pass smtp.mailfrom=kanamei.com; dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b=B0m+H89A; arc=pass smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kanamei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b="B0m+H89A"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-347866278b6so2485804eec.2
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 10:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790876642; cv=none;
        d=google.com; s=arc-20260327;
        b=HTe/PusisSyGk+iUGzhXxWegClCvsdgvupAxrE49uJ0PWg/jP8BYz9/jPYQ6TPth64
         iZOJ4eu3rga4WMrQzjYjotBQYD6MPWf/ADuSTo9oIJYuvRBmGxmwoV98ypxvUBH4ERE0
         tRf8yuaU2i0VkZat+bczI0lG9tnSNU8xHU0ICpH/awv9YUNNaxdkE6ytZnnhU5QkXr8M
         0/kBnwPovb3RXu2dgJLZLvE59c+HP1lqlnbzx0C3PpVG+IjV2VODKtdHQbquTHj8cg0E
         odemKqrYAtbsHwTIqYw/aAkpqHrVyVx8F1bZ3itoC8sSdmRnLXf+3cXyByVavdcX/Ypn
         mTbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=wn/4/+20hwIJakKkvFcwn4dnaO77O3FnOtc13pbnfe8=;
        fh=4whAYCPW/OAoi666UReR1NFju3LCK6wWcBiRFrcki7k=;
        b=Inef1T6BwLciDVPbU16WdXFE8RenxW9w+9cky2BwwNyzvxOI5S3kvdVF2YyHk8Ssi9
         /nr3ppUg0XlW1IClK6r/HH8x4iMaGs+EbaojMdGMB4K3ClrNyJAsn50gMuaalnhyaIO3
         5RcVA815GRUb6SVkMiEoPLUnwtddznvqATupEyFpyfi6EKIqO43zTpDvDMhvPSyMLYOE
         o6v5403MU/ZDoS7XVRyHyJwWHYJ9Wy3IKuuYhP4t8EhTXxUuXwyjjxhGRZLdUqiocjsq
         N+rLL2Tnib+eD4CY4BPPRE5tye+tNeSNKocSe/gUtwaPkXOmcGuP3ZH/QCKwbKNjw1EZ
         0Ksg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kanamei-com.20251104.gappssmtp.com; s=20251104; t=1790876642; x=1791481442; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wn/4/+20hwIJakKkvFcwn4dnaO77O3FnOtc13pbnfe8=;
        b=B0m+H89AJoCt+mICQu5guHqRH4Vnl5AXPsEsKwAvQS7lWnma9GqGoOjSHOCRQ3r6aS
         vVz4kSzWh9aVrSFAmliG+taIDi9ImvepEoVZkNMr6wdONcAZtlFmGFjbKJYNgq0MNEt9
         gIZLRPi2G72B+hTczaXDMybjQok3ERecMXNe1MKVtNgWBD78gPWicmtTEKn0KIO2rbkk
         1b124qGQKHyDopOZZviTFBFBrfmINtXPINYErtVwbGM5rW1+dvUIfHKDOOt3aFvmILhP
         XVxPAugc/m5//kyQid+zBc3nr9/CAkIOT2PrOaE9jlPj7QY8YRSYjdcIxUllCn/VNpIN
         Ha/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790876642; x=1791481442;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wn/4/+20hwIJakKkvFcwn4dnaO77O3FnOtc13pbnfe8=;
        b=EbNMVurzy563uGBFfXEFG1wR89tqRnluwIQyx8tMbjAd3Br5rAL47JRwnUvTTGRU2x
         20RCnisVMmnNKQ+xC3RnmohZOKVyuwuNvgMR1EbBbHVrPAei/T2wzQYm3y1cJUofZgkP
         lVe59bbaWmilt+ydY2283l3t/dliEL8O6Z6fBeqoYVeXZTwcp3VAGg22hwxvajIsvLcd
         4Cl03yaynA9OUaWuU6IXCNKAoLbYX1q7RZUvdsVhgf3Qsb3nA2P2mA7XAeVoPqf40En4
         8gNO3LSt3t8PIbnqmTPWMpFuLAR7NwdCcN2VG7svX3ypGxP9c8TvzMpdPGZ6OOuJVflm
         BMsw==
X-Gm-Message-State: AFuF++nwZGB9nxOqIRHZAXpLzeqL9z/8WEO5LCRNdG6zVMnpEnXobFsA
	U8YAyMB19NGWqjZ0UT1TpDU67SBr8QPUfdIHlPVKo4qcRBLcb+LkxAzBnQZOeErPi43U4p+f0UU
	Jx8QpywoFiyzO8lohvik7qiTc9T+rwPJazjsaxHAEhA==
X-Gm-Gg: AYBFou3h9wKJs10nl5F7EW9UYYqWQ0GOoLPx5prvLNrzNqRWmrKF23HPnyYxsuh/Q5+
	OYT/MIu0JpDAibIy8qp2oRqMOyZxZdOK3D3CSOcX0V3Hj5kcxZg8ZpG60ML7eIncqYXW/eZkIYH
	f8HdS/rWB5U29kFXn0bYddW3dK2KFCv6D5/cvg/t/ZvXmgjllHDIw3ll19dVQPSOXORUNzfCNnI
	WYFdi7tfWQpF+bhZ5x8TgY9TDoL7JSRgxxNQVLSHA34o3r23k73FQPsnLNwfUesglsLHq5PY3Th
	kxt2lpi5jhrd9EM+NzpBoDMcWZhzOi+vP6cssZqio9YwI/9VWTXxYw==
X-Received: by 2002:a05:7300:6a99:b0:34d:2c1a:9881 with SMTP id
 5a478bee46e88-34d2c1a9d9bmr4942220eec.36.1790876641874; Thu, 01 Oct 2026
 10:44:01 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 1 Oct 2026 19:44:00 +0200
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 1 Oct 2026 19:44:00 +0200
In-Reply-To: <8453ebd1-77c1-4941-afbf-572f9e7b12c1@gmail.com>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com> <8453ebd1-77c1-4941-afbf-572f9e7b12c1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>
Date: Thu, 1 Oct 2026 19:44:00 +0200
X-Gm-Features: AclHuK-Cp5kCon9ORh5qxHYdFNfiIs4Zjea9DO4CMD3aNYlQpimEngSK_bFKk8o
Message-ID: <CANUHOw201hr2LgHb1ThcadiH8Y5k3zUArnhtj8g8SRVrvMsN-g@mail.gmail.com>
Subject: Re: [PATCH] stash: expose untracked modes in create
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Phillip,

Thanks for the review.

Sorry, I got a little carried away and sent v2 before replying.

> This doesn't seem to match the code changes.

For the no-change case, plain "git stash create" already checks for
tracked changes before calling do_create_stash(), and returns 0 with
empty output when there is nothing to create.

For -u and -a, I think we should follow that existing "create" behavior
as well, using check_changes() for the selected mode before calling
do_create_stash(), and returning 0 when it finds nothing to create.

I am also thinking of mapping do_create_stash()'s internal no-change
status of 1 to 0 in the unlikely case where the state changes between
these checks. That 1 is not STASH_APPLY_CONFLICT. Following 786fc390465f
("stash: reserve exit status 1 for conflicts"), I do not think it should
escape as public exit status 1, and would map it to 0 instead.

> You should pass PARSE_OPT_STOP_AT_NON_OPTION to parse_options()
> to prevent that.

I plan to use PARSE_OPT_STOP_AT_NON_OPTION as you suggested.

Thanks,

Kazumasa Shigeta


On Tue, 29 Sep 2026 17:08:08 +0100, Phillip Wood
<phillip.wood123@gmail.com> wrote:
> Hi Kazumasa
>
> On 29/09/2026 08:42, Kazumasa Shigeta wrote:
> > `git stash create` always passes zero for the include_untracked parameter
> > of do_create_stash(), even though that helper already supports untracked
> > and ignored files and stash push/save expose those modes as
> > -u/--include-untracked and -a/--all.
> >
> > Teach create to accept the same options and pass the existing mode
> > through. Unlike push/save, create continues to only create objects: it
> > does not update refs/stash or modify the index or working tree.
> >
> > When the selected mode finds no changes, do_create_stash() returns 1.
> > Translate that to success so create keeps its existing no-object, empty
> > output behavior.
>
> This doesn't seem to match the code changes. The code that prints the
> object id when the stash is successfully created is unchanged, as far as
> I can see what this patch does is change the exit status for "git stash
> create" when there are no changes to stash. Instead of exiting 1, it
> exits 0 even though it does not create a stash. That does not seem like
> a good idea.
>
> > Use normal parse-options semantics, so options may appear after message
> > arguments. A message that begins with a dash can be disambiguated with
>
> As "git stash create" concatenates excess arguments to use as the stash
> message we should not be permuting options. "git stash create handle new
> -u flag" should continue to create a stash with the message "handle new
> -u flag" - it should not start stashing untracked files. You should pass
> PARSE_OPT_STOP_AT_NON_OPTION to parse_options() to prevent that.
>
> > I proposed adding both --include-untracked and --all to
> > "git stash create" in 2014:
> > <1403856479-37421-1-git-send-email-shigeta@kanamei.co.jp>
> >
> > I should also apologize for dropping that thread after receiving review.
> > I did not follow up on the comments at the time. Thanks to those who
> > reviewed it then.
>
> Better late than never! I think the idea is fine, but the implementation
> could do with a couple of tweaks so it is as backward compatible as
> possible.
>
> Thanks
>
> Phillip
>
> > Separately, in 2017, Thomas Gummerer added an internal -u path while
> > refactoring stash_create in 9ca6326dff29 (stash: refactor stash_create).
> > That change explicitly kept the user interface of "git stash create"
> > unchanged.
> >
> > When "stash create" was later converted to the builtin C implementation
> > in d4788af875cc (stash: convert create to builtin), the untracked-file
> > handling was carried into the new implementation and remains there today.
> >
> > More recently, Shabbir Bhojani proposed exposing --include-untracked:
> > <pull.1892.git.1774768580147.gitgitgadget@gmail.com>
> >
> > This patch exposes both existing untracked modes, --include-untracked and
> > --all, to "git stash create".
> >
> > Documentation/git-stash.adoc | 18 ++++++----
> > builtin/stash.c | 36 ++++++++++++++-----
> > t/t3903-stash.sh | 70 ++++++++++++++++++++++++++++++++++++
> > 3 files changed, 109 insertions(+), 15 deletions(-)
> >
> > diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
> > index fc6a9a0..32f0fd5 100644
> > --- a/Documentation/git-stash.adoc
> > +++ b/Documentation/git-stash.adoc
> > @@ -21,7 +21,7 @@ git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | -
> > git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
> > [-u | --include-untracked] [-a | --all] [<message>]
> > git stash clear
> > -git stash create [<message>]
> > +git stash create [-u | --include-untracked] [-a | --all] [<message>]
> > git stash store [(-m | --message) <message>] [-q | --quiet] <commit>
> > git stash export (--print | --to-ref <ref>) [<stash>...]
> > git stash import <commit>
> > @@ -138,10 +138,12 @@ with no conflicts.
> > `drop [-q | --quiet] [<stash>]`::
> > Remove a single stash entry from the list of stash entries.
> >
> > -`create`::
> > +`create [-u | --include-untracked] [-a | --all]`::
> > Create a stash entry (which is a regular commit object) and
> > return its object name, without storing it anywhere in the ref
> > - namespace.
> > + namespace. The `--include-untracked` option includes untracked
> > + files, while `--all` also includes ignored files, without modifying
> > + the working tree.
> > This is intended to be useful for scripts. It is probably not
> > the command you want to use; see "push" above.
> >
> > @@ -167,10 +169,11 @@ OPTIONS
> > -------
> > `-a`::
> > `--all`::
> > - This option is only valid for `push` and `save` commands.
> > + When used with the `push` and `save` commands, all ignored and
> > + untracked files are also stashed and then cleaned up with `git clean`.
> > +
> > -All ignored and untracked files are also stashed and then cleaned
> > -up with `git clean`.
> > +When used with the `create` command, ignored and untracked files are included
> > +in the stash entry without modifying the working tree.
> >
> > `-u`::
> > `--include-untracked`::
> > @@ -179,6 +182,9 @@ up with `git clean`.
> > all untracked files are also stashed and then cleaned up with
> > `git clean`.
> > +
> > +When used with the `create` command, untracked files are included in the
> > +stash entry without modifying the working tree.
> > ++
> > When used with the `show` command, show the untracked files in the stash
> > entry as part of the diff.
> >
> > diff --git a/builtin/stash.c b/builtin/stash.c
> > index 7a98434..57a4750 100644
> > --- a/builtin/stash.c
> > +++ b/builtin/stash.c
> > @@ -59,7 +59,7 @@
> > N_("git stash save [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]\n" \
> > " [-u | --include-untracked] [-a | --all] [<message>]")
> > #define BUILTIN_STASH_CREATE_USAGE \
> > - N_("git stash create [<message>]")
> > + N_("git stash create [-u | --include-untracked] [-a | --all] [<message>]")
> > #define BUILTIN_STASH_EXPORT_USAGE \
> > N_("git stash export (--print | --to-ref <ref>) [<stash>...]")
> > #define BUILTIN_STASH_IMPORT_USAGE \
> > @@ -119,6 +119,11 @@ static const char * const git_stash_clear_usage[] = {
> > NULL
> > };
> >
> > +static const char * const git_stash_create_usage[] = {
> > + BUILTIN_STASH_CREATE_USAGE,
> > + NULL
> > +};
> > +
> > static const char * const git_stash_store_usage[] = {
> > BUILTIN_STASH_STORE_USAGE,
> > NULL
> > @@ -1643,26 +1648,39 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
> > return ret;
> > }
> >
> > -static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
> > +static int create_stash(int argc, const char **argv, const char *prefix,
> > struct repository *repo UNUSED)
> > {
> > - int ret;
> > + int ret = 0;
> > + int include_untracked = 0;
> > + struct option options[] = {
> > + OPT_BOOL('u', "include-untracked", &include_untracked,
> > + N_("include untracked files in stash")),
> > + OPT_SET_INT('a', "all", &include_untracked,
> > + N_("include ignored files in stash"),
> > + INCLUDE_ALL_FILES),
> > + OPT_END()
> > + };
> > struct strbuf stash_msg_buf = STRBUF_INIT;
> > struct stash_info info = STASH_INFO_INIT;
> > struct pathspec ps;
> >
> > - /* Starting with argv[1], since argv[0] is "create" */
> > - strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
> > + argc = parse_options(argc, argv, prefix, options,
> > + git_stash_create_usage, 0);
> > + strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
> >
> > memset(&ps, 0, sizeof(ps));
> > - if (!check_changes_tracked_files(&ps))
> > - return 0;
> > + if (!include_untracked && !check_changes_tracked_files(&ps))
> > + goto done;
> >
> > - ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
> > - NULL, 0);
> > + ret = do_create_stash(&ps, &stash_msg_buf, include_untracked, 0, NULL,
> > + 0, &info, NULL, 0);
> > if (!ret)
> > printf_ln("%s", oid_to_hex(&info.w_commit));
> > + else if (ret == 1)
> > + ret = 0;
> >
> > +done:
> > free_stash_info(&info);
> > strbuf_release(&stash_msg_buf);
> > return ret;
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index 7211586..fe34879 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -640,6 +640,76 @@ test_expect_success 'stash create - no changes' '
> > test_must_be_empty actual
> > '
> >
> > +# --all observes every untracked and ignored path in the worktree. Use one
> > +# isolated repository for these checks so unrelated test state is not captured.
> > +test_expect_success 'stash create with untracked options' '
> > + test_when_finished "rm -rf stash-create-options" &&
> > + test_create_repo stash-create-options &&
> > + (
> > + cd stash-create-options &&
> > + test_commit base tracked base &&
> > + echo create-ignored >.gitignore &&
> > + git add .gitignore &&
> > + git commit -m ignore &&
> > +
> > + git stash create -u >.git/actual &&
> > + test_must_be_empty .git/actual &&
> > + git stash create -a >.git/actual &&
> > + test_must_be_empty .git/actual &&
> > +
> > + echo untracked >create-untracked &&
> > + git stash create "without untracked" >.git/actual &&
> > + test_must_be_empty .git/actual &&
> > + short=$(git stash create "create untracked" -u) &&
> > + long=$(git stash create --include-untracked "create untracked") &&
> > + test_cmp_rev "$short^3^{tree}" "$long^3^{tree}" &&
> > + echo untracked >.git/expect &&
> > + git show "$short^3:create-untracked" >.git/actual &&
> > + test_cmp .git/expect .git/actual &&
> > + branch=$(git symbolic-ref --short HEAD) &&
> > + echo "On $branch: create untracked" >.git/expect &&
> > + git show --pretty=%s -s "$short" >.git/actual &&
> > + test_cmp .git/expect .git/actual &&
> > + test_path_is_file create-untracked &&
> > +
> > + echo ignored >create-ignored &&
> > + with_untracked=$(git stash create -u "create options") &&
> > + test_must_fail git cat-file -e "$with_untracked^3:create-ignored" &&
> > + short=$(git stash create "create options" -a) &&
> > + long=$(git stash create --all "create options") &&
> > + test_cmp_rev "$short^3^{tree}" "$long^3^{tree}" &&
> > + echo ignored >.git/expect &&
> > + git show "$short^3:create-ignored" >.git/actual &&
> > + test_cmp .git/expect .git/actual &&
> > + test_path_is_file create-untracked &&
> > + test_path_is_file create-ignored &&
> > +
> > + echo staged >staged &&
> > + git add staged &&
> > + echo modified >>tracked &&
> > + git diff >.git/before-worktree &&
> > + git diff --cached >.git/before-index &&
> > + git status --porcelain=v1 --ignored >.git/before-status &&
> > + test_must_fail git rev-parse --verify refs/stash >/dev/null 2>&1 &&
> > + STASH_ID=$(git stash create -a -- -create-message) &&
> > + git diff >.git/after-worktree &&
> > + git diff --cached >.git/after-index &&
> > + git status --porcelain=v1 --ignored >.git/after-status &&
> > + test_cmp .git/before-worktree .git/after-worktree &&
> > + test_cmp .git/before-index .git/after-index &&
> > + test_cmp .git/before-status .git/after-status &&
> > + test_must_fail git rev-parse --verify refs/stash >/dev/null 2>&1 &&
> > + echo "On $branch: -create-message" >.git/expect &&
> > + git show --pretty=%s -s "$STASH_ID" >.git/actual &&
> > + test_cmp .git/expect .git/actual
> > + )
> > +'
> > +
> > +test_expect_success 'stash create rejects unknown options' '
> > + test_expect_code 129 git stash create --unknown-option 2>err &&
> > + test_grep "unknown option" err
> > +'
> > +
> > test_expect_success 'stash branch - no stashes on stack, stash-like argument' '
> > git stash clear &&
> > test_when_finished "git reset --hard HEAD" &&
