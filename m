Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00619D067
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 08:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398787; cv=none; b=oLDDZvUGCbkJtmwxTdIgrzp35qFKT4o6ERqs/cKLN2i3MRX4FZdWW92xEMoLMWticpcHAKaETALuh5Cuf7cPUIBnhokNKIS2cY157h0oBW7nVC/xnEduDflAiuIrAA9u1F8yRmWnu1AL9LRXPRFD2rIPXgz59s1QK435LtwovYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398787; c=relaxed/simple;
	bh=rmJ/60F5FrL/qc0T620WAlWwauXfzCp+1QDGB/a7iGs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=GADZNpAJbrjMrI6qg19rlr4xYbFBJ2vzxFivaiWsKsIvMGZQdeItPQu5yR9CkJuNbscrfrUJ991NqBACzeMcVgPeEJGnj/tiLRG387p4qjDqkpIxh4fJspIH+wHmbym9Yknhcl7CX3iwZqs1/W7s1qTl5KnPyYyPoF1eeRVBGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M83ha4vD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M83ha4vD"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d538fe5f2so3904620f8f.2
        for <git@vger.kernel.org>; Tue, 12 Nov 2024 00:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731398784; x=1732003584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CwtWTKYF8zD4oeS8EV4BhI3WLpdj1Am9lu2gT9WenWY=;
        b=M83ha4vDonQV1Z1r2IrJDjXD+xzikFRRVwAi9ou5djd7zDNsgbdCGBPSJyZl2kay+B
         ohZNjD3E55o1AMuXb2vnqiv0wuq8MvYLrL51FC53CjgVPeJtBrOMdxrwBzvA9efr7MDT
         wqf1yvo86mM5x03KMt7uuLDbC0kA/nN7mjAFn0OLK0v9fnPPOCv90dMLtYVYHbCo5DYB
         C0W9nCMLSIot+Mo4Zaj10he2WTBRcd3h6v8d0CFPf+AsJYQaDTvWeY8Xkyr1Q4rN4kz1
         yd4WAzDt4YZmjV7COwz2GE1nry5EdkRKsD0wNm2bPeuG62vDf11stEowLstBqmdUh44k
         6NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731398784; x=1732003584;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CwtWTKYF8zD4oeS8EV4BhI3WLpdj1Am9lu2gT9WenWY=;
        b=J9mSytf3YfYOndRyjvhx44uMEv/XKDZrYhG5ov1oJhZMtaYl/O9FCXQUFeU+hdDD8O
         s1eJ2wE6ARpbj4aGPhhIhgFnAhIrXqlqPfw2G8QAS0LXZIC9+0zCbiPtnlgJnGLP8nNZ
         Cn7CCsRnkbYrYxnPTJr408/IQ3KLtdq01LfIYqcEeZEy1o0l8tkTaMxq7MF1P37jDxSk
         T3OQC3rfIPR+6PIjR0aaI4LkwW7bW0iwmqdD2GUY06GA7v/k425gQ9R3MZKjr9xeEfRI
         xacnnNAESnobCL+qCDeHBLJjKFmF9SICXj/2MdFPxfE3IiMXJ2KnNp32Rh4DUJxCa5Mj
         jtZw==
X-Forwarded-Encrypted: i=1; AJvYcCWC8ee7KM/NbDBfHZ8RQ/a4qN8cUu2MqGty1VXA5cdRUnVa17u6BckFA//igpwqDLEnTIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Fo9wPQ+msThBqEqeMxrFv/blMrtmhwwtUag/NRFFacJY738f
	2a2JPGpjbKMy3lZjCjMUS2epMFppFNeNw1RsW3EgqPxAH97o1/bC
X-Google-Smtp-Source: AGHT+IG4KH7IynuiRmNMnw1/nWCBz1f8z3kR0QKFktBjlkr5ql6JvVi6t2XRjfqNtGRWapuRCqWiHQ==
X-Received: by 2002:a5d:6daf:0:b0:371:8eb3:603a with SMTP id ffacd0b85a97d-381f17253e1mr14363301f8f.27.1731398783602;
        Tue, 12 Nov 2024 00:06:23 -0800 (PST)
