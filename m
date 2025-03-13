Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1C522A
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 00:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825276; cv=none; b=sydv7Dm6kJbCBMJcd9a9hNNYZDKe9zx8uiGtu4w3tyMDsv7/3UED2F6Doh4AiiE5/7i9DgxJLeQJ2iZHcXTC5t/VS/ROv3TLsneeWdJnL9+6xMibigRE7nmEK74mMk8fzdW/S/9O5ekXmF579TzcJ2iDsz3xHx9DBf7jYsUUDAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825276; c=relaxed/simple;
	bh=gTi/f/m96zQoSdrB8M2lU0m5o8ZGRS2BEyrfgA75vDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5/HlzpYNdj8F0Ytyw33cMk1V9fe6H3sduUN8BKcFo9dvlxQcSi+uE87sfJS/4RNnf4UnVEAwhKxbIXhesDjHdgq5bB0ZV96CxzOySF2+RnpEb7JnqVltUa9UFCnueGgx+nVUns4lOqdD2fbsLurJf/wnwERl6lsj/M5OPBmQ7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDRIZ4Th; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDRIZ4Th"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-726819aa3fcso248305a34.0
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 17:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741825273; x=1742430073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w+5mR0RYomBN2zaQZKPIGHqHzE9yBzoExxMu+Zalzo=;
        b=RDRIZ4ThXZJdv0gvhxepqXTmijbKvjrvp3nluqPCkyyisK+3OBc7f5dk0lH2c3q8vF
         DnBtnNuVnAW3Clv4g3O+9jTW4J+s3McsTZ6MSgFOE7065BkFIVc6L3+AokWn8bsObKWp
         Y1ovc+wy98yrMKxjtia46fs7g4KQVdU5AqstvwA4K3DpiHBeE5JwNdxyLbZEKBYJFmg+
         2t0l7a5g+uk0/cl40oPDPgrSZJCvREvuMYyq5tg0RbNc9GTUFi6WTH6ZuB64YBbC2o27
         YKAAkSiy2wdkgCe9mGLl7I/I0rrrqK5H5q1tE2IY6evFekMJsV2axtHyHjZcKcVbEjVO
         1FMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741825273; x=1742430073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w+5mR0RYomBN2zaQZKPIGHqHzE9yBzoExxMu+Zalzo=;
        b=hpaXfzAfu5KFVFrk0jb4yFXI2nihxT8sX9QWMHMB2vXXFy2RZFwRiiPgWQ9RQcVj1v
         fSfwjhlA9BekYaunotBVxEY1gsz/QpnWXWCEJKF1umdUhPxJRT+JODCIx9srFUzuplFC
         d+lnnb+5qcLT5bexzEuAn3sasagXG/s4O/WuSuZSSHx7pLlSc56QOdt9itJ8lY/lI3k9
         Yr9XJpTh17icdrgnyMsmsV/ajyLFi9iBiLPGyRkL2Q+xPKtnIG1GKttkDDJhDy64yMxp
         otFRrKH/0pRV8mM41zdw0PfzXMpAz4qm9vqfk1knop1XzDmKfe6441VpGUKV3QK75/q1
         CfXw==
X-Gm-Message-State: AOJu0Yz3fFo5AZ5PeqsDODqKhAiCFpzqBpHmvv3s/qMaHMAIv/Opyibp
	AyfHJ9syDkr217vOQQkiYJwPoOWEyBv0C/NlrRGzZfx3/xfqGvms7kKjtuno
X-Gm-Gg: ASbGncsDekxiGy4GZu39jf5oKJTlCCk0GPqDy3M9yJRO6kw6swLaSxfE8Gavy4XtH8M
	ufyxbD5ojobrlv5/W5A9Ek+D5qXcn9I5fWZT1ndF7OuTLg7ucfC0+k1ohTFZjsm/7rrA2SZKt2A
	XBbAAYdbe4/Um9vZd+frerqtSdZbfTTclg8g3au1ScuVfsk94NnBzUSkCJLKfL58kCl95SbJZ6j
	i28tGSWcNjvZTGtiJ+sR/2NG+7A+3AM6evdxi+kAr20SN9LIPT/o121DcLKQMzkOxHb6LVvH11r
	/2BfixV4y950y01r4eNGCb+61t3xlFgf9Y7/nUbCP6FpPHgWQrvd
