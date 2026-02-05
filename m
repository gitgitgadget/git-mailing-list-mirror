Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8183ACA64
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 11:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289867; cv=pass; b=hwXisW5GVA0MvuesZhRsROHWAxJvmZx778wQ6ZQ9GyYP5NGlofOdogngouCZiZciHyWCNL9xyFxN7RdjydWiZENq9mDCnZIbh37l97NZBCXzgkBSOO0MOWdNMwUXImn17OgCQu8r16Wryyw0mR9y/qyMgM4dcVsVVZBg4SGyZbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289867; c=relaxed/simple;
	bh=OmQzn07A0ryW4AjGEwb+BLB/VH16PFEO9uAaP5879pk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u83x9Eh77prJT7vzmcUawlnhgpFMgPoqzPjaBmrDy3sUGDjEosqn0jq92LeoPGBBKBsCq+BEEt0CdQyy00Ji57FALl1NL5BbplBW+s0/Q4sNNSTGjlJQlqGtjkd/aw8bKbvaM3Z2g752mc4frDAeNsFDhhA4+ce44mqs831+sOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUmmH+iF; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUmmH+iF"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-948bd416c7eso198630241.2
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 03:11:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770289866; cv=none;
        d=google.com; s=arc-20240605;
        b=h9o0o3FxwGEPWl87C90n0tRQ+QPATdlaTCTZQ+cBrwNRSG/RSR6l1u7nM/AhfTTlnE
         /HDALHS4pAqkRc7IyxwZ1v5QymcnoMfuVNqCMlheDuu5ZZByssLjU2c77PQ5727/P4iL
         Wy4sBaNz05Ld2prWizTuXr3f3fD3l5y443WZG9siXbn4Bxt+47Dx1YRuV7ETiugP/9hD
         Y5uatcZRixqRBWUz/R2jr13uDPy5j3/s+AlicqA7Cw9aArSDi/dxu/bloLGFtJhPAGQL
         /NYVu91t/U8sNHBqZVBFiWUqu6NNTaklgujKDji9ojt4xColdhvqFG7vyXGMb7JT7u/C
         pl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=b3GLrNRkT1s/OphRQkJoWMnKcHyqb4LU5oxZOJE8LdA=;
        fh=XfDBJPIkKlK/MxncBtv9UijuAbqe0dSItjKtZakfyXU=;
        b=XXQ+XxVeCtuKSjMkDZ4nLV70FcTwHrq2ljTRYBto3sNEV14BZ9ZRLUcTHv10zUUhDG
         pT15cm3yp8CPmF1ekTudQJ3xvbwZ9FoUur6h0yFFCXgIC6LCFl63yAphly0y/AJnf6wy
         oFa+PMv4Nfi2HTspGuEL1W+vSErzckz/I9/5BR95bSHcWJOK9mjnDhy8vAFeiqmaqDve
         nsPXW6EGgFywJB0uGD2228GxDdVVC+urvlDScSAn4d6sR1Hv4VK6IJSkOGFWYqCGc2gN
         d6zdyfQQASJFKI1YtYGrcJwk5sqNEwYm2xV7XPmgP8KfSg7E4rWy4EIXLyT1qnc5k6ya
         b+Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770289866; x=1770894666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3GLrNRkT1s/OphRQkJoWMnKcHyqb4LU5oxZOJE8LdA=;
        b=AUmmH+iFA32vkRw43ivmbVKA8FjpvskETml20zhk34ge6lxcZ9ep3qja2mANXaslBD
         3KM7tFMS9ogvEPsk0QN96xP5lrB9YMn0iO7+iVmiMMxDJuMHsTtJhdgLA2xsJuVB8fXf
         7AQ+fAKF1TURHJ/BwkxhLo3SbRdoQx14th2zLutdNEYIkXCrpKcXSSw8Ef0o9shVBO6l
         kK1oMHAPhQUqlGqrK6sDL1KFnchVtKZSLluBGvklJVqHWbCVpB5mk10KBBWtrnt4xt4h
         QYVVdaBD0tnll4NKTySP+hByExyOubLCYH3QcdaLTDgEKH6K86yr5+8Vb5BpOcR7NHga
         EIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289866; x=1770894666;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3GLrNRkT1s/OphRQkJoWMnKcHyqb4LU5oxZOJE8LdA=;
        b=FUlIiWN9FgQe8A0zmCw6ebm4u8W8iXH8pVmY61I554e3JDMiCwApZf8T5DFVg/3NPM
         +G6mZm8yY2+01MI5yFiyzl1HFJXm2vAm9HTJpsdes9HL62UVlCTGtaTw+u9UverWB4oX
         Baeh+D5CP0ngo8RpcHTbN7WyQWNcimXaqLbdcI38SOyM0fIBuOHVlQtZgqjykoQXmncC
         QWCRXTUMf/TKkeJ6USZ20zaqFvdex7bazdw3t3JbhF5m3PXgMuesK4GlqmUrt/7WjmgR
         S+cntKP44coZeOA3jtdljP+Vr2ku03Xrco1lrS5J8FM+qVWl+n5sWQYDBFez7TeK5D8d
         /1KA==
