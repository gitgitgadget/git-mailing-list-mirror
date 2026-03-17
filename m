Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4EC39D6D5
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773742314; cv=none; b=gopMWWLZfdh6i+w5OKmaALq/yAZrQzAUErqw4/Zmo8RnanSTHXjSB48b9IHo8upopjhs+6L//2dJVcFPrJqWMC0clHvZiKGxTvslLSHfF0LLIgI750S5BC7TZJkdbdP8rzN+QivIjv9bPJxPSSFuasXLvLcqVqkxNyZ2ddkZ1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773742314; c=relaxed/simple;
	bh=9C13p8G3B8/0b6rk8MjZAZnAEwzyegTuMa8/dFLMkl4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LbjJbotpcrKX3RhmvCI/rN8kY1q6SQqB19RmXoDbr1b9F4y/VFgwqzpWoa/fqTlHlfAnfVCraiWdEJOJWhxz3lNAh3lgnVckakSSQegH93dKo66K1LFtL2fLxzzFNL8SQAdAnYOMOffBI9BzUGUDr7Q5Pff/KiH4yJWO+ZiDZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf2SbIcR; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf2SbIcR"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b41b545d9so2739086f8f.2
        for <git@vger.kernel.org>; Tue, 17 Mar 2026 03:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773742307; x=1774347107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SI3jy3EyXqi/YyA0svo3egVMxcNjJu3wqvB3m9Z51Z4=;
        b=Bf2SbIcRWQ2yXk1h+Q5UNv34rTxug1kjyAuYKXOHlWFw2DLndIWmUvQlh4SgCamwFz
         o9awXwHNhUtAzWrJxNX241AmvQXhIQLcd41xqodUYZ/XjlusuXjdnR8pvpEFwsMH/K5G
         echnT8Ef5vJyD2ihgRr7BDVtwsZbTQxZYLv0y5Ab/fgh5KDagOiyVoT6l3DtS/Bc4osn
         cFd+ENTicdvdxCk2Wc2M6klNbTUCqmH8HuKLB25EeUAh73gwL1hFHlNVBZ/49ggEalt4
         JBQQTRhuiUO4PVb2LoSLOj8tONfmpP9gMWTL5VcPxEVGuPN2OzFrpNo8OW3fxJx9JhWp
         B9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773742307; x=1774347107;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI3jy3EyXqi/YyA0svo3egVMxcNjJu3wqvB3m9Z51Z4=;
        b=KXvy199jTurepaep8srgNk8ooMEAXi2L05QQDFXFmaE80WT5Qv1aO2GNrklV8uMjp5
         jKnEQNpX7Q1Exa+2nLgEoCSCy89qFeVeCtaPGLwABStRZMroy8ROqA7iKivD6P7aJMCM
         LOVtK25R+aFD+8s0PuA1s3PqCOuWJ6uOjh998TJ6isqIxo47B2WZ5N4m1HK5E688agMk
         J5jU5+4JSjEzbTcwKqDzWw1AXOlDWIdc0qHF2jsM0AeduFNAmg3qNPmIl55tyyP0hrKf
         7OHsRPPc92eVa4/f31jlonSgCqnhLRoWeOdi6ygWd0QNMb2zLJAgudUzTIcfXupRR3Ne
         oAcw==
X-Forwarded-Encrypted: i=1; AJvYcCU0BX6Hf6a+xKIBWalmSMuf79S/M/w7BE2ul1c7mZDxZZwGvGpON9B9JwejTGHhazHVLLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6h6DdcNlYFB8VlVPJPz/wxQPF8NAiIE2uD8vNkm300A8mqLzp
	W45/g919ytgcvR5YlJeR3kq13UaG1Tqf/uMqRGcJVyve68I4OyKfG2ti
