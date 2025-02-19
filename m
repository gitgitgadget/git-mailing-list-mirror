Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2088722FAD4
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997239; cv=none; b=lyuz4y6IhWsAm0h96ktqRp4ZwdWigw3jdK3k7EFhUzJhuX//qhbpAkNf6E7ATU2BXmMENesPOKpdMZwLBggC0BqGPBXiy628BqUukKuVyg3QkAbq4dRztOeOv2HJeRSxwyn0fyBXXM87wOuelfXYxyo5q0OKLeHWJLFbxF55jJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997239; c=relaxed/simple;
	bh=wiOUSoreNaBgcgpiDe67qaYXebRQkYvDTCUHS2LxB4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdyvotsvzLousVbwdWPdsZnDF0/4GlSh+RZiSpZdESSn8GjDw4oia33y+BIi6TvVngPVH4iWUK6wh+hRri7S4G0ZJtS9XFOFA2UexTvzBdhiVNYDsIkdRFI9pc4T9nt+tNlYxJJt5Qet2e1lixVjZbljMWr9liZ1WjCsCb9d8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBdL+nPB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBdL+nPB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221050f3f00so3131915ad.2
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997237; x=1740602037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vFZZLorxQaSWGiJdpPK7QbsDZw77ooz+sBw+hOKJYc=;
        b=RBdL+nPBXZEBNhHuXgP4BXEKbeBcMbm+AIOHeGhjWrD/1IJERUEIK+vjBYwdVxpRVM
         rt3dtQA/4YmX68AKrGsJQELlYTCIVGSMxXFcOBkqHEmgAudOJmiOMbNP2Ur/o+mzs7wu
         FSkNNagGlTMbI987l+1JXQ280B25uMABOIYFo26sj0NCi1Beo2xEbBFFPaAx8jigCBrP
         n7IVoFCc34qJUVafLAamdn1hcs8bpmESDTxpAG6vfOI3ajr1UFIzKiOvlxEQpjx/uwI7
         0OogMoxf41uqE2J/Tx+sYpQu8skDIf29Fz7nci6XJtdo0MPX0DS6FMY1rxcvVhIejVK3
         k/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997237; x=1740602037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vFZZLorxQaSWGiJdpPK7QbsDZw77ooz+sBw+hOKJYc=;
        b=OybqNSX9yJvqactDnEyfpNrR+KRwiqUnWFWxV/UCosTe3g/han4o1+soC+u+bJlXnb
         8FQgBZNNdngu44Re27VGgMq2yk6wcdWtsodGXK7gUaEb52bPHGSSeVJbEZ8MJwF/8u5l
         9D7HnNQxfKc5PKJKnHvSQ/LEh7VvoosjFG2S0Haaa+/Jo+YBwzVmae+7mkXw15sze6Rf
         41A8Ty6waR9kDnu2ALoLMG/3aUqix5gNVMqhwHq3YI0/W3GFALKFaPqM2xxTvrf4SfjG
         0B/57EkiYgNUDa/T4QCrC+IfjzKayjYUGZSZZo6FiZZGlwUDt3fhCDQlV3xgidSaU4qR
         vL3w==
X-Forwarded-Encrypted: i=1; AJvYcCXy00dl32DLX8E9tbUaOfZuH2+KnQSUOgMMlMwJePsUSrquGT5QprMGKZWgor7Z98SJJcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3BFMq7ddpjEjAbSxeF9hrg17bd5MqT3IvLY3qRfvwU02xy8Xs
	8EepIdMYDREgbSht5MvIrZhLusBX4Yx20RllYSnZHT6jWfoKCUuW
X-Gm-Gg: ASbGnctclflTSjH3c/XTrCXfjhYQd+Q6HU9DEbLB2w+1oT+LiMHkIP62hokYmeWy5Ny
	zk288oe0nR1jNlJ0XBFlvbZJaqE0yYqrL0oYvF0lldPS22txtEAV4Hlpoj4G9za2eq/o+5U7vjE
	pXzX4KOWcZlI9nY0mnGE70TDM+t/iPILyTBWWTTHuMsvkGjjN6NwEMZ+9QflpdhY9jqyJ2Z3yPv
	Z2LZI0QsDWUJuZsZbCIOeMsroHzTOZwIz6XgG63n0xF7jGGpR3r71SL+QadVMJgJLNHtUPcro0p
	cKpZyZoJJhBJ+qJxWmiTaa9Ze8fhLcFCYk6ZEuHF
