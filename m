Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661F4284889
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396866; cv=none; b=k18XDMRVMMLjmHhq65x3+Pt+UfSAilNTpjNL94CBAwq1ZT3IkhMlLPzRIayHkHz0IU97JuCEZeHltMEz3kwGMvxHklo+K1AbuDMz2WjCxeVHvrxxOB1OFoQqRqHm1jj4NZh/9TB4+vL0QJa75AMj4wrNGws9i2zFercfoYmvWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396866; c=relaxed/simple;
	bh=MfcmBLHZMFArrtiEVLRKtxAG7MWwjh8C8Oz7qDdoaBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RK49FjOc3kBFHCZz3gGl8ip08tBMWIJx35UPGh2Kk3cr5mHgYjVje74YcidiieryR062MyxQROyJXJE3S5YCPPEu2IWNIgr9NU88i/W7sDZs9AaUEl+eiIfZY2wfyQ9NCGfbUZVnTcphb+ZXqBC4iotKvq07Ih8/o5jvsJlIGeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f85k3X9P; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f85k3X9P"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47796a837c7so14294025e9.0
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 08:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763396862; x=1764001662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VLJ4s5XbUj31zNJ689BnubsOB1t5NeIjX8Y8vO5rQ6c=;
        b=f85k3X9Pti1tf1waM8cG3d7rlVx9BpNz06zLuw/U6vfCVQYfSGlqfBmXAxSiXrwzgC
         nTTCP1t69lOsFjQowProbILos5UjXCh5ZxHRSeCgoPaoRy+BwcJWeAvOYwHgJ6lmitj5
         6DDXXKgZhlOxRWBcW/XLJ+D7WrkiDZnuypb3aajoWNKtETCgYCWb/MuZtbV6RzQH8G3i
         qSKEbTlkZT0A6p4SRZE4DCFNOw9Hjz0+5pdDGuQQAKl6jaojNOQ+Ma2PR0jhkwMoIvgU
         JS3T1upksnWlpomvi0A9uRfZfEH7LvPvhb0pF4tOWoUwtAQLcFKxyp4bRp3VND/LoTFK
         iVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763396862; x=1764001662;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLJ4s5XbUj31zNJ689BnubsOB1t5NeIjX8Y8vO5rQ6c=;
        b=PnBKTJsVX9JwkSO2tY6qsZQVUJGNJwT8r6S3CPUz0+/BroTKm5sVGPXpVr3orGZH4r
         tf28F+d4Ad6ZIr4cLVm0QDBsJne8ntj65QXo2+82AGRL2I3nmsEp923c3FUak73rrPHA
         ttqaubdDENWKioylHgG4o5Cb4QGMSanwL6vsI8UtBBNTFtNu0KapcAX0w71lIfnA7puj
         IARcWo9kFGYhyiKDxcL9+KBaRmyxtOjETx36fpvmYDADH1V9+k0jfohWtJFOguc8X7DI
         qxx/nKA2QyIfgGETt7nyPECqg2vBk/zA4rEjqAcSL4MoSWrN0y2haZacQ9JjO4Wg//py
         db2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6I67wiVbEK6uR0FUV5PpwqZJdS4lyNkB837PooQv5eJuc2opNHAEKUpIH62b4PftCszY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6vhiNhPLEJfdma02KseKaeNkV2BTonhRGZj7wNSVg8dO/8US4
	/wI/rIUwBbAaV+aH6e0n5+O28S6pMAsp9z+W2ZkEOh7PFvQL6rXPHwvi
X-Gm-Gg: ASbGncsp45aezYdO7Sit/BDTdQGDTmHWCyQBnKA+5ZR8q/LqVj7dIpNgZvyZNU8gIb5
	IqX1Y7Px2oy9hgC0NIABOBJYn5sr4lpxiJPavG4MSIDHLnIxXFQkE+4s2UzgUutCEBY2WsSxqfu
	TZn4z5CKGziAMd1T+89MXX//dhj4Pc+s0/LyKCIc7kJWlDU5qPiTD4mPZiLqIi1rREZGe3zJ2xb
	eIQdo7UYMfYnBAS303cse7DURZqiGFYdXAymnihKjWJmAVsxAGCLhgslr3xndBmkV5Y70duCwY7
	fTo81QJuupmU9wqlV6eyGrB54xlCNvYzLwa76eI3hLUkjwHHc/XSz4w4M3haTlMcj7Y1bWEf28K
	6vRdZZkQ+31YnbgSLO6PgD1zi8YOM2sQEOTlj5HtWb39D6+FNXCAKjya55s2/k1nm93Lo3Y8ajR
	VNfIWNe+E7etok/mXmQZw6Ml/ZFdRow0HWOiYnfSYAaOKAXHI8TqlPMtTbPTT7KdU=
