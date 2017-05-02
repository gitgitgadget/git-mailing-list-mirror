Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CBE91F790
	for <e@80x24.org>; Tue,  2 May 2017 15:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750727AbdEBPcS (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 11:32:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:50749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750710AbdEBPcR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 11:32:17 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LwJFG-1e8wEV1Mi6-0185IS; Tue, 02
 May 2017 17:32:05 +0200
Date:   Tue, 2 May 2017 17:32:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Liam Beguin <liambeguin@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 2/6] rebase -i: add abbreviate_commands function
In-Reply-To: <20170502040048.9065-3-liambeguin@gmail.com>
Message-ID: <alpine.DEB.2.20.1705021641240.3480@virtualbox>
References: <20170502040048.9065-1-liambeguin@gmail.com> <20170502040048.9065-3-liambeguin@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:U0tHcObhMcWsYxROFHch1Nuf6e3gvlO7HORiU9wgMZkm+35LtBL
 RP5h30uo5Zz4sm9z73JX64c3K7JiA87U/Czpb8iSm3V2eHjT3J7y9VY+3Ua6K4NLUPsX5s3
 KTR2C6IUtxuv8hLODb3dGq2Ywq26H32kTVYzolPqxQj0Igg+EtD3ghmfT5FBNixMnUGlBoJ
 F1LjPaAvbKr/cYas6mBnA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WacD65kKI58=:tiQyKtmyjN1H2kFGkvI1TT
 /hs7NhrWPAYEYFlkI9U3kXiQ9VAfPMGx/7qad3n9db+3geQqvfWAvXF1k5pvt6VgjN1ph4MZO
 a2F/bbuI54jiT3KUtMQXxCiSM/vzVa0mO7bFgDOxrKS1aH4LhyLA4LBLQz3Tv9fV5BQbSjrN8
 j4eixpVE0gOthz3bF13m38DmIEGZhSTDR11d9w+jxIoe2BRcaR2UavqCp3QNDBiqgpCvtffPs
 tfcLjNPgPTtf1UoURT8E09c0QFWr4LcG1Wkjo4+H7Bxki1Vo1fuBy5Lr13ypCXqm1lszOppTY
 9BhTw3j1fe3xI+EKN8PQN2VoJau6fGM61uhvCsBacXkbxCziKdWdSHeFihRUbr5bWXWabXEkO
 maHUZsjo3RwujnyL/5aJc5SgocKNasYVfoXHnNsjKZ30wynI5+odvJ2KfU4hApgkS68MOhmMR
 jIRZGO0EpP0PGxVfV1kKGbhmG4Yq03wY4qUKfhbJs8XqZRN+ZezTML2SlhdlfJ29j7QoX3nhf
 G/8v3n02ai0//AF5bm11KclX64Or5bLu0+tq2U6+2bM6zpeto084i5OGzyc9edoGcbpYzjJxg
 tGPK91/hhI5y8PcROmaDEbH9l4qTTnRmbjSBlYM5PYYqcrRSS1ufTGAo3Sw8d/eoYXmqZNIRl
 jCn2SvZofvk1at26IqubWHhmMBJMJnYPZQgjqWxCjQHw/xPpTTmcd8BoWFaJiOZXo1ksxiica
 GqpsIe19FHdTcmC7jH8Q+GHAVi3QsGjIKReY1tAdQ6ixFSrfNO6pLxvudFGlKPo8SEJ4Nxb8B
 fsxXyZd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Liam,

On Tue, 2 May 2017, Liam Beguin wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 9b8a030ff045..4fa621062cdf 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -884,6 +884,20 @@ add_exec_commands () {
>  	mv "$1.new" "$1"
>  }
>  
> +abbreviate_commands () {
> +	test "$(git config --bool rebase.abbreviateCommands)" = true || return
> +
> +	while read -r command rest
> +	do
> +		case $command in
> +		x|exec) command=x ;;
> +		*)      command=${command%${command#?}} ;;
> +		esac
> +		printf "%s\n" "$command $rest"
> +	done <"$1" >"$1.new" &&
> +	mv -f "$1.new" "$1"
> +}

Neither this function nor its callers handle errors, but that is in line
with how the other todo list-munging functions work.

I just say this to document that I read this code, noted this shortcoming,
and think that it is okay to keep it this way for the moment.

There is one more fundamental comment I have, though: we already have a
step that converts the todo list to/from the human readable format (by
collapsing/expanding the commit hashes presented in the list). We could
easily make this conversion a part of that conversion.

Once my `rebase-i-extra` patches get accepted, we will need to rewrite
this in C, as part of sequencer.c, anyway. It will look somewhat like
this:

-- snipsnap --
diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index e6591f01112..5eda71307af 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -11,7 +11,7 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	int keep_empty = 0;
+	int keep_empty = 0, abbreviate_commands = 0;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH
@@ -39,6 +39,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	};
 
 	git_config(git_default_config, NULL);
