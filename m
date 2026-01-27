Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052422853F2
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 20:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769546907; cv=none; b=TEFFB4+7KmZZU/VuBfMqrIYyZBycCVtKLyxZZEqCUsr/GkXsHCdYmfWE4fXWQQbSzp/a1PTgfhxNi2DEVuvGEn941mNDnYx2Z48jPZcaJ7rLg67LPP/o891GuT76sv6/M+YpYwobQhfy5vU+vOe/wg4v+MhaQT39/Ze6C/c/7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769546907; c=relaxed/simple;
	bh=0f+6c72+t+yE0MaOnJ7S7xIJ8LLNh/Bp/pC2wuuk+9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uzEgVSNi17+ioaVheukSGN4jFm5eAsL44rSDkXzxVrHvIz2p1JgUmwkWCbmv5YohL+m+kDQgj1HiAD+FOHJ8BEiv6Hp9LbjMGa+jDKAWvBByfJDld0Crj3Wwfe4D+ExzuYECDgEUSclh843P01i/XbqVCPFiQMZzc0vBpswYklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q79GHSTv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DO8VRxka; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q79GHSTv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DO8VRxka"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4CE95140008E;
	Tue, 27 Jan 2026 15:48:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 27 Jan 2026 15:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769546904; x=1769633304; bh=GS+aabAL3v
	dMlo1B8CL8Y9aKjUwiUPm1DeywtdV5mFk=; b=Q79GHSTva+9ljf64dd7JG9vql8
	NUJvabtKqJgkUEHKV+DrXATZ6faL3YLfQ0QrU2h4x2bezuHhKxaT7haqbW8uzziu
	2NuTNhQu76ax5MSr9A4dEfdli1aqWEJzRzs4ec8PgIxQsrO6ALAIqsWI53PO8r3H
	UZifrj5se6crhm3GfLAqHCd1vlxZ6JwXj5MUOAfp0J5qMLVyDtPsMWcxzWsShVde
	T5TwqZ65HwlZyZCUaBZ0nkCPktFsNm54eaJ3p8tgwDj5N6+C7U4Ra7Y1XD9al+nA
	WlL34YoGY4+O1amvpelbhjwFlVCHL8S6G453pFvQ76g2We8XThzVPlTxYaQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769546904; x=1769633304; bh=GS+aabAL3vdMlo1B8CL8Y9aKjUwiUPm1Dey
	wtdV5mFk=; b=DO8VRxkaosxIn1P18L3UR19kV6xgWj2X313ZjkCsVmiAzBH9IFh
	4yInvd5zgQeuBWFH9PQYhngFQiqcWYir4Zpp5VjglIV3zz7aWbGeEthqyYuVTphI
	ycYYzgVk090WQ6a4qwKGU4dMnKZ6NZUmfUAP6dAmax0VFVh5TzEsJchaUdfG3Gxc
	kp8fyFcToL56sGDhjom6aop6LkEUSc5y+d/PpydFWeDbaMiKr53OwCQsclsC62pR
	EEGoLOdlojbdPybZjavdUqoRPxXU1R/l37UV7js6x1KrddqFoy9SRgGkFELm2lZ2
	SLH3BV0M9WkjRI0iDuMHqBuw23PpaJEOKGA==
X-ME-Sender: <xms:mCR5aRqVjf481ZKTHIrdcNBJAip1021i8rT0bjcz_KktBhBS5zf8XA>
    <xme:mCR5aWO46cjLEaKTT1N1GpbNx5d8VECyC2Pvr_6qX0K6YweI0gwKDMaJ7JPYR_KOS
    9lpzJJ13-0UNlHLexVHUNeWFtNz4YC-8YU_5gYN21xmXg8drCr6Zw>