X-Google-Smtp-Source: AGHT+IE0guhq8XkNmOMTqzhX2BuXe+uzUhsYqvYkFo6H4FREWUB06HnE0V4aCkAjX12jw0TnBVztrw==
X-Received: by 2002:a17:903:2f88:b0:21f:8718:fc64 with SMTP id d9443c01a7336-221040d8187mr329606455ad.46.1739997235912;
        Wed, 19 Feb 2025 12:33:55 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:33:55 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 00/12][Outreachy] stop using the_repository global variable.
Date: Thu, 20 Feb 2025 02:02:48 +0530
Message-ID: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove `the_repository` global variable in favor of the repository
argument that gets passed in builtin commands. 

These sets of commands are commands that use only RUN_SETUP macro in "git.c".
Basically, When `-h` is passed to any of this command outside a Git repository,
the `run_builtin()` will call the `cmd_x()` function (where `x` is any
of the command from the sets of builtin commands that `the_repository` is removed
from) with `repo` set to NULL and then early in the function, `parse_options()`
or show_usage_with_options_if_asked() call will give the options help and exit,
without having to consult much of the configuration file.

As there exist some builtin commands where the `repository` variable is accessed
before options is given exit and fail, we will move the functions which
accessed the `repository` below the `usage_with_options()` and it
variants which will exit before getting to the function accessing the `repository`
variable. We will do this in a preparatory patches.

Some, functions also uses `the_repository` global internally, so, let's
let's refactor them and pass `struct repo` as one of the argument. 

I picked some of this files based on the above explanation, how easy they are to
resolve and how easy easy to review. 

[1]: https://public-inbox.org/git/20250210181103.3609495-1-usmanakinyemi202@gmail.com/

Changes since v1
================
- Add some new preparatory patches to move the `git_config()` below the
`usage_with_options()`.
- Fix some errors in the commit messages.

Usman Akinyemi (12):
  builtin/verify-tag: refactor `cmd_verify_tag()`
  builtin/verify-tag: stop using `the_repository`
  builtin/verify-commit: refactor `cmd_verify_commit()`
  builtin/verify-commit: stop using `the_repository`
  builtin/send-pack: refactor `cmd_send_pack()`
  builtin/send-pack: stop using `the_repository`
  builtin/pack-refs: refactor `cmd_pack_refs()`
  builtin/pack-refs: stop using `the_repository`
  builtin/ls-files: stop using `the_repository`
  builtin/for-each-ref: refactor `cmd_for_each_ref()`
  builtin/for-each-ref: stop using `the_repository`
  builtin/checkout-index: stop using `the_repository`

 builtin/checkout-index.c | 43 ++++++++++++++++++++--------------------
 builtin/for-each-ref.c   |  6 ++----
 builtin/ls-files.c       | 32 +++++++++++++++---------------
 builtin/pack-refs.c      |  9 ++++-----
 builtin/send-pack.c      |  8 ++++----
 builtin/verify-commit.c  | 15 +++++++-------
 builtin/verify-tag.c     |  9 ++++-----
 7 files changed, 58 insertions(+), 64 deletions(-)

