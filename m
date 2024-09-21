Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD861137C37
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726926005; cv=none; b=PM15lkgJdWJzJF/wHE6sFfoRxRGi8hFm+f50MAqAECLMXbAwe02ToFh7Tfod636hzpfpSmf2Gk/Jtpt+k/JKN6kDs+CHw6Busuf3jroDy4mhoEY298DaMi+5Ozw8634cPXa6/x8SZZQAGpLG1fJZjbpvAvOW3H4tWjWpFwjFwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726926005; c=relaxed/simple;
	bh=c0Bk2XkCjfHM81abkUoPl+Q7hdcWYzUwXRi+5ImQc54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5AbusosXhNymUlm2VFr1yZrWJK3++BzutmmAEgcpXWXCFCrLt9b5l1z8cdVyxhMJJsCv39sS6S86IAxYn0p6Ion8n92fh3J2WjZkKAMwfs4tDIYMcQWILQyYcfaez9Er/wvlBOpXr5j/E7+RQK7w7mewPhVJ2EbODivS2DCYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ3r4JY5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ3r4JY5"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42ca4e0299eso23117605e9.2
        for <git@vger.kernel.org>; Sat, 21 Sep 2024 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726926002; x=1727530802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vtAG0axfDnALuEt+eX+vwU+fT1+STHNEP3HQNu+0AAI=;
        b=ZJ3r4JY50A0wTWY9zHiuUcIOt49dpglFSnrHNOEe101Zg6qm8ptWz1J/Q6XvGGKyfe
         CnZG8ylDTiZCOAQZ3cdEph7Ju+YhBi/ZvhTWuv4hFjI8h3iFPBCS7z7K7XyWkd3RdTTg
         HRXSpJEk5/PTe41G6m36fOTZBkrpoSU2nX2mmd5D8Eu3H4fWZ7inOPkF+iRgqt7+mSRP
         OGMtU1nNI5tLUNWW+7OdfVP+NiIjk+08aR8Yedemw4qh+2wplFEijzpN4KHjg0FAC+Se
         ISNhl/tknV2E074CP4LuSuzhvjWBXkqphp3odzJosq3ULzRnNt1/opuVrItXLJ1adt+G
         dEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726926002; x=1727530802;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtAG0axfDnALuEt+eX+vwU+fT1+STHNEP3HQNu+0AAI=;
        b=XieWhhJOaHsgTa/bF9jhdlQDB7iHp8W9nzSvjwX1HvsT+sMxCQsne5+oEBfR4aSK8D
         c9VOs+nCqtN0sLGxqm1i5u0B1bbpAgDttTolznUHwTrYHl4VKRMFt33A1t5YwT5TsW0z
         X34UFkpOGV6Yq8TsEEuOiCuwl0c14piWoR4lpkg7zmGMe31cLTd5ySrXK90JNqux/xJ2
         Yl8jCpX+mpgJp/fxLCMVNhE6ahWDe8jcTKXWU2kMwoMWfkM1JGQNQwB7fU3r5ti84q4D
         gppw65opKHEmJMSUKMqjclodJML556jOPB04UcgqIzpS4wndCTh3s8WVV8ozojXWWX3d
         DVYg==
X-Forwarded-Encrypted: i=1; AJvYcCXeHlng4uXM0n4OoCkTo1XbU7f1Fuf3gAs8TSw0p5adcXnsI18EUGmSZEAnllDf1aFFUWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlupicZuhjS05XhKJshnLZRR1M52ydOZvppwq9VWLuH3okfYch
	9ha2WDVzziPr5aPHRoEasiLHAsByFly1H+J/5FP6e9Evk66XJPW+
