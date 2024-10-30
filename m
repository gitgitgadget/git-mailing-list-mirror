Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433D1E3776
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730327408; cv=none; b=m2UrvxLMrpaPn2+CVEFrHbPXQ7MJ8TNV+8hMsjJ1tT1DRFsb0uIq0zfK/45TqG64bBPPq3O/qQa1HdHPIeny6iulqlH9tf4DarSBWxGhjTrwuBL3ESPd5ISWbG8I2RB6zUYV0BbIICh9h1kWCzxEG3a+hCBoMyll98IpRyKUtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730327408; c=relaxed/simple;
	bh=EdXyIIjVWSSRs4jFFaCYdUmY805T8CtTGVQJxvhlls8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWXwq8AZn2xslg1+GeYsegA0+OBQ6RiCD/BI72EqGkSVnsysHb0ayMIYNjCtl1a0KBx+CFsFIqnrjBR8iCQk88rKyC8HjrfMQ5odSaZI9FdTO6OJOTcT361plmb2xEEiUIkoxeUmpzpLM/L1azjI0L85u7C1tft9v/9aBpayS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1CEZzcPx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1CEZzcPx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca4877690so29375ad.1
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730327405; x=1730932205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wH7kSUAq2tADcI5SLbzZepjfcwZ6B1mXtcsdegr1Bs=;
        b=1CEZzcPxpgkm11m2GRBeDGPX0vmqzqjqk7FcQhZ6cUTsnYfdCA+7GVB32MfccPWjmJ
         4APh4uGKUQuwDWH/6J3d9mHspij0+6zt1fEemT92Ie/DYIHBEaM0X2ZrIptphjeyfnV5
         86uh5uMwMlOwJOokF0Xqbd7K7aZYLIQTJ8Himx+bJTlc5bBK3LbZLvcitZ8dJJz2ee/L
         WgnQa4dFWD4ts1q06pzkm5ssv1DM0mxKzXiNL6VnHv5alkHLH7dKMYvnxIA6y63h98pZ
         zhZJ++P6j7GqgniU7BBMjw0cc0fB7hn3gyrgF4gyN8u5gqhvC63gx1aofpNSHguGj1yu
         DPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730327405; x=1730932205;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wH7kSUAq2tADcI5SLbzZepjfcwZ6B1mXtcsdegr1Bs=;
        b=sALrvMTaJH1IBdCc1MqFUG0XgVKA5TzgQRCmxGob93k/v0rnodwMSLWLR0P3+PS8Px
         ZqDX6I/GmMue2Jb1bJS7qE7/7KOLmbps+s2Kz8+KnrrMf4TuBy48DI1MWKqMDuaFpzQt
         H4d/bkIwpTYuOqbw1wqTohBZtEDK13VHWnkn5XZw1i9HXmVNVlr/WQsN1UXjIaE6f388
         6VEaAe6sLrsPIejlHFJYRCtsZKBY2DcGFeaySnOpZZ95SOO/AzyDxyof+zh9idloSe8X
         /+Z/akzbHP6YebUF849bRY4e5G4CE4rmYQXx3zxy0NaOZc5JcFY+HXPgyaeYdFsPzFCf
         s9fQ==
X-Gm-Message-State: AOJu0YyN8POxRjLwvZKeOYr8sslpdkvSR6yc+GoY8ZorvSvF4dfsxH5d
	Vc9NHVUVEXu65T6HPOnNjn7eG9CRINHP9nZr4IoYj0lJIkULSHvFObWqOFLBWw==
X-Gm-Gg: ASbGnctJC7jY7aUHuR0kizNecBYVzykNqYhFSUh7CVqVS3bBu5yCTL83Z66ZpDXA95Z
	3qhxBa0kNcZZmpiKQ8E3pIUbdsy9lzoFY4XKctirrwHSDPV7q6oL+mRnbEWvyeOt+UeHtYCS8kN
	R7O79Mxm/gAAGPk282FDfx/w47X2U6Iki+FlsL3ivV1pevLp6CwrRwphMQ7nIjqDi/mEARimee0
	Yeg/XHHVrxKV02sHwYOEGEXSz9Ub7NHpt73TSNs5taZ0hwF