X-Gm-Gg: ATEYQzwpBgi6wDuQ/AdsTsIKPrccQ5YD0ZCnhQKfabjoLbVQIv3OY7C1XcdMCoXNXFv
	co2m/hZbwcmigftOT7yTfxr9kVn3LT41zprc1UvG+doE33R8WdP6L8D/IQXgwySpVPOXP3ycmt+
	1fKX/zUPQ6M5lyKyZLj2MNwsptGBAaB3DYn8vaTXblzpw4M2aDLF5TE/UHFFBVGEwVug7bvAMse
	hWTjtT9hx/PUAtcoHIXdjc6RqcWZwLfCgVgJPWDIJxzWbFSpJgEELSNRgg0o12LUXQ/7FW3TM2i
	DXucEE8NmMFKOqProE8AuXUeu9KL2geZlqoGfLcYBEgCULNAYgUVVnvlWa/pdvzjNCKo+iTXA19
	wmHsbLnbzXf7h4G/YEstxgzbADVzc719PAaqJhO00slvcquOnE9VH1romECDHYy97r8n+8nzJvL
	f7lm9YAAI34WPW6GhTO2rNu8QgUdDOCCVihY2fmoX3Wb9zKswEjYbFPs6bIkFQxNufMccYEtDj/
	PvPvA==
X-Received: by 2002:a05:6000:2501:b0:439:ba4d:bf40 with SMTP id ffacd0b85a97d-43a04dc831fmr30732213f8f.43.1773742306958;
        Tue, 17 Mar 2026 03:11:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe22529csm49759500f8f.31.2026.03.17.03.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 03:11:46 -0700 (PDT)
Message-ID: <dd4aeb75-c4db-4feb-8075-e65d15bd04d3@gmail.com>
Date: Tue, 17 Mar 2026 10:11:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] replay: add --revert mode to reverse commit
 changes
To: Toon Claes <toon@iotcl.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, karthik.188@gmail.com, johannes.schindelin@gmx.de
References: <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260313054035.26605-1-siddharthasthana31@gmail.com>
 <20260313054035.26605-3-siddharthasthana31@gmail.com>
 <87ms07sgaq.fsf@iotcl.com>
