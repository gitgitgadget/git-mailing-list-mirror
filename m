Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AA4F2027C
	for <e@80x24.org>; Tue, 30 May 2017 18:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbdE3STh (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 14:19:37 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34266 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdE3STg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 14:19:36 -0400
Received: by mail-io0-f193.google.com with SMTP id 12so9829186iol.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 11:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m80YmK4oeHypva7HWAhhwHaLsUsdJ7x6vFZKg/lhhpg=;
        b=gtiVJzllU7cn7upPbzyYHBS/sh9vzicyXFpztXv5QmZ8YHGOuCF2Tt4W3BQAZgFLO6
         TVnOfJYZdQD13onQo2v7gBFnkz9hNlCJWG692TyMTpIdC30fG9kQrTwX11neQdkSDOWZ
         e1I3Umw/NN+fzU8P4B1y0XNonxPh4ZvuoKUlAsec5df2AXQ8jrf+n+x2d5UfrHnb/PPQ
         EDh5VHPmVmqSLItGQfAEA0bhlw4cVHAJ0kJcMIXcpG3PYEPE81xrauopzLJtxtPK1VWr
         oSvY7gAbiuA5WgWwRTOlFnnaskvDCzpXt3J7g73+tU1qv8Xm12x4MLK9AX+vR/GYg6xu
         ktfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m80YmK4oeHypva7HWAhhwHaLsUsdJ7x6vFZKg/lhhpg=;
        b=nFNQ5nVivF1HykCwTuNil5lT4YPdUwx3fllzNf0Abr8RckHJSpUBIW/iyAMVRUROe2
         gUPF64cLL6OK7cH12N0AcEdcjKX7jGw1XnA83ufXYk65OnCVEDZ5vLZloDX+VKNzcZz4
         xRiT6k49TStX+5pLVHGjSfV0RA7Tv7P9RYGYVxKlANEkrCNOWIuct+aLUZRKf+MttYHK
         Ky/u5oiQZ68jDWHYDatYvZYncbassFVOnsa9R9tqsSpQyWBBhcp4mtSuHN0uhWgZcNTX
         fkQJSDrJqOWpv2ZTAygiMJcFug2pLA0kvQFtFWn5HT2Ln7P5rF2zOK5tY2QrEMWegQMn
         Lexw==
X-Gm-Message-State: AODbwcBHKqf8R2MZVTpwwrpn5CbBMAiRkdBbnEf9d7TtTknvcetOduGd
        RksSPHhtLsBenJOWIitVmQ==
X-Received: by 10.107.20.134 with SMTP id 128mr17600510iou.132.1496168374955;
        Tue, 30 May 2017 11:19:34 -0700 (PDT)
Received: from [192.168.2.102] (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id i74sm9871980itb.5.2017.05.30.11.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 May 2017 11:19:34 -0700 (PDT)
Subject: Re: [PATCH v4 02/10] rebase -i: generate the script via
 rebase--helper
From:   liam Beguin <liambeguin@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, phillip.wood@dunelm.org.uk
References: <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de>
 <20170526031516.26287-1-liambeguin@gmail.com>
Message-ID: <b1377fcf-90a4-4ba8-d3ad-53be275b3b75@gmail.com>
Date:   Tue, 30 May 2017 14:19:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <20170526031516.26287-1-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> The first step of an interactive rebase is to generate the so-called "todo
> script", to be stored in the state directory as "git-rebase-todo" and to
> be edited by the user.
>
> Originally, we adjusted the output of `git log <options>` using a simple
> sed script. Over the course of the years, the code became more
> complicated. We now use shell scripting to edit the output of `git log`
> conditionally, depending whether to keep "empty" commits (i.e. commits
> that do not change any files).
>
> On platforms where shell scripting is not native, this can be a serious
> drag. And it opens the door for incompatibilities between platforms when
> it comes to shell scripting or to Unix-y commands.
>
> Let's just re-implement the todo script generation in plain C, using the
> revision machinery directly.
>
> This is substantially faster, improving the speed relative to the
> shell script version of the interactive rebase from 2x to 3x on Windows.
>
> Note that the rearrange_squash() function in git-rebase--interactive
> relied on the fact that we set the "format" variable to the config setting
> rebase.instructionFormat. Relying on a side effect like this is no good,
> hence we explicitly perform that assignment (possibly again) in
> rearrange_squash().
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/rebase--helper.c   |  8 +++++++-
>  git-rebase--interactive.sh | 44 +++++++++++++++++++++--------------------
>  sequencer.c                | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>  sequencer.h                |  3 +++
>  4 files changed, 82 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
> index ca1ebb2fa18..821058d452d 100644
> --- a/builtin/rebase--helper.c
> +++ b/builtin/rebase--helper.c
> @@ -11,15 +11,19 @@ static const char * const builtin_rebase_helper_usage[] = {
>  int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  {
>  	struct replay_opts opts = REPLAY_OPTS_INIT;
> +	int keep_empty = 0;
>  	enum {
> -		CONTINUE = 1, ABORT
> +		CONTINUE = 1, ABORT, MAKE_SCRIPT
>  	} command = 0;
>  	struct option options[] = {
>  		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
> +		OPT_BOOL(0, "keep-empty", &keep_empty, N_("keep empty commits")),
>  		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
>  				CONTINUE),
>  		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
>  				ABORT),
> +		OPT_CMDMODE(0, "make-script", &command,
> +			N_("make rebase script"), MAKE_SCRIPT),
>  		OPT_END()
>  	};

This is probably being picky, but we could also use a different name
here instead of 'rebase script'. This would help keep the name of this
script consistent as you already pointed out.
maybe something like 'make-todo-list' or just 'make-list'?

>  
> @@ -36,5 +40,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
>  		return !!sequencer_continue(&opts);
>  	if (command == ABORT && argc == 1)
>  		return !!sequencer_remove_state(&opts);
> +	if (command == MAKE_SCRIPT && argc > 1)
> +		return !!sequencer_make_script(keep_empty, stdout, argc, argv);

same here.

>  	usage_with_options(builtin_rebase_helper_usage, options);
>  }
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 2c9c0165b5a..609e150d38f 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -785,6 +785,7 @@ collapse_todo_ids() {
>  # each log message will be re-retrieved in order to normalize the
>  # autosquash arrangement
>  rearrange_squash () {
> +	format=$(git config --get rebase.instructionFormat)
>  	# extract fixup!/squash! lines and resolve any referenced sha1's
>  	while read -r pick sha1 message
>  	do
> @@ -1210,26 +1211,27 @@ else
>  	revisions=$onto...$orig_head
>  	shortrevisions=$shorthead
>  fi
> -format=$(git config --get rebase.instructionFormat)
> -# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
> -git rev-list $merges_option --format="%m%H ${format:-%s}" \
> -	--reverse --left-right --topo-order \
> -	$revisions ${restrict_revision+^$restrict_revision} | \
> -	sed -n "s/^>//p" |
> -while read -r sha1 rest
> -do
> -
> -	if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
> -	then
> -		comment_out="$comment_char "
> -	else
> -		comment_out=
> -	fi
> +if test t != "$preserve_merges"
> +then
> +	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
> +		$revisions ${restrict_revision+^$restrict_revision} >"$todo"
> +else
> +	format=$(git config --get rebase.instructionFormat)
> +	# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
> +	git rev-list $merges_option --format="%m%H ${format:-%s}" \
> +		--reverse --left-right --topo-order \
> +		$revisions ${restrict_revision+^$restrict_revision} | \
> +		sed -n "s/^>//p" |
> +	while read -r sha1 rest
> +	do
> +
> +		if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
> +		then
> +			comment_out="$comment_char "
> +		else
> +			comment_out=
> +		fi
>  
> -	if test t != "$preserve_merges"
> -	then
> -		printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
> -	else
>  		if test -z "$rebase_root"
>  		then
>  			preserve=t
> @@ -1248,8 +1250,8 @@ do
>  			touch "$rewritten"/$sha1
>  			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
>  		fi
> -	fi
> -done
> +	done
> +fi
>  
>  # Watch for commits that been dropped by --cherry-pick
>  if test t = "$preserve_merges"
> diff --git a/sequencer.c b/sequencer.c
> index 130cc868e51..88819a1a2a9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2388,3 +2388,52 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>  
>  	strbuf_release(&sob);
>  }
> +
> +int sequencer_make_script(int keep_empty, FILE *out,
> +		int argc, const char **argv)
> +{
> +	char *format = NULL;
> +	struct pretty_print_context pp = {0};
> +	struct strbuf buf = STRBUF_INIT;
> +	struct rev_info revs;
> +	struct commit *commit;
> +
> +	init_revisions(&revs, NULL);
> +	revs.verbose_header = 1;
> +	revs.max_parents = 1;
> +	revs.cherry_pick = 1;
> +	revs.limited = 1;
> +	revs.reverse = 1;
> +	revs.right_only = 1;
> +	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
> +	revs.topo_order = 1;
> +
> +	revs.pretty_given = 1;
> +	git_config_get_string("rebase.instructionFormat", &format);
> +	if (!format || !*format) {
> +		free(format);
> +		format = xstrdup("%s");
> +	}
> +	get_commit_format(format, &revs);
> +	free(format);
> +	pp.fmt = revs.commit_format;
> +	pp.output_encoding = get_log_output_encoding();
> +
> +	if (setup_revisions(argc, argv, &revs, NULL) > 1)
> +		return error(_("make_script: unhandled options"));
> +
> +	if (prepare_revision_walk(&revs) < 0)
> +		return error(_("make_script: error preparing revisions"));
> +
> +	while ((commit = get_revision(&revs))) {
> +		strbuf_reset(&buf);
> +		if (!keep_empty && is_original_commit_empty(commit))
> +			strbuf_addf(&buf, "%c ", comment_line_char);
> +		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
> +		pretty_print_commit(&pp, commit, &buf);
> +		strbuf_addch(&buf, '\n');
> +		fputs(buf.buf, out);
> +	}
> +	strbuf_release(&buf);
> +	return 0;
> +}
> diff --git a/sequencer.h b/sequencer.h
> index f885b68395f..83f2943b7a9 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -45,6 +45,9 @@ int sequencer_continue(struct replay_opts *opts);
>  int sequencer_rollback(struct replay_opts *opts);
>  int sequencer_remove_state(struct replay_opts *opts);
>  
> +int sequencer_make_script(int keep_empty, FILE *out,
> +		int argc, const char **argv);
> +
>  extern const char sign_off_header[];
>  
>  void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
> -- 
> 2.12.2.windows.2.800.gede8f145e06

If you want, I could add to what I did in "rebase -i: add config to
abbreviate command-names"[1] and try to resolve these naming inconsistencies
in a separate patch.

Liam

[1]: https://public-inbox.org/git/20170502040048.9065-1-liambeguin@gmail.com/
