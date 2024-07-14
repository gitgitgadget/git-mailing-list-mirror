Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998DA7344E
	for <git@vger.kernel.org>; Sun, 14 Jul 2024 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720960117; cv=none; b=bCduvA7iWVrgf7GJa8Olf+vjfMdJccmhFeLv2ZRXQGVhLdAVBB8TJeL8lzZ1S5R1shGQ4xoGlKX2dzDsBtH0MxxmTcDVWf4HeKSeyahHhTSqU7dHVORvt6kfX3gKGc6B2BG3krflhBAjOs/iK1YjZyvGVHu8xM9hvUoA5FEflGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720960117; c=relaxed/simple;
	bh=DBbHMZGSVkCA3LaZPjaQhjCbwAuCwhFlLRjfs6XQBIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueFrq6s8YFwEIFERC08vqIwRZOC3stKULpPrRIevXyn4Was116Nf4Y6Nx5IR2f9SjljT3s+nqq0B2S+9eQcGyFb7sp7wO4gDZg4+P1X61tizyYzgp2lj/5a2sz1qopxT+67jpiaYC64kHLOmqyWiwppKmzI2wDFr8gfuF3Jgbxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg7RgldH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg7RgldH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso21438725ad.2
        for <git@vger.kernel.org>; Sun, 14 Jul 2024 05:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720960114; x=1721564914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yngfWf3RK9clR6vE7fT3H7/lpDyGkEV2qGOuT6s6MVQ=;
        b=eg7RgldHdLoZNZcXzJvSGERL2gphHb+NuMpTq9N4U+JPcWaqCC72cYyAEmPevFeNuM
         WP/E8Hv5LF+Kbrrgs/Jwu6r0/vNeckIJ5NGBDWtxEk7UVJTo/+IijNSf3VxJFtJ+3OCi
         F5xq3kGLnesD+emK+wrZhO/c5rLzHvMji1Kxkho8VWIfBXgBdu2v+foRBaM58r4ejMZi
         9HMUj0hZNrE9ksxhpQVK8JQCVmWzA1+Tlfb7LurPQTrl2clVYqPOkxsF6xsqSf8gBOFr
         QvyYEcEA7QmajavsmLcJTj827SyQC6BQffMTmnL0FOqhONRvMtjcsYT/kMV6zGDqdh5v
         domA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720960114; x=1721564914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yngfWf3RK9clR6vE7fT3H7/lpDyGkEV2qGOuT6s6MVQ=;
        b=Yy8+Wjir7RELdgiYi5anXahtt4RblZpRaZJsCFVNxL5F+fZA3pYFCSPHgxUnwWubg9
         kkH3qR/XYUOxTJ3nA1vcqhJYSv4GGjzOfQy7Whbg8L5O4BZt82K7hrIp+JLyrG3Ao5xW
         9hTGX56+vt8wW5O+k8i1ueRV+4KF8s0/3uLrDDA1ZIi1kNFs9/oo5HybKvIylMSv8TU5
         dWnXT0PI0XsPbyWxh9vqnreakLSfOESqxE/MUhk43f9v61h14EPxQF1HNQvZTb3pLgBl
         CXbcarlVUsjFjvIsostkCQf8ctP0S8qYnUzx9vg4YOG7CMXVjhtdmP1f+TGTFZdsxpQ4
         H+Zw==
X-Gm-Message-State: AOJu0YwrtXaYu1Tz74B7Sic60KsHM9xigzzCqX76B/kzgD4ejs9hXqaF
	MCSjLhUCx0UVTmLdkPxo6kjuy/IrA9pDZghfVj2wPDjx/SUEV3Dg/9kiWA==
X-Google-Smtp-Source: AGHT+IGkYEg/hlHafzTz2NHFQrvccJFSRj0H0xC8zuxKVSV6WXazXNZ/K1D8aUVCS3bxDdRGSVCVDg==
X-Received: by 2002:a17:902:c950:b0:1fb:4093:4712 with SMTP id d9443c01a7336-1fbb6cdac44mr150127615ad.10.1720960114199;
        Sun, 14 Jul 2024 05:28:34 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc3a251sm22919175ad.198.2024.07.14.05.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 05:28:33 -0700 (PDT)
