Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2824E4A8
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455881; cv=none; b=EgniUfnuvZ6ySURUNoiG3jLVxQfPR0krO9Cf1ElxXJaJxaNyEbo+GmYr4NLzUkR+NX9Bhez3Mo9DXlqAS9dk0js77ACCqBYZcpKN/2QOClYPmNRj3Iaiipr5TE0BcXVGE0g0bq7apFyeaE0NCb5n781Ean8MtNxAUK6mDVi62UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455881; c=relaxed/simple;
	bh=fFYirowumJYkBSxeSFWtCiPeJ56+jaDasuVgIjmUSwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3OX3uI4ZQFmNF6icmfn/wo/Tu6Ab2EXuOSzIT7uqaIzN3tn08KwFQsO5yq1GICabCrFwib8YuC7ybd3tMXWcV6C5CrlHvp81ZvVlkZPVFDcCgQnuuLmqo3Ze9vJ/nYOIjMwzIYLmJDTMTWEhlvBxugZBdf4CwDGMVXqOHVtdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=si3tqN3N; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si3tqN3N"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b41b545d9so2693452f8f.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774455876; x=1775060676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v8q5GU9+s5zej5EYP/nBC1VI2yKPohEe8zRzoYqpTzM=;
        b=si3tqN3NuLM3IWsU1JAZ1v9KG2AOtSC8wQUI9ZvAOOjYO9Zu2LMN+gjY7mHQXM4Kth
         sY1DeM+eG/CGjXUj1YiQO8jPIlSbTH500B3qYDFbI9EGurqWPwyB6EOQUnMZwYLeNI+E
         GCaLwTPwiqQyWaGecrkdXcb++SOoGQIFW7W8arD2EycXoxhsXZWeaztqujwFHZxOfAUS
         o1N0M8uEtY8AUXPbvQ594oQ2zp4/9FpLjHlckZj3RrGz4Cfrx8ipIUKiWd6nlEzi5+Ka
         /rUYT7d2JkA2Ehh33Z2ZJz6mjfg9/MK+TXFgDb6m2gkaO37C0RH79Z+Y8heOTZbGa6bz
         YuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774455876; x=1775060676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8q5GU9+s5zej5EYP/nBC1VI2yKPohEe8zRzoYqpTzM=;
        b=AaBv9bPkA6wWScN21TPY/EIdt0xAxhKj145jXPLv00rO5WDQoe3DnZlJvBJbAPznOK
         6EqrNIPlG1+mWyzYX7uBXkWP2ZxAjz0N4L4FdMaIwGFZmPID0KXUnonwIxMbXnGm2OJu
         yj2/iF4gxeeEg6bgzkrC4hF/+4UPajqqdXybObdv/dDKWxAk2u+uHqdnZvoPjiH82LEq
         JltZ8wbf0rJp1UF3KJo+nqrahT4/6pYgn/09nlMP7vOiWk9TTwbFSwWUF+M9GzaZ0rJz
         y98a6ZOg+lnbVuvdTv78UgnDdlWv3Uxtv5A0xKUxBzgBSxW6Pni0U/9AVY/rzTIhAbCP
         nzXA==
X-Forwarded-Encrypted: i=1; AJvYcCXkWHq9ULjJvZfpaA2J+syGMsKFsS6qJ22tB0QdqlQEPQBINw2FAPC5QkYhPoKmFtQ5UJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ShA4Tja+K65blQO9Gvp7UfwSfE601lZfbZbXjNjMccdcLG3d
	DNXKUongVc0kEyXjOcOAn97uTjZvWRuQJtDFd1wryNuutGyuHFpDMQD07VlqBg==
