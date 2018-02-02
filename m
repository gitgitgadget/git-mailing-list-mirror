Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F8A1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 01:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeBBBgH (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 20:36:07 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34286 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751579AbeBBBgG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 20:36:06 -0500
Received: by mail-wm0-f68.google.com with SMTP id j21-v6so316193wmh.1
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 17:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UPqx3iD8n98IxAsF3EKF/alrvQfuIpl3iua4j3AwJ/c=;
        b=GPEllryTfKxF4a+wPyb0hjrG5DGmNxxfyunktnA/jU8Ts9YYuFp8VtOhMVuC+7Q4BI
         JYYsARSVD4bQyUBmjdfZ00vji8ce4BjoubiD1pwtK8BV6/0iEQQslRjKMN8kCRV1PIv2
         19moAyYC9na/PGdQrXoEjjtwiHzwW1b6A8Jizhzsn6bUcAQ8AorZqkSPE3HjW5MHXMS3
         1cAiR4iIELNansTex0pwAwO7dpHjtLuSXAiuJXif8ZapQ9zHYK8H0aCCuetvoNtSoKQd
         hYTfp45hzXvQEET1VzgL7L8xTP/TPehwc3eoWv8Ak9aBU2p8NtegsDhX4/2anzQwb6bC
         UKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UPqx3iD8n98IxAsF3EKF/alrvQfuIpl3iua4j3AwJ/c=;
        b=ilObBNUCaEEezOZkNqFnCzr56BpSf7HBQ7j3bnfM2dahCUxgcUfBF6JWj4vhTIePN0
         Avpvb8i3hf6/0BxnzQwH3sno5nCH5oNZf4S4Oz9eRyTTGF0Kgh4j0PaqEbIOS3dCZI62
         7Mf4HkjlosSX/JlI9Mz/svoNql0XsftFncIRWmVE+Erz7V1DwbzSV6VtAUvMe3LfNC5s
         ulXM3lyVMVJI38BWmwQsjwDvFIJ1WHCjiMNAJDK50tHSOO1Zipwh6dkTzdnxCGo/xTYN
         hnBqDSoDq9ZT7waFMPDF6u9JqhuM/kAiOQsgHReuJgCa9mODZAJEuRbCOM+hAdIZx4t9
         qr7Q==
X-Gm-Message-State: AKwxytcttQreCuji4nu+cHMdP5oK6D036r6ZQUE5kYuTYa+fmtBnAb2C
        +InnyuyBDnMht5M2TmM/bNs=
X-Google-Smtp-Source: AH8x2244YeQy9lMR20/wLRumj/aPHqqJVIVGuMxHFf0G1JjdLlUXNZPvrj6f0KSCeiHhfRRWekscBg==
X-Received: by 10.28.234.93 with SMTP id i90mr29249843wmh.112.1517535365012;
        Thu, 01 Feb 2018 17:36:05 -0800 (PST)
Received: from localhost.localdomain (x4db049fc.dyn.telefonica.de. [77.176.73.252])
        by smtp.gmail.com with ESMTPSA id r5sm758937wmg.30.2018.02.01.17.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Feb 2018 17:36:04 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 07/14] commit-graph: implement git-commit-graph --update-head
Date:   Fri,  2 Feb 2018 02:35:52 +0100
Message-Id: <20180202013552.24931-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <1517348383-112294-8-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com> <1517348383-112294-8-git-send-email-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It is possible to have multiple commit graph files in a pack directory,
> but only one is important at a time. Use a 'graph_head' file to point
> to the important file.

This implies that all those other files are ignored, right?

> Teach git-commit-graph to write 'graph_head' upon
> writing a new commit graph file.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-commit-graph.txt | 34 ++++++++++++++++++++++++++++++++++
>  builtin/commit-graph.c             | 38 +++++++++++++++++++++++++++++++++++---
>  commit-graph.c                     | 25 +++++++++++++++++++++++++
>  commit-graph.h                     |  2 ++
>  t/t5318-commit-graph.sh            | 12 ++++++++++--
>  5 files changed, 106 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
> index 09aeaf6c82..99ced16ddc 100644
> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt
> @@ -12,15 +12,49 @@ SYNOPSIS
>  'git commit-graph' --write <options> [--pack-dir <pack_dir>]
>  'git commit-graph' --read <options> [--pack-dir <pack_dir>]
>  
> +OPTIONS
> +-------

Oh, look, the 'OPTIONS' section I missed in the previous patches! ;)

This should be split up and squashed into the previous patches where
the individual --options are first mentioned.

> +--pack-dir::
> +	Use given directory for the location of packfiles, graph-head,
> +	and graph files.
> +
> +--read::
> +	Read a graph file given by the graph-head file and output basic
> +	details about the graph file. (Cannot be combined with --write.)

From the output of 'git commit-graph --read' it seems that it's not a
generally useful option to the user.  Perhaps it should be mentioned
that it's only intended as a debugging aid?  Or maybe it doesn't
really matter, because eventually this command will become irrelevant,
as other commands (clone, fetch, gc) will invoke it automagically...

