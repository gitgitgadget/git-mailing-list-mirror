Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D41C06
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449401; cv=none; b=FPy1F+ahk6JsLOxEWWuiF7Nu+yH7ep9OtmQ9Z8y7aR3mp81FRq3kovBUBw5NY7ZCP1RYyb2MybLPGbnc7euxW20d/556UDWE9rCabZ3QCjIhZKD7geFRNwPk92hdzwkLr6MNWHnsxhb8cFP/s6hsNTAW0Lor901fPKnRwGnRBio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449401; c=relaxed/simple;
	bh=4ODxv/2L3HVAD3b2i2yTdP2lakpXHRFlDPQOeTrMh+U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+5GPEQNVYiUkvIheRMBLiUtXWTQn+nytLWr0EaldHqJYY6TjZlQxiaz8waRKIJl2myM2aIrpwxFttcMVLkDeP2Q4Uu4eqfklbCB4plpmUh6J5Ib4/kpbD8erN5M3wEs41QOf3l0hwU3+gxoly0Sg9vVq6vPA2TDTKz2izLh4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMPb3Zj2; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMPb3Zj2"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-24c9f6338a4so2567642fac.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720449399; x=1721054199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WpofeBrPNE+c3Jt5tvI2IULNEITa+Kk2GmjzCs0EbY=;
        b=QMPb3Zj2jMZxk3HMPZHre+OO7yLvF8GKzzltsB2ZgNDRMp8KBeY07HXQ8ZKl0Z5Nlh
         Cv8dSFLNL63VA5pdK0Z6OGZmhJCs0Ltmhx+PP2wQwA2z0N+lSAGMAWiP8SdI7Wos9QsA
         ozZWXdxitHNIuYxjHGkHA8stSl0DjY2odZmWZRWY5PCjL8hZAQwTpslYWmUU0K6TT5xI
         yllyE7LfpjV93Zd/6Gf+PVcagy9zx67ZmdyU8XuEnsRpvJq5HIt8qIJtWo++jtqA2eL3
         8PNbxbAseCG8W27LUBbkDCSDM38e4ChM1gdN+buhVaZLPdvE2RGbz0zSmkd3PiIG0PIv
         B4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720449399; x=1721054199;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WpofeBrPNE+c3Jt5tvI2IULNEITa+Kk2GmjzCs0EbY=;
        b=Z+bx8MloUoZ7VFXSAjaG0LCn92vhE9WajrvyB7uG55YuP7i9RRn/MXeTQcX1rUYLFB
         LYTqFS1k1n33dYkEwmV88TPrNhek5CPZVQjgy2S05eBFiArF2r1qIfOVHmF37KYrjx+8
         zBtOfEa5Xi2Tu169KFBLCItWfZMf0lPdZaY7x3W5cbHkKkiqRozvWBUthzd0vdOymX1T
         Akb6SXhOllnPHDwnAFHIP59U90GkBMZFQnGLBa5Tz8rBTsDdaVqkGlm4LhnrDYSbaHyW
         vs0nx3/nyKIJ9hgqNHcUNO763oeJT6X3pDjWlbBRtQVfZ4DKbQYVQF2BwEKJw6a1xPGw
         SA5w==
X-Forwarded-Encrypted: i=1; AJvYcCWVLrnW349bPGJFm9gRlK73vfEu3uzq1ymIli7w21Mi6C04oOoWddB1qy8ya/5vxDM+vt5Hs3qZ2N09bhF6Lsz83OCU
X-Gm-Message-State: AOJu0YxDu01QUkRXUiYxZ9We/0eunsyvr1RnGQUNaYwql1ol9KJBFDkB
	KejQ6PrnQcKmQgyIe6mmGE72KmQAplftWBl5vPM87RwzpDvRJr1RmXLGs/lwme4iemtyu7YdTki
	vrqjw9hEYVSyXXGutdATsTQxkeBuAIWsn
