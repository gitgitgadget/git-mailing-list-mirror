Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7FFC38142
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 15:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjAXPag (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 10:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjAXPaf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 10:30:35 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B59213A
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:30:33 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id kt14so40037028ejc.3
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unity3d.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QjQaG8vUUy16t/x7Fj3rjskq2tKblqTtSK2h5L9smc=;
        b=VrB5atupEamQ9nHYntQc+m5kOumlFzvcS4ik2wnoYKIQnH/hFhKEcYGp4593tvx+uX
         niP9yQbf8J7WAKHRLBxwW7DJiRVmdPf4wrkBka6M4Fw5jKDRlfmMxTkTgO4YqvA3rfid
         ccuZJ5nxRbZVhT9B/oemUVehdOZkBeIdtVVKusDLTgXnL2Hb4IAe8P+QyVNz5XQJHwP9
         mkiN2PkpATbEUkWeRYPXDgOKSQ+FPB0hiKY8l0ily1Mn2y79ghiQDdbi0EH5Yt3VZ57V
         E2HhwH5oqvmgorfJC4w2Yl8fK+ISJ75akoU8x63uRi50CNnzRl3gDYfdk5pxZ5Wjvqyr
         yVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QjQaG8vUUy16t/x7Fj3rjskq2tKblqTtSK2h5L9smc=;
        b=vjisyazKAHLx7I3Ydn2Z2zEXI6e9C/s/V31b4C68KBJv7fY3A4O1yL45fArBGkNnJY
         gzv2R5DSJkLyUYeUGDoKGbBpakB/hcOgh7Pp8l076nfkRACANUk2koXWYNEnnoJUEKoR
         8yipw7Pi29kgkBdPG+XwAnhrbNpW5lITBFmCtLrRxk5NSduzcJ65gnwSoxQbfiBqpmWy
         yOhlJQLmWkcUa3DfvTeuG3KiU7giAU/5bHcwa7tkBZNPlZJ6VKlPjnlQBraDCCMpm+VX
         tO8zR65AA2KeC+kJLgbrZRLsccyJTV2f8KPEisv1e4tMJsLAZBLudJ2lKFI9jpYtb1tF
         lR9w==
X-Gm-Message-State: AFqh2koKJZ7UlitMzy6xh4rUlgv0jXCqMIg97DQPNyUCvpmDtBd4uXyl
        54qfnRhAGvs4o2E5Qi72gA9MEw==
X-Google-Smtp-Source: AMrXdXsDfi+xW1heuoZJINMAHksVsp95XK4AWpFjeDYl7/eoZ/twds+ZZzAHQyk+TxuYtBdNKmgS+g==
X-Received: by 2002:a17:907:c24b:b0:85c:f3cd:66f3 with SMTP id tj11-20020a170907c24b00b0085cf3cd66f3mr30203716ejc.9.1674574231444;
        Tue, 24 Jan 2023 07:30:31 -0800 (PST)
Received: from [10.45.34.243] ([80.80.14.217])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7c04f000000b00497d8613532sm1180594edo.5.2023.01.24.07.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:30:31 -0800 (PST)
Message-ID: <9787a68d-80a3-f554-355c-5015798a8816@unity3d.com>
Date:   Tue, 24 Jan 2023 16:30:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] ls-tree: add --sparse-filter-oid argument
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        William Sprent via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
 <pull.1459.v2.git.1674474371817.gitgitgadget@gmail.com>
 <230123.861qnltmbp.gmgdl@evledraar.gmail.com>
From:   William Sprent <williams@unity3d.com>
In-Reply-To: <230123.861qnltmbp.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/01/2023 14.06, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Jan 23 2023, William Sprent via GitGitGadget wrote:
> 
>> From: William Sprent <williams@unity3d.com>
> 
> ...some further inline commentary, in addition to my proposed squash-in...
> 

Thanks for taking the time. :)

>> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
>> index 0240adb8eec..724bb1f9dbd 100644
>> --- a/Documentation/git-ls-tree.txt
>> +++ b/Documentation/git-ls-tree.txt
>> @@ -11,6 +11,7 @@ SYNOPSIS
>>   [verse]
>>   'git ls-tree' [-d] [-r] [-t] [-l] [-z]
>>   	    [--name-only] [--name-status] [--object-only] [--full-name] [--full-tree] [--abbrev[=<n>]] [--format=<format>]
>> +	    [--sparse-filter-oid=<blob-ish>]
>>   	    <tree-ish> [<path>...]
>>   
>>   DESCRIPTION
>> @@ -48,6 +49,11 @@ OPTIONS
>>   	Show tree entries even when going to recurse them. Has no effect
>>   	if `-r` was not passed. `-d` implies `-t`.
>>   
>> +--sparse-filter-oid=<blob-ish>::
>> +	Omit showing tree objects and paths that do not match the
>> +	sparse-checkout specification contained in the blob
>> +	(or blob-expression) <blob-ish>.
>> +
>>   -l::
>>   --long::
>>   	Show object size of blob (file) entries.
>> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
>> index 72eb70823d5..46a815fc7dc 100644
>> --- a/builtin/ls-tree.c
>> +++ b/builtin/ls-tree.c
>> @@ -13,6 +13,7 @@
>>   #include "builtin.h"
>>   #include "parse-options.h"
>>   #include "pathspec.h"
>> +#include "dir.h"
>>   
>>   static const char * const ls_tree_usage[] = {
>>   	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
>> @@ -364,6 +365,65 @@ static struct ls_tree_cmdmode_to_fmt ls_tree_cmdmode_format[] = {
>>   	},
>>   };
> 
> Okey, here yo uupdate the *.txt, but not the "-h", but it's one of those
> where way say <options>.
> 
> I for one wouldn't mind some preceding change like my 423be1f83c5 (doc
> txt & -h consistency: make "commit" consistent, 2022-10-13), which in
> turn would make t/t0450-txt-doc-vs-help.sh pass for this command, but
> maybe it's too much of a digression...
> 

I don't mind doing that.

>> +	(*d) = xcalloc(1, sizeof(**d));
>> +	(*d)->fn = fn;
>> +	(*d)->pl.use_cone_patterns = core_sparse_checkout_cone;
> 
> I forgot to note in my proposed fix-up that I omitted this, but your
> tests still pass, which suggests it's either not needed, or your tests
> are lacking....
> 

Well.. The line exists to enable the cone mode optimisations. The only 
observable differences are performance and that a warning is emitted 
when cone mode is enabled in the config but the patterns given aren't in 
the cone mode pattern set.

I can look into writing a performance test that captures the performance 
differences.

I can also test for the latter behaviour. But that is testing for the 
side effect of a main behaviour to ensure that the main behaviour is 
there. Which isn't the nicest thing I can think of, but it might be 
better than nothing.

>> +	(*d)->options = options;
>> +	strbuf_init(&(*d)->full_path_buf, 0);
>> +
>> +	if (get_oid_with_context(the_repository, sparse_oid_name, GET_OID_BLOB,
>> +			&sparse_oid, &oc))
>> +		die(_("unable to access sparse blob in '%s'"), sparse_oid_name);
>> +	if (add_patterns_from_blob_to_list(&sparse_oid, "", 0, &(*d)->pl) < 0)
> 
> As noted you can avoid the malloc here, which also sidesteps this (IMO
> at last) ugly &(*v)->m syntax.
> 

Right.

