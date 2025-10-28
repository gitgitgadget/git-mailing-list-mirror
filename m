Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC932E690
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 13:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659011; cv=none; b=H6toOiwFczsoB7Xbh0AdjwqdNGUnJtzN9Ra5OCyj/5qJi0TPYkDDT594u/GLOM17PX4HcU8O1bltjScxzBOSa59Yd0f3ZD38rcUlNrOZ/2wSlWbWvuJHH5wcBLLMLZcpQ8iPIgPha6TvXJyCkGDJ/MJGxU1/BWqAiRRr7Ek9JSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659011; c=relaxed/simple;
	bh=sHE7SgO3w0MwA2lukzICH5vABqP/9S/bkMsQltUxhiw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOX/Fa13CqMxgOcJuYcizElaaFUA8mEW+xywLu9fkIXPdyNdx84EvumnHqGaWcz1HMOfqDzYIeeyGLjUY3sMLQYirwrDzLw1ejQZuDl9YiR0/Yn8jRayqy39CHxgt823Unb84LKvar4IMOP7PfDrYoSiMi5BjCJq4QISwpuwzi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EnKQcdYs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C39F81HI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EnKQcdYs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C39F81HI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B6A59EC04D9;
	Tue, 28 Oct 2025 09:43:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 28 Oct 2025 09:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761659008; x=1761745408; bh=vkEEkRCnkk
	DR4UtwlT6N1/p9CsTnQyAyHOH/StEwTAw=; b=EnKQcdYsBhtDhSv+uH2g06i3A4
	CJ8EARfV87JKC6tRBh21Hiw/ro/862M//MwZsdn7VlAG81WmTDoTvEXIhaT7zI6u
	Joq9UkW+nIs0aARZPYsyLSPUpUEwoixVIe17eW9/gur+S2WJIr0F91qhuMylJL9G
	v1C73+2dFb+d5EaaPA5bnjHhFp3n1lzDTTF9/uM+JlooKvR8ryiKg77qHZnlsG8e
	jtFMmqLk37d13K6DBHAViPsyMZsZ82rP9G6HF6zw2KOXY0MZZnTX4DU8vd60FI9f
	5a+duaqowPo9CwXkbZRaBe7uCGIc8Vd7NGMz9ccS/MOPhdQM4KjufL89Nu1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761659008; x=1761745408; bh=vkEEkRCnkkDR4UtwlT6N1/p9CsTnQyAyHOH
	/StEwTAw=; b=C39F81HIrxEuYObwW4DYVIwmbk2kcWis7FsAeH/BWIppzol4BKi
	njt33BoipuHCng0ZdCOUhX+AxEy4LG2lPWEpzOSPc2DoBhVpkD7Z3pB/2iHLqSaZ
	qubba/QLu3SLNoslOcVTNi7SvDFluVTqns5n44km+F160cFIpCC61lokTzkP9kKb
	jDkeUQ2nhC6HEo+sx2bHF860Sgk6gJMU9WMVui9gUB6rL3CCWXTXsjKOt3EAEqwx
	l6qslEqCMqQyHIhpngw7E8kw95bgvwvEnsW2EvugQptXURcpUJukHSE34G6rRDtB
	cZcFPXvBSxcvc/sNhWKG4eVNFF6bggYypvQ==
X-ME-Sender: <xms:f8gAaSgry8Smz9g5XB4IZXoiH4_UJmKtqjSV7i5qFMgwIK7-vH12JQ>
    <xme:f8gAaVkw2_6UZgyn7GpNpK1D5SQ4-7_-42jQxQzyH90EmbPdt9j43ZBX5WuZqAsBz
    -4VZeDK5eJ1YDZtbAAFTCOk7PGnUlJMkJ-wDc9oXm2kCK6sSFu0>
X-ME-Received: <xmr:f8gAadtg7bf9xN50834Aa0gt1EoHhs3OxxVYkB5mC7xsxB5qP_BS08F05MC_Al63b6SRYhel6fjCxYDy-CLJsvjQIVS8u6GIgvUs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjoh
    hhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopegthhhr
    ihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:gMgAaba0h9Z77nLO1kIslwyhkxP7pR7wzgCumUcGUTxM4zlMrVtVNw>
    <xmx:gMgAaVClazGSTspbd5uyuAejm2n8skkOna9CKRReWvSfHwErq65SaQ>
    <xmx:gMgAaT_5vJgLCzi1cN4bLp4ISow6ilc0FmT-iGs1LTrqoTd61SynDA>
    <xmx:gMgAaRS2fwE6buDOVLeWzLMzRxzZ6SBtRV-1BqKpYDrDqJqq32p6Kg>
    <xmx:gMgAadMh6_R9KAHA9kXGedJmxxX4rbdGIFLt3YV_WdBStJKoUdEYcsWD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Oct 2025 09:43:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/5] fast-export: mark strings for translation
