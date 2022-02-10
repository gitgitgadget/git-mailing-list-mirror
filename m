Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B22C433EF
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 04:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiBJEBs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 23:01:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiBJEBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 23:01:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F66F24585
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 20:01:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e3so7342978wra.0
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 20:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Tjqawnv5H9z+/x9pMRucDeOvAt4oe8zHCsLEY3KyVEU=;
        b=l3iZrFqjEOe+3EMcUuoy38ebmI5L16LvguyLhfmoHJM9PGB98tC5oxporZe1au/C34
         w/JNxFOjClHln9fGX+6qCCmeBwzSUvWwpmlzXLdOh5A2pqTV+t3Uzix6LLQVPDjEIJe4
         yQjeY5+16ljhJvjI+sz323Sxb917lE/6+ImDvc51TBWQ7oDNLsRit+ArapHn5KrOAF7X
         Bvd61WKk3ZMhPuVCo2pJ28b1BpuKQ5N716piM8I1Q8vv0T0V+tUvxVXKz+F/o6FnUVW4
         g2Nq5WyjTpHZIScQLz5cVtKe50cGccRtj920+3avIxWCSWGvJZbRdFcKJlGRXiPayaT1
         dpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Tjqawnv5H9z+/x9pMRucDeOvAt4oe8zHCsLEY3KyVEU=;
        b=WOpAoy79f3KjOpSYPatlNmJnO/e5QUZKTg6xz3jNGesstGYR/70joOP4QhQY7gmOl1
         OFUXkP2R8bWZG/XC868dItjuYaTKzokDiidt+CkH1g3HRyG01LHyLdmYpjz6PqqQ27oB
         McxtBGMCP2BuTUYq2YVVi6W6gagrWII/gl2XTXGCu8tq3eT7KVp5Z/kFWNnmuXQMCFUD
         m0oEO9BFKWdUjlTXqXQwG1tiZibNyT0YQoYY2ACmuk7jmnDw1fiD57eWeXLanhPd0Zrm
         6Bjd2AiYQIMcVncyjyBNVCzS/nHg+pInx31i5hXESx/6hpGshXkwdTt1ELWjGRccYYib
         YOAA==
X-Gm-Message-State: AOAM530z43/LfefpZQPdNCLjyWLBAm0E53SgHiEbuPXqcwv49gIoja3y
        TQZqUvPF2MEJPBCbPY86FqL85oizusY=
X-Google-Smtp-Source: ABdhPJwL/wYggCrlcznb/72TVIiHMxTQn4u7/pafH11tqXqk5S+Kbv8er0OjOwnYgjbRJTAlOtXFtA==
X-Received: by 2002:a5d:4148:: with SMTP id c8mr4847460wrq.471.1644465707000;
        Wed, 09 Feb 2022 20:01:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13sm250489wmq.29.2022.02.09.20.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:01:46 -0800 (PST)
Message-Id: <pull.1212.v4.git.git.1644465706.gitgitgadget@gmail.com>
In-Reply-To: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
References: <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Feb 2022 04:01:43 +0000
Subject: [PATCH v4 0/3] Add cat-file --batch-command flag
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, phillip.wood123@gmail.com, avarab@gmail.com,
        e@80x24.org, bagasdotme@gmail.com, gitster@pobox.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The feature proposal of adding a command interface to cat-file was first
discussed in [A]. In [B], Taylor expressed the need for a fuller proposal
before moving forward with a new flag. An RFC was created [C] and the idea
was discussed more thoroughly, and overall it seemed like it was headed in
the right direction.

This patch series consolidates the feedback from these different threads.

This patch series has three parts:

 1. preparation patch to rename a variable
 2. adding an enum to keep track of batch modes
 3. logic to handle --batch-command flag, adding contents, info, flush
    commands