> +--graph-id::
> +	When used with --read, consider the graph file graph-<oid>.graph.
> +
> +--write::
> +	Write a new graph file to the pack directory. (Cannot be combined
> +	with --read.)

I think this should also mention that it prints the generated graph
file's checksum.

> +
> +--update-head::
> +	When used with --write, update the graph-head file to point to
> +	the written graph file.

So it should be used with '--write', noted.

>  EXAMPLES
>  --------
>  
> +* Output the hash of the graph file pointed to by <dir>/graph-head.
> ++
> +------------------------------------------------
> +$ git commit-graph --pack-dir=<dir>
> +------------------------------------------------
> +
>  * Write a commit graph file for the packed commits in your local .git folder.
>  +
>  ------------------------------------------------
>  $ git commit-graph --write
>  ------------------------------------------------
>  
> +* Write a graph file for the packed commits in your local .git folder,
> +* and update graph-head.
> ++
> +------------------------------------------------
> +$ git commit-graph --write --update-head
> +------------------------------------------------
> +
>  * Read basic information from a graph file.
>  +
>  ------------------------------------------------
> diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
> index 218740b1f8..d73cbc907d 100644
> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -11,7 +11,7 @@
>  static char const * const builtin_commit_graph_usage[] = {
>  	N_("git commit-graph [--pack-dir <packdir>]"),
>  	N_("git commit-graph --read [--graph-hash=<hash>]"),
> -	N_("git commit-graph --write [--pack-dir <packdir>]"),
> +	N_("git commit-graph --write [--pack-dir <packdir>] [--update-head]"),
>  	NULL
>  };
>  
> @@ -20,6 +20,9 @@ static struct opts_commit_graph {
>  	int read;
>  	const char *graph_hash;
>  	int write;
> +	int update_head;
> +	int has_existing;
> +	struct object_id old_graph_hash;
>  } opts;
>  
>  static int graph_read(void)
> @@ -30,8 +33,8 @@ static int graph_read(void)
>  
>  	if (opts.graph_hash && strlen(opts.graph_hash) == GIT_MAX_HEXSZ)
>  		get_oid_hex(opts.graph_hash, &graph_hash);
> -	else
> -		die("no graph hash specified");
> +	else if (!get_graph_head_hash(opts.pack_dir, &graph_hash))
> +		die("no graph-head exists");
>  
>  	graph_file = get_commit_graph_filename_hash(opts.pack_dir, &graph_hash);
>  	graph = load_commit_graph_one(graph_file, opts.pack_dir);
> @@ -62,10 +65,33 @@ static int graph_read(void)
>  	return 0;
>  }
>  
> +static void update_head_file(const char *pack_dir, const struct object_id *graph_hash)
> +{
> +	struct strbuf head_path = STRBUF_INIT;
> +	int fd;
> +	struct lock_file lk = LOCK_INIT;
> +
> +	strbuf_addstr(&head_path, pack_dir);
> +	strbuf_addstr(&head_path, "/");
> +	strbuf_addstr(&head_path, "graph-head");

strbuf_addstr(&head_path, "/graph-head"); ?

> +
> +	fd = hold_lock_file_for_update(&lk, head_path.buf, LOCK_DIE_ON_ERROR);
> +	strbuf_release(&head_path);
> +
> +	if (fd < 0)
> +		die_errno("unable to open graph-head");
> +
> +	write_in_full(fd, oid_to_hex(graph_hash), GIT_MAX_HEXSZ);
> +	commit_lock_file(&lk);

The new graph-head file will be writable.  All other files in
.git/objects/pack are created read-only, including graph files.  Just
pointing it out, but I don't think it's a bit deal; other than
consistency with the permissions of other files I don't have any
argument for making it read-only.

> +}
> +
>  static int graph_write(void)
>  {
>  	struct object_id *graph_hash = construct_commit_graph(opts.pack_dir);

First the new graph file is written ...

>  
> +	if (opts.update_head)
> +		update_head_file(opts.pack_dir, graph_hash);

... and then the new graph head, good.  There could be a race if it
were the other way around.

> +
>  	if (graph_hash)
>  		printf("%s\n", oid_to_hex(graph_hash));
>  
> @@ -83,6 +109,8 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  			N_("read graph file")),
>  		OPT_BOOL('w', "write", &opts.write,
>  			N_("write commit graph file")),
> +		OPT_BOOL('u', "update-head", &opts.update_head,
> +			N_("update graph-head to written graph file")),
>  		{ OPTION_STRING, 'H', "graph-hash", &opts.graph_hash,
>  			N_("hash"),
>  			N_("A hash for a specific graph file in the pack-dir."),
> @@ -109,10 +137,14 @@ int cmd_commit_graph(int argc, const char **argv, const char *prefix)
>  		opts.pack_dir = strbuf_detach(&path, NULL);
>  	}
>  
> +	opts.has_existing = !!get_graph_head_hash(opts.pack_dir, &opts.old_graph_hash);
> +
>  	if (opts.read)
>  		return graph_read();
>  	if (opts.write)
>  		return graph_write();
>  
> +	if (opts.has_existing)
> +		printf("%s\n", oid_to_hex(&opts.old_graph_hash));