X-Google-Smtp-Source: AGHT+IHAKcQUwZB/EhrA1rCraENyE1c+driJqAi/YBkUlTBIbP1SoagdtzNwGljKS5sRKgccLiILHA==
X-Received: by 2002:a05:600c:358c:b0:42c:a580:71cf with SMTP id 5b1f17b1804b1-42e7c1a2f6dmr37209135e9.30.1726926001543;
        Sat, 21 Sep 2024 06:40:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ba:6501:244f:f1e2:145d:427a? ([2a0a:ef40:6ba:6501:244f:f1e2:145d:427a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450a95sm76671445e9.25.2024.09.21.06.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 06:40:00 -0700 (PDT)
Message-ID: <7fecc442-8d5e-4542-8ce8-907c35db870d@gmail.com>
Date: Sat, 21 Sep 2024 14:40:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] update_symref: add REF_CREATE_ONLY option
To: Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
 Patrick Steinhardt <ps@pks.im>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
 <20240919121335.298856-1-bence@ferdinandy.com>
 <20240919121335.298856-2-bence@ferdinandy.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20240919121335.298856-2-bence@ferdinandy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2024 13:13, Bence Ferdinandy wrote:
> Add a new REF_CREATE_ONLY flag for use by the files backend which will
> only update the symref if it doesn't already exist. Add the possibility
> to pass extra flags to refs_update_symref so that it can utilize this
> new flag.

I'm not sure we need a new flag to do this as it is already supported by
the ref transaction api.

	struct ref_transaction *t;
	struct strbuf err = STRBUF_INIT;
	struct ref_store refs = get_main_ref_store(the_repository);
	int ret = 0;

	t = ref_transaction_begin(refs, &err);
	if (!t ||
	    ref_transaction_create(t, b_head.buf, NULL, b_remote_head.buf,
				   REF_NO_DEREF, "fetch", &err) ||
	    ref_transaction_commit(t, &err))
		ret = error(_("%s", err.buf));

	ref_transaction_free(transaction);
	strbuf_release(&err);

	return ret;

Best Wishes

Phillip

> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> ---
> 
> Notes:
>      v3: new patch, passes all tests on it's own
> 
>   builtin/branch.c          |  2 +-
>   builtin/checkout.c        |  4 ++--
>   builtin/clone.c           |  6 +++---
>   builtin/notes.c           |  2 +-
>   builtin/remote.c          |  6 +++---
>   builtin/symbolic-ref.c    |  2 +-
>   builtin/worktree.c        |  2 +-
>   refs.c                    |  6 +++---
>   refs.h                    | 12 ++++++++++--
>   refs/files-backend.c      |  8 ++++++++
>   reset.c                   |  2 +-
>   sequencer.c               |  2 +-
>   setup.c                   |  2 +-
>   t/helper/test-ref-store.c |  2 +-
>   14 files changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index c98601c6fe..6025bca45e 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -559,7 +559,7 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
>   			continue;
>   
>   		refs = get_worktree_ref_store(worktrees[i]);
> -		if (refs_update_symref(refs, "HEAD", newref, logmsg))
> +		if (refs_update_symref(refs, "HEAD", newref, 0, logmsg))
>   			ret = error(_("HEAD of working tree %s is not updated"),
>   				    worktrees[i]->path);
>   	}
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 4cfe6fab50..23e28321d6 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1011,7 +1011,7 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>   			describe_detached_head(_("HEAD is now at"), new_branch_info->commit);
>   		}
>   	} else if (new_branch_info->path) {	/* Switch branches. */
> -		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", new_branch_info->path, msg.buf) < 0)
> +		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", new_branch_info->path, 0, msg.buf) < 0)
>   			die(_("unable to update HEAD"));
>   		if (!opts->quiet) {
>   			if (old_branch_info->path && !strcmp(new_branch_info->path, old_branch_info->path)) {
> @@ -1475,7 +1475,7 @@ static int switch_unborn_to_new_branch(const struct checkout_opts *opts)
>   		die(_("You are on a branch yet to be born"));
>   	strbuf_addf(&branch_ref, "refs/heads/%s", opts->new_branch);
>   	status = refs_update_symref(get_main_ref_store(the_repository),
> -				    "HEAD", branch_ref.buf, "checkout -b");
> +				    "HEAD", branch_ref.buf, 0, "checkout -b");
>   	strbuf_release(&branch_ref);
>   	if (!opts->quiet)
>   		fprintf(stderr, _("Switched to a new branch '%s'\n"),
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 269b6e18a4..43b7878a79 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -659,7 +659,7 @@ static void update_remote_refs(const struct ref *refs,
>   		strbuf_addstr(&head_ref, branch_top);
>   		strbuf_addstr(&head_ref, "HEAD");
>   		if (refs_update_symref(get_main_ref_store(the_repository), head_ref.buf,
> -				       remote_head_points_at->peer_ref->name,
> +				       remote_head_points_at->peer_ref->name, 0,
>   				       msg) < 0)
>   			die(_("unable to update %s"), head_ref.buf);
>   		strbuf_release(&head_ref);
> @@ -672,7 +672,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
>   	const char *head;
>   	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
>   		/* Local default branch link */
> -		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name, NULL) < 0)
> +		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", our->name, 0, NULL) < 0)
>   			die(_("unable to update HEAD"));
>   		if (!option_bare) {
>   			refs_update_ref(get_main_ref_store(the_repository),
> @@ -701,7 +701,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
>   		 * Unborn head from remote; same as "our" case above except
>   		 * that we have no ref to update.
>   		 */
> -		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", unborn, NULL) < 0)
> +		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", unborn, 0, NULL) < 0)
>   			die(_("unable to update HEAD"));
>   		if (!option_bare)
>   			install_branch_config(0, head, remote_name, unborn);
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 04f9dfb7fb..6b42d1139f 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -978,7 +978,7 @@ static int merge(int argc, const char **argv, const char *prefix)
>   			die(_("a notes merge into %s is already in-progress at %s"),
>   			    default_notes_ref(), wt->path);
>   		free_worktrees(worktrees);
> -		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", default_notes_ref(), NULL))
> +		if (refs_update_symref(get_main_ref_store(the_repository), "NOTES_MERGE_REF", default_notes_ref(), 0, NULL))
>   			die(_("failed to store link to current notes ref (%s)"),
>   			    default_notes_ref());
>   		fprintf(stderr, _("Automatic notes merge failed. Fix conflicts in %s "
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 0acc547d69..d28c65599d 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -243,7 +243,7 @@ static int add(int argc, const char **argv, const char *prefix)
>   		strbuf_reset(&buf2);
>   		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
>   
> -		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote add"))
> +		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, 0, "remote add"))
>   			result = error(_("Could not setup master '%s'"), master);
>   	}
>   
> @@ -863,7 +863,7 @@ static int mv(int argc, const char **argv, const char *prefix)
>   		strbuf_reset(&buf3);
>   		strbuf_addf(&buf3, "remote: renamed %s to %s",
>   				item->string, buf.buf);
> -		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, buf3.buf))
> +		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, 0, buf3.buf))
>   			die(_("creating '%s' failed"), buf.buf);
>   		display_progress(progress, ++refs_renamed_nr);
>   	}
> @@ -1443,7 +1443,7 @@ static int set_head(int argc, const char **argv, const char *prefix)
>   		/* make sure it's valid */
>   		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
>   			result |= error(_("Not a valid ref: %s"), buf2.buf);
> -		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
> +		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, 0, "remote set-head"))
>   			result |= error(_("Could not setup %s"), buf.buf);
>   		else if (opt_a)
>   			printf("%s/HEAD set to %s\n", argv[0], head_name);
> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
> index 81abdd170f..52de3e02af 100644
> --- a/builtin/symbolic-ref.c
> +++ b/builtin/symbolic-ref.c
> @@ -84,7 +84,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>   		if (check_refname_format(argv[1], REFNAME_ALLOW_ONELEVEL) < 0)
>   			die("Refusing to set '%s' to invalid ref '%s'", argv[0], argv[1]);
>   		ret = !!refs_update_symref(get_main_ref_store(the_repository),
> -					   argv[0], argv[1], msg);
> +					   argv[0], argv[1], 0, msg);
>   		break;
>   	default:
>   		usage_with_options(git_symbolic_ref_usage, options);
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 41e7f6a327..71434737e8 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -517,7 +517,7 @@ static int add_worktree(const char *path, const char *refname,
>   		ret = refs_update_ref(wt_refs, NULL, "HEAD", &commit->object.oid,
>   				      NULL, 0, UPDATE_REFS_MSG_ON_ERR);
>   	else
> -		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL);
> +		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, 0, NULL);
>   	if (ret)
>   		goto done;
>   
> diff --git a/refs.c b/refs.c
> index ceb72d4bd7..7afe46cadc 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2085,8 +2085,9 @@ int peel_iterated_oid(struct repository *r, const struct object_id *base, struct
>   	return peel_object(r, base, peeled) ? -1 : 0;
>   }
>   
> +
>   int refs_update_symref(struct ref_store *refs, const char *ref,
> -		       const char *target, const char *logmsg)
> +		       const char *target, const unsigned int extra_flags, const char *logmsg)
>   {
>   	struct ref_transaction *transaction;
>   	struct strbuf err = STRBUF_INIT;
> @@ -2095,7 +2096,7 @@ int refs_update_symref(struct ref_store *refs, const char *ref,
>   	transaction = ref_store_transaction_begin(refs, &err);
>   	if (!transaction ||
>   	    ref_transaction_update(transaction, ref, NULL, NULL,
> -				   target, NULL, REF_NO_DEREF,
> +				   target, NULL, REF_NO_DEREF | extra_flags,
>   				   logmsg, &err) ||
>   	    ref_transaction_commit(transaction, &err)) {
>   		ret = error("%s", err.buf);
> @@ -2920,4 +2921,3 @@ int ref_update_expects_existing_old_ref(struct ref_update *update)
>   	return (update->flags & REF_HAVE_OLD) &&
>   		(!is_null_oid(&update->old_oid) || update->old_target);
>   }
> -
> diff --git a/refs.h b/refs.h
> index f8b919a138..d907451d13 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -569,7 +569,7 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
>   		    const char *newref, const char *logmsg);
>   
>   int refs_update_symref(struct ref_store *refs, const char *refname,
> -		       const char *target, const char *logmsg);
> +		       const char *target, const unsigned int extra_flags, const char *logmsg);
>   
>   enum action_on_err {
>   	UPDATE_REFS_MSG_ON_ERR,
> @@ -672,13 +672,21 @@ struct ref_transaction *ref_store_transaction_begin(struct ref_store *refs,
>    */
>   #define REF_SKIP_CREATE_REFLOG (1 << 12)
>   
> +/*
> + * If the reference has already been created do not touch it.
> + */
> +
> +#define REF_CREATE_ONLY (1 << 13)
> +
> +
>   /*
>    * Bitmask of all of the flags that are allowed to be passed in to
>    * ref_transaction_update() and friends:
>    */
>   #define REF_TRANSACTION_UPDATE_ALLOWED_FLAGS                                  \
>   	(REF_NO_DEREF | REF_FORCE_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION | \
> -	 REF_SKIP_REFNAME_VERIFICATION | REF_SKIP_CREATE_REFLOG)
> +	 REF_SKIP_REFNAME_VERIFICATION | REF_SKIP_CREATE_REFLOG | \
> +	 REF_CREATE_ONLY)
>   
>   /*
>    * Add a reference update to transaction. `new_oid` is the value that
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index c7f3f4e591..1440b69b87 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2993,6 +2993,8 @@ static int files_transaction_finish(struct ref_store *ref_store,
>   		struct ref_update *update = transaction->updates[i];
>   		struct ref_lock *lock = update->backend_data;
>   
> +		if (update->flags & REF_CREATE_ONLY && refs_ref_exists(ref_store, update->refname))
> +			continue;
>   		if (update->flags & REF_NEEDS_COMMIT ||
>   		    update->flags & REF_LOG_ONLY) {
>   			if (parse_and_write_reflog(refs, update, lock, err)) {
> @@ -3031,6 +3033,8 @@ static int files_transaction_finish(struct ref_store *ref_store,
>   	 */
>   	for (i = 0; i < transaction->nr; i++) {
>   		struct ref_update *update = transaction->updates[i];
> +		if (update->flags & REF_CREATE_ONLY && refs_ref_exists(ref_store, update->refname))
> +			continue;
>   		if (update->flags & REF_DELETING &&
>   		    !(update->flags & REF_LOG_ONLY) &&
>   		    !(update->flags & REF_IS_PRUNING)) {
> @@ -3061,6 +3065,8 @@ static int files_transaction_finish(struct ref_store *ref_store,
>   	for (i = 0; i < transaction->nr; i++) {
>   		struct ref_update *update = transaction->updates[i];
>   		struct ref_lock *lock = update->backend_data;
> +		if (update->flags & REF_CREATE_ONLY && refs_ref_exists(ref_store, update->refname))
> +			continue;
>   
>   		if (update->flags & REF_DELETING &&
>   		    !(update->flags & REF_LOG_ONLY)) {
> @@ -3085,6 +3091,8 @@ static int files_transaction_finish(struct ref_store *ref_store,
>   
>   	for (i = 0; i < transaction->nr; i++) {
>   		struct ref_update *update = transaction->updates[i];
> +		if (update->flags & REF_CREATE_ONLY && refs_ref_exists(ref_store, update->refname))
> +			continue;
>   
>   		if (update->flags & REF_DELETED_RMDIR) {
>   			/*
> diff --git a/reset.c b/reset.c
> index b22b1be792..8dce5f2133 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -75,7 +75,7 @@ static int update_refs(const struct reset_head_opts *opts,
>   				      UPDATE_REFS_MSG_ON_ERR);
>   		if (!ret)
>   			ret = refs_update_symref(get_main_ref_store(the_repository),
> -						 "HEAD", switch_to_branch,
> +						 "HEAD", switch_to_branch, 0,
>   						 reflog_head);
>   	}
>   	if (!ret && run_hook)
> diff --git a/sequencer.c b/sequencer.c
> index 8d01cd50ac..924a78dab8 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5107,7 +5107,7 @@ static int pick_commits(struct repository *r,
>   			}
>   			msg = reflog_message(opts, "finish", "returning to %s",
>   				head_ref.buf);
> -			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, msg)) {
> +			if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", head_ref.buf, 0, msg)) {
>   				res = error(_("could not update HEAD to %s"),
>   					head_ref.buf);
>   				goto cleanup_head_ref;
> diff --git a/setup.c b/setup.c
> index 29f8673921..6a1fdef2c3 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -2169,7 +2169,7 @@ void create_reference_database(enum ref_storage_format ref_storage_format,
>   			die(_("invalid initial branch name: '%s'"),
>   			    initial_branch);
>   
> -		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref, NULL) < 0)
> +		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref, 0, NULL) < 0)
>   			exit(1);
>   		free(ref);
>   	}
> diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
> index 65346dee55..90af41edce 100644
> --- a/t/helper/test-ref-store.c
> +++ b/t/helper/test-ref-store.c
> @@ -120,7 +120,7 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
>   	const char *target = notnull(*argv++, "target");
>   	const char *logmsg = *argv++;
>   
> -	return refs_update_symref(refs, refname, target, logmsg);
> +	return refs_update_symref(refs, refname, target, 0, logmsg);
>   }
>   
>   static struct flag_definition transaction_flags[] = {