X-Google-Smtp-Source: AGHT+IHr/jhlc8xz6NmvIEp0crQd8sWxazQb2sJKBZXnIuEP0irJB/CZT+bX6ym+JwOy56UVdQMdKA==
X-Received: by 2002:a05:6830:4d98:b0:72b:8000:d487 with SMTP id 46e09a7af769-72b8000d6c9mr5849373a34.3.1741825272586;
        Wed, 12 Mar 2025 17:21:12 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb267a8b4sm24028a34.9.2025.03.12.17.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 17:21:12 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	christian.couder@gmail.com,
	peff@peff.net,
	ben.knoble@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/6] rev-list: introduce NUL-delimited output mode
Date: Wed, 12 Mar 2025 19:17:00 -0500
Message-ID: <20250313001706.3390502-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc2
In-Reply-To: <20250310192829.661692-1-jltobler@gmail.com>
References: <20250310192829.661692-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When walking objects, git-rev-list(1) prints each object entry on a
separate line in the form:

        <oid> LF

Some options, such as `--objects`, may print additional information
about the object on the same line:

        <oid> SP [<path>] LF

In this mode, if the object path contains a newline it is truncated at
the newline.

The `--boundary` option also modifies output by prefixing boundary
objects with `-`:

        -<oid> LF

When the `--missing={print,print-info}` option is provided, information
about any missing objects encountered during the object walk are also
printed in the form:

        ?<oid> [SP <token>=<value>]... LF

where values containing LF or SP are printed in a token specific fashion
so that the resulting encoded value does not contain either of these two
problematic bytes. For example, missing object paths are quoted in the C
style when they contain LF or SP.

To make machine parsing easier, this series introduces a NUL-delimited
output mode for git-rev-list(1) via a `-z` option. In this mode, the
output format for object records is unified such that each object and
its accompanying metadata is formatted without relying on object
metadata order. This format follows the existing `<token>=<value>` used
by the `--missing` option to represent object metadata in the form:

        <oid> NUL [<token>=<value> NUL]...

        # Examples
        <oid> LF                       -> <oid> NUL
        <oid> SP <path> LF             -> <oid> NUL path=<path> NUL
        -<oid> LF                      -> <oid> NUL boundary=yes NUL
        ?<oid> [SP <token>=<value>]... -> <oid> NUL missing=yes NUL [<token>=<value> NUL]...

Note that token value info is printed as-is without any special encoding
or truncation. Prefixes such as '-' and '?' are dropped in favor using a
token/value pair to signal the same information.

While in this mode, if the `--sdtin` option is used, revision and
pathspec arguments read from stdin are separated with a NUL byte instead
of being newline delimited.

For now this series only adds support for use with the `--objects`,
`--boundary` and `--missing` output options. Usage of `-z` with other
options is rejected, so it can potentially be added in the future.

This series is structured as follows:

        - Patches 1 and 2 do some minor preparatory refactors.

        - Patch 3 modifies stdin argument parsing handled by
          `setup_revisions()` to support NUL-delimited arguments.

        - Patch 4 adds the `-z` option to git-rev-list(1) to print
          objects in a NUL-delimited fashion. Arguments parsed on stdin
          while in the mode are also NUL-delimited.

        - Patch 5 teaches the `--boundary` option how to print info in a
          NUL-delimited fashino using the unified output format.

        - Patch 6 teaches the `--missing` option how to print info in a
          NUL-delimited fashion using the unified output format.

Changes since V1:

        - Use unified output format with `<token>=<value>` pairs for
          all object metadata.

        - Add support for the `--boundary` option in NUL-delimited mode.

        - Add support for NUL-delimited stdin argument parsing in
          NUL-delimited mode.

        - Instead of using two NUL bytes to delimit between object
          records, a single NUL byte is used. Now that object metadata
          is always in the form `<token>=<value>`, we know a new object
          record starts when there is an OID entry which will not
          contain '='.

