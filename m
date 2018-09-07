Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2811F404
	for <e@80x24.org>; Fri,  7 Sep 2018 22:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeIHDPJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 23:15:09 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55872 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeIHDPI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 23:15:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so16031452wmc.5
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CMJLlnpRQ4E5MVdKgKPygeSXsyrMOJWQO56x9M1/kOA=;
        b=Lz/+Isbp4aILhrA/DDwYjrgfGxFJpDtYchsENsDUseR1oQmy6qXlYqNraflFK6t17a
         OM7wUOo46DudEX9qRMwFRC79jDlo4goZKw0Wh3V+RYyjO4VnSjmFFi+pVb1aZc9uxX3l
         M6uJurxh8BBSBKp+iISMCmgAIIPkF5QK+8K8X2O1UOav2BZbKfEO4y9ARWJBVcEX11Up
         J4xDWvAhVgA+MhVTdXZx2E15MQDs/sVDTHkwhOc/gw+qSUQUFFCranWrcJ+aQ/qtAGjZ
         ZJpOPFkHwtYDlJ/y96aDfp0BM5CF+8tRUP6E5yO7g/8td4QxRkSR2UhhDo2fZGzMj1N6
         6iTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CMJLlnpRQ4E5MVdKgKPygeSXsyrMOJWQO56x9M1/kOA=;
        b=GMfoYIF4TGghWewSr0QuE2PEaAZYvpt82ntVIHe1Pv4/yWBIfmYB5Ba60G3f1Ad72v
         /MOLfW8kqrfF4sEVAlNsqlOA8p3PQIRipCSlNKxgc3ZQeKZdO7reYS4519Wn2xgz25W7
         FKhkaXBWAzGd5OWz8nwTet2uIS6u2dhCSTY6PKpQkfpNChrxa5joLbcgzBtEwEplbfTh
         3kOgSu5OntxtScgQOWDRDwJ5OinT5vpWC3WI2cK+jMKnohKWtljUO5UfKc/XoSd+rgC/
         zn0+ulE6g2vb5LeV1Uk1CTMO8MP/p46dYwNNNw95cYbU8X7/jMHm0eUvFtp5HDC3RaWP
         /z/g==
X-Gm-Message-State: APzg51Bn4cDXUHpus6NhX76lmBRZOb+PktUZNrigKJg3u/HIu9np3pC7
        cqnq7eNjB/n33Vmj5yMaSBvP0eRD
X-Google-Smtp-Source: ANB0VdYLn4nid2jEY7CMIFRhOEWrbjmbP2PxZtsXnH7yc/psD4pYEq5emn5jv/8dP3WwHY5423IAUQ==
X-Received: by 2002:a1c:f03:: with SMTP id 3-v6mr6285308wmp.129.1536359516983;
        Fri, 07 Sep 2018 15:31:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r13-v6sm7323673wmf.34.2018.09.07.15.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 15:31:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/4] wt-status.c: Set the committable flag in the collect phase.
References: <20180906005329.11277-1-ischis2@cox.net>
        <20180906005329.11277-5-ischis2@cox.net>
        <xmqqworxufuv.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 07 Sep 2018 15:31:55 -0700
In-Reply-To: <xmqqworxufuv.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 07 Sep 2018 15:01:28 -0700")
Message-ID: <xmqqr2i5ueg4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Stephen P. Smith" <ischis2@cox.net> writes:
>
>>  void wt_status_collect(struct wt_status *s)
>>  {
>> +	struct wt_status_state state;
>>  	wt_status_collect_changes_worktree(s);
>>  
>>  	if (s->is_initial)
>> @@ -746,6 +752,11 @@ void wt_status_collect(struct wt_status *s)
>>  	else
>>  		wt_status_collect_changes_index(s);
>>  	wt_status_collect_untracked(s);
>> +
>> +	memset(&state, 0, sizeof(state));
>> +	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
>> +	if (state.merge_in_progress && !has_unmerged(s))
>> +		s->committable = 1;
>>  }
>
> I do not think this is wrong per-se, but now we have three calls to
> wt_status_get_state() in wt-status.c, and it smells (at least to me)
> that each of these callsites does so only because their callers
> do not give them enough information, forcing them to find the state
> out for themselves.
>
> Given that the ideal paradigm to come up with the "work tree status"
> is to do the collection followed by printing, and among three
> callers of get_state(), two appear in the "printing" side of the
> callchain [*1*], I wonder if it makes a better organization to
>
>  - embed struct wt_status_state in struct wt_status
>
>  - make the new call to wt_status_get_state() added above in this
>    patch to populate the wt_status_state embedded in 's'
>
>  - change the other two callers of wt_status_get_state() in
>    wt_longstatus_print() and wt_porcelain_v2_print_tracking(), both
>    of which will receive 's' that has been populated by a previous
>    call to wt_status_collect(), so that they do *not* call
>    get_state() themselves, but instead use the result recorded in
>    wt_status_state embedded in 's', which was populated by
>    wt_status_collect() before they got called.
>
> That would bring the resulting code even closer to the ideal,
> i.e. the "collect" phase learns _everything_ we need about the
> current state that is necessary in order to later show to the user,
> and the "print" phase does not do its own separate discovery.
>
> What do you think?
>
> Thanks.