X-Google-Smtp-Source: AGHT+IGIKtNsd3FJ23hPgV2bBUx/FybcYVMhTrnW9IhzJ3iBk4BI/bq4GUTiAqYNcmQmFQMt6mYkzQ==
X-Received: by 2002:a05:600c:4695:b0:477:63b4:ef7a with SMTP id 5b1f17b1804b1-4778feaa8a1mr104568055e9.20.1763396862357;
        Mon, 17 Nov 2025 08:27:42 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42c961f6e64sm13704036f8f.27.2025.11.17.08.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 08:27:41 -0800 (PST)
Message-ID: <073e9a8c-3f6f-4e5c-862a-da59043eb16f@gmail.com>
Date: Mon, 17 Nov 2025 16:27:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 02/11] replay: extract logic to pick commits
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Martin von Zweigbergk <martinvonz@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
 <20251027-b4-pks-history-builtin-v6-2-407dd3f57ad3@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20251027-b4-pks-history-builtin-v6-2-407dd3f57ad3@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 27/10/2025 11:33, Patrick Steinhardt wrote:
> We're about to add a new git-history(1) command that will reuse some of
> the same infrastructure as git-replay(1). To prepare for this, extract
> the logic to pick a commit into a new "replay.c" file so that it can be
> shared between both commands.
> 
> Rename the function to have a "replay_" prefix to clearly indicate its
> subsystem.

I'm sorry it has taken me so long to get round to looking at this, I've 
been intending to read through this series ever since you re-rolled 
after the contributor summit.

This patch looks good, the only changes to the moved code are to 
namespace the function which become public. I'm very pleased to see us 
switching to using the replay machinery.

Thanks