>> +		die(_("unable to parse sparse filter data in %s"),
>> +		    oid_to_hex(&sparse_oid));
>> +}
>> +
>> +static void free_sparse_filter_data(struct sparse_filter_data *d)
>> +{
>> +	clear_pattern_list(&d->pl);
>> +	strbuf_release(&d->full_path_buf);
>> +	free(d);
>> +}
>> +
>> +static int path_matches_sparse_checkout_patterns(struct strbuf *full_path, struct pattern_list *pl, int dtype)
>> +{
>> +	enum pattern_match_result match = recursively_match_path_with_sparse_patterns(full_path->buf, the_repository->index, dtype, pl);
> 
> I for one would welcome e.g. abbreviating "sparse_checkout_patterns" as
> "scp" or whatever throughout, with resulting shortening of very long
> lines & identifiers. E.g. for this one "patch_match_scp" or whatever.
> 
> 

I don't mind either way, but a quick search doesn't reveal any of uses 
of an abbreviation like, though.

Either way, I could also drop the '_checkout_' from 
'sparse_checkout_patterns'. I don't think that would make it less clear 
what we are talking about.

>> +	struct sparse_filter_data *data = context;
>> +
> 
> Style: Don't add a \n\n between variable decls,
> 
>> +	int do_recurse = show_recursive(data->options, base->buf, base->len, pathname);
> 
> Instead add it here, before the code proper.
> 
> 

Alright. I'll apply that.

>> +	if (object_type(mode) == OBJ_TREE)
>> +		return do_recurse;
>> +
>> +	strbuf_reset(&data->full_path_buf);
> 
> I wondered if we need this after, but we don't, I for one would welcome a fix-up like:
> 	
> 	diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> 	index 68d6ef675f2..74dfa9a4580 100644
> 	--- a/builtin/ls-tree.c
> 	+++ b/builtin/ls-tree.c
> 	@@ -410,19 +410,21 @@ static int filter_sparse(const struct object_id *oid, struct strbuf *base,
> 	 			 const char *pathname, unsigned mode, void *context)
> 	 {
> 	 	struct sparse_filter_data *data = context;
> 	-
> 	 	int do_recurse = show_recursive(data->options, base->buf, base->len, pathname);
> 	+	int ret = 0;
> 	+
> 	 	if (object_type(mode) == OBJ_TREE)
> 	 		return do_recurse;
> 	
> 	-	strbuf_reset(&data->full_path_buf);
> 	 	strbuf_addbuf(&data->full_path_buf, base);
> 	 	strbuf_addstr(&data->full_path_buf, pathname);
> 	
> 	 	if (!path_matches_sparse_checkout_patterns(&data->full_path_buf, &data->pl, DT_REG))
> 	-			return 0;
> 	-
> 	-	return data->fn(oid, base, pathname, mode, data->options);
> 	+		goto cleanup;
> 	+	ret = data->fn(oid, base, pathname, mode, data->options);
> 	+cleanup:
> 	+	strbuf_reset(&data->full_path_buf);
> 	+	return ret;
> 	 }
> 	
> 	 int cmd_ls_tree(int argc, const char **argv, const char *prefix)
> 	
> It's slightly more verbose, and we do end up needlessly reset-ing the
> "last" one, but makes it clear that we don't have need for this after
> this.
> 
> Which to me, also raises the question of why you have this
> "full_path_buf" at all. It looks like a memory optimization, as you're
> trying to avoid a malloc()/free() in the loop.
> 
> That's fair, but you could also do that with:
> 
> 	const size_t oldlen = base->len;
> 	strbuf_addstr(base, pathname);
>          /* do the path_matches_sparse_checkout_patterns() call here */
> 	/* before "cleanup" */
> 	strbuf_setlen(base, oldlen);
> 
> Or whatever, those snippets are untested, but we use similar tricks
> elsewhere, and as it's contained to a few lines here I think it's better
> than carrying another buffer.
> 

Okay. That makes sense. And if it is a common trick then I guess it 
isn't too mysterious.

>> +	strbuf_addbuf(&data->full_path_buf, base);
>> +	strbuf_addstr(&data->full_path_buf, pathname);
> 
> Nit: Shorter as: strbuf_addf(&sb, "%s%s", base.buf, pathname) (or equivalent);
> 
>> +
>> +	if (!path_matches_sparse_checkout_patterns(&data->full_path_buf, &data->pl, DT_REG))
>> +			return 0;
>> +
>> +	return data->fn(oid, base, pathname, mode, data->options);
>> +}
>> +
>>   int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>>   {
>>   	struct object_id oid;
>> @@ -372,7 +432,11 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>>   	read_tree_fn_t fn = NULL;
>>   	enum ls_tree_cmdmode cmdmode = MODE_DEFAULT;
>>   	int null_termination = 0;
>> +
> 
> Don't add this stray \n.
> 

Ok.

>>   	struct ls_tree_options options = { 0 };
>> +	char *sparse_oid_name = NULL;
>> +	void *read_tree_context = NULL;
>> +	struct sparse_filter_data *sparse_filter_data = NULL;
>>   	const struct option ls_tree_options[] = {
>>   		OPT_BIT('d', NULL, &options.ls_options, N_("only show trees"),
>>   			LS_TREE_ONLY),
>> @@ -399,6 +463,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>>   					 N_("format to use for the output"),
>>   					 PARSE_OPT_NONEG),
>>   		OPT__ABBREV(&options.abbrev),
>> +		OPT_STRING_F(0, "filter-sparse-oid", &sparse_oid_name, N_("filter-sparse-oid"),
> 
> Make that N_(...) be "object-id", "oid", "hash" or something?
> 
> I.e. the RHS with the <type> should be <thingy>, not
> <thingy-for-some-purpose>.
> 

Right. I've used the "blob-ish" wording in the .txt file, I think it 
makes sense to reuse it here.

>> +			   N_("filter output with sparse-checkout specification contained in the blob"),
>> +			     PARSE_OPT_NONEG),
>>   		OPT_END()
>>   	};
>>   	struct ls_tree_cmdmode_to_fmt *m2f = ls_tree_cmdmode_format;
>> @@ -474,7 +541,17 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>>   		break;
>>   	}
>>   
>> -	ret = !!read_tree(the_repository, tree, &options.pathspec, fn, &options);
>> +	if (sparse_oid_name) {
>> +		init_sparse_filter_data(&sparse_filter_data, &options, sparse_oid_name, fn);
>> +		read_tree_context = sparse_filter_data;
>> +		fn = filter_sparse;
>> +	} else
>> +		read_tree_context = &options;
> 
> You're missing a {} here for the "else".
> 
> Better yet, delete that "else" and change the decl above to be:
> 
> 	void *context = &options;
> 
> Then just keep the "if" here, where you might clobber the "context".
> 