X-Google-Smtp-Source: AGHT+IErwQ4GwK+tb+06pNDMtXYK6Mj9S0qUY+2ZtWANN3xZKmeOIeIMMTWLoJNnrWIFfvq9+jYOwnsMOfFZRWVbP6c=
X-Received: by 2002:a05:6870:65a2:b0:25e:e09:786d with SMTP id
 586e51a60fabf-25e2bf9b4e0mr11297449fac.53.1720449399045; Mon, 08 Jul 2024
 07:36:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 10:36:38 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZovrFCzRg06pq5eI@ArchLinux>
References: <ZoVX6sn2C9VIeZ38@ArchLinux> <ZovrFCzRg06pq5eI@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jul 2024 10:36:38 -0400
Message-ID: <CAOLa=ZRPaiHK+NezigXEyWceriHZ7rb6msR51zcit9X=8rHFyQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v8 2/9] fsck: add a unified interface for reporting
 fsck messages
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000048dc88061cbd5755"

--00000000000048dc88061cbd5755
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> The static function "report" provided by "fsck.c" aims at checking fsck
> error type and calling the callback "error_func" to report the message.
> However, "report" function is only related to object database which
> cannot be reused for refs. In order to provide a unified interface which
> can report either objects or refs, create a new function "vfsck_report"
> by adding "checked_ref_name" parameter following the "report" prototype.
> Instead of using "...", provide "va_list" to allow more flexibility.
>
> Like "report", the "vfsck_report" function will use "error_func"
> registered in "fsck_options" to report customized messages. Change
> "error_func" prototype to align with the new "vfsck_report".
>
> Then, change "report" function to use "vfsck_report" to report objects
> related messages. Add a new function called "fsck_refs_report" to use
> "vfsck_report" to report refs related messages.
>

Not sure I really understand why we need to do this. Why can't we simply
add `const char *checked_ref_name` to the existing 'report' and
propagate this also to 'error_func'. Why do we need all this parallel
flows?

Apart from that, what does 'v' in 'vfsck_report' signify?