Date: Sun, 14 Jul 2024 20:28:38 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [GSoC][PATCH v11 00/10] ref consistency check infra setup
Message-ID: <ZpPEdmUN1Z5tqbK3@ArchLinux>
References: <Zo6eJi8BePrQxTQV@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo6eJi8BePrQxTQV@ArchLinux>

Hi All:

This version handles the following problems:

1. Reorder the commit message to let "fsck: rename objects-related fsck
error functions" behind the "fsck: add a unified interface for reporting
fsck messages".
2. Rename "vfsck_report" to "fsck_vreport" to be align with the
codebase.
3. Make the "git-refs verify" commit message clean, and add
user-friendly error message here.
4. Rename "verbose_refs" to "verbose" field in "fsck_options".

And the most important change in this version is to enhance the
"fsck_refs_report" function. After some investigations, there are the
following situations where we should handle when checking ref
consistency.

1. When checking loose refs and reflofs, we only need the checkee
information, because they are standalone files.
2. When checking packed-refs, we should check the packed-refs itself,
for example whether it is sorted or there are some garbage trailing
contents. However, we should also check each ref (sub_checkee) in the
file.
3. When checking reftable refs, we need to check the binary file,
however, I does not truly understand the principle of reftable refs. But
we could still use the idea like 2 case.

By the above statements, I change the "fsck_refs_report" shown as below:

int fsck_refs_error_function(struct fsck_options *options UNUSED,
			     const struct object_id *oid,
			     enum object_type object_type UNUSED,
			     const char *ref_checkee,
			     const char *sub_ref_checkee,
			     enum fsck_msg_type msg_type,
			     enum fsck_msg_id msg_id UNUSED,
			     const char *message)
{
	struct strbuf sb = STRBUF_INIT;
	int ret = 0;

	if (sub_ref_checkee)
		strbuf_addf(&sb, "%s.%s", ref_checkee, sub_ref_checkee);
	else
		strbuf_addstr(&sb, ref_checkee);

	if (oid)
		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));

	if (msg_type == FSCK_WARN)
		warning("%s: %s", sb.buf, message);
	else
		ret = error("%s: %s", sb.buf, message);

	strbuf_release(&sb);
	return ret;
}

It could provide the following report messages:

1. "ref_checkee": "fsck error name": "user message".
2. "ref_checkee.sub_ref_checkee": "fsck error name": "user message".
3. "ref_checkee -> (oid hex)": "fsck error name": "user message".
4. "ref_checkee.sub_ref_checkee -> (oid hex)": "fsck error name": "user
message".

shejialuo (10):
  fsck: rename "skiplist" to "skip_oids"
  fsck: add a unified interface for reporting fsck messages
  fsck: rename objects-related fsck error functions
  fsck: add refs-related error report function
  refs: set up ref consistency check infrastructure
  git refs: add verify subcommand
  builtin/fsck: add `git-refs verify` child process
  files-backend: add unified interface for refs scanning
  fsck: add ref name check for files backend
  fsck: add ref content check for files backend

 Documentation/fsck-msgids.txt |  12 ++
 Documentation/git-refs.txt    |  13 ++
 builtin/fsck.c                |  33 ++++-
 builtin/mktag.c               |   2 +
 builtin/refs.c                |  44 ++++++
 fsck.c                        | 118 +++++++++++++---
 fsck.h                        |  69 ++++++---
 object-file.c                 |  12 +-
 refs.c                        |   7 +-
 refs.h                        |   8 ++
 refs/debug.c                  |  11 ++
 refs/files-backend.c          | 255 +++++++++++++++++++++++++++++++++-
 refs/packed-backend.c         |   8 ++
 refs/refs-internal.h          |  11 +-
 refs/reftable-backend.c       |   8 ++
 t/t0602-reffiles-fsck.sh      | 211 ++++++++++++++++++++++++++++
 16 files changed, 766 insertions(+), 56 deletions(-)
 create mode 100755 t/t0602-reffiles-fsck.sh