I'll delete the else as you suggest.

>> +
>> +	ret = !!read_tree(the_repository, tree, &options.pathspec, fn, read_tree_context);
>>   	clear_pathspec(&options.pathspec);
>> +	if (sparse_filter_data)
>> +		free_sparse_filter_data(sparse_filter_data);
> 
> I suggested a fixup for this, but as an aside don't make a free_*()
> function that's not happy to accept NULL, it should work like the free()
> itself.
> 

Ah. That's a fair point. Thanks.

>> +
>>   	return ret;
>>   }
>> diff --git a/dir.c b/dir.c
>> index 4e99f0c868f..122ebced08e 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -1457,45 +1457,50 @@ int init_sparse_checkout_patterns(struct index_state *istate)
>>   	return 0;
>>   }
>>   
>> -static int path_in_sparse_checkout_1(const char *path,
>> -				     struct index_state *istate,
>> -				     int require_cone_mode)
>> +int recursively_match_path_with_sparse_patterns(const char *path,
>> +						struct index_state *istate,
>> +						int dtype,
>> +						struct pattern_list *pl)
>>   {
>> -	int dtype = DT_REG;
>>   	enum pattern_match_result match = UNDECIDED;
>>   	const char *end, *slash;
>> -
>> -	/*
>> -	 * We default to accepting a path if the path is empty, there are no
>> -	 * patterns, or the patterns are of the wrong type.
>> -	 */
>> -	if (!*path ||
>> -	    init_sparse_checkout_patterns(istate) ||
>> -	    (require_cone_mode &&
>> -	     !istate->sparse_checkout_patterns->use_cone_patterns))
>> -		return 1;
>> -
>>   	/*
>>   	 * If UNDECIDED, use the match from the parent dir (recursively), or
>>   	 * fall back to NOT_MATCHED at the topmost level. Note that cone mode
>>   	 * never returns UNDECIDED, so we will execute only one iteration in
>>   	 * this case.
>>   	 */
>> -	for (end = path + strlen(path);
>> -	     end > path && match == UNDECIDED;
>> +	for (end = path + strlen(path); end > path && match == UNDECIDED;
> 
> All good, aside from this whitespace refactoring, as noted.
> 

Ok.

>>   	     end = slash) {
>> -
>>   		for (slash = end - 1; slash > path && *slash != '/'; slash--)
>>   			; /* do nothing */
>>   
>>   		match = path_matches_pattern_list(path, end - path,
>>   				slash > path ? slash + 1 : path, &dtype,
>> -				istate->sparse_checkout_patterns, istate);
>> +				pl, istate);
>>   
>>   		/* We are going to match the parent dir now */
>>   		dtype = DT_DIR;
>>   	}
>> -	return match > 0;
>> +
>> +	return match;
>> +}
>> +
>> +static int path_in_sparse_checkout_1(const char *path,
>> +				     struct index_state *istate,
>> +				     int require_cone_mode)
>> +{
>> +	/*
>> +	 * We default to accepting a path if the path is empty, there are no
>> +	 * patterns, or the patterns are of the wrong type.
>> +	 */
>> +	if (!*path ||
>> +	    init_sparse_checkout_patterns(istate) ||
>> +	    (require_cone_mode &&
>> +	     !istate->sparse_checkout_patterns->use_cone_patterns))
>> +		return 1;
>> +
>> +	return recursively_match_path_with_sparse_patterns(path, istate, DT_REG, istate->sparse_checkout_patterns) > 0;
> 
> All good, except for the really long line, aside from the previous
> suggestion, maybe pull "istate->sparse_checkout_patterns" into a
> variable, as it's now used twice here in this function?
> 

I think that makes sense.

>> +check_agrees_with_ls_files () {
>> +	REPO=repo  &&
>> +	git -C $REPO submodule deinit -f --all &&
>> +	git -C $REPO cat-file -p $filter_oid >"$REPO/.git/info/sparse-checkout" &&
>> +	git -C $REPO sparse-checkout init --cone &&
>> +	git -C $REPO submodule init &&
>> +	git -C $REPO ls-files -t >out &&
>> +	sed -n "/^S /!s/^. //p" out >expect &&
>> +	test_cmp expect actual
> 
> Instead of this last "sed" munging, why not use the "--format" option to
> "ls-tree" to just make the output the same?

I hadn't thought about changing that side of the output. I would have to 
call ls-tree once more instead of relying on the 'expect' file to be 
there when the function is called. But that might be nicer anyway.

