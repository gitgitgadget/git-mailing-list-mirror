Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A06248864
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362217; cv=none; b=OVoJ4guKb+UdGas/Ajuk6fuyQM0h/RLiB7CxDbGiKMU10urp85IdHDaK78pZGxA0OaGY4/izw+wscu5nTBLYYgSwlZFUc/hg87WBG9FcJGA0Rq81Xurz4ZPjTwKfvo687fHXu/Vyr/c4b8ROKZ7+Lb7Sd8Ij1uttMpVtpeOyBp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362217; c=relaxed/simple;
	bh=IZwRfzUINroitrEoQIxXE/fGMwqCwVMOSsujbDKnBW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbqsuHQ0EpllZwwXaImHhj7ZfaCkMqbDCfmvPPhrq9NyLJ9bNSJU7bdbjdWLhM7PGZ1MWBthnJF/XVhue4oRq++D1US+L/qw7IXRprywOBAoxkxmecixRvjB7Oqob/VQ9z9iAEP3lGvPRuFNycBPSuSPj9mJI4DXlrokbkKPctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RjNx8xnd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NNoA3/MO; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RjNx8xnd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NNoA3/MO"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 207E07A070B;
	Thu, 24 Jul 2025 09:03:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 24 Jul 2025 09:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753362213; x=1753448613; bh=ts4PZkMmVu
	tFZIWqJY/NutRkZFU/CR1guAFF7sONeqE=; b=RjNx8xndEulVQGF8k5HK4n04K+
	8m7j20Xt1P+6voGaT4tqcWS9AIDk+XLKD8qzLd+BANyCLAPFDjJQC3GsEBOQP6t4
	LUA/QJbNPMsGbNnRaqtkmKfAnBjY7Xp+pRK7w3DiKofm4HaPSjS66MXJFDtFRz3Z
	svY5n8EQc+v3SUZIHH3/Uo0zJ5AZvQ04/+pxabOFIZbT+jO178FRXaGg2sqfK2hD
	Vk0K4ol6bJK3oKh/HDIn3P2uYD8tPuBlNlRSHdFI44L06eRwbfoOc+8ZioiXEwcH
	831PH5kws9ROB+7vVKMt1st6r2cJcCH5j+MYJBwAggFqsxndYbSK/j5FG6rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753362213; x=1753448613; bh=ts4PZkMmVutFZIWqJY/NutRkZFU/CR1guAF
	F7sONeqE=; b=NNoA3/MOZEA1poBbTPs3wZLY8j2rnQ18JOZeUe4vftB1P/Eze2u
	Ncxiplk4NFJmXqIDuQctsOw8m2pwMV49dK/u9ZaVc7anoQRcUSfk3B4mMHQUzJIm
	S+WtLxcSc+YRq0aiZxKuknSiSeOoHBBETREkV3yuMZzo0SQ+8TKHyV1RMCEKrQUs
	aMCruP8XhAXliaIRJak3FR3d0XAgW7Ywd0Jl0w020pDetQZ2h/1xX/zhhLw3QS/c
	iL7WLhEDbVz/xQPvnyratnp6krjwM7kaNyxKAUhJdbLcaxNihjygj3fBNtFweG6T
	ohlGgoPcECcigkSn4Un7r5uD3b+6+h3ICDg==
X-ME-Sender: <xms:JS-CaOw_Sb073mCrDFjAtBDyQMJq32LQ_M2_L7vBnJcUTa40tLx7Tw>
    <xme:JS-CaNhHrDGey_CG-3e6d5bF2vGnt1gLo-WtSYCTbzctoyUSP41EmuB6UGxcvLivZ
    h9dZWo5l7_dYChGtw>
X-ME-Received: <xmr:JS-CaJwq0WIE1NyTqo43h59R_xvyiB9pJbFArMYv5GGAhxgJsGcQENk84BRUsbZ0wfHZc_oUDRP2ifFECCkdZeHx4qrE8PdaxufVIJh8n6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:JS-CaALIiPlH95dc8QR__CWjpEv2wEQ_jxpt4r-wZtrV8NYsO23jmw>
    <xmx:JS-CaAR2WEsQPWl8_u6AwYqZN40vaxe8M9h5nw-KKEz6l-gsXs0jhw>
    <xmx:JS-CaIrhNECPiHprCgR-uVsdOcExPJnlaVHfkclTRqVbqPfDdLWBqg>
    <xmx:JS-CaFrEjNPt076dvGEoywhCrTGX21YXDDqQR50Mr81g8cqB135l-w>
    <xmx:JS-CaFJqcaaJatvxY1nlXO_a_f48x5I5o2YOkWR0nBhtSnz5-oCm557e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 09:03:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f0137ffa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 13:03:31 +0000 (UTC)