Received: from gmail.com ([178.237.229.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e5bddsm203729955e9.38.2024.11.12.00.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 00:06:22 -0800 (PST)
Message-ID: <3b311295-f43c-4b4d-bbbc-79e49eb5911d@gmail.com>
Date: Tue, 12 Nov 2024 09:06:21 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/27] Memory leak fixes (pt.10, final)
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
References: <cover.1730901926.git.ps@pks.im>
 <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
 <894bb8da-fd5d-4352-a31f-3167b3cd7e1b@gmail.com>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
In-Reply-To: <894bb8da-fd5d-4352-a31f-3167b3cd7e1b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Nov 12, 2024 at 12:33:16AM +0100, Rubén Justo wrote:

>> Range-diff versus v1:
>>
>>  1:  09dbc39ffb =  1:  76daa9584b builtin/blame: fix leaking blame entries with `--incremental`
>>  2:  15bbe539ea =  2:  6659f0d59b bisect: fix leaking good/bad terms when reading multipe times
>>  3:  739e28c864 =  3:  5a9011e1ef bisect: fix leaking string in `handle_bad_merge_base()`
>>  4:  fa91eb9dc6 =  4:  3afc0a7bfe bisect: fix leaking `current_bad_oid`
>>  5:  4ca01afd9e =  5:  15577aaae6 bisect: fix multiple leaks in `bisect_next_all()`
>>  6:  805b91ce20 =  6:  13ddfed4fc bisect: fix leaking commit list items in `check_merge_base()`
>>  7:  0f183fb264 !  7:  0bc49ed3bb bisect: fix various cases where we leak commit list items
>>     @@ bisect.c: static struct commit_list *skip_away(struct commit_list *list, int cou
>>      +			else if (previous)
>>      +				result = previous;
>>      +			else
>>     -+				result =  list;
>>     ++				result = list;
>>      +			break;
>>       		}
>>       		previous = cur;
>>  8:  163c36c78e =  8:  addba1afce line-log: fix leak when rewriting commit parents
>>  9:  c0bcfbd98b =  9:  6e501effad strvec: introduce new `strvec_splice()` function
>> 10:  cf0ac084c5 = 10:  2271761621 git: refactor alias handling to use a `struct strvec`
>> 11:  c4989aab86 = 11:  7bff5d167f git: refactor builtin handling to use a `struct strvec`
>> 12:  483d2951cc = 12:  e93d461504 split-index: fix memory leak in `move_cache_to_base_index()`
>> 13:  70b12d6347 = 13:  a0643da6f5 builtin/sparse-checkout: fix leaking sanitized patterns
>> 14:  f57d967cd5 = 14:  881feffeb1 help: refactor to not use globals for reading config
>> 15:  45aacddc8a <  -:  ---------- help: fix leaking `struct cmdnames`
>>  -:  ---------- > 15:  f1bbb676f2 help: fix leaking `struct cmdnames`
>> 16:  b61cc4da84 ! 16:  51c7ad993f help: fix leaking return value from `help_unknown_cmd()`
>>     @@ help.c: static const char bad_interpreter_advice[] =
>>       {
>>       	struct help_unknown_cmd_config cfg = { 0 };
>>       	int i, n, best_similarity = 0;
>>     - 	struct cmdnames main_cmds = { 0 };
>>     - 	struct cmdnames other_cmds = { 0 };
>>     - 	struct cmdname_help *common_cmds;
>>     --	const char *assumed = NULL;
>>     -+	char *assumed = NULL;
>>     - 
>>     - 	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
>>     - 
>>      @@ help.c: const char *help_unknown_cmd(const char *cmd)
>>       			; /* still counting */
>>       	}
>>       	if (cfg.autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
>>     --		assumed = main_cmds.names[0]->name;
>>     +-		const char *assumed = main_cmds.names[0]->name;
>>      -		main_cmds.names[0] = NULL;
>>      -		cmdnames_release(&main_cmds);
>>     -+		assumed = xstrdup(main_cmds.names[0]->name);
>>     ++		char *assumed = xstrdup(main_cmds.names[0]->name);
>>      +
>>       		fprintf_ln(stderr,
>>       			   _("WARNING: You called a Git command named '%s', "
>>       			     "which does not exist."),
>>     -@@ help.c: const char *help_unknown_cmd(const char *cmd)
>>     - 			strbuf_release(&msg);
>>     - 			if (!(starts_with(answer, "y") ||
>>     - 			      starts_with(answer, "Y"))) {
>>     --				assumed = NULL;
>>     -+				FREE_AND_NULL(assumed);
>>     - 				goto out;
>>     - 			}
>>     - 		} else {
>>      
>>       ## help.h ##
>>      @@ help.h: void list_all_other_cmds(struct string_list *list);
>> 17:  b38a39ef04 = 17:  38a25da315 builtin/help: fix leaks in `check_git_cmd()`
>> 18:  cd5cde9acb ! 18:  462c9fc110 builtin/init-db: fix leaking directory paths
>>     @@ builtin/init-db.c: int cmd_init_db(int argc,
>>      -
>>       	flags |= INIT_DB_EXIST_OK;
>>      -	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
>>     -+	ret =  init_db(git_dir, real_git_dir, template_dir, hash_algo,
>>     - 		       ref_storage_format, initial_branch,
>>     - 		       init_shared_repository, flags);
>>     +-		       ref_storage_format, initial_branch,
>>     +-		       init_shared_repository, flags);
>>     ++	ret = init_db(git_dir, real_git_dir, template_dir, hash_algo,
>>     ++		      ref_storage_format, initial_branch,
>>     ++		      init_shared_repository, flags);
>>      +
>>      +	free(template_dir_to_free);
>>      +	free(real_git_dir_to_free);
>> 19:  2c7b50461b = 19:  6eabeed343 builtin/branch: fix leaking sorting options
>> 20:  6865dda344 = 20:  2a44bbfba3 t/helper: fix leaking commit graph in "read-graph" subcommand
>>  -:  ---------- > 21:  fc8a96bac3 global: drop `UNLEAK()` annotation
>> 21:  d7d8ece289 ! 22:  10e44976c2 git-compat-util: drop `UNLEAK()` annotation
>>     @@ Metadata
>>      Author: Patrick Steinhardt <ps@pks.im>
>>      
>>       ## Commit message ##
>>     -    git-compat-util: drop `UNLEAK()` annotation
>>     +    git-compat-util: drop now-unused `UNLEAK()` macro
>>      
>>     -    There are two users of `UNLEAK()` left in our codebase:
>>     -
>>     -      - In "builtin/clone.c", annotating the `repo` variable. That leak has
>>     -        already been fixed though as you can see in the context, where we do
>>     -        know to free `repo_to_free`.
>>     -
>>     -      - In "builtin/diff.c", to unleak entries of the `blob[]` array. That
>>     -        leak has also been fixed, because the entries we assign to that
>>     -        array come from `rev.pending.objects`, and we do eventually release
>>     -        `rev`.
>>     -
>>     -    This neatly demonstrates one of the issues with `UNLEAK()`: it is quite
>>     -    easy for the annotation to become stale. A second issue is that its
>>     -    whole intent is to paper over leaks. And while that has been a necessary
>>     -    evil in the past, because Git was leaking left and right, it isn't
>>     -    really much of an issue nowadays where our test suite has no known leaks
>>     +    The `UNLEAK()` macro has been introduced with 0e5bba53af (add UNLEAK
>>     +    annotation for reducing leak false positives, 2017-09-08) to help us
>>     +    reduce the amount of reported memory leaks in cases we don't care about,
>>     +    e.g. when exiting immediately afterwards. We have since removed all of
>>     +    its users in favor of freeing the memory and thus don't need the macro
>>          anymore.
>>      
>>     -    Remove the last two users and drop the now-unused `UNLEAK()` annotation.
>>     +    Remove it.
>>      
>>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>>      
>>     - ## builtin/clone.c ##
>>     -@@ builtin/clone.c: int cmd_clone(int argc,
>>     - 	free(dir);
>>     - 	free(path);
>>     - 	free(repo_to_free);
>>     --	UNLEAK(repo);
>>     - 	junk_mode = JUNK_LEAVE_ALL;
>>     - 
>>     - 	transport_ls_refs_options_release(&transport_ls_refs_options);
>>     -
>>     - ## builtin/diff.c ##
>>     -@@ builtin/diff.c: int cmd_diff(int argc,
>>     - 	release_revisions(&rev);
>>     - 	object_array_clear(&ent);
>>     - 	symdiff_release(&sdiff);
>>     --	UNLEAK(blob);
>>     - 	return result;
>>     - }
>>     -
>>       ## git-compat-util.h ##
>>      @@ git-compat-util.h: int cmd_main(int, const char **);
>>       int common_exit(const char *file, int line, int code);
>> 22:  d52ca35b05 = 23:  218132b7d5 t5601: work around leak sanitizer issue
>> 23:  44b48929fb = 24:  832c87a045 t: mark some tests as leak free
>> 24:  b1fdbe04be = 25:  5fc1319241 t: remove unneeded !SANITIZE_LEAK prerequisites
>> 25:  2b752b71c6 = 26:  06a1e8b27c test-lib: unconditionally enable leak checking
>> 26:  53bc5f7d75 = 27:  19428158c8 t: remove TEST_PASSES_SANITIZE_LEAK annotations
>
> This iteration addresses all of my comments.
>
> Thanks again for working on this.  And congratulations, it's not even
> the end of the year and memory leak checks are opt-out.

Junio, reviewing the range-diff again this morning with what has been
queued I noticed this:

    $ git range-diff ea42eb76e7...a0c677023d
    [...]
    25:  67df655518 ! 26:  b2863b3f06 test-lib: unconditionally enable leak checking
        @@ Commit message
             finally fixed the last leak exposed by our test suite, which means that
             we are now basically leak free wherever we have branch coverage.
    
        -    From hereon, the Git test suite should ideally stay free of memory
        +    >From hereon, the Git test suite should ideally stay free of memory
             leaks. Most importantly, any test suite that is being added should
             automatically be subject to the leak checker, and if that test does not
             pass it is a strong signal that the added code introduced new memory
    26:  ea42eb76e7 = 27:  a0c677023d t: remove TEST_PASSES_SANITIZE_LEAK annotations

>
>>
>> ---
>> base-commit: b0c643d6a710e2b092902a3941655176b358bfd0
>> change-id: 20241111-b4-pks-leak-fixes-pt10-a6fa657f4fac
>>
