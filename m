Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE691D89E3
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 23:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749510199; cv=none; b=ZH+VGKhqDlQXwyAZiMWWuUiMk+rkngD/nLh5+0bu839xOv7YeWy99JoemnmOuyBnTHCKcDTRDjuaq4gV4fXW2POWMHOAf2yLbu02shZ97ZIi0dlhRsKlccZ6XyJiutk5hhIXpefTGW6BQVzLYB2QUD3HhqU/GVmY4BfA/MUuW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749510199; c=relaxed/simple;
	bh=kyEPzqsLA01bMtY7CZn6T7EVhReZGXPyW+nh0NZzoh0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TWwrHv/iaXi0VncpDK7DvewXmXsLJ+LwyIw5mQCaaS7CNYxv1GY6niw2Vyb0JmO06onp+nVP60DoC31c8O+dHuZbPcPbtaO403VGVgGOONS2kJOlbhtSeJccMUSsv3QgC3D4EeWEuqkrmQCgzqrfKj1/WCiuliq5DMNPzLqp6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yubRvPp+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jmvgmhoq; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yubRvPp+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jmvgmhoq"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0FD2625402F4;
	Mon,  9 Jun 2025 19:03:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 09 Jun 2025 19:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749510195;
	 x=1749596595; bh=hXzipK1MeWlfcJyhCvp8AOzekBCmEpmeTMAaisTZzJk=; b=
	yubRvPp+TBE4mSXSwLGkvEbZTqsvD/fIqk4C/Hosm2/v6eZtZhuk7vTVlU25d+cN
	liXI7JICP56XWf7YX3SxDTinJYInqHCTekKbbpFsTsgdzBV1OawGlFbFkTPvBORq
	Xdvh54xleHAn2NpFTWFur9DjMeqABlVX2VyNcdBkFRFAmvmMSrPvE90g8uYvAhoS
	8C7k5aDlk+YHA4LrUo7cYJIxmmTt216VuIXa38wr4L2O8t/IpXo9WtdXc9y0DJ4u
	nmVB5Bbq7K/q5GCzTwxUyYLpzffxEtsO1Xz/dYUTtmOX1+R/hFiLF8n40f9E5iSH
	3/6X3CyNepaHSSSu06BENA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749510195; x=
	1749596595; bh=hXzipK1MeWlfcJyhCvp8AOzekBCmEpmeTMAaisTZzJk=; b=J
	mvgmhoqr/D+yc4YmRTzwCmseJPKP00z+aP58FMsMBnLinGnDJLha42ELovO40bd5
	mVAE85hI+kJtH6fHf1wGxXkcGcAH+PP4Z85/xT5qkfytsK4rqQDMkMbt46y74hMk
	D9MfDH8BHaONO5oV7ZO2fzrovhnB/jaQq0ALgVAIsO5R3fVfz+ArPcQWSkUnvyTt
	sEAC/lFVf3eWmREuYsTSNdkZDjjQKThX7oqilscUTob8p5TyRmTs5U5e2GZ+EoAb
	x1pFJYtpJlf3blr+E0msBbNtyCEjk7XiKmFFpcOLEqSfXOpOeS7kRWwsJkjwJ7vU
	So9sQC4pWGni4dXlnBI1A==
X-ME-Sender: <xms:M2hHaJqCsm_J92K6hlMDmCcDr-THk7hR8w8a0bp3lGyGJSiVCRp3DA>
    <xme:M2hHaLoTRipgQKEk6OSyYFIWVW1See6FNR6Y_bakd0O6AT6h_tieK334nAKFrHh7t
    dd_PRKwVIJGX20VHw>
X-ME-Received: <xmr:M2hHaGPaZ2jNVrKExU8igk_LsvBL7I1q593p7xG6qWvhDRuIkqpcXP_9ks5asRw4uM_2IYqHqczli9qFLJJAaM86PF-m9fEgCJHR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptd
    ffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepohihshhtfigrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:M2hHaE5alDRSnHq7AGZ3UgUwFRlTQUvC4Fesx2xj0vLlY4Ch40xcTA>
    <xmx:M2hHaI5LeMwUCpFWhNWiIIm978oO1g3FTpZ4tjC2sof51HzERscJxw>
    <xmx:M2hHaMhb6G5fHknKZl_KAHhysPdKK5DUv6BoqgULk4KRh194r0BoxQ>
    <xmx:M2hHaK5VYnqsFmcKIE4_v7uAESagCUNU0H-HAqyNF_yAkh13dQDzRw>
    <xmx:M2hHaPWrD1mif5-qOB_wT3NvDgVj8w-EKUaToQ9BAAvZnGcQsXLaz6n2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 19:03:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rebase: write script before initializing state