X-Gm-Gg: ATEYQzy4O/IaPJYJludGu0tDjhV3WHjnQnrmvZ3eVBW0n8eibsPUXkdi+HFnV46E4XN
	x06MzVPuNYosJIMhk+uyibswj4hRh5+H4H906RIcZfEki05/TAK7wJD3ID+mjNmtQ637C7nAAyY
	mLNZP31wBHcK+3Zz8zawwcNrd/tRZMVXMz+FIOnwl51zBmWiTlN8LxJCXOFIMyOaxhN7UZuN0h5
	Fi0fPqL6GvHyhisX4B1nGk7sG7YsWRddjCxlFO883YA0hvlKIuerdT3MzwbIzvXl7l5uGTzm41z
	SYitsow05JOC+wivSlj3o9WgdTLcDKWoplC0qg5yribT1TtZFqOMM19Yei+j9211Wov00rpNrFp
	D+GIqtYQ2vPqgPWq8C2GNbbzKqsrq6X05ykqi4deDfsd9NCwo9217OvlvyKZsBIth8sYGQy/UQb
	LXcshomP4S8Q4kcReFpV5qQ01iQS4x8z5mNU99miUnR8iYWatBnOcy87qFyoK0LpGLVzeHYzTA9
	f+RTolmGcpGruW/
X-Received: by 2002:a05:6000:2308:b0:43b:6a16:17e with SMTP id ffacd0b85a97d-43b88994d97mr6548815f8f.11.1774455875989;
        Wed, 25 Mar 2026 09:24:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919e722dsm716623f8f.35.2026.03.25.09.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 09:24:35 -0700 (PDT)
Message-ID: <2a0ccbfe-3d26-4146-89ed-3b942bdc861e@gmail.com>
Date: Wed, 25 Mar 2026 16:24:25 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 1/1] add -p: support discarding hunks with 'x'
To: Luiz Campos <luizedc1@gmail.com>, git@vger.kernel.org
Cc: peff@peff.net, sagotsky@gmail.com, Johannes.Schindelin@gmx.de
References: <20260325075055.354709-1-luizedc1@gmail.com>
 <20260325075055.354709-2-luizedc1@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260325075055.354709-2-luizedc1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luiz

On 25/03/2026 07:50, Luiz Campos wrote:
> When using `git add -p`, users can stage or skip hunks,
> but cannot discard unwanted changes from the working tree.
> 
> Introduce a new 'x' action to discard the current hunk by
> reverse-applying it.
> 
> This idea was suggested in a previous mailing list discussion:
> https://lore.kernel.org/git/X%2FiFCo0bXLR%2BLZXs@coredump.intra.peff.net/t/#m0576e6f3c6375e11cc4693b9dca3c1fc57baadd0

I tend to agree with peff's comments in that thread that it is rather 
unexpected for "git add" to modify the working copy. I also think that a 
command that lets you stage some changes and discard others could be 
useful as I do both fairly frequently from my editor. Regardless of 
whether we want a new command the implementation will be similar so I've 
left some comments on the code below.

> diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
> index 941135dc63..0ab81e5615 100644
> --- a/Documentation/git-add.adoc
> +++ b/Documentation/git-add.adoc
> @@ -351,12 +351,15 @@ patch::
>          K - go to the previous hunk, roll over at the top
>          s - split the current hunk into smaller hunks
>          e - manually edit the current hunk
> +       x - discard this hunk from the worktree
>          p - print the current hunk
>          P - print the current hunk using the pager
>          ? - print help
>   +
> -After deciding the fate for all hunks, if there is any hunk
> -that was chosen, the index is updated with the selected hunks.
> +After deciding the fate for all hunks, any hunks marked for
> +discard are removed from the working tree (reverted to the index
> +version for those lines).  Then, if there is any hunk chosen for
> +staging, the index is updated with those hunks.

Makes sense.