X-Forwarded-Encrypted: i=1; AJvYcCX2r1CatVHlUYGkKdJi8C5aObdo8plOxpeUfaejGvzr8LM6up1jz0jEdr59TP0izcIeLZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2gAZJ3q6gMU03gbPnj86lP8QzAFnp5idPHF4NV+sNqOcSVypi
	QVayvV7sqcZf2UNa+z0JIHY5qhp/ecW5/aIZqfINfO9RcTg8wv+lUX5J5hDFKngGwrKTodluk27
	B60BtbN+vsXWqi4hzb0aYQXOXCdqE55Q=
X-Gm-Gg: AZuq6aIICj0f/OhfNoY4byt1fHvRi7JwxB0SUcLf6vaiWZRszlbna76X9ETrMaGWbOT
	8/XRVu0XpqHIgcPLAUpmVwCyxzDQamWDz0FvwmcZri/6R/tQG0iku6aMpOpJayPBIu5Tp0teIQA
	o5+S0toKWrOP1lYH9UsMz5DcII5QLjwcG0DaS/lMNpnb2Vf3ohYxU4Py6lcik8uGGM20MbMPBYH
	CpJFvv+bjv8jcWDCOSnoNkLs8a4u7M0PX5QX7oWmmramUYu7QB9qmOeNlYxU/GI0DNiQHPrwr4q
	1j1I7hI6g/PoXzVityW/VqjLXTQH1A==
X-Received: by 2002:a05:6102:f0c:b0:5df:ac57:b0ea with SMTP id
 ada2fe7eead31-5f9394be8d9mr1873406137.10.1770289866295; Thu, 05 Feb 2026
 03:11:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 05:11:05 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 05:11:05 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZQOzNrCkKzwG7CuH5Ge+OPZcT4i0cY9nRkAJZO6T_QZQw@mail.gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260205101524.125452-1-shreyanshpaliwalcmsmn@gmail.com> <20260205101524.125452-2-shreyanshpaliwalcmsmn@gmail.com>
 <CAOLa=ZQOzNrCkKzwG7CuH5Ge+OPZcT4i0cY9nRkAJZO6T_QZQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 5 Feb 2026 05:11:05 -0600
X-Gm-Features: AZwV_QhGV5E-0AwxtaK9HpPHoMsPFilKC7L4C6wlNoiYOENroSqh2zWvMF_2qI4
Message-ID: <CAOLa=ZTFUZF_8YFk=TkMXVYptP6q9_bJRUoBYYsjCMW02NKc7w@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] wt-status: replace uses of the_repository with
 local repository instances
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000a16c14064a11ba6f"