In-Reply-To: <20250609221055.136074-1-oystwa@gmail.com> (=?utf-8?Q?=22?=
 =?utf-8?Q?=C3=98ystein?= Walle"'s
	message of "Tue, 10 Jun 2025 00:10:55 +0200")
References: <20250609221055.136074-1-oystwa@gmail.com>
Date: Mon, 09 Jun 2025 16:03:13 -0700
Message-ID: <xmqqa56gplfy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Øystein Walle <oystwa@gmail.com> writes:

> ...
> By attempting to write the rebase script before initializing the state
> this potential scenario is avoided.
> ---

Missing sign-off.

> The diff looks perhaps more messy than required. The only required
> change is the filling in of make_script_args and the call to
> sequencer_make_script() above the call to init_basic_state(). But then
> the `if (ret)` looks out of place, and moving that up means adding `goto
> cleanup` which means the code that was previously the else case can be
> dedented.

"git show --histogram" may do a lot better job than the default
algorithm used by "git show" for this patch.

diff --git a/builtin/rebase.c b/builtin/rebase.c
index d4715ed35d..06da8e4f36 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -283,53 +283,53 @@ static int init_basic_state(struct replay_opts *opts, const char *head_name,
 static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 {
 	int ret = -1;
 	char *revisions = NULL, *shortrevisions = NULL;
 	struct strvec make_script_args = STRVEC_INIT;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	struct replay_opts replay = get_replay_opts(opts);
 
 	if (get_revision_ranges(opts->upstream, opts->onto, &opts->orig_head->object.oid,
 				&revisions, &shortrevisions))
 		goto cleanup;
 
+	strvec_pushl(&make_script_args, "", revisions, NULL);
+	if (opts->restrict_revision)
+		strvec_pushf(&make_script_args, "^%s",
+			     oid_to_hex(&opts->restrict_revision->object.oid));
+
+	ret = sequencer_make_script(the_repository, &todo_list.buf,
+				    make_script_args.nr, make_script_args.v,
+				    flags);
+	if (ret) {
+		error(_("could not generate todo list"));
+		goto cleanup;
+	}
+
 	if (init_basic_state(&replay,
 			     opts->head_name ? opts->head_name : "detached HEAD",
 			     opts->onto, &opts->orig_head->object.oid))
 		goto cleanup;
 
 	if (!opts->upstream && opts->squash_onto)
 		write_file(path_squash_onto(), "%s\n",
 			   oid_to_hex(opts->squash_onto));
 
-	strvec_pushl(&make_script_args, "", revisions, NULL);
-	if (opts->restrict_revision)
-		strvec_pushf(&make_script_args, "^%s",
-			     oid_to_hex(&opts->restrict_revision->object.oid));
+	discard_index(the_repository->index);
+	if (todo_list_parse_insn_buffer(the_repository, &replay,
+					todo_list.buf.buf, &todo_list))
+		BUG("unusable todo list");
 
-	ret = sequencer_make_script(the_repository, &todo_list.buf,
-				    make_script_args.nr, make_script_args.v,
-				    flags);
-
-	if (ret)
-		error(_("could not generate todo list"));
-	else {
-		discard_index(the_repository->index);
-		if (todo_list_parse_insn_buffer(the_repository, &replay,
-						todo_list.buf.buf, &todo_list))
-			BUG("unusable todo list");
-
-		ret = complete_action(the_repository, &replay, flags,
-			shortrevisions, opts->onto_name, opts->onto,
-			&opts->orig_head->object.oid, &opts->exec,
-			opts->autosquash, opts->update_refs, &todo_list);
-	}
+	ret = complete_action(the_repository, &replay, flags,
+		shortrevisions, opts->onto_name, opts->onto,
+		&opts->orig_head->object.oid, &opts->exec,
+		opts->autosquash, opts->update_refs, &todo_list);
 
 cleanup:
 	replay_opts_release(&replay);
 	free(revisions);
 	free(shortrevisions);
 	todo_list_release(&todo_list);
 	strvec_clear(&make_script_args);
 
 	return ret;
 }
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index fcc40d6fe1..d4c624b841 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -394,6 +394,16 @@ test_expect_success 'autosquash with empty custom instructionFormat' '
 	)
 '
 
+test_expect_success 'autosquash with invalid custom instructionFormat' '
+	git reset --hard base &&
+	test_commit invalid-instructionFormat-test &&
+	(
+		test_must_fail git -c rebase.instructionFormat=blah \
+			rebase --autosquash  --force-rebase -i HEAD^ &&
+		test_path_is_missing .git/rebase-merge
+	)
+'
+
 set_backup_editor () {
 	write_script backup-editor.sh <<-\EOF
 	cp "$1" .git/backup-"$(basename "$1")"
