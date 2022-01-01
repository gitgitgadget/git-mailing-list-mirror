Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC451C433EF
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 13:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiAANuz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 08:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiAANuz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 08:50:55 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C8C061574
        for <git@vger.kernel.org>; Sat,  1 Jan 2022 05:50:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so27844997pjf.3
        for <git@vger.kernel.org>; Sat, 01 Jan 2022 05:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fkx1gDq+Fb16/XatC/EBuxPekq5frrCUYcmuFJN+pw=;
        b=KMYu3hpUbAtgpVPLiE78FoWtmf3D9aCPCoE3gsnkNvT5cklAv42d3nKtCL0+ZA+obL
         JZ+OsvAaYugvLMQxfNNgSmY1uEC0Nl1SYTXUMmM7sfW7WVYqjv029ZvYBU+kCqVD5snj
         2xBEXTzY5DkJ5XWo3iCgbZJ8CpfZprP6q+QiOsrG5gvJ8Nx5YRa/EZw4u9c9mhYlPCgA
         SPcPXG3p8hxvbLZk3oVcpO4pMHwHpceUaAhLLGbrVctwgnemMdCwthm5gxRH1q4qbvzU
         xWBfXdemHUHt+UkirR1cYDvF3qSHIqHHxN/7hYVQqFBTUO67T7by7k3WMf6SrmZNN5Mz
         NGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fkx1gDq+Fb16/XatC/EBuxPekq5frrCUYcmuFJN+pw=;
        b=KNqHz8q9IDDggN3OplBHnHEJCMZVCS9uCvPAiTxzo2zbMNyNhbuJRVvfzIPgkLn0rr
         itFuYPmNnXXoKBv0qZ+kbKRyZq0LtzKm1lHDT/umNFrZpC7+Cn5ePTYtx+/cz/czcKa7
         p2YtIo2l1a69+Iv6emKLO3R4Xun2VzkUeLLX+CjZXwOfwQ0vknAz6NDBscS8br7DKwGs
         m1hShpYnWOnwzpXtaROkm++p6i3ckXZunGZM+tClXLRYftmw+FHPFe4+0s9J9lTxuBz5
         /62I2e7+XRhUcAzv60yUlbO3sX8Xc4G5fUMODmfuIoE5ZD9NvPOptrKwka+1AMJ3ZZgw
         Mqrg==
X-Gm-Message-State: AOAM533tu2BhIQWk9d4N2CDf2zyQJi86mzOnTQ4jdvTsft55YVjycjLC
        OXaB3hPn86HPJ5wFjnmmiSk=
X-Google-Smtp-Source: ABdhPJwLDBTpm2Hq6MMmF5YRMG79UcRB7nxwk8udFIJ1G/iEXX4oIQadDLUZTbksC0s/fYitrQAMTA==
X-Received: by 2002:a17:903:234e:b0:149:4f86:c7e6 with SMTP id c14-20020a170903234e00b001494f86c7e6mr38202286plh.21.1641045054045;
        Sat, 01 Jan 2022 05:50:54 -0800 (PST)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id o11sm34022039pfu.150.2022.01.01.05.50.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jan 2022 05:50:53 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 0/8] ls-tree: "--object-only" and "--format" opts
Date:   Sat,  1 Jan 2022 21:50:23 +0800
Message-Id: <cover.1641043500.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.1802.gbb1c3936fb.dirty
In-Reply-To: <cover.1639721750.git.dyroneteng@gmail.com>
References: <cover.1639721750.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diff from v6 (Origin) and v7 (RFC by Ævar):

1. [v6] Performance Regression

In v6, Ævar pointed out that there's a nearly 10% performance
regression under linux [1]. This is cause by in V6, I chose to
use a bitwisp operation to check whether the specified field to
be printed, this will separate the original to many "printf" to
combined the final output format. But some "checks" are unnecessary,
like we will check whether to print the "mode" and the "type", but
we do not really need to do that because only print them are
meaningless.

