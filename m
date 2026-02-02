Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A2013DDA4
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026534; cv=pass; b=MXkr6c0sHaBi/mhvP3qEOvcFdkn+Lbov5GPr+bAgfn1i76iGOCxjsdJX9ifmBhLRlw6YFqiMtNj1Bcr0TwnlXxXcp40uuScvqRevYC3thlfAnmDQLeiscBIYNfkFvJCDRXorh5Wd4OHunCH7UnqX30lP/ArocTl2AZ/GxXK7eLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026534; c=relaxed/simple;
	bh=iksHaKVIt1dAInxrx1CoAQiNJQuXUquY1chlKXZscao=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=llotGSZZK2ydwPTPUKN8/2hDQb+w4kaurdWNqJMZm1ALNth8a1ny24783SQeURSKPJ/8ye954cujgS5vFnkaBmuXw7DNTcBalrWl3nQfl7bnfaf5eX3+/wu3cRC4UzHfqlaZFOXLeP2KVLXQsrlVk8iz2ly5lFC5MEzR5q2gQ4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gC9RfKXJ; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC9RfKXJ"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-124a95e592fso4466545c88.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 02:02:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770026532; cv=none;
        d=google.com; s=arc-20240605;
        b=G/tEqC2zvK/NCZenyy0xOdE2jcY646uKhAe8SMPwoPJJ6Agws074Y9mlrB3irQVW14
         nz3CRdL7Qmyuu/OS9svHhSLUMgg+fZFtAf+PTRWGPWUPQJZzuRp3pLjf967WWyz2iBoQ
         lV1MlRMsCbrDL3jW6E+RYMIK19DzascNikmz5BhmiwHLPOOJu92WKrBaG9jHrWir2qh5
         +YKrippnBEbxLDZrikSIPDRJIFw6Y1l1eZMz3Nv1U9yhSmPccDwBTtNyIblxdrXD8rbJ
         DNrJgcDRftB99zn45VNs+SDzrRveGJiT/klRZ5lk8i8iSUnzzwE2bMmP75RGYXGDhcvP
         VGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=qwfHEmwHgqmaeJTOVJvonKcURy7EasFZeX4UN3P+ruo=;
        fh=qWw2BFf3iBkt8X+yoRVRz87y5Qgl3Fk23Rta4toPL2U=;
        b=KVr5B+J7fD6GEygTaTOqNXmQyKphS/3r/57oiHQLN9x6IbkFkb7RgfIETvEG+o//Fs
         QzWTabx3X5IFdJaXRgh2z+EG3YPlEd4+yT8UpnK7vPPeaVL8SSE47NQWjyojPLdctIJC
         mGMoe3IRBgWkffde9aWH8jnZHFoWCImYHGiBn5HRik5NpJxu9E8zRM9n7yYT0pD8T26D
         gXsPaJ8B00ZVUSXPyiO3X82HAHKfKan++m+s3W8Ecg94BvWlAZ8zCUsfB6icTk0Bvxe3
         vMUfrsmDzLggpzgGREtDq4KDQxl96LfkedqDMeSEZ1tPQrFeBr/TgF/ogc5bMkR+8lv8
         1ztQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770026532; x=1770631332; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwfHEmwHgqmaeJTOVJvonKcURy7EasFZeX4UN3P+ruo=;
        b=gC9RfKXJBrN22Rxzo+YvQWiUuhetfWMgmfGRtowbxk7fV9Zlh6qje53OqcIwwawvei
         7/eNNvbFMOkVnRhzG9rWyaSRC7eGkNeBi9Aj3P5FZtbuFtCJONrC79b7HaI6r83Yf3Rf
         Kv3g2kJ104exbbJ9tK5bKwky7zG4nk3+7WWoU5VC4Sj3EBaNQ6dN7QmctNs51DDcSJLP
         DoXYjg5w+0KHmAWqep7t0WkxBy4Z48Abynv3qr4CEcIrlwoYcjLv4heTBCUAK2FacAXH
         k8Ltf04dLd1fyURoFT/bTtHfKuiZByf3KCrXKZ8otUhH2IYq1SiahwUGj36lFMoDQlLV
         I5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770026532; x=1770631332;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwfHEmwHgqmaeJTOVJvonKcURy7EasFZeX4UN3P+ruo=;
        b=GlDwjGZatu1ZegWOctmHUfOCBmKx56dqrbYwqd0tOR+Cp6PIqS5U8B8+HInx77vOIM
         gqdZLnWL15ie063rSITEGC7Ap7fpNJWyAXVfI8TnjXRJcg4xaqdDuceTqqvuf/Le7+0Q
         c6lwfCEMcQF17iQcQO9AyGX4KjejCCk7RTUIDl/MMXl+sMEWkPolfBQljPWVeTf4bPn3
         +fzdbrWoyrNS2V0FJLNAD++rkSCY6BTH48NRPGvlKDi1edN2TbjqSgqv6xhKGjZAWA9R
         cZrgNk/ZqbgtVZ9rS63bTzksOu8ZDi6cFOHn2YmPVejQtDjm01sqnqlHm0Ruxa7BuVfz
         IwwA==
