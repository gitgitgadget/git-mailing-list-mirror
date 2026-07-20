Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567E11DED4C
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586847; cv=none; b=EI1kYfKBgcFZ1pRYgmy/Ddvp/X5S5qAI5wy/rFpP1r9AHozU6r5uWVOgnWCVVx/rzA5U3dJCQ18NsOXx0vQ/Mxi4Zvjzw6ALoiscymHiEdM6STTc/oM8ktygSqvNFK+Ka/tu9lkNPei7Jx5KKQhwUXhH4ZfYMiTgk+Ma2rf5RLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586847; c=relaxed/simple;
	bh=Agtge4LUJ/BnYE/XvCEKxNxtsySbBxRt28gjqKA0yrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6gG2AcGZlNYjTWDwaxcvdACyj4aO4UF8Ee7ura8odZzsLLBj/TqbcA6JtEO+CLlznrIJgjwWKo3uBYHCOHBEkEOgtfIK5WMNU2vWx0nPwLzsVT+oShoN68dNqTDFKF904HHK1/TcRsWOVpU1kMNlCzTTWRQiBQMtfJfNU6wAJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=afvyvlhH; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="afvyvlhH"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f0989428b3so12048186d6.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784586842; x=1785191642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DwLCVSOYFFy+hhhSZmXof6KrFkztDE96ezMV5J2L3qs=;
        b=afvyvlhHNKhPuke2JPqe0shX9Nx0H2l+o6ktGPN/P3g0y/98UZGiGUoHxxPEKXu1LH
         q12O9bXHZ3O/C4kzSoupGiy/CvnCHtbaK8997GTPuZNe56DMxOXnc0VQ4SymtIyxpj8q
         w18cCoW6DsMJwdbjd8bn0YeslBtvYP09YnXG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784586842; x=1785191642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DwLCVSOYFFy+hhhSZmXof6KrFkztDE96ezMV5J2L3qs=;
        b=Ye9y1fpAYfWHgeptnr/NgN/o1PNIR+yKqVTTEibk10nf2QPh+KHJIEHVd6qWWU0CrC
         DhKpFFSnetLzyrhu7nWb0hIrdYm45zsp818de3n5NngTnn5Yvsj34htXt6NIYVdbQZcr
         vzpT3vilpq6aOt8Kccjdu468oMmqSTfgbW4s8wB7meaokFPOKhwhkk8LhItpO2p9N14U
         EYtT8pOCMwg/+x5SK0AaWavAJuWV7n7Gm5KEvCVU+/SrxMcKCxPQeUpi/yfsqn+2kTg0
         n69WP2mUorgr8TBpVlqyW2ZBdVMP1iBSaOyMd7UJ4KvTwpHVOtBJqdlqW4BDQZogJolU
         Zx0Q==
X-Gm-Message-State: AOJu0YxEbuVYWGZt0/oRnNaPyvE2dNjsSPhO7rkZqIlL62vGChlJD6NO
	HGS/jSNsanqfMFDyn/fwZqGiZPPx0XpAwkgsU43vDZF20+xF9Gt9MzJN/LFfFQjpSX73fYVJTxa
	WbSz84Xk=
X-Gm-Gg: AfdE7cmPcvpCQ6GewnCUW8zgitQ2efuCAwfg36yFyjP3YfLP4pKKKnP0xtC5dIsU92l
	4/FeLTIQTNEAdS73tAEPRi1vOt3LRMzX1iuPa/vcKq+IgR4m1pZmUTeI/0QU7tfdGO61KM73Zyx
	oa9VqthFAOd2fNMCoKc6IGza9oPjcrGBwVCqVVQP/GH1a/LEQb119Sf0VZCVeqXH1guRqlQHTVu
	Vkge6RVMTApQm3Uap5/YUw/o1x8JTrmF0kmdzBKXBZkogPed+FG+L8utMpgFHh7xplCUqkMheRB
	lqTipRhYpQiCnj3fBC7Rkz52xX2PcW//9UgroNCfVwgTou75OUY1mKTRy2rmkGwEVjIWfKDw5R3
	eiW2RvF0U8B8NTaNffDzzlfMOMPhGeB+Bx5YVWvwuqhzE0GftpdP7X0XsltJEI6cRSZQzV2GVdi
	vyFKFCvFNhGseEY/9wR6pxYLB5S/J7Cxtz8k5IYlEwsbM1Z6ZOfLQqymQB2hRbgMw8T7jjXpDlI
	9+z4AI=
X-Received: by 2002:a05:620a:ac10:b0:930:79bc:abe with SMTP id af79cd13be357-930b418da4dmr989197785a.4.1784586841401;
        Mon, 20 Jul 2026 15:34:01 -0700 (PDT)