X-ME-Received: <xmr:mCR5aR1JjuMk2EuwlIoHDS5ZkBOH8YPmmrR2xAhtpRB_XOKxqCa7ozy7p3ZMkoGYduFgnxSQKFWUObaIcVQaZ5ylIcwefA74X56nsV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduiedugeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggsrhgrhhgrmhgruggvkhhunhhlvgehtdesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgr
    shhtmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:mCR5adDkjVOFqnqL_lJdU4gvwMrm8dInxnVH_HlBjjGizMb3zqXVAw>
    <xmx:mCR5aWJ8PeD6N4URTwKZ8irg1R4cnRA1lrpjKCbJK40Fc-HsXmVsfg>
    <xmx:mCR5aem3529Jb01aguRovkn0vYYwArg8Ke9trZUxkiuvXIcbY32H9Q>
    <xmx:mCR5aXagtzaUZAEp3_kTb3mroQ7JHn31ESzKGdAK-LIs-Z_TS09jWQ>
    <xmx:mCR5aZ2MX28nIee8ioLyt4XjPUSa4i75shdjKhSlU3F_Mrrva99XNWnr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Jan 2026 15:48:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 1/1] Allow reworking with a file after deciding on
 all its hunks
In-Reply-To: <9b21cb901ab14397af94b8ed2d09da1a9a6d862b.1769522219.git.abrahamadekunle50@gmail.com>
	(Abraham Samuel Adekunle's message of "Tue, 27 Jan 2026 16:45:13
	+0100")
References: <cover.1769522219.git.abrahamadekunle50@gmail.com>
	<9b21cb901ab14397af94b8ed2d09da1a9a6d862b.1769522219.git.abrahamadekunle50@gmail.com>
Date: Tue, 27 Jan 2026 12:48:22 -0800
Message-ID: <xmqq7bt2g4tl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> diff --git a/add-patch.c b/add-patch.c
> index 173a53241e..edb2fab3fd 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1418,6 +1418,8 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
>     "e - manually edit the current hunk\n"
>     "p - print the current hunk\n"
>     "P - print the current hunk using the pager\n"
> +   "> - go to the next file\n"
> +   "< - go to the previous file\n"
>     "? - print help\n");

As I said earlier, these may have to be optional.  It may give
existing users a jarring experience to be given a prompt after
deciding on all the hunks in a file, when they expect to be on
the next file already.

> @@ -1441,6 +1443,17 @@ static bool get_first_undecided(const struct file_diff *file_diff, size_t *idx)
>  	return false;
>  }
>  
> +static size_t get_file_diff_index(struct add_p_state *s, struct file_diff *file_diff) {
> +	size_t idx = 0;
> +	for (size_t i = 0; i < s->file_diff_nr; i++) {
> +		if (s->file_diff + i == file_diff) {
> +			idx = i;
> +			break;
> +		}
> +	}
> +	return idx;
> +}

Yuck.  Can't we lose the need for this function if we change the
interface into patch_update_file so that it takes the index of the
file (i.e., instead of "&s.file_diff[i]", pass "i")?  There is only
one caller to patch_update_file() which is run_add_p(), so such a
clean-up should be trivial.

