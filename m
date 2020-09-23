Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68776C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 10:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA922076E
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 10:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6PEMwZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIWKSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 06:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgIWKSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 06:18:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7927CC0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 03:18:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so20354238wrl.12
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yG39jS1hTRZPUBsaWKgfwQde4dpUfudIxzbNpri2K1E=;
        b=b6PEMwZj/AW9bSpLaEwZilWqVLaZux7d7AZEjzvRN3PyBccWpv12NOc31VLJOBxSiS
         BzugCrA+dYr2nIUR4ULTqh7+7TWKjf/Dgmqon0Syej8eEOB1qMLNLKVqNZWJE48RgGbp
         qY9k4qIQGUlg/W0ukFLbgRznXfDIEBdahSPVOAe5DMCNuSNVMJaq7cZyW+jImeQCsdO3
         Ph/a9Lw2RK5V0CKLNImoBnxs5QC82cc4ZJrxABQeEqhCpm0QijAWb/3b1oHB+iHhIYEP
         pNhr8S3Q/gEK+49NGGfdBxzfHiWzm4BjVp2O0GLPf1KJJN9MNqG4qgMR1uYtYRFsuyPa
         +t/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yG39jS1hTRZPUBsaWKgfwQde4dpUfudIxzbNpri2K1E=;
        b=JvOE1mn6VFshJBOuzkhNrC8eha5AzRfCPcZ7uBmTkGABBiAmKA5eQqgktoJmp3rXh1
         VNhQe0Hu91I4qxRV4uS0fPbdkJQmceEldg3r19vMJCx82pFPPnmUSScztWu3IbTtomwc
         01w2BnPsE4ewvIs2nFk3VxxIMPiVY4OU1zaksouj1lUppz8Eg5fk1QztmkP1EXFGb2GR
         3K/L+gnSf+H9zSDf68d+rgAtc7X29G4Yc6A8NuSCUXhe22WYClVXwJcN+nu7F0o/GT13
         Z0+5MOIC1f+a7N8QKB4RjCAcCqpoHJn7UGE+D2bEEy+rzy9Yp3kfTmbRWzpOxkHe6psV
         z8nw==
X-Gm-Message-State: AOAM530KC8lSSCKIRNKxxTK6Mclt7PjtlEWiL2a+npI2hshD8nKaHb4A
        h0H1yOWM6FJT3haMmIWXexNB4djrMhM=
X-Google-Smtp-Source: ABdhPJy4nd+0oq/99qTMBw2B3PMT6M5iN/Usv6Snnwg70es+co22yMgb1uEY4LHnLNqoPMMESoomNw==
X-Received: by 2002:adf:f58b:: with SMTP id f11mr2658wro.250.1600856325400;
        Wed, 23 Sep 2020 03:18:45 -0700 (PDT)
Received: from [192.168.1.201] (79.35.7.51.dyn.plus.net. [51.7.35.79])
        by smtp.googlemail.com with ESMTPSA id k8sm8652345wma.16.2020.09.23.03.18.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 03:18:44 -0700 (PDT)
Subject: Re: [PATCH v5 1/3] push: add reflog check for "--force-if-includes"
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>, git@vger.kernel.org
References: <20200919170316.5310-1-shrinidhi.kaushik@gmail.com>
 <20200923073022.61293-1-shrinidhi.kaushik@gmail.com>
 <20200923073022.61293-2-shrinidhi.kaushik@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3c254220-de10-8e17-1175-f88e790c17a6@gmail.com>
Date:   Wed, 23 Sep 2020 11:18:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923073022.61293-2-shrinidhi.kaushik@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi

I think this is moving forward in the right direction, I've got a couple 
of comments below. Note I've only looked at the first part of the patch 
as I'm not that familiar with the rest of the code.

On 23/09/2020 08:30, Srinidhi Kaushik wrote:
> Add a check to verify if the remote-tracking ref of the local branch
> is reachable from one of its "reflog" entries.
> 
> When a local branch that is based on a remote ref, has been rewound
> and is to be force pushed on the remote, "--force-if-includes" runs
> a check that ensures any updates to remote-tracking refs that may have

nit pick - there is only one remote tracking ref for each local ref

> happened (by push from another repository) in-between the time of the

s/push/fetch/ ?

> last checkout,

more generally it is the last time we updated the local branch to 
incorporate any fetched changes in the remote tracking branch, this 
includes `pull --rebase` `pull --merge` as well as checking out the 
remote ref

