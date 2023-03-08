Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1334EC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 22:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjCHWOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCHWOm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 17:14:42 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3326132A
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 14:14:40 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id l16-20020a9d4c10000000b006944b17058cso47380otf.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 14:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678313679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJCQPR69q5NfWm1+0lryw36mCjRaGLYqbuMKlLf+tTc=;
        b=EzuKIJpz/cTxLmsAbC1qU7Mf1ueGpExeys26O3PJGkBAhXKlIcliOWkitVe0voC2Ag
         f1RQuWdYg5aUTqA/bvhAovG8KNWLyDXu9Vo5vNyWdQmX9QqDw573fqrbejcBiC5x5bT2
         DFPqGGMbqr7gx59REdoP6VVgYq0eDRckgk5zcvSPVJ00+lpu5DGt/s61apnXsIcj3gax
         +0k8nUzbDl1if8E/JmFmSDuYddkzM28JDGT9p+HsuWM9bQ3oejr6M2MmqmwL/mCKnNrk
         le6QaIsfo4suVv8dtrc0z7acvW9lT2j8ZAyCwSr7MKl/FFqO2HndXfmQEEVIFu+nkDs/
         wbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678313679;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJCQPR69q5NfWm1+0lryw36mCjRaGLYqbuMKlLf+tTc=;
        b=A5kZzW7mMj1f8DWuafrnvFv/CgndEA4wUYYJ/EQ2mB9J2o+CZA+HoQ435KS2uyBE/v
         peE8EkncHz7KuFUz1YpjbZA6lYeqBLXXLd9fNv7icmxNZrwZ9s0NyPUfDWzmeVNxMUui
         Gt+W6WgYKv3VWO1wvRJx2A9Fl0ffpeys4XmTGrcn7U3JThGyLdmZN3SMnDSXpCOUDCxH
         CcpB7Lx8KJgli9nVnEQcCauxDP+98yIz3QpCYSoO4fEk5mHxvvpWt9jP4JW0216IwUD1
         lMuf5QRJzQJFNL2Sw6F/3E8Q/vf8hhiEN3OXl64i/tRZ0Yg/XGu5OY6kUQkmkLsnpM0v
         nljg==
X-Gm-Message-State: AO0yUKUeLtmvo9MMHpbjXOGlb1J3EFKpHredynChuWUYhQMRwFtvIoAF
        w2uB9RNdYoAI1OdwPu0qgUvi
X-Google-Smtp-Source: AK7set8rHyfmao0TL4jd/qKLkDncGgdcA7qWTzSW5486o9z3bQAhzD96A1kVtfaJwfrM5zpl83zIYA==
X-Received: by 2002:a05:6830:31bb:b0:68d:48a9:85ec with SMTP id q27-20020a05683031bb00b0068d48a985ecmr9308638ots.24.1678313679647;
        Wed, 08 Mar 2023 14:14:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d0dc:3668:fb01:9900? ([2600:1700:e72:80a0:d0dc:3668:fb01:9900])
        by smtp.gmail.com with ESMTPSA id t5-20020a9d5905000000b0068d3f341dd9sm6877795oth.62.2023.03.08.14.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 14:14:39 -0800 (PST)
Message-ID: <7328e095-83c6-dd33-1d36-9220612e99c0@github.com>
Date:   Wed, 8 Mar 2023 17:14:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/8] ahead-behind: create empty builtin
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, vdye@github.com
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <0fd18b6d740f1e8a6f62a25947bc3ad49c2674a6.1678111599.git.gitgitgadget@gmail.com>
 <xmqqzg8p90mq.fsf@gitster.g> <ZAaH/iCsqdewYrUj@nand.local>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZAaH/iCsqdewYrUj@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/6/2023 7:40 PM, Taylor Blau wrote:
> On Mon, Mar 06, 2023 at 10:48:45AM -0800, Junio C Hamano wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> For example, we will be able to track all local branches relative to an
>>> upstream branch using an invocation such as
>>>
>>>   git for-each-ref --format=%(refname) refs/heads/* |
>>>     git ahead-behind --base=origin/main --stdin
>>
>> Stepping back a bit, this motivating example makes me wonder if
>>
>>  $ git for-each-ref --format='%(refname) %(aheadbehind)' refs/heads/\*
> 
> One disadvantage to using for-each-ref here is that we are bound to use
> all of the ref-sorting code, so callers can't see intermediate results
> until the entire walk is complete.
> 
> I can't remember enough of the details about the custom traversal we use
> here to know if that would even matter or not (i.e., do we need to
> traverse through the whole set of objects entirely before outputting a
> single result anyway?). But something to think about nonetheless.
> 
> At the very least, it is quite a cute idea (especially something like
> '%(aheadbehind:origin/main)') ;-).
> 
>> that computes the ahead-behind number for each ref (that matches the
>> pattern) based on their own "upstream" (presumably each branch is
>> configured to track the same, or different, upstreams), or
>> overrriding @{upstream}, a specified base, i.e.
>>
>>  $ git for-each-ref --format='%(refname) %(aheadbehind:origin/main)' refs/heads/\*
>>
>> would be a more intuitive interface to the end-users.
>>
>> It would probably work well in conjunction with
>>
>>     git for-each-ref --format='%(refname)' --merged origin/main refs/heads/\*
>>
>> which is a way to list local branches that are already merged into
>> the upstream, to have the feature appear in the same command,
>> perhaps?
> 
> One thing that we had talked about internally[^1] was the idea of
> specifying multiple bases. IOW, having some way to invoke the
> ahead-behind builtin that gives some set of tips with a common base B1,
> and another set of tips (which could--but doesn't have to--intersect
> with the first) and a common base to compare *them* to, say, B2.
> 
> There are some technical reasons that we might want to consider such a
> thing at least motivated by GitHub's proposed future use of it. But they
> are kind of technical and not that interesting to this discussion, so I
> wouldn't be sad if we didn't have a way to specify multiple bases.
> 
> OTOH, it would be nice to avoid painting ourselves into a corner from a
> UI-perspective if we can avoid it.
> 
> Thanks,
> Taylor
> 
> [^1]: ...and couldn't decide if it was going to be a nice future
> addition or simply another case of YAGNI ;-).

This use of 'git for-each-ref --format=""' actually fixes some of the
issues I had with how to specify multiple bases. I'm not sure there is
a huge need for it, except that if we allow a "%(ahead-behind:<ref>)"
format token, then we would need to support multiple bases.

Thankfully, the implementation in this series is already prepared for
that, so the following diff implements this format token:

--- >8 ---

 builtin/for-each-ref.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 ref-filter.c           | 23 +++++++++++++++++++
 ref-filter.h           | 15 ++++++++++++-
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 6f62f40d126..c8dd21d7e13 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -5,6 +5,7 @@
 #include "object.h"
 #include "parse-options.h"
 #include "ref-filter.h"
+#include "commit-reach.h"
 
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
@@ -14,6 +15,51 @@ static char const * const for_each_ref_usage[] = {
 	NULL
 };
 
+static void compute_ahead_behind(struct ref_format *format,
+				 struct ref_array *array)
+{
+	struct commit **commits;
+	size_t commits_nr = format->bases.nr + array->nr;
+
+	if (!format->bases.nr || !array->nr)
+		return;
+
+	ALLOC_ARRAY(commits, commits_nr);
+	for (size_t i = 0; i < format->bases.nr; i++) {
+		const char *name = format->bases.items[i].string;
+		commits[i] = lookup_commit_reference_by_name(name);
+		if (!commits[i])
+			die("failed to find '%s'", name);
+	}
+
+	ALLOC_ARRAY(array->counts, st_mult(format->bases.nr, array->nr));
+
+	commits_nr = format->bases.nr;
+	array->counts_nr = 0;
+	for (size_t i = 0; i < array->nr; i++) {
+		const char *name = array->items[i]->refname;
+		commits[commits_nr] = lookup_commit_reference_by_name(name);
+
+		if (!commits[commits_nr]) {
+			warning(_("could not find '%s'"), name);
+			continue;
+		}
+
+		CALLOC_ARRAY(array->items[i]->counts, format->bases.nr);
+		for (size_t j = 0; j < format->bases.nr; j++) {
+			struct ahead_behind_count *count;
+			count = &array->counts[array->counts_nr++];
+			count->tip_index = format->bases.nr + i;
+			count->base_index = j;
+
+			array->items[i]->counts[j] = count;
+		}
+		commits_nr++;
+	}
+
+	ahead_behind(commits, commits_nr, array->counts, array->counts_nr);
+}
+
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -78,6 +124,10 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	filter.name_patterns = argv;
 	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL);
+
+	/* Do ahead-behind things, if necessary. */
+	compute_ahead_behind(&format, &array);
+
 	ref_array_sort(sorting, &array);
 
 	if (!maxcount || array.nr < maxcount)