>  static int patch_update_file(struct add_p_state *s,
>  			     struct file_diff *file_diff)
>  {
> @@ -1448,9 +1461,10 @@ static int patch_update_file(struct add_p_state *s,
>  	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
>  	struct hunk *hunk;
>  	char ch;
> -	struct child_process cp = CHILD_PROCESS_INIT;

This is related to the hoisting of the actual patch application to
the caller, but it is not explained why such a change is needed, and
it byitself, even without the "jump to the next file before deciding
on all the hunks" feature.  What problem is it solving???

If it is necessary to move the code to run "git apply" to the
caller, would it make sense to split this patch into at least two
patches, one to do such a move, possibly another patch to change the
function signature of patch_update_file() so that it takes the file
index instead of file_diff struct, and finally another patch to
allow jumping around the files?

>  	int colored = !!s->colored.len, quit = 0, use_pager = 0;
>  	enum prompt_mode_type prompt_mode_type;
> +	size_t file_diff_index = get_file_diff_index(s, file_diff);
> +	int all_decided = 0;
>  
>  	/* Empty added files have no hunks */
>  	if (!file_diff->hunk_nr && !file_diff->added)
> @@ -1467,7 +1481,9 @@ static int patch_update_file(struct add_p_state *s,
>  			ALLOW_GOTO_NEXT_UNDECIDED_HUNK = 1 << 3,
>  			ALLOW_SEARCH_AND_GOTO = 1 << 4,
>  			ALLOW_SPLIT = 1 << 5,
> -			ALLOW_EDIT = 1 << 6
> +			ALLOW_EDIT = 1 << 6,
> +			ALLOW_GOTO_PREVIOUS_FILE = 1 << 7,
> +			ALLOW_GOTO_NEXT_FILE = 1 << 8
>  		} permitted = 0;
>  
>  		if (hunk_index >= file_diff->hunk_nr)
> @@ -1499,8 +1515,7 @@ static int patch_update_file(struct add_p_state *s,
>  		/* Everything decided? */
>  		if (undecided_previous < 0 && undecided_next < 0 &&
>  		    hunk->use != UNDECIDED_HUNK)
> -			break;
> -
> +				all_decided = 1;
>  		strbuf_reset(&s->buf);
>  		if (file_diff->hunk_nr) {
>  			if (rendered_hunk_index != hunk_index) {
> @@ -1548,6 +1563,16 @@ static int patch_update_file(struct add_p_state *s,
>  				permitted |= ALLOW_EDIT;
>  				strbuf_addstr(&s->buf, ",e");
>  			}
> +			if (file_diff_index >= 0 &&
> +				file_diff_index < s->file_diff_nr - 1) {
> +				permitted |= ALLOW_GOTO_NEXT_FILE;
> +				strbuf_addstr(&s->buf, ",>");
> +			}
> +			if (file_diff_index > 0 &&
> +				file_diff_index <= s->file_diff_nr - 1) {
> +				permitted |= ALLOW_GOTO_PREVIOUS_FILE;
> +				strbuf_addstr(&s->buf, ",<");
> +			}

As can be seen in what patch_update_file() does when the user says
'J' or 'K', hunks in a file are treated as a ring, and these
commands are enabled as long as there are more than one hunks.

Perhaps that is more familiar than "when we hit the floor, we cannot
sink deeper, and when we hit the ceiling, we cannot float more",
which seems to be what the above implements.

>  			strbuf_addstr(&s->buf, ",p,P");
>  		}
>  		if (file_diff->deleted)
> @@ -1566,6 +1591,9 @@ static int patch_update_file(struct add_p_state *s,
>  						: 1));
>  		printf(_(s->mode->prompt_mode[prompt_mode_type]),
>  		       s->buf.buf);
> +		if (all_decided)
> +			printf(_("\n%s All hunks decided. What now? "),
> +				s->s.prompt_color);
>  		if (*s->s.reset_color_interactive)
>  			fputs(s->s.reset_color_interactive, stdout);
>  		fflush(stdout);
> @@ -1618,7 +1646,24 @@ static int patch_update_file(struct add_p_state *s,
>  		} else if (ch == 'q') {
>  			quit = 1;
>  			break;
> -		} else if (s->answer.buf[0] == 'K') {
> +		} else if (s->answer.buf[0] == '>') {
> +			if (permitted & ALLOW_GOTO_NEXT_FILE) {
> +				quit = 0;
> +				break;
> +			} else {
> +				err(s, _("No next file"));
> +				continue;
> +			}
> +		} else if (s->answer.buf[0] == '<') {
> +			if (permitted & ALLOW_GOTO_PREVIOUS_FILE) {
> +				quit = 2;
> +				break;

What's the magic number "2"?  Should "quit" become an enum with
elements that are more meaningfully named?

> +			} else {
> +				err(s, _("No previous file"));
> +				continue;
> +			}
> +		}
> +		else if (s->answer.buf[0] == 'K') {
>  			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
>  				hunk_index = dec_mod(hunk_index,
>  						     file_diff->hunk_nr);
> @@ -1775,33 +1820,6 @@ static int patch_update_file(struct add_p_state *s,
>  		}
>  	}
>  
> -	/* Any hunk to be used? */
> -	for (i = 0; i < file_diff->hunk_nr; i++)
> -		if (file_diff->hunk[i].use == USE_HUNK)
> -			break;
> -
> -	if (i < file_diff->hunk_nr ||
> -	    (!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
> -		/* At least one hunk selected: apply */
> -		strbuf_reset(&s->buf);
> -		reassemble_patch(s, file_diff, 0, &s->buf);
> -
> -		discard_index(s->s.r->index);
> -		if (s->mode->apply_for_checkout)
> -			apply_for_checkout(s, &s->buf,
> -					   s->mode->is_reverse);
> -		else {
> -			setup_child_process(s, &cp, "apply", NULL);
> -			strvec_pushv(&cp.args, s->mode->apply_args);
> -			if (pipe_command(&cp, s->buf.buf, s->buf.len,
> -					 NULL, 0, NULL, 0))
> -				error(_("'git apply' failed"));
> -		}
> -		if (repo_read_index(s->s.r) >= 0)
> -			repo_refresh_and_write_index(s->s.r, REFRESH_QUIET, 0,
> -						     1, NULL, NULL, NULL);
> -	}

It is not obvious why the above code needs to be hoisted to the
caller.  

>  	putchar('\n');
>  	return quit;
>  }
> @@ -1813,7 +1831,9 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>  	struct add_p_state s = {
>  		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
>  	};
> -	size_t i, binary_count = 0;
> +	size_t i, j, binary_count = 0;
> +	size_t patch_update_result = 0;

Hmph, I think patch_update_file() returns "int quit".  Why do we
want overly wide type to store the result, which cannot even express
negative number to potentially signal a failure?

> +	struct child_process cp = CHILD_PROCESS_INIT;
>  
>  	init_add_i_state(&s.s, r, o);
>  
> @@ -1852,11 +1872,56 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
>  		return -1;
>  	}
>  
> -	for (i = 0; i < s.file_diff_nr; i++)
> -		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
> +	for (i = 0; i < s.file_diff_nr;) {
> +		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr) {
>  			binary_count++;
> -		else if (patch_update_file(&s, s.file_diff + i))
> -			break;
> +			i++;
> +			continue;
> +		}
> +		else {
> +			patch_update_result = patch_update_file(&s, s.file_diff + i);
> +			if (patch_update_result == 0) {
> +				i++;
> +				continue;
> +			}
> +			if (patch_update_result == 1)
> +				break;
> +			if (patch_update_result == 2) {
> +				i--;
> +				continue;
> +			}
> +		}
> +	}
> +	for (i = 0; i < s.file_diff_nr; i++) {
> +
> +			/* Any hunk to be used? */
> +		for (j = 0; j < s.file_diff[i].hunk_nr; j++)
> +			if (s.file_diff[i].hunk[j].use == USE_HUNK)
> +				break;
> +
> +		if (j < s.file_diff[i].hunk_nr ||
> +	    (!s.file_diff[i].hunk_nr && s.file_diff[i].head.use == USE_HUNK)) {
> +			/* At least one hunk selected: apply */
> +			strbuf_reset(&s.buf);
> +			reassemble_patch(&s, s.file_diff + i, 0, &s.buf);
> +
> +			discard_index(s.s.r->index);
> +			if (s.mode->apply_for_checkout)
> +				apply_for_checkout(&s, &s.buf,
> +						s.mode->is_reverse);
> +			else {
> +				setup_child_process(&s, &cp, "apply", NULL);
> +				strvec_pushv(&cp.args, s.mode->apply_args);
> +				if (pipe_command(&cp, s.buf.buf, s.buf.len,
> +						NULL, 0, NULL, 0))
> +					error(_("'git apply' failed"));
> +			}
> +			if (repo_read_index(s.s.r) >= 0)
> +				repo_refresh_and_write_index(s.s.r, REFRESH_QUIET, 0,
> +								1, NULL, NULL, NULL);
> +		}
> +
> +	}

One upside of having "git apply" at the end of patch_update_file()
is that you can "^C" out of "git add -p" or your terminal connection
can be cut off, after dealing with hunks in a few early files, and
these early part of your work that you have already done are already
reflected to the working tree files.  By hoisting the logic to the
caller, this is making the update all-or-none, which is good in
transactional systems, but can make a horrible experience for an
interactive use where you make progress while thinking.

So I am not yet convinced if this change makes sense---it could be
because of the lack of justification for this change.



>  
>  	if (s.file_diff_nr == 0)
>  		err(&s, _("No changes."));