Changes since v3 (thanks to Junio's feedback):

 * added cascading logic in batch_options_callback()
 * free memory for queued call input lines
 * do not throw error when flushing an empty queue
 * renamed cmds array to singular queued_cmd
 * fixed flaky test that failed --stress

Changes since v2:

 * added enum to keep track of which batch mode we are in (thanks to Junio's
   feedback)
 * fixed array allocation logic (thanks to Junio's feedback)
 * added code to flush commands when --batch-commands receives an EOF and
   exits (thanks to Phillip's feedback)
 * fixed docs formatting (thanks to Jonathan's feedback)

Changes since v1:

 * simplified "session" mechanism. "flush" will execute all commands that
   were entered in since the last "flush" when in --buffer mode
 * when not in --buffer mode, each command is executed and flushed each time
 * rename cmdmode to transform_mode instead of just mode
 * simplified command parsing logic
 * changed rename of cmdmode to transform_mode
 * clarified verbiage in commit messages

A. https://lore.kernel.org/git/xmqqk0hitnkc.fsf@gitster.g/ B.
https://lore.kernel.org/git/YehomwNiIs0l83W7@nand.local/ C.
https://lore.kernel.org/git/e75ba9ea-fdda-6e9f-4dd6-24190117d93b@gmail.com/

John Cai (3):
  cat-file: rename cmdmode to transform_mode
  cat-file: introduce batch_mode enum to replace print_contents
  cat-file: add --batch-command mode

 Documentation/git-cat-file.txt |  24 ++++
 builtin/cat-file.c             | 159 +++++++++++++++++++++++--
 t/t1006-cat-file.sh            | 211 ++++++++++++++++++++++++++++++++-
 3 files changed, 382 insertions(+), 12 deletions(-)


base-commit: 38062e73e009f27ea192d50481fcb5e7b0e9d6eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1212%2Fjohn-cai%2Fjc-cat-file-batch-command-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1212/john-cai/jc-cat-file-batch-command-v4
Pull-Request: https://github.com/git/git/pull/1212

Range-diff vs v3:

 1:  fa6294387ab = 1:  fa6294387ab cat-file: rename cmdmode to transform_mode
 2:  ae2dfa512a7 ! 2:  81bc5ae1fc1 cat-file: introduce batch_command enum to replace print_contents
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    cat-file: introduce batch_command enum to replace print_contents
     +    cat-file: introduce batch_mode enum to replace print_contents
      
          The next patch introduces a new --batch-command flag. Including --batch
          and --batch-check, we will have a total of three batch modes. Currently,
     @@ builtin/cat-file.c
       #include "object-store.h"
       #include "promisor-remote.h"
       
     -+enum batch_command {
     -+	BATCH_COMMAND_CONTENTS,
     -+	BATCH_COMMAND_INFO,
     ++enum batch_mode {
     ++	BATCH_MODE_CONTENTS,
     ++	BATCH_MODE_INFO,
      +};
      +
       struct batch_options {
       	int enabled;
       	int follow_symlinks;
      -	int print_contents;
     -+	enum batch_command command_mode;
     ++	enum batch_mode batch_mode;
       	int buffer_output;
       	int all_objects;
       	int unordered;
     @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
       	batch_write(opt, scratch->buf, scratch->len);
       
      -	if (opt->print_contents) {
     -+	if (opt->command_mode == BATCH_COMMAND_CONTENTS) {
     ++	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
       		print_object_or_die(opt, data);
       		batch_write(opt, "\n", 1);
       	}
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       	 * since we will want to decide whether or not to stream.
       	 */
      -	if (opt->print_contents)
     -+	if (opt->command_mode == BATCH_COMMAND_CONTENTS)
     ++	if (opt->batch_mode == BATCH_MODE_CONTENTS)
       		data.info.typep = &data.type;
       
       	if (opt->all_objects) {
     @@ builtin/cat-file.c: static int batch_option_callback(const struct option *opt,
       	bo->enabled = 1;
      -	bo->print_contents = !strcmp(opt->long_name, "batch");
      +
     -+	if (!strcmp(opt->long_name, "batch"))
     -+		bo->command_mode = BATCH_COMMAND_CONTENTS;
     -+	if (!strcmp(opt->long_name, "batch-check"))
     -+		bo->command_mode = BATCH_COMMAND_INFO;
     ++	if (!strcmp(opt->long_name, "batch")) {
     ++		bo->batch_mode = BATCH_MODE_CONTENTS;
     ++	} else if (!strcmp(opt->long_name, "batch-check")) {
     ++		bo->batch_mode = BATCH_MODE_INFO;
     ++	} else {
     ++		BUG("%s given to batch-option-callback", opt->long_name);
     ++	}
      +
       	bo->format = arg;
       
 3:  1ab5524ee87 ! 3:  6c51324a662 cat-file: add --batch-command mode
     @@ Documentation/git-cat-file.txt: OPTIONS
      
       ## builtin/cat-file.c ##
      @@
     - #include "object-store.h"
     - #include "promisor-remote.h"
     - 
     --enum batch_command {
     --	BATCH_COMMAND_CONTENTS,
     --	BATCH_COMMAND_INFO,
     -+enum batch_mode {
     -+	BATCH_MODE_CONTENTS,
     -+	BATCH_MODE_INFO,
     -+	BATCH_MODE_PARSE_CMDS,
     + enum batch_mode {
     + 	BATCH_MODE_CONTENTS,
     + 	BATCH_MODE_INFO,
     ++	BATCH_MODE_QUEUE_AND_DISPATCH,
       };
       
       struct batch_options {
     - 	int enabled;
     - 	int follow_symlinks;
     --	enum batch_command command_mode;
     -+	enum batch_mode batch_mode;
     - 	int buffer_output;
     - 	int all_objects;
     - 	int unordered;
     -@@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
     - 	strbuf_addch(scratch, '\n');
     - 	batch_write(opt, scratch->buf, scratch->len);
     - 
     --	if (opt->command_mode == BATCH_COMMAND_CONTENTS) {
     -+	if (opt->batch_mode == BATCH_MODE_CONTENTS) {
     - 		print_object_or_die(opt, data);
     - 		batch_write(opt, "\n", 1);
     - 	}
      @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oid,
       				      data);
       }
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +
      +struct queued_cmd {
      +	parse_cmd_fn_t fn;
     -+	const char *line;
     ++	char *line;
      +};
      +
      +static void parse_cmd_contents(struct batch_options *opt,
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +	batch_one_object(line, output, opt, data);
      +}
      +
     -+static void flush_batch_calls(struct batch_options *opt,
     ++static void dispatch_calls(struct batch_options *opt,
      +		struct strbuf *output,
      +		struct expand_data *data,
     -+		struct queued_cmd *cmds,
     ++		struct queued_cmd *cmd,
      +		int nr)
      +{
      +	int i;
     -+	for (i = 0; i < nr; i++)
     -+		cmds[i].fn(opt, cmds[i].line, output, data);
     ++
     ++	for (i = 0; i < nr; i++){
     ++		cmd[i].fn(opt, cmd[i].line, output, data);
     ++		free(cmd[i].line);
     ++	}
      +
      +	fflush(stdout);
      +}
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +				    struct expand_data *data)
      +{
      +	struct strbuf input = STRBUF_INIT;
     -+	struct queued_cmd *cmds = NULL;
     ++	struct queued_cmd *queued_cmd = NULL;
      +	size_t alloc = 0, nr = 0;
      +
      +	while (!strbuf_getline(&input, stdin)) {
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +				die(_("flush is only for --buffer mode"));
      +			if (*cmd_end)
      +				die(_("flush takes no arguments"));
     -+			if (!nr)
     -+				error(_("nothing to flush"));
      +
     -+			flush_batch_calls(opt, output, data, cmds, nr);
     ++			dispatch_calls(opt, output, data, queued_cmd, nr);
      +			nr = 0;
      +			continue;
      +		}
     @@ builtin/cat-file.c: static int batch_unordered_packed(const struct object_id *oi
      +			cmd->fn(opt, p, output, data);
      +			continue;
      +		}
     -+		
     -+		ALLOC_GROW(cmds, nr + 1, alloc);
     ++
     ++		ALLOC_GROW(queued_cmd, nr + 1, alloc);
      +		call.fn = cmd->fn;
     -+		call.line = xstrdup(p);
     -+		cmds[nr++] = call;
     ++		call.line = xstrdup_or_null(p);
     ++		queued_cmd[nr++] = call;
      +	}
      +
      +	if (opt->buffer_output && nr)
     -+		flush_batch_calls(opt, output, data, cmds, nr);
     ++		dispatch_calls(opt, output, data, queued_cmd, nr);
      +
     -+	free(cmds);
     ++	free(queued_cmd);
      +	strbuf_release(&input);
      +}
      +
       static int batch_objects(struct batch_options *opt)
       {
       	struct strbuf input = STRBUF_INIT;
     -@@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
     - 	 * If we are printing out the object, then always fill in the type,
     - 	 * since we will want to decide whether or not to stream.
     - 	 */
     --	if (opt->command_mode == BATCH_COMMAND_CONTENTS)
     -+	if (opt->batch_mode == BATCH_MODE_CONTENTS)
     - 		data.info.typep = &data.type;
     - 
     - 	if (opt->all_objects) {
      @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       	save_warning = warn_on_object_refname_ambiguity;
       	warn_on_object_refname_ambiguity = 0;
       
     -+	if (opt->batch_mode == BATCH_MODE_PARSE_CMDS) {
     ++	if (opt->batch_mode == BATCH_MODE_QUEUE_AND_DISPATCH) {
      +		batch_objects_command(opt, &output, &data);
      +		goto cleanup;
      +	}
     @@ builtin/cat-file.c: static int batch_objects(struct batch_options *opt)
       	strbuf_release(&output);
       	warn_on_object_refname_ambiguity = save_warning;
      @@ builtin/cat-file.c: static int batch_option_callback(const struct option *opt,
     + 		bo->batch_mode = BATCH_MODE_CONTENTS;
     + 	} else if (!strcmp(opt->long_name, "batch-check")) {
     + 		bo->batch_mode = BATCH_MODE_INFO;
     ++	} else if (!strcmp(opt->long_name, "batch-command")) {
     ++		bo->batch_mode = BATCH_MODE_QUEUE_AND_DISPATCH;
     + 	} else {
     + 		BUG("%s given to batch-option-callback", opt->long_name);
       	}
     - 
     - 	bo->enabled = 1;
     --
     - 	if (!strcmp(opt->long_name, "batch"))
     --		bo->command_mode = BATCH_COMMAND_CONTENTS;
     -+		bo->batch_mode = BATCH_MODE_CONTENTS;
     - 	if (!strcmp(opt->long_name, "batch-check"))
     --		bo->command_mode = BATCH_COMMAND_INFO;
     -+		bo->batch_mode = BATCH_MODE_INFO;
     -+	if (!strcmp(opt->long_name, "batch-command"))
     -+		bo->batch_mode = BATCH_MODE_PARSE_CMDS;
     - 
     - 	bo->format = arg;
     - 
      @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *prefix)
       			N_("like --batch, but don't emit <contents>"),
       			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
     @@ t/t1006-cat-file.sh: $content"
      +	size=$3
      +
      +	mkfifo input &&
     -+	test_when_finished 'rm input; exec 8<&-' &&
     ++	test_when_finished 'rm input' &&
      +	mkfifo output &&
      +	exec 9<>output &&
      +	test_when_finished 'rm output; exec 9<&-'
     @@ t/t1006-cat-file.sh: test_expect_success "--batch-check with multiple sha1s give
      +info $commit_sha1
      +info $tag_sha1
      +info deadbeef
     -+info 
      +flush
      +"
      +
     ++batch_command_info_output="$hello_sha1 blob $hello_size
     ++$tree_sha1 tree $tree_size
     ++$commit_sha1 commit $commit_size
     ++$tag_sha1 tag $tag_size
     ++deadbeef missing"
     ++
      +test_expect_success "--batch-command with multiple info calls gives correct format" '
     -+	test "$batch_check_output" = "$(echo_without_newline \
     ++	test "$batch_command_info_output" = "$(echo_without_newline \
      +	"$batch_command_info_input" | git cat-file --batch-command --buffer)"
      +'
      +
     @@ t/t1006-cat-file.sh: test_expect_success "--batch-check with multiple sha1s give
      +contents $commit_sha1
      +contents $tag_sha1
      +contents deadbeef
     -+contents 
      +flush
      +"
      +
     ++batch_command_output="$hello_sha1 blob $hello_size
     ++$hello_content
     ++$commit_sha1 commit $commit_size
     ++$commit_content
     ++$tag_sha1 tag $tag_size
     ++$tag_content
     ++deadbeef missing"
     ++
      +test_expect_success "--batch-command with multiple contents calls gives correct format" '
     -+	test "$(maybe_remove_timestamp "$batch_output" 1)" = \
     ++	test "$(maybe_remove_timestamp "$batch_command_output" 1)" = \
      +	"$(maybe_remove_timestamp "$(echo_without_newline "$batch_command_contents_input" | git cat-file --batch-command)" 1)"
      +'
      +
     @@ t/t1006-cat-file.sh: test_expect_success "--batch-check with multiple sha1s give
      +info $tag_sha1
      +contents $tag_sha1
      +contents deadbeef
     -+info 
      +flush
      +"
      +
     @@ t/t1006-cat-file.sh: test_expect_success "--batch-check with multiple sha1s give
      +$tag_sha1 tag $tag_size
      +$tag_sha1 tag $tag_size
      +$tag_content
     -+deadbeef missing
     -+ missing"
     ++deadbeef missing"
      +
      +test_expect_success "--batch-command with mixed calls gives correct format" '
      +	test "$(maybe_remove_timestamp "$batch_command_mixed_output" 1)" = \
     @@ t/t1006-cat-file.sh: test_expect_success 'cat-file --batch-all-objects --batch-c
      +	echo "flush arg" >cmd &&
      +	test_expect_code 128 git cat-file --batch-command <cmd 2>err &&
      +	grep -E "^fatal:.*flush is only for --buffer mode.*" err
     -+'
     -+
     -+test_expect_success 'batch-command flush empty queue' '
     -+	echo flush >cmd &&
     -+	test_expect_code 0 git cat-file --batch-command --buffer <cmd 2>err &&
     -+	grep -E "^error:.*nothing to flush.*" err
      +'
       
       test_done

-- 
gitgitgadget