So in commit cb881183cb if this patch, I kept some parts of
bitwise logic in "show_tree" because it's more intuitive than before
I think. Then, move the original logic to function "show_default", now
in "show_tree" the procedure is clearer, first "show_tree_init", then 
check whether it's asked only to print objectname or filename, or to
print a default format. After this, the performance regression problem
was solved, here is the performance test result based on linux in my env: 

    $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r HEAD"
    Benchmark 1: /opt/git/master/bin/git ls-tree -r HEAD
    Time (mean ± σ):     105.8 ms ±   2.7 ms    [User: 85.7 ms, System: 20.0 ms]
    Range (min … max):   101.5 ms … 111.3 ms    28 runs
    
    $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD"
    Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD
    Time (mean ± σ):     105.0 ms ±   3.0 ms    [User: 83.7 ms, System: 21.2 ms]
    Range (min … max):    99.3 ms … 109.5 ms    27 runs
    
    $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r -l HEAD"
    Benchmark 1: /opt/git/master/bin/git ls-tree -r -l HEAD
    Time (mean ± σ):     337.4 ms ±  10.9 ms    [User: 308.3 ms, System: 29.0 ms]
    Range (min … max):   323.0 ms … 355.0 ms    10 runs
    
    $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD"
    Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD
    Time (mean ± σ):     337.6 ms ±   6.2 ms    [User: 309.4 ms, System: 28.1 ms]
    Range (min … max):   330.4 ms … 349.9 ms    10 runs

  2. [v6] Bugs in "t3104"

  Ævar found that[2] I forgot to supply a <tree-ish> in tests, that's obviously a
  bug need to fix and already done in this patch.

  3. [RFC v7 by Ævar] the pre-works commits

  Ævar helped to do some pre-works commits in V7, they are 2fcff7e0d4, 6fd1dd9383,
  208654b5e2, 2637464fd8 and d77c895a4b, I think these are all reasonable, so I
  just cherry-pick to this patch and continue the work base on them.

  First, is to support `--object-only`, had been mentioned above. The second commit is
  to create a "shown_data" struct to prepare the next "--format" commit for reusing the
  struct. The last one (ls-tree.c: introduce "--format" option) is to support the
  "--format" option.
  
  Ævar posted a commit for mainly supporting "--format" in RFC v7[3] and give some design
  and performance test context. My commit based on Ævar's (I'm not sure I have to mark
  something about Ævar in commit message, because I only made some modifications but the
  idea is from Ævar) but exists some changes:

      1).  Changed the format field names, the original's and the current's are:

          objectmode -> mode
          objecttype -> type
          objectname -> object
          path -> file

          The original's are ok, just I prefer to make the name more simple to memorize and
          type, in addition, the current Documentation/git-ls-tree.txt, at "Output Format"
          section use "<mode> SP <type> SP <object> TAB <file>" to describe the format.

          I think the names with "object" prefix are from Documentation/git-for-each-ref.txt,
          use a "objectname" is not a redundant expression because there are also "authorname"
          and "refname" to be distingushed in `git-for-each-ref`, but in "git-ls-tree",
          currently, seems like no necessary, but I'm not so much sure about the naming rules
          if I was missing something.
      
      2).  OPT_CMDMODE and OPT_BIT:

          I noticed Ævar uses "OPT_BIT" in his patch but I use "OPT_CMDMODE" (actually
          OPT_CMDMODE also is Ævar teached me) and they seems like both supporting to
          make a mutual exclusive betweem options. I didn't change them to "OPT_BIT"
          because they looked like working well, plz told me if I misunderstood. 

