From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 12/14] pull: configure --rebase via branch.<name>.rebase
 or pull.rebase
Date: Mon, 18 May 2015 16:58:43 -0700
Message-ID: <CAGZ79kar5AOrK1-n3=PAxNETbh-YWTf1-9aUKk=j6o0Mk=jexg@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<1431961571-20370-13-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 19 01:59:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuUw3-0007ji-Lv
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 01:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbbERX6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 19:58:44 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33262 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932200AbbERX6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 19:58:44 -0400
Received: by igbpi8 with SMTP id pi8so92927160igb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 16:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8l0KToe1vYVAZa9eyOAmorqLgNbFAwZxGZVDSTxF0vU=;
        b=fARvkj2ZjgQMMaBWkoDYlIk05SLSwyjl7ky1JdHmjdgAdVTCGE044ogFXGtU8L9AUQ
         ARJNjkLBEPApyoAKnN7X3QABYE/TsVGKklcS0Jy9M1DyGqg9307RY2aLr3X+Mt558r8d
         1gIfJP1xnCfzq6t1X7QXGruEVsssksG5BozFmpqQDOnB8td4D7grNqn0vb3y6nXFCMlr
         Uot8aCLkv1h9tTCv/NJgoqK9COoS+uQA1VI/bzT4NxiGQstIXFB40Be7J5gGXQVnLTvd
         HI3MvrENajE6Votg4YN3kqn5gU0c98kd1x6kI4sbZ13jX0Zz7BDhPSFFiEoixIdQPMW1
         0UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=8l0KToe1vYVAZa9eyOAmorqLgNbFAwZxGZVDSTxF0vU=;
        b=NDeVUHOuDoVpiMiqgTLF7BlPt5e/qpgABuUL0V3cb6jBcrbZnp4Rwty9ohzOUHCFqk
         SpIA7J8bGcl3SW2NDYzRgIfye2qsDpqNINdp76Jb6kLGFOrIB/PWdMJEDN0lrhr3E8qh
         KaukYMSlF8WLVo8aF4R2WY5q4m2QejhVieHCJ+MiGQLffYY3tyX8KAsJc6+sZzhMM8Z6
         TZdaQrKP3xnm+bu90WkKvdc066nHc8c0fAsQfk98Z0slM+/PpN78zA0JtXcA+3vsAkss
         6huwgvCO7aRpLi/L6LYG6bCPB3O97dFj6yfUJjbBvbDfY7QpiSm5GMemZMuR6Auw/P3W
         c35w==
X-Gm-Message-State: ALoCoQkzIxuzgRAbaC/DRIOzCv/ubMdVEYxt7p/PoH2y+7OCuBxmXdlgv8Rl3TYGuvrfha2QK3Fd
X-Received: by 10.107.8.144 with SMTP id h16mr498118ioi.49.1431993523315; Mon,
 18 May 2015 16:58:43 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Mon, 18 May 2015 16:58:43 -0700 (PDT)
In-Reply-To: <1431961571-20370-13-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269332>

On Mon, May 18, 2015 at 8:06 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Since cd67e4d (Teach 'git pull' about --rebase, 2007-11-28),
> fetch+rebase could be set by default by defining the config variable
> branch.<name>.rebase. This setting can be overriden on the command line
> by --rebase and --no-rebase.
>
> Since 6b37dff (pull: introduce a pull.rebase option to enable --rebase,
> 2011-11-06), git-pull --rebase can also be configured via the
> pull.rebase configuration option.
>
> Re-implement support for these two configuration settings by introducing
> config_get_rebase() which is called before parse_options() to set the
> default value of opt_rebase.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  builtin/pull.c  | 35 +++++++++++++++++++++++++++++++++++
>  t/t5520-pull.sh | 12 ++++++------
>  2 files changed, 41 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index f18a21c..a0958a7 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -294,6 +294,39 @@ static const char *config_get_ff(void)
>         die(_("Invalid value for pull.ff: %s"), value);
>  }
>
> +/**
> + * Returns the default configured value for --rebase. It first looks for the
> + * value of "branch.$curr_branch.rebase", where $curr_branch is the current
> + * branch, and if HEAD is detached or the configuration key does not exist,
> + * looks for the value of "pull.rebase". If both configuration keys do not
> + * exist, returns REBASE_FALSE.
> + */
> +static int config_get_rebase(void)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +       struct branch *curr_branch = branch_get("HEAD");
> +       const char *key, *str;
> +       int ret = -1, value;
> +
> +       if (curr_branch) {
> +               strbuf_addf(&sb, "branch.%s.rebase", curr_branch->name);
> +               key = sb.buf;
> +               ret = git_config_get_value(sb.buf, &str);
> +       }
> +       if (ret) {
> +               key = "pull.rebase";
> +               ret = git_config_get_value(key, &str);
> +       }
> +       if (ret) {
> +               strbuf_release(&sb);
> +               return REBASE_FALSE;
> +       }
> +       if ((value = parse_config_rebase(str)) < 0)