It seems that a command like 'git commit-graph --read --update-head'
succeeds and '--update-head' has no effect.  I think it should error
out.  'git commit-graph --update-head' doesn't complain, either.

Would it be more appropriate to have 'read' and 'write' subcommands
instead of '--read' and '--write' options?  Then parse-options alone
would take care of a command line like 'git commit-graph read
--update-index' and error out because of unrecognized option.

>  	return 0;
>  }
> diff --git a/commit-graph.c b/commit-graph.c
> index 622a650259..764e016ddb 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -35,6 +35,31 @@
>  #define GRAPH_MIN_SIZE (GRAPH_CHUNKLOOKUP_SIZE + GRAPH_FANOUT_SIZE + \
>  			GRAPH_OID_LEN + sizeof(struct commit_graph_header))
>  
> +struct object_id *get_graph_head_hash(const char *pack_dir, struct object_id *hash)
> +{
> +	struct strbuf head_filename = STRBUF_INIT;
> +	char hex[GIT_MAX_HEXSZ + 1];
> +	FILE *f;
> +
> +	strbuf_addstr(&head_filename, pack_dir);
> +	strbuf_addstr(&head_filename, "/graph-head");
> +
> +	f = fopen(head_filename.buf, "r");
> +	strbuf_release(&head_filename);
> +
> +	if (!f)
> +		return 0;
> +
> +	if (!fgets(hex, sizeof(hex), f))
> +		die("failed to read graph-head");
> +
> +	fclose(f);
> +
> +	if (get_oid_hex(hex, hash))
> +		return 0;
> +	return hash;
> +}
> +
>  char* get_commit_graph_filename_hash(const char *pack_dir,
>  				     struct object_id *hash)
>  {
> diff --git a/commit-graph.h b/commit-graph.h
> index e046ae575c..43eb0aec84 100644
> --- a/commit-graph.h
> +++ b/commit-graph.h
> @@ -4,6 +4,8 @@
>  #include "git-compat-util.h"
>  #include "commit.h"
>  
> +extern struct object_id *get_graph_head_hash(const char *pack_dir,
> +					     struct object_id *hash);
>  extern char* get_commit_graph_filename_hash(const char *pack_dir,
>  					    struct object_id *hash);
>  
> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index da565624e3..d1a23bcdaf 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -13,7 +13,8 @@ test_expect_success 'setup full repo' \
>       packdir=".git/objects/pack"'
>  
>  test_expect_success 'write graph with no packs' \
> -    'git commit-graph --write --pack-dir .'
> +    'git commit-graph --write --pack-dir . &&
> +     test_path_is_missing graph-head'
>  
>  test_expect_success 'create commits and repack' \
>      'for i in $(test_seq 5)
> @@ -37,6 +38,7 @@ EOF
>  test_expect_success 'write graph' \
>      'graph1=$(git commit-graph --write) &&
>       test_path_is_file ${packdir}/graph-${graph1}.graph &&
> +     test_path_is_missing ${packdir}/graph-head &&
>       git commit-graph --read --graph-hash=${graph1} >output &&
>       _graph_read_expect "5" "${packdir}" &&
>       cmp expect output'
> @@ -90,8 +92,11 @@ test_expect_success 'Add more commits' \
>  # 1
>  
>  test_expect_success 'write graph with merges' \
> -    'graph2=$(git commit-graph --write) &&
> +    'graph2=$(git commit-graph --write --update-head) &&
>       test_path_is_file ${packdir}/graph-${graph2}.graph &&
> +     test_path_is_file ${packdir}/graph-head &&
> +     echo ${graph2} >expect &&
> +     cmp -n 40 expect ${packdir}/graph-head &&

This check is fishy, and that '-n 40' will need adjustment once we
migrate to a longer hash function.  I presume you used it, because
'graph-head' contains only 40 hexdigits without a trailing newline,
but 'expect' created with 'echo' does contain a newline as well,
right?  Then this would be better instead:

  printf $graph2 >expect &&
  test_cmp expect $packdir/graph-head &&

>       git commit-graph --read --graph-hash=${graph2} >output &&
>       _graph_read_expect "18" "${packdir}" &&
>       cmp expect output'
> @@ -107,6 +112,9 @@ test_expect_success 'setup bare repo' \
>  test_expect_success 'write graph in bare repo' \
>      'graphbare=$(git commit-graph --write) &&
>       test_path_is_file ${baredir}/graph-${graphbare}.graph &&
> +     test_path_is_file ${baredir}/graph-head &&
> +     echo ${graphbare} >expect &&
> +     cmp -n 40 expect ${baredir}/graph-head &&

Likewise.

>       git commit-graph --read --graph-hash=${graphbare} >output &&
>       _graph_read_expect "18" "${baredir}" &&
>       cmp expect output'
> -- 
> 2.16.0.15.g9c3cf44.dirty


