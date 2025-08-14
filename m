Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEC321444
	for <git@vger.kernel.org>; Thu, 14 Aug 2025 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184000; cv=none; b=Fob1k7dge7KUabdB6LH69Jus1E+wi3yHMq490IfaGiq5BHLLbTaqCQgJbEPf1gJHJfz1GXe89cQYyec7knaRXhoQmp3NLVMvlBcaZLNUtn2vCLGVF0hsKKm4+WW0HDrX6h1gsvD8OEUu3WH/12wj2iOfKr9WzINUnrXxh8Td8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184000; c=relaxed/simple;
	bh=RN9myqOyGcXagzK/6z8/mstuzTcjQYX4yY0l8WPN+fw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jrQBnEDvXCw6vgpGitGrKjJGxvudipyrz1D1+SaWVm9CuWGnJAgxlrKgnL6++pq3H9o8RuDAFXBxPk18Zh+HGxiUmyxKgDuuGBG6V7+oQYFZMMaw6FKeG6Ax4C8r1Kn9+VyGjYYeP2eJU43YJ8sj9poLYVRYq8DsWDdCW6QjTLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EI1s1PyB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HsXEL0ky; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EI1s1PyB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HsXEL0ky; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EI1s1PyB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HsXEL0ky";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EI1s1PyB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HsXEL0ky"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22CAB1F7FE;
	Thu, 14 Aug 2025 15:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755183994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=tdIzwZscnu4VsRTpvaaCBqMVfYGzKVO4Tto5JGlTd98=;
	b=EI1s1PyBSYwXCidDemPpuKP3e69sX/aePgEU2p9u/utSlB6lRJWV0HOnXjNWrTqNU4HYQ/
	G8cwd0mt32sNMfG5FWbTI4fF3dCIx7Xrq/xyzXzCvtE4Zr4WwRqo4X/2LUSJP3dcbyEBNz
	qOwzoK7K/4yJmdduP1OBSJ2fb8nL5aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755183994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=tdIzwZscnu4VsRTpvaaCBqMVfYGzKVO4Tto5JGlTd98=;
	b=HsXEL0kyVp4d0iN7Idcwz2xN6PRRstc9VcJKHq9wMFazDPJwQ/oRbWjdhnhwD5Pzt9mKB5
	6k/VyEvnTKLkA1DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EI1s1PyB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HsXEL0ky
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755183994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=tdIzwZscnu4VsRTpvaaCBqMVfYGzKVO4Tto5JGlTd98=;
	b=EI1s1PyBSYwXCidDemPpuKP3e69sX/aePgEU2p9u/utSlB6lRJWV0HOnXjNWrTqNU4HYQ/
	G8cwd0mt32sNMfG5FWbTI4fF3dCIx7Xrq/xyzXzCvtE4Zr4WwRqo4X/2LUSJP3dcbyEBNz
	qOwzoK7K/4yJmdduP1OBSJ2fb8nL5aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755183994;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=tdIzwZscnu4VsRTpvaaCBqMVfYGzKVO4Tto5JGlTd98=;
	b=HsXEL0kyVp4d0iN7Idcwz2xN6PRRstc9VcJKHq9wMFazDPJwQ/oRbWjdhnhwD5Pzt9mKB5
	6k/VyEvnTKLkA1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 178701368C;
	Thu, 14 Aug 2025 15:06:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mu1fBXr7nWj1BwAAD6G6ig
	(envelope-from <mls@suse.de>); Thu, 14 Aug 2025 15:06:34 +0000
Date: Thu, 14 Aug 2025 17:06:32 +0200
From: Michael Schroeder <mls@suse.de>
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH] submodule: truncate the oid when fetchig commits
Message-ID: <aJ37eHEGMw6RgmZC@suse.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 22CAB1F7FE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

If a submodule uses a different hash algorithm than used in
the main repository, the recorded submodule commit is padded
with zeros. This is usually not a problem as the default is to
do submodule clones non-shallow and the commit can be found
in the local objects.

But this is not true if the --shallow-submodules clone option is
used (or the --depth option in the submodule update call).
In this case, the commit is often not reachable and a fetch of the
specific commit is done. But the fetch cannot deal with the zero
padding and interprets the commit as a name. Because of this,
the checkout will fail.

Implement truncation of the recorded commit to the correct size
corresponding to the hash algorithm used in the submodule.

Signed-off-by: Michael Schroeder <mls@suse.de>
---
 builtin/submodule--helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 07a1935cbe..ef21eb42b8 100644
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
 
@@ -2319,16 +2322,19 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet,
 	if (depth)
 		strvec_pushf(&cp.args, "--depth=%d", depth);
 	if (oid) {
-		char *hex = oid_to_hex(oid);
+		char hexbuffer[GIT_MAX_HEXSZ + 1];
+		char *hex = oid_to_hex_r(hexbuffer, oid);
 		char *remote;
+		const struct git_hash_algo *hash_algo = NULL;
 		int code;
 
-		code = get_default_remote_submodule(module_path, &remote);
+		code = get_default_remote_submodule(module_path, &remote, &hash_algo);
 		if (code) {
 			child_process_clear(&cp);
 			return code;
 		}
-
+		if (hash_algo)
+			hex[hash_algo->hexsz] = 0;	/* truncate to correct size */
 		strvec_pushl(&cp.args, remote, hex, NULL);
 		free(remote);
 	}
@@ -2635,7 +2641,7 @@ static int update_submodule(struct update_data *update_data)
 		char *remote_ref;
 		int code;
 
-		code = get_default_remote_submodule(update_data->sm_path, &remote_name);
+		code = get_default_remote_submodule(update_data->sm_path, &remote_name, NULL);
 		if (code)
 			return code;
 		code = remote_submodule_branch(update_data->sm_path, &branch);
-- 
2.50.0

