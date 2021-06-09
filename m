Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A6FC48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 10:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6012861375
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 10:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbhFIKel (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 06:34:41 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:43756 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbhFIKej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 06:34:39 -0400
Received: by mail-pl1-f174.google.com with SMTP id v12so12286582plo.10
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 03:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7+qC/i4ssDaUsxrSQpT101WeueHMz2oeIeXsNgZpvOA=;
        b=iIV4/SV60tJ6BYei7tLlJxCgl2/MfOfcKd84aJ8Z5plv+50zAOQ/FvKFinhV6Pf7G3
         hmx8AfIKUZflRpAe0tamBbqGvTtntea+XFCCH4DJz5axYv9Q3OXVRAOS3YWpt/hn+oqI
         dDft4br2XXLLL+C5ke2pperqxfYkxZfQdszZ3zsto6zTgAR6hktJH/Y8k515U+LT5Oft
         mixGH8lphyRSWVpwF58cBqvSeRF5NSO/K95DFa5y5IbVDR0gFVK5C0cRuW3fIVoZSMm3
         Wjup/nYZUEAXP6590qt2/Fc7QhoKjIipG2ZoJLq9tYdwvbXs0F/xYQ/wEOdFk4kuRXOO
         PDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7+qC/i4ssDaUsxrSQpT101WeueHMz2oeIeXsNgZpvOA=;
        b=qqxfdZ6hlpULhoZZZCZcnfCRFoKpVmvGnaB7bMlMlfBTMQZof2w35GeyPPaeuc2qVY
         cdBcLuWQrJYsLUHwczNr17aDr9bomyfkHIF86bUP5Di4mj1N8fS6aSocRAfgblbtJpIy
         +KnZBgtqnPicPp66J0DZEx1TQDpywBXAfWB9EERJXo2F3DIKW225FalW74QAjUzymc/P
         pBGoUh/35Zsm/jM4eaj4B2QXVkwd+XxYpKaj0fx+ETeyIB7n+oxUlRmhZR9qdoKJljXo
         Aw1cbL+A8frXYw1cQ7m3nLlNBt/lLOzeQniSnE3HWEazPji8/e/lFfj+wHF3Y//YVkvK
         ioHw==
X-Gm-Message-State: AOAM531QHR3PbOmG4Fbhl0EdQTOaQGY6t29QGYACJ9aUmT48I9fOORFr
        jopA2Wa3692d22sEhjYEpA6YkKDM9xGnaKrq
X-Google-Smtp-Source: ABdhPJz7Xt0sEdvvnMPH178wTpO7IcQWkN+TR/He3meitQjWxmoaHWvUTRwih6ZCsp1HwDhsQQ6xpg==
X-Received: by 2002:a17:902:b10b:b029:113:7af5:a8bb with SMTP id q11-20020a170902b10bb02901137af5a8bbmr4406857plr.41.1623234704966;
        Wed, 09 Jun 2021 03:31:44 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id j7sm4935662pjf.0.2021.06.09.03.31.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:31:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] [PATCH v2 1/2] submodule--helper: introduce add-clone
 subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <YL9jTFAoEBP+mDA2@danh.dev>
Date:   Wed, 9 Jun 2021 16:01:40 +0530
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B9B2CD5-2B99-4BF3-B348-5766F1CEB6D7@gmail.com>
References: <20210605113913.29005-1-raykar.ath@gmail.com>
 <20210608095655.47324-1-raykar.ath@gmail.com>
 <20210608095655.47324-2-raykar.ath@gmail.com> <YL9jTFAoEBP+mDA2@danh.dev>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08-Jun-2021, at 18:02, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh =
<congdanhqx@gmail.com> wrote:
>=20
>> [...]
>> +static char *get_next_line(char *const begin, const char *const end)
>> +{
>> +	char *pos =3D begin;
>> +	while (pos !=3D end && *pos++ !=3D '\n');
>> +	return pos;
>> +}
>=20
> On my first glance, this function looks like a reinvention of =
strchr(3).
> Except that, this function also has a second parameter for "end".
> Maybe it has a specical use-case?
>=20
>> +
>> +static void show_fetch_remotes(FILE *output, const char *sm_name, =
const char *git_dir_path)
>> +{
>> +	struct child_process cp_remote =3D CHILD_PROCESS_INIT;
>> +	struct strbuf sb_remote_out =3D STRBUF_INIT;
>> +
>> +	cp_remote.git_cmd =3D 1;
>> +	strvec_pushf(&cp_remote.env_array,
>> +		     "GIT_DIR=3D%s", git_dir_path);
>> +	strvec_push(&cp_remote.env_array, "GIT_WORK_TREE=3D.");
>> +	strvec_pushl(&cp_remote.args, "remote", "-v", NULL);
>> +	if (!capture_command(&cp_remote, &sb_remote_out, 0)) {
>> +		char *line;
>> +		char *begin =3D sb_remote_out.buf;
>> +		char *end =3D sb_remote_out.buf + sb_remote_out.len;
>> +		while (begin !=3D end && (line =3D get_next_line(begin, =
end))) {
>=20
> And this is the only use-case.  Because you also want to check if you
> reached the last token or not.  I guess you really meant to write:
>=20
> 	while ((line =3D strchr(begin, '\n')) !=3D NULL) {
>=20
> Anyway, I would name the "line" variable as "nextline"
>=20
>> +			int namelen =3D 0, urllen =3D 0, taillen =3D 0;
>> +			char *name =3D parse_token(&begin, line, =
&namelen);
>> +			char *url =3D parse_token(&begin, line, =
&urllen);
>> +			char *tail =3D parse_token(&begin, line, =
&taillen);
>> +			if (!memcmp(tail, "(fetch)", 7))
>> +				fprintf(output, "  %.*s\t%.*s\n",
>> +					namelen, name, urllen, url);
>=20
> I think this whole block is better replaced with strip_suffix_mem and
> fprintf.
>=20
> Overral I would replace the block inside capture_command with:
>=20
> -----8<-----
> 	char *nextline;
> 	char *line =3D sb_remote_out.buf;
> 	while ((nextline =3D strchr(line, '\n')) !=3D NULL) {
> 		size_t len =3D nextline - line;
> 		if (strip_suffix_mem(line, &len, "(fetch)"))
> 			fprintf(output, "  %.*s\n", (int)len, line);
> 		line =3D nextline + 1;
> 	}
> ---->8-----
>=20
> And get rid of parse_token and get_next_line functions.

That looks much simpler. Thanks!

I realised that all the token parsing I do is not really necessary.
What I really want to do is "If this line ends with '(fetch)',
print it, but without the '(fetch)'", and I think your version
captures that succinctly.

>> +		}
>> +	}
>> +
>> +	strbuf_release(&sb_remote_out);
>> +}
>> +
>> +static int add_submodule(const struct add_data *add_data)
>> +{
>> +	char *submod_gitdir_path;
>> +	/* perhaps the path already exists and is already a git repo, =
else clone it */
>> +	if (is_directory(add_data->sm_path)) {
>> +		submod_gitdir_path =3D xstrfmt("%s/.git", =
add_data->sm_path);
>> +		if (is_directory(submod_gitdir_path) || =
file_exists(submod_gitdir_path))
>> +			printf(_("Adding existing path at '%s' to =
index\n"),
>> +			       add_data->sm_path);
>> +		else
>> +			die(_("'%s' already exists and is not a valid =
git repo"),
>> +			    add_data->sm_path);
>> +		free(submod_gitdir_path);
>> +	} else {
>> +		struct strvec clone_args =3D STRVEC_INIT;
>> +		struct child_process cp =3D CHILD_PROCESS_INIT;
>> +		submod_gitdir_path =3D xstrfmt(".git/modules/%s", =
add_data->sm_name);
>> +
>> +		if (is_directory(submod_gitdir_path)) {
>> +			if (!add_data->force) {
>> +				error(_("A git directory for '%s' is =
found "
>> +					"locally with remote(s):"), =
add_data->sm_name);
>=20
> We don't capitalise first character of error message.
> IOW, downcase "A git".

Got it.

> Well, it's bug-for-bug with shell implementation, so it doesn't matter =
much, anyway.

While it is meant to be a faithful implementation, I think this
is a good opportunity to make minor style fixes.

>> +				show_fetch_remotes(stderr, =
add_data->sm_name,
>> +						   submod_gitdir_path);
>> +				fprintf(stderr,
>> +					_("If you want to reuse this =
local git "
>> +					  "directory instead of cloning =
again from\n"
>> +					  "  %s\n"
>> +					  "use the '--force' option. If =
the local git "
>> +					  "directory is not the correct =
repo\n"
>> +					  "or if you are unsure what =
this means, choose "
>> +					  "another name with the =
'--name' option.\n"),
>> +					add_data->realrepo);
>=20
> Is there any reason we can't use "error" here?

The message in its entirety looks like this:

error: A git directory for 'test' is found locally with remote(s):
  origin	git@github.com:tfidfwastaken/abc.git
If you want to reuse this local git directory instead of cloning again =
from
  git@github.com:tfidfwastaken/test.git
use the '--force' option. If the local git directory is not the correct =
repo
or if you are unsure what this means, choose another name with the =
'--name' option.

Since the 'error:' is already there in the first line, having it
prepended before 'If you want to reuse...' felt redundant to me.

Besides, it's more of an informational message about what a user
can do next, rather than a message that signifies an error.

If there is a preferred convention or label for such messages,
I can use that. The shell version did not have any such thing though.

>> [...]
>> +	struct option options[] =3D {
>> +		OPT_STRING('b', "branch", &add_data.branch,
>> +			   N_("branch"),
>> +			   N_("branch of repository to checkout on =
cloning")),
>> +		OPT_STRING(0, "prefix", &add_data.prefix,
>> +			   N_("path"),
>> +			   N_("alternative anchor for relative paths")),
>> +		OPT_STRING(0, "path", &add_data.sm_path,
>> +			   N_("path"),
>> +			   N_("where the new submodule will be cloned =
to")),
>> +		OPT_STRING(0, "name", &add_data.sm_name,
>> +			   N_("string"),
>> +			   N_("name of the new submodule")),
>> +		OPT_STRING(0, "url", &add_data.realrepo,
>> +			   N_("string"),
>> +			   N_("url where to clone the submodule from")),
>> +		OPT_STRING(0, "reference", &add_data.reference_path,
>> +			   N_("repo"),
>> +			   N_("reference repository")),
>> +		OPT_BOOL(0, "dissociate", &dissociate,
>> +			 N_("use --reference only while cloning")),
>> +		OPT_INTEGER(0, "depth", &add_data.depth,
>> +			    N_("depth for shallow clones")),
>> +		OPT_BOOL(0, "progress", &progress,
>> +			 N_("force cloning progress")),
>> +		OPT_BOOL('f', "force", &force,
>> +			 N_("allow adding an otherwise ignored submodule =
path")),
>=20
> We have OPT__FORCE, too.

Will switch over to that.

>> +		OPT__QUIET(&quiet, "Suppress output for cloning a =
submodule"),
>=20
> And, please downcase "Suppress".

OK.

>> +		OPT_END()
>> +	};
>> +
>> +	const char *const usage[] =3D {
>> +		N_("git submodule--helper add-clone [--prefix=3D<path>] =
[--quiet] [--force] "
>> +		   "[--reference <repository>] [--depth <depth>] =
[-b|--branch <branch>]"
>> +		   "[--progress] [--dissociate] --url <url> --path =
<path> --name <name>"),
>=20
> I think it's too crowded here, I guess it's better to write:
>=20
> 	N_("git submodule--helper add-clone [<options>...] --url <url> =
--path <path> --name <name>"),

OK. It shouldn't be an issue to shorten it, because this is not
user-facing, and is only ever used within 'cmd_add()'.

>> +		NULL
>> +	};
>> +
>> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>=20
> =46rom above usage, I think url, path, name is required, should we =
have a check for them, here?

We could. The reason why I was not too rigorous about this is
because I plan to eliminate the shell interface for this helper
eventually and call add-clone from within C, in the next few
patches.

But this is a small ask, and I can just add a quick check just
to be extra safe, so I'll do it.

>> +
>> +	add_data.progress =3D !!progress;
>> +	add_data.dissociate =3D !!dissociate;
>> +	add_data.force =3D !!force;
>> +	add_data.quiet =3D !!quiet;
>> +
>> +	if (add_submodule(&add_data))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> #define SUPPORT_SUPER_PREFIX (1<<0)
>>=20
>> struct cmd_struct {
>> @@ -2757,6 +2955,7 @@ static struct cmd_struct commands[] =3D {
>> 	{"list", module_list, 0},
>> 	{"name", module_name, 0},
>> 	{"clone", module_clone, 0},
>> +	{"add-clone", add_clone, 0},
>> 	{"update-module-mode", module_update_module_mode, 0},
>> 	{"update-clone", update_clone, 0},
>> 	{"ensure-core-worktree", ensure_core_worktree, 0},
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 4678378424..f71e1e5495 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -241,43 +241,7 @@ cmd_add()
>> 		die "$(eval_gettext "'$sm_name' is not a valid submodule =
name")"
>> 	fi
>>=20
>> -	# perhaps the path exists and is already a git repo, else clone =
it
>> -	if test -e "$sm_path"
>> -	then
>> -		if test -d "$sm_path"/.git || test -f "$sm_path"/.git
>> -		then
>> -			eval_gettextln "Adding existing repo at =
'\$sm_path' to the index"
>> -		else
>> -			die "$(eval_gettext "'\$sm_path' already exists =
and is not a valid git repo")"
>> -		fi
>> -
>> -	else
>> -		if test -d ".git/modules/$sm_name"
>> -		then
>> -			if test -z "$force"
>> -			then
>> -				eval_gettextln >&2 "A git directory for =
'\$sm_name' is found locally with remote(s):"
>> -				GIT_DIR=3D".git/modules/$sm_name" =
GIT_WORK_TREE=3D. git remote -v | grep '(fetch)' | sed -e s,^,"  ", -e =
s,' (fetch)',, >&2
>> -				die "$(eval_gettextln "\
>> -If you want to reuse this local git directory instead of cloning =
again from
>> -  \$realrepo
>> -use the '--force' option. If the local git directory is not the =
correct repo
>> -or you are unsure what this means choose another name with the =
'--name' option.")"
>> -			else
>> -				eval_gettextln "Reactivating local git =
directory for submodule '\$sm_name'."
>> -			fi
>> -		fi
>> -		git submodule--helper clone ${GIT_QUIET:+--quiet} =
${progress:+"--progress"} --prefix "$wt_prefix" --path "$sm_path" --name =
"$sm_name" --url "$realrepo" ${reference:+"$reference"} =
${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
>> -		(
>> -			sanitize_submodule_env
>> -			cd "$sm_path" &&
>> -			# ash fails to wordsplit ${branch:+-b =
"$branch"...}
>> -			case "$branch" in
>> -			'') git checkout -f -q ;;
>> -			?*) git checkout -f -q -B "$branch" =
"origin/$branch" ;;
>> -			esac
>> -		) || die "$(eval_gettext "Unable to checkout submodule =
'\$sm_path'")"
>> -	fi
>> +	git submodule--helper add-clone ${GIT_QUIET:+--quiet} =
${force:+"--force"} ${progress:+"--progress"} ${branch:+--branch =
"$branch"} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" =
--url "$realrepo" ${reference:+"$reference"} =
${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
>> 	git config submodule."$sm_name".url "$realrepo"
>>=20
>> 	git add --no-warn-embedded-repo $force "$sm_path" ||
>> --=20
>> 2.31.1
>>=20
>=20
> --=20
> Danh

Thanks for the comments!=