>   +
>   You can omit having to type return here, by setting the configuration
>   variable `interactive.singleKey` to `true`.
> diff --git a/add-patch.c b/add-patch.c
> index 4e28e5c187..ea38ab453e 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -259,7 +259,7 @@ struct hunk_header {
>   struct hunk {
>   	size_t start, end, colored_start, colored_end, splittable_into;
>   	ssize_t delta;
> -	enum { UNDECIDED_HUNK = 0, SKIP_HUNK, USE_HUNK } use;
> +	enum { UNDECIDED_HUNK = 0, SKIP_HUNK, USE_HUNK, DISCARD_HUNK } use;
>   	struct hunk_header header;
>   };
>   
> @@ -884,17 +884,35 @@ static void render_diff_header(struct add_p_state *s,
>   	}
>   }
>   
> +static bool should_merge_hunk(struct file_diff *file_diff,
> +			      size_t hunk_index, int use_all,
> +			      int merge_for_discard)
> +{
> +	if (use_all)
> +		return true;

If we're looking for hunks to discard then we want to return false if 
all the hunks have been selected to be staged.

> +	return merge_for_discard
> +		? file_diff->hunk[hunk_index].use == DISCARD_HUNK
> +		: file_diff->hunk[hunk_index].use == USE_HUNK;

It would be simpler just to take USE_HUNK or DISCARD_HUNK as an argument 
rather than a boolean here.

>   /* Coalesce hunks again that were split */
>   static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
> -		       size_t *hunk_index, int use_all, struct hunk *merged)
> +		       size_t *hunk_index, int use_all, struct hunk *merged,
> +		       int merge_for_discard)

Taking the type of hunk we want to retain (USE_HUNK or DISCARD_HUNK) 
would avoid having to convert merge_for_discard back into the hunk type 
in should_merge_hunk().

