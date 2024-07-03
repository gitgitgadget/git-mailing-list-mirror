Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3DC3CF73
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 13:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014830; cv=none; b=cM6DCGUhO6XZMC+hY8jk/r2vMmvDS6/ZpuDI8eqiHa4+YTacSSwrk4ndIkb+CGlOgMhs3CBujzSSfR46CCSNBP7pVgD0FlRMLeGmSOACL2RJ8WCxbwjejXDfOBdNe4dPLSfUOtWNpSydezMOckRIyCqXGiX2ZsfUDpIaf6RUFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014830; c=relaxed/simple;
	bh=vFAAPTlC5hSd/t7GHabVV6FpZJbSWDvBDeq+kuOip1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8j8t1CSxLYkYOI/XFKFey1HOje2AWLDbmNzed1BKXUWh9WI5x5Eib+nIOKix6H8HYvBqbtXFma8XKrecf3STqzrHpjaC5CFpcFkM6WH/IuzRKqAsznqissffOWWY/KrB0gSBPyOIceK3L/mR4p371ZPVD1TZr8p9Cb5oNAnQsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDiq6D2B; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDiq6D2B"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3d853e31de8so391378b6e.2
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 06:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720014827; x=1720619627; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDfPv1WtwN5fAxMk9cOZIwXGg+fIPh8GYKPv6dL2SEs=;
        b=lDiq6D2B57Kr0bt5aWag9LCe0xTKWaz9jdxDGOBU4zfgXZ4b64OCSmXVzRfTGtfPGy
         wAsPoCqj32a0SxebcpFbVwuYW0U+iPk7k/aS1lS0vi/WqgZXBQJfDe/VjjXjnaGnbCOz
         9Lq8qQ6COz+MUDrG7/VyxbrHFhF441Gw3H34dpKCUIcYuYILmwR6Fctw92nWsbkWbq9X
         Ff8cx1CXZHoPIykyPJgPKH4Ix4GB3GFmr9d+CJPgUJqLa6ntt/YfTxpQyOaZkql7oZuB
         i83VAiKH9eOLaE2lhKFT+yfGBVo6PPkg1WNgURuO7HFxCw2XclaTAgQ2LG2Tm769MyUd
         z1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720014827; x=1720619627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDfPv1WtwN5fAxMk9cOZIwXGg+fIPh8GYKPv6dL2SEs=;
        b=uoBR/KrjhXF5FOnGOruZksk2H3TnRjSfUnQN95weGwA8SX8A+MKwkj49jOjQL2BZtj
         q7vKZidHoBEn4CT5BcbVzKNpyH8NvJjU/sIuUugQ6GEi5rw5S4S1mIk+BiVc8x8JZezj
         FjBXzxSLjJJ2aEQUsb3U8TgN9KRO/ubWcvD2gM9Sw2Lm+SDznzntdwQ3+uSIhcuwZ4PD
         v9KD59daHfpu7rokKVGUPa1okzvClmMDcMBAoZSoXRC2sEaLzmeU6Z6NPdpVapW8c025
         Hx/GWYNA/DtQUbOed9qEJ94jFK0/T/4ABh/oX9U7wI0kXLTluTmY0lDvzdfZZCQJQIMp
         5W+Q==
X-Gm-Message-State: AOJu0YwS5R7BgbLwXpYZ6QLqXbANB+iCH5YPDnX0EgpuPWPTb/Za/Tlf
	1eHYaX+cofhVD6876vI0VaryNW1JXX+mmroZ52rGHPrVLqirWarbijlYua/B
X-Google-Smtp-Source: AGHT+IGHLxxQ8z+OkN2qnmPfRXbiuVgaC+nJkLOyxUJ2GPWqeeNVObhgiIcIpdaOaV8CYKs5PQptvA==
X-Received: by 2002:a05:6808:1a2a:b0:3d5:630e:7b6f with SMTP id 5614622812f47-3d6b30f4620mr15661887b6e.10.1720014827166;
        Wed, 03 Jul 2024 06:53:47 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70802568f18sm10411987b3a.76.2024.07.03.06.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:53:46 -0700 (PDT)
Date: Wed, 3 Jul 2024 21:53:46 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v7 0/9] ref consistency check infra setup
Message-ID: <ZoVX6sn2C9VIeZ38@ArchLinux>
References: <ZoLHtmOKTfxMSxvw@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoLHtmOKTfxMSxvw@ArchLinux>

Hi All:

We have come to an agreement that there is no need to add complexity in
"fsck_options". So this version just adds a new field into "fsck_option"
for refs. The other parts are just the same as the previous version.

CI: https://github.com/shejialuo/git/pull/7

This patch is made upon the latest commit:

   06e570c0df (Sync with 'maint', 2024-07-02)

> Just like premature optimization is bad, premature factoring and
> over-modularization is bad.

I have learned a lot from yesterday's email. I always think we should
modularize the code which made a lot of trouble in this series. However,
the range-diff below may contain some commits from others. (Because this
patch is built upon the latest, sorry for the inconvenience)

