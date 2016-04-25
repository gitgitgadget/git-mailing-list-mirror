From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 1/3] submodule clone: pass along `local` option
Date: Mon, 25 Apr 2016 14:18:42 +0200
Message-ID: <65302315-2C33-4801-887C-9AF3CB2F6BB6@gmail.com>
References: <1460504929-19208-1-git-send-email-sbeller@google.com> <1460504929-19208-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, gitster@pobox.com, jacob.keller@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 14:18:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aufTa-0003Go-8L
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 14:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbcDYMSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 08:18:46 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38003 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932325AbcDYMSo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 08:18:44 -0400
Received: by mail-wm0-f52.google.com with SMTP id u206so124121424wme.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 05:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YF9vouGAdlL74fT1WQ5MHb0sf9x02zcrT8mPaxV/DjY=;
        b=spqCr09LL/Kg/LX67WBNxFlc5K+YfHVt1o1aYY4RXyMTGJ0u8TcsgNqcQkZGbARQhz
         kUYAqrV/zvB5srURahbRiGUBZTaPEDtQgpuwia05U8EWwtVPQwouMBv301v9YQVt05t9
         BzU7L56vodh4FSaN4bFhKCNPVWGEYf/7UZACJE9yHPmZxYn7MYkwWvympH/hz5DZxRE5
         qX4k0zZFROeGWw/7fWOkcGNX0k3vPKzRW9JzQIz0zfoG01Exi2JJsdIn3XrJXAQcT2fm
         Z9JkGCijasCXJJIbZdQml1rbRP7Wy/2m9ywKpWvsQGMdeh5T/0LKWoh6LK9yzK/BLi7g
         KBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YF9vouGAdlL74fT1WQ5MHb0sf9x02zcrT8mPaxV/DjY=;
        b=Sl2b2/L44OofDV92jhItMeFSHYyeE8IGxs1sFLH2wAUAKaffzf+5thST9xNbd48YYj
         Fam213tf3RYLR0qNzKwGIMUXJh++9wgfJc55O0MeX3ljw7QSMNe6NES7Dm9JSRdgLGnp
         sEPkFjFBPz1RyZXuSZ5aRYqJvh8y4lVlhA/6Yg9IqzuFArWDDsRMLpxp+k3ml0RS1L4y
         3L+2BmhNTSF+ljZwfOMbegds5PLJolnPE5NmL5HBEWAWQvlTEMsMxVT9u7R9RIAmKV9z
         PGf1rXN1hWt+1z0Ta2LX2suTUjaY/eHfn3HJJEybJIEvQYKcXp6Id+Brzw5RHpnffB4N
         a1Ow==
X-Gm-Message-State: AOPr4FUInzCruq+9QRdCnz2SNixuimsurn//Fikv/uLUBy0h53nOQkXgV3mqm+/1NRYyUA==
X-Received: by 10.28.125.138 with SMTP id y132mr6598600wmc.90.1461586722847;
        Mon, 25 Apr 2016 05:18:42 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id da5sm23391369wjb.25.2016.04.25.05.18.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 05:18:42 -0700 (PDT)
In-Reply-To: <1460504929-19208-2-git-send-email-sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292471>