X-Google-Smtp-Source: AGHT+IG+UCVXhHOm1U6EX4nWZDuwP+1BLT5vzwNzunNbAwMd3BYVAAX9WksRY01D/w0u7OGyhATjxA==
X-Received: by 2002:a17:902:ce91:b0:207:14ca:f0c1 with SMTP id d9443c01a7336-2110427ce3cmr1133945ad.16.1730327404860;
        Wed, 30 Oct 2024 15:30:04 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:e2cb:194a:36bf:6b07])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c4165sm128076b3a.100.2024.10.30.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 15:30:04 -0700 (PDT)
Date: Wed, 30 Oct 2024 15:29:59 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, hanyang.tony@bytedance.com
Subject: Re: [PATCH 5/5] index-pack: repack local links into promisor packs
Message-ID: <radxsrv6sjemdzl2mw5zzkieyim6xfikrevwggjmzi774g2sob@4nx7fwcjfk32>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, calvinwan@google.com, 
	hanyang.tony@bytedance.com
References: <cover.1729792911.git.jonathantanmy@google.com>
 <5dd7fdc16df7757ee1b24997ad9fbe3f923d5e93.1729792911.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd7fdc16df7757ee1b24997ad9fbe3f923d5e93.1729792911.git.jonathantanmy@google.com>

Mostly looks good, just one point of confusion on my part, and one nit.
Thanks for the patch! (comments inline below)


