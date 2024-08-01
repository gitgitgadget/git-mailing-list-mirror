Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F1613B5A5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525062; cv=none; b=EsRAAg29P7y4GwosCgAjRpK7pz6+h8zC/r8913GAbK4gihrX/TlVYdtN0mTf93W54tlsgraIuRk0/21cicaJ3wO9l2gJvUNDW6IVrkz5pcZpZ5FwixzsoIXOwsR64LaZQOZOpk2kp70mGx3W9MZmGQU1soxaB6oJ9Sk7WfUYOJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525062; c=relaxed/simple;
	bh=rZwukYd0ASfvJ/9TWP8a8dZcqFu3avvHRPxpfvTA+ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPd0gZoJXumbEsRMicBxQrjkroEPCXr7npdyIDV9wkFAhhbbyo157eJJZrFeKv4qade+UWS+3mx00d+S97+PKlcNnuqyy01MC6mVwmW/pAzewwd9ZLvTnF9Qp2lsFwMt+cgXgrdhLK7v8ASg3ZTr+twmkdQ9EiZmyRsDrzcx86g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV5lKLVQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV5lKLVQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd640a6454so55696365ad.3
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 08:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525059; x=1723129859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zC1ITbrfJU8NnVinmpRy+Fp7+TlyW04Nyu385Xf2W8=;
        b=LV5lKLVQriGX9Niy3LTX4zStnAIw3LgCrFPbg1vO65hi5lc6N1Uy20e6Adj/JGPb1o
         S1KI75x78I3ToWbHttPDJAC9fnMCL7y59I0AKKNZqIEfEep3zE/4vOJNXwWrvlXzRbsc
         g3DOG26gXvU1A0MK6/ciud9RHwPa/gYPFn/vDq21Xlzv2fUfNzTNkaXQcIso37s2w+wU
         +ksFR9ZcV08+gxIMY46EuC7z2VmhVhDv5jzBWO+JEzHQzR5kIJg9iukziCcWR5ToxhUc
         JKm5Z6Ns2UEIj1cRg22YbUG4kMHAeZ5cAv+bNdluvjA5SN1vA/gyNhpHQSzEmFfq4vxB
         Rzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525059; x=1723129859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zC1ITbrfJU8NnVinmpRy+Fp7+TlyW04Nyu385Xf2W8=;
        b=RyqApwFzyvmcgBqczlqVKS0SkSppK73ch8r0/IcsJnRS1qPRRpZdWIqKcgd30WwQ7m
         24qsD6L9ThzDQ27bN4FP5ZCDwE9maqSPkeHGo+P9vTx6Op7RqYsorWUkXbtyEh+KhB6d
         PPS0aaDTI+ys2mkQOWgFwHIuTDmnlwu5O6qFNSiFgSNyTfHSccOLr1ZE48sKHmc/rciG
         U/oxb1heMED3SF53KE6PG5+uO6iWTxTVk68WEXmcWhvkIGOL/1KFp/fI5v1vIPtIG3Zn
         6qJYHca55bLekB5BOqii4+PdT2FLuWAZPeAJSF8Ml/vAepVaBbWp2yQq9kKnWe1loQhk
         5vBQ==
X-Gm-Message-State: AOJu0YzJt6SsS3GgENEJOrT5aZuh3OIGVf64R6YOtvfOPPC9SH0a63a3
	0q3yvI3z4OxJ72mI+8YBzMQWVlfo8KyEpA1dqShQQhSUY+M0ufeGTPMzbA==
X-Google-Smtp-Source: AGHT+IEVyhr4SraVJza6bDGFFLO7fzHXSTRTelH7BQcXida8Vb2C6LJcaGKgg8HsBRIM+y7AeCIOnw==
X-Received: by 2002:a17:902:edd3:b0:1fc:4aff:5b46 with SMTP id d9443c01a7336-1ff574911a6mr4384325ad.47.1722525059140;
        Thu, 01 Aug 2024 08:10:59 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee1258sm140397525ad.147.2024.08.01.08.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:10:58 -0700 (PDT)
Date: Thu, 1 Aug 2024 23:11:21 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v14 00/11] ref consistency check infra setup
Message-ID: <ZqulmWVBaeyP4blf@ArchLinux>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqeXrPROpEg_pRS2@ArchLinux>

Hi All,

This version does the following things:

1. By following the advice from Patrick, we should make the callback
function be generic by adding only one "void * fsck_report" parameter.
Thus the commit sequence will be much more clearer. And it wll be much
easier for reviewers to review. And I have split the commit into more
commits in this version.
2. Enhance the commit messages to provide more context about why we
should do this.
3. Patrick advices that we should initialize the "fsck_options" member
when parsing the options. However, because the original "strict" and
"verbose" field are defined as the bit field, we cannot take the address
of them. So I simply remove the bit field.
4. As Patrick said, ".lock" should not be reported as error. At current,
ignore files ending with ".lock".
5. Add a fsck msg type called "badRefFiletype" which indicates that a
ref has a bad file type when scanning the directory.
6. Junio advices instead of using "fsck_refs_fns", we should use the
singular version "fsck_refs_fn", fix this.
7. Drop the last patch because in this series, we mainly focus on the
infra, I will add a series later to add ref content check.

However, there is one thing holding. Junio advices that I should
follow the Patrick's change to change the prototype of "files_fsck_refs_fn"

   https://lore.kernel.org/git/fe0e2c3617c8040c632dbc3de613a1d22e8070f7.1722316795.git.ps@pks.im/

However, at current, this patch is not in the cooking tree. I will
handle this later.

shejialuo (11):
  fsck: rename "skiplist" to "skip_oids"
  fsck: make "fsck_error" callback generic
  fsck: add a unified interface for reporting fsck messages
  fsck: add refs report function
  fsck: add refs-related error callback
  fsck: rename objects-related fsck error functions
  refs: set up ref consistency check infrastructure
  builtin/refs: add verify subcommand
  builtin/fsck: add `git-refs verify` child process
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend

 Documentation/fsck-msgids.txt |   6 ++
 Documentation/git-refs.txt    |  13 ++++
 builtin/fsck.c                |  34 +++++++--
 builtin/mktag.c               |   3 +-
 builtin/refs.c                |  34 +++++++++
 fsck.c                        | 131 +++++++++++++++++++++++++++-------
 fsck.h                        |  76 +++++++++++++++-----
 object-file.c                 |   9 ++-
 refs.c                        |   5 ++
 refs.h                        |   8 +++
 refs/debug.c                  |  11 +++
 refs/files-backend.c          | 118 +++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 +++
 refs/refs-internal.h          |   6 ++
 refs/reftable-backend.c       |   8 +++
 t/t0602-reffiles-fsck.sh      |  94 ++++++++++++++++++++++++
 16 files changed, 504 insertions(+), 60 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v13:
 1:  772cad5b92 =  1:  75b64a219d fsck: rename "skiplist" to "skip_oids"
 2:  e76449977d <  -:  ---------- fsck: add a unified interface for reporting fsck messages
 -:  ---------- >  2:  81433d1628 fsck: make "fsck_error" callback generic
 -:  ---------- >  3:  0792c51e6d fsck: add a unified interface for reporting fsck messages
 -:  ---------- >  4:  ecd144af15 fsck: add refs report function
 -:  ---------- >  5:  e80dba0cab fsck: add refs-related error callback
 3:  26bde4283f !  6:  a61db42bf2 fsck: rename objects-related fsck error functions
    @@ Metadata
      ## Commit message ##
         fsck: rename objects-related fsck error functions
     
    -    The names of objects-related fsck error functions are general. It's OK
    +    The names of objects-related fsck error functions are generic. It's OK
         when there is only object database check. However, we have introduced
         refs database check report function. To avoid ambiguity, rename
         object-related fsck error functions to explicitly indicate these
    @@ builtin/fsck.c: static int objerror(struct object *obj, const char *err)
      }
      
     -static int fsck_error_func(struct fsck_options *o UNUSED,
    --			   const struct object_id *oid,
    --			   enum object_type object_type,
    --			   const struct fsck_refs_info *refs_info UNUSED,
    +-			   void *fsck_report,
     -			   enum fsck_msg_type msg_type,
     -			   enum fsck_msg_id msg_id UNUSED,
     -			   const char *message)
     +static int fsck_objects_error_func(struct fsck_options *o UNUSED,
    -+				   const struct object_id *oid,
    -+				   enum object_type object_type,
    -+				   const struct fsck_refs_info *refs_info UNUSED,
    ++				   void *fsck_report,
     +				   enum fsck_msg_type msg_type,
     +				   enum fsck_msg_id msg_id UNUSED,
     +				   const char *message)
      {
    - 	switch (msg_type) {
    - 	case FSCK_WARN:
    + 	struct fsck_object_report *report = fsck_report;
    + 	const struct object_id *oid = report->oid;
     @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char *prefix)
      
      	fsck_walk_options.walk = mark_object;
    @@ fsck.c: int fsck_buffer(const struct object_id *oid, enum object_type type,
      }
      
     -int fsck_error_function(struct fsck_options *o,
    --			const struct object_id *oid,
    --			enum object_type object_type UNUSED,
    --			const struct fsck_refs_info *refs_info UNUSED,
    +-			void *fsck_report,
     -			enum fsck_msg_type msg_type,
     -			enum fsck_msg_id msg_id UNUSED,
     -			const char *message)
     +int fsck_objects_error_function(struct fsck_options *o,
    -+				const struct object_id *oid,
    -+				enum object_type object_type UNUSED,
    -+				const struct fsck_refs_info *refs_info UNUSED,
    ++				void *fsck_report,
     +				enum fsck_msg_type msg_type,
     +				enum fsck_msg_id msg_id UNUSED,
     +				const char *message)
      {
    - 	if (msg_type == FSCK_WARN) {
    - 		warning("object %s: %s", fsck_describe_object(o, oid), message);
    + 	struct fsck_object_report *report = fsck_report;
    + 	const struct object_id *oid = report->oid;
     @@ fsck.c: int git_fsck_config(const char *var, const char *value,
       * Custom error callbacks that are used in more than one place.
       */
      
     -int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
    --					   const struct object_id *oid,
    --					   enum object_type object_type,
    --					   const struct fsck_refs_info *refs_info,
    +-					   void *fsck_report,
     -					   enum fsck_msg_type msg_type,
     -					   enum fsck_msg_id msg_id,
     -					   const char *message)
     +int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
    -+						   const struct object_id *oid,
    -+						   enum object_type object_type,
    -+						   const struct fsck_refs_info *refs_info,
    ++						   void *fsck_report,
     +						   enum fsck_msg_type msg_type,
     +						   enum fsck_msg_id msg_id,
     +						   const char *message)
      {
      	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
    - 		puts(oid_to_hex(oid));
    + 		struct fsck_object_report *report = fsck_report;
    + 		puts(oid_to_hex(report->oid));
      		return 0;
      	}
    --	return fsck_error_function(o, oid, object_type, refs_info,
    --				   msg_type, msg_id, message);
    -+	return fsck_objects_error_function(o, oid, object_type, refs_info,
    -+					   msg_type, msg_id, message);
    +-	return fsck_error_function(o, fsck_report, msg_type, msg_id, message);
    ++	return fsck_objects_error_function(o, fsck_report, msg_type,msg_id, message);
      }
     
      ## fsck.h ##
    @@ fsck.h: typedef int (*fsck_error)(struct fsck_options *o,
      			  const char *message);
      
     -int fsck_error_function(struct fsck_options *o,
    --			const struct object_id *oid, enum object_type object_type,
    --			const struct fsck_refs_info *refs_info,
    +-			void *fsck_report,
     -			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
     -			const char *message);
     -int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
    --					   const struct object_id *oid,
    --					   enum object_type object_type,
    --					   const struct fsck_refs_info *refs_info,
    +-					   void *fsck_report,
     -					   enum fsck_msg_type msg_type,
     -					   enum fsck_msg_id msg_id,
     -					   const char *message);
     +int fsck_objects_error_function(struct fsck_options *o,
    -+				const struct object_id *oid, enum object_type object_type,
    -+				const struct fsck_refs_info *refs_info,
    ++				void *fsck_report,
     +				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
     +				const char *message);
     +int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
    -+						   const struct object_id *oid,
    -+						   enum object_type object_type,
    -+						   const struct fsck_refs_info *refs_info,
    ++						   void *fsck_report,
     +						   enum fsck_msg_type msg_type,
     +						   enum fsck_msg_id msg_id,
     +						   const char *message);
      
    - /*
    -  * The information for reporting refs-related error message
    + int fsck_refs_error_function(struct fsck_options *options,
    + 			     void *fsck_report,
     @@ fsck.h: struct fsck_options {
      	.gitmodules_done = OIDSET_INIT, \
      	.gitattributes_found = OIDSET_INIT, \
    @@ fsck.h: struct fsck_options {
     -	.error_func = fsck_error_cb_print_missing_gitmodules, \
     +	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
      }
    - 
    - /* descend in all linked child objects
    + #define FSCK_REFS_OPTIONS_DEFAULT { \
    + 	.error_func = fsck_refs_error_function, \
 4:  56fc833a54 <  -:  ---------- fsck: add refs-related error report function
 5:  90f992ecfb !  7:  f2248bc52d refs: set up ref consistency check infrastructure
    @@ Metadata
      ## Commit message ##
         refs: set up ref consistency check infrastructure
     
    +    The "struct ref_store" is the base class which contains the "be" pointer
    +    which provides backend-specific functions whose interfaces are defined
    +    in the "ref_storage_be". We could reuse this polymorphism to define only
    +    one interface. For every backend, we need to provide its own function
    +    pointer.
    +
         The interfaces defined in the `ref_storage_be` are carefully structured
         in semantic. It's organized as the five parts:
     
 6:  b2277f5ef4 !  8:  0c5463d757 git refs: add verify subcommand
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    git refs: add verify subcommand
    +    builtin/refs: add verify subcommand
     
         Introduce a new subcommand "verify" in git-refs(1) to allow the user to
         check the reference database consistency and also this subcommand will
    -    be used as the entry point of checking refs for "git-fsck(1)". Last, add
    -    "verbose" field into "fsck_options" to indicate whether we should print
    -    verbose messages when checking refs and objects consistency.
    +    be used as the entry point of checking refs for "git-fsck(1)".
    +
    +    Add "verbose" field into "fsck_options" to indicate whether we should
    +    print verbose messages when checking refs and objects consistency.
    +
    +    Remove bit-field for "strict" field, this is because we cannot take
    +    address of a bit-field which makes it unhandy to set member variables
    +    when parsing the command line options.
    +
    +    The "git-fsck(1)" declares "fsck_options" variable with "static"
    +    identifier which avoids complaint by the leak-checker. However, in
    +    "git-refs verify", we need to do memory clean manually. Thus add
    +    "fsck_options_clear" function in "fsck.c" to provide memory clean
    +    operation.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ Documentation/git-refs.txt: include::ref-storage-format.txt[]
     +The following options are specific to 'git refs verify':
     +
     +--strict::
    -+	Enable more strict checking, every WARN severity for the `Fsck Messages`
    -+	be seen as ERROR. See linkgit:git-fsck[1].
    ++	Enable stricter error checking. This will cause warnings to be
    ++	reported as errors. See linkgit:git-fsck[1].
     +
     +--verbose::
     +	When verifying the reference database consistency, be chatty.
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
     +		REFS_VERIFY_USAGE,
     +		NULL,
     +	};
    -+	unsigned int verbose = 0, strict = 0;
     +	struct option options[] = {
    -+		OPT__VERBOSE(&verbose, N_("be verbose")),
    -+		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
    ++		OPT_BOOL(0, "verbose", &fsck_refs_options.verbose, N_("be verbose")),
    ++		OPT_BOOL(0, "strict", &fsck_refs_options.strict, N_("enable strict checking")),
     +		OPT_END(),
     +	};
     +	int ret;
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
     +	if (argc)
     +		usage(_("'git refs verify' takes no arguments"));
     +
    -+	if (verbose)
    -+		fsck_refs_options.verbose = 1;
    -+	if (strict)
    -+		fsck_refs_options.strict = 1;
    -+
     +	git_config(git_fsck_config, &fsck_refs_options);
     +	prepare_repo_settings(the_repository);
     +
     +	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
     +
    -+	/*
    -+	 * Explicitly free the allocated array and "skip_oids" set
    -+	 */
    -+	free(fsck_refs_options.msg_type);
    -+	oidset_clear(&fsck_refs_options.skip_oids);
    ++	fsck_options_clear(&fsck_refs_options);
     +	return ret;
     +}
     +
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
      	};
      
     
    + ## fsck.c ##
    +@@ fsck.c: int fsck_finish(struct fsck_options *options)
    + 	return ret;
    + }
    + 
    ++void fsck_options_clear(struct fsck_options *options)
    ++{
    ++	free(options->msg_type);
    ++	oidset_clear(&options->skip_oids);
    ++	oidset_clear(&options->gitmodules_found);
    ++	oidset_clear(&options->gitmodules_done);
    ++	oidset_clear(&options->gitattributes_found);
    ++	oidset_clear(&options->gitattributes_done);
    ++	kh_clear_oid_map(options->object_names);
    ++}
    ++
    + int git_fsck_config(const char *var, const char *value,
    + 		    const struct config_context *ctx, void *cb)
    + {
    +
      ## fsck.h ##
    -@@ fsck.h: struct fsck_options {
    +@@ fsck.h: struct fsck_ref_report {
    + struct fsck_options {
      	fsck_walk_func walk;
      	fsck_error error_func;
    - 	unsigned strict:1;
    -+	unsigned verbose:1;
    +-	unsigned strict:1;
    ++	unsigned strict;
    ++	unsigned verbose;
      	enum fsck_msg_type *msg_type;
      	struct oidset skip_oids;
      	struct oidset gitmodules_found;
    +@@ fsck.h: int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
    +  */
    + int fsck_finish(struct fsck_options *options);
    + 
    ++/*
    ++ * Clear the fsck_options struct, freeing any allocated memory.
    ++ */
    ++void fsck_options_clear(struct fsck_options *options);
    ++
    + /*
    +  * Report an error or warning for refs.
    +  */
 7:  f96d0f200d =  9:  0ac25c2f6e builtin/fsck: add `git-refs verify` child process
 8:  f9a0c16bef ! 10:  2b6f5e6c46 files-backend: add unified interface for refs scanning
    @@ Commit message
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
         Signed-off-by: shejialuo <shejialuo@gmail.com>
     
    + ## Documentation/fsck-msgids.txt ##
    +@@
    + `badParentSha1`::
    + 	(ERROR) A commit object has a bad parent sha1.
    + 
    ++`badRefFiletype`::
    ++	(ERROR) A ref has a bad file type.
    ++
    + `badTagName`::
    + 	(INFO) A tag has an invalid format.
    + 
    +
    + ## fsck.h ##
    +@@ fsck.h: enum fsck_msg_type {
    + 	FUNC(BAD_NAME, ERROR) \
    + 	FUNC(BAD_OBJECT_SHA1, ERROR) \
    + 	FUNC(BAD_PARENT_SHA1, ERROR) \
    ++	FUNC(BAD_REF_FILETYPE, ERROR) \
    + 	FUNC(BAD_TIMEZONE, ERROR) \
    + 	FUNC(BAD_TREE, ERROR) \
    + 	FUNC(BAD_TREE_SHA1, ERROR) \
    +
      ## refs/files-backend.c ##
     @@
      #include "../gettext.h"
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +static int files_fsck_refs_dir(struct ref_store *ref_store,
     +			       struct fsck_options *o,
     +			       const char *refs_check_dir,
    -+			       files_fsck_refs_fn *fsck_refs_fns)
    ++			       files_fsck_refs_fn *fsck_refs_fn)
     +{
     +	const char *gitdir = ref_store->gitdir;
     +	struct strbuf sb = STRBUF_INIT;
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +	strbuf_addf(&sb, "%s/%s", gitdir, refs_check_dir);
     +
     +	iter = dir_iterator_begin(sb.buf, 0);
    -+
     +	if (!iter) {
    -+		ret = error_errno("cannot open directory %s", sb.buf);
    ++		ret = error_errno(_("cannot open directory %s"), sb.buf);
     +		goto out;
     +	}
     +
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +			if (o->verbose)
     +				fprintf_ln(stderr, "Checking %s/%s",
     +					   refs_check_dir, iter->relative_path);
    -+			for (size_t i = 0; fsck_refs_fns[i]; i++) {
    -+				if (fsck_refs_fns[i](o, gitdir, refs_check_dir, iter))
    ++			for (size_t i = 0; fsck_refs_fn[i]; i++) {
    ++				if (fsck_refs_fn[i](o, gitdir, refs_check_dir, iter))
     +					ret = -1;
     +			}
     +		} else {
    -+			ret = error(_("unexpected file type for '%s'"),
    -+				    iter->basename);
    ++			struct fsck_ref_report report = { .path = iter->basename };
    ++			if (fsck_report_ref(o, &report,
    ++					    FSCK_MSG_BAD_REF_FILETYPE,
    ++					    "unexpected file type"))
    ++				ret = -1;
     +		}
     +	}
     +
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +static int files_fsck_refs(struct ref_store *ref_store,
     +			   struct fsck_options *o)
     +{
    -+	files_fsck_refs_fn fsck_refs_fns[]= {
    -+		NULL
    ++	files_fsck_refs_fn fsck_refs_fn[]= {
    ++		NULL,
     +	};
     +
     +	if (o->verbose)
     +		fprintf_ln(stderr, "Checking references consistency");
    -+
    -+	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fns);
    ++	return files_fsck_refs_dir(ref_store, o,  "refs", fsck_refs_fn);
     +
     +}
     +
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
      		files_downcast(ref_store, REF_STORE_READ, "fsck");
      
     -	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
    -+	return refs->packed_ref_store->be->fsck(refs->packed_ref_store, o) |
    -+	       files_fsck_refs(ref_store, o);
    ++	return files_fsck_refs(ref_store, o) |
    ++	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o);
      }
      
      struct ref_storage_be refs_be_files = {
 9:  ee55ee5787 <  -:  ---------- fsck: add ref name check for files backend
10:  9256328cbb <  -:  ---------- fsck: add ref content check for files backend
 -:  ---------- > 11:  14f2739bd7 fsck: add ref name check for files backend
-- 
2.45.2