2. Performance comparation between "master" and v8

      1). Default format( "git ls-tree -r" vs "hitten builtin formats" vs "miss builtin formats")

        $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r HEAD"
        Benchmark 1: /opt/git/master/bin/git ls-tree -r HEAD
        Time (mean ± σ):     105.2 ms ±   3.3 ms    [User: 84.3 ms, System: 20.8 ms]
        Range (min … max):    99.2 ms … 113.2 ms    28 runs
    
        $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='%(mode) %(type) %(object)%x09%(file)'  HEAD"
        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='%(mode) %(type) %(object)%x09%(file)'  HEAD
        Time (mean ± σ):     106.4 ms ±   2.7 ms    [User: 86.1 ms, System: 20.2 ms]
        Range (min … max):   100.2 ms … 110.5 ms    29 runs

        $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='> %(mode) %(type) %(object)%x09%(file)'  HEAD"
        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='> %(mode) %(type) %(object)%x09%(file)'  HEAD
        Time (mean ± σ):     145.3 ms ±   3.9 ms    [User: 119.0 ms, System: 26.2 ms]
        Range (min … max):   139.7 ms … 150.8 ms    20 runs

      2). Default format that including object size (( "git ls-tree -r -l" vs "hitten builtin formats" vs "miss builtin formats"))

        $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r -l HEAD"
        Benchmark 1: /opt/git/master/bin/git ls-tree -r -l HEAD
        Time (mean ± σ):     335.1 ms ±   6.5 ms    [User: 304.6 ms, System: 30.4 ms]
        Range (min … max):   327.5 ms … 348.4 ms    10 runs
    
        $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='%(mode) %(type) %(object) %(size:padded)%x09%(file)'  HEAD"
        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='%(mode) %(type) %(object) %(size:padded)%x09%(file)'  HEAD
        Time (mean ± σ):     337.2 ms ±   8.2 ms    [User: 309.2 ms, System: 27.9 ms]
        Range (min … max):   328.8 ms … 349.4 ms    10 runs

        $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='> %(mode) %(type) %(object) %(size:padded)%x09%(file)'  HEAD"
        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r --format='> %(mode) %(type) %(object) %(size:padded)%x09%(file)'  HEAD
        Time (mean ± σ):     396.9 ms ±   8.9 ms    [User: 364.2 ms, System: 32.7 ms]
        Range (min … max):   379.6 ms … 408.6 ms    10 runs

Thanks.

[1] https://public-inbox.org/git/RFC-cover-0.7-00000000000-20211217T131635Z-avarab@gmail.com/
[2] https://public-inbox.org/git/211217.86o85f8jey.gmgdl@evledraar.gmail.com/
[3] https://public-inbox.org/git/RFC-patch-6.7-eac299f06ff-20211217T131635Z-avarab@gmail.com/

Teng Long (3):
  ls-tree.c: support --object-only option for "git-ls-tree"
  ls-tree.c: introduce struct "shown_data"
  ls-tree.c: introduce "--format" option

Ævar Arnfjörð Bjarmason (5):
  ls-tree: remove commented-out code
  ls-tree: add missing braces to "else" arms
  ls-tree: use "enum object_type", not {blob,tree,commit}_type
  ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
  ls-tree: split up the "init" part of show_tree()

 Documentation/git-ls-tree.txt |  55 +++++-
 builtin/ls-tree.c             | 315 +++++++++++++++++++++++++++-------
 t/t3104-ls-tree-oid.sh        |  51 ++++++
 t/t3105-ls-tree-format.sh     |  55 ++++++
 4 files changed, 415 insertions(+), 61 deletions(-)
 create mode 100755 t/t3104-ls-tree-oid.sh
 create mode 100755 t/t3105-ls-tree-format.sh

