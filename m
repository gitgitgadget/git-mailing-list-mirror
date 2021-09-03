Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59428C4332F
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB1B610CC
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 15:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349591AbhICPVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 11:21:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:41713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349606AbhICPVb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 11:21:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630682426;
        bh=ZbPGAThIpZGsltEVaLhWrwNIG/VhqCy82CIgj2bmIds=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MVvYcfRCTxxR4ll6IpcDx8PCWQPaUntPDN9aX5w+X/xLfzQYzXhY4HyrEJZIexcD5
         yvTdJVvlorraT5DbR3vp2jiuZD+Mi7Pe65jZypwFIKQjFdDFApwv7r3G1CQ8/UVosx
         VV4A9lCjvSe6zQoAyChCZiR2z2peGZ9ixv3uYfeM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAwXr-1mFo7n1wHh-00BPKw; Fri, 03
 Sep 2021 17:20:26 +0200
Date:   Fri, 3 Sep 2021 17:20:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 08/15] scalar: implement the `clone` subcommand
In-Reply-To: <xmqqsfyoqm6e.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109031709190.55@tvgsbejvaqbjf.bet>
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com> <2cbf0b611133df5fa7eed1bf38460f9d119d2a6e.1630359290.git.gitgitgadget@gmail.com> <xmqqsfyoqm6e.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cXsb25sVXsxqwa5H+ngbiz61ZpQizpdVUcM+ZvtoynCmqZ+f6gM
 xcA8O9JxXHGC9CJwuWZWSCa99c+kOuHGKNYwBNdOU4986QcXhy53v0uI7JhGhzdvTHMCyYd
 8YAcyszYL3gyrcTeWOXbzaAeVRyUS/TSU5NF3JUoMYX0LAU3jIarr5zCsHpdYGYuURFS09G
 gbA2ymCaHpLaQKkdgm0GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c3RF41/J1eE=:Q7SdwSRbbnO42djPvy1OSP
 +4zfZOGS1KVaxD86d48fUIiUld2pQ2p7EX6xTMX97gLdGKic7Y9BXoEiFbFyfLkkv3VeOyEbl
 Surk2JCyFgEu1Uif7b80EfNlrMgmmFMkG0DPg/CrtCFoUVbOjJkmXM/JkLVoiWssTIxPLOOP6
 L8Ymb8a6uASLvqHOYvN/G1aTH95CtRybCIwWBgp9kg4U3nDrCPppKSXHUOHLvtqFlLLy76ZTD
 DmyzaWc+6VocCldQc1a/i0CEngBkXMJu8NB+MHK+IjdriRPLdOabGuMi5hJBZua6y1+kwHZ83
 wPcpon/EXPjyHRNT2VU+vxdod1+vfou2nOauy7wTUZotblouT6cMOSZvLRrViJAdfCzmSiZvJ
 yaronMWDMflRNJvqsn0LrnkeRWScUqEJlW0ClqUsTxqOluDA7R1UWoY4NLgp1wNGNEvBcZoo5
 ENAzfhQ9WkwURal8RhlaDYOrTLg2rOIvwtzvBrhq03khdAK265/gT686rx/dQNgZkBkPA8Lfo
 5xV0Ns1B+7unRpXDC/x+h4Igm+fERG57d+A/0uC+DdOtEmfkcH+nlEkB1RvrrNd9TjrWD29tv
 Nn9XM8P7bwIjcwmjkhC8d54WOBMg/l3qiZZxr69Xwz1e7IL9bVMsDzFZqATitissRdhc96Ueg
 1LvEVIxcyz7h2u1EEegZlTaAvXKWakrTs1oA2jaggTAY0lZu7oJFlxNEwFeZgRy8opTJgxGu+
 3XCM+OTX+0T5diDLy+86sY2Yd9F5+Rd1lO4q9elsVcuvScTBUmUtPQh1Hm91dQSgztH2Qtzz/
 HOpSp/cQbBEY14Yd2yCA7Qw6d+VTM3fjO3ApNHw5CgQfeLlfckw21pcZCVDyX/hV31Gm26u7M
 XwC8gAUo1WeuI3oEkLXAZU29BcF4jk+S5JrE55ONXxj+5E0SX9GRd1wbioRfTcF7IYttS65Qo
 EdEoegO4LbqRjguJbR8OUYCnVxIfbcJgRfSUD3zQKrQbqiiR1VBZwMUt2WkVP79hPhzBK0/9b
 8IpkyiII9Gu5W+a7PXY3RmZtZ0bGc8+WFyedWxkIq6VWIawXKOtwQ8MBcq00GPQjwo7nG8LJk
 zj8MeQ1AR59A3Id8oHKyJTRMj4JYfm6odk3h09sVQ4+Gn/g0rtI0A5uzw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 1 Sep 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +static char *remote_default_branch(const char *url)