Received: from com-76773.corp.openai.org ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b542dd27sm972590185a.29.2026.07.20.15.33.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 15:34:00 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v2 0/2] packfile URIs: support concurrent downloads
Date: Mon, 20 Jul 2026 15:33:58 -0700
Message-ID: <cover.1784582665.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0.125.g9b41d4ddb3
In-Reply-To: <cover.1783982021.git.tnyman@openai.com>
References: <cover.1783982021.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packfile URI and dumb HTTP downloads stage packs at
objects/pack/pack-<hash>.pack.temp so an interrupted transfer can
resume. Two Git processes fetching the same pack into one object
database can append to that file concurrently, which can corrupt the
temporary pack.

Following Peff's suggestion in the v1 discussion, the first patch keeps
the predictable temporary name but opens the file without append mode.
Each downloader keeps its own file offset, so overlapping responses for
the same pack write the same bytes at the same offsets. This preserves
resumable downloads and protects both packfile URI and ordinary dumb
HTTP requests. Concurrent downloaders may still transfer the same
suffix; this series avoids adding cross-process coordination and a
stale-owner policy.

A second downloader can also find that the partial pack has completed
and request a range starting at EOF. Servers may respond with HTTP 416
in that case. Treat that response as a completed download and let
index-pack validate the pack. Keep the open descriptor for indexing so
another downloader can safely remove the temporary path.

The second patch handles the related .keep race. When another process
has already created the keep file, index-pack reports
"pack<TAB><hash>" instead of "keep<TAB><hash>". Accept both successful
forms and remove only keep files created by the current process. Read
only the prefix and hash so any following fsck output remains available
to fetch-pack.

The tests cover resumption, a completed partial returning 416,
overlapping 200 and 206 responses, and a pre-existing .keep file.

Changes since v1:

  * Preserve resumability by removing append mode instead of using a
    unique temporary file for each download.
  * Handle the EOF-range/416 and concurrent-unlink cases, including the
    Windows sharing behavior.
  * Add a deterministic overlapping-download regression test.
  * Read the pack/keep prefix and hash without consuming later fsck
    output, as suggested during review.
  * Correct the stale --index-pack-args documentation and error text;
    the repeatable --index-pack-arg option is already supported.

The v1 discussion is at:

  https://lore.kernel.org/git/cover.1783982021.git.tnyman@openai.com/

Ted Nyman (2):
  http: avoid concurrent appends to partial packs
  fetch-pack: accept "pack" output for packfile URIs

 Documentation/git-http-fetch.adoc |  13 +-
 fetch-pack.c                      |  33 +++--
 http-fetch.c                      |   7 +-
 http-push.c                       |   3 +-
 http-walker.c                     |   3 +-
 http.c                            |  53 ++++---
 t/t5550-http-fetch-dumb.sh        | 223 ++++++++++++++++++++++++++++++
 t/t5702-protocol-v2.sh            |  31 +++++
 8 files changed, 320 insertions(+), 46 deletions(-)