Range-diff against v7:
-:  ---------- > 1:  2fcff7e0d4 ls-tree: remove commented-out code
-:  ---------- > 2:  6fd1dd9383 ls-tree: add missing braces to "else" arms
-:  ---------- > 3:  208654b5e2 ls-tree: use "enum object_type", not {blob,tree,commit}_type
-:  ---------- > 4:  2637464fd8 ls-tree: use "size_t", not "int" for "struct strbuf"'s "len"
-:  ---------- > 5:  d77c895a4b ls-tree: split up the "init" part of show_tree()
1:  2e449d1c79 ! 6:  cb881183cb ls-tree.c: support `--object-only` option for "git-ls-tree"
    @@ Metadata
     Author: Teng Long <dyroneteng@gmail.com>
     
      ## Commit message ##
    -    ls-tree.c: support `--object-only` option for "git-ls-tree"
    +    ls-tree.c: support --object-only option for "git-ls-tree"
     
         We usually pipe the output from `git ls-trees` to tools like
         `sed` or `cut` when we only want to extract some fields.
    @@ Commit message
     
         Teach the "--object-only" option to the command to only show the
         object name. This option cannot be used together with
    -    "--name-only" or "--long" (mutually exclusive).
    +    "--name-only" or "--long" , they are mutually exclusive (actually
    +    "--name-only" and "--long" can be combined together before, this
    +    commit by the way fix this bug).
    +
    +    A simple refactoring was done to the "show_tree" function, intead by
    +    using bitwise operations to recognize the format for printing to
    +    stdout. The reason for doing this is that we don't want to increase
    +    the readability difficulty with the addition of "-object-only",
    +    making this part of the logic easier to read and expand.
    +
    +    In terms of performance, there is no loss comparing to the
    +    "master" (2ae0a9cb8298185a94e5998086f380a355dd8907), here are the
    +    results of the performance tests in my environment based on linux
    +    repository:
    +
    +        $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r HEAD"
    +        Benchmark 1: /opt/git/master/bin/git ls-tree -r HEAD
    +        Time (mean ± σ):     105.8 ms ±   2.7 ms    [User: 85.7 ms, System: 20.0 ms]
    +        Range (min … max):   101.5 ms … 111.3 ms    28 runs
    +
    +        $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD"
    +        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r HEAD
    +        Time (mean ± σ):     105.0 ms ±   3.0 ms    [User: 83.7 ms, System: 21.2 ms]
    +        Range (min … max):    99.3 ms … 109.5 ms    27 runs
    +
    +        $hyperfine --warmup=10 "/opt/git/master/bin/git ls-tree -r -l HEAD"
    +        Benchmark 1: /opt/git/master/bin/git ls-tree -r -l HEAD
    +        Time (mean ± σ):     337.4 ms ±  10.9 ms    [User: 308.3 ms, System: 29.0 ms]
    +        Range (min … max):   323.0 ms … 355.0 ms    10 runs
    +
    +        $hyperfine --warmup=10 "/opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD"
    +        Benchmark 1: /opt/git/ls-tree-oid-only/bin/git ls-tree -r -l HEAD
    +        Time (mean ± σ):     337.6 ms ±   6.2 ms    [User: 309.4 ms, System: 28.1 ms]
    +        Range (min … max):   330.4 ms … 349.9 ms    10 runs
     
         Signed-off-by: Teng Long <dyroneteng@gmail.com>
     
    @@ builtin/ls-tree.c
      	NULL
      };
      
    +-static int show_recursive(const char *base, size_t baselen, const char *pathname)
     +enum {
     +	MODE_UNSPECIFIED = 0,
     +	MODE_NAME_ONLY,
    @@ builtin/ls-tree.c
     +
     +static int cmdmode = MODE_UNSPECIFIED;
     +
    - static int show_recursive(const char *base, int baselen, const char *pathname)
    ++static int parse_shown_fields(void)
    ++{
    ++	if (cmdmode == MODE_NAME_ONLY) {
    ++		shown_bits = SHOW_FILE_NAME;
    ++		return 0;
    ++	}
    ++	if (cmdmode == MODE_OBJECT_ONLY) {
    ++		shown_bits = SHOW_OBJECT_NAME;
    ++		return 0;
    ++	}
    ++	if (!ls_options || (ls_options & LS_RECURSIVE)
    ++	    || (ls_options & LS_SHOW_TREES)
    ++	    || (ls_options & LS_TREE_ONLY))
    ++		shown_bits = SHOW_DEFAULT;
    ++	if (cmdmode == MODE_LONG)
    ++		shown_bits = SHOW_DEFAULT | SHOW_SIZE;
    ++	return 1;
    ++}
    ++
    ++static int show_recursive(const char *base, size_t baselen,
    ++			  const char *pathname)
      {
      	int i;
    -@@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    - {
    - 	int retval = 0;
    - 	int baselen;
    -+	int interspace = 0;
    - 	const char *type = blob_type;
      
    - 	if (S_ISGITLINK(mode)) {
    -@@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    - 		 *
    - 		 * Something similar to this incomplete example:
    - 		 *
    --		if (show_subprojects(base, baselen, pathname))
    --			retval = READ_TREE_RECURSIVE;
    -+		 * if (show_subprojects(base, baselen, pathname))
    -+		 *	retval = READ_TREE_RECURSIVE;
    - 		 *
    - 		 */
    - 		type = commit_type;
    +@@ builtin/ls-tree.c: static int show_recursive(const char *base, size_t baselen, const char *pathname
    + 	return 0;
    + }
    + 
    ++static int show_default(const struct object_id *oid, enum object_type type,
    ++			const char *pathname, unsigned mode,
    ++			struct strbuf *base)
    ++{
    ++	size_t baselen = base->len;
    ++
    ++	if (shown_bits & SHOW_SIZE) {
    ++		char size_text[24];
    ++		if (type == OBJ_BLOB) {
    ++			unsigned long size;
    ++			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
    ++				xsnprintf(size_text, sizeof(size_text), "BAD");
    ++			else
    ++				xsnprintf(size_text, sizeof(size_text),
    ++					  "%" PRIuMAX, (uintmax_t)size);
    ++		} else {
    ++			xsnprintf(size_text, sizeof(size_text), "-");
    ++		}
    ++		printf("%06o %s %s %7s\t", mode, type_name(type),
    ++		find_unique_abbrev(oid, abbrev), size_text);
    ++	} else {
    ++		printf("%06o %s %s\t", mode, type_name(type),
    ++		find_unique_abbrev(oid, abbrev));
    ++	}
    ++	baselen = base->len;
    ++	strbuf_addstr(base, pathname);
    ++	write_name_quoted_relative(base->buf,
    ++				   chomp_prefix ? ls_tree_prefix : NULL, stdout,
    ++				   line_termination);
    ++	strbuf_setlen(base, baselen);
    ++	return 1;
    ++}
    ++
    + static int show_tree_init(enum object_type *type, struct strbuf *base,
    + 			  const char *pathname, unsigned mode, int *retval)
    + {
     @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strbuf *base,
    - 	else if (ls_options & LS_TREE_ONLY)
    - 		return 0;
    + 	if (show_tree_init(&type, base, pathname, mode, &retval))
    + 		return retval;
      
     -	if (!(ls_options & LS_NAME_ONLY)) {
     -		if (ls_options & LS_SHOW_SIZE) {
     -			char size_text[24];
    --			if (!strcmp(type, blob_type)) {
    +-			if (type == OBJ_BLOB) {
     -				unsigned long size;
     -				if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
     -					xsnprintf(size_text, sizeof(size_text),
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -				else
     -					xsnprintf(size_text, sizeof(size_text),
     -						  "%"PRIuMAX, (uintmax_t)size);
    --			} else
    +-			} else {
     -				xsnprintf(size_text, sizeof(size_text), "-");
    --			printf("%06o %s %s %7s\t", mode, type,
    +-			}
    +-			printf("%06o %s %s %7s\t", mode, type_name(type),
     -			       find_unique_abbrev(oid, abbrev),
     -			       size_text);
    -+	if (shown_bits & SHOW_MODE) {
    -+		printf("%06o", mode);
    -+		interspace = 1;
    -+	}
    -+	if (shown_bits & SHOW_TYPE) {
    -+		printf("%s%s", interspace ? " " : "", type);
    -+		interspace = 1;
    -+	}
    -+	if (shown_bits & SHOW_OBJECT_NAME) {
    -+		printf("%s%s", interspace ? " " : "",
    -+		       find_unique_abbrev(oid, abbrev));
    -+		if (!(shown_bits ^ SHOW_OBJECT_NAME))
    -+			goto LINE_FINISH;
    -+		interspace = 1;
    -+	}
    -+	if (shown_bits & SHOW_SIZE) {
    -+		char size_text[24];
    -+		if (!strcmp(type, blob_type)) {
    -+			unsigned long size;
    -+			if (oid_object_info(the_repository, oid, &size) == OBJ_BAD)
    -+				xsnprintf(size_text, sizeof(size_text), "BAD");
    -+			else
    -+				xsnprintf(size_text, sizeof(size_text),
    -+					  "%"PRIuMAX, (uintmax_t)size);
    - 		} else
    --			printf("%06o %s %s\t", mode, type,
    +-		} else {
    +-			printf("%06o %s %s\t", mode, type_name(type),
     -			       find_unique_abbrev(oid, abbrev));
    -+			xsnprintf(size_text, sizeof(size_text), "-");
    -+		printf("%s%7s", interspace ? " " : "", size_text);
    -+		interspace = 1;
    -+	}
    -+	if (shown_bits & SHOW_FILE_NAME) {
    -+		if (interspace)
    -+			printf("\t");
    -+		baselen = base->len;
    -+		strbuf_addstr(base, pathname);
    -+		write_name_quoted_relative(base->buf,
    -+					   chomp_prefix ? ls_tree_prefix : NULL,
    -+					   stdout,
    -+					   line_termination
    -+					   ? CQ_NO_TERMINATOR_C_QUOTED
    -+					   : CQ_NO_TERMINATOR_AS_IS);
    -+		strbuf_setlen(base, baselen);
    +-		}
    ++	if (!(shown_bits ^ SHOW_OBJECT_NAME)) {
    ++		printf("%s%c", find_unique_abbrev(oid, abbrev), line_termination);
    ++		return retval;
      	}
     -	baselen = base->len;
     -	strbuf_addstr(base, pathname);
    @@ builtin/ls-tree.c: static int show_tree(const struct object_id *oid, struct strb
     -				   stdout, line_termination);
     -	strbuf_setlen(base, baselen);
     +
    -+LINE_FINISH:
    -+	putchar(line_termination);
    ++	if (!(shown_bits ^ SHOW_FILE_NAME)) {
    ++		baselen = base->len;
    ++		strbuf_addstr(base, pathname);
    ++		write_name_quoted_relative(base->buf,
    ++					   chomp_prefix ? ls_tree_prefix : NULL,
    ++					   stdout, line_termination);
    ++		strbuf_setlen(base, baselen);
    ++	}
    ++
    ++	if (!(shown_bits ^ SHOW_DEFAULT) ||
    ++	    !(shown_bits ^ (SHOW_DEFAULT | SHOW_SIZE)))
    ++		show_default(oid, type, pathname, mode, base);
    ++
      	return retval;
      }
      
    -+static int parse_shown_fields(void)
    -+{
    -+	if (cmdmode == MODE_NAME_ONLY) {
    -+		shown_bits = SHOW_FILE_NAME;
    -+		return 0;
    -+	}
    -+	if (cmdmode == MODE_OBJECT_ONLY) {
    -+		shown_bits = SHOW_OBJECT_NAME;
    -+		return 0;
    -+	}
    -+	if (!ls_options || (ls_options & LS_RECURSIVE)
    -+	    || (ls_options & LS_SHOW_TREES)
    -+	    || (ls_options & LS_TREE_ONLY))
    -+		shown_bits = SHOW_DEFAULT;
    -+	if (cmdmode == MODE_LONG)
    -+		shown_bits = SHOW_DEFAULT | SHOW_SIZE;
    -+	return 1;
    -+}
    -+
    - int cmd_ls_tree(int argc, const char **argv, const char *prefix)
    - {
    - 	struct object_id oid;
     @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *prefix)
      			LS_SHOW_TREES),
      		OPT_SET_INT('z', NULL, &line_termination,
    @@ builtin/ls-tree.c: int cmd_ls_tree(int argc, const char **argv, const char *pref
      		die("Not a valid object name %s", argv[0]);
      
     +	parse_shown_fields();
    ++
      	/*
      	 * show_recursive() rolls its own matching code and is
      	 * generally ignorant of 'struct pathspec'. The magic mask
     
    - ## quote.c ##
    -@@ quote.c: void quote_two_c_style(struct strbuf *sb, const char *prefix, const char *path,
    - 
    - void write_name_quoted(const char *name, FILE *fp, int terminator)
    - {
    --	if (terminator) {
    -+	if (0 < terminator || terminator == CQ_NO_TERMINATOR_C_QUOTED)
    - 		quote_c_style(name, NULL, fp, 0);
    --	} else {
    -+	else
    - 		fputs(name, fp);
    --	}
    --	fputc(terminator, fp);
    -+	if (0 <= terminator)
    -+		fputc(terminator, fp);
    - }
    - 
    - void write_name_quoted_relative(const char *name, const char *prefix,
    -
    - ## quote.h ##
    -@@ quote.h: int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
    - #define CQUOTE_NODQ 01
    - size_t quote_c_style(const char *name, struct strbuf *, FILE *, unsigned);
    - void quote_two_c_style(struct strbuf *, const char *, const char *, unsigned);
    -+/*
    -+ * Write a name, typically a filename, followed by a terminator that
    -+ * separates it from what comes next.
    -+ * When terminator is NUL, the name is given as-is.  Otherwise, the
    -+ * name is c-quoted, suitable for text output.  HT and LF are typical
    -+ * values used for the terminator, but other positive values are possible.
    -+ *
    -+ * In addition to non-negative values two special values in terminator
    -+ * are possible.
    -+ *
    -+ * -1: show the name c-quoted, without adding any terminator.
    -+ * -2: show the name as-is, without adding any terminator.
    -+ */
    -+#define CQ_NO_TERMINATOR_C_QUOTED	(-1)
    -+#define CQ_NO_TERMINATOR_AS_IS		(-2)
    - 
    - void write_name_quoted(const char *name, FILE *, int terminator);
    -+/*
    -+ * Similar to the above, but the name is first made relative to the prefix
    -+ * before being shown.
    -+ */
    - void write_name_quoted_relative(const char *name, const char *prefix,
    - 				FILE *fp, int terminator);
    - 
    -
    - ## t/t3103-ls-tree-misc.sh ##
    -@@ t/t3103-ls-tree-misc.sh: test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
    - 	test_must_fail git ls-tree -r HEAD
    - '
    - 
    -+test_expect_success 'usage: incompatible options: --name-status with --long' '
    -+	test_expect_code 129 git ls-tree --long --name-status
    -+'
    -+
    -+test_expect_success 'usage: incompatible options: --name-only with --long' '
    -+	test_expect_code 129 git ls-tree --long --name-only
    -+'
    -+
    - test_done
    -
      ## t/t3104-ls-tree-oid.sh (new) ##
     @@
     +#!/bin/sh
    @@ t/t3104-ls-tree-oid.sh (new)
     +'
     +
     +test_expect_success 'usage: incompatible options: --name-only with --object-only' '
    -+	test_expect_code 129 git ls-tree --object-only --name-only
    ++	test_expect_code 129 git ls-tree --object-only --name-only $tree
     +'
     +
     +test_expect_success 'usage: incompatible options: --name-status with --object-only' '
    -+	test_expect_code 129 git ls-tree --object-only --name-status
    ++	test_expect_code 129 git ls-tree --object-only --name-status $tree
     +'
     +
     +test_expect_success 'usage: incompatible options: --long with --object-only' '
    -+	test_expect_code 129 git ls-tree --object-only --long
    ++	test_expect_code 129 git ls-tree --object-only --long $tree
     +'
     +
     +test_done
-:  ---------- > 7:  296ebacafe ls-tree.c: introduce struct "shown_data"
-:  ---------- > 8:  e0add802fb ls-tree.c: introduce "--format" option
-- 
2.33.0.rc1.1802.gbb1c3936fb.dirty