On 2024.10.24 11:08, Jonathan Tan wrote:
> Teach index-pack to, when processing the objects in a pack with
> --promisor specified on the CLI, repack local objects (and the local
> objects that they refer to, recursively) referenced by these objects
> into promisor packs.
> 
> This prevents the situation in which, when fetching from a promisor
> remote, we end up with promisor objects (newly fetched) referring
> to non-promisor objects (locally created prior to the fetch). This
> situation may arise if the client had previously pushed objects to the
> remote, for example. One issue that arises in this situation is that,
> if the non-promisor objects become inaccessible except through promisor
> objects (for example, if the branch pointing to them has moved to
> point to the promisor object that refers to them), then GC will garbage
> collect them. There are other ways to solve this, but the simplest
> seems to be to enforce the invariant that we don't have promisor objects
> referring to non-promisor objects.
> 
> This repacking is done from index-pack to minimize the performance
> impact. During a fetch, the only time most objects are fully inflated
> in memory is when their object ID is computed, so we also scan the
> objects (to see which objects they refer to) during this time.
> 
> Also to minimize the performance impact, an object is calculated to be
> local if it's a loose object or present in a non-promisor pack. (If it's
> also in a promisor pack or referred to by an object in a promisor pack,
> it is technically already a promisor object. But a misidentification
> of a promisor object as a non-promisor object is relatively benign
> here - we will thus repack that promisor object into a promisor pack,
> duplicating it in the object store, but there is no correctness issue,
> just an issue of inefficiency.)
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  Documentation/git-index-pack.txt |   5 ++
>  builtin/index-pack.c             | 110 ++++++++++++++++++++++++++++++-
>  builtin/pack-objects.c           |  28 ++++++++
>  t/t5616-partial-clone.sh         |  30 +++++++++
>  4 files changed, 171 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
> index 5a20deefd5..4be09e58e7 100644
> --- a/Documentation/git-index-pack.txt
> +++ b/Documentation/git-index-pack.txt
> @@ -139,6 +139,11 @@ include::object-format-disclaimer.txt[]
>  	written. If a `<message>` is provided, then that content will be
>  	written to the .promisor file for future reference. See
>  	link:technical/partial-clone.html[partial clone] for more information.
> ++
> +Also, if there are objects in the given pack that references non-promisor
> +objects (in the repo), repacks those non-promisor objects into a promisor
> +pack. This avoids a situation in which a repo has non-promisor objects that are
> +accessible through promisor objects.
>  
>  NOTES
>  -----
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 9d23b41b3a..e4afd6725f 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -9,6 +9,7 @@
>  #include "csum-file.h"
>  #include "blob.h"
>  #include "commit.h"
> +#include "tag.h"
>  #include "tree.h"
>  #include "progress.h"
>  #include "fsck.h"
> @@ -20,9 +21,14 @@
>  #include "object-file.h"
>  #include "object-store-ll.h"
>  #include "oid-array.h"
> +#include "oidset.h"
> +#include "path.h"
>  #include "replace-object.h"
> +#include "tree-walk.h"
>  #include "promisor-remote.h"
> +#include "run-command.h"
>  #include "setup.h"
> +#include "strvec.h"
>  
>  static const char index_pack_usage[] =
>  "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-id>=<severity>...]] [--fsck-objects[=<msg-id>=<severity>...]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
> @@ -148,6 +154,13 @@ static uint32_t input_crc32;
>  static int input_fd, output_fd;
>  static const char *curr_pack;
>  
> +/*
> + * local_links is guarded by read_mutex, and record_local_links is read-only in
> + * a thread.
> + */
> +static struct oidset local_links = OIDSET_INIT;
> +static int record_local_links;
> +
>  static struct thread_local *thread_data;
>  static int nr_dispatched;
>  static int threads_active;
> @@ -799,6 +812,44 @@ static int check_collison(struct object_entry *entry)
>  	return 0;
>  }
>  
> +static void record_if_local_object(const struct object_id *oid)
> +{
> +	struct object_info info = OBJECT_INFO_INIT;
> +	if (oid_object_info_extended(the_repository, oid, &info, 0))
> +		/* Missing; assume it is a promisor object */
> +		return;
> +	if (info.whence == OI_PACKED && info.u.packed.pack->pack_promisor)
> +		return;
> +	oidset_insert(&local_links, oid);
> +}
> +
> +static void do_record_local_links(struct object *obj)
> +{
> +	if (obj->type == OBJ_TREE) {
> +		struct tree *tree = (struct tree *)obj;
> +		struct tree_desc desc;
> +		struct name_entry entry;
> +		if (init_tree_desc_gently(&desc, &tree->object.oid,
> +					  tree->buffer, tree->size, 0))

This part confused me for a bit, since I didn't see how simply casting
a `struct object *` to a `struct tree *` could possibly guarantee that
`tree->buffer` or `tree->size` pointed to valid memory. But the object
pointers in question have all been created via `parse_object_buffer` and
allocated as the appropriate blob/tree/commit/tag structs, and were
previously cast to `struct object *` by that function. So all looks good
here.


> +			/*
> +			 * Error messages are given when packs are
> +			 * verified, so do not print any here.
> +			 */
> +			return;
> +		while (tree_entry_gently(&desc, &entry))
> +			record_if_local_object(&entry.oid);
> +	} else if (obj->type == OBJ_COMMIT) {
> +		struct commit *commit = (struct commit *) obj;
> +		struct commit_list *parents = commit->parents;
> +
> +		for (; parents; parents = parents->next)
> +			record_if_local_object(&parents->item->object.oid);
> +	} else if (obj->type == OBJ_TAG) {
> +		struct tag *tag = (struct tag *) obj;
> +		record_if_local_object(get_tagged_oid(tag));
> +	}

We only ever `record_if_local_object()` on things referenced by `obj`
here but not on `obj` itself. We should only be calling this on objects
that are inside a promisor pack, so all good here I think.

> +}
> +
>  static void sha1_object(const void *data, struct object_entry *obj_entry,
>  			unsigned long size, enum object_type type,
>  			const struct object_id *oid)
> @@ -845,7 +896,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>  		free(has_data);
>  	}
>  
> -	if (strict || do_fsck_object) {
> +	if (strict || do_fsck_object || record_local_links) {
>  		read_lock();
>  		if (type == OBJ_BLOB) {
>  			struct blob *blob = lookup_blob(the_repository, oid);
> @@ -877,6 +928,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>  				die(_("fsck error in packed object"));
>  			if (strict && fsck_walk(obj, NULL, &fsck_options))
>  				die(_("Not all child objects of %s are reachable"), oid_to_hex(&obj->oid));
> +			if (record_local_links)
> +				do_record_local_links(obj);
>  
>  			if (obj->type == OBJ_TREE) {
>  				struct tree *item = (struct tree *) obj;
> @@ -1719,6 +1772,57 @@ static void show_pack_info(int stat_only)
>  	free(chain_histogram);
>  }
>  
> +static void repack_local_links(void)
> +{
> +	struct child_process cmd = CHILD_PROCESS_INIT;
> +	FILE *out;
> +	struct strbuf line = STRBUF_INIT;
> +	struct oidset_iter iter;
> +	struct object_id *oid;
> +	char *base_name;
> +
> +	if (!oidset_size(&local_links))
> +		return;
> +
> +	base_name = mkpathdup("%s/pack/pack", repo_get_object_directory(the_repository));
> +
> +	strvec_push(&cmd.args, "pack-objects");
> +	strvec_push(&cmd.args, "--exclude-promisor-objects-best-effort");
> +	strvec_push(&cmd.args, base_name);
> +	cmd.git_cmd = 1;
> +	cmd.in = -1;
> +	cmd.out = -1;
> +	if (start_command(&cmd))
> +		die(_("could not start pack-objects to repack local links"));
> +
> +	oidset_iter_init(&local_links, &iter);
> +	while ((oid = oidset_iter_next(&iter))) {
> +		if (write_in_full(cmd.in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
> +		    write_in_full(cmd.in, "\n", 1) < 0)
> +			die(_("failed to feed local object to pack-objects"));
> +	}
> +	close(cmd.in);
> +
> +	out = xfdopen(cmd.out, "r");
> +	while (strbuf_getline_lf(&line, out) != EOF) {
> +		unsigned char binary[GIT_MAX_RAWSZ];
> +		if (line.len != the_hash_algo->hexsz ||
> +		    !hex_to_bytes(binary, line.buf, line.len))
> +			die(_("index-pack: Expecting full hex object ID lines only from pack-objects."));

I'm not sure why we check the pack-objects output here, is this just to
detect errors? Could we instead just check the exit status of
pack-objects, and discard the output?


> +
> +		/*
> +		 * pack-objects creates the .pack and .idx files, but not the
> +		 * .promisor file. Create the .promisor file, which is empty.
> +		 */
> +		write_special_file("promisor", "", NULL, binary, NULL);
> +	}
> +
> +	fclose(out);
> +	if (finish_command(&cmd))
> +		die(_("could not finish pack-objects to repack local links"));
> +	strbuf_release(&line);
> +}
> +
>  int cmd_index_pack(int argc,
>  		   const char **argv,
>  		   const char *prefix,
> @@ -1794,7 +1898,7 @@ int cmd_index_pack(int argc,
>  			} else if (skip_to_optional_arg(arg, "--keep", &keep_msg)) {
>  				; /* nothing to do */
>  			} else if (skip_to_optional_arg(arg, "--promisor", &promisor_msg)) {
> -				; /* already parsed */
> +				record_local_links = 1;
>  			} else if (starts_with(arg, "--threads=")) {
>  				char *end;
>  				nr_threads = strtoul(arg+10, &end, 0);
> @@ -1970,6 +2074,8 @@ int cmd_index_pack(int argc,
>  		free((void *) curr_index);
>  	free(curr_rev_index);
>  
> +	repack_local_links();
> +
>  	/*
>  	 * Let the caller know this pack is not self contained
>  	 */
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index e15fbaeb21..a565ab9b40 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4310,6 +4310,18 @@ static int option_parse_cruft_expiration(const struct option *opt UNUSED,
>  	return 0;
>  }
>  
> +static int should_include_obj(struct object *obj, void *data UNUSED)
> +{
> +	struct object_info info = OBJECT_INFO_INIT;
> +	if (oid_object_info_extended(the_repository, &obj->oid, &info, 0))
> +		BUG("should_include_obj should only be called on existing objects");
> +	return info.whence != OI_PACKED || !info.u.packed.pack->pack_promisor;
> +}
> +
> +static int should_include(struct commit *commit, void *data) {
> +	return should_include_obj((struct object *) commit, data);
> +}
> +

Nit: these two functions could be named a bit more descriptively.


>  int cmd_pack_objects(int argc,
>  		     const char **argv,
>  		     const char *prefix,
> @@ -4326,6 +4338,7 @@ int cmd_pack_objects(int argc,
>  	struct list_objects_filter_options filter_options =
>  		LIST_OBJECTS_FILTER_INIT;
>  	int exclude_promisor_objects = 0;
> +	int exclude_promisor_objects_best_effort = 0;
>  
>  	struct option pack_objects_options[] = {
>  		OPT_CALLBACK_F('q', "quiet", &progress, NULL,
> @@ -4423,6 +4436,9 @@ int cmd_pack_objects(int argc,
>  		  option_parse_missing_action),
>  		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
>  			 N_("do not pack objects in promisor packfiles")),
> +		OPT_BOOL(0, "exclude-promisor-objects-best-effort",
> +			 &exclude_promisor_objects_best_effort,
> +			 N_("implies --missing=allow-any")),
>  		OPT_BOOL(0, "delta-islands", &use_delta_islands,
>  			 N_("respect islands during delta compression")),
>  		OPT_STRING_LIST(0, "uri-protocol", &uri_protocols,
> @@ -4503,10 +4519,18 @@ int cmd_pack_objects(int argc,
>  		strvec_push(&rp, "--unpacked");
>  	}
>  
> +	if (exclude_promisor_objects && exclude_promisor_objects_best_effort)
> +		die(_("options '%s' and '%s' cannot be used together"),
> +		    "--exclude-promisor-objects", "--exclude-promisor-objects-best-effort");
>  	if (exclude_promisor_objects) {
>  		use_internal_rev_list = 1;
>  		fetch_if_missing = 0;
>  		strvec_push(&rp, "--exclude-promisor-objects");
> +	} else if (exclude_promisor_objects_best_effort) {
> +		use_internal_rev_list = 1;
> +		fetch_if_missing = 0;
> +		option_parse_missing_action(NULL, "allow-any", 0);
> +		/* revs configured below */
>  	}
>  	if (unpack_unreachable || keep_unreachable || pack_loose_unreachable)
>  		use_internal_rev_list = 1;
> @@ -4626,6 +4650,10 @@ int cmd_pack_objects(int argc,
>  
>  		repo_init_revisions(the_repository, &revs, NULL);
>  		list_objects_filter_copy(&revs.filter, &filter_options);
> +		if (exclude_promisor_objects_best_effort) {
> +			revs.include_check = should_include;
> +			revs.include_check_obj = should_include_obj;
> +		}
>  		get_object_list(&revs, rp.nr, rp.v);
>  		release_revisions(&revs);
>  	}
> diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
> index c53e93be2f..2e67f59f89 100755
> --- a/t/t5616-partial-clone.sh
> +++ b/t/t5616-partial-clone.sh
> @@ -694,6 +694,36 @@ test_expect_success 'lazy-fetch in submodule succeeds' '
>  	git -C client restore --recurse-submodules --source=HEAD^ :/
>  '
>  
> +test_expect_success 'after fetching descendants of non-promisor commits, gc works' '
> +	# Setup
> +	git init full &&
> +	git -C full config uploadpack.allowfilter 1 &&
> + 	git -C full config uploadpack.allowanysha1inwant 1 &&
> +	touch full/foo &&
> +	git -C full add foo &&
> +	git -C full commit -m "commit 1" &&
> +	git -C full checkout --detach &&
> +
> +	# Partial clone and push commit to remote
> +	git clone "file://$(pwd)/full" --filter=blob:none partial &&
> +	echo "hello" > partial/foo &&
> +	git -C partial commit -a -m "commit 2" &&
> +	git -C partial push &&
> +
> +	# gc in partial repo
> +	git -C partial gc --prune=now &&
> +
> +	# Create another commit in normal repo
> +	git -C full checkout main &&
> +	echo " world" >> full/foo &&
> +	git -C full commit -a -m "commit 3" &&
> +
> +	# Pull from remote in partial repo, and run gc again
> +	git -C partial pull &&
> +	git -C partial gc --prune=now
> +'
> +
> +
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd
>  
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
> 
