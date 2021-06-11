Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9D6C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 07:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CDD0613B3
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 07:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhFKHfN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 03:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFKHfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 03:35:11 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8799DC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 00:33:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m7so3740190pfa.10
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vK48D55d/nVaIt3/FDKrCqF7nZKiUdajGtzOURosERo=;
        b=ZNtKwfrwQVJ2zc4aCKX8ahJ2zUP4Og3LVQSSGVPn+ukcJlT5ckFUYxzIuAVzNuvDuD
         7J2QkCAghERfhoB5yAfuuftoqljHfRogZCjh1xNOO6wgurIGqcKaANIa8lj4ueCidDih
         m6TTJUxsg0aYF3neUNeNbg5fRAeq+1P+afGk+aEN+NoRASH+svdY0nrbROjODb+sMyNS
         BjqRAgsl7LiOjKuwY5OzHk1kSdFRkOBOMM92dOiHtmW+WRcn/1QpbV4KirgLR/ajoAlR
         2hTtgwjBISBXs9RXOudNLWf4ydpiJq9RZErYVsvLmGB6cVL394foV/w6qrSQWPfMLKfc
         X8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vK48D55d/nVaIt3/FDKrCqF7nZKiUdajGtzOURosERo=;
        b=dK1kSLH0ZeMfPfQUD1dDobmaIlJjPoHqlhdqomu4mo5ehUtKM9HYqsx6lTI2WYF8ui
         Mo+ZKWIPqe2ekaLSZMz1RexIvzWWwlr8ocjFNt4RGubpa9/YRDmwEUhL1bIldAyknGyp
         dsWgXfxigbQWlf50KqGbxvfqCbAKlFISnjstLaXTof8LyJdHMzuesNZY6aNixTNDG0Nv
         SYUlYYDHMlVDeRE2h5PHvAznmQZ/nKK6JSYv27h7SGRaL7vpPW/8bqRBgr9AcgxsnPGg
         drIxCKCK/7xd0IP8jcygXuyQGYg+Cfn88RPzm7XKA1U9jxYA8nIzzBHhIAcbHqqI40m4
         rpdQ==
X-Gm-Message-State: AOAM531ebUB3ZVMx3kg3vd+95pZT1NAZ4GrlTD6ePcLAOFoM2NGr6/Pc
        hTLdskl4k6S3KyGJHsdoT1w=
X-Google-Smtp-Source: ABdhPJw9pKkgEGRXEK+cx7NVoBwnMz1mgXD45VUyw7sFb+r0HgTFnI8oyX1rzbwYG/3gHzL+r7aJkQ==
X-Received: by 2002:a63:ed4d:: with SMTP id m13mr2285060pgk.433.1623396781905;
        Fri, 11 Jun 2021 00:33:01 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id s13sm4486628pjm.34.2021.06.11.00.32.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jun 2021 00:33:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3 1/2] submodule--helper: introduce add-clone subcommand
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <xmqqim2l3p92.fsf@gitster.g>
Date:   Fri, 11 Jun 2021 13:02:57 +0530
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EAB5ABE4-B032-41AE-B39D-44D0D0A40D52@gmail.com>
References: <20210608095655.47324-1-raykar.ath@gmail.com>
 <20210610083916.96243-1-raykar.ath@gmail.com>
 <20210610083916.96243-2-raykar.ath@gmail.com> <xmqqim2l3p92.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11-Jun-2021, at 11:40, Junio C Hamano <gitster@pobox.com> wrote:
>=20
>> [...]
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
>> +		char *next_line;
>> +		char *line =3D sb_remote_out.buf;
>> +		while ((next_line =3D strchr(line, '\n')) !=3D NULL) {
>> +			size_t len =3D next_line - line;
>> +			if (strip_suffix_mem(line, &len, " (fetch)"))
>> +				fprintf(output, "  %.*s\n", (int)len, =
line);
>> +			line =3D next_line + 1;
>=20
> Good.  That's a handy helper to use here.
>=20
>> +		}
>> +	}
>> +
>> +	strbuf_release(&sb_remote_out);
>> +}
>> +
>> +static int add_submodule(const struct add_data *add_data)
>> +{
>> +	char *submod_gitdir_path;
>> +
>> +	/* perhaps the path already exists and is already a git repo, =
else clone it */
>> +	if (is_directory(add_data->sm_path)) {
>> +		submod_gitdir_path =3D xstrfmt("%s/.git", =
add_data->sm_path);
>> +		if (is_directory(submod_gitdir_path) || =
file_exists(submod_gitdir_path))
>=20
> This is a faithful translation from the scripted Porcelain that did
> not have access to our C internals that can do a lot better job at
> deciding if a given "$path", which has ".git" directly or file below
> it, is the top of a working tree that is governed by that ".git"
> thing.
>=20
> I wonder if setup.c::is_nonbare_repository_dir() can be used here.
> You really want to see add_data->sm_path is the top of the working
> tree of a submodule, so requiring only that ".git" thing is either
> a directory or a file, which was the cheap thing the scripted version
> could do without expending too much engineering effort, is a shame
> when you are now writing in C and all the infrastructure to do much
> better job is available to you.

Yes, that looks like the right function to use. My version just
poorly reinvented that wheel. Will fix.

>> +			printf(_("Adding existing path at '%s' to =
index\n"),
>> +			       add_data->sm_path);
>=20
> Unintended change to the message here; you lost "the".

Will change.

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
>> +				error(_("a git directory for '%s' is =
found "
>> +					"locally with remote(s):"), =
add_data->sm_name);
>=20
> The original is a mere eval_gettextln, so a faithful conversion
> would be to emit this to the standard error stream, without letting
> error() to add "error: " prefix and downcasing "A git directory".

This was an intentional change on my part, which was motivated by
Sivaraam's message on a similar patch[1]. I agreed with his point
that it is better to be explicit to the user that an error has
occurred.

I think the larger concern I have to balance here is what level of
"faithfulness" should I be having with this conversion. My current
thoughts on this are:

 - Functionality and behaviour should be as similar as possible.

 - If there is an *obvious* bug that can be fixed in translation,
   then I should fix it.

 - If there are error messages that can be made more clear and
   consistent with the rest of the Porcelain, then I'll make the
   required change.

If you want me to turn up the faithfulness all the way up, so that
the error messages are identical word-for-word, I don't mind doing
that. I just personally felt that this conversion would be a good
opportunity to make the error messages consistent with the rest of
Git.

(I'll concede that I'm not sure what "consistent with the rest
of Git" would exactly mean, so I'll be happy if any reviewers will
guide me on those kind of changes).

If I do go down the "reproduce messages exactly" path, it should
also follow that I not include this warning in [2/2], as it is
not in the original shell script:

+	if (pathspec_key_exists && !submod_pathspec) {
+		warning(_("The submodule.active configuration exists, =
but the "
+			  "pathspec was unset. If the submodule is not =
already "
+			  "active, the value of submodule.%s.active will =
be "
+			  "be set to 'true'."), add_data->sm_name);
+		activate =3D 1;
+	}

This was something that you suggested including, back when Shourya was
working on this[2]. So I used that as the signal that lightly altering
the messages emitted would be acceptable. I'm willing to change my
boundaries though.

[1] =
https://lore.kernel.org/git/5899bf6e-f61f-8a19-196d-d38d611dc037@gmail.com=
/
[2] https://lore.kernel.org/git/xmqqo8isxefz.fsf@gitster.c.googlers.com/

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
>> +				free(submod_gitdir_path);
>> +				return 1;
>=20
> The updated caller in the scripted Porcelain just silently exits
> upon an error, so the above message that used to be given to die()
> needs to be emitted by us like this.  You may want to do die(),
> instead of fprintf(stderr) followed by return 1, to be a more
> faithful conversion.

Okay. Will change.

>> +			} else {
>> +				printf(_("Reactivating local git =
directory for "
>> +					 "submodule '%s'\n"), =
add_data->sm_name);
>> +			}
>> +		}
>> +		free(submod_gitdir_path);
>=20
> And at this point, the original scripted Porcelain used to call "git
> submodule--helper clone".
>=20
>> +		strvec_pushl(&clone_args, "clone", "--path", =
add_data->sm_path, "--name",
>> +			     add_data->sm_name, "--url", =
add_data->realrepo, NULL);
>> +		if (add_data->quiet)
>> +			strvec_push(&clone_args, "--quiet");
>> +		if (add_data->progress)
>> +			strvec_push(&clone_args, "--progress");
>> +		if (add_data->prefix)
>> +			strvec_pushl(&clone_args, "--prefix", =
add_data->prefix, NULL);
>> +		if (add_data->reference_path)
>> +			strvec_pushl(&clone_args, "--reference",
>> +				     add_data->reference_path, NULL);
>> +		if (add_data->dissociate)
>> +			strvec_push(&clone_args, "--dissociate");
>> +		if (add_data->depth >=3D 0)
>> +			strvec_pushf(&clone_args, "--depth=3D%d", =
add_data->depth);
>> +
>> +		if (module_clone(clone_args.nr, clone_args.v, =
add_data->prefix)) {
>> +			strvec_clear(&clone_args);
>> +			return -1;
>> +		}
>> +		strvec_clear(&clone_args);
>=20
> All of the above does the equivalent of it, but having to "unparse"
> members of the add_data structure and stuff clone_args, only to be
> parsed by parse_options() call in module_clone(), is somewhat
> unsatisfactory.  I think this series would be helped greatly if
> there were an additional step that splits module_clone() into two,
> factoring out everything that happens after module_clone() calls
> parse_options() into a helper function.  module_clone() will call
> that helper function, and then at this step, instead of the above
> "unparse and then call module_clone()", this place will call the
> same helper function.

This is the right idea. I will do this.

> In any case, after doing "git submodule--helper clone", the original
> scripted version does "git checkout" in the newly cloned working
> tree.  I wonder if the "module_clone" is done with "--no-checkout"
> option---cloning and letting a commit checked out, and checking out
> another commit immediately after it, feels somewhat wasteful.

I just had a look: module_clone() already uses "--no-checkout".
So this should not be a problem.

>> +		prepare_submodule_repo_env(&cp.env_array);
>> +		cp.git_cmd =3D 1;
>> +		cp.dir =3D add_data->sm_path;
>> +		strvec_pushl(&cp.args, "checkout", "-f", "-q", NULL);
>> +
>> +		if (add_data->branch) {
>> +			strvec_pushl(&cp.args, "-B", add_data->branch, =
NULL);
>> +			strvec_pushf(&cp.args, "origin/%s", =
add_data->branch);
>> +		}
>> +
>> +		if (run_command(&cp))
>> +			die(_("unable to checkout submodule '%s'"), =
add_data->sm_path);
>> +	}
>> +	return 0;
>> +}
>=20
> Other than all the commented parts, this looks fairly faithful
> conversion from the part of the scripted Porcelain that has been
> lost by the same patch.
>=20
>> +static int add_clone(int argc, const char **argv, const char =
*prefix)
>> +{
>> +	int force =3D 0, quiet =3D 0, dissociate =3D 0, progress =3D 0;
>> +	struct add_data add_data =3D ADD_DATA_INIT;
>> + ...
>> +	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
>> +
>> +	if (argc !=3D 0)
>> +		usage_with_options(usage, options);
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
>=20
> As you wrote the add_clone() vs add_submodule() split of labour, the
> reason this one is much more nicely organized than module_clone()
> should be obvious to you.  This part of the design of this patch is
> very well done.
>=20
> The "additional step" I hinted earlier is exactly that---by making
> the guts of the feature add_submodule() to work on already parsed
> data and a separate wrapper add_clone() that interfaces to the
> scripts to parse the command line arguments into a shape that is
> more appropriate for the inner function, you can later call the
> inner function add_submodule() directly without going through the
> unparsing-then-parsing dance from other places.  If module_clone()
> were split into two in a similar way, then the place to call it from
> add_submodule() would become much cleaner.

This definitely sounds like the way to go. I'll be on it.

> Thanks.

Thanks for your suggestions. They were very helpful.=