+	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
 
 	opts.action = REPLAY_INTERACTIVE_REBASE;
 	opts.allow_ff = 1;
@@ -52,11 +53,12 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	if (command == ABORT && argc == 1)
 		return !!sequencer_remove_state(&opts);
 	if (command == MAKE_SCRIPT && argc > 1)
-		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
+		return !!sequencer_make_script(keep_empty, abbreviate_commands,
+					       stdout, argc, argv);
 	if (command == SHORTEN_SHA1S && argc == 1)
-		return !!transform_todo_ids(1);
+		return !!transform_todo_ids(1, abbreviate_commands);
 	if (command == EXPAND_SHA1S && argc == 1)
-		return !!transform_todo_ids(0);
+		return !!transform_todo_ids(0, 0);
 	if (command == CHECK_TODO_LIST && argc == 1)
 		return !!check_todo_list();
 	if (command == SKIP_UNNECESSARY_PICKS && argc == 1)
diff --git a/sequencer.c b/sequencer.c
index 63a588f0916..ca504063d16 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2390,7 +2390,7 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
 	strbuf_release(&sob);
 }
 
-int sequencer_make_script(int keep_empty, FILE *out,
+int sequencer_make_script(int keep_empty, int abbreviate_commands, FILE *out,
 		int argc, const char **argv)
 {
 	char *format = NULL;
@@ -2430,7 +2430,9 @@ int sequencer_make_script(int keep_empty, FILE *out,
 		strbuf_reset(&buf);
 		if (!keep_empty && is_original_commit_empty(commit))
 			strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, "pick %s ", oid_to_hex(&commit->object.oid));
+		strbuf_addf(&buf, "%s %s ",
+			    abbreviate_commands ? "p" : "pick",
+			    oid_to_hex(&commit->object.oid));
 		pretty_print_commit(&pp, commit, &buf);
 		strbuf_addch(&buf, '\n');
 		fputs(buf.buf, out);
@@ -2440,7 +2442,7 @@ int sequencer_make_script(int keep_empty, FILE *out,
 }
 
 
-int transform_todo_ids(int shorten_sha1s)
+int transform_todo_ids(int shorten_sha1s, int abbreviate_commands)
 {
 	const char *todo_file = rebase_path_todo();
 	struct todo_list todo_list = TODO_LIST_INIT;
@@ -2476,16 +2478,31 @@ int transform_todo_ids(int shorten_sha1s)
 			todo_list.items[i + 1].offset_in_buf :
 			todo_list.buf.len;
 
-		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
-			fwrite(p, eol - bol, 1, out);
+		if (item->command >= TODO_EXEC && item->command != TODO_DROP) {
+			if (!abbreviate_commands)
+				fwrite(p, eol - bol, 1, out);
+			else {
+				const char *end_of_line = p + eol;
+				p += strspn(p, " \t"); /* skip whitespace */
+				p += strcspn(p, " \t"); /* skip command */
+				fprintf(out, "%c%.*s",
+					todo_command_info[item->command].c,
+					(int)(end_of_line - p), p);
+			}
+		}
 		else {
 			const char *sha1 = shorten_sha1s ?
 				short_commit_name(item->commit) :
 				oid_to_hex(&item->commit->object.oid);
 			int len;
 
-			p += strspn(p, " \t"); /* left-trim command */
-			len = strcspn(p, " \t"); /* length of command */
+			if (abbreviate_commands) {
+				p = &todo_command_info[item->command].c;
+				len = 1;
+			} else {
+				p += strspn(p, " \t"); /* left-trim command */
+				len = strcspn(p, " \t"); /* length of command */
+			}
 
 			fprintf(out, "%.*s %s %.*s\n",
 				len, p, sha1, item->arg_len, item->arg);
diff --git a/sequencer.h b/sequencer.h
index 1c94bec7622..9a7f4333900 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -45,10 +45,10 @@ int sequencer_continue(struct replay_opts *opts);
 int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
-int sequencer_make_script(int keep_empty, FILE *out,
+int sequencer_make_script(int keep_empty, int abbreviate_commands, FILE *out,
 		int argc, const char **argv);
 
-int transform_todo_ids(int shorten_sha1s);
+int transform_todo_ids(int shorten_sha1s, int abbreviate_commands);
 int check_todo_list(void);
 int skip_unnecessary_picks(void);
 int rearrange_squash(void);
