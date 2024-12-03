Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84879204F77
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262190; cv=none; b=cOIj4bxbm3DH4G10+Ly892u0cxA8Fex5FRdW8j7EeU7rR9c8G+NRpqomC+yXBeCO/21lgrNa2/6O4BW25D7Zt/E7jLOFhKubohgxl/x+MS/pPNhcE7mFnwWfndzIrYXN2EEwM8mffsGJwnacveq/NpR8EbBp2p95SyqwttzJ67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262190; c=relaxed/simple;
	bh=Hf+yRiOiuWnMamSgKxGHFBBDpe5yDxRrHJbqrtmwnr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZqiBmhtNCCBxXwdJC1VrOAvX1Qm9/xGFPFKVOvIET7O00Kt150ezdPmY6TNpmKHyFS2EIGchzeRVGidwynGxkxVcB1+AjkPRJtwdlSSqM1zmEZFzqMuPKrDXRUoubLx9Z/vjJJDjABuEw/ODM+bYgvnk1MCWZl7XQHn2+lMsL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcy7KbvU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcy7KbvU"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2eec0bad68dso2839030a91.2
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 13:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733262188; x=1733866988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xUqPyItVixpsNT9bgW+7+kO0BFiiFlZgGMTOk0VpKI0=;
        b=hcy7KbvUY0MwjDAQ1h1FBYcwMp3iYUDiNSm1NsYH5+p+pRFD+rTw0XIVPBE1lVhJYj
         Mkpn6BG0YG2j+3SzB/rHjDGI/2E8h7oEPgtmOS8def92IYh/dlWzstzp1nDk2jAZAhr3
         Zaw+cSwU+U2UUl/GYeDsj61U1XED9OFeEweV4S41WABws7Muoksue5bYlNsK3ZONVScz
         PtbTng5IiHnGidCV4W7F1tM2RrrOIRUVlvYcB65B6JTouTgztg3zmFfLYQ9WQDod+tO/
         o591X9LjZIOXm90xTwcl10ZHe7dnOcjf2VYCh3Vzhe9ZdumHhWb6vWHeAVbY488rdTlv
         ZkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733262188; x=1733866988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUqPyItVixpsNT9bgW+7+kO0BFiiFlZgGMTOk0VpKI0=;
        b=gMnBOnV2ao/hN0U4969sB57dI49UEyPXMfmtH8RjN64cATZUhJfBF1TGedj18eIKhQ
         MURwme03rPFGCfo3metMeqFsESdozp1r3+Js77gNX67UKO0d1WHRM3uJZLVKUcNFUeeD
         WGCoPdfcNr3xTPtjylP/vsgnyGuWw7Dw+she5dFnaKcqiYmWe+P/7dX9hNZLqQ+ObjeH
         5BAnKfRDYtpElMXHnsjUzPQTRDCAOBI1lFdvsrS6am162V+M5B57wOvgctrvSsj/wfLJ
         oseecg4x6QfeiLaMfdSnYG8lW04rDcZUhnluPDNjD4+S2pxBaO7/r0RmVkn8nFVoWDII
         J9lQ==
X-Gm-Message-State: AOJu0YxPQhBQlHWc3+AZ1Qg3JS4gqVIPhjV8b9A/HPKo1tCAmiVm8weP
	d1CikkU711YHPCtNi9pZOdVGUD8ueiZLA4ZLCtKELeAyvFWsKx3pAZH3QJLBJA6nrKm0wruzzyQ
	+8T0wg9TJOVjwGmGdd0lf27/MjX7T+oqdbQPPG4pirEHwA3qCfH+qJ839+3lwMLjcibw8j1y0sA
	0W/jzG7XbxZMdJnBAQOvC1npbHQarViyQ2s5MzjfI783mBqMrbwlTDKsFJg/7z4D7hPg==