diff --git a/ref-filter.c b/ref-filter.c
index f8203c6b052..1706b9dd0d5 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -158,6 +158,7 @@ enum atom_type {
 	ATOM_THEN,
 	ATOM_ELSE,
 	ATOM_REST,
+	ATOM_AHEADBEHIND,
 };
 
 /*
@@ -586,6 +587,16 @@ static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
 	return 0;
 }
 
+static int ahead_behind_atom_parser(struct ref_format *format, struct used_atom *atom,
+				    const char *arg, struct strbuf *err)
+{
+	if (!arg)
+		return strbuf_addf_ret(err, -1, _("expected format: %%(ahead-behind:<ref>)"));
+
+	string_list_append(&format->bases, arg);
+	return 0;
+}
+
 static int head_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
@@ -645,6 +656,7 @@ static struct {
 	[ATOM_THEN] = { "then", SOURCE_NONE },
 	[ATOM_ELSE] = { "else", SOURCE_NONE },
 	[ATOM_REST] = { "rest", SOURCE_NONE, FIELD_STR, rest_atom_parser },
+	[ATOM_AHEADBEHIND] = { "ahead-behind", SOURCE_OTHER, FIELD_STR, ahead_behind_atom_parser },
 	/*
 	 * Please update $__git_ref_fieldlist in git-completion.bash
 	 * when you add new atoms
@@ -1848,6 +1860,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 	struct object *obj;
 	int i;
 	struct object_info empty = OBJECT_INFO_INIT;
+	int ahead_behind_atoms = 0;
 
 	CALLOC_ARRAY(ref->value, used_atom_cnt);
 
@@ -1978,6 +1991,16 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
 			else
 				v->s = xstrdup("");
 			continue;
+		} else if (atom_type == ATOM_AHEADBEHIND) {
+			if (ref->counts) {
+				const struct ahead_behind_count *count;
+				count = ref->counts[ahead_behind_atoms++];
+				v->s = xstrfmt("%d %d", count->ahead, count->behind);
+			} else {
+				/* Not a commit. */
+				v->s = xstrdup("");
+			}
+			continue;
 		} else
 			continue;
 
diff --git a/ref-filter.h b/ref-filter.h
index aa0eea4ecf5..937a857ddee 100644
--- a/ref-filter.h
+++ b/ref-filter.h
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "commit.h"
 #include "parse-options.h"
+#include "string-list.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -24,6 +25,7 @@
 
 struct atom_value;
 struct ref_sorting;
+struct ahead_behind_count;
 
 enum ref_sorting_order {
 	REF_SORTING_REVERSE = 1<<0,
@@ -40,6 +42,8 @@ struct ref_array_item {
 	const char *symref;
 	struct commit *commit;
 	struct atom_value *value;
+	struct ahead_behind_count **counts;
+
 	char refname[FLEX_ARRAY];
 };
 
@@ -47,6 +51,9 @@ struct ref_array {
 	int nr, alloc;
 	struct ref_array_item **items;
 	struct rev_info *revs;
+
+	struct ahead_behind_count *counts;
+	size_t counts_nr;
 };
 
 struct ref_filter {
@@ -80,9 +87,15 @@ struct ref_format {
 
 	/* Internal state to ref-filter */
 	int need_color_reset_at_eol;
+
+	/* List of bases for ahead-behind counts. */
+	struct string_list bases;
 };
 
-#define REF_FORMAT_INIT { .use_color = -1 }
+#define REF_FORMAT_INIT {             \
+	.use_color = -1,              \
+	.bases = STRING_LIST_INIT_DUP, \
+}
 
 /*  Macros for checking --merged and --no-merged options */
 #define _OPT_MERGED_NO_MERGED(option, filter, h) \
-- 
2.40.0.vfs.0.0.3.g5872ac9aaa4

--- >8 ---

I can already see some things I want to change about this quick
and dirty implementation, but it gets the point across. This
"test" can be added to the end of t6302 for some demonstration:

test_expect_success 'ahead-behind' '
	git for-each-ref --format="%(refname) %(ahead-behind:HEAD)" &&
	git for-each-ref --format="%(refname) %(ahead-behind:HEAD) %(ahead-behind:refs/heads/side)"
'

What I have yet to determine is that 'git for-each-ref' does
not have significant overhead due to how it's implementation is
built around listing "all refs that match" versus an explicit
input list of refs. There's also the concept of '--stdin' that
would be interesting to interact with.

I'll continue to investigate this path and report back when I
have more of this information. This is as far I as I could get
today.

Thanks,
-Stolee