> > +{
> > +	struct child_process cp =3D CHILD_PROCESS_INIT;
> > +	struct strbuf out =3D STRBUF_INIT;
> > +
> > +	cp.git_cmd =3D 1;
> > +	strvec_pushl(&cp.args, "ls-remote", "--symref", url, "HEAD", NULL);
> > +	strbuf_addstr(&out, "-\n");
>
> Is this a workaround for the problem that the first "ref:" line
> won't be found by looking for "\nref: " in the loop?  Cute, but the
> extra "-" is a bit misleading.

The `-` is actually needed because of the `ref + 1` below, over which you
stumbled.

>
> > +	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
> > +		char *ref =3D out.buf;
> > +
> > +		while ((ref =3D strstr(ref + 1, "\nref: "))) {
> > +			const char *p;
> > +			char *head, *branch;
> > +
> > +			ref +=3D strlen("\nref: ");
> > +			head =3D strstr(ref, "\tHEAD");
> > +
> > +			if (!head || memchr(ref, '\n', head - ref))
> > +				continue;
>
> OK.  We expect "ref: " <refname> "\t" <head> "\n" where <head> is
> "HEAD" for their .git/HEAD and refs/remotes/<nick>/HEAD for their
> remote-tracking branch for the remote they call <nick>, on a single
> line.  We reject a line that is not of that shape, and we reject a
> line that is about remote-tracking branch by only looking for
> "\tHEAD". Makes sense.
>
> The strstr() goes from "ref + 1", which feels sloppy.

I would use a different adjective, one that is less judgemental in nature,
but then, you were talking about your feelings.

> When we reject the line we found that begins with "ref :", I would have
> expected that the next scan would start at the beginning of the next
> line, not from the middle of this line at the first letter 'e' in
> 'refs/heads/' on the current line "ref: refs/heads/.....".  As long as
> the current line is long enough, strstr() would not miss the beginning
> of the next line, so it might be OK.

It would even work if the current line is shorter, but as you point out:
it is wasteful. And it could be improved to be more readable. I reworked
it, and it now looks like this:

	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
		const char *line =3D out.buf;

		while (*line) {
			const char *eol =3D strchrnul(line, '\n'), *p;
			size_t len =3D eol - line;
			char *branch;

			if (!skip_prefix(line, "ref: ", &p) ||
			    !strip_suffix_mem(line, &len, "\tHEAD")) {
				line =3D eol + (*eol =3D=3D '\n');
				continue;
			}

			eol =3D line + len;
			if (skip_prefix(p, "refs/heads/", &p)) {
				branch =3D xstrndup(p, eol - p);
				strbuf_release(&out);
				return branch;
			}

			error(_("remote HEAD is not a branch: '%.*s'"),
			      (int)(eol - p), p);
			strbuf_release(&out);
			return NULL;
		}
	}

It now parses the output line by line, looking for the expected prefix and
suffix, then verifies the ref name format, and either returns the short
branch name or errors out with the message that this is not a branch.

>
> > +			if (skip_prefix(ref, "refs/heads/", &p)) {
> > +				branch =3D xstrndup(p, head - p);
> > +				strbuf_release(&out);
> > +				return branch;
> > +			}
> > +
> > +			error(_("remote HEAD is not a branch: '%.*s'"),
> > +			      (int)(head - ref), ref);
> > +			strbuf_release(&out);
> > +			return NULL;
>
> OK.  Any symref whose basename is HEAD in their remote-tracking
> hierarchy would have been rejected earlier in the loop.
>
> Is there a particular reason why we return early here, instead of
> breaking out of hte loop and let the generic "failed to get" code
> path below to handle this case?

Yes, the reason is that I wanted to err on the side of caution. If the
remote repository reports a default branch that is not a default branch at
all, I do not want to pretend that things are fine and then run into
trouble later when we set up a non-branch as remote-tracking target or
something like that.

>
> > +		}
> > +	}
> > +	warning(_("failed to get default branch name from remote; "
> > +		  "using local default"));
> > +	strbuf_reset(&out);
> > +
> > +	child_process_init(&cp);
> > +	cp.git_cmd =3D 1;
> > +	strvec_pushl(&cp.args, "symbolic-ref", "--short", "HEAD", NULL);
> > +	if (!pipe_command(&cp, NULL, 0, &out, 0, NULL, 0)) {
> > +		strbuf_trim(&out);
> > +		return strbuf_detach(&out, NULL);
> > +	}
> > +
> > +	strbuf_release(&out);
> > +	error(_("failed to get default branch name"));
> > +	return NULL;
> > +}
>
> > +static int cmd_clone(int argc, const char **argv)
> > +{
> > +	const char *branch =3D NULL;
> > +	int full_clone =3D 0;
> > +	struct option clone_options[] =3D {
> > +		OPT_STRING('b', "branch", &branch, N_("<branch>"),
> > +			   N_("branch to checkout after clone")),
> > +		OPT_BOOL(0, "full-clone", &full_clone,
> > +			 N_("when cloning, create full working directory")),
> > +		OPT_END(),
> > +	};
> > +	const char * const clone_usage[] =3D {
> > +		N_("scalar clone [<options>] [--] <repo> [<dir>]"),
> > +		NULL
> > +	};
> > +	const char *url;
> > +	char *enlistment =3D NULL, *dir =3D NULL;
> > +	struct strbuf buf =3D STRBUF_INIT;
> > +	int res;
> > +
> > +	argc =3D parse_options(argc, argv, NULL, clone_options, clone_usage,=
 0);
> > +
> > +	if (argc =3D=3D 2) {
> > +		url =3D argv[0];
> > +		enlistment =3D xstrdup(argv[1]);
> > +	} else if (argc =3D=3D 1) {
> > +		url =3D argv[0];
> > +
> > +		strbuf_addstr(&buf, url);
> > +		/* Strip trailing slashes, if any */
> > +		while (buf.len > 0 && is_dir_sep(buf.buf[buf.len - 1]))
> > +			strbuf_setlen(&buf, buf.len - 1);
> > +		/* Strip suffix `.git`, if any */
> > +		strbuf_strip_suffix(&buf, ".git");
> > +
> > +		enlistment =3D find_last_dir_sep(buf.buf);
> > +		if (!enlistment) {
> > +			die(_("cannot deduce worktree name from '%s'"), url);
> > +		}
> > +		enlistment =3D xstrdup(enlistment + 1);
> > +	} else {
> > +		usage_msg_opt(_("You must specify a repository to clone."),
> > +			      clone_usage, clone_options);
> > +	}
> > +
> > +	if (is_directory(enlistment))
> > +		die(_("directory '%s' exists already"), enlistment);
> > +
> > +	dir =3D xstrfmt("%s/src", enlistment);
> > +
> > +	strbuf_reset(&buf);
> > +	if (branch)
> > +		strbuf_addf(&buf, "init.defaultBranch=3D%s", branch);
> > +	else {
> > +		char *b =3D repo_default_branch_name(the_repository, 1);
> > +		strbuf_addf(&buf, "init.defaultBranch=3D%s", b);
> > +		free(b);
>
> Doesn't "git clone" already use their HEAD without having to make an
> extra "git ls-remote" roundtrip?
>
> Ahh, you do not do "git clone"; you do "git init", set things up,
> and then "git fetch" and checkout, all manually.
>
> Which is kind of shame.
>
> I wonder if it is a cleaner implementation to give a new option to
> "git clone" that gives a command sequence (not necessarily have to
> be implemented as a shell script) that specifies necessary
> pre-configuration steps to be done before the command starts the
> transfer step.

Right. It is a shame, I agree. And it is one of the things I want to work
on, after the Scalar patch series made it into Git.

The reason why I don't want to work on this now is that I expect this
effort to result in new options for `git clone`, new options that need to
be designed well, and where I fully expect a long discussion until we
reach a consensus how these options should look like, especially since we
will need to maintain backwards-compatibility of Scalar's functionality.

Therefore, in the interest to keep the patch series relatively easy to
review, I left this in the "for later" pile, for now.

Ciao,
Dscho