X-Google-Smtp-Source: AGHT+IGJly+0rc+JodMYyQQdWj0bUG4VFWNfSidQctTpAZomGoagPfgL567prD7zj20TFiK62WWPDA+YSx4soPfjTtTB
X-Received: from pjuw3.prod.google.com ([2002:a17:90a:d603:b0:2e0:52d7:183e])
 (user=jonathantanmy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a85:b0:2ee:e961:303d with SMTP id 98e67ed59e1d1-2ef01275c7dmr5579239a91.35.1733262187738;
 Tue, 03 Dec 2024 13:43:07 -0800 (PST)
Date: Tue,  3 Dec 2024 13:43:01 -0800
In-Reply-To: <cover.1733170252.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1733170252.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <cover.1733259949.git.jonathantanmy@google.com>
Subject: [PATCH v2 0/3] Performance improvements for repacking non-promisor objects
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, ps@pks.im, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Thanks everyone for the reviews.

The only code change is to invoke the repacking of non-promisor objects
into a promisor pack only when the first object that needs repacking
is detected. If not, there will be an empty pack created, which is the
cause of the failing tests Junio noticed.

Other than that, there are some code comments and commit message changes
as requested by reviews.

I've checked that all tests pass before and after merging with "seen".

Jonathan Tan (3):
  index-pack --promisor: dedup before checking links
  index-pack --promisor: don't check blobs
  index-pack --promisor: also check commits' trees

 builtin/index-pack.c | 101 +++++++++++++++++++++++++++++--------------
 1 file changed, 69 insertions(+), 32 deletions(-)

Range-diff against v1:
1:  5f0f114dbd ! 1:  7ae21c921f index-pack: dedup first during outgoing link check
    @@ Metadata
     Author: Jonathan Tan <jonathantanmy@google.com>
     
      ## Commit message ##
    -    index-pack: dedup first during outgoing link check
    +    index-pack --promisor: dedup before checking links
     
         Commit c08589efdc (index-pack: repack local links into promisor packs,
         2024-11-01) fixed a bug with what was believed to be a negligible
    @@ builtin/index-pack.c: static void repack_local_links(void)
     +	if (!oidset_size(&outgoing_links))
      		return;
      
    - 	base_name = mkpathdup("%s/pack/pack", repo_get_object_directory(the_repository));
    -@@ builtin/index-pack.c: static void repack_local_links(void)
    - 	if (start_command(&cmd))
    - 		die(_("could not start pack-objects to repack local links"));
    - 
    --	oidset_iter_init(&local_links, &iter);
    +-	base_name = mkpathdup("%s/pack/pack", repo_get_object_directory(the_repository));
     +	oidset_iter_init(&outgoing_links, &iter);
    - 	while ((oid = oidset_iter_next(&iter))) {
    ++	while ((oid = oidset_iter_next(&iter))) {
     +		struct object_info info = OBJECT_INFO_INIT;
     +		if (oid_object_info_extended(the_repository, oid, &info, 0))
     +			/* Missing; assume it is a promisor object */
     +			continue;
     +		if (info.whence == OI_PACKED && info.u.packed.pack->pack_promisor)
     +			continue;
    + 
    +-	strvec_push(&cmd.args, "pack-objects");
    +-	strvec_push(&cmd.args, "--exclude-promisor-objects-best-effort");
    +-	strvec_push(&cmd.args, base_name);
    +-	cmd.git_cmd = 1;
    +-	cmd.in = -1;
    +-	cmd.out = -1;
    +-	if (start_command(&cmd))
    +-		die(_("could not start pack-objects to repack local links"));
    ++		if (!cmd.args.nr) {
    ++			base_name = mkpathdup(
    ++				"%s/pack/pack",
    ++				repo_get_object_directory(the_repository));
    ++			strvec_push(&cmd.args, "pack-objects");
    ++			strvec_push(&cmd.args,
    ++				    "--exclude-promisor-objects-best-effort");
    ++			strvec_push(&cmd.args, base_name);
    ++			cmd.git_cmd = 1;
    ++			cmd.in = -1;
    ++			cmd.out = -1;
    ++			if (start_command(&cmd))
    ++				die(_("could not start pack-objects to repack local links"));
    ++		}
    + 
    +-	oidset_iter_init(&local_links, &iter);
    +-	while ((oid = oidset_iter_next(&iter))) {
      		if (write_in_full(cmd.in, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
      		    write_in_full(cmd.in, "\n", 1) < 0)
      			die(_("failed to feed local object to pack-objects"));
    + 	}
    ++
    ++	if (!cmd.args.nr)
    ++		return;
    ++
    + 	close(cmd.in);
    + 
    + 	out = xfdopen(cmd.out, "r");
     @@ builtin/index-pack.c: int cmd_index_pack(int argc,
      			} else if (skip_to_optional_arg(arg, "--keep", &keep_msg)) {
      				; /* nothing to do */
2:  300f53b8e3 ! 2:  5a63c9a5ca index-pack: no blobs during outgoing link check
    @@ Metadata
     Author: Jonathan Tan <jonathantanmy@google.com>
     
      ## Commit message ##
    -    index-pack: no blobs during outgoing link check
    +    index-pack --promisor: don't check blobs
     
         As a follow-up to the parent of this commit, it was found that not
         checking for the existence of blobs linked from trees sped up the fetch
         from 24m47.815s to 2m2.127s. Teach Git to do that.
     
    -    The benefit of doing this is as above (fetch speedup), but the drawback
    -    is that if the packfile to be indexed references a local blob directly
    -    (that is, not through a local tree), that local blob is in danger of
    -    being garbage collected. Such a situation may arise if we push local
    -    commits, including one with a change to a blob in the root tree,
    -    and then the server incorporates them into its main branch through a
    -    "rebase" or "squash" merge strategy, and then we fetch the new main
    -    branch from the server.
    -
    -    This situation has not been observed yet - we have only noticed missing
    -    commits, not missing trees or blobs. (In fact, if it were believed that
    -    only missing commits are problematic, one could argue that we should
    -    also exclude trees during the outgoing link check; but it is safer to
    -    include them.)
    -
    -    Due to the rarity of the situation (it has not been observed to happen
    -    in real life), and because the "penalty" in such a situation is merely
    -    to refetch the missing blob when it's needed, the tradeoff seems
    -    worth it.
    +    The tradeoff of not checking blobs is documented in a code comment.
     
         (Blobs may also be linked from tag objects, but it is impossible to know
         the type of an object linked from a tag object without looking it up in
    @@ Commit message
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
      ## builtin/index-pack.c ##
    +@@ builtin/index-pack.c: static void record_outgoing_link(const struct object_id *oid)
    + 	oidset_insert(&outgoing_links, oid);
    + }
    + 
    ++static void maybe_record_name_entry(const struct name_entry *entry)
    ++{
    ++	/*
    ++	 * The benefit of doing this is as above (fetch speedup), but the drawback
    ++is that if the packfile to be indexed references a local blob directly
    ++(that is, not through a local tree), that local blob is in danger of
    ++being garbage collected. Such a situation may arise if we push local
    ++commits, including one with a change to a blob in the root tree,
    ++and then the server incorporates them into its main branch through a
    ++"rebase" or "squash" merge strategy, and then we fetch the new main
    ++branch from the server.
    ++
    ++This situation has not been observed yet - we have only noticed missing
    ++commits, not missing trees or blobs. (In fact, if it were believed that
    ++only missing commits are problematic, one could argue that we should
    ++also exclude trees during the outgoing link check; but it is safer to
    ++include them.)
    ++
    ++Due to the rarity of the situation (it has not been observed to happen
    ++in real life), and because the "penalty" in such a situation is merely
    ++to refetch the missing blob when it's needed, the tradeoff seems
    ++worth it.
    ++	*/
    ++	if (S_ISDIR(entry->mode))
    ++		record_outgoing_link(&entry->oid);
    ++}
    ++
    + static void do_record_outgoing_links(struct object *obj)
    + {
    + 	if (obj->type == OBJ_TREE) {
     @@ builtin/index-pack.c: static void do_record_outgoing_links(struct object *obj)
    - 			 * verified, so do not print any here.
      			 */
      			return;
    --		while (tree_entry_gently(&desc, &entry))
    + 		while (tree_entry_gently(&desc, &entry))
     -			record_outgoing_link(&entry.oid);
    -+		while (tree_entry_gently(&desc, &entry)) {
    -+			if (S_ISDIR(entry.mode))
    -+				record_outgoing_link(&entry.oid);
    -+		}
    ++			maybe_record_name_entry(&entry);
      	} else if (obj->type == OBJ_COMMIT) {
      		struct commit *commit = (struct commit *) obj;
      		struct commit_list *parents = commit->parents;
3:  2f2f0db78b ! 3:  8139325bf2 index-pack: commit tree during outgoing link check
    @@ Metadata
     Author: Jonathan Tan <jonathantanmy@google.com>
     
      ## Commit message ##
    -    index-pack: commit tree during outgoing link check
    +    index-pack --promisor: also check commits' trees
     
         Commit c08589efdc (index-pack: repack local links into promisor packs,
         2024-11-01) seems to contain an oversight in that the tree of a commit
    -    is not checked. The fix slows down a fetch from a certain repo at
    -    $DAYJOB from 2m2.127s to 2m45.052s, but in order to make the fetch
    -    correct, it seems worth it.
    +    is not checked. Teach git to check these trees.
    +
    +    The fix slows down a fetch from a certain repo at $DAYJOB from 2m2.127s
    +    to 2m45.052s, but in order to make the fetch correct, it seems worth it.
     
         In order to test this, we could create server and client repos as
         follows...
    @@ Commit message
     
         (O and C are commits both on the client and server. S is a commit
         only on the server. C and S have the same tree but different commit
    -    messages.)
    +    messages. The diff between O and C is non-zero.)
     
         ...and then, from the client, fetch S from the server.
     
-- 
2.47.0.338.g60cca15819-goog