Range-diff versus v1:

 -:  ---------- >  1:  ceb03199e1 builtin/verify-tag: refactor `cmd_verify_tag()`
 1:  3e8d11ccfe !  2:  ecfb834600 builtin/verify-tag: stop using `the_repository`
    @@ Commit message
         `run_builtin()` will call the `cmd_verify_tag()` function with `repo` set
         to NULL and then early in the function, `parse_options()` call will give
         the options help and exit, without having to consult much of the
    -    configuration file. So it is safe to omit reading the config when `repo`
    -    argument the caller gave us is NULL.
    +    configuration file.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
    @@ builtin/verify-tag.c: static const char * const verify_tag_usage[] = {
      	int i = 1, verbose = 0, had_error = 0;
      	unsigned flags = 0;
     @@ builtin/verify-tag.c: int cmd_verify_tag(int argc,
    - 		OPT_END()
    - 	};
    + 		flags |= GPG_VERIFY_OMIT_STATUS;
    + 	}
      
     -	git_config(git_default_config, NULL);
    -+	if (repo)
    -+		repo_config(repo, git_default_config, NULL);
    ++	repo_config(repo, git_default_config, NULL);
      
    - 	argc = parse_options(argc, argv, prefix, verify_tag_options,
    - 			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
    -@@ builtin/verify-tag.c: int cmd_verify_tag(int argc,
    + 	while (i < argc) {
      		struct object_id oid;
      		const char *name = argv[i++];
      
 -:  ---------- >  3:  2f770824b1 builtin/verify-commit: refactor `cmd_verify_commit()`
 2:  88af56e220 !  4:  546588a6ae builtin/verify-commit.c: stop using `the_repository`
    @@ Metadata
     Author: Usman Akinyemi <usmanakinyemi202@gmail.com>
     
      ## Commit message ##
    -    builtin/verify-commit.c: stop using `the_repository`
    +    builtin/verify-commit: stop using `the_repository`
     
         Remove the_repository global variable in favor of the repository
    -    argument that gets passed in "builtin/verify-tag.c".
    +    argument that gets passed in "builtin/verify-commit.c".
     
         When `-h` is passed to the command outside a Git repository, the
         `run_builtin()` will call the `cmd_verify_commit()` function with `repo`
         set to NULL and then early in the function, `parse_options()` call will
         give the options help and exit, without having to consult much of the
    -    configuration file. So it is safe to omit reading the config when `repo`
    -    argument the caller gave us is NULL.
    +    configuration file.
     
    -    Let's pass `repository` argument to `verify_commit()` function to remove
    -    it's dependency on the global `the_repository` variable.
    +    Pass the repository available in the calling context to `verify_commit()`
    +    to remove it's dependency on the global `the_repository` variable.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
    @@ builtin/verify-commit.c: static int verify_commit(const char *name, unsigned fla
      	int i = 1, verbose = 0, had_error = 0;
      	unsigned flags = 0;
     @@ builtin/verify-commit.c: int cmd_verify_commit(int argc,
    - 		OPT_END()
    - 	};
    + 	if (verbose)
    + 		flags |= GPG_VERIFY_VERBOSE;
      
     -	git_config(git_default_config, NULL);
    -+	if (repo)
    -+		repo_config(repo, git_default_config, NULL);
    ++	repo_config(repo, git_default_config, NULL);
      
    - 	argc = parse_options(argc, argv, prefix, verify_commit_options,
    - 			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
    -@@ builtin/verify-commit.c: int cmd_verify_commit(int argc,
    + 	/* sometimes the program was terminated because this signal
      	 * was received in the process of writing the gpg input: */
      	signal(SIGPIPE, SIG_IGN);
      	while (i < argc)
 -:  ---------- >  5:  99f10469bd builtin/send-pack: refactor `cmd_send_pack()`
 3:  39409ea113 !  6:  cb3886bc46 builtin/send-pack.c: stop using `the_repository`
    @@ Metadata
     Author: Usman Akinyemi <usmanakinyemi202@gmail.com>
     
      ## Commit message ##
    -    builtin/send-pack.c: stop using `the_repository`
    +    builtin/send-pack: stop using `the_repository`
     
         Remove the_repository global variable in favor of the repository
         argument that gets passed in "builtin/send-pack.c".
    @@ Commit message
         `run_builtin()` will call the `cmd_send_pack()` function with `repo` set
         to NULL and then early in the function, `parse_options()` call will give
         the options help and exit, without having to consult much of the
    -    configuration file. So it is safe to omit reading the config when `repo`
    -    argument the caller gave us is NULL.
    +    configuration file.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
    @@ builtin/send-pack.c: static int send_pack_config(const char *k, const char *v,
      	struct refspec rs = REFSPEC_INIT_PUSH;
      	const char *remote_name = NULL;
     @@ builtin/send-pack.c: int cmd_send_pack(int argc,
    - 		OPT_END()
    - 	};
    + 	if (!dest)
    + 		usage_with_options(send_pack_usage, options);
      
     -	git_config(send_pack_config, NULL);
    -+	if (repo)
    -+		repo_config(repo, send_pack_config, NULL);
    - 	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
    - 	if (argc > 0) {
    - 		dest = argv[0];
    ++	repo_config(repo, send_pack_config, NULL);
    + 
    + 	args.verbose = verbose;
    + 	args.dry_run = dry_run;
     @@ builtin/send-pack.c: int cmd_send_pack(int argc,
      	set_ref_status_for_push(remote_refs, args.send_mirror,
      		args.force_update);
 -:  ---------- >  7:  d104522e30 builtin/pack-refs: refactor `cmd_pack_refs()`
 4:  6fd5f4727c !  8:  7f02e48663 builtin/pack-refs: stop using `the_repository`
    @@ Commit message
         `run_builtin()` will call the `cmd_pack_refs()` function with `repo` set
         to NULL and then early in the function, `parse_options()` call will give
         the options help and exit, without having to consult much of the
    -    configuration file. So it is safe to omit reading the config when `repo`
    -    argument the caller gave us is NULL.
    +    configuration file.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
    @@ builtin/pack-refs.c: static char const * const pack_refs_usage[] = {
      	struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
      	struct string_list included_refs = STRING_LIST_INIT_NODUP;
     @@ builtin/pack-refs.c: int cmd_pack_refs(int argc,
    - 			N_("references to exclude")),
    - 		OPT_END(),
    - 	};
    --	git_config(git_default_config, NULL);
    -+	if (repo)
    -+		repo_config(repo, git_default_config, NULL);
      	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
      		usage_with_options(pack_refs_usage, opts);
      
    +-	git_config(git_default_config, NULL);
    ++	repo_config(repo, git_default_config, NULL);
    + 	for_each_string_list_item(item, &option_excluded_refs)
    + 		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
    + 
     @@ builtin/pack-refs.c: int cmd_pack_refs(int argc,
      	if (!pack_refs_opts.includes->nr)
      		string_list_append(pack_refs_opts.includes, "refs/tags/*");
 5:  c58f27988b !  9:  b706fab321 builtin/ls-files: stop using `the_repository`
    @@ Commit message
         call will give the options help and exit, without having to consult much
         of the configuration file.
     
    -    Let's pass `repository` argument to `expand_objectsize()`,
    -    `show_ru_info()` functions to remove their dependency on the global
    -    `the_repository` variable.
    +    Pass the repository available in the calling context to both
    +    `expand_objectsize()` and `show_ru_info()` to remove their
    +    dependency on the global `the_repository` variable.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
 -:  ---------- > 10:  d2fc527d51 builtin/for-each-ref: refactor `cmd_for_each_ref()`
 6:  4bbca37330 ! 11:  c3a3a6cff7 builtin/for-each-ref: stop using `the_repository`
    @@ Commit message
         `run_builtin()` will call the `cmd_for_each_ref()` function with `repo`
         set to NULL and then early in the function, `parse_options()` call will
         give the options help and exit, without having to consult much of the
    -    configuration file. So it is safe to omit reading the config when `repo`
    -    argument the caller gave us is NULL.
    +    configuration file.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
    @@ builtin/for-each-ref.c: static char const * const for_each_ref_usage[] = {
      	struct ref_sorting *sorting;
      	struct string_list sorting_options = STRING_LIST_INIT_DUP;
     @@ builtin/for-each-ref.c: int cmd_for_each_ref(int argc,
    - 
    - 	format.format = "%(objectname) %(objecttype)\t%(refname)";
    + 	if (verify_ref_format(&format))
    + 		usage_with_options(for_each_ref_usage, opts);
      
     -	git_config(git_default_config, NULL);
    -+	if (repo)
    -+		repo_config(repo, git_default_config, NULL);
    - 
    - 	/* Set default (refname) sorting */
    - 	string_list_append(&sorting_options, "refname");
    ++	repo_config(repo, git_default_config, NULL);
    + 	sorting = ref_sorting_options(&sorting_options);
    + 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
    + 	filter.ignore_case = icase;
 7:  369008d554 ! 12:  d3a18f857e builtin/checkout-index.c: stop using `the_repository`
    @@ Metadata
     Author: Usman Akinyemi <usmanakinyemi202@gmail.com>
     
      ## Commit message ##
    -    builtin/checkout-index.c: stop using `the_repository`
    +    builtin/checkout-index: stop using `the_repository`
     
         Remove the_repository global variable in favor of the repository
         argument that gets passed in "builtin/checkout-index.c".
    @@ Commit message
         call will give the options help and exit, without having to consult much
         of the configuration file.
     
    -    Let's pass `repository` argument to `checkout_all()` and `checkout_file()`
    -    functions to remove their dependency on the global `the_repository` variable.
    +    Pass the repository available in the calling context to both `checkout_all()`
    +    and `checkout_file()` to remove their dependency on the global
    +    `the_repository` variable.
     
         Mentored-by: Christian Couder <chriscool@tuxfamily.org>
         Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>

-- 
2.48.1