Such a "clean-up" may look like this patch:

 - add .state field to wt_status to embed a wt_status_state instance

 - remove a parameter of type struct wt_status_state from all
   functions where wt_status is already passed; we'd use .state
   field of the wt_status instead

The patch is mostly for illustration of the idea.

The result seems to compile and pass the test suite, but I haven't
carefully thought about what else I may be breaking with this
mechanical change.  For example, I noticed that both of the old
callsites of wt_status_get_state() have free() of a few fiedls in
the structure, and I kept the code as close to the original, but I
suspect they should not be freed there in the functions in the
"print" phase, but rather the caller of the "collect" and "print"
should be made responsible for deciding when to dispose the entire
wt_status (and wt_status_state as part of it).  This illustration
patch does not address that kind of details (yet).


 wt-status.c | 132 ++++++++++++++++++++++++++----------------------------------
 wt-status.h |  37 ++++++++---------
 2 files changed, 77 insertions(+), 92 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index c7f76d4758..69f2cbdca9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -744,18 +744,15 @@ static int has_unmerged(struct wt_status *s)
 
 void wt_status_collect(struct wt_status *s)
 {
-	struct wt_status_state state;
 	wt_status_collect_changes_worktree(s);
-
 	if (s->is_initial)
 		wt_status_collect_changes_initial(s);
 	else
 		wt_status_collect_changes_index(s);
 	wt_status_collect_untracked(s);
 
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
-	if (state.merge_in_progress && !has_unmerged(s))
+	wt_status_get_state(&s->state, s->branch && !strcmp(s->branch, "HEAD"));
+	if (s->state.merge_in_progress && !has_unmerged(s))
 		s->committable = 1;
 }
 
@@ -1087,8 +1084,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 }
 
 static void show_merge_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
-				const char *color)
+				   const char *color)
 {
 	if (has_unmerged(s)) {
 		status_printf_ln(s, color, _("You have unmerged paths."));
@@ -1109,16 +1105,15 @@ static void show_merge_in_progress(struct wt_status *s,
 }
 
 static void show_am_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
 				const char *color)
 {
 	status_printf_ln(s, color,
 		_("You are in the middle of an am session."));
-	if (state->am_empty_patch)
+	if (s->state.am_empty_patch)
 		status_printf_ln(s, color,
 			_("The current patch is empty."));
 	if (s->hints) {
-		if (!state->am_empty_patch)
+		if (!s->state.am_empty_patch)
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git am --continue\")"));
 		status_printf_ln(s, color,
@@ -1242,10 +1237,9 @@ static int read_rebase_todolist(const char *fname, struct string_list *lines)
 }
 
 static void show_rebase_information(struct wt_status *s,
-					struct wt_status_state *state,
-					const char *color)
+				    const char *color)
 {
-	if (state->rebase_interactive_in_progress) {
+	if (s->state.rebase_interactive_in_progress) {
 		int i;
 		int nr_lines_to_show = 2;
 
@@ -1296,28 +1290,26 @@ static void show_rebase_information(struct wt_status *s,
 }
 
 static void print_rebase_state(struct wt_status *s,
-				struct wt_status_state *state,
-				const char *color)
+			       const char *color)
 {
-	if (state->branch)
+	if (s->state.branch)
 		status_printf_ln(s, color,
 				 _("You are currently rebasing branch '%s' on '%s'."),
-				 state->branch,
-				 state->onto);
+				 s->state.branch,
+				 s->state.onto);
 	else
 		status_printf_ln(s, color,
 				 _("You are currently rebasing."));
 }
 
 static void show_rebase_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
-				const char *color)
+				    const char *color)
 {
 	struct stat st;
 
-	show_rebase_information(s, state, color);
+	show_rebase_information(s, color);
 	if (has_unmerged(s)) {
-		print_rebase_state(s, state, color);
+		print_rebase_state(s, color);
 		if (s->hints) {
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git rebase --continue\")"));
@@ -1326,17 +1318,18 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (use \"git rebase --abort\" to check out the original branch)"));
 		}
