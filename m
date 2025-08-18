Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADDE1FDE14
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755508551; cv=none; b=T/OmVbmfjILOpdETUpVJjp9HKs0RS/TlVYDruzeFpAbrMgYOOm2Et9zBQpgVx8CTdsK7tpXfTx5mRktidTGMQ5O4+MdnIfUYGl9AFNOA8OlZyLZrc7PgVi87h/mD7yddzjr/Qyyjkfp+Dsq15BmTwGGXXicuyvUydWGqBk9P0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755508551; c=relaxed/simple;
	bh=1juu/z1GCt+ba1GtkCknOhSTJZItoOdTTSCrIhX4yf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRmOlh5fsBdhioEXQfrVi4y3q5xq6GpV7fenmNDoseC0GLri2APx6Mx2zkP+6YEjTABxietdf9OFp1fkqzK7nvbGEO7UHvmvU0FCG4Oqnde5KzUAuOmndKoNPsLUOxalbNMf8qjYkWPFtRdZj9kohvBvvS2sIzWmsBNjskBgMkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nu5F/TFl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3YyFzpzn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nu5F/TFl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3YyFzpzn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nu5F/TFl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3YyFzpzn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nu5F/TFl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3YyFzpzn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94C1E211CC;
	Mon, 18 Aug 2025 09:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755508547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jm/2ru5LEhHxjrqvINXUPL3gwID5qMG5LzrEw/5SA/I=;
	b=nu5F/TFlr1a2gPmiBklX+FuosgbkMnE6b/Y7ze3B+aciZehcGn6xd1TJWPU0Tbkx+MZ5W2
	rG/b2bHiBxnGrb1pL10eDxp4i/JHgZe4EsBachT+87x2uvpkyZ2PUCG5jOdv+wALrUAVs+
	XzB58FjhtQXvo4UmYvfjUurnrYLdHZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755508547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jm/2ru5LEhHxjrqvINXUPL3gwID5qMG5LzrEw/5SA/I=;
	b=3YyFzpznoVidJRdI63eGixK2F+gvQ3q5Pa9/TXfS9Ol6Dbcb+tmBT6FEKleP894vtfLnPu
	sSw7OhxVISQRgaDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755508547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jm/2ru5LEhHxjrqvINXUPL3gwID5qMG5LzrEw/5SA/I=;
	b=nu5F/TFlr1a2gPmiBklX+FuosgbkMnE6b/Y7ze3B+aciZehcGn6xd1TJWPU0Tbkx+MZ5W2
	rG/b2bHiBxnGrb1pL10eDxp4i/JHgZe4EsBachT+87x2uvpkyZ2PUCG5jOdv+wALrUAVs+
	XzB58FjhtQXvo4UmYvfjUurnrYLdHZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755508547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jm/2ru5LEhHxjrqvINXUPL3gwID5qMG5LzrEw/5SA/I=;
	b=3YyFzpznoVidJRdI63eGixK2F+gvQ3q5Pa9/TXfS9Ol6Dbcb+tmBT6FEKleP894vtfLnPu
	sSw7OhxVISQRgaDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88CF013A55;
	Mon, 18 Aug 2025 09:15:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U6wGIUPvomjUNQAAD6G6ig
	(envelope-from <mls@suse.de>); Mon, 18 Aug 2025 09:15:47 +0000
Date: Mon, 18 Aug 2025 11:15:46 +0200
From: Michael Schroeder <mls@suse.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] submodule: truncate the oid when fetchig commits
Message-ID: <aKLvQlwlTpQec_t1@suse.de>
References: <aJ37eHEGMw6RgmZC@suse.de>
 <xmqqqzxd6haw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzxd6haw.fsf@gitster.g>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30


Hi git team,

here's the new version of the patch based on your comments:

From 3962b9cb065504f52875f728f03ecbf8dc1f23e2 Mon Sep 17 00:00:00 2001
From: Michael Schroeder <mls@suse.de>
Date: Thu, 14 Aug 2025 16:12:53 +0200
Subject: [PATCH v2] submodule: use subrepo algo when fetchig commits

If a submodule uses a hash algorithm with shorter hash length than
what is used in the main repository, the recorded submodule commit
is padded with zeros. This is usually not a problem as the default
is to do submodule clones non-shallow and the commit can be found
in the local objects.

But this is not true if the --shallow-submodules clone option is
used (or the --depth option in the submodule update call).
In this case, the commit is often not reachable and a fetch of the
specific commit is done. But the fetch cannot deal with the zero
padding and interprets the commit as a name. Because of this,
the checkout will fail.

Use the subrepo algorithm when converting the stored commit to hex
so that the result matches the expected oid length of the submodule.

Signed-off-by: Michael Schroeder <mls@suse.de>
---
 builtin/submodule--helper.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 07a1935cbe..5c2e96b517 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -72,7 +72,7 @@ static char *resolve_relative_url(const char *rel_url, const char *up_path, int
 	return resolved_url;
 }
 
-static int get_default_remote_submodule(const char *module_path, char **default_remote)
+static int get_default_remote_submodule(const char *module_path, char **default_remote, const struct git_hash_algo **hash_algo)
 {
 	const struct submodule *sub;
 	struct repository subrepo;
@@ -106,6 +106,9 @@ static int get_default_remote_submodule(const char *module_path, char **default_
 
 	*default_remote = xstrdup(remote_name);
 
+	if (hash_algo)
+		*hash_algo = subrepo.hash_algo;
+
 	repo_clear(&subrepo);
 	free(url);
 
@@ -1272,7 +1275,7 @@ static void sync_submodule(const char *path, const char *prefix,
 		goto cleanup;
 
 	strbuf_reset(&sb);
-	code = get_default_remote_submodule(path, &default_remote);
+	code = get_default_remote_submodule(path, &default_remote, NULL);
 	if (code)
 		exit(code);
 
@@ -2319,16 +2322,18 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 	if (depth)
 		strvec_pushf(&cp.args, "--depth=%d", depth);
 	if (oid) {
-		char *hex = oid_to_hex(oid);
+		const struct git_hash_algo *hash_algo = NULL;
+		char *hex;
 		char *remote;
 		int code;
 
-		code = get_default_remote_submodule(module_path, &remote);
+		code = get_default_remote_submodule(module_path, &remote, &hash_algo);
 		if (code) {
 			child_process_clear(&cp);
 			return code;
 		}
 
+		hex = hash_to_hex_algop(oid->hash, hash_algo);
 		strvec_pushl(&cp.args, remote, hex, NULL);
 		free(remote);
 	}
@@ -2635,7 +2640,7 @@ static int update_submodule(struct update_data *update_data)
 		char *remote_ref;
 		int code;
 
-		code = get_default_remote_submodule(update_data->sm_path, &remote_name);
+		code = get_default_remote_submodule(update_data->sm_path, &remote_name, NULL);
 		if (code)
 			return code;
 		code = remote_submodule_branch(update_data->sm_path, &branch);
-- 
2.50.0