> On 13 Apr 2016, at 01:48, Stefan Beller <sbeller@google.com> wrote:
> 
> When cloning a local repository, the user may choose to use an optimization
> such that the transfer uses a Git agnostic protocol. Propagate the users
> choice to submodules or if they don't choose, propagate nothing.
> A test will be added in a later patch.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> builtin/clone.c             | 14 ++++++++++++++
> builtin/submodule--helper.c | 22 +++++++++++++++++++---
> git-submodule.sh            |  7 +++++++
> 3 files changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index b004fb4..7453244 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -727,6 +727,20 @@ static int checkout(void)
> 		struct argv_array args = ARGV_ARRAY_INIT;
> 		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
> 
> +		switch (option_local) {
> +		case 1:
> +			argv_array_push(&args, "--local");
> +			break;
> +		case 0:
> +			argv_array_push(&args, "--no-local");
> +			break;
> +		case -1:
> +			/* pass nothing */
> +			break;
> +		default:
> +			die("BUG: option_local out of range");
> +		}
> +
> 		if (max_jobs != -1)
> 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
> 
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a484945..822ec69 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -125,7 +125,8 @@ static int module_name(int argc, const char **argv, const char *prefix)
> 	return 0;
> }
> static int clone_submodule(const char *path, const char *gitdir, const char *url,
> -			   const char *depth, const char *reference, int quiet)
> +			   const char *depth, const char *reference, int quiet,
> +			   int local)
> {
> 	struct child_process cp;
> 	child_process_init(&cp);
> @@ -140,6 +141,10 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
> 		argv_array_pushl(&cp.args, "--reference", reference, NULL);
> 	if (gitdir && *gitdir)
> 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
> +	if (local == 1)
bikeshedding: Why do you use == 1 here and !local below? I would either compare both against
integers or none ("if (local)" should work here, too, no?). Or is this a Git coding guideline
that I am not yet aware of?


> +		argv_array_push(&cp.args, "--local");
> +	else if (!local)
> +		argv_array_push(&cp.args, "--no-local");
> 
> 	argv_array_push(&cp.args, url);
> 	argv_array_push(&cp.args, path);
> @@ -156,6 +161,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
> 	const char *path = NULL, *name = NULL, *url = NULL;
> 	const char *reference = NULL, *depth = NULL;
> 	int quiet = 0;
> +	int local = -1;
> 	FILE *submodule_dot_git;
> 	char *sm_gitdir, *cwd, *p;
> 	struct strbuf rel_path = STRBUF_INIT;
> @@ -180,6 +186,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
> 		OPT_STRING(0, "depth", &depth,
> 			   N_("string"),
> 			   N_("depth for shallow clones")),
> +		OPT_BOOL(0, "local", &local,
> +			 N_("to clone from a local repository")),
TBH I think "local" could be misleading here. How about "--pass-transfer-protocol-on-to-submodules" 
or something? If I understand this option correctly then this could be useful for other cases besides
"local". Imagine you clone a repo via HTTPS that has references to SSH submodules on the same
server. If you don't have a proper SSH setup then the submodule clone will fail.


> 		OPT__QUIET(&quiet, "Suppress output for cloning a submodule"),
> 		OPT_END()
> 	};
> @@ -200,7 +208,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
> 	if (!file_exists(sm_gitdir)) {
> 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
> 			die(_("could not create directory '%s'"), sm_gitdir);
> -		if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
> +		if (clone_submodule(path, sm_gitdir, url, depth, reference,
> +				    quiet, local))
> 			die(_("clone of '%s' into submodule path '%s' failed"),
> 			    url, path);
> 	} else {
> @@ -266,6 +275,7 @@ struct submodule_update_clone {
> 
> 	/* configuration parameters which are passed on to the children */
> 	int quiet;
> +	int local;
> 	const char *reference;
> 	const char *depth;
> 	const char *recursive_prefix;
> @@ -278,7 +288,7 @@ struct submodule_update_clone {
> 	unsigned quickstop : 1;
> };
> #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
> -	SUBMODULE_UPDATE_STRATEGY_INIT, 0, NULL, NULL, NULL, NULL, \
> +	SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, NULL, NULL, NULL, NULL, \
> 	STRING_LIST_INIT_DUP, 0}
> 
> /**
> @@ -367,6 +377,10 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
> 	child->err = -1;
> 	argv_array_push(&child->args, "submodule--helper");
> 	argv_array_push(&child->args, "clone");
> +	if (suc->local == 1)
> +		argv_array_push(&child->args, "--local");
> +	else if (!suc->local)
> +		argv_array_push(&child->args, "--no-local");
> 	if (suc->quiet)
> 		argv_array_push(&child->args, "--quiet");
> 	if (suc->prefix)
> @@ -451,6 +465,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
> 		OPT_STRING(0, "depth", &suc.depth, "<depth>",
> 			   N_("Create a shallow clone truncated to the "
> 			      "specified number of revisions")),
> +		OPT_BOOL(0, "local", &suc.local,
> +			 N_("to clone from a local repository")),
same as above


> 		OPT_INTEGER('j', "jobs", &max_jobs,
> 			    N_("parallel jobs")),
> 		OPT__QUIET(&suc.quiet, N_("don't print cloning progress")),
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 86018ee..4d5e8c7 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -653,6 +653,12 @@ cmd_update()
> 		--jobs=*)
> 			jobs=$1
> 			;;
> +		--local)
> +			option_local="--local"
> +			;;
> +		--no-local)
> +			option_local="--no-local"
> +			;;
> 		--)
> 			shift
> 			break
> @@ -680,6 +686,7 @@ cmd_update()
> 		${reference:+--reference "$reference"} \
> 		${depth:+--depth "$depth"} \
> 		${jobs:+$jobs} \
> +		${option_local:+$option_local} \
> 		"$@" || echo "#unmatched"
> 	} | {
> 	err=
> -- 
> 2.5.0.264.gc776916.dirty
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