>   {
>   	size_t i = *hunk_index, delta;
>   	struct hunk *hunk = file_diff->hunk + i;
>   	/* `header` corresponds to the merged hunk */
>   	struct hunk_header *header = &merged->header, *next;
>   
> -	if (!use_all && hunk->use != USE_HUNK)
> +	if (!should_merge_hunk(file_diff, *hunk_index, use_all, merge_for_discard)) {
>   		return 0;
> +	}

There's no need to add braces here

> @@ -1014,11 +1032,13 @@ static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
>   
>   static void reassemble_patch(struct add_p_state *s,
>   			     struct file_diff *file_diff, int use_all,
> +			     enum reassemble_mode mode,
>   			     struct strbuf *out)
>   {
>   	struct hunk *hunk;
>   	size_t save_len = s->plain.len, i;
>   	ssize_t delta = 0;
> +	int merge_for_discard = (mode == REASSEMBLE_DISCARD);

It would by simpler just to take USE_HUNK or DISCARD_HUNK as a parameter 
and pass that to reassemble_patch() rather than forcing the caller to 
pass an enum that we then transform to a boolean.

>   
>   	render_diff_header(s, file_diff, 0, out);
>   
> @@ -1026,25 +1046,26 @@ static void reassemble_patch(struct add_p_state *s,
>   		struct hunk merged = { 0 };
>   
>   		hunk = file_diff->hunk + i;
> -		if (!use_all && hunk->use != USE_HUNK)
> +		if (!should_merge_hunk(file_diff, i, use_all, merge_for_discard)) {
>   			delta += hunk->header.old_count
>   				- hunk->header.new_count;
> -		else {
> -			/* merge overlapping hunks into a temporary hunk */
> -			if (merge_hunks(s, file_diff, &i, use_all, &merged))
> -				hunk = &merged;
> +			continue;

I'm not sure this is an improvement - it certainly makes the patch 
harder to read because you end up changing the indentation of otherwise 
unchanged lines that were in the else clause.

> +		}
>   
> -			render_hunk(s, hunk, delta, 0, out);
> +		if (merge_hunks(s, file_diff, &i, use_all, &merged,
> +				merge_for_discard))
> +			hunk = &merged;
>   
> -			/*
> -			 * In case `merge_hunks()` used `plain` as a scratch
> -			 * pad (this happens when an edited hunk had to be
> -			 * coalesced with another hunk).
> -			 */
> -			strbuf_setlen(&s->plain, save_len);
> +		render_hunk(s, hunk, delta, 0, out);

We need to tell render_hunk whether a hunk is being applied in reverse 
or not so that it knows whether to apply delta to the old offset or the 
new offset. Currently it uses s->mode->reverse but that will not be 
correct for the patch that discards changes from the working tree. I'm 
not sure what the best way of doing that is, the simplest approach is to 
invert s->mode->reverse when we want to keep hunks marked DISCARD_HUNK 
and then restore the original value.

> -			delta += hunk->delta;
> -		}
> +		/*
> +		 * In case `merge_hunks()` used `plain` as a scratch
> +		 * pad (this happens when an edited hunk had to be
> +		 * coalesced with another hunk).
> +		 */
> +		strbuf_setlen(&s->plain, save_len);
> +
> +		delta += hunk->delta;

This is unchanged code that re-indented because of the addition of 
"continue" above.

>   	}
>   }

> @@ -1540,6 +1562,7 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
>      "/ - search for a hunk matching the given regex\n"
>      "s - split the current hunk into smaller hunks\n"
>      "e - manually edit the current hunk\n"
> +   "x - discard this hunk from the worktree\n"

It would be nice to avoid showing this for 'checkout -p' etc.

>      "p - print the current hunk\n"
>      "P - print the current hunk using the pager\n"
>      "> - go to the next file, roll over at the bottom\n"
> @@ -1547,21 +1570,57 @@ N_("j - go to the next undecided hunk, roll over at the bottom\n"
>      "? - print help\n"
>      "HUNKS SUMMARY - Hunks: %d, USE: %d, SKIP: %d\n");
>   
> +static int apply_discard_hunks(struct add_p_state *s,
> +			       struct file_diff *file_diff)
> +{
> +	struct child_process check_cp = CHILD_PROCESS_INIT;
> +	struct child_process apply_cp = CHILD_PROCESS_INIT;
> +
> +	strbuf_reset(&s->buf);
> +	reassemble_patch(s, file_diff, 0, REASSEMBLE_DISCARD, &s->buf);
> +
> +	discard_index(s->index);
> +
> +	setup_child_process(s, &check_cp, "apply", "-R", "--check", NULL);
> +	if (pipe_command(&check_cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0)) {
> +		error(_("'git apply -R --check' failed"));
> +		return -1;
> +	}

Why do we need to run "git apply --check" here?

> +	setup_child_process(s, &apply_cp, "apply", "-R", NULL);
> +	if (pipe_command(&apply_cp, s->buf.buf, s->buf.len, NULL, 0, NULL, 0)) {
> +		error(_("'git apply -R' failed"));
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>   static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
>   {
>   	struct child_process cp = CHILD_PROCESS_INIT;
>   	size_t j;
> +	int needs_refresh = 0;
> +
> +	if (s->mode == &patch_mode_add) {
> +		for (j = 0; j < file_diff->hunk_nr; j++) {
> +			if (file_diff->hunk[j].use == DISCARD_HUNK)
> +				break;
> +		}
> +		if (j < file_diff->hunk_nr && apply_discard_hunks(s, file_diff))
> +			return;
> +		if (j < file_diff->hunk_nr)
> +			needs_refresh = 1;
> +	}
>   
> -	/* Any hunk to be used? */

Isn't this comment still relevant?

>   	for (j = 0; j < file_diff->hunk_nr; j++)
>   		if (file_diff->hunk[j].use == USE_HUNK)
>   			break;
>   
>   	if (j < file_diff->hunk_nr ||
> -		(!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {
> -		/* At least one hunk selected: apply */
> +	    (!file_diff->hunk_nr && file_diff->head.use == USE_HUNK)) {

What's the point of this change?

>   		strbuf_reset(&s->buf);
> -		reassemble_patch(s, file_diff, 0, &s->buf);
> +		reassemble_patch(s, file_diff, 0, REASSEMBLE_STAGE, &s->buf);
>   
>   		discard_index(s->index);
>   		if (s->mode->apply_for_checkout)
> @@ -1574,13 +1633,15 @@ static void apply_patch(struct add_p_state *s, struct file_diff *file_diff)
>   					NULL, 0, NULL, 0))
>   				error(_("'git apply' failed"));
>   		}
> -		if (read_index_from(s->index, s->index_file, s->r->gitdir) >= 0 &&
> -		    s->index == s->r->index) {
> -			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
> -						     1, NULL, NULL, NULL);
> -		}
> +		needs_refresh = 1;
>   	}
>   
> +	if (needs_refresh &&
> +	    read_index_from(s->index, s->index_file, s->r->gitdir) >= 0 &&
> +	    s->index == s->r->index) {
> +		repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
> +					     1, NULL, NULL, NULL);

We now wait until we've applied both patches before refreshing the index 
- sounds sensible.

> +	}
>   }