Perhaps it is also because this commit is doing a lot of things and we
could have simplified it into smaller commits?

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  builtin/fsck.c  | 15 ++++-----
>  builtin/mktag.c |  1 +
>  fsck.c          | 81 ++++++++++++++++++++++++++++++++++++-------------
>  fsck.h          | 42 ++++++++++++++++---------
>  object-file.c   | 11 ++++---
>  5 files changed, 102 insertions(+), 48 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index d13a226c2e..de34538c4f 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -89,12 +89,13 @@ static int objerror(struct object *obj, const char *err)
>  	return -1;
>  }
>
> -static int fsck_error_func(struct fsck_options *o UNUSED,
> -			   const struct object_id *oid,
> -			   enum object_type object_type,
> -			   enum fsck_msg_type msg_type,
> -			   enum fsck_msg_id msg_id UNUSED,
> -			   const char *message)
> +static int fsck_objects_error_func(struct fsck_options *o UNUSED,
> +				   const struct object_id *oid,
> +				   enum object_type object_type,
> +				   const char *checked_ref_name UNUSED,
> +				   enum fsck_msg_type msg_type,
> +				   enum fsck_msg_id msg_id UNUSED,
> +				   const char *message)
>  {
>  	switch (msg_type) {
>  	case FSCK_WARN:
> @@ -938,7 +939,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
>
>  	fsck_walk_options.walk = mark_object;
>  	fsck_obj_options.walk = mark_used;
> -	fsck_obj_options.error_func = fsck_error_func;
> +	fsck_obj_options.error_func = fsck_objects_error_func;
>  	if (check_strict)
>  		fsck_obj_options.strict = 1;
>
> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 4767f1a97e..42f945c584 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -20,6 +20,7 @@ static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
>  static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
>  				 const struct object_id *oid UNUSED,
>  				 enum object_type object_type UNUSED,
> +				 const char *checked_ref_name UNUSED,
>  				 enum fsck_msg_type msg_type,
>  				 enum fsck_msg_id msg_id UNUSED,
>  				 const char *message)
> diff --git a/fsck.c b/fsck.c
> index 1960bfeba9..7182ce8e80 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -226,12 +226,18 @@ static int object_on_skiplist(struct fsck_options *opts,
>  	return opts && oid && oidset_contains(&opts->oid_skiplist, oid);
>  }
>
> -__attribute__((format (printf, 5, 6)))
> -static int report(struct fsck_options *options,
> -		  const struct object_id *oid, enum object_type object_type,
> -		  enum fsck_msg_id msg_id, const char *fmt, ...)
> +/*
> + * Provide a unified interface for either fscking refs or objects.
> + * It will get the current msg error type and call the error_func callback
> + * which is registered in the "fsck_options" struct.
> + */
> +static int vfsck_report(struct fsck_options *options,
> +			const struct object_id *oid,
> +			enum object_type object_type,
> +			const char *checked_ref_name,
> +			enum fsck_msg_id msg_id, const char *fmt, va_list ap)
>  {
> -	va_list ap;
> +	va_list ap_copy;
>  	struct strbuf sb = STRBUF_INIT;
>  	enum fsck_msg_type msg_type = fsck_msg_type(msg_id, options);
>  	int result;
> @@ -250,9 +256,9 @@ static int report(struct fsck_options *options,
>  	prepare_msg_ids();
>  	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
>
> -	va_start(ap, fmt);
> -	strbuf_vaddf(&sb, fmt, ap);
> -	result = options->error_func(options, oid, object_type,
> +	va_copy(ap_copy, ap);
> +	strbuf_vaddf(&sb, fmt, ap_copy);
> +	result = options->error_func(options, oid, object_type, checked_ref_name,
>  				     msg_type, msg_id, sb.buf);
>  	strbuf_release(&sb);
>  	va_end(ap);
> @@ -260,6 +266,36 @@ static int report(struct fsck_options *options,
>  	return result;
>  }
>
> +__attribute__((format (printf, 5, 6)))
>

Shouldn't this be moved to the header file too?

> +static int report(struct fsck_options *options,
> +		  const struct object_id *oid, enum object_type object_type,
> +		  enum fsck_msg_id msg_id, const char *fmt, ...)
> +{
> +	va_list ap;
> +	int result;
> +	va_start(ap, fmt);
> +	result = vfsck_report(options, oid, object_type, NULL,
> +			      msg_id, fmt, ap);
> +	va_end(ap);
> +	return result;
> +}
> +
> +
> +

There is an extra newline here.

> +int fsck_refs_report(struct fsck_options *options,
> +		     const struct object_id *oid,
> +		     const char *checked_ref_name,
> +		     enum fsck_msg_id msg_id, const char *fmt, ...)
> +{
> +	va_list ap;
> +	int result;
> +	va_start(ap, fmt);
> +	result = vfsck_report(options, oid, OBJ_NONE,
> +			      checked_ref_name, msg_id, fmt, ap);
> +	va_end(ap);
> +	return result;
> +}
> +
>  void fsck_enable_object_names(struct fsck_options *options)
>  {
>  	if (!options->object_names)
> @@ -1200,12 +1236,13 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
>  		      type);
>  }
>
> -int fsck_error_function(struct fsck_options *o,
> -			const struct object_id *oid,
> -			enum object_type object_type UNUSED,
> -			enum fsck_msg_type msg_type,
> -			enum fsck_msg_id msg_id UNUSED,
> -			const char *message)
> +int fsck_objects_error_function(struct fsck_options *o,
> +				const struct object_id *oid,
> +				enum object_type object_type UNUSED,
> +				const char *checked_ref_name UNUSED,
> +				enum fsck_msg_type msg_type,
> +				enum fsck_msg_id msg_id UNUSED,
> +				const char *message)
>  {
>  	if (msg_type == FSCK_WARN) {
>  		warning("object %s: %s", fsck_describe_object(o, oid), message);
> @@ -1303,16 +1340,18 @@ int git_fsck_config(const char *var, const char *value,
>   * Custom error callbacks that are used in more than one place.
>   */
>
> -int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
> -					   const struct object_id *oid,
> -					   enum object_type object_type,
> -					   enum fsck_msg_type msg_type,
> -					   enum fsck_msg_id msg_id,
> -					   const char *message)
> +int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
> +						   const struct object_id *oid,
> +						   enum object_type object_type,
> +						   const char *checked_ref_name,
> +						   enum fsck_msg_type msg_type,
> +						   enum fsck_msg_id msg_id,
> +						   const char *message)
>  {
>  	if (msg_id == FSCK_MSG_GITMODULES_MISSING) {
>  		puts(oid_to_hex(oid));
>  		return 0;
>  	}
> -	return fsck_error_function(o, oid, object_type, msg_type, msg_id, message);
> +	return fsck_objects_error_function(o, oid, object_type, checked_ref_name,
> +					   msg_type, msg_id, message);
>  }
> diff --git a/fsck.h b/fsck.h
> index 1ee3dd85ba..f703dfb5e8 100644
> --- a/fsck.h
> +++ b/fsck.h
> @@ -114,22 +114,27 @@ int is_valid_msg_type(const char *msg_id, const char *msg_type);
>  typedef int (*fsck_walk_func)(struct object *obj, enum object_type object_type,
>  			      void *data, struct fsck_options *options);
>
> -/* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
> +/*
> + * callback function for reporting errors when checking either objects or refs
> + */
>  typedef int (*fsck_error)(struct fsck_options *o,
>  			  const struct object_id *oid, enum object_type object_type,
> +			  const char *checked_ref_name,
>  			  enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
>  			  const char *message);
>
> -int fsck_error_function(struct fsck_options *o,
> -			const struct object_id *oid, enum object_type object_type,
> -			enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
> -			const char *message);
> -int fsck_error_cb_print_missing_gitmodules(struct fsck_options *o,
> -					   const struct object_id *oid,
> -					   enum object_type object_type,
> -					   enum fsck_msg_type msg_type,
> -					   enum fsck_msg_id msg_id,
> -					   const char *message);
> +int fsck_objects_error_function(struct fsck_options *o,
> +				const struct object_id *oid, enum object_type object_type,
> +				const char *checked_ref_name,
> +				enum fsck_msg_type msg_type, enum fsck_msg_id msg_id,
> +				const char *message);
> +int fsck_objects_error_cb_print_missing_gitmodules(struct fsck_options *o,
> +						   const struct object_id *oid,
> +						   enum object_type object_type,
> +						   const char *checked_ref_name,
> +						   enum fsck_msg_type msg_type,
> +						   enum fsck_msg_id msg_id,
> +						   const char *message);
>
>  struct fsck_options {
>  	fsck_walk_func walk;
> @@ -145,12 +150,12 @@ struct fsck_options {
>  };
>
>  #define FSCK_OPTIONS_DEFAULT { \
> -	.skiplist = OIDSET_INIT, \
> +	.oid_skiplist = OIDSET_INIT, \
>  	.gitmodules_found = OIDSET_INIT, \
>  	.gitmodules_done = OIDSET_INIT, \
>  	.gitattributes_found = OIDSET_INIT, \
>  	.gitattributes_done = OIDSET_INIT, \
> -	.error_func = fsck_error_function \
> +	.error_func = fsck_objects_error_function \
>  }
>  #define FSCK_OPTIONS_STRICT { \
>  	.strict = 1, \
> @@ -158,7 +163,7 @@ struct fsck_options {
>  	.gitmodules_done = OIDSET_INIT, \
>  	.gitattributes_found = OIDSET_INIT, \
>  	.gitattributes_done = OIDSET_INIT, \
> -	.error_func = fsck_error_function, \
> +	.error_func = fsck_objects_error_function, \
>  }
>  #define FSCK_OPTIONS_MISSING_GITMODULES { \
>  	.strict = 1, \
> @@ -166,7 +171,7 @@ struct fsck_options {
>  	.gitmodules_done = OIDSET_INIT, \
>  	.gitattributes_found = OIDSET_INIT, \
>  	.gitattributes_done = OIDSET_INIT, \
> -	.error_func = fsck_error_cb_print_missing_gitmodules, \
> +	.error_func = fsck_objects_error_cb_print_missing_gitmodules, \
>  }
>
>  /* descend in all linked child objects
> @@ -209,6 +214,13 @@ int fsck_tag_standalone(const struct object_id *oid, const char *buffer,
>   */
>  int fsck_finish(struct fsck_options *options);
>
> +__attribute__((format (printf, 5, 6)))
> +int fsck_refs_report(struct fsck_options *options,
> +		     const struct object_id *oid,
> +		     const char *checked_ref_name,
> +		     enum fsck_msg_id msg_id,
> +		     const char *fmt, ...);
> +
>  /*
>   * Subsystem for storing human-readable names for each object.
>   *
> diff --git a/object-file.c b/object-file.c
> index 065103be3e..d2c6427935 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2470,11 +2470,12 @@ int repo_has_object_file(struct repository *r,
>   * give more context.
>   */
>  static int hash_format_check_report(struct fsck_options *opts UNUSED,
> -				     const struct object_id *oid UNUSED,
> -				     enum object_type object_type UNUSED,
> -				     enum fsck_msg_type msg_type UNUSED,
> -				     enum fsck_msg_id msg_id UNUSED,
> -				     const char *message)
> +				    const struct object_id *oid UNUSED,
> +				    enum object_type object_type UNUSED,
> +				    const char *ref_checked_name UNUSED,
> +				    enum fsck_msg_type msg_type UNUSED,
> +				    enum fsck_msg_id msg_id UNUSED,
> +				    const char *message)
>  {
>  	error(_("object fails fsck: %s"), message);
>  	return 1;
> --
> 2.45.2

--00000000000048dc88061cbd5755
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 7de98fefa53bf1cf_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hTCtYUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meCt6REFDTUxlNWVxdkFrSHZlZnEwSEI4eVpoTndONgoxSWcvRkhFVEtE
VVUrNVYvb25LZ3gvMnhsdk92cXZKOC9oRzM0SG55WXZqV2dMMDhMRHNMZ05TK2YzdUZaNmRKClBD
eEZGZ0xFQVczdkpXZWZvK01RbEJXajc1bkRFRkhuSjNEcTZiYXFpdmlxS09XU1JId3U1UE9GMldW
R0dxVlYKdzM4M1dSQWgvYVVCNE9hT1RLSWpDYlBVNjNlQlkyQmtFT0dicmxvZHVsbW1aUGlVK25U
RTZBcCtDbjBia1RGMAo2RmFMaTl1U2pGNXMvaUhsZFVBNXhad1lIY0I3d0ZkK1NxR25YQlNmOEFp
bW14NnhiZmNRQzl5WjJkdXhGcmtwCkJzUTdvYndWWVJoYURnbFk0TVVIdTlKeFdXMGZJOXVnc1pJ
ZGN3Q0VDbFB5eUQ3WnlZZ2NJbkFEK0N6SlpINk0KdC9oaGZWWkZ0VGlRaEtueU9qS2l6eE12cG1I
R2Job3FPM211Q2dJNk1RREUvVkpsdzZIRTBrLy9aQ3pRMDgrTQpXaGZSTzVUdXpTcWNqQ0dhWjU1
WmdWdUNQUmJ5alpOaUhDSzBJSUt6U3g2WjB3eXp5b2pGaTVqbFFBZTNTN2M0CjJNWjV0UmhDdzlP
dDUwT1NDNGp1dU9EWTc0S1MwS3p4RUZJL2FqYz0KPXArNW4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000048dc88061cbd5755--