> and right before the time of push, have been integrated
> locally before allowing a forced updated.
> 
> A new field "use_force_if_includes" has been added to "push_cas_option",
> which is set to "1" when "--force-if-includes" is specified as an
> option in the command line or as a configuration setting.
> 
> The struct "ref" has two new bit-fields:
>    - check_reachable:
>      Set when we have to run the new check on the ref, and the remote
>      ref was marked as "use_tracking" or "use_tracking_for_rest" by
>      compare-and-swap (if the "the remote tip must be at the expected
>      commit" condition is not specified); "apply_push_cas()" has been
>      updated to check if this field is set and run the check.
> 
>    - unreachable:
>      Set if the ref is unreachable from any of the "reflog" entries of
>      its local counterpart.
> 
> "REF_STATUS_REJECT_REMOTE_UPDATED" has been added to the "status"
> enum to imply that the ref failed the check; "case" statements in
> "send-pack", "transport" and "transport-helper" have been updated
> accordingly to catch this status when set.

This is quite a long description of the implementation, I think it would 
be more helpful to the reader to concentrate on what the new feature is 
and why it is useful.

> 
> When "--force-is-includes" is used along with "--force-with-lease",

s/-is-/-if-/

> the check runs only for refs marked as "if_includes". If the option
> is passed without specifying "--force-with-lease", or specified along
> with "--force-with-lease=<refname>:<expect>" it is a "no-op".

If I've understood this correctly `--force-if-includes` does nothing on 
its own - I had hoped it would imply --force-with-lease

> 
> Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
> ---
>   builtin/send-pack.c |   5 ++
>   remote.c            | 140 +++++++++++++++++++++++++++++++++++++++++++-
>   remote.h            |   8 ++-
>   send-pack.c         |   1 +
>   transport-helper.c  |   5 ++
>   transport.c         |   6 ++
>   6 files changed, 162 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 2b9610f121..4d76727edb 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -69,6 +69,11 @@ static void print_helper_status(struct ref *ref)
>   			msg = "stale info";
>   			break;
>   
> +		case REF_STATUS_REJECT_REMOTE_UPDATED:
> +			res = "error";
> +			msg = "remote ref updated since checkout";
> +			break;
> +
>   		case REF_STATUS_REJECT_ALREADY_EXISTS:
>   			res = "error";
>   			msg = "already exists";
> diff --git a/remote.c b/remote.c
> index eafc14cbe7..0dcac4ab8e 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1471,12 +1471,23 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>   		 * with the remote-tracking branch to find the value
>   		 * to expect, but we did not have such a tracking
>   		 * branch.
> +		 *
> +		 * If the tip of the remote-tracking ref is unreachable
> +		 * from any reflog entry of its local ref indicating a
> +		 * possible update since checkout; reject the push.
>   		 */
>   		if (ref->expect_old_sha1) {
>   			if (!oideq(&ref->old_oid, &ref->old_oid_expect))
>   				reject_reason = REF_STATUS_REJECT_STALE;
> +			else if (ref->check_reachable && ref->unreachable)
> +				reject_reason =
> +					REF_STATUS_REJECT_REMOTE_UPDATED;
>   			else
> -				/* If the ref isn't stale then force the update. */
> +				/*
> +				 * If the ref isn't stale, and is reachable
> +				 * from from one of the reflog entries of
> +				 * the local branch, force the update.
> +				 */
>   				force_ref_update = 1;
>   		}
>   
> @@ -2268,6 +2279,118 @@ static int remote_tracking(struct remote *remote, const char *refname,
>   	return 0;
>   }
>   
> +/*
> + * The struct "reflog_commit_list" and related helper functions
> + * for list manipulation are used for collecting commits into a
> + * list during reflog traversals in "if_exists_or_grab_until()".
> + */
> +struct reflog_commit_list {
> +	struct commit **items;
> +	size_t nr, alloc;
> +};
> +
> +/* Adds a commit to list. */
> +static void add_commit(struct reflog_commit_list *list, struct commit *commit)
> +{
> +	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
> +	list->items[list->nr++] = commit;
> +}
> +
> +/* Free and reset the list. */
> +static void free_reflog_commit_list(struct reflog_commit_list *list)
> +{
> +	FREE_AND_NULL(list->items);
> +	list->nr = list->alloc = 0;
> +}
> +
> +struct check_and_collect_until_cb_data {
> +	struct commit *remote_commit;
> +	struct reflog_commit_list *local_commits;
> +};
> +
> +
> +static int check_and_collect_until(struct object_id *o_oid,
> +				   struct object_id *n_oid,
> +				   const char *ident, timestamp_t timestamp,
> +				   int tz, const char *message, void *cb_data)
> +{
> +	struct commit *commit;
> +	struct check_and_collect_until_cb_data *cb = cb_data;
> +
> +	/*
> +	 * If the reflog entry timestamp is older than the
> +	 * remote commit date, there is no need to check or
> +	 * collect entries older than this one.
> +	 */
> +	if (timestamp < cb->remote_commit->date)

It's great that you've incorporated a date check, however I think we 
need to check the local reflog timestamp against the last time the 
remote ref was updated (i.e. the remote reflog timestamp), not the 
commit date of the commit that the remote ref points too. We are 
interested in whether the local branch has incorporated the remote 
branch since the last time the remote branch was updated.

> +		return -1;
> +
> +	/* An entry was found. */
> +	if (oideq(n_oid, &cb->remote_commit->object.oid))
> +		return 1;
> +
> +	/* Lookup the commit and append it to the list. */
> +	if ((commit = lookup_commit_reference(the_repository, n_oid)))
> +		add_commit(cb->local_commits, commit);

I think Junio suggested batching the commits for the merge base check 
into small groups, rather than checking them all at once

Best Wishes

Phillip

> +
> +	return 0;
> +}
> +
> +/*
> + * Iterate through the reflog of a local ref to check if there is an entry for
> + * the given remote-tracking ref (i.e., if it was checked out); runs until the
> + * timestamp of an entry is older than the commit date of the remote-tracking
> + * ref. Any commits that seen along the way are collected into a list to check
> + * if the remote-tracking ref is reachable from any of them.
> + */
> +static int is_reachable_in_reflog(const char *local_ref_name,
> +				  const struct object_id *remote_oid)
> +{
> +	struct commit *remote_commit;
> +	struct reflog_commit_list list = { NULL, 0, 0 };
> +	struct check_and_collect_until_cb_data cb;
> +	int ret = 0;
> +
> +	remote_commit = lookup_commit_reference(the_repository, remote_oid);
> +	if (!remote_commit)
> +		goto cleanup_return;
> +
> +	cb.remote_commit = remote_commit;
> +	cb.local_commits = &list;
> +	ret = for_each_reflog_ent_reverse(local_ref_name,
> +					  check_and_collect_until, &cb);
> +
> +	/* We found an entry in the reflog. */
> +	if (ret > 0)
> +		goto cleanup_return;
> +
> +	/*
> +	 * Check if "remote_commit" is reachable from
> +	 * any of the commits in the collected list.
> +	 */
> +	if (list.nr > 0)
> +		ret = in_merge_bases_many(remote_commit, list.nr, list.items);
> +
> +cleanup_return:
> +	free_reflog_commit_list(&list);
> +	return ret;
> +}
> +
> +/*
> + * Check for reachability of a remote-tracking
> + * ref in the reflog entries of its local ref.
> + */
> +static void check_if_includes_upstream(struct ref *remote_ref)
> +{
> +	struct ref *local_ref = get_local_ref(remote_ref->name);
> +
> +	if (!local_ref)
> +		return;
> +
> +	if (!is_reachable_in_reflog(local_ref->name, &remote_ref->old_oid))
> +		remote_ref->unreachable = 1;
> +}
> +
>   static void apply_cas(struct push_cas_option *cas,
>   		      struct remote *remote,
>   		      struct ref *ref)
> @@ -2284,6 +2407,8 @@ static void apply_cas(struct push_cas_option *cas,
>   			oidcpy(&ref->old_oid_expect, &entry->expect);
>   		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
>   			oidclr(&ref->old_oid_expect);
> +		else
> +			ref->check_reachable = cas->use_force_if_includes;
>   		return;
>   	}
>   
> @@ -2294,6 +2419,8 @@ static void apply_cas(struct push_cas_option *cas,
>   	ref->expect_old_sha1 = 1;
>   	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
>   		oidclr(&ref->old_oid_expect);
> +	else
> +		ref->check_reachable = cas->use_force_if_includes;
>   }
>   
>   void apply_push_cas(struct push_cas_option *cas,
> @@ -2301,6 +2428,15 @@ void apply_push_cas(struct push_cas_option *cas,
>   		    struct ref *remote_refs)
>   {
>   	struct ref *ref;
> -	for (ref = remote_refs; ref; ref = ref->next)
> +	for (ref = remote_refs; ref; ref = ref->next) {
>   		apply_cas(cas, remote, ref);
> +
> +		/*
> +		 * If "compare-and-swap" is in "use_tracking[_for_rest]"
> +		 * mode, and if "--force-if-includes" was specified, run
> +		 * the check.
> +		 */
> +		if (ref->check_reachable)
> +			check_if_includes_upstream(ref);
> +	}
>   }
> diff --git a/remote.h b/remote.h
> index 5e3ea5a26d..7c5e59770e 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -104,7 +104,11 @@ struct ref {
>   		forced_update:1,
>   		expect_old_sha1:1,
>   		exact_oid:1,
> -		deletion:1;
> +		deletion:1,
> +		/* Need to check if local reflog reaches the remote tip. */
> +		check_reachable:1,
> +		/* The local reflog does not reach the remote tip. */
> +		unreachable:1;
>   
>   	enum {
>   		REF_NOT_MATCHED = 0, /* initial value */
> @@ -134,6 +138,7 @@ struct ref {
>   		REF_STATUS_REJECT_NEEDS_FORCE,
>   		REF_STATUS_REJECT_STALE,
>   		REF_STATUS_REJECT_SHALLOW,
> +		REF_STATUS_REJECT_REMOTE_UPDATED,
>   		REF_STATUS_UPTODATE,
>   		REF_STATUS_REMOTE_REJECT,
>   		REF_STATUS_EXPECTING_REPORT,
> @@ -332,6 +337,7 @@ struct ref *get_stale_heads(struct refspec *rs, struct ref *fetch_map);
>   
>   struct push_cas_option {
>   	unsigned use_tracking_for_rest:1;
> +	unsigned use_force_if_includes:1;
>   	struct push_cas {
>   		struct object_id expect;
>   		unsigned use_tracking:1;
> diff --git a/send-pack.c b/send-pack.c
> index 632f1580ca..956306e8e8 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -240,6 +240,7 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
>   	case REF_STATUS_REJECT_FETCH_FIRST:
>   	case REF_STATUS_REJECT_NEEDS_FORCE:
>   	case REF_STATUS_REJECT_STALE:
> +	case REF_STATUS_REJECT_REMOTE_UPDATED:
>   	case REF_STATUS_REJECT_NODELETE:
>   		return CHECK_REF_STATUS_REJECTED;
>   	case REF_STATUS_UPTODATE:
> diff --git a/transport-helper.c b/transport-helper.c
> index c52c99d829..e547e21199 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -779,6 +779,10 @@ static int push_update_ref_status(struct strbuf *buf,
>   			status = REF_STATUS_REJECT_STALE;
>   			FREE_AND_NULL(msg);
>   		}
> +		else if (!strcmp(msg, "remote ref updated since checkout")) {
> +			status = REF_STATUS_REJECT_REMOTE_UPDATED;
> +			FREE_AND_NULL(msg);
> +		}
>   		else if (!strcmp(msg, "forced update")) {
>   			forced = 1;
>   			FREE_AND_NULL(msg);
> @@ -897,6 +901,7 @@ static int push_refs_with_push(struct transport *transport,
>   		case REF_STATUS_REJECT_NONFASTFORWARD:
>   		case REF_STATUS_REJECT_STALE:
>   		case REF_STATUS_REJECT_ALREADY_EXISTS:
> +		case REF_STATUS_REJECT_REMOTE_UPDATED:
>   			if (atomic) {
>   				reject_atomic_push(remote_refs, mirror);
>   				string_list_clear(&cas_options, 0);
> diff --git a/transport.c b/transport.c
> index 43e24bf1e5..99fe6233a3 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -567,6 +567,11 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
>   		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
>   				 "stale info", porcelain, summary_width);
>   		break;
> +	case REF_STATUS_REJECT_REMOTE_UPDATED:
> +		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
> +				 "remote ref updated since checkout",
> +				 porcelain, summary_width);
> +		break;
>   	case REF_STATUS_REJECT_SHALLOW:
>   		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
>   				 "new shallow roots not allowed",
> @@ -1101,6 +1106,7 @@ static int run_pre_push_hook(struct transport *transport,
>   		if (!r->peer_ref) continue;
>   		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
>   		if (r->status == REF_STATUS_REJECT_STALE) continue;
> +		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
>   		if (r->status == REF_STATUS_UPTODATE) continue;
>   
>   		strbuf_reset(&buf);
> 