In-Reply-To: <20251028081232.3068147-4-christian.couder@gmail.com> (Christian
	Couder's message of "Tue, 28 Oct 2025 09:12:30 +0100")
References: <20251028081232.3068147-1-christian.couder@gmail.com>
	<20251028081232.3068147-4-christian.couder@gmail.com>
Date: Tue, 28 Oct 2025 06:43:26 -0700
Message-ID: <xmqqv7jzdtvl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> Some error or warning messages in "builtin/fast-export.c" are marked
> for translation, but many are not.
>
> To be more consistent and provide a better experience to people using a
> translated version, let's mark all the remaining error or warning
> messages for translation.

Makes sense.  Should we also downcase some Unknown and Unexpected?

> While at it, improve how some arguments to some error functions are
> indented.

OK.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/fast-export.c | 77 ++++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 38 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index dc2486f9a8..cb532f6325 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -65,7 +65,7 @@ static int parse_opt_sign_mode(const struct option *opt,
>  		return 0;
>  
>  	if (parse_sign_mode(arg, val))
> -		return error("Unknown %s mode: %s", opt->long_name, arg);
> +		return error(_("Unknown %s mode: %s"), opt->long_name, arg);
>  
>  	return 0;
>  }
> @@ -82,7 +82,7 @@ static int parse_opt_tag_of_filtered_mode(const struct option *opt,
>  	else if (!strcmp(arg, "rewrite"))
>  		*val = REWRITE;
>  	else
> -		return error("Unknown tag-of-filtered mode: %s", arg);
> +		return error(_("Unknown tag-of-filtered mode: %s"), arg);
>  	return 0;
>  }
>  
> @@ -107,7 +107,7 @@ static int parse_opt_reencode_mode(const struct option *opt,
>  		if (!strcasecmp(arg, "abort"))
>  			*val = REENCODE_ABORT;
>  		else
> -			return error("Unknown reencoding mode: %s", arg);
> +			return error(_("Unknown reencoding mode: %s"), arg);
>  	}
>  
>  	return 0;
> @@ -318,16 +318,16 @@ static void export_blob(const struct object_id *oid)
>  	} else {
>  		buf = odb_read_object(the_repository->objects, oid, &type, &size);
>  		if (!buf)
> -			die("could not read blob %s", oid_to_hex(oid));
> +			die(_("could not read blob %s"), oid_to_hex(oid));
>  		if (check_object_signature(the_repository, oid, buf, size,
>  					   type) < 0)
> -			die("oid mismatch in blob %s", oid_to_hex(oid));
> +			die(_("oid mismatch in blob %s"), oid_to_hex(oid));
>  		object = parse_object_buffer(the_repository, oid, type,
>  					     size, buf, &eaten);
>  	}
>  
>  	if (!object)
> -		die("Could not read blob %s", oid_to_hex(oid));
> +		die(_("Could not read blob %s"), oid_to_hex(oid));
>  
>  	mark_next_object(object);
>  
> @@ -336,7 +336,7 @@ static void export_blob(const struct object_id *oid)
>  		printf("original-oid %s\n", oid_to_hex(oid));
>  	printf("data %"PRIuMAX"\n", (uintmax_t)size);
>  	if (size && fwrite(buf, size, 1, stdout) != 1)
> -		die_errno("could not write blob '%s'", oid_to_hex(oid));
> +		die_errno(_("could not write blob '%s'"), oid_to_hex(oid));
>  	printf("\n");
>  
>  	show_progress();
> @@ -499,10 +499,10 @@ static void show_filemodify(struct diff_queue_struct *q,
>  			break;
>  
>  		default:
> -			die("Unexpected comparison status '%c' for %s, %s",
> -				q->queue[i]->status,
> -				ospec->path ? ospec->path : "none",
> -				spec->path ? spec->path : "none");
> +			die(_("Unexpected comparison status '%c' for %s, %s"),
> +			    q->queue[i]->status,
> +			    ospec->path ? ospec->path : _("none"),
> +			    spec->path ? spec->path : _("none"));
>  		}
>  	}
>  }
> @@ -699,14 +699,14 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  
>  	author = strstr(commit_buffer_cursor, "\nauthor ");
>  	if (!author)
> -		die("could not find author in commit %s",
> +		die(_("could not find author in commit %s"),
>  		    oid_to_hex(&commit->object.oid));
>  	author++;
>  	commit_buffer_cursor = author_end = strchrnul(author, '\n');
>  
>  	committer = strstr(commit_buffer_cursor, "\ncommitter ");
>  	if (!committer)
> -		die("could not find committer in commit %s",
> +		die(_("could not find committer in commit %s"),
>  		    oid_to_hex(&commit->object.oid));
>  	committer++;
>  	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
> @@ -781,8 +781,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  		case REENCODE_NO:
>  			break;
>  		case REENCODE_ABORT:
> -			die("Encountered commit-specific encoding %.*s in commit "
> -			    "%s; use --reencode=[yes|no] to handle it",
> +			die(_("Encountered commit-specific encoding %.*s in commit "
> +			      "%s; use --reencode=[yes|no] to handle it"),
>  			    (int)encoding_len, encoding,
>  			    oid_to_hex(&commit->object.oid));
>  		}
> @@ -798,11 +798,11 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  	if (signatures.nr) {
>  		switch (signed_commit_mode) {
>  		case SIGN_ABORT:
> -			die("encountered signed commit %s; use "
> -			    "--signed-commits=<mode> to handle it",
> +			die(_("encountered signed commit %s; use "
> +			      "--signed-commits=<mode> to handle it"),
>  			    oid_to_hex(&commit->object.oid));
>  		case SIGN_WARN_VERBATIM:
> -			warning("exporting %"PRIuMAX" signature(s) for commit %s",
> +			warning(_("exporting %"PRIuMAX" signature(s) for commit %s"),
>  				(uintmax_t)signatures.nr, oid_to_hex(&commit->object.oid));
>  			/* fallthru */
>  		case SIGN_VERBATIM:
> @@ -812,7 +812,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  			}
>  			break;
>  		case SIGN_WARN_STRIP:
> -			warning("stripping signature(s) from commit %s",
> +			warning(_("stripping signature(s) from commit %s"),
>  				oid_to_hex(&commit->object.oid));
>  			/* fallthru */
>  		case SIGN_STRIP:
> @@ -890,7 +890,8 @@ static void handle_tag(const char *name, struct tag *tag)
>  		tagged = ((struct tag *)tagged)->tagged;
>  	}
>  	if (tagged->type == OBJ_TREE) {
> -		warning("Omitting tag %s,\nsince tags of trees (or tags of tags of trees, etc.) are not supported.",
> +		warning(_("Omitting tag %s,\nsince tags of trees (or tags "
> +			  "of tags of trees, etc.) are not supported."),
>  			oid_to_hex(&tag->object.oid));
>  		return;
>  	}
> @@ -898,7 +899,7 @@ static void handle_tag(const char *name, struct tag *tag)
>  	buf = odb_read_object(the_repository->objects, &tag->object.oid,
>  			      &type, &size);
>  	if (!buf)
> -		die("could not read tag %s", oid_to_hex(&tag->object.oid));
> +		die(_("could not read tag %s"), oid_to_hex(&tag->object.oid));
>  	message = memmem(buf, size, "\n\n", 2);
>  	if (message) {
>  		message += 2;
> @@ -936,17 +937,17 @@ static void handle_tag(const char *name, struct tag *tag)
>  		if (signature)
>  			switch (signed_tag_mode) {
>  			case SIGN_ABORT:
> -				die("encountered signed tag %s; use "
> -				    "--signed-tags=<mode> to handle it",
> +				die(_("encountered signed tag %s; use "
> +				      "--signed-tags=<mode> to handle it"),
>  				    oid_to_hex(&tag->object.oid));
>  			case SIGN_WARN_VERBATIM:
> -				warning("exporting signed tag %s",
> +				warning(_("exporting signed tag %s"),
>  					oid_to_hex(&tag->object.oid));
>  				/* fallthru */
>  			case SIGN_VERBATIM:
>  				break;
>  			case SIGN_WARN_STRIP:
> -				warning("stripping signature from tag %s",
> +				warning(_("stripping signature from tag %s"),
>  					oid_to_hex(&tag->object.oid));
>  				/* fallthru */
>  			case SIGN_STRIP:
> @@ -961,8 +962,8 @@ static void handle_tag(const char *name, struct tag *tag)
>  	if (!tagged_mark) {
>  		switch (tag_of_filtered_mode) {
>  		case TAG_FILTERING_ABORT:
> -			die("tag %s tags unexported object; use "
> -			    "--tag-of-filtered-object=<mode> to handle it",
> +			die(_("tag %s tags unexported object; use "
> +			      "--tag-of-filtered-object=<mode> to handle it"),
>  			    oid_to_hex(&tag->object.oid));
>  		case DROP:
>  			/* Ignore this tag altogether */
> @@ -1026,7 +1027,7 @@ static struct commit *get_commit(struct rev_cmdline_entry *e, const char *full_n
>  			tag = (struct tag *)tag->tagged;
>  		}
>  		if (!tag)
> -			die("Tag %s points nowhere?", e->name);
> +			die(_("Tag %s points nowhere?"), e->name);
>  		return (struct commit *)tag;
>  	}
>  	default:
> @@ -1064,7 +1065,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
>  
>  		commit = get_commit(e, full_name);
>  		if (!commit) {
> -			warning("%s: Unexpected object of type %s, skipping.",
> +			warning(_("%s: Unexpected object of type %s, skipping."),
>  				e->name,
>  				type_name(e->item->type));
>  			free(full_name);
> @@ -1079,7 +1080,7 @@ static void get_tags_and_duplicates(struct rev_cmdline_info *info)
>  			free(full_name);
>  			continue;
>  		default: /* OBJ_TAG (nested tags) is already handled */
> -			warning("Tag points to object of unexpected type %s, skipping.",
> +			warning(_("Tag points to object of unexpected type %s, skipping."),
>  				type_name(commit->object.type));
>  			free(full_name);
>  			continue;
> @@ -1175,7 +1176,7 @@ static void export_marks(char *file)
>  
>  	f = fopen_for_writing(file);
>  	if (!f)
> -		die_errno("Unable to open marks file %s for writing.", file);
> +		die_errno(_("Unable to open marks file %s for writing."), file);
>  
>  	for (i = 0; i < idnums.size; i++) {
>  		if (deco->base && deco->base->type == 1) {
> @@ -1192,7 +1193,7 @@ static void export_marks(char *file)
>  	e |= ferror(f);
>  	e |= fclose(f);
>  	if (e)
> -		error("Unable to write marks file %s.", file);
> +		error(_("Unable to write marks file %s."), file);
>  }
>  
>  static void import_marks(char *input_file, int check_exists)
> @@ -1215,20 +1216,20 @@ static void import_marks(char *input_file, int check_exists)
>  
>  		line_end = strchr(line, '\n');
>  		if (line[0] != ':' || !line_end)
> -			die("corrupt mark line: %s", line);
> +			die(_("corrupt mark line: %s"), line);
>  		*line_end = '\0';
>  
>  		mark = strtoumax(line + 1, &mark_end, 10);
>  		if (!mark || mark_end == line + 1
>  			|| *mark_end != ' ' || get_oid_hex(mark_end + 1, &oid))
> -			die("corrupt mark line: %s", line);
> +			die(_("corrupt mark line: %s"), line);
>  
>  		if (last_idnum < mark)
>  			last_idnum = mark;
>  
>  		type = odb_read_object_info(the_repository->objects, &oid, NULL);
>  		if (type < 0)
> -			die("object not found: %s", oid_to_hex(&oid));
> +			die(_("object not found: %s"), oid_to_hex(&oid));
>  
>  		if (type != OBJ_COMMIT)
>  			/* only commits */
> @@ -1236,12 +1237,12 @@ static void import_marks(char *input_file, int check_exists)
>  
>  		commit = lookup_commit(the_repository, &oid);
>  		if (!commit)
> -			die("not a commit? can't happen: %s", oid_to_hex(&oid));
> +			die(_("not a commit? can't happen: %s"), oid_to_hex(&oid));
>  
>  		object = &commit->object;
>  
>  		if (object->flags & SHOWN)
> -			error("Object %s already has a mark", oid_to_hex(&oid));
> +			error(_("Object %s already has a mark"), oid_to_hex(&oid));
>  
>  		mark_object(object, mark);
>  
> @@ -1395,7 +1396,7 @@ int cmd_fast_export(int argc,
>  	get_tags_and_duplicates(&revs.cmdline);
>  
>  	if (prepare_revision_walk(&revs))
> -		die("revision walk setup failed");
> +		die(_("revision walk setup failed"));
>  
>  	revs.reverse = 1;
>  	revs.diffopt.format_callback = show_filemodify;