Range-diff against v10:
 1:  e044f933de =  1:  a69705b777 fsck: rename "skiplist" to "skip_oids"
 3:  df4837e960 !  2:  1ef1036348 fsck: add a unified interface for reporting fsck messages
    @@ Commit message
         error type and calling the callback "error_func" to report the message.
         However, "report" function is only related to object database which
         cannot be reused for refs. In order to provide a unified interface which
    -    can report either objects or refs, create a new function "vfsck_report"
    -    by adding "checked_ref_name" parameter following the "report" prototype.
    -    Instead of using "...", provide "va_list" to allow more flexibility.
    +    can report either objects or refs, create a new function "fsck_vreport"
    +    following the "report" prototype. Instead of using "...", provide
    +    "va_list" to allow more flexibility.
     
    -    Like "report", the "vfsck_report" function will use "error_func"
    +    When checking loose refs and reflogs, we only need to pass the checked
    +    name to the fsck error report function. However, for packed-refs and
    +    reftable refs, we need to check both the consistency of the file itself
    +    and the refs or reflogs contained in the file. In order to provide above
    +    checks, add two parameters "ref_checkee" and "sub_ref_checkee" in
    +    "fsck_vreport" function.
    +
    +    Like "report", the "fsck_vreport" function will use "error_func"
         registered in "fsck_options" to report customized messages. Change
    -    "error_func" prototype to align with the new "vfsck_report".
    +    "error_func" prototype to align with the new "fsck_vreport".
     
    -    Then, change "report" function to use "vfsck_report" to report objects
    +    Then, change "report" function to use "fsck_vreport" to report objects
         related messages. Add a new function called "fsck_refs_report" to use
    -    "vfsck_report" to report refs related messages.
    +    "fsck_vreport" to report refs related messages.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ Commit message
     
      ## builtin/fsck.c ##
     @@ builtin/fsck.c: static int objerror(struct object *obj, const char *err)
    - static int fsck_objects_error_func(struct fsck_options *o UNUSED,
    - 				   const struct object_id *oid,
    - 				   enum object_type object_type,
    -+				   const char *checked_ref_name UNUSED,
    - 				   enum fsck_msg_type msg_type,
    - 				   enum fsck_msg_id msg_id UNUSED,
    - 				   const char *message)
    + static int fsck_error_func(struct fsck_options *o UNUSED,
    + 			   const struct object_id *oid,
    + 			   enum object_type object_type,
    ++			   const char *ref_checkee UNUSED,
    ++			   const char *sub_ref_checkee UNUSED,
    + 			   enum fsck_msg_type msg_type,
    + 			   enum fsck_msg_id msg_id UNUSED,
    + 			   const char *message)
     
      ## builtin/mktag.c ##
     @@ builtin/mktag.c: static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
      static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
      				 const struct object_id *oid UNUSED,
      				 enum object_type object_type UNUSED,
    -+				 const char *checked_ref_name UNUSED,
    ++				 const char *ref_checkee UNUSED,
    ++				 const char *sub_ref_checkee UNUSED,
      				 enum fsck_msg_type msg_type,
      				 enum fsck_msg_id msg_id UNUSED,
      				 const char *message)
    @@ fsck.c: static int object_on_skiplist(struct fsck_options *opts,
     + * It will get the current msg error type and call the error_func callback
     + * which is registered in the "fsck_options" struct.
     + */
    -+static int vfsck_report(struct fsck_options *options,
    ++static int fsck_vreport(struct fsck_options *options,
     +			const struct object_id *oid,
     +			enum object_type object_type,
    -+			const char *checked_ref_name,
    ++			const char *ref_checkee,
    ++			const char *sub_ref_checkee,
     +			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
      {
     -	va_list ap;
    @@ fsck.c: static int report(struct fsck_options *options,
      
     -	va_start(ap, fmt);
     -	strbuf_vaddf(&sb, fmt, ap);
    --	result = options->error_func(options, oid, object_type,
     +	va_copy(ap_copy, ap);
     +	strbuf_vaddf(&sb, fmt, ap_copy);
    -+	result = options->error_func(options, oid, object_type, checked_ref_name,
    + 	result = options->error_func(options, oid, object_type,
    ++				     ref_checkee, sub_ref_checkee,
      				     msg_type, msg_id, sb.buf);
      	strbuf_release(&sb);
      	va_end(ap);
    @@ fsck.c: static int report(struct fsck_options *options,
     +{
     +	va_list ap;
     +	int result;
    ++
     +	va_start(ap, fmt);
    -+	result = vfsck_report(options, oid, object_type, NULL,
    ++	result = fsck_vreport(options, oid, object_type, NULL, NULL,
     +			      msg_id, fmt, ap);
     +	va_end(ap);
    ++
     +	return result;
     +}
     +
    -+
    -+
     +int fsck_refs_report(struct fsck_options *options,
     +		     const struct object_id *oid,
    -+		     const char *checked_ref_name,
    ++		     const char *ref_checkee,
    ++		     const char *sub_ref_checkee,
     +		     enum fsck_msg_id msg_id, const char *fmt, ...)
     +{
     +	va_list ap;
     +	int result;
     +	va_start(ap, fmt);
    -+	result = vfsck_report(options, oid, OBJ_NONE,
    -+			      checked_ref_name, msg_id, fmt, ap);
    ++	result = fsck_vreport(options, oid, OBJ_NONE, ref_checkee, sub_ref_checkee,
    ++			      msg_id, fmt, ap);
     +	va_end(ap);
     +	return result;
     +}
    @@ fsck.c: static int report(struct fsck_options *options,
      {
      	if (!options->object_names)
     @@ fsck.c: int fsck_buffer(const struct object_id *oid, enum object_type type,
    - int fsck_objects_error_function(struct fsck_options *o,
    - 				const struct object_id *oid,
    - 				enum object_type object_type UNUSED,
    -+				const char *checked_ref_name UNUSED,
    - 				enum fsck_msg_type msg_type,
    - 				enum fsck_msg_id msg_id UNUSED,
    - 				const char *message)
    + int fsck_error_function(struct fsck_options *o,
    + 			const struct object_id *oid,
    + 			enum object_type object_type UNUSED,
    ++			const char *ref_checkee UNUSED,
    ++			const char *sub_ref_checkee UNUSED,
    + 			enum fsck_msg_type msg_type,
    + 			enum fsck_msg_id msg_id UNUSED,
    + 			const char *message)
     @@ fsck.c: int git_fsck_config(const char *var, const char *value,
    - int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
    - 						   const struct object_id *oid,
    - 						   enum object_type object_type,
    -+						   const char *checked_ref_name,
    - 						   enum fsck_msg_type msg_type,
    - 						   enum fsck_msg_id msg_id,
    - 						   const char *message)
    -@@ fsck.c: int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
    + int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
    + 					   const struct object_id *oid,
    + 					   enum object_type object_type,
    ++					   const char *ref_checkee,
    ++					   const char *sub_ref_checkee,
    + 					   enum fsck_msg_type msg_type,
    + 					   enum fsck_msg_id msg_id,
    + 					   const char *message)
    +@@ fsck.c: int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
      		puts(oid_to_hex(oid));
      		return 0;
      	}
    --	return fsck_objects_error_function(o, oid, object_type,
    -+	return fsck_objects_error_function(o, oid, object_type, checked_ref_name,
    - 					   msg_type, msg_id, message);
    +-	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
    ++	return fsck_error_function(o, oid, object_type, ref_checkee,
    ++				   sub_ref_checkee, msg_type, msg_id, message);
      }
     
      ## fsck.h ##
    @@ fsck.h: int is_valid_msg_type(const char *msg_id, const char *msg_type);
     + */
      typedef int (*fsck_error)(struct fsck_options *o,
      			  const struct object_id *oid, enum object_type object_type,
    -+			  const char *checked_ref_name,
    ++			  const char *ref_checkee, const char *sub_ref_checkee,
      			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
      			  const char *message);
      
    - int fsck_objects_error_function(struct fsck_options *o,
    - 				const struct object_id *oid, enum object_type object_type,
    -+				const char *checked_ref_name,
    - 				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
    - 				const char *message);
    - int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
    - 						   const struct object_id *oid,
    - 						   enum object_type object_type,
    -+						   const char *checked_ref_name,
    - 						   enum fsck_msg_type msg_type,
    - 						   enum fsck_msg_id msg_id,
    - 						   const char *message);
    + int fsck_error_function(struct fsck_options *o,
    + 			const struct object_id *oid, enum object_type object_type,
    ++			const char *ref_checkee, const char *sub_ref_checkee,
    + 			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
    + 			const char *message);
    + int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
    + 					   const struct object_id *oid,
    + 					   enum object_type object_type,
    ++					   const char *ref_checkee,
    ++					   const char *sub_ref_checkee,
    + 					   enum fsck_msg_type msg_type,
    + 					   enum fsck_msg_id msg_id,
    + 					   const char *message);
     @@ fsck.h: int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
       */
      int fsck_finish(struct fsck_options *options);
    @@ fsck.h: int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
     +/*
     + * Report an error or warning for refs.
     + */
    -+__attribute__((format (printf, 5, 6)))
    ++__attribute__((format (printf, 6, 7)))
     +int fsck_refs_report(struct fsck_options *options,
     +		     const struct object_id *oid,
    -+		     const char *checked_ref_name,
    ++		     const char *ref_checkee,
    ++		     const char *sub_ref_checkee,
     +		     enum fsck_msg_id msg_id,
     +		     const char *fmt, ...);
     +
    @@ object-file.c: int repo_has_object_file(struct repository *r,
     -				     const char *message)
     +				    const struct object_id *oid UNUSED,
     +				    enum object_type object_type UNUSED,
    -+				    const char *ref_checked_name UNUSED,
    ++				    const char *ref_checkee UNUSED,
    ++				    const char *sub_ref_checkee UNUSED,
     +				    enum fsck_msg_type msg_type UNUSED,
     +				    enum fsck_msg_id msg_id UNUSED,
     +				    const char *message)
 2:  73a7c53a23 !  3:  d17cf6166e fsck: rename objects-related fsck error functions
    @@ Commit message
         fsck: rename objects-related fsck error functions
     
         The names of objects-related fsck error functions are general. It's OK
    -    when there is only object database check. However, we are going to
    -    introduce refs database check. In order to avoid ambiguity, rename
    -    objects-related fsck error functions to explicitly indicate these
    +    when there is only object database check. However, we have introduced
    +    refs database check report function. To avoid ambiguity, rename
    +    object-related fsck error functions to explicitly indicate these
         functions are used to report objects-related messages.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
    @@ builtin/fsck.c: static int objerror(struct object *obj, const char *err)
     -static int fsck_error_func(struct fsck_options *o UNUSED,
     -			   const struct object_id *oid,
     -			   enum object_type object_type,
    +-			   const char *ref_checkee UNUSED,
    +-			   const char *sub_ref_checkee UNUSED,
     -			   enum fsck_msg_type msg_type,
     -			   enum fsck_msg_id msg_id UNUSED,
     -			   const char *message)
     +static int fsck_objects_error_func(struct fsck_options *o UNUSED,
     +				   const struct object_id *oid,
     +				   enum object_type object_type,
    ++				   const char *ref_checkee UNUSED,
    ++				   const char *sub_ref_checkee UNUSED,
     +				   enum fsck_msg_type msg_type,
     +				   enum fsck_msg_id msg_id UNUSED,
     +				   const char *message)
    @@ fsck.c: int fsck_buffer(const struct object_id *oid, enum object_type type,
     -int fsck_error_function(struct fsck_options *o,
     -			const struct object_id *oid,
     -			enum object_type object_type UNUSED,
    +-			const char *ref_checkee UNUSED,
    +-			const char *sub_ref_checkee UNUSED,
     -			enum fsck_msg_type msg_type,
     -			enum fsck_msg_id msg_id UNUSED,
     -			const char *message)
     +int fsck_objects_error_function(struct fsck_options *o,
     +				const struct object_id *oid,
     +				enum object_type object_type UNUSED,
    ++				const char *ref_checkee UNUSED,
    ++				const char *sub_ref_checkee UNUSED,
     +				enum fsck_msg_type msg_type,
     +				enum fsck_msg_id msg_id UNUSED,
     +				const char *message)
    @@ fsck.c: int git_fsck_config(const char *var, const char *value,
     -int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
     -					   const struct object_id *oid,
     -					   enum object_type object_type,
    +-					   const char *ref_checkee,
    +-					   const char *sub_ref_checkee,
     -					   enum fsck_msg_type msg_type,
     -					   enum fsck_msg_id msg_id,
     -					   const char *message)
     +int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
     +						   const struct object_id *oid,
     +						   enum object_type object_type,
    ++						   const char *ref_checkee,
    ++						   const char *sub_ref_checkee,
     +						   enum fsck_msg_type msg_type,
     +						   enum fsck_msg_id msg_id,
     +						   const char *message)
    @@ fsck.c: int git_fsck_config(const char *var, const char *value,
      		puts(oid_to_hex(oid));
      		return 0;
      	}
    --	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
    -+	return fsck_objects_error_function(o, oid, object_type,
    -+					   msg_type, msg_id, message);
    +-	return fsck_error_function(o, oid, object_type, ref_checkee,
    +-				   sub_ref_checkee, msg_type, msg_id, message);
    ++	return fsck_objects_error_function(o, oid, object_type, ref_checkee,
    ++					   sub_ref_checkee, msg_type, msg_id,
    ++					   message);
      }
     
      ## fsck.h ##
    @@ fsck.h: typedef int (*fsck_error)(struct fsck_options *o,
      
     -int fsck_error_function(struct fsck_options *o,
     -			const struct object_id *oid, enum object_type object_type,
    +-			const char *ref_checkee, const char *sub_ref_checkee,
     -			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
     -			const char *message);
     -int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
     -					   const struct object_id *oid,
     -					   enum object_type object_type,
    +-					   const char *ref_checkee,
    +-					   const char *sub_ref_checkee,
     -					   enum fsck_msg_type msg_type,
     -					   enum fsck_msg_id msg_id,
     -					   const char *message);
     +int fsck_objects_error_function(struct fsck_options *o,
     +				const struct object_id *oid, enum object_type object_type,
    ++				const char *ref_checkee, const char *sub_ref_checkee,
     +				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
     +				const char *message);
     +int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
     +						   const struct object_id *oid,
     +						   enum object_type object_type,
    ++						   const char *ref_checkee,
    ++						   const char *sub_ref_checkee,
     +						   enum fsck_msg_type msg_type,
     +						   enum fsck_msg_id msg_id,
     +						   const char *message);
 4:  c8eb01c987 !  4:  ee17c0835b fsck: add refs-related error report function
    @@ Metadata
      ## Commit message ##
         fsck: add refs-related error report function
     
    -    Add refs-related options to the "fsck_options", create refs-specific
    -    "error_func" callback "fsck_refs_error_function".
    +    Create refs-specific "error_func" callback "fsck_refs_error_function"
    +    which could provide the following report messages.
     
    -    "fsck_refs_error_function" will use the "oid" parameter. When the caller
    +    1. "ref_checkee": "fsck error name": "user message".
    +    2. "ref_checkee.sub_ref_checkee": "fsck error name": "user message".
    +    3. "ref_checkee -> (oid hex)": "fsck error name": "user message".
    +    4. "ref_checkee.sub_ref_checkee -> (pid hex)": "fsck error name": "user
    +       message".
    +
    +    "fsck_refs_error_function" uses the "ref_checkee" and "sub_ref_checkee"
    +    parameters to indicate the information of the checked refs. For loose
    +    ref and reflog, it only uses the "ref_checkee" parameter. For packed
    +    refs and reftable refs, when checking the consistency of the file
    +    itself, it still only uses "ref_checkee" parameter. However, when
    +    checking the consistency of the ref or reflog contained in the file, it
    +    will use "sub_ref_checkee" parameter to indicate that we are not
    +    checking the file but the incorporated ref or reflog.
    +
    +    "fsck_refs_error_function" will use the "oid" parameter if the caller
         passes the oid, it will use "oid_to_hex" to get the corresponding hex
         value to report to the caller.
     
    @@ fsck.c: int fsck_objects_error_function(struct fsck_options *o,
     +int fsck_refs_error_function(struct fsck_options *options UNUSED,
     +			     const struct object_id *oid,
     +			     enum object_type object_type UNUSED,
    -+			     const char *checked_ref_name,
    ++			     const char *ref_checkee,
    ++			     const char *sub_ref_checkee,
     +			     enum fsck_msg_type msg_type,
     +			     enum fsck_msg_id msg_id UNUSED,
     +			     const char *message)
    @@ fsck.c: int fsck_objects_error_function(struct fsck_options *o,
     +	struct strbuf sb = STRBUF_INIT;
     +	int ret = 0;
     +
    -+	strbuf_addstr(&sb, checked_ref_name);
    ++	if (sub_ref_checkee)
    ++		strbuf_addf(&sb, "%s.%s", ref_checkee, sub_ref_checkee);
    ++	else
    ++		strbuf_addstr(&sb, ref_checkee);
    ++
     +	if (oid)
     +		strbuf_addf(&sb, " -> (%s)", oid_to_hex(oid));
     +
    @@ fsck.h: int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *
     +int fsck_refs_error_function(struct fsck_options *options,
     +			     const struct object_id *oid,
     +			     enum object_type object_type,
    -+			     const char *checked_ref_name,
    ++			     const char *ref_checkee,
    ++			     const char *sub_ref_checkee,
     +			     enum fsck_msg_type msg_type,
     +			     enum fsck_msg_id msg_id,
     +			     const char *message);
 5:  e4085df496 =  5:  4718ba7ddc refs: set up ref consistency check infrastructure
 6:  497f224bed !  6:  76163fb5d9 builtin/refs: add verify subcommand and verbose_refs for "fsck_options"
    @@ Metadata
     Author: shejialuo <shejialuo@gmail.com>
     
      ## Commit message ##
    -    builtin/refs: add verify subcommand and verbose_refs for "fsck_options"
    +    git refs: add verify subcommand
     
         Introduce a new subcommand "verify" in git-refs(1) to allow the user to
         check the reference database consistency and also this subcommand will
         be used as the entry point of checking refs for "git-fsck(1)". Last, add
    -    "verbose_refs" field into "fsck_options" to indicate whether we should
    -    print verbose messages when checking refs consistency.
    +    "verbose" field into "fsck_options" to indicate whether we should print
    +    verbose messages when checking refs and objects consistency.
     
         Mentored-by: Patrick Steinhardt <ps@pks.im>
         Mentored-by: Karthik Nayak <karthik.188@gmail.com>
    @@ builtin/refs.c: static int cmd_refs_migrate(int argc, const char **argv, const c
     +
     +	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
     +	if (argc)
    -+		usage(_("too many arguments"));
    ++		usage(_("'git refs verify' takes no arguments"));
     +
     +	if (verbose)
    -+		fsck_refs_options.verbose_refs = 1;
    ++		fsck_refs_options.verbose = 1;
     +	if (strict)
     +		fsck_refs_options.strict = 1;
     +
    @@ fsck.h: struct fsck_options {
      	fsck_walk_func walk;
      	fsck_error error_func;
      	unsigned strict:1;
    -+	unsigned verbose_refs:1;
    ++	unsigned verbose:1;
      	enum fsck_msg_type *msg_type;
      	struct oidset skip_oids;
      	struct oidset gitmodules_found;
 7:  86a14c7b43 =  7:  27f766fb8e builtin/fsck: add `git-refs verify` child process
 8:  daedb80b47 !  8:  e2ab45ec9f files-backend: add unified interface for refs scanning
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +			continue;
     +		} else if (S_ISREG(iter->st.st_mode) ||
     +			   S_ISLNK(iter->st.st_mode)) {
    -+			if (o->verbose_refs)
    ++			if (o->verbose)
     +				fprintf_ln(stderr, "Checking %s/%s",
     +					   refs_check_dir, iter->relative_path);
     +			for (size_t i = 0; fsck_refs_fns[i]; i++) {
    @@ refs/files-backend.c: static int files_ref_store_remove_on_disk(struct ref_store
     +		NULL
     +	};
     +
    -+	if (o->verbose_refs)
    ++	if (o->verbose)
     +		fprintf_ln(stderr, "Checking references consistency");
     +
     +	ret = files_fsck_refs_dir(ref_store, o, "refs", fsck_refs_fns);
 9:  c36d588e4f !  9:  cd438fb56d fsck: add ref name check for files backend
    @@ refs/files-backend.c: typedef int (*files_fsck_refs_fn)(struct fsck_options *o,
     +
     +	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
     +		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
    -+		ret = fsck_refs_report(o, NULL, sb.buf,
    ++		ret = fsck_refs_report(o, NULL, sb.buf, NULL,
     +				       FSCK_MSG_BAD_REF_NAME,
     +				       "invalid refname format");
     +	}
10:  521e0d9ca3 ! 10:  15662c6934 fsck: add ref content check for files backend
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +
     +	if (!skip_prefix(pointee_name, "refs/", &p)) {
     +
    -+		ret = fsck_refs_report(o, NULL, refname,
    ++		ret = fsck_refs_report(o, NULL, refname, NULL,
     +				       FSCK_MSG_BAD_SYMREF_POINTEE,
     +				       "point to target out of refs hierarchy");
     +		goto out;
     +	}
     +
     +	if (check_refname_format(pointee_name, 0)) {
    -+		ret = fsck_refs_report(o, NULL, refname,
    ++		ret = fsck_refs_report(o, NULL, refname, NULL,
     +				       FSCK_MSG_BAD_SYMREF_POINTEE,
     +				       "point to invalid refname");
     +	}
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +		goto out;
     +
     +	if (!S_ISREG(st.st_mode) && !S_ISLNK(st.st_mode)) {
    -+		ret = fsck_refs_report(o, NULL, refname,
    ++		ret = fsck_refs_report(o, NULL, refname, NULL,
     +				       FSCK_MSG_BAD_SYMREF_POINTEE,
     +				       "point to invalid target");
     +		goto out;
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +
     +		if (!skip_prefix(pointee_path.buf,
     +				 abs_gitdir.buf, &pointee_name)) {
    -+			ret = fsck_refs_report(o, NULL, refname.buf,
    ++			ret = fsck_refs_report(o, NULL, refname.buf, NULL,
     +					       FSCK_MSG_BAD_SYMREF_POINTEE,
     +					       "point to target outside gitdir");
     +			goto clean;
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +	if (parse_loose_ref_contents(ref_content.buf, &oid,
     +				     &referent, &type,
     +				     &failure_errno, &trailing)) {
    -+		ret = fsck_refs_report(o, NULL, refname.buf,
    ++		ret = fsck_refs_report(o, NULL, refname.buf, NULL,
     +				       FSCK_MSG_BAD_REF_CONTENT,
     +				       "invalid ref content");
     +		goto clean;
    @@ refs/files-backend.c: static int files_fsck_refs_name(struct fsck_options *o,
     +		 * be reported as a warning.
     +		 */
     +		if (trailing && (*trailing != '\0' && *trailing != '\n')) {
    -+			ret = fsck_refs_report(o, NULL, refname.buf,
    ++			ret = fsck_refs_report(o, NULL, refname.buf, NULL,
     +					       FSCK_MSG_TRAILING_REF_CONTENT,
     +					       "trailing garbage in ref");
     +			goto clean;
-- 
2.45.2