-	} else if (state->rebase_in_progress || !stat(git_path_merge_msg(the_repository), &st)) {
-		print_rebase_state(s, state, color);
+	} else if (s->state.rebase_in_progress ||
+		   !stat(git_path_merge_msg(the_repository), &st)) {
+		print_rebase_state(s, color);
 		if (s->hints)
 			status_printf_ln(s, color,
 				_("  (all conflicts fixed: run \"git rebase --continue\")"));
 	} else if (split_commit_in_progress(s)) {
-		if (state->branch)
+		if (s->state.branch)
 			status_printf_ln(s, color,
 					 _("You are currently splitting a commit while rebasing branch '%s' on '%s'."),
-					 state->branch,
-					 state->onto);
+					 s->state.branch,
+					 s->state.onto);
 		else
 			status_printf_ln(s, color,
 					 _("You are currently splitting a commit during a rebase."));
@@ -1344,11 +1337,11 @@ static void show_rebase_in_progress(struct wt_status *s,
 			status_printf_ln(s, color,
 				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
 	} else {
-		if (state->branch)
+		if (s->state.branch)
 			status_printf_ln(s, color,
 					 _("You are currently editing a commit while rebasing branch '%s' on '%s'."),
-					 state->branch,
-					 state->onto);
+					 s->state.branch,
+					 s->state.onto);
 		else
 			status_printf_ln(s, color,
 					 _("You are currently editing a commit during a rebase."));
@@ -1363,11 +1356,10 @@ static void show_rebase_in_progress(struct wt_status *s,
 }
 
 static void show_cherry_pick_in_progress(struct wt_status *s,
-					struct wt_status_state *state,
-					const char *color)
+					 const char *color)
 {
 	status_printf_ln(s, color, _("You are currently cherry-picking commit %s."),
-			find_unique_abbrev(&state->cherry_pick_head_oid, DEFAULT_ABBREV));
+			find_unique_abbrev(&s->state.cherry_pick_head_oid, DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1382,11 +1374,10 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 }
 
 static void show_revert_in_progress(struct wt_status *s,
-					struct wt_status_state *state,
-					const char *color)
+				    const char *color)
 {
 	status_printf_ln(s, color, _("You are currently reverting commit %s."),
-			 find_unique_abbrev(&state->revert_head_oid, DEFAULT_ABBREV));
+			 find_unique_abbrev(&s->state.revert_head_oid, DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
 			status_printf_ln(s, color,
@@ -1401,13 +1392,12 @@ static void show_revert_in_progress(struct wt_status *s,
 }
 
 static void show_bisect_in_progress(struct wt_status *s,
-				struct wt_status_state *state,
-				const char *color)
+				    const char *color)
 {
-	if (state->branch)
+	if (s->state.branch)
 		status_printf_ln(s, color,
 				 _("You are currently bisecting, started from branch '%s'."),
-				 state->branch);
+				 s->state.branch);
 	else
 		status_printf_ln(s, color,
 				 _("You are currently bisecting."));
@@ -1581,48 +1571,45 @@ void wt_status_get_state(struct wt_status_state *state,
 		wt_status_get_detached_from(state);
 }
 
-static void wt_longstatus_print_state(struct wt_status *s,
-				      struct wt_status_state *state)
+static void wt_longstatus_print_state(struct wt_status *s)
 {
 	const char *state_color = color(WT_STATUS_HEADER, s);
+	struct wt_status_state *state = &s->state;
+
 	if (state->merge_in_progress)
-		show_merge_in_progress(s, state, state_color);
+		show_merge_in_progress(s, state_color);
 	else if (state->am_in_progress)
-		show_am_in_progress(s, state, state_color);
+		show_am_in_progress(s, state_color);
 	else if (state->rebase_in_progress || state->rebase_interactive_in_progress)
-		show_rebase_in_progress(s, state, state_color);
+		show_rebase_in_progress(s, state_color);
 	else if (state->cherry_pick_in_progress)
-		show_cherry_pick_in_progress(s, state, state_color);
+		show_cherry_pick_in_progress(s, state_color);
 	else if (state->revert_in_progress)
-		show_revert_in_progress(s, state, state_color);
+		show_revert_in_progress(s, state_color);
 	if (state->bisect_in_progress)
-		show_bisect_in_progress(s, state, state_color);
+		show_bisect_in_progress(s, state_color);
 }
 
 static void wt_longstatus_print(struct wt_status *s)
 {
 	const char *branch_color = color(WT_STATUS_ONBRANCH, s);
 	const char *branch_status_color = color(WT_STATUS_HEADER, s);
-	struct wt_status_state state;
-
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state,
-			    s->branch && !strcmp(s->branch, "HEAD"));
 
 	if (s->branch) {
 		const char *on_what = _("On branch ");
 		const char *branch_name = s->branch;
 		if (!strcmp(branch_name, "HEAD")) {
 			branch_status_color = color(WT_STATUS_NOBRANCH, s);
-			if (state.rebase_in_progress || state.rebase_interactive_in_progress) {
-				if (state.rebase_interactive_in_progress)
+			if (s->state.rebase_in_progress ||
+			    s->state.rebase_interactive_in_progress) {
+				if (s->state.rebase_interactive_in_progress)
 					on_what = _("interactive rebase in progress; onto ");
 				else
 					on_what = _("rebase in progress; onto ");
-				branch_name = state.onto;
-			} else if (state.detached_from) {
-				branch_name = state.detached_from;
-				if (state.detached_at)
+				branch_name = s->state.onto;
+			} else if (s->state.detached_from) {
+				branch_name = s->state.detached_from;
+				if (s->state.detached_at)
 					on_what = _("HEAD detached at ");
 				else
 					on_what = _("HEAD detached from ");
@@ -1639,10 +1626,10 @@ static void wt_longstatus_print(struct wt_status *s)
 			wt_longstatus_print_tracking(s);
 	}
 
-	wt_longstatus_print_state(s, &state);
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
+	wt_longstatus_print_state(s);
+	free(s->state.branch);
+	free(s->state.onto);
+	free(s->state.detached_from);
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
@@ -1946,13 +1933,9 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 	struct branch *branch;
 	const char *base;
 	const char *branch_name;
-	struct wt_status_state state;
 	int ab_info, nr_ahead, nr_behind;
 	char eol = s->null_termination ? '\0' : '\n';
 
-	memset(&state, 0, sizeof(state));
-	wt_status_get_state(&state, s->branch && !strcmp(s->branch, "HEAD"));
-
 	fprintf(s->fp, "# branch.oid %s%c",
 			(s->is_initial ? "(initial)" : sha1_to_hex(s->sha1_commit)),
 			eol);
@@ -1963,10 +1946,11 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		if (!strcmp(s->branch, "HEAD")) {
 			fprintf(s->fp, "# branch.head %s%c", "(detached)", eol);
 
-			if (state.rebase_in_progress || state.rebase_interactive_in_progress)
-				branch_name = state.onto;
-			else if (state.detached_from)
-				branch_name = state.detached_from;
+			if (s->state.rebase_in_progress ||
+			    s->state.rebase_interactive_in_progress)
+				branch_name = s->state.onto;
+			else if (s->state.detached_from)
+				branch_name = s->state.detached_from;
 			else
 				branch_name = "";
 		} else {
@@ -2001,9 +1985,9 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		}
 	}
 
-	free(state.branch);
-	free(state.onto);
-	free(state.detached_from);
+	free(s->state.branch);
+	free(s->state.onto);
+	free(s->state.detached_from);
 }
 
 /*
diff --git a/wt-status.h b/wt-status.h
index 937b2c3521..f9115c59ae 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -64,6 +64,24 @@ enum wt_status_format {
 	STATUS_FORMAT_UNSPECIFIED
 };
 
+struct wt_status_state {
+	int merge_in_progress;
+	int am_in_progress;
+	int am_empty_patch;
+	int rebase_in_progress;
+	int rebase_interactive_in_progress;
+	int cherry_pick_in_progress;
+	int bisect_in_progress;
+	int revert_in_progress;
+	int detached_at;
+	char *branch;
+	char *onto;
+	char *detached_from;
+	struct object_id detached_oid;
+	struct object_id revert_head_oid;
+	struct object_id cherry_pick_head_oid;
+};
+
 struct wt_status {
 	int is_initial;
 	char *branch;
@@ -93,6 +111,7 @@ struct wt_status {
 	int rename_score;
 	int rename_limit;
 	enum wt_status_format status_format;
+	struct wt_status_state state;
 	unsigned char sha1_commit[GIT_MAX_RAWSZ]; /* when not Initial */
 
 	/* These are computed during processing of the individual sections */
@@ -107,24 +126,6 @@ struct wt_status {
 	uint32_t untracked_in_ms;
 };
 
-struct wt_status_state {
-	int merge_in_progress;
-	int am_in_progress;
-	int am_empty_patch;
-	int rebase_in_progress;
-	int rebase_interactive_in_progress;
-	int cherry_pick_in_progress;
-	int bisect_in_progress;
-	int revert_in_progress;
-	int detached_at;
-	char *branch;
-	char *onto;
-	char *detached_from;
-	struct object_id detached_oid;
-	struct object_id revert_head_oid;
-	struct object_id cherry_pick_head_oid;
-};
-
 size_t wt_status_locate_end(const char *s, size_t len);
 void wt_status_add_cut_line(FILE *fp);
 void wt_status_prepare(struct wt_status *s);

