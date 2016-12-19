Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADEA91FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 13:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762080AbcLSNqc (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 08:46:32 -0500
Received: from mout.gmx.net ([212.227.15.19]:49758 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752737AbcLSNqa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 08:46:30 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ldq55-1czyRl2Z8t-00j0kd; Mon, 19
 Dec 2016 14:46:10 +0100
Date:   Mon, 19 Dec 2016 14:46:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2 03/34] sequencer (rebase -i): implement the 'edit'
 command
In-Reply-To: <xmqqbmwf1pqd.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1612191438200.54750@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de> <a1361151ad1dad8f4dc3c412c7ed30f625d67ba0.1481642927.git.johannes.schindelin@gmx.de> <xmqqbmwf1pqd.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VxpU1QCRePn1g8q1DcOIUIKsY0bZqcuxlg0H3e7zpDm5gD4FsX9
 eQhgHSxoNVngfm8Ef7tUS4UOT9n52YCsWpOzFR1q2YOFQM9eb04mG4TozobHjJX2dp3eIep
 V4XoHIx9A4FgD6CypgEeEdWsVLZgHgdnmAlmOT5332NOT0TUlIK+XqfvUlW/vwN8N3VE1mE
 y31nbr1mu7l6HtHBntr4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YW0QxbLIeVQ=:cYIjA2bZwPFPvryV8EZM6l
 QkiWXZQ93ebYHA9hXLhD4XapMTT5FPbqfMnwIIXIGDP9CrWOev01MopV1zmQOTh2RrFLR6ast
 iEATyVKiAUxAdKLV5zvZQugK3gWetac8Si1UAH6kPFOd2ktHA9pWVetNZOb4lqqmta2MBP3vY
 oBuq/LPRaajQ+p9sxnZ7OIZwsDxhpgDjaXOhkrTvl4IYS0HUG8xvfM3WOkjuridS5E3uNaa79
 JtFOw43MHiI6h1s127vcZ3CoVR+1xBpu5t3i/jFr5sy/y2erjnRTEp/iP+0Yjrs0AcOq1K41H
 XoTPOqWe9aaerEg1WSVHsFpa4MaHdW4YjNGCOQEwZ+nq/AyW55/ztjYGdLYQBoMrLNHqfBEZQ
 a6fNKfuoX+okMAA7KaaqvdBAi8wD8yFZCSfpLhq5Rvj+322ixt0mnh8rFLoCd+NItuwX+XZtP
 SHRe8LpNo2YgJDb7cFRtqsDG2WAfS8PGL0pG3X9TLBu9xG8K3w84Z/ZDrPVoRFznhV//nOgCp
 ejqQCgvdmx7UAcpLV4k/A0W/yzs0/PKfYfgPGjaIQtGUEsEWSv01SsbN+JQhTD4QWPqK/6CSh
 e95lM32ei7uAj9f6wD2I2lqCo7JRkehT/WXsLn1EMgd+wZI40JkJvf8v6xAk2tO2J44NWpzCd
 Ggkyr0P1JfzSP/QxKhu/DHsnJF5IeRGXLnhwzouESDUrp6dTSk5b3A5N3eHEioZ1q9geg4oSN
 3qjfRHvrC9eisuZxgC2ijUxhvM7T4wm44RidGziWqqsn/mIvAZs4Kmp9gNG1w5UBr9uqcXuva
 +BnDwUH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 13 Dec 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > @@ -43,6 +44,20 @@ static GIT_PATH_FUNC(rebase_path_todo, "rebase-merge/git-rebase-todo")
> >   */
> >  static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
> >  /*
> 
> It is minor, but please have a blank line to separate the logical
> blocks.

Ah, but where to draw the line? These comments in front of some of the
rebase_path_* functions clarify the particular role of the corresponding
paths, but all of those functions belong to the same block of
rebase_path_* functions. That latter circumstance is what made me decide
to *not* insert blank lines here, but only a blank line before that block
(to separate from the sequencer path functions) and after that block (to
separate from the rest of the code).

> If you have "comment for thing A" before "thing A", then having a blank
> after that before "comment for thing B" and "thing B" that follow would
> help.  Otherwise "thing A" immediately followed by "comment for thing B"
> are (mis)read together, leading to nonsense.

In this case, I think it is quite obvious that the comments belong to the
immediately following line, and that all of the path functions are part of
a bigger block.

> > + * When an "edit" rebase command is being processed, the SHA1 of the
> > + * commit to be edited is recorded in this file.  When "git rebase
> > + * --continue" is executed, if there are any staged changes then they
> > + * will be amended to the HEAD commit, but only provided the HEAD
> > + * commit is still the commit to be edited.  When any other rebase
> > + * command is processed, this file is deleted.
> > + */
> > +static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
> > +/*
> > + * When we stop at a given patch via the "edit" command, this file contains
> > + * the long commit name of the corresponding patch.
> 
> If you abbreviate an object name to 38-hex that is still long but
> that is not full; if you meant full 40-hex, better spell it out as
> "full"---that conveys useful information to programmers (e.g. they
> can just use get_sha1_hex()).
> 
> But I think you are writing short_commit_name() to it?  So perhaps
> "an abbreviated commit object name"?

Fixed.

> > @@ -1301,9 +1318,87 @@ static int save_opts(struct replay_opts *opts)
> >  	return res;
> >  }
> >  
> > +static int make_patch(struct commit *commit, struct replay_opts *opts)
> > +{
> > +	struct strbuf buf = STRBUF_INIT;
> > +	struct rev_info log_tree_opt;
> > +	const char *commit_buffer = get_commit_buffer(commit, NULL), *subject, *p;
> > +	int res = 0;
> > +
> > +	p = short_commit_name(commit);
> > +	if (write_message(p, strlen(p), rebase_path_stopped_sha(), 1) < 0)
> > +		return -1;
> > +
> > +	strbuf_addf(&buf, "%s/patch", get_dir(opts));
> > +	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
> > +	init_revisions(&log_tree_opt, NULL);
> > +	log_tree_opt.abbrev = 0;
> > +	log_tree_opt.diff = 1;
> > +	log_tree_opt.diffopt.output_format = DIFF_FORMAT_PATCH;
> > +	log_tree_opt.disable_stdin = 1;
> > +	log_tree_opt.no_commit_id = 1;
> > +	log_tree_opt.diffopt.file = fopen(buf.buf, "w");
> > +	log_tree_opt.diffopt.use_color = GIT_COLOR_NEVER;
> > +	if (!log_tree_opt.diffopt.file)
> > +		res |= error_errno(_("could not open '%s'"), buf.buf);
> > +	else {
> > +		res |= log_tree_commit(&log_tree_opt, commit);
> > +		fclose(log_tree_opt.diffopt.file);
> > +	}
> > +	strbuf_reset(&buf);
> > +	strbuf_addf(&buf, "%s/message", get_dir(opts));
> > +	if (!file_exists(buf.buf)) {
> > +		find_commit_subject(commit_buffer, &subject);
> > +		res |= write_message(subject, strlen(subject), buf.buf, 1);
> > +		unuse_commit_buffer(commit, commit_buffer);
> > +	}
> > +	strbuf_release(&buf);
> > +
> > +	return res;
> > +}
> 
> OK.  This seems to match what scripted make_patch does in a handful
> of lines.  We probably should have given you a helper to reduce
> boilerplate that sets up log_tree_opt so that this function does not
> have to be this long, but that is a separate topic.
> 
> Does it matter output_format is set to FORMAT_PATCH here, though?
> With --no-commit-id set, I suspect there is no log message or
> authorship information given to the output.
> 
> As you are only interested in seeing the patch/diff in this file and
> the log is stored in a separate "message" file, as long as "patch"
> file gets the patch correctly, it is not a problem, but it just
> looked strange to see FORMAT_PATCH there.

I am indifferent as to FORMAT_PATCH. It is there simply as a direct
translation of the `diff-tree -p` command in
https://github.com/git/git/blob/v2.11.0/git-rebase--interactive.sh#L188

Ciao,
Dscho