X-Forwarded-Encrypted: i=1; AJvYcCUw438kB4iS+6m6xwHeyH8lpvvFPYEcfDXy8P5t097d/HWtF5CD0Ms4OVrPgSRnPailBLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDAr4NJV2gch50gPq1t/S4bJOsQxigzLrNJdNtZzehsbRSWGe/
	tqEvSXEw93tZbTD2SjxY66DQaMtx2Lbny+3noPXZnk9nmWiYd2Q99yl935RAfVdC6FFJXiQw+1F
	v1aPXqwtXbQeNSsDpJm+hsQLKt2CHIQ0=
X-Gm-Gg: AZuq6aJggxTMaLfbEfsKNMgqM3kcVa51Pxzd9fUymYRLi2USbeGe+DfPbkwpbAYze9+
	KjsSrzlJjw/yQMd4T5N0uQwta3Yz4HzZamcdDGfgQweeKZgTo78mBe8X4F0uqDfSfKCXehEbjV6
	HcbGUh2zDyFRcpV8Ad4QjzxizIxOb5c/dRLPTH4YOlsDsO85TaTT5/jR12xKaH4UFxh43YQNAcv
	KDlh2SZskI4irACICL5wgGZ2BIPkYUA/iZjBtYx+6j6bNgClQ2V7fZVdxjmut0i0MGXzCvMDfIb
	dilui6tkvZbdJc/bP0twTnmSXdqnzA==
X-Received: by 2002:a05:7022:418b:b0:11f:3d55:ab9a with SMTP id
 a92af1059eb24-125c0fa6663mr6562194c88.13.1770026531946; Mon, 02 Feb 2026
 02:02:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Feb 2026 05:02:08 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 2 Feb 2026 05:02:08 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260131190106.389289-2-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com> <20260131190106.389289-2-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 2 Feb 2026 05:02:08 -0500
X-Gm-Features: AZwV_Qim1Ue1C-5qEmULIfKsPKeThTh4KMEOyo-TU466a1nD59nmIWkDZhTPNj0
Message-ID: <CAOLa=ZRv4xsy0adY_BcXQkypsgYkLNM6x5LhJGX+B+=aKCwmgg@mail.gmail.com>
Subject: Re: [PATCH 1/3] wt-status: replace uses of the_repository with local
 repository instances
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000ae75380649d46aa5"

--000000000000ae75380649d46aa5
Content-Type: text/plain; charset="UTF-8"

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> Many instances of the_repository are used in wt-status.c even when a
> local repository is already available via struct wt_status or struct
> worktree.
>

One missing information is why is it safe to make this change? If is a
repository field, is it holding the same information, is it always
defined?

> Replace direct uses of the global the_repository with the repository
> instance carried by the local structs (e.g. s->repo, wt->repo).
>
> This helps reduce reliance on global repository state.
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
>  wt-status.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index e12adb26b9..9f4d8fda7f 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
>  	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
>  	s->use_color = GIT_COLOR_UNKNOWN;
>  	s->relative_paths = 1;
> -	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
> +	s->branch = refs_resolve_refdup(get_main_ref_store(s->repo),
>  					"HEAD", 0, NULL, NULL);

Wouldn't it make more sense to use the function argument 'r' here?