--000000000000a16c14064a11ba6f
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>
>> wt-status.c uses the global the_repository in several places even when
>> a repository instance is already available via struct wt_status or
>> struct worktree.
>>
>> Replace these direct uses of the_repository with the repository carried
>> by the local structs (e.g. s->repo, wt->repo).
>>
>> The replacements of all the_repository with s->repo are mostly
>> to cases where a repository instance is already available via
>> struct wt_status. All functions operating on struct wt_status *s
>> are only used after s is initialized by wt_status_prepare(),
>> which sets s->repo from the repository provided by the caller.
>> As a result, s->repo is guaranteed to be available and consistent
>> whenever these functions are invoked.
>>
>> This reduces reliance on global state and keeps wt-status consistent,
>> though many functions operating on struct wt_status *s
>> are called via commit.c and it still relies on the_repository,
>> but within wt-status.c the local repository pointer
>> refers to the same underlying repository object.
>>
>> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
>> ---
>>  wt-status.c | 28 ++++++++++++++--------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/wt-status.c b/wt-status.c
>> index e12adb26b9..f71addc35f 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
>>  	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
>>  	s->use_color = GIT_COLOR_UNKNOWN;
>>  	s->relative_paths = 1;
>> -	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
>> +	s->branch = refs_resolve_refdup(get_main_ref_store(r),
>>  					"HEAD", 0, NULL, NULL);
>>  	s->reference = "HEAD";
>>  	s->fp = stdout;
>> -	s->index_file = repo_get_index_file(the_repository);
>> +	s->index_file = repo_get_index_file(s->repo);
>>  	s->change.strdup_strings = 1;
>>  	s->untracked.strdup_strings = 1;
>>  	s->ignored.strdup_strings = 1;
>> @@ -646,7 +646,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>>
>>  	repo_init_revisions(s->repo, &rev, NULL);
>>  	memset(&opt, 0, sizeof(opt));
>> -	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
>> +	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
>>  	setup_revisions(0, NULL, &rev, &opt);
>>
>>  	rev.diffopt.flags.override_submodule_config = 1;
>> @@ -1146,7 +1146,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
>>  	rev.diffopt.ita_invisible_in_index = 1;
>>
>>  	memset(&opt, 0, sizeof(opt));
>> -	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
>> +	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
>>  	setup_revisions(0, NULL, &rev, &opt);
>>
>>  	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
>> @@ -1317,9 +1317,9 @@ static int split_commit_in_progress(struct wt_status *s)
>>  	    !s->branch || strcmp(s->branch, "HEAD"))
>>  		return 0;
>>
>> -	if (refs_read_ref_full(get_main_ref_store(the_repository), "HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>> +	if (refs_read_ref_full(get_main_ref_store(s->repo), "HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>>  			       &head_oid, &head_flags) ||
>> -	    refs_read_ref_full(get_main_ref_store(the_repository), "ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>> +	    refs_read_ref_full(get_main_ref_store(s->repo), "ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>>  			       &orig_head_oid, &orig_head_flags))
>>  		return 0;
>>  	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
>> @@ -1432,7 +1432,7 @@ static void show_rebase_information(struct wt_status *s,
>>  				i++)
>>  				status_printf_ln(s, color, "   %s", have_done.items[i].string);
>>  			if (have_done.nr > nr_lines_to_show && s->hints) {
>> -				char *path = repo_git_path(the_repository, "rebase-merge/done");
>> +				char *path = repo_git_path(s->repo, "rebase-merge/done");
>>  				status_printf_ln(s, color,
>>  					_("  (see more in file %s)"), path);
>>  				free(path);
>> @@ -1534,7 +1534,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
>>  	else
>>  		status_printf_ln(s, color,
>>  			_("You are currently cherry-picking commit %s."),
>> -			repo_find_unique_abbrev(the_repository, &s->state.cherry_pick_head_oid,
>> +			repo_find_unique_abbrev(s->repo, &s->state.cherry_pick_head_oid,
>>  						DEFAULT_ABBREV));
>>
>>  	if (s->hints) {
>> @@ -1564,7 +1564,7 @@ static void show_revert_in_progress(struct wt_status *s,
>>  	else
>>  		status_printf_ln(s, color,
>>  			_("You are currently reverting commit %s."),
>> -			repo_find_unique_abbrev(the_repository, &s->state.revert_head_oid,
>> +			repo_find_unique_abbrev(s->repo, &s->state.revert_head_oid,
>>  						DEFAULT_ABBREV));
>>  	if (s->hints) {
>>  		if (has_unmerged(s))
>> @@ -1624,7 +1624,7 @@ static char *get_branch(const struct worktree *wt, const char *path)
>>  	struct object_id oid;
>>  	const char *branch_name;
>>
>> -	if (strbuf_read_file(&sb, worktree_git_path(the_repository, wt, "%s", path), 0) <= 0)
>> +	if (strbuf_read_file(&sb, worktree_git_path(wt->repo, wt, "%s", path), 0) <= 0)
>>  		goto got_nothing;
>>
>
> So if you look into `worktree_git_path()`, it has a certain check
>
>   if (wt && wt->repo != r)
> 		BUG("worktree not connected to expected repository");
>
> But this is okay with your change, the only question is, do we know wt
> is always defined here? Unfortunately, wt can be NULL here, in the same
> file we have:
>
>   wt_status_check_rebase(NULL, state);
>   -> get_branch(NULL, ...)
>
> Which would crash, no? This is applicable for other parts of the code
> too were we're now using wt->repo.
>
> This is also what I was requesting in the previous round, about
> explaining why it is safe to make a particular change.
>
> [snip]

One question, did you run the entire test suite with these changes? I
would hope that we have tests which would fail if my inference is
correct. If not, there's a gap in our tests too.

- Karthik

--000000000000a16c14064a11ba6f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e6de0fae82bc2c6a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tRWVzY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN0QzQy93TjA0SzZCdWJOVmhvK0RIZmlKOVVVMloxegp2LzRFMnNXOXR0
eHhvMG1TeDI2KzBIbjFaM1FUMndHOTF2ckJEM0t2Kzl2aU9NOGoyYlduanpIbmEyNktXN25ICnBi
ZzFzeWJ1Mk92OWQ3dnlwTmZqVnpPMjJrNXBsN2MxelI2bU1uVWFyMWRrcDN1U0h5RUtKWUdiQVVm
YnlYWTEKZkhqUlA4QU95VFlqSGt1c0c4MmlIUmpreGVYak1ldnJHbkhVMTJtZDdHV2NmQi96dHFa
aUU1RWtOcC9iNFdCbQpqMEI2MXhmeFNWTVg0N3dTdldvQUE4VVAzcEN3b3dnbXlwQXJnZ3RTN2pj
NURIcW95amlYelcwam4rWjM5N1VqCmNvOUVEOFVGWDZwKzBLYjBiR2xKK2ZzL0JJTmpyWDZCTU80
OXRYY3JMYzd3Z3BvNmM0RVl6NHNvaUlWSEo0amoKNXR3bUJ2dm1lcHVDQk5ZNzQwWXhiWUVPYW1S
Q2I3MVVWcitET3FROFcyVWxXSFNZcDVaajFQZm1hODZKVzNlNgpTYVJBU0UydGdCbjlmS0Jpc0h2
N2tnUkRud1Z0NlUzamZkY1FRZEZDUU5xUEFYdUdxUjA1WTNpbXpXMTQ4SU9tCjZxY2M4U25LUGZS
UllwT3FxbWs4RzlMeWUyejFQb0hpdnFsRURtOD0KPWd3cWEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a16c14064a11ba6f--