Thanks for every reviewer.

shejialuo (9):
  fsck: rename "skiplist" to "oid_skiplist"
  fsck: add a unified interface for reporting fsck messages
  fsck: add refs-related options and error report function
  refs: set up ref consistency check infrastructure
  builtin/refs: add verify subcommand
  builtin/fsck: add `git-refs verify` child process
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend
  fsck: add ref content check for files backend

 Documentation/fsck-msgids.txt |  12 ++
 Documentation/git-refs.txt    |  13 ++
 builtin/fsck.c                |  32 ++++-
 builtin/mktag.c               |   1 +
 builtin/refs.c                |  44 ++++++
 fsck.c                        | 107 +++++++++++---
 fsck.h                        |  63 ++++++---
 object-file.c                 |  11 +-
 refs.c                        |   7 +-
 refs.h                        |   8 ++
 refs/debug.c                  |  11 ++
 refs/files-backend.c          | 255 +++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 ++
 refs/refs-internal.h          |  11 +-
 refs/reftable-backend.c       |   8 ++
 t/t0602-reffiles-fsck.sh      | 211 ++++++++++++++++++++++++++++
 16 files changed, 745 insertions(+), 57 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v6:
 1:  d32ae41a4d <  -:  ---------- fsck: add "fsck_objects_options" to hold objects-related options
 2:  589a7a6fac <  -:  ---------- fsck: rename "skiplist" to "oid_skiplist"
 3:  bab97d7c82 <  -:  ---------- fsck: add "fsck_refs_options" into "fsck_options"
 -:  ---------- >  1:  f5fcf36132 fsck: rename "skiplist" to "oid_skiplist"
 4:  276da52a6b !  2:  c81b5b6fba fsck: add a unified interface for reporting fsck messages
    @@ builtin/fsck.c: static int objerror(struct object *obj, const char *err)
      	case FSCK_WARN:
     @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char *prefix)
      
    - 	fsck_walk_options.objects_options.walk = mark_object;
    - 	fsck_obj_options.objects_options.walk = mark_used;
    + 	fsck_walk_options.walk = mark_object;
    + 	fsck_obj_options.walk = mark_used;
     -	fsck_obj_options.error_func = fsck_error_func;
     +	fsck_obj_options.error_func = fsck_objects_error_func;
      	if (check_strict)
    @@ builtin/fsck.c: int cmd_fsck(int argc, const char **argv, const char *prefix)
      
     
      ## builtin/mktag.c ##
    -@@ builtin/mktag.c: static struct fsck_options fsck_options = FSCK_OBJECTS_OPTIONS_STRICT;
    +@@ builtin/mktag.c: static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
      static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
      				 const struct object_id *oid UNUSED,
      				 enum object_type object_type UNUSED,
    @@ fsck.c: static int report(struct fsck_options *options,
     +
      void fsck_enable_object_names(struct fsck_options *options)
      {
    - 	if (!options->objects_options.object_names)
    + 	if (!options->object_names)
     @@ fsck.c: int fsck_buffer(const struct object_id *oid, enum object_type type,
      		      type);
      }
    @@ fsck.h: int is_valid_msg_type(const char *msg_id, const char *msg_type);
     +						   enum fsck_msg_id msg_id,
     +						   const char *message);
      
    - struct fsck_refs_options {
    - 	unsigned verbose:1;
    + struct fsck_options {
    + 	fsck_walk_func walk;
     @@ fsck.h: struct fsck_options {
    + };
      
    - #define FSCK_OBJECTS_OPTIONS_DEFAULT { \
    - 	.oid_skiplist = OIDSET_INIT, \
    --	.error_func = fsck_error_function, \
    -+	.error_func = fsck_objects_error_function, \
    - 	.objects_options = { \
    - 		.gitmodules_found = OIDSET_INIT, \
    - 		.gitmodules_done = OIDSET_INIT, \
    -@@ fsck.h: struct fsck_options {
    + #define FSCK_OPTIONS_DEFAULT { \
    +-	.skiplist = OIDSET_INIT, \
    ++	.oid_skiplist = OIDSET_INIT, \
    + 	.gitmodules_found = OIDSET_INIT, \
    + 	.gitmodules_done = OIDSET_INIT, \
    + 	.gitattributes_found = OIDSET_INIT, \
    + 	.gitattributes_done = OIDSET_INIT, \
    +-	.error_func = fsck_error_function \
    ++	.error_func = fsck_objects_error_function \
      }
    - #define FSCK_OBJECTS_OPTIONS_STRICT { \
    + #define FSCK_OPTIONS_STRICT { \
      	.strict = 1, \
    +@@ fsck.h: struct fsck_options {
    + 	.gitmodules_done = OIDSET_INIT, \
    + 	.gitattributes_found = OIDSET_INIT, \
    + 	.gitattributes_done = OIDSET_INIT, \
     -	.error_func = fsck_error_function, \
     +	.error_func = fsck_objects_error_function, \
    - 	.objects_options = { \
    - 		.gitmodules_found = OIDSET_INIT, \
    - 		.gitmodules_done = OIDSET_INIT, \
    -@@ fsck.h: struct fsck_options {
      }
    - #define FSCK_OBJECTS_OPTIONS_MISSING_GITMODULES { \
    + #define FSCK_OPTIONS_MISSING_GITMODULES { \
      	.strict = 1, \
    +@@ fsck.h: struct fsck_options {
    + 	.gitmodules_done = OIDSET_INIT, \
    + 	.gitattributes_found = OIDSET_INIT, \
    + 	.gitattributes_done = OIDSET_INIT, \
     -	.error_func = fsck_error_cb_print_missing_gitmodules, \
     +	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
    - 	.objects_options = { \
    - 		.gitmodules_found = OIDSET_INIT, \
    - 		.gitmodules_done = OIDSET_INIT, \
    + }
    + 
    + /* descend in all linked child objects
     @@ fsck.h: int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
       */
      int fsck_finish(struct fsck_options *options);
 5:  e93940c50c !  3:  53156dc847 fsck: add "fsck_refs_options" initialization macros
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    fsck: add "fsck_refs_options" initialization macros
    +    fsck: add refs-related options and error report function
     
    -    Add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT" macros to
    -    create the refs options easily. Add refs-specific "error_func" callback
    -    "fsck_refs_error_function".
    +    Add refs-related options to the "fsck_options", create refs-specific
    +    "error_func" callback "fsck_refs_error_function".
     
         "fsck_refs_error_function" will use the "oid" parameter. When the caller
    -    passed the oid, it will use "oid_to_hex" to get the corresponding hex
    -    value to report to the user.
    +    passes the oid, it will use "oid_to_hex" to get the corresponding hex
    +    value to report to the caller.
    +
    +    Last, add "FSCK_REFS_OPTIONS_DEFAULT" and "FSCK_REFS_OPTIONS_STRICT"
    +    macros to create refs options easily.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ fsck.h: int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *
     +			     enum fsck_msg_id msg_id,
     +			     const char *message);
      
    - struct fsck_refs_options {
    - 	unsigned verbose:1;
    + struct fsck_options {
    + 	fsck_walk_func walk;
    + 	fsck_error error_func;
    + 	unsigned strict:1;
    ++	unsigned verbose_refs:1;
    + 	enum fsck_msg_type *msg_type;
    + 	struct oidset oid_skiplist;
    + 	struct oidset gitmodules_found;
     @@ fsck.h: struct fsck_options {
    - 		.gitattributes_done = OIDSET_INIT, \
    - 	} \
    + 	.gitattributes_done = OIDSET_INIT, \
    + 	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
      }
     +#define FSCK_REFS_OPTIONS_DEFAULT { \
     +	.error_func = fsck_refs_error_function, \
 6:  85aa953f6d !  4:  358f4a1be9 refs: set up ref consistency check infrastructure
    @@ refs.c: int check_refname_format(const char *refname, int flags)
     
      ## refs.h ##
     @@
    - 
      #include "commit.h"
    + #include "repository.h"
      
     +struct fsck_options;
      struct object_id;
      struct ref_store;
    - struct repository;
    + struct strbuf;
     @@ refs.h: int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_dat
       */
      int check_refname_format(const char *refname, int flags);
 7:  ce7adc7372 !  5:  e632859df6 builtin/refs: add verify subcommand
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
     +		usage(_("too many arguments"));
     +
     +	if (verbose)
    -+		fsck_refs_options.refs_options.verbose = 1;
    ++		fsck_refs_options.verbose_refs = 1;
     +	if (strict)
     +		fsck_refs_options.strict = 1;
     +
 8:  035eafe10b =  6:  5d7a6261ae builtin/fsck: add `git-refs verify` child process
 9:  9398bf3f0d !  7:  33311af1b1 files-backend: add unified interface for refs scanning
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +			continue;
     +		} else if (S_ISREG(iter->st.st_mode) ||
     +			   S_ISLNK(iter->st.st_mode)) {
    -+			if (o->refs_options.verbose)
    ++			if (o->verbose_refs)
     +				fprintf_ln(stderr, "Checking %s/%s",
     +					   refs_check_dir, iter->relative_path);
     +			for (size_t i = 0; fsck_refs_fns[i]; i++) {
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +		NULL
     +	};
     +
    -+	if (o->refs_options.verbose)
    ++	if (o->verbose_refs)
     +		fprintf_ln(stderr, "Checking references consistency");
     +
     +	ret = files_fsck_refs_dir(ref_store, o, "refs", fsck_refs_fns);
10:  046773e35c =  8:  02bd3ac952 fsck: add ref name check for files backend
11:  c9b9599589 !  9:  94d123471d fsck: add ref content check for files backend
    @@ refs.c: static int refs_read_special_head(struct ref_store *ref_store,
     
      ## refs/files-backend.c ##
     @@
    + #define USE_THE_REPOSITORY_VARIABLE
    + 
      #include "../git-compat-util.h"
     +#include "../abspath.h"
      #include "../copy.h"
-- 
2.45.2