Assignment inside an if (....).
I just looked up the Documentation/CodingGuidelines
which state it as:
 - We try to avoid assignments inside "if ()" conditions.
so my hint from my previous mail (to also apply it to for/while)
is wrong.

Initially the flow confused me a little, so I tried to understand why,
and I guess it's because of the return value used both as a return value
and as conditional.

Maybe you could move the check of the value out of this function
and here you only focus on getting the order right?
Something like (completely untested code, beware):

enum rebase_type config_get_rebase(void)
{
    struct strbuf sb = STRBUF_INIT;
    enum rebase_type value;

    struct branch *curr_branch = branch_get("HEAD");

    if (curr_branch) {
        strbuf_addf(&sb, "branch.%s.rebase", curr_branch->name);
        if (parse_config_rebase_or_die_on_unparsable(sb.buf, &value))
            return value;
    }

    if (parse_config_rebase_or_die_on_unparsable("pull.rebase", &value))
        return value;

    return REBASE_FALSE;
}

This implementation leaks the strbuf though.


> +               die(_("Invalid value for %s: %s"), key, str);
> +       strbuf_release(&sb);
> +       return value;
> +}
> +
>  struct known_remote {
>         struct known_remote *next;
>         struct remote *remote;
> @@ -730,6 +763,8 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>         if (!getenv("GIT_REFLOG_ACTION"))
>                 set_reflog_message(argc, argv);
>
> +       opt_rebase = config_get_rebase();
> +
>         argc = parse_options(argc, argv, prefix, pull_options, pull_usage, 0);
>         parse_repo_refspecs(argc, argv, &repo, &refspecs);
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 3798b96..17254ee 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -234,7 +234,7 @@ test_expect_success '--rebase fails with multiple branches' '
>         test modified = "$(git show HEAD:file)"
>  '
>
> -test_expect_failure 'pull.rebase' '
> +test_expect_success 'pull.rebase' '
>         git reset --hard before-rebase &&
>         test_config pull.rebase true &&
>         git pull . copy &&
> @@ -242,7 +242,7 @@ test_expect_failure 'pull.rebase' '
>         test new = "$(git show HEAD:file2)"
>  '
>
> -test_expect_failure 'branch.to-rebase.rebase' '
> +test_expect_success 'branch.to-rebase.rebase' '
>         git reset --hard before-rebase &&
>         test_config branch.to-rebase.rebase true &&
>         git pull . copy &&
> @@ -280,7 +280,7 @@ test_expect_success 'pull.rebase=false create a new merge commit' '
>         test file3 = "$(git show HEAD:file3.t)"
>  '
>
> -test_expect_failure 'pull.rebase=true flattens keep-merge' '
> +test_expect_success 'pull.rebase=true flattens keep-merge' '
>         git reset --hard before-preserve-rebase &&
>         test_config pull.rebase true &&
>         git pull . copy &&
> @@ -288,7 +288,7 @@ test_expect_failure 'pull.rebase=true flattens keep-merge' '
>         test file3 = "$(git show HEAD:file3.t)"
>  '
>
> -test_expect_failure 'pull.rebase=1 is treated as true and flattens keep-merge' '
> +test_expect_success 'pull.rebase=1 is treated as true and flattens keep-merge' '
>         git reset --hard before-preserve-rebase &&
>         test_config pull.rebase 1 &&
>         git pull . copy &&
> @@ -296,7 +296,7 @@ test_expect_failure 'pull.rebase=1 is treated as true and flattens keep-merge' '
>         test file3 = "$(git show HEAD:file3.t)"
>  '
>
> -test_expect_failure 'pull.rebase=preserve rebases and merges keep-merge' '
> +test_expect_success 'pull.rebase=preserve rebases and merges keep-merge' '
>         git reset --hard before-preserve-rebase &&
>         test_config pull.rebase preserve &&
>         git pull . copy &&
> @@ -304,7 +304,7 @@ test_expect_failure 'pull.rebase=preserve rebases and merges keep-merge' '
>         test "$(git rev-parse HEAD^2)" = "$(git rev-parse keep-merge)"
>  '
>
> -test_expect_failure 'pull.rebase=invalid fails' '
> +test_expect_success 'pull.rebase=invalid fails' '
>         git reset --hard before-preserve-rebase &&
>         test_config pull.rebase invalid &&
>         ! git pull . copy
> --
> 2.1.4
>