Date: Thu, 24 Jul 2025 15:03:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Han Jiang <jhcarl0814@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: `git remote rename` does not work when
 `refs/remotes/server/HEAD` is unborn (when right after `git remote add -m`)
Message-ID: <aIIvHxR8wXLTCgMW@pks.im>
References: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>
 <20250724104536.GA1316505@coredump.intra.peff.net>
 <aIIf7S5iPspktxdw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIIf7S5iPspktxdw@pks.im>

On Thu, Jul 24, 2025 at 01:58:37PM +0200, Patrick Steinhardt wrote:
> On Thu, Jul 24, 2025 at 06:45:36AM -0400, Jeff King wrote:
> > On Thu, Jul 24, 2025 at 09:59:45PM +1200, Han Jiang wrote:
> > 
> > > What did you expect to happen? (Expected behavior)
> > > 
> > > `git symbolic-ref 'refs/remotes/server/HEAD'` outputs
> > > "refs/remotes/server/master";
> > > `git symbolic-ref 'refs/remotes/server2/HEAD'` outputs
> > > "refs/remotes/server2/master".
> > > 
> > > What happened instead? (Actual behavior)
> > > 
> > > `git symbolic-ref 'refs/remotes/server/HEAD'` outputs
> > > "refs/remotes/server/master";
> > > `git symbolic-ref 'refs/remotes/server2/HEAD'` outputs "fatal: ref
> > > refs/remotes/server2/HEAD is not a symbolic ref".
> > > `git symbolic-ref 'refs/remotes/server/HEAD'` outputs
> > > "refs/remotes/server/master".
> > 
> > Thanks for the report. I can reproduce the issue easily here. Probably a
> > simpler reproduction is just:
> > 
> >   git init
> >   git remote add -m whatever server1 /does/not/need/to/exist
> >   git remote rename server1 server2
> >   git symbolic-ref refs/remotes/server2/HEAD
> > 
> > The problem is that the branch-renaming code in git-remote is not
> > prepared to handle symrefs that don't resolve. This seems to make it
> > work:
> > 
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index 5dd6cbbaee..478ea3a80c 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -630,7 +630,9 @@ static int read_remote_branches(const char *refname, const char *referent UNUSED
> >  	if (starts_with(refname, buf.buf)) {
> >  		item = string_list_append(rename->remote_branches, refname);
> >  		symref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
> > -						 refname, RESOLVE_REF_READING,
> > +						 refname,
> > +						 RESOLVE_REF_READING |
> > +						 RESOLVE_REF_NO_RECURSE,
> >  						 NULL, &flag);
> >  		if (symref && (flag & REF_ISSYMREF)) {
> >  			item->util = xstrdup(symref);
> > @@ -835,8 +837,8 @@ static int mv(int argc, const char **argv, const char *prefix,
> >  	 * First remove symrefs, then rename the rest, finally create
> >  	 * the new symrefs.
> >  	 */
> > -	refs_for_each_ref(get_main_ref_store(the_repository),
> > -			  read_remote_branches, &rename);
> > +	refs_for_each_rawref(get_main_ref_store(the_repository),
> > +			     read_remote_branches, &rename);
> >  	if (show_progress) {
> >  		/*
> >  		 * Count symrefs twice, since "renaming" them is done by
> > 
> > That is, we need two fixes:
> > 
> >   1. When iterating over the refs, we need to cover _all_ refs, not just
> >      those that fully resolve (there's a related bug here: we'll
> >      silently ignore an actual broken or corrupt ref, whereas I think
> >      the right thing would probably be to try copying it and then
> >      complain loudly if we don't have the object).
> > 
> >   2. When resolving each one, we shouldn't recurse. We're doing a
> >      shallow copy, not a deep one.
> > 
> > Reading this code, though, I can't help but think that the recent "git
> > refs migrate" command had to deal with all of these problems. I wonder
> > if we could reuse its code. +cc pks for wisdom.
> 
> I'm not sure whether we can easily reuse the code -- the use case is
> quite different, as the migration works across two totally independent
> refdbs. So all refs are recreated 1:1, without any renaming involved.
> 
> But it certainly seems to me like this whole logic could use quite some
> love:
> 
>   - We create N+M*2 separate ref transactions, where N is the number of
>     direct remote refs we need to migrate and M is the number of
>     symbolic refs. This is bad with the "reftable" backend, but given
>     that the N transactions are all renames that have to delete the old
>     ref it's even quadratic in the worst case for the "files" backend
>     because we may have to rewrite the packed-refs file for each such
>     transaction.
> 
>   - It is way too brittle, as the update isn't even pretending to be
>     atomic. We first delete everything, and then we recreate it. So if
>     any of these updates fails we'll be left in an in-between state.
> 
>   - We shouldn't have to even call `refs_resolve_ref_unsafe()` at all,
>     as the `read_remote_branches()` nowadays gets the referent as
>     parameter.
> 
> To demonstrate:
> 
>      $ git init --ref-format=files repo
>     Initialized empty Git repository in /tmp/repo/.git/
>      $ cd repo/
>      /tmp/repo:HEAD $ git commit --allow-empty -m initial
>     [main (root-commit) 00c2622] x
>      $ git remote add origin /dev/null
>      /tmp/repo:main $ for i in $(seq 100000); do printf "create refs/remotes/origin/branch-%d HEAD\n" $i; done | git update-ref --stdin
>      /tmp/repo:main $ git pack-refs --all
>      /tmp/repo:main $ time git remote rename origin renamed
>     Renaming remote references:   0% (2216/100000)
> 
> I stopped after a minute -- this will take hours to complete.
> 
> So I think we should adapt this logic to use a single transaction.
> There's one catch, as refs_rename_ref()` also migrates any reflogs that
> exist. But with the recent infra that Karthik has added we can now also
> migrate reflogs, so that's all doable.
> 
> Patrick

I've quickly hacked something together now, see the work-in-progress
patch below. The patch does not yet handle reflogs, but that isn't too
hard to implement.

And these changes indeed speed up things by quite a lot: instead of
hours it now takes 7 seconds :) I'll polish this patch series and will
likely send it in tomorrow.

Patrick

diff --git a/builtin/remote.c b/builtin/remote.c
index 5dd6cbbaeed..072a70e6b45 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -612,36 +612,53 @@ static int add_branch_for_removal(const char *refname,
 struct rename_info {
 	const char *old_name;
 	const char *new_name;
-	struct string_list *remote_branches;
 	uint32_t symrefs_nr;
+	struct ref_transaction *transaction;
+	struct strbuf *err;
 };
 
-static int read_remote_branches(const char *refname, const char *referent UNUSED,
-				const struct object_id *oid UNUSED,
-				int flags UNUSED, void *cb_data)
+static int queue_one_rename(const char *refname, const char *referent,
+			    const struct object_id *oid,
+			    int flags, void *cb_data)
 {
+	struct strbuf new_refname = STRBUF_INIT, new_referent = STRBUF_INIT;
 	struct rename_info *rename = cb_data;
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list_item *item;
-	int flag;
-	const char *symref;
-
-	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
-	if (starts_with(refname, buf.buf)) {
-		item = string_list_append(rename->remote_branches, refname);
-		symref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						 refname, RESOLVE_REF_READING,
-						 NULL, &flag);
-		if (symref && (flag & REF_ISSYMREF)) {
-			item->util = xstrdup(symref);
-			rename->symrefs_nr++;
-		} else {
-			item->util = NULL;
-		}
+	int error;
+
+	strbuf_addf(&new_refname, "refs/remotes/%s/", rename->old_name);
+	if (!starts_with(refname, new_refname.buf)) {
+		error = 0;
+		goto out;
 	}
-	strbuf_release(&buf);
 
-	return 0;
+	if (flags & REF_ISSYMREF) {
+		strbuf_addstr(&new_referent, referent);
+		strbuf_splice(&new_referent, strlen("refs/remotes/"), strlen(rename->old_name),
+			      rename->new_name, strlen(rename->new_name));
+		oid = NULL;
+	}
+
+	error = ref_transaction_delete(rename->transaction, refname,
+				       oid, referent, REF_NO_DEREF, NULL, rename->err);
+	if (error < 0)
+		goto out;
+
+	strbuf_reset(&new_refname);
+	strbuf_addstr(&new_refname, refname);
+	strbuf_splice(&new_refname, strlen("refs/remotes/"), strlen(rename->old_name),
+		      rename->new_name, strlen(rename->new_name));
+
+	error = ref_transaction_update(rename->transaction, new_refname.buf, oid,
+				       null_oid(the_hash_algo), (flags & REF_ISSYMREF) ? new_referent.buf : NULL, NULL,
+				       REF_SKIP_CREATE_REFLOG | REF_NO_DEREF | REF_SKIP_OID_VERIFICATION,
+				       NULL, rename->err);
+	if (error < 0)
+		goto out;
+
+out:
+	strbuf_release(&new_refname);
+	strbuf_release(&new_referent);
+	return error;
 }
 
 static int migrate_file(struct remote *remote)
@@ -740,12 +757,10 @@ static int mv(int argc, const char **argv, const char *prefix,
 		OPT_END()
 	};
 	struct remote *oldremote, *newremote;
-	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT,
-		old_remote_context = STRBUF_INIT;
-	struct string_list remote_branches = STRING_LIST_INIT_DUP;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT,
+		old_remote_context = STRBUF_INIT, err = STRBUF_INIT;
 	struct rename_info rename;
-	int i, refs_renamed_nr = 0, refspec_updated = 0;
-	struct progress *progress = NULL;
+	int i, refspec_updated = 0;
 	int result = 0;
 
 	argc = parse_options(argc, argv, prefix, options,
@@ -756,8 +771,8 @@ static int mv(int argc, const char **argv, const char *prefix,
 
 	rename.old_name = argv[0];
 	rename.new_name = argv[1];
-	rename.remote_branches = &remote_branches;
 	rename.symrefs_nr = 0;
+	rename.err = &err;
 
 	oldremote = remote_get(rename.old_name);
 	if (!remote_is_configured(oldremote, 1)) {
@@ -831,80 +846,28 @@ static int mv(int argc, const char **argv, const char *prefix,
 	if (!refspec_updated)
 		goto out;
 
-	/*
-	 * First remove symrefs, then rename the rest, finally create
-	 * the new symrefs.
-	 */
-	refs_for_each_ref(get_main_ref_store(the_repository),
-			  read_remote_branches, &rename);
-	if (show_progress) {
-		/*
-		 * Count symrefs twice, since "renaming" them is done by
-		 * deleting and recreating them in two separate passes.
-		 */
-		progress = start_progress(the_repository,
-					  _("Renaming remote references"),
-					  rename.remote_branches->nr + rename.symrefs_nr);
-	}
-	for (i = 0; i < remote_branches.nr; i++) {
-		struct string_list_item *item = remote_branches.items + i;
-		struct strbuf referent = STRBUF_INIT;
-
-		if (refs_read_symbolic_ref(get_main_ref_store(the_repository), item->string,
-					   &referent))
-			continue;
-		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, item->string, NULL, REF_NO_DEREF))
-			die(_("deleting '%s' failed"), item->string);
-
-		strbuf_release(&referent);
-		display_progress(progress, ++refs_renamed_nr);
-	}
-	for (i = 0; i < remote_branches.nr; i++) {
-		struct string_list_item *item = remote_branches.items + i;
+	rename.transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
+							 0, &err);
+	if (!rename.transaction)
+		goto out;
 
-		if (item->util)
-			continue;
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, item->string);
-		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
-				rename.new_name, strlen(rename.new_name));
-		strbuf_reset(&buf2);
-		strbuf_addf(&buf2, "remote: renamed %s to %s",
-				item->string, buf.buf);
-		if (refs_rename_ref(get_main_ref_store(the_repository), item->string, buf.buf, buf2.buf))
-			die(_("renaming '%s' failed"), item->string);
-		display_progress(progress, ++refs_renamed_nr);
-	}
-	for (i = 0; i < remote_branches.nr; i++) {
-		struct string_list_item *item = remote_branches.items + i;
+	result = refs_for_each_rawref(get_main_ref_store(the_repository),
+				      queue_one_rename, &rename);
+	if (result < 0)
+		die(_("renaming references failed: %s"), rename.err->buf);
 
-		if (!item->util)
-			continue;
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, item->string);
-		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
-				rename.new_name, strlen(rename.new_name));
-		strbuf_reset(&buf2);
-		strbuf_addstr(&buf2, item->util);
-		strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old_name),
-				rename.new_name, strlen(rename.new_name));
-		strbuf_reset(&buf3);
-		strbuf_addf(&buf3, "remote: renamed %s to %s",
-				item->string, buf.buf);
-		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, buf3.buf))
-			die(_("creating '%s' failed"), buf.buf);
-		display_progress(progress, ++refs_renamed_nr);
-	}
-	stop_progress(&progress);
+	result = ref_transaction_commit(rename.transaction, &err);
+	if (result < 0)
+		die(_("committing renamed references failed: %s"), rename.err->buf);
 
 	handle_push_default(rename.old_name, rename.new_name);
 
 out:
-	string_list_clear(&remote_branches, 1);
+	ref_transaction_free(rename.transaction);
 	strbuf_release(&old_remote_context);
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
-	strbuf_release(&buf3);
+	strbuf_release(&err);
 	return result;
 }
 