>  	s->reference = "HEAD";
>  	s->fp = stdout;
> -	s->index_file = repo_get_index_file(the_repository);
> +	s->index_file = repo_get_index_file(s->repo);
>  	s->change.strdup_strings = 1;
>  	s->untracked.strdup_strings = 1;
>  	s->ignored.strdup_strings = 1;
> @@ -646,7 +646,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
>
>  	repo_init_revisions(s->repo, &rev, NULL);
>  	memset(&opt, 0, sizeof(opt));
> -	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
> +	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
>  	setup_revisions(0, NULL, &rev, &opt);
>
>  	rev.diffopt.flags.override_submodule_config = 1;
> @@ -1146,7 +1146,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
>  	rev.diffopt.ita_invisible_in_index = 1;
>
>  	memset(&opt, 0, sizeof(opt));
> -	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
> +	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
>  	setup_revisions(0, NULL, &rev, &opt);
>
>  	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
> @@ -1317,9 +1317,9 @@ static int split_commit_in_progress(struct wt_status *s)
>  	    !s->branch || strcmp(s->branch, "HEAD"))
>  		return 0;
>
> -	if (refs_read_ref_full(get_main_ref_store(the_repository), "HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +	if (refs_read_ref_full(get_main_ref_store(s->repo), "HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>  			       &head_oid, &head_flags) ||
> -	    refs_read_ref_full(get_main_ref_store(the_repository), "ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +	    refs_read_ref_full(get_main_ref_store(s->repo), "ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>  			       &orig_head_oid, &orig_head_flags))
>  		return 0;
>  	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
> @@ -1432,7 +1432,7 @@ static void show_rebase_information(struct wt_status *s,
>  				i++)
>  				status_printf_ln(s, color, "   %s", have_done.items[i].string);
>  			if (have_done.nr > nr_lines_to_show && s->hints) {
> -				char *path = repo_git_path(the_repository, "rebase-merge/done");
> +				char *path = repo_git_path(s->repo, "rebase-merge/done");
>  				status_printf_ln(s, color,
>  					_("  (see more in file %s)"), path);
>  				free(path);
> @@ -1534,7 +1534,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
>  	else
>  		status_printf_ln(s, color,
>  			_("You are currently cherry-picking commit %s."),
> -			repo_find_unique_abbrev(the_repository, &s->state.cherry_pick_head_oid,
> +			repo_find_unique_abbrev(s->repo, &s->state.cherry_pick_head_oid,
>  						DEFAULT_ABBREV));
>
>  	if (s->hints) {
> @@ -1564,7 +1564,7 @@ static void show_revert_in_progress(struct wt_status *s,
>  	else
>  		status_printf_ln(s, color,
>  			_("You are currently reverting commit %s."),
> -			repo_find_unique_abbrev(the_repository, &s->state.revert_head_oid,
> +			repo_find_unique_abbrev(s->repo, &s->state.revert_head_oid,
>  						DEFAULT_ABBREV));
>  	if (s->hints) {
>  		if (has_unmerged(s))
> @@ -1624,7 +1624,7 @@ static char *get_branch(const struct worktree *wt, const char *path)
>  	struct object_id oid;
>  	const char *branch_name;
>
> -	if (strbuf_read_file(&sb, worktree_git_path(the_repository, wt, "%s", path), 0) <= 0)
> +	if (strbuf_read_file(&sb, worktree_git_path(wt->repo, wt, "%s", path), 0) <= 0)
>  		goto got_nothing;
>
>  	while (sb.len && sb.buf[sb.len - 1] == '\n')
> @@ -1691,7 +1691,7 @@ static void wt_status_get_detached_from(struct repository *r,
>  	char *ref = NULL;
>
>  	strbuf_init(&cb.buf, 0);
> -	if (refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository), "HEAD", grab_1st_switch, &cb) <= 0) {
> +	if (refs_for_each_reflog_ent_reverse(get_main_ref_store(r), "HEAD", grab_1st_switch, &cb) <= 0) {
>  		strbuf_release(&cb.buf);
>  		return;
>  	}
> @@ -1723,18 +1723,18 @@ int wt_status_check_rebase(const struct worktree *wt,
>  {
>  	struct stat st;
>
> -	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
> -		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
> +	if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply"), &st)) {
> +		if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply/applying"), &st)) {

In the same file we make a call 'wt_status_check_rebase(NULL, state)',
so wouldn't this break?

>  			state->am_in_progress = 1;
> -			if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/patch"), &st) && !st.st_size)
> +			if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply/patch"), &st) && !st.st_size)
>  				state->am_empty_patch = 1;
>  		} else {
>  			state->rebase_in_progress = 1;
>  			state->branch = get_branch(wt, "rebase-apply/head-name");
>  			state->onto = get_branch(wt, "rebase-apply/onto");
>  		}
> -	} else if (!stat(worktree_git_path(the_repository, wt, "rebase-merge"), &st)) {
> -		if (!stat(worktree_git_path(the_repository, wt, "rebase-merge/interactive"), &st))
> +	} else if (!stat(worktree_git_path(wt->repo, wt, "rebase-merge"), &st)) {
> +		if (!stat(worktree_git_path(wt->repo, wt, "rebase-merge/interactive"), &st))
>  			state->rebase_interactive_in_progress = 1;
>  		else
>  			state->rebase_in_progress = 1;
> @@ -1750,7 +1750,7 @@ int wt_status_check_bisect(const struct worktree *wt,
>  {
>  	struct stat st;
>
> -	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
> +	if (!stat(worktree_git_path(wt->repo, wt, "BISECT_LOG"), &st)) {
>  		state->bisect_in_progress = 1;
>  		state->bisecting_from = get_branch(wt, "BISECT_START");
>  		return 1;
> @@ -2099,7 +2099,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>  		upstream_is_gone = 1;
>  	}
>
> -	short_base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
> +	short_base = refs_shorten_unambiguous_ref(get_main_ref_store(s->repo),
>  						  base, 0);
>  	color_fprintf(s->fp, header_color, "...");
>  	color_fprintf(s->fp, branch_color_remote, "%s", short_base);
> @@ -2233,7 +2233,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
>  		ab_info = stat_tracking_info(branch, &nr_ahead, &nr_behind,
>  					     &base, 0, s->ahead_behind_flags);
>  		if (base) {
> -			base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
> +			base = refs_shorten_unambiguous_ref(get_main_ref_store(s->repo),
>  							    base, 0);
>  			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
>  			free((char *)base);
> --
> 2.52.0

--000000000000ae75380649d46aa5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a98e7583ecc7cfcd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tQWRod1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGJsREFDQm04anR0eTZISW1sR1g4aGxPb2xWeWRKeQpNMGNUZXN5Y1RX
VFJ2VjJHOXZtWDBzTXcxZ3BHM1BqazdhSkxiUWM1RUZManBlNnhVZlZ2STV3bXZ2TTZvbTg0ClNn
NVN4MTZsa0l1M0xhbDlmMVRjRjdlZGRVc1pvaFJmVEJEY3kyeFR4czVOUHJSZjZQMmIvTmxOdG5a
S0xEMVMKdnRCK2xyaFdmRVhvVDVJYVV3SmR1S0lVRHRvOWxCdkw0YW45ZzJMWldKa2xMZUN1TVhr
clBLNlAxd1RmbzdHWQpra0VZcUkvblJlRXJocnVQLzNoZmlRcGRYWXZCMzRWamY2N3IxZHlJKzFz
aW1LQzZuUEJiNWNvNnFWMFRNRUc3CktabUlCM0xFVnE2U2JIc2IrRFo4N3VZQ205UnlNNlYxSzM0
SlI2VTh5akdGcGVjbzZBK0cxckVuSklRWmlIeXMKcUIrSWFUR0t4c0tiMTI2aG5uMnpaN01DQzRN
bTU3TXFHZlZsald1N1d0Y1NNY0xZM2xGa1F6d2t5ZjVkdE4yYwoycDRzRU5zZ3lJM0dieGd6em5Q
Z0dmdFJ6dGQ2ZzNkSEZYRElXNTlaNmhUYjFsTlR2VUFtWXkweDFNZlZtQmVFCm5LVFhOT1BOajFo
TWhwb01TZ01EOTRDRjAwMFVHenV6WkYvZEhRST0KPVFZZDYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ae75380649d46aa5--