> @@ -1722,6 +1784,10 @@ static size_t patch_update_file(struct add_p_state *s,
>   			    !file_diff->deleted) {
>   				permitted |= ALLOW_EDIT;
>   				strbuf_addstr(&s->buf, ",e");
> +				if (s->mode == &patch_mode_add) {
> +					permitted |= ALLOW_DISCARD;
> +					strbuf_addstr(&s->buf, ",x");
> +				}

So 'x' is only permitted if 'e' is what's the reason for that?
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> [...]
> +test_expect_success 'add -p discard removes worktree change' '
> +	test_when_finished "rm -rf discard-testrepo" &&
> +	mkdir discard-testrepo &&

It's nice to see a test for 'x', but I'm not sure why this test needs to 
be in a separate repository - why can't it use the same repository as 
the other tests?

> +	(
> +		cd discard-testrepo &&
> +		git init -b main &&
> +		echo clean >discard-me &&
> +		git add discard-me &&
> +		git commit -m base &&
> +		echo extra >>discard-me &&
> +		test_write_lines x | git add -p discard-me &&
> +		printf "clean\n" >expect &&
> +		test_cmp expect discard-me &&
> +		git diff --cached >tmp &&
> +		test_must_be_empty tmp

It would be nice to see tests that split a hunk like

-a
+A
  b
-c
+C
  d
-e
+E

and then (1) stage the first and third sub-hunks and discard the second, 
(2) discard the first and third sub-hunks and stage the second. It would 
also be nice to see a test that discards a hunk with pathological 
context lines - see 2bd69b9024c (add -p: fix checkout -p with 
pathological context, 2019-06-12) for an example.

Thanks

Phillip


> +	)
> +'
> +
>   test_expect_success 'setup expected' '
>   	cat >expected <<-\EOF
>   	diff --git a/non-empty b/non-empty
> @@ -521,13 +539,13 @@ test_expect_success 'split hunk setup' '
>   test_expect_success 'goto hunk 1 with "g 1"' '
>   	test_when_finished "git reset" &&
>   	tr _ " " >expect <<-EOF &&
> -	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? + 1:  -1,2 +1,3          +15
> +	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,x,p,P,?]? + 1:  -1,2 +1,3          +15
>   	_ 2:  -2,4 +3,8          +21
>   	go to which hunk? @@ -1,2 +1,3 @@
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?_
>   	EOF
>   	test_write_lines s y g 1 | git add -p >actual &&
>   	tail -n 7 <actual >actual.trimmed &&
> @@ -540,7 +558,7 @@ test_expect_success 'goto hunk 1 with "g1"' '
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?_
>   	EOF
>   	test_write_lines s y g1 | git add -p >actual &&
>   	tail -n 4 <actual >actual.trimmed &&
> @@ -550,11 +568,11 @@ test_expect_success 'goto hunk 1 with "g1"' '
>   test_expect_success 'navigate to hunk via regex /pattern' '
>   	test_when_finished "git reset" &&
>   	tr _ " " >expect <<-EOF &&
> -	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
> +	(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,x,p,P,?]? @@ -1,2 +1,3 @@
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?_
>   	EOF
>   	test_write_lines s y /1,2 | git add -p >actual &&
>   	tail -n 5 <actual >actual.trimmed &&
> @@ -567,7 +585,7 @@ test_expect_success 'navigate to hunk via regex / pattern' '
>   	_10
>   	+15
>   	_20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?_
>   	EOF
>   	test_write_lines s y / 1,2 | git add -p >actual &&
>   	tail -n 4 <actual >actual.trimmed &&
> @@ -579,11 +597,11 @@ test_expect_success 'print again the hunk' '
>   	tr _ " " >expect <<-EOF &&
>   	+15
>   	 20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? @@ -1,2 +1,3 @@
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? @@ -1,2 +1,3 @@
>   	 10
>   	+15
>   	 20
> -	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?_
> +	(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?_
>   	EOF
>   	test_write_lines s y g 1 p | git add -p >actual &&
>   	tail -n 7 <actual >actual.trimmed &&
> @@ -595,11 +613,11 @@ test_expect_success TTY 'print again the hunk (PAGER)' '
>   	cat >expect <<-EOF &&
>   	<GREEN>+<RESET><GREEN>15<RESET>
>   	 20<RESET>
> -	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
> +	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
>   	PAGER  10<RESET>
>   	PAGER <GREEN>+<RESET><GREEN>15<RESET>
>   	PAGER  20<RESET>
> -	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
> +	<BOLD;BLUE>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? <RESET>
>   	EOF
>   	test_write_lines s y g 1 P |
>   	(
> @@ -796,21 +814,21 @@ test_expect_success 'colors can be overridden' '
>   	<BLUE>+<RESET><BLUE>new<RESET>
>   	<CYAN> more-context<RESET>
>   	<BLUE>+<RESET><BLUE>another-one<RESET>
> -	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,p,P,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
> +	<YELLOW>(1/1) Stage this hunk [y,n,q,a,d,s,e,x,p,P,?]? <RESET><BOLD>Split into 2 hunks.<RESET>
>   	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
>   	<CYAN> context<RESET>
>   	<BOLD>-old<RESET>
>   	<BLUE>+<RESET><BLUE>new<RESET>
>   	<CYAN> more-context<RESET>
> -	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
> +	<YELLOW>(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? <RESET><MAGENTA>@@ -3 +3,2 @@<RESET>
>   	<CYAN> more-context<RESET>
>   	<BLUE>+<RESET><BLUE>another-one<RESET>
> -	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,p,P,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
> +	<YELLOW>(2/2) Stage this hunk [y,n,q,a,d,K,J,g,/,e,x,p,P,?]? <RESET><MAGENTA>@@ -1,3 +1,3 @@<RESET>
>   	<CYAN> context<RESET>
>   	<BOLD>-old<RESET>
>   	<BLUE>+new<RESET>
>   	<CYAN> more-context<RESET>
> -	<YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? <RESET>
> +	<YELLOW>(1/2) Stage this hunk (was: y) [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? <RESET>
>   	EOF
>   	test_cmp expect actual
>   '
> @@ -1424,9 +1442,9 @@ test_expect_success 'invalid option s is rejected' '
>   	test_write_lines j s q | git add -p >out &&
>   	sed -ne "s/ @@.*//" -e "s/ \$//" -e "/^(/p" <out >actual &&
>   	cat >expect <<-EOF &&
> -	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,p,P,?]?
> -	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]? Sorry, cannot split this hunk
> -	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,p,P,?]?
> +	(1/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,s,e,x,p,P,?]?
> +	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]? Sorry, cannot split this hunk
> +	(2/2) Stage this hunk [y,n,q,a,d,k,K,j,J,g,/,e,x,p,P,?]?
>   	EOF
>   	test_cmp expect actual
>   '