Thanks for taking a look,
-Justin

Justin Tobler (6):
  rev-list: inline `show_object_with_name()` in `show_object()`
  rev-list: refactor early option parsing
  revision: support NUL-delimited --stdin mode
  rev-list: support delimiting objects with NUL bytes
  rev-list: support NUL-delimited --boundary option
  rev-list: support NUL-delimited --missing option

 Documentation/rev-list-options.adoc | 26 ++++++++
 builtin/rev-list.c                  | 92 ++++++++++++++++++++++-------
 revision.c                          | 27 ++++-----
 revision.h                          |  5 +-
 t/t6000-rev-list-misc.sh            | 51 ++++++++++++++++
 t/t6017-rev-list-stdin.sh           |  9 +++
 t/t6022-rev-list-missing.sh         | 31 ++++++++++
 7 files changed, 200 insertions(+), 41 deletions(-)

Range-diff against v1:
1:  d2eded3ac7 = 1:  d2eded3ac7 rev-list: inline `show_object_with_name()` in `show_object()`
2:  03cd08c859 = 2:  03cd08c859 rev-list: refactor early option parsing
-:  ---------- > 3:  803a49933a revision: support NUL-delimited --stdin mode
3:  41c5cb7737 ! 4:  d3b3c4ef89 rev-list: support delimiting objects with NUL bytes
    @@ Commit message
         newline are also truncated at the newline.
     
         Introduce the `-z` option for git-rev-list(1) which reformats the output
    -    to use NUL-delimiters between objects and associated info. Each object
    -    line uses two NUL bytes to indicate the end of an object entry and a
    -    single NUL byte to delimit between object information in the following
    -    form:
    +    to use NUL-delimiters between objects and associated info in the
    +    following form:
     
                 $ git rev-list -z --objects <rev>
    -            <oid> [NUL <path>] NUL NUL
    +            <oid> NUL [path=<path> NUL]
     
    -    For now, the `--objects` flag is the only option that can be used in
    -    combination with `-z`. In this mode, the object path is not truncated at
    -    newlines. In a subsequent commit, NUL-delimiter support for other
    -    options is added. Other options that do not make sense with be used in
    -    combination with `-z` are rejected.
    +    In this form, the start of each record is signaled by an OID entry that
    +    is all hexidecimal and does not contain any '='. Additional path info
    +    from `--objects` is appended to the record as a token/value pair
    +    `path=<path>` as-is without any truncation.
    +
    +    In this mode, revision and pathspec arguments provided on stdin with the
    +    `--stdin` option are also separated by a NUL byte instead of being
    +    newline delimited.
    +
    +    For now, the `--objects` and `--stdin` flag are the only options that
    +    can be used in combination with `-z`. In a subsequent commit,
    +    NUL-delimited support for other options is added. Other options that do
    +    not make sense with be used in combination with `-z` are rejected.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
    @@ Documentation/rev-list-options.adoc: ifdef::git-rev-list[]
      	`<header>` text will be printed with each progress update.
     +
     +-z::
    -+	Instead of being newline-delimited, each outputted object is delimited
    -+	with two NUL bytes in the following form:
    ++	Instead of being newline-delimited, each outputted object and its
    ++	accompanying metadata is delimited using NUL bytes in the following
    ++	form:
     ++
     +-----------------------------------------------------------------------
    -+<OID> NUL NUL
    ++<OID> NUL [<token>=<value> NUL]...
     +-----------------------------------------------------------------------
     ++
    -+When the `--objects` option is also present, available object name information
    -+is printed in the following form without any truncation for object names
    -+containing newline characters:
    ++Additional object metadata, such as object paths, is printed using the
    ++`<token>=<value>` form. Token values are printed as-is without any
    ++encoding/truncation. An OID entry never contains a '=' character and thus
    ++is used to signal the start of a new object record. Examples:
     ++
     +-----------------------------------------------------------------------
    -+<OID> [NUL <object-name>] NUL NUL
    ++<OID> NUL
    ++<OID> NUL path=<path> NUL
     +-----------------------------------------------------------------------
     ++
    -+This option is only compatible with `--objects`.
    ++This mode is only compatible with the `--objects` output option. Also, revision
    ++and pathspec argument parsing on stdin with the `--stdin` option is NUL byte
    ++delimited instead of using newlines while in this mode.
      endif::git-rev-list[]
      
      History Simplification
    @@ builtin/rev-list.c: static int arg_show_object_names = 1;
      
      #define DEFAULT_OIDSET_SIZE     (16*1024)
      
    -+static int nul_delim;
    ++static char line_term = '\n';
    ++static char info_term = ' ';
    ++
      static int show_disk_usage;
      static off_t total_disk_usage;
      static int human_readable;
    - 
    -+static void print_object_term(int nul_delim)
    -+{
    -+	char line_sep = '\n';
    -+
    -+	if (nul_delim)
    -+		line_sep = '\0';
    -+
    -+	putchar(line_sep);
    -+	if (nul_delim)
    -+		putchar(line_sep);
    -+}
    -+
    - static off_t get_object_disk_usage(struct object *obj)
    - {
    - 	off_t size;
     @@ builtin/rev-list.c: static void show_commit(struct commit *commit, void *data)
      	if (revs->commit_format == CMIT_FMT_ONELINE)
      		putchar(' ');
      	else if (revs->include_header)
     -		putchar('\n');
    -+		print_object_term(nul_delim);
    ++		putchar(line_term);
      
      	if (revs->verbose_header) {
      		struct strbuf buf = STRBUF_INIT;
    @@ builtin/rev-list.c: static void show_object(struct object *obj, const char *name
     -		putchar(' ');
     -		for (const char *p = name; *p && *p != '\n'; p++)
     -			putchar(*p);
    -+		if (nul_delim && *name) {
    -+			putchar('\0');
    -+			printf("%s", name);
    -+		} else if (!nul_delim) {
    -+			putchar(' ');
    ++		if (line_term) {
    ++			putchar(info_term);
     +			for (const char *p = name; *p && *p != '\n'; p++)
     +				putchar(*p);
    ++		} else if (*name) {
    ++			printf("%cpath=%s", info_term, name);
     +		}
      	}
      
     -	putchar('\n');
    -+	print_object_term(nul_delim);
    ++	putchar(line_term);
      }
      
      static void show_edge(struct commit *commit)
    @@ builtin/rev-list.c: int cmd_rev_list(int argc,
      		} else if (skip_prefix(arg, "--missing=", &arg)) {
      			parse_missing_action_value(arg);
     +		} else if (!strcmp(arg, "-z")) {
    -+			nul_delim = 1;
    ++			s_r_opt.nul_delim_stdin = 1;
    ++			line_term = '\0';
    ++			info_term = '\0';
      		}
      	}
      
    @@ builtin/rev-list.c: int cmd_rev_list(int argc,
      
      	}
     +
    -+	if (nul_delim) {
    ++	/*
    ++	 * Reject options currently incompatible with -z. For some options, this
    ++	 * is not an inherent limitation and support may be implemented in the
    ++	 * future.
    ++	 */
    ++	if (!line_term) {
     +		if (revs.graph || revs.verbose_header || show_disk_usage ||
     +		    info.show_timestamp || info.header_prefix || bisect_list ||
    -+		    use_bitmap_index || revs.edge_hint || arg_missing_action)
    ++		    use_bitmap_index || revs.edge_hint || revs.left_right ||
    ++		    revs.cherry_mark || arg_missing_action || revs.boundary)
     +			die(_("-z option used with unsupported option"));
     +	}
     +
    @@ t/t6000-rev-list-misc.sh: test_expect_success 'rev-list --unpacked' '
     +	oid1=$(git -C repo rev-parse HEAD) &&
     +	oid2=$(git -C repo rev-parse HEAD~) &&
     +
    -+	printf "%s\0\0%s\0\0" "$oid1" "$oid2" >expect &&
    ++	printf "%s\0%s\0" "$oid1" "$oid2" >expect &&
     +	git -C repo rev-list -z HEAD >actual &&
     +
     +	test_cmp expect actual
    @@ t/t6000-rev-list-misc.sh: test_expect_success 'rev-list --unpacked' '
     +	path1=1.t &&
     +	path2=2.t &&
     +
    -+	printf "%s\0%s\0\0%s\0%s\0\0" "$oid1" "$path1" "$oid2" "$path2" >expect &&
    ++	printf "%s\0path=%s\0%s\0path=%s\0" "$oid1" "$path1" "$oid2" "$path2" \
    ++		>expect &&
     +	git -C repo rev-list -z --objects HEAD:1.t HEAD:2.t >actual &&
     +
     +	test_cmp expect actual
     +'
     +
      test_done
    +
    + ## t/t6017-rev-list-stdin.sh ##
    +@@ t/t6017-rev-list-stdin.sh: test_expect_success '--not via stdin does not influence revisions from command l
    + 	test_cmp expect actual
    + '
    + 
    ++test_expect_success 'NUL-delimited stdin' '
    ++	printf "%s\0%s\0%s\0" "HEAD" "--" "file-1" > input &&
    ++
    ++	git rev-list -z --objects HEAD -- file-1 >expect &&
    ++	git rev-list -z --objects --stdin <input >actual &&
    ++
    ++	test_cmp expect actual
    ++'
    ++
    + test_done
-:  ---------- > 5:  5e4fc41976 rev-list: support NUL-delimited --boundary option
4:  007adbac25 ! 6:  7744966514 rev-list: support NUL-delimited --missing option
    @@ Commit message
         rev-list: support NUL-delimited --missing option
     
         The `--missing={print,print-info}` option for git-rev-list(1) prints
    -    missing objects found while performing the revision walk. Add support
    -    for printing missing objects in a NUL-delimited format when the `-z`
    -    option is enabled.
    +    missing objects found while performing the object walk in the form:
    +
    +            $ git rev-list --missing=print-info <rev>
    +            ?<oid> [SP <token>=<value>]... LF
    +
    +    Add support for printing missing objects in a NUL-delimited format when
    +    the `-z` option is enabled.
     
                 $ git rev-list -z --missing=print-info <rev>
    -            <oid> NUL NUL
    -            ?<oid> [NUL <token>=<value>]... NUL NUL
    +            <oid> NUL missing=yes NUL [<token>=<value> NUL]...
     
         In this mode, values containing special characters or spaces are printed
    -    as-is without being escaped or quoted.
    +    as-is without being escaped or quoted. Instead of prefixing the missing
    +    OID with '?', a separate `missing=yes` token/value pair is appended.
     
         Signed-off-by: Justin Tobler <jltobler@gmail.com>
     
      ## Documentation/rev-list-options.adoc ##
    -@@ Documentation/rev-list-options.adoc: containing newline characters:
    - <OID> [NUL <object-name>] NUL NUL
    +@@ Documentation/rev-list-options.adoc: ifdef::git-rev-list[]
    + <OID> NUL [<token>=<value> NUL]...
    + -----------------------------------------------------------------------
    + +
    +-Additional object metadata, such as object paths or boundary objects, is
    +-printed using the `<token>=<value>` form. Token values are printed as-is
    ++Additional object metadata, such as object paths or boundary/missing objects,
    ++is printed using the `<token>=<value>` form. Token values are printed as-is
    + without any encoding/truncation. An OID entry never contains a '=' character
    + and thus is used to signal the start of a new object record. Examples:
    + +
    +@@ Documentation/rev-list-options.adoc: and thus is used to signal the start of a new object record. Examples:
    + <OID> NUL
    + <OID> NUL path=<path> NUL
    + <OID> NUL boundary=yes NUL
    ++<OID> NUL missing=yes NUL [<token>=<value> NUL]...
      -----------------------------------------------------------------------
      +
    --This option is only compatible with `--objects`.
    -+When the `--missing` option is provided, missing objects are printed in the
    -+following form where value is printed as-is without any token specific
    -+encoding:
    -++
    -+-----------------------------------------------------------------------
    -+?<OID> [NUL <token>=<value>]... NUL NUL
    -+-----------------------------------------------------------------------
    -++
    -+This option is only compatible with `--objects` and `--missing`.
    +-This mode is only compatible with the `--objects` and `--boundary` output
    +-options. Also, revision and pathspec argument parsing on stdin with the
    +-`--stdin` option is NUL byte delimited instead of using newlines while in this
    +-mode.
    ++This mode is only compatible with the `--objects`, `--boundary`, and
    ++`--missing` output options. Also, revision and pathspec argument parsing on
    ++stdin with the `--stdin` option is NUL byte delimited instead of using newlines
    ++while in this mode.
      endif::git-rev-list[]
      
      History Simplification
     
      ## builtin/rev-list.c ##
     @@ builtin/rev-list.c: static void print_missing_object(struct missing_objects_map_entry *entry,
    - 				 int print_missing_info)
      {
      	struct strbuf sb = STRBUF_INIT;
    -+	char info_sep = ' ';
    + 
    ++	if (line_term)
    ++		putchar('?');
     +
    -+	if (nul_delim)
    -+		info_sep = '\0';
    ++	printf("%s", oid_to_hex(&entry->entry.oid));
    ++
    ++	if (!line_term)
    ++		printf("%cmissing=yes", info_term);
     +
    -+	printf("?%s", oid_to_hex(&entry->entry.oid));
    - 
      	if (!print_missing_info) {
     -		printf("?%s\n", oid_to_hex(&entry->entry.oid));
    -+		print_object_term(nul_delim);
    ++		putchar(line_term);
      		return;
      	}
      
    @@ builtin/rev-list.c: static void print_missing_object(struct missing_objects_map_
     -		strbuf_addstr(&sb, " path=");
     -		quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
     -		strbuf_addbuf(&sb, &path);
    -+		strbuf_addf(&sb, "%cpath=", info_sep);
    ++		strbuf_addf(&sb, "%cpath=", info_term);
     +
    -+		if (nul_delim) {
    -+			strbuf_addstr(&sb, entry->path);
    -+		} else {
    ++		if (line_term) {
     +			quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
     +			strbuf_addbuf(&sb, &path);
    ++		} else {
    ++			strbuf_addstr(&sb, entry->path);
     +		}
      
      		strbuf_release(&path);
      	}
      	if (entry->type)
     -		strbuf_addf(&sb, " type=%s", type_name(entry->type));
    -+		strbuf_addf(&sb, "%ctype=%s", info_sep, type_name(entry->type));
    ++		strbuf_addf(&sb, "%ctype=%s", info_term, type_name(entry->type));
     +
     +	fwrite(sb.buf, sizeof(char), sb.len, stdout);
    -+	print_object_term(nul_delim);
    ++	putchar(line_term);
      
     -	printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
      	strbuf_release(&sb);
      }
      
     @@ builtin/rev-list.c: int cmd_rev_list(int argc,
    - 	if (nul_delim) {
      		if (revs.graph || revs.verbose_header || show_disk_usage ||
      		    info.show_timestamp || info.header_prefix || bisect_list ||
    --		    use_bitmap_index || revs.edge_hint || arg_missing_action)
    -+		    use_bitmap_index || revs.edge_hint)
    + 		    use_bitmap_index || revs.edge_hint || revs.left_right ||
    +-		    revs.cherry_mark || arg_missing_action)
    ++		    revs.cherry_mark)
      			die(_("-z option used with unsupported option"));
      	}
      
    @@ t/t6022-rev-list-missing.sh: do
     +
     +		git rev-list -z --objects --no-object-names \
     +			HEAD ^"$oid" >expect &&
    -+		printf "?%s\0path=%s\0type=%s\0\0" "$oid" "$path" "$type" >>expect &&
    ++		printf "%s\0missing=yes\0path=%s\0type=%s\0" "$oid" "$path" \
    ++			"$type" >>expect &&
     +
     +		mv "$obj_path" "$obj_path.hidden" &&
     +		git rev-list -z --objects --no-object-names \

base-commit: 87a0bdbf0f72b7561f3cd50636eee33dcb7dbcc3
-- 
2.49.0.rc2