Phillip

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>   Makefile         |   1 +
>   builtin/replay.c | 110 ++--------------------------------------------------
>   meson.build      |   1 +
>   replay.c         | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   replay.h         |  23 +++++++++++
>   5 files changed, 143 insertions(+), 107 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1919d35bf3f..01c171b4f03 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1261,6 +1261,7 @@ LIB_OBJS += reftable/tree.o
>   LIB_OBJS += reftable/writer.o
>   LIB_OBJS += remote.o
>   LIB_OBJS += replace-object.o
> +LIB_OBJS += replay.o
>   LIB_OBJS += repo-settings.o
>   LIB_OBJS += repository.o
>   LIB_OBJS += rerere.o
> diff --git a/builtin/replay.c b/builtin/replay.c
> index bb0420dc992..e39824912cd 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -2,7 +2,6 @@
>    * "git replay" builtin command
>    */
>   
> -#define USE_THE_REPOSITORY_VARIABLE
>   #define DISABLE_SIGN_COMPARE_WARNINGS
>   
>   #include "git-compat-util.h"
> @@ -16,6 +15,7 @@
>   #include "object-name.h"
>   #include "parse-options.h"
>   #include "refs.h"
> +#include "replay.h"
>   #include "revision.h"
>   #include "strmap.h"
>   #include <oidset.h>
> @@ -26,13 +26,6 @@ enum ref_action_mode {
>   	REF_ACTION_PRINT
>   };
>   
> -static const char *short_commit_name(struct repository *repo,
> -				     struct commit *commit)
> -{
> -	return repo_find_unique_abbrev(repo, &commit->object.oid,
> -				       DEFAULT_ABBREV);
> -}
> -
>   static struct commit *peel_committish(struct repository *repo, const char *name)
>   {
>   	struct object *obj;
> @@ -45,59 +38,6 @@ static struct commit *peel_committish(struct repository *repo, const char *name)
>   						  OBJ_COMMIT);
>   }
>   
> -static char *get_author(const char *message)
> -{
> -	size_t len;
> -	const char *a;
> -
> -	a = find_commit_header(message, "author", &len);
> -	if (a)
> -		return xmemdupz(a, len);
> -
> -	return NULL;
> -}
> -
> -static struct commit *create_commit(struct repository *repo,
> -				    struct tree *tree,
> -				    struct commit *based_on,
> -				    struct commit *parent)
> -{
> -	struct object_id ret;
> -	struct object *obj = NULL;
> -	struct commit_list *parents = NULL;
> -	char *author;
> -	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
> -	struct commit_extra_header *extra = NULL;
> -	struct strbuf msg = STRBUF_INIT;
> -	const char *out_enc = get_commit_output_encoding();
> -	const char *message = repo_logmsg_reencode(repo, based_on,
> -						   NULL, out_enc);
> -	const char *orig_message = NULL;
> -	const char *exclude_gpgsig[] = { "gpgsig", NULL };
> -
> -	commit_list_insert(parent, &parents);
> -	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
> -	find_commit_subject(message, &orig_message);
> -	strbuf_addstr(&msg, orig_message);
> -	author = get_author(message);
> -	reset_ident_date();
> -	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
> -				 &ret, author, NULL, sign_commit, extra)) {
> -		error(_("failed to write commit object"));
> -		goto out;
> -	}
> -
> -	obj = parse_object(repo, &ret);
> -
> -out:
> -	repo_unuse_commit_buffer(the_repository, based_on, message);
> -	free_commit_extra_headers(extra);
> -	free_commit_list(parents);
> -	strbuf_release(&msg);
> -	free(author);
> -	return (struct commit *)obj;
> -}
> -
>   struct ref_info {
>   	struct commit *onto;
>   	struct strset positive_refs;
> @@ -246,50 +186,6 @@ static void determine_replay_mode(struct repository *repo,
>   	strset_clear(&rinfo.positive_refs);
>   }
>   
> -static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
> -				    struct commit *commit,
> -				    struct commit *fallback)
> -{
> -	khint_t pos = kh_get_oid_map(replayed_commits, commit->object.oid);
> -	if (pos == kh_end(replayed_commits))
> -		return fallback;
> -	return kh_value(replayed_commits, pos);
> -}
> -
> -static struct commit *pick_regular_commit(struct repository *repo,
> -					  struct commit *pickme,
> -					  kh_oid_map_t *replayed_commits,
> -					  struct commit *onto,
> -					  struct merge_options *merge_opt,
> -					  struct merge_result *result)
> -{
> -	struct commit *base, *replayed_base;
> -	struct tree *pickme_tree, *base_tree;
> -
> -	base = pickme->parents->item;
> -	replayed_base = mapped_commit(replayed_commits, base, onto);
> -
> -	result->tree = repo_get_commit_tree(repo, replayed_base);
> -	pickme_tree = repo_get_commit_tree(repo, pickme);
> -	base_tree = repo_get_commit_tree(repo, base);
> -
> -	merge_opt->branch1 = short_commit_name(repo, replayed_base);
> -	merge_opt->branch2 = short_commit_name(repo, pickme);
> -	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
> -
> -	merge_incore_nonrecursive(merge_opt,
> -				  base_tree,
> -				  result->tree,
> -				  pickme_tree,
> -				  result);
> -
> -	free((char*)merge_opt->ancestor);
> -	merge_opt->ancestor = NULL;
> -	if (!result->clean)
> -		return NULL;
> -	return create_commit(repo, result->tree, pickme, replayed_base);
> -}
> -
>   static int handle_ref_update(enum ref_action_mode mode,
>   			     struct ref_transaction *transaction,
>   			     const char *refname,
> @@ -483,8 +379,8 @@ int cmd_replay(int argc,
>   		if (commit->parents->next)
>   			die(_("replaying merge commits is not supported yet!"));
>   
> -		last_commit = pick_regular_commit(repo, commit, replayed_commits,
> -						  onto, &merge_opt, &result);
> +		last_commit = replay_pick_regular_commit(repo, commit, replayed_commits,
> +							 onto, &merge_opt, &result);
>   		if (!last_commit)
>   			break;
>   
> diff --git a/meson.build b/meson.build
> index cee94244759..ae8d4fef059 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -464,6 +464,7 @@ libgit_sources = [
>     'reftable/writer.c',
>     'remote.c',
>     'replace-object.c',
> +  'replay.c',
>     'repo-settings.c',
>     'repository.c',
>     'rerere.c',
> diff --git a/replay.c b/replay.c
> new file mode 100644
> index 00000000000..98be33b8545
> --- /dev/null
> +++ b/replay.c
> @@ -0,0 +1,115 @@
> +#define USE_THE_REPOSITORY_VARIABLE
> +
> +#include "git-compat-util.h"
> +#include "commit.h"
> +#include "environment.h"
> +#include "gettext.h"
> +#include "ident.h"
> +#include "object.h"
> +#include "object-name.h"
> +#include "replay.h"
> +#include "tree.h"
> +
> +static const char *short_commit_name(struct repository *repo,
> +				     struct commit *commit)
> +{
> +	return repo_find_unique_abbrev(repo, &commit->object.oid,
> +				       DEFAULT_ABBREV);
> +}
> +
> +static char *get_author(const char *message)
> +{
> +	size_t len;
> +	const char *a;
> +
> +	a = find_commit_header(message, "author", &len);
> +	if (a)
> +		return xmemdupz(a, len);
> +
> +	return NULL;
> +}
> +
> +struct commit *replay_create_commit(struct repository *repo,
> +				    struct tree *tree,
> +				    struct commit *based_on,
> +				    struct commit *parent)
> +{
> +	struct object_id ret;
> +	struct object *obj = NULL;
> +	struct commit_list *parents = NULL;
> +	char *author;
> +	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
> +	struct commit_extra_header *extra = NULL;
> +	struct strbuf msg = STRBUF_INIT;
> +	const char *out_enc = get_commit_output_encoding();
> +	const char *message = repo_logmsg_reencode(repo, based_on,
> +						   NULL, out_enc);
> +	const char *orig_message = NULL;
> +	const char *exclude_gpgsig[] = { "gpgsig", NULL };
> +
> +	commit_list_insert(parent, &parents);
> +	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
> +	find_commit_subject(message, &orig_message);
> +	strbuf_addstr(&msg, orig_message);
> +	author = get_author(message);
> +	reset_ident_date();
> +	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
> +				 &ret, author, NULL, sign_commit, extra)) {
> +		error(_("failed to write commit object"));
> +		goto out;
> +	}
> +
> +	obj = parse_object(repo, &ret);
> +
> +out:
> +	repo_unuse_commit_buffer(the_repository, based_on, message);
> +	free_commit_extra_headers(extra);
> +	free_commit_list(parents);
> +	strbuf_release(&msg);
> +	free(author);
> +	return (struct commit *)obj;
> +}
> +
> +static struct commit *mapped_commit(kh_oid_map_t *replayed_commits,
> +				    struct commit *commit,
> +				    struct commit *fallback)
> +{
> +	khint_t pos = kh_get_oid_map(replayed_commits, commit->object.oid);
> +	if (pos == kh_end(replayed_commits))
> +		return fallback;
> +	return kh_value(replayed_commits, pos);
> +}
> +
> +struct commit *replay_pick_regular_commit(struct repository *repo,
> +					  struct commit *pickme,
> +					  kh_oid_map_t *replayed_commits,
> +					  struct commit *onto,
> +					  struct merge_options *merge_opt,
> +					  struct merge_result *result)
> +{
> +	struct commit *base, *replayed_base;
> +	struct tree *pickme_tree, *base_tree;
> +
> +	base = pickme->parents->item;
> +	replayed_base = mapped_commit(replayed_commits, base, onto);
> +
> +	result->tree = repo_get_commit_tree(repo, replayed_base);
> +	pickme_tree = repo_get_commit_tree(repo, pickme);
> +	base_tree = repo_get_commit_tree(repo, base);
> +
> +	merge_opt->branch1 = short_commit_name(repo, replayed_base);
> +	merge_opt->branch2 = short_commit_name(repo, pickme);
> +	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
> +
> +	merge_incore_nonrecursive(merge_opt,
> +				  base_tree,
> +				  result->tree,
> +				  pickme_tree,
> +				  result);
> +
> +	free((char*)merge_opt->ancestor);
> +	merge_opt->ancestor = NULL;
> +	if (!result->clean)
> +		return NULL;
> +	return replay_create_commit(repo, result->tree, pickme, replayed_base);
> +}
> diff --git a/replay.h b/replay.h
> new file mode 100644
> index 00000000000..d6535ee56c9
> --- /dev/null
> +++ b/replay.h
> @@ -0,0 +1,23 @@
> +#ifndef REPLAY_H
> +#define REPLAY_H
> +
> +#include "khash.h"
> +#include "merge-ort.h"
> +#include "repository.h"
> +
> +struct commit;
> +struct tree;
> +
> +struct commit *replay_create_commit(struct repository *repo,
> +				    struct tree *tree,
> +				    struct commit *based_on,
> +				    struct commit *parent);
> +
> +struct commit *replay_pick_regular_commit(struct repository *repo,
> +					  struct commit *pickme,
> +					  kh_oid_map_t *replayed_commits,
> +					  struct commit *onto,
> +					  struct merge_options *merge_opt,
> +					  struct merge_result *result);
> +
> +#endif
> 