Content-Language: en-US
In-Reply-To: <87ms07sgaq.fsf@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/03/2026 19:52, Toon Claes wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
> 
>> @@ -144,11 +155,14 @@ int cmd_replay(int argc,
>>   	 * Detect and warn if we override some user specified rev
>>   	 * walking options.
>>   	 */
>> -	if (revs.reverse != 1) {
>> -		warning(_("some rev walking options will be overridden as "
>> -			  "'%s' bit in 'struct rev_info' will be forced"),
>> -			"reverse");
>> -		revs.reverse = 1;
>> +	{
> 
> Do we want to keep these braces?

That's a good point which I think is worth a re-roll. It would be better 
to move the declaration of "desired_reverse" up so that we have

	int desired_reverse = !opts.revert;
	...
	revs.reverse = desired_reverse
	...
	if (revs.reverse != desired_reverse)
		warning(...);

That way we know we are using the same expected value for revs.reverse 
when we set it and when we check it hasn't changed later.

Thanks

Phillip

>> +		int desired_reverse = opts.revert ? 0 : 1;
>> +		if (revs.reverse != desired_reverse) {
>> +			warning(_("some rev walking options will be overridden as "
>> +				  "'%s' bit in 'struct rev_info' will be forced"),
>> +				"reverse");
>> +			revs.reverse = desired_reverse;
>> +		}
>>   	}
>>   	if (revs.sort_order != REV_SORT_IN_GRAPH_ORDER) {
>>   		warning(_("some rev walking options will be overridden as "
>> @@ -174,7 +188,9 @@ int cmd_replay(int argc,
>>   		goto cleanup;
>>   
>>   	/* Build reflog message */
>> -	if (opts.advance) {
>> +	if (opts.revert) {
>> +		strbuf_addf(&reflog_msg, "replay --revert %s", opts.revert);
>> +	} else if (opts.advance) {
>>   		strbuf_addf(&reflog_msg, "replay --advance %s", opts.advance);
>>   	} else {
>>   		struct object_id oid;
>> diff --git a/replay.c b/replay.c
>> index a63f6714c4..199066f6b3 100644
>> --- a/replay.c
>> +++ b/replay.c
>> @@ -8,14 +8,14 @@
>>   #include "refs.h"
>>   #include "replay.h"
>>   #include "revision.h"
>> +#include "sequencer.h"
>>   #include "strmap.h"
>>   #include "tree.h"
>>   
>> -/*
>> - * We technically need USE_THE_REPOSITORY_VARIABLE for DEFAULT_ABBREV, but
>> - * do not want to use the_repository.
>> - */
>> -#define the_repository DO_NOT_USE_THE_REPOSITORY
> 
> Why are you removing this? We're still setting
> USE_THE_REPOSITORY_VARIABLE, and not using 'the_repository' in this file?
> 
>> +enum replay_mode {
>> +	REPLAY_MODE_PICK,
>> +	REPLAY_MODE_REVERT,
>> +};
>>   
>>   static const char *short_commit_name(struct repository *repo,
>>   				     struct commit *commit)
>> @@ -50,15 +50,37 @@ static char *get_author(const char *message)
>>   	return NULL;
>>   }
>>   
>> +static void generate_revert_message(struct strbuf *msg,
>> +				    struct commit *commit,
>> +				    struct repository *repo)
>> +{
>> +	const char *out_enc = get_commit_output_encoding();
>> +	const char *message = repo_logmsg_reencode(repo, commit, NULL, out_enc);
>> +	const char *subject_start;
>> +	int subject_len;
>> +	char *subject;
>> +
>> +	subject_len = find_commit_subject(message, &subject_start);
>> +	subject = xmemdupz(subject_start, subject_len);
>> +
>> +	sequencer_format_revert_message(repo, subject, commit,
>> +					commit->parents ? commit->parents->item : NULL,
>> +					false, msg);
>> +
>> +	free(subject);
>> +	repo_unuse_commit_buffer(repo, commit, message);
>> +}
>> +
>>   static struct commit *create_commit(struct repository *repo,
>>   				    struct tree *tree,
>>   				    struct commit *based_on,
>> -				    struct commit *parent)
>> +				    struct commit *parent,
>> +				    enum replay_mode mode)
>>   {
>>   	struct object_id ret;
>>   	struct object *obj = NULL;
>>   	struct commit_list *parents = NULL;
>> -	char *author;
>> +	char *author = NULL;
>>   	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
>>   	struct commit_extra_header *extra = NULL;
>>   	struct strbuf msg = STRBUF_INIT;
>> @@ -70,9 +92,16 @@ static struct commit *create_commit(struct repository *repo,
>>   
>>   	commit_list_insert(parent, &parents);
>>   	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
>> -	find_commit_subject(message, &orig_message);
>> -	strbuf_addstr(&msg, orig_message);
>> -	author = get_author(message);
>> +	if (mode == REPLAY_MODE_REVERT) {
>> +		generate_revert_message(&msg, based_on, repo);
>> +		/* For revert, use current user as author (NULL = use default) */
>> +	} else if (mode == REPLAY_MODE_PICK) {
>> +		find_commit_subject(message, &orig_message);
>> +		strbuf_addstr(&msg, orig_message);
>> +		author = get_author(message);
>> +	} else {
>> +		BUG("unexpected replay mode %d", mode);
>> +	}
>>   	reset_ident_date();
>>   	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
>>   				 &ret, author, NULL, sign_commit, extra)) {
>> @@ -153,11 +182,35 @@ static void get_ref_information(struct repository *repo,
>>   	}
>>   }
>>   
>> +static void set_up_branch_mode(struct repository *repo,
>> +			       char **branch_name,
>> +			       const char *option_name,
>> +			       struct ref_info *rinfo,
>> +			       struct commit **onto)
>> +{
>> +	struct object_id oid;
>> +	char *fullname = NULL;
>> +
>> +	if (repo_dwim_ref(repo, *branch_name, strlen(*branch_name),
>> +			  &oid, &fullname, 0) == 1) {
>> +		free(*branch_name);
>> +		*branch_name = fullname;
>> +	} else {
>> +		die(_("argument to %s must be a reference"), option_name);
>> +	}
>> +	*onto = peel_committish(repo, *branch_name, option_name);
>> +	if (rinfo->positive_refexprs > 1)
>> +		die(_("'%s' cannot be used with multiple revision ranges "
>> +		      "because the ordering would be ill-defined"),
>> +		    option_name);
>> +}
>> +
>>   static void set_up_replay_mode(struct repository *repo,
>>   			       struct rev_cmdline_info *cmd_info,
>>   			       const char *onto_name,
>>   			       bool *detached_head,
>>   			       char **advance_name,
>> +			       char **revert_name,
>>   			       struct commit **onto,
>>   			       struct strset **update_refs)
>>   {
>> @@ -172,9 +225,6 @@ static void set_up_replay_mode(struct repository *repo,
>>   	if (!rinfo.positive_refexprs)
>>   		die(_("need some commits to replay"));
>>   
>> -	if (!onto_name == !*advance_name)
>> -		BUG("one and only one of onto_name and *advance_name must be given");
>> -
>>   	if (onto_name) {
>>   		*onto = peel_committish(repo, onto_name, "--onto");
>>   		if (rinfo.positive_refexprs <
>> @@ -183,23 +233,12 @@ static void set_up_replay_mode(struct repository *repo,
>>   		*update_refs = xcalloc(1, sizeof(**update_refs));
>>   		**update_refs = rinfo.positive_refs;
>>   		memset(&rinfo.positive_refs, 0, sizeof(**update_refs));
>> +	} else if (*advance_name) {
>> +		set_up_branch_mode(repo, advance_name, "--advance", &rinfo, onto);
>> +	} else if (*revert_name) {
>> +		set_up_branch_mode(repo, revert_name, "--revert", &rinfo, onto);
>>   	} else {
>> -		struct object_id oid;
>> -		char *fullname = NULL;
>> -
>> -		if (!*advance_name)
>> -			BUG("expected either onto_name or *advance_name in this function");
>> -
>> -		if (repo_dwim_ref(repo, *advance_name, strlen(*advance_name),
>> -			     &oid, &fullname, 0) == 1) {
>> -			free(*advance_name);
>> -			*advance_name = fullname;
>> -		} else {
>> -			die(_("argument to --advance must be a reference"));
>> -		}
>> -		*onto = peel_committish(repo, *advance_name, "--advance");
>> -		if (rinfo.positive_refexprs > 1)
>> -			die(_("cannot advance target with multiple sources because ordering would be ill-defined"));
>> +		BUG("expected one of onto_name, *advance_name, or *revert_name");
>>   	}
>>   	strset_clear(&rinfo.negative_refs);
>>   	strset_clear(&rinfo.positive_refs);
>> @@ -220,7 +259,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
>>   					  kh_oid_map_t *replayed_commits,
>>   					  struct commit *onto,
>>   					  struct merge_options *merge_opt,
>> -					  struct merge_result *result)
>> +					  struct merge_result *result,
>> +					  enum replay_mode mode)
>>   {
>>   	struct commit *base, *replayed_base;
>>   	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
>> @@ -232,25 +272,45 @@ static struct commit *pick_regular_commit(struct repository *repo,
>>   	pickme_tree = repo_get_commit_tree(repo, pickme);
>>   	base_tree = repo_get_commit_tree(repo, base);
>>   
>> -	merge_opt->branch1 = short_commit_name(repo, replayed_base);
>> -	merge_opt->branch2 = short_commit_name(repo, pickme);
>> -	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
>> -
>> -	merge_incore_nonrecursive(merge_opt,
>> -				  base_tree,
>> -				  replayed_base_tree,
>> -				  pickme_tree,
>> -				  result);
>> -
>> -	free((char*)merge_opt->ancestor);
>> +	if (mode == REPLAY_MODE_PICK) {
>> +		/* Cherry-pick: normal order */
>> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
>> +		merge_opt->branch2 = short_commit_name(repo, pickme);
>> +		merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
>> +
>> +		merge_incore_nonrecursive(merge_opt,
>> +					  base_tree,
>> +					  replayed_base_tree,
>> +					  pickme_tree,
>> +					  result);
>> +
>> +		free((char *)merge_opt->ancestor);
>> +	} else if (mode == REPLAY_MODE_REVERT) {
>> +		/* Revert: swap base and pickme to reverse the diff */
>> +		const char *pickme_name = short_commit_name(repo, pickme);
>> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
>> +		merge_opt->branch2 = xstrfmt("parent of %s", pickme_name);
>> +		merge_opt->ancestor = pickme_name;
>> +
>> +		merge_incore_nonrecursive(merge_opt,
>> +					  pickme_tree,
>> +					  replayed_base_tree,
>> +					  base_tree,
>> +					  result);
>> +
>> +		free((char *)merge_opt->branch2);
>> +	} else {
>> +		BUG("unexpected replay mode %d", mode);
>> +	}
>>   	merge_opt->ancestor = NULL;
>> +	merge_opt->branch2 = NULL;
> 
> It took me a while to understand the ownership of these buffers,
> especially those returned by short_commit_name(). But it seems to call
> repo_find_unique_abbrev() which has 4 buffers which it cycles through.
> 
> So this seems to be okay (this was also not changed in the MODE_PICK
> path.
> 
>>   	if (!result->clean)
>>   		return NULL;
>>   	/* Drop commits that become empty */
>>   	if (oideq(&replayed_base_tree->object.oid, &result->tree->object.oid) &&
>>   	    !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
>>   		return replayed_base;
>> -	return create_commit(repo, result->tree, pickme, replayed_base);
>> +	return create_commit(repo, result->tree, pickme, replayed_base, mode);
>>   }
>>   
>>   void replay_result_release(struct replay_result *result)
>> @@ -287,11 +347,16 @@ int replay_revisions(struct rev_info *revs,
>>   	};
>>   	bool detached_head;
>>   	char *advance;
>> +	char *revert;
>> +	enum replay_mode mode = REPLAY_MODE_PICK;
>>   	int ret;
>>   
>>   	advance = xstrdup_or_null(opts->advance);
>> +	revert = xstrdup_or_null(opts->revert);
>> +	if (revert)
>> +		mode = REPLAY_MODE_REVERT;
>>   	set_up_replay_mode(revs->repo, &revs->cmdline, opts->onto,
>> -			   &detached_head, &advance, &onto, &update_refs);
>> +			   &detached_head, &advance, &revert, &onto, &update_refs);
>>   
>>   	/* FIXME: Should allow replaying commits with the first as a root commit */
>>   
>> @@ -315,7 +380,8 @@ int replay_revisions(struct rev_info *revs,
>>   			die(_("replaying merge commits is not supported yet!"));
>>   
>>   		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
>> -						  onto, &merge_opt, &result);
>> +						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
>> +						  &merge_opt, &result, mode);
>>   		if (!last_commit)
>>   			break;
>>   
>> @@ -327,7 +393,7 @@ int replay_revisions(struct rev_info *revs,
>>   		kh_value(replayed_commits, pos) = last_commit;
>>   
>>   		/* Update any necessary branches */
>> -		if (advance)
>> +		if (advance || revert)
>>   			continue;
>>   
>>   		for (decoration = get_name_decoration(&commit->object);
>> @@ -361,11 +427,13 @@ int replay_revisions(struct rev_info *revs,
>>   		goto out;
>>   	}
>>   
>> -	/* In --advance mode, advance the target ref */
>> -	if (advance)
>> -		replay_result_queue_update(out, advance,
>> +	/* In --advance or --revert mode, update the target ref */
>> +	if (advance || revert) {
>> +		const char *ref = advance ? advance : revert;
>> +		replay_result_queue_update(out, ref,
>>   					   &onto->object.oid,
>>   					   &last_commit->object.oid);
>> +	}
>>   
>>   	ret = 0;
>>   
>> @@ -377,5 +445,6 @@ int replay_revisions(struct rev_info *revs,
>>   	kh_destroy_oid_map(replayed_commits);
>>   	merge_finalize(&merge_opt, &result);
>>   	free(advance);
>> +	free(revert);
>>   	return ret;
>>   }
>> diff --git a/replay.h b/replay.h
>> index d8407dc7f7..e916a5f975 100644
>> --- a/replay.h
>> +++ b/replay.h
>> @@ -13,7 +13,7 @@ struct replay_revisions_options {
>>   	/*
>>   	 * Starting point at which to create the new commits; must be a branch
>>   	 * name. The branch will be updated to point to the rewritten commits.
>> -	 * This option is mutually exclusive with `onto`.
>> +	 * This option is mutually exclusive with `onto` and `revert`.
>>   	 */
>>   	const char *advance;
>>   
>> @@ -22,7 +22,14 @@ struct replay_revisions_options {
>>   	 * committish. References pointing at decendants of `onto` will be
>>   	 * updated to point to the new commits.
>>   	 */
>> -	 const char *onto;
>> +	const char *onto;
>> +
>> +	/*
>> +	 * Starting point at which to create revert commits; must be a branch
>> +	 * name. The branch will be updated to point to the revert commits.
>> +	 * This option is mutually exclusive with `onto` and `advance`.
>> +	 */
>> +	const char *revert;
>>   
>>   	/*
>>   	 * Update branches that point at commits in the given revision range.
>> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>> index a03f8f9293..0c1e03e0fb 100755
>> --- a/t/t3650-replay-basics.sh
>> +++ b/t/t3650-replay-basics.sh
>> @@ -74,8 +74,8 @@ test_expect_success '--onto with invalid commit-ish' '
>>   	test_cmp expect actual
>>   '
>>   
>> -test_expect_success 'option --onto or --advance is mandatory' '
>> -	echo "error: option --onto or --advance is mandatory" >expect &&
>> +test_expect_success 'exactly one of --onto, --advance, or --revert is required' '
>> +	echo "error: exactly one of --onto, --advance, or --revert is required" >expect &&
>>   	test_might_fail git replay -h >>expect &&
>>   	test_must_fail git replay topic1..topic2 2>actual &&
>>   	test_cmp expect actual
>> @@ -87,16 +87,17 @@ test_expect_success 'no base or negative ref gives no-replaying down to root err
>>   	test_cmp expect actual
>>   '
>>   
>> -test_expect_success 'options --advance and --contained cannot be used together' '
>> -	printf "fatal: options ${SQ}--advance${SQ} " >expect &&
>> -	printf "and ${SQ}--contained${SQ} cannot be used together\n" >>expect &&
>> +test_expect_success '--contained requires --onto' '
>> +	echo "fatal: --contained requires --onto" >expect &&
>>   	test_must_fail git replay --advance=main --contained \
>>   		topic1..topic2 2>actual &&
>>   	test_cmp expect actual
>>   '
>>   
>>   test_expect_success 'cannot advance target ... ordering would be ill-defined' '
>> -	echo "fatal: cannot advance target with multiple sources because ordering would be ill-defined" >expect &&
>> +	cat >expect <<-\EOF &&
>> +	fatal: '"'"'--advance'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined
>> +	EOF
>>   	test_must_fail git replay --advance=main main topic1 topic2 2>actual &&
>>   	test_cmp expect actual
>>   '
>> @@ -398,4 +399,105 @@ test_expect_success 'invalid replay.refAction value' '
>>   	test_grep "invalid.*replay.refAction.*value" error
>>   '
>>   
>> +test_expect_success 'argument to --revert must be a reference' '
>> +	echo "fatal: argument to --revert must be a reference" >expect &&
>> +	oid=$(git rev-parse main) &&
>> +	test_must_fail git replay --revert=$oid topic1..topic2 2>actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'cannot revert with multiple sources' '
>> +	cat >expect <<-\EOF &&
>> +	fatal: '"'"'--revert'"'"' cannot be used with multiple revision ranges because the ordering would be ill-defined
>> +	EOF
>> +	test_must_fail git replay --revert main main topic1 topic2 2>actual &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'using replay --revert to revert commits' '
>> +	# Reuse existing topic4 branch (has commits I and J on top of main)
>> +	START=$(git rev-parse topic4) &&
>> +	test_when_finished "git branch -f topic4 $START" &&
>> +
>> +	# Revert commits I and J
>> +	git replay --revert topic4 topic4~2..topic4 &&
>> +
>> +	# Verify the revert commits were created (newest-first ordering
>> +	# means J is reverted first, then I on top)
>> +	git log --format=%s -4 topic4 >actual &&
>> +	cat >expect <<-\EOF &&
>> +	Revert "I"
>> +	Revert "J"
>> +	J
>> +	I
>> +	EOF
>> +	test_cmp expect actual &&
>> +
>> +	# Verify commit message format includes hash (tip is Revert "I")
>> +	test_commit_message topic4 <<-EOF &&
>> +	Revert "I"
>> +
>> +	This reverts commit $(git rev-parse I).
>> +	EOF
>> +
>> +	# Verify reflog message
>> +	git reflog topic4 -1 --format=%gs >reflog-msg &&
>> +	echo "replay --revert topic4" >expect-reflog &&
>> +	test_cmp expect-reflog reflog-msg
>> +'
>> +
>> +test_expect_success 'using replay --revert in bare repo' '
>> +	# Reuse existing topic4 in bare repo
>> +	START=$(git -C bare rev-parse topic4) &&
>> +	test_when_finished "git -C bare update-ref refs/heads/topic4 $START" &&
>> +
>> +	# Revert commit J in bare repo
>> +	git -C bare replay --revert topic4 topic4~1..topic4 &&
>> +
>> +	# Verify revert was created
>> +	git -C bare log -1 --format=%s topic4 >actual &&
>> +	echo "Revert \"J\"" >expect &&
>> +	test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'revert of revert uses Reapply' '
>> +	# Use topic4 and first revert J, then revert the revert
>> +	START=$(git rev-parse topic4) &&
>> +	test_when_finished "git branch -f topic4 $START" &&
>> +
>> +	# First revert J
>> +	git replay --revert topic4 topic4~1..topic4 &&
>> +	REVERT_J=$(git rev-parse topic4) &&
>> +
>> +	# Now revert the revert - should become Reapply
>> +	git replay --revert topic4 topic4~1..topic4 &&
>> +
>> +	# Verify Reapply prefix and message format
>> +	test_commit_message topic4 <<-EOF
>> +	Reapply "J"
>> +
>> +	This reverts commit $REVERT_J.
>> +	EOF
>> +'
>> +
>> +test_expect_success 'git replay --revert with conflict' '
>> +	# conflict branch has C.conflict which conflicts with topic1s C
>> +	test_expect_code 1 git replay --revert conflict B..topic1
>> +'
>> +
>> +test_expect_success 'git replay --revert incompatible with --contained' '
>> +	test_must_fail git replay --revert topic4 --contained topic4~1..topic4 2>error &&
>> +	test_grep "requires --onto" error
>> +'
>> +
>> +test_expect_success 'git replay --revert incompatible with --onto' '
>> +	test_must_fail git replay --revert topic4 --onto main topic4~1..topic4 2>error &&
>> +	test_grep "cannot be used together" error
>> +'
>> +
>> +test_expect_success 'git replay --revert incompatible with --advance' '
>> +	test_must_fail git replay --revert topic4 --advance main topic4~1..topic4 2>error &&
>> +	test_grep "cannot be used together" error
>> +'
>> +
>>   test_done
>> -- 
>> 2.51.0
>>
>>
> 