Range-diff against v1:
1:  32eb9b0831 ! 1:  160a9b9fd0 http: use unique tempfiles for packfile URI downloads
    @@ Metadata
     Author: Ted Nyman <tnyman@openai.com>
     
      ## Commit message ##
    -    http: use unique tempfiles for packfile URI downloads
    +    http: avoid concurrent appends to partial packs
     
    -    Since 8d5d2a34df (http-fetch: support fetching packfiles by URL,
    -    2020-06-10), packfile URI downloads have been staged at
    -    objects/pack/pack-<hash>.pack.temp.
    +    Pack requests stage downloads in a predictable partial-pack file so an
    +    interrupted transfer can be resumed. Both packfile URI and ordinary dumb
    +    HTTP requests use this staging path. Opening it in append mode lets
    +    concurrent fetches interleave their writes, corrupting the pack or
    +    causing a later fetch to request a range at EOF.
     
    -    The path is derived from the advertised pack hash. Two processes
    -    fetching the same pack into a shared object database therefore open the
    -    same file for append. Their writes can corrupt the temporary pack. If
    -    one process arrives after the other has completed the download, it may
    -    instead try to resume at EOF, which some HTTP servers reject with 416.
    +    Open the partial pack read-write, seek to its current end, and retain a
    +    per-descriptor offset for incoming data. Reopen newly created partial
    +    packs without O_CREAT so Windows permits concurrent unlink, and keep the
    +    descriptor for index-pack when another downloader removes the staging
    +    path. Accept HTTP 416 when a partial pack is already complete.
     
    -    Use the tempfile API to give direct packfile URI downloads unique
    -    temporary files. Keep the deterministic path for ordinary dumb HTTP
    -    pack requests, which use it to resume a partial download left by an
    -    earlier invocation.
    -
    -    This means that a packfile URI download cannot be resumed by a later
    -    invocation. A retry starts with an empty temporary file instead.
    -
    -    Add a test which pauses one process after downloading the pack and
    -    starts another process using the same object database.
    +    Exercise resumed transfers, EOF ranges, and overlapping 200 and 206
    +    responses. Clarify the staging-key documentation and correct the stale
    +    --index-pack-args spelling in the documentation and error messages; the
    +    repeatable --index-pack-arg option is already accepted.
     
         Signed-off-by: Ted Nyman <tnyman@openai.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/git-http-fetch.adoc ##
     @@ Documentation/git-http-fetch.adoc: commit-id::
    @@ Documentation/git-http-fetch.adoc: commit-id::
     -	The hash is used to determine the name of the temporary file and is
     -	arbitrary. The output of index-pack is printed to stdout. Requires
     -	--index-pack-args.
    -+	The hash is arbitrary. The output of index-pack is printed to stdout.
    -+	Requires --index-pack-args.
    ++	The hash is used to determine the name of the temporary file. It need
    ++	not be the pack hash, but it must uniquely identify the pack contents
    ++	for resumption. The output of index-pack is printed to stdout. Requires
    ++	one or more --index-pack-arg options.
    + 
    +---index-pack-args=<args>::
    +-	For internal use only. The command to run on the contents of the
    +-	downloaded pack. Arguments are URL-encoded separated by spaces.
    ++--index-pack-arg=<arg>::
    ++	For internal use only. An argument to the command run on the contents
    ++	of the downloaded pack. This option can be specified multiple times.
      
    - --index-pack-args=<args>::
    - 	For internal use only. The command to run on the contents of the
    + --recover::
    + 	Verify that everything reachable from target is fetched.  Used after
     
    - ## http.c ##
    -@@ http.c: int http_get_info_packs(const char *base_url, struct packfile_list *packs)
    + ## http-fetch.c ##
    +@@ http-fetch.c: static void fetch_single_packfile(struct object_id *packfile_hash,
      
    - void release_http_pack_request(struct http_pack_request *preq)
    - {
    --	if (preq->packfile) {
    -+	if (preq->tempfile) {
    -+		delete_tempfile(&preq->tempfile);
    -+		preq->packfile = NULL;
    -+	} else if (preq->packfile) {
    - 		fclose(preq->packfile);
    - 		preq->packfile = NULL;
    + 	if (start_active_slot(preq->slot)) {
    + 		run_active_slot(preq->slot);
    +-		if (results.curl_result != CURLE_OK) {
    ++		if (results.curl_result != CURLE_OK &&
    ++		    results.http_code != 416) {
    + 			struct url_info url;
    + 			char *nurl = url_normalize(preq->url, &url);
    + 			if (!nurl || !git_env_bool("GIT_TRACE_REDACT", 1)) {
    +@@ http-fetch.c: int cmd_main(int argc, const char **argv)
    + 
    + 	if (packfile) {
    + 		if (!index_pack_args.nr)
    +-			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-args");
    ++			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-arg");
    + 
    + 		fetch_single_packfile(&packfile_hash, argv[arg],
    + 				      index_pack_args.v);
    +@@ http-fetch.c: int cmd_main(int argc, const char **argv)
      	}
    + 
    + 	if (index_pack_args.nr)
    +-		die(_("the option '%s' requires '%s'"), "--index-pack-args", "--packfile");
    ++		die(_("the option '%s' requires '%s'"), "--index-pack-arg", "--packfile");
    + 
    + 	if (commits_on_stdin) {
    + 		commits = walker_targets_stdin(&commit_id, &write_ref);
    +
    + ## http-push.c ##
    +@@ http-push.c: static void finish_request(struct transfer_request *request)
    + 
    + 	} else if (request->state == RUN_FETCH_PACKED) {
    + 		int fail = 1;
    +-		if (request->curl_result != CURLE_OK) {
    ++		if (request->curl_result != CURLE_OK &&
    ++		    request->http_code != 416) {
    + 			fprintf(stderr, "Unable to get pack file %s\n%s",
    + 				request->url, curl_errorstr);
    + 		} else {
    +
    + ## http-walker.c ##
    +@@ http-walker.c: static int http_fetch_pack(struct walker *walker, struct alt_base *repo,
    + 
    + 	if (start_active_slot(preq->slot)) {
    + 		run_active_slot(preq->slot);
    +-		if (results.curl_result != CURLE_OK) {
    ++		if (results.curl_result != CURLE_OK &&
    ++		    results.http_code != 416) {
    + 			error("Unable to get pack file %s\n%s", preq->url,
    + 			      curl_errorstr);
    + 			goto abort;
    +
    + ## http.c ##
     @@ http.c: int finish_http_pack_request(struct http_pack_request *preq)
      	int tmpfile_fd;
      	int ret = 0;
      
    --	fclose(preq->packfile);
    -+	if (preq->tempfile)
    -+		close_tempfile_gently(preq->tempfile);
    -+	else
    -+		fclose(preq->packfile);
    ++	/* Another downloader may unlink the staging path while we index it. */
    ++	tmpfile_fd = xdup(fileno(preq->packfile));
    + 	fclose(preq->packfile);
      	preq->packfile = NULL;
    +-
    +-	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
    ++	if (lseek(tmpfile_fd, 0, SEEK_SET) < 0)
    ++		die_errno("unable to seek local file %s for pack",
    ++			  preq->tmpfile.buf);
      
    - 	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
    + 	ip.git_cmd = 1;
    + 	ip.in = tmpfile_fd;
     @@ http.c: int finish_http_pack_request(struct http_pack_request *preq)
    + 	else
    + 		ip.no_stdout = 1;
      
    - cleanup:
    - 	close(tmpfile_fd);
    --	unlink(preq->tmpfile.buf);
    -+	if (preq->tempfile)
    -+		delete_tempfile(&preq->tempfile);
    -+	else
    -+		unlink(preq->tmpfile.buf);
    +-	if (run_command(&ip)) {
    ++	if (run_command(&ip))
    + 		ret = -1;
    +-		goto cleanup;
    +-	}
    +-
    +-cleanup:
    +-	close(tmpfile_fd);
    + 	unlink(preq->tmpfile.buf);
      	return ret;
      }
    - 
    -@@ http.c: void http_install_packfile(struct packed_git *p,
    - 	packfile_store_add_pack(files->packed, p);
    - }
    - 
    --struct http_pack_request *new_http_pack_request(
    --	const unsigned char *packed_git_hash, const char *base_url) {
    --
    --	struct strbuf buf = STRBUF_INIT;
    --
    --	end_url_with_slash(&buf, base_url);
    --	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
    --		hash_to_hex(packed_git_hash));
    --	return new_direct_http_pack_request(packed_git_hash,
    --					    strbuf_detach(&buf, NULL));
    --}
    --
    --struct http_pack_request *new_direct_http_pack_request(
    --	const unsigned char *packed_git_hash, char *url)
    -+static struct http_pack_request *new_http_pack_request_for_url(
    -+	const unsigned char *packed_git_hash, char *url, int resumable)
    +@@ http.c: struct http_pack_request *new_http_pack_request(
    + struct http_pack_request *new_direct_http_pack_request(
    + 	const unsigned char *packed_git_hash, char *url)
      {
    - 	off_t prev_posn = 0;
    +-	off_t prev_posn = 0;
    ++	off_t prev_posn;
      	struct http_pack_request *preq;
    -@@ http.c: struct http_pack_request *new_direct_http_pack_request(
    ++	int fd;
      
    + 	CALLOC_ARRAY(preq, 1);
    + 	strbuf_init(&preq->tmpfile, 0);
    +-
      	preq->url = url;
      
    --	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
    --	strbuf_addstr(&preq->tmpfile, ".temp");
    + 	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
    + 	strbuf_addstr(&preq->tmpfile, ".temp");
     -	preq->packfile = fopen(preq->tmpfile.buf, "a");
    -+	if (resumable) {
    -+		odb_pack_name(the_repository, &preq->tmpfile,
    -+			      packed_git_hash, "pack");
    -+		strbuf_addstr(&preq->tmpfile, ".temp");
    -+		preq->packfile = fopen(preq->tmpfile.buf, "a");
    -+	} else {
    -+		strbuf_addf(&preq->tmpfile, "%s/pack/tmp_pack_XXXXXX",
    -+			    repo_get_object_directory(the_repository));
    -+		preq->tempfile = mks_tempfile_m(preq->tmpfile.buf, 0444);
    -+		if (preq->tempfile) {
    -+			strbuf_reset(&preq->tmpfile);
    -+			strbuf_addstr(&preq->tmpfile,
    -+				      get_tempfile_path(preq->tempfile));
    -+			preq->packfile = fdopen_tempfile(preq->tempfile, "w");
    +-	if (!preq->packfile) {
    +-		error("Unable to open local file %s for pack",
    +-		      preq->tmpfile.buf);
    ++	/* Reopen without O_CREAT so MinGW permits another writer to unlink it. */
    ++	for (;;) {
    ++		fd = open(preq->tmpfile.buf, O_RDWR);
    ++		if (fd >= 0 || errno != ENOENT)
    ++			break;
    ++		fd = open(preq->tmpfile.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
    ++		if (fd >= 0) {
    ++			close(fd);
    ++			continue;
     +		}
    ++		if (errno != EEXIST)
    ++			break;
    ++	}
    ++	if (fd < 0) {
    ++		error_errno("unable to open local file %s for pack",
    ++			    preq->tmpfile.buf);
    ++		goto abort;
     +	}
    - 	if (!preq->packfile) {
    - 		error("Unable to open local file %s for pack",
    - 		      preq->tmpfile.buf);
    ++	prev_posn = lseek(fd, 0, SEEK_END);
    ++	if (prev_posn < 0) {
    ++		error_errno("unable to seek local file %s for pack",
    ++			    preq->tmpfile.buf);
    ++		close(fd);
    + 		goto abort;
    + 	}
    ++	preq->packfile = xfdopen(fd, "w");
    + 
    + 	preq->slot = get_active_slot();
    + 	preq->headers = object_request_headers();
     @@ http.c: struct http_pack_request *new_direct_http_pack_request(
    - 	 * If there is data present from a previous transfer attempt,
    - 	 * resume where it left off
    - 	 */
    + 	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
    + 	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER, preq->headers);
    + 
    +-	/*
    +-	 * If there is data present from a previous transfer attempt,
    +-	 * resume where it left off
    +-	 */
     -	prev_posn = ftello(preq->packfile);
     -	if (prev_posn>0) {
    -+	if (resumable)
    -+		prev_posn = ftello(preq->packfile);
     +	if (prev_posn > 0) {
      		if (http_is_verbose)
      			fprintf(stderr,
      				"Resuming fetch of pack %s at byte %"PRIuMAX"\n",
    -@@ http.c: struct http_pack_request *new_direct_http_pack_request(
    - 	return preq;
    - 
    - abort:
    --	strbuf_release(&preq->tmpfile);
    --	free(preq->url);
    --	free(preq);
    -+	release_http_pack_request(preq);
    - 	return NULL;
    - }
    - 
    -+struct http_pack_request *new_http_pack_request(
    -+	const unsigned char *packed_git_hash, const char *base_url)
    -+{
    -+	struct strbuf buf = STRBUF_INIT;
    -+
    -+	end_url_with_slash(&buf, base_url);
    -+	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
    -+		hash_to_hex(packed_git_hash));
    -+	return new_http_pack_request_for_url(packed_git_hash,
    -+					     strbuf_detach(&buf, NULL), 1);
    -+}
    -+
    -+struct http_pack_request *new_direct_http_pack_request(
    -+	const unsigned char *packed_git_hash, char *url)
    -+{
    -+	return new_http_pack_request_for_url(packed_git_hash, url, 0);
    -+}
    -+
    - /* Helpers for fetching objects (loose) */
    - static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
    - 			       void *data)
    -
    - ## http.h ##
    -@@ http.h: struct http_pack_request {
    - 
    - 	FILE *packfile;
    - 	struct strbuf tmpfile;
    -+	struct tempfile *tempfile;
    - 	struct active_request_slot *slot;
    - 	struct curl_slist *headers;
    - };
     
      ## t/t5550-http-fetch-dumb.sh ##
     @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
      	git -C packfileclient cat-file -e "$HASH"
      '
      
    -+test_expect_success PIPE 'concurrent http-fetch --packfile' '
    ++test_expect_success 'http-fetch --packfile resumes a partial download' '
    ++	git init packfileclient-resume &&
    ++	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
    ++		ls objects/pack/pack-*.pack) &&
    ++	tmpfile="packfileclient-resume/.git/objects/pack/pack-$ARBITRARY.pack.temp" &&
    ++	test_copy_bytes 64 <"$HTTPD_DOCUMENT_ROOT_PATH/repo_pack.git/$p" >"$tmpfile" &&
    ++	GIT_TRACE_CURL="$TRASH_DIRECTORY/resume.trace" \
    ++	git -C packfileclient-resume http-fetch --packfile="$ARBITRARY" \
    ++		--index-pack-arg=index-pack --index-pack-arg=--stdin \
    ++		--index-pack-arg=--keep \
    ++		"$HTTPD_URL/dumb/repo_pack.git/$p" >out &&
    ++	test_grep "Range: bytes=64-" resume.trace &&
    ++	test_path_is_missing "$tmpfile" &&
    ++	git -C packfileclient-resume cat-file -e "$HASH"
    ++'
    ++
    ++test_expect_success PIPE 'concurrent http-fetch --packfile accepts a complete partial' '
     +	git init packfileclient-concurrent &&
    -+	HASH=$(git -C "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git rev-parse HEAD) &&
     +	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
     +		ls objects/pack/pack-*.pack) &&
     +	packhash=$(basename "$p" .pack) &&
     +	packhash=${packhash#pack-} &&
    -+
    ++	tmpfile="packfileclient-concurrent/.git/objects/pack/pack-$packhash.pack.temp" &&
    ++	test_copy_bytes 64 <"$HTTPD_DOCUMENT_ROOT_PATH/repo_pack.git/$p" >"$tmpfile" &&
     +	mkfifo first-ready first-continue &&
     +	exec 8<>first-ready &&
     +	exec 9<>first-continue &&
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
     +	read continue <"$GIT_TEST_WAIT_CONTINUE" &&
     +	exec git index-pack "$@"
     +	EOF
    -+
    -+	# Hold the first download before it is indexed, so that the second
    -+	# download installs the pack first.
     +	{
     +		(
     +			if ! PATH="$TRASH_DIRECTORY:$PATH" \
     +			GIT_TEST_WAIT_READY="$TRASH_DIRECTORY/first-ready" \
     +			GIT_TEST_WAIT_CONTINUE="$TRASH_DIRECTORY/first-continue" \
    -+			git -C packfileclient-concurrent http-fetch \
    -+				--packfile="$packhash" \
    ++			GIT_TRACE_CURL="$TRASH_DIRECTORY/first.trace" \
    ++			git -C packfileclient-concurrent http-fetch --packfile="$packhash" \
     +				--index-pack-arg=wait-index-pack \
    -+				--index-pack-arg=--stdin \
    -+				--index-pack-arg=--keep \
    ++				--index-pack-arg=--stdin --index-pack-arg=--keep \
     +				"$HTTPD_URL/dumb/repo_pack.git/$p" >first.out
     +			then
     +				echo failed >"$TRASH_DIRECTORY/first-ready" &&
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
     +	} &&
     +	test_when_finished "
     +		echo continue >&9
    ++		kill $first_pid 2>/dev/null || :
     +		wait $first_pid 2>/dev/null || :
     +		exec 8>&-
     +		exec 9>&-
     +		rm -f first-ready first-continue git-wait-index-pack
     +	" &&
    -+
     +	read ready <&8 &&
     +	test "$ready" = ready &&
    -+	git -C packfileclient-concurrent http-fetch \
    -+		--packfile="$packhash" \
    ++	GIT_TRACE_CURL="$TRASH_DIRECTORY/second.trace" \
    ++	git -C packfileclient-concurrent http-fetch --packfile="$packhash" \
     +		--index-pack-arg=index-pack \
    -+		--index-pack-arg=--stdin \
    -+		--index-pack-arg=--keep \
    ++		--index-pack-arg=--stdin --index-pack-arg=--keep \
     +		"$HTTPD_URL/dumb/repo_pack.git/$p" >second.out &&
     +	echo continue >&9 &&
     +	wait "$first_pid" &&
    -+
     +	printf "pack\t%s\n" "$packhash" >expect &&
     +	test_cmp expect first.out &&
     +	printf "keep\t%s\n" "$packhash" >expect &&
     +	test_cmp expect second.out &&
    -+	test_path_is_missing \
    -+		"packfileclient-concurrent/.git/objects/pack/pack-$packhash.pack.temp" &&
    -+	find packfileclient-concurrent/.git/objects/pack \
    -+		-name "tmp_pack_*" -print >tmpfiles &&
    -+	test_must_be_empty tmpfiles &&
    ++	test_grep "Range: bytes=64-" first.trace &&
    ++	test_grep "Range: bytes=[0-9]*-" second.trace &&
    ++	test_grep "HTTP/[0-9.]* 416" second.trace &&
    ++	test_path_is_missing "$tmpfile" &&
     +	git -C packfileclient-concurrent cat-file -e "$HASH"
     +'
    ++
    ++test_expect_success PERL,PIPE 'concurrent http-fetch --packfile cannot corrupt an overlapping download' '
    ++	git init packfileclient-overlap &&
    ++	blob=$(test-tool genrandom pack-overlap 2m |
    ++		git -C "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git \
    ++			hash-object -w --stdin) &&
    ++	packhash=$(printf "%s\n" "$blob" |
    ++		git -C "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git \
    ++			pack-objects "$TRASH_DIRECTORY/overlap-pack") &&
    ++	pack="$TRASH_DIRECTORY/overlap-pack-$packhash.pack" &&
    ++	tmpfile="packfileclient-overlap/.git/objects/pack/pack-$packhash.pack.temp" &&
    ++	mkfifo server-ready first-ready &&
    ++	exec 7<>server-ready &&
    ++	exec 8<>first-ready &&
    ++	write_script slow-pack-server "$PERL_PATH" <<-\EOF &&
    ++	use strict;
    ++	use warnings;
    ++	use IO::Socket::INET;
    ++
    ++	my ($packfile, $server_ready, $first_ready) = @ARGV;
    ++	open(my $in, "<:raw", $packfile) or die "open $packfile: $!";
    ++	my $pack = do { local $/; <$in> };
    ++	close($in) or die "close $packfile: $!";
    ++	my $server = IO::Socket::INET->new(LocalAddr => "127.0.0.1",
    ++		LocalPort => 0, Proto => "tcp", Listen => 2, ReuseAddr => 1)
    ++		or die "listen: $!";
    ++
    ++	sub signal_ready {
    ++		my ($file, $value) = @_;
    ++		open(my $out, ">", $file) or die "open $file: $!";
    ++		print $out "$value\n" or die "write $file: $!";
    ++		close($out) or die "close $file: $!";
    ++	}
    ++
    ++	sub write_all {
    ++		my ($out, $data) = @_;
    ++		my $offset = 0;
    ++		while ($offset < length($data)) {
    ++			my $written = syswrite($out, $data,
    ++				length($data) - $offset, $offset);
    ++			defined($written) && $written or die "write response: $!";
    ++			$offset += $written;
    ++		}
    ++	}
    ++
    ++	sub start_response {
    ++		my $out = $server->accept() or die "accept: $!";
    ++		<$out> or die "read request: $!";
    ++		my $start = 0;
    ++		while (<$out>) {
    ++			last if /^\r?\n$/;
    ++			$start = $1 if /^Range: bytes=(\d+)-/i;
    ++		}
    ++		$start < length($pack) or die "invalid range $start";
    ++		my $length = length($pack) - $start;
    ++		my $middle = int($length / 2);
    ++		my $status = $start ? "206 Partial Content" : "200 OK";
    ++		my $headers = "HTTP/1.1 $status\r\n" .
    ++			"Content-Length: $length\r\n" .
    ++			($start ? "Content-Range: bytes $start-" .
    ++				(length($pack) - 1) . "/" . length($pack) . "\r\n" : "") .
    ++			"Connection: close\r\n\r\n";
    ++		write_all($out, $headers);
    ++		write_all($out, substr($pack, $start, $middle));
    ++		return ($out, $start + $middle);
    ++	}
    ++
    ++	signal_ready($server_ready, $server->sockport());
    ++	my ($first, $first_pos) = start_response();
    ++	signal_ready($first_ready, "ready");
    ++	my ($second, $second_pos) = start_response();
    ++	write_all($first, substr($pack, $first_pos));
    ++	write_all($second, substr($pack, $second_pos));
    ++	close($first) or die "close first response: $!";
    ++	close($second) or die "close second response: $!";
    ++	EOF
    ++	{
    ++		(
    ++			if ! "$TRASH_DIRECTORY/slow-pack-server" "$pack" \
    ++				"$TRASH_DIRECTORY/server-ready" \
    ++				"$TRASH_DIRECTORY/first-ready"
    ++			then
    ++				echo failed >"$TRASH_DIRECTORY/server-ready" &&
    ++				echo failed >"$TRASH_DIRECTORY/first-ready" &&
    ++				exit 1
    ++			fi
    ++		) >server.log 2>&1 &
    ++		server_pid=$!
    ++	} &&
    ++	test_when_finished "
    ++		kill $server_pid 2>/dev/null || :
    ++		wait $server_pid 2>/dev/null || :
    ++		exec 7>&-
    ++		exec 8>&-
    ++		rm -f server-ready first-ready slow-pack-server
    ++	" &&
    ++	read port <&7 &&
    ++	url="http://127.0.0.1:$port/pack" &&
    ++	{
    ++		(
    ++			if ! GIT_TRACE_CURL="$TRASH_DIRECTORY/overlap-first.trace" \
    ++			GIT_TRACE_CURL_NO_DATA=1 \
    ++			git -C packfileclient-overlap http-fetch --packfile="$packhash" \
    ++				--index-pack-arg=index-pack \
    ++				--index-pack-arg=--stdin --index-pack-arg=--keep \
    ++				"$url" >first.out
    ++			then
    ++				echo failed >"$TRASH_DIRECTORY/first-ready" &&
    ++				exit 1
    ++			fi
    ++		) &
    ++		first_pid=$!
    ++	} &&
    ++	test_when_finished "
    ++		kill $first_pid 2>/dev/null || :
    ++		wait $first_pid 2>/dev/null || :
    ++	" &&
    ++	read ready <&8 &&
    ++	test "$ready" = ready &&
    ++	test_path_is_file "$tmpfile" &&
    ++	test -s "$tmpfile" &&
    ++	{
    ++		GIT_TRACE_CURL="$TRASH_DIRECTORY/overlap-second.trace" \
    ++		GIT_TRACE_CURL_NO_DATA=1 \
    ++		git -C packfileclient-overlap http-fetch --packfile="$packhash" \
    ++			--index-pack-arg=index-pack \
    ++			--index-pack-arg=--stdin --index-pack-arg=--keep \
    ++			"$url" >second.out &
    ++		second_pid=$!
    ++	} &&
    ++	test_when_finished "
    ++		kill $second_pid 2>/dev/null || :
    ++		wait $second_pid 2>/dev/null || :
    ++	" &&
    ++	wait "$server_pid" &&
    ++	wait "$first_pid" &&
    ++	wait "$second_pid" &&
    ++	test_grep "HTTP/[0-9.]* 200" overlap-first.trace &&
    ++	test_grep "Range: bytes=[1-9][0-9]*-" overlap-second.trace &&
    ++	test_grep "HTTP/[0-9.]* 206" overlap-second.trace &&
    ++	printf "keep\t%s\npack\t%s\n" "$packhash" "$packhash" | sort >expect &&
    ++	sort first.out second.out >actual &&
    ++	test_cmp expect actual &&
    ++	test_path_is_missing "$tmpfile" &&
    ++	git -C packfileclient-overlap cat-file -e "$blob"
    ++'
     +
      test_expect_success 'fetch notices corrupt pack' '
      	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
      	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
    -@@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile with corrupt pack' '
    - 	git init packfileclient &&
    - 	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git && ls objects/pack/pack-*.pack) &&
    - 	test_must_fail git -C packfileclient http-fetch --packfile \
    --		"$HTTPD_URL"/dumb/repo_bad1.git/$p
    -+		"$HTTPD_URL"/dumb/repo_bad1.git/$p &&
    -+	find packfileclient/.git/objects/pack -name "tmp_pack_*" -print >tmpfiles &&
    -+	test_must_be_empty tmpfiles
    - '
    - 
    - test_expect_success 'fetch notices corrupt idx' '
2:  e73de423f0 ! 2:  9b41d4ddb3 fetch-pack: accept "pack" output for packfile URIs
    @@ Metadata
      ## Commit message ##
         fetch-pack: accept "pack" output for packfile URIs
     
    -    When "index-pack --keep" creates a .keep file, it reports
    -    "keep<TAB><hash>". If the file already exists, index-pack leaves it
    -    untouched and reports "pack<TAB><hash>" instead.
    +    When index-pack finds an existing keep file it reports pack rather than
    +    keep. Accept either result from http-fetch, and only register a keep
    +    lockfile when this fetch created it.
     
    -    Since dd4b732df7 (upload-pack: send part of packfile response as uri,
    -    2020-06-10), fetch-pack has accepted only the "keep" form for packs
    -    downloaded through packfile URIs. A concurrent fetch can install the
    -    same pack and create its .keep file before another process reaches
    -    index-pack. The latter process then fails even though index-pack
    -    completed successfully.
    -
    -    Accept both successful forms. Add a path to pack_lockfiles only for the
    -    "keep" form, so cleanup removes only a keep file created by the current
    -    process and preserves a pre-existing one.
    -
    -    Add a regression test which pre-creates a keep file and verifies that a
    -    fetch succeeds without changing it.
    +    Read the pack/keep prefix and hash without consuming any following fsck
    +    output, validate the reported pack hash against the advertised hash, and
    +    exercise a packfile URI fetch with a pre-existing keep file.
     
         Signed-off-by: Ted Nyman <tnyman@openai.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## fetch-pack.c ##
     @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
      	}
      
      	for (i = 0; i < packfile_uris.nr; i++) {
    -+		int created_keep = 0;
    ++		bool created_keep;
      		int j;
      		struct child_process cmd = CHILD_PROCESS_INIT;
     -		char packname[GIT_MAX_HEXSZ + 1];
    -+		char packname[GIT_MAX_HEXSZ + 6];
    -+		const char *packhash;
    -+		const int packname_len = the_hash_algo->hexsz + 6;
    ++		char packhash[GIT_MAX_HEXSZ + 1];
      		const char *uri = packfile_uris.items[i].string +
      			the_hash_algo->hexsz + 1;
      
    @@ fetch-pack.c: static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
     -		if (read_in_full(cmd.out, packname, 5) < 0 ||
     -		    memcmp(packname, "keep\t", 5))
     -			die("fetch-pack: expected keep then TAB at start of http-fetch output");
    --
    ++		if (read_in_full(cmd.out, packhash, 5) != 5 ||
    ++		    (memcmp(packhash, "keep\t", 5) &&
    ++		     memcmp(packhash, "pack\t", 5)))
    ++			die("fetch-pack: expected pack or keep then TAB at start of http-fetch output");
    ++		created_keep = !memcmp(packhash, "keep\t", 5);
    + 
     -		if (read_in_full(cmd.out, packname,
     -				 the_hash_algo->hexsz + 1) < 0 ||
     -		    packname[the_hash_algo->hexsz] != '\n')
     -			die("fetch-pack: expected hash then LF at end of http-fetch output");
     -
     -		packname[the_hash_algo->hexsz] = '\0';
    -+		if (read_in_full(cmd.out, packname, packname_len) != packname_len ||
    -+		    packname[packname_len - 1] != '\n')
    -+			die("fetch-pack: expected pack or keep, TAB, hash, "
    -+			    "then LF in http-fetch output");
    -+		packname[packname_len - 1] = '\0';
    -+		if (skip_prefix(packname, "keep\t", &packhash))
    -+			created_keep = 1;
    -+		else if (!skip_prefix(packname, "pack\t", &packhash))
    -+			die("fetch-pack: expected pack or keep, TAB, hash, "
    -+			    "then LF in http-fetch output");
    ++		if (read_in_full(cmd.out, packhash,
    ++				 the_hash_algo->hexsz + 1) != the_hash_algo->hexsz + 1 ||
    ++		    packhash[the_hash_algo->hexsz] != '\n')
    ++			die("fetch-pack: expected hash then LF in http-fetch output");
    ++		packhash[the_hash_algo->hexsz] = '\0';
      
      		parse_gitmodules_oids(cmd.out, &fsck_options.gitmodules_found);
      

base-commit: f60db8d575adb79761d363e026fb49bddf330c73
-- 
2.55.0.125.g9b41d4ddb3
