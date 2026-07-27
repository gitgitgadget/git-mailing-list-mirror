Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E0E2771B
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 00:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112138; cv=none; b=UsYPbJVT0cf1tI3CE+rB1NnctdrWITag51bpitx5DKeL/m/OMSZgsFsJIos4NkwIidLa0FONWL+5jtqK8K6fs5yCosQ9IJIkXxHFEPWHq5qSsQqF6BKVzyBwXmCQ2ywKJDXZZdDtoIp8F94YYc6aXVzGnrR5hvNAeTrauIbRnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112138; c=relaxed/simple;
	bh=RF16tqq2liMCUD3DKCkZifYUw5LZimNX9c1cT/QOP2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMVv7I0DgndKDJpBZzUbm2qgFlWNWxk0XSFMhIO6eL65lL0DiLctvhDy/b4/lZg9aiJ8ocwc52JT+QJJHgZ+Mz5EXWkcPvtvEQhL11Kwc6Mt34ngO4/VVfcA9Ab4/Gojnhvt30xj7b7Z6+T/uoLEQWkcDKOV/+ADzzUAyJZsE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=PmOdajdi; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="PmOdajdi"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38115bbb83dso102115a91.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785112136; x=1785716936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p5oLIKrd4i03oMePWHj/OezvI3bsr8ruv5t2TpGMSLM=;
        b=PmOdajdi8B1dqMgackB8LAuRlG12iPMp0Gq8IPjnto+U0hNGq1LeqrelEf6wE6k8fK
         cOMMxgQTH94sfvcIruhY/A78j+eDHbQNVWvAnsZwajd8lAKMVXeRUsBOlXjoe6Rd7Z+m
         GarOmIqsjet/gqNB9hHmjz09tXSRrFSWyrgts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785112136; x=1785716936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=p5oLIKrd4i03oMePWHj/OezvI3bsr8ruv5t2TpGMSLM=;
        b=QU7yb1Zr/8qoXRYYYy/x5s0Q199YVEbhxGyq6mNnAxGtjvdR5ehI1V3HthX31HAXBK
         lYd2PTxEtHu5KYrOxcPyuk7uSYisXCH4xqJtTk9ADXQHxO0WXmG9ugBjGM1TuC/ogjM0
         YLRCv5CtkHnHc5Y/btRYkUisM/xW7xk/REeGJNU7yPEBpk7AHieBfNVuq29GNogKFvA5
         ggs26PaCBgvekNC60H+MYChTgEtTpzYsqtPlEZeqB7NQGNLhmTpFxh4vBHCj1/i5D7xH
         JYg3d4gY+1s5kRT2KTjZ9WMHekPHP9mabG6wykeqcojMykWbGQol0O3cRb6wEGP0Ma1N
         BbJQ==
X-Gm-Message-State: AOJu0YyD0bz23W+T7HzaDJMVGGWh2iaAnBxHDAxiUZH2zz5dQKoPyoS1
	GmGlvEbMMtVwPeyY1tCjPRymzGDd/sDr+8QIYdBX0NS5dzqJLjKm/H5HEwaSSUJBBR1VqD82tys
	DGSfdzGo=
X-Gm-Gg: AR+sD11s29B0O2iftgcoBRq9KcftYh1/KlqYygI1xy7XhLCmwdQ9qPCcRwCq5O+g9UO
	GzRTuIVpD3JCL3xEQtEVfjZ5aUUuh3/uROc3a5/MTpenzKDo1KeibiwKmefurk7Z2HkavaT9un8
	hTGqd/rJkJFF201YkKiAtcObOzhJzY77+uo9/+guFTRsU0BVCd9IIlQ7X2zNll/iT4XQxyTd5h/
	XxssuahpdCxP+lVhBxeMdijwB7CzLBifORVJWCMrEVTfOZQxHgM+Aq9trTJ+KtL273bLkvyO8DE
	QIcoqqHEvmlMDYGX4mtpvBHjjlSzmYklQFMQRr3D7iuM6NMqmBMZBwhTAR/8z3OfUidglZ9MzvI
	VmQ+eG/cnHBiZN54b3cMsaMDRDD5xtthPj2S1Net2+yECVpsIBXuMlb9cWJ5FWF55QQZlgIc0gr
	PjensAaAuuTzIxoCc+AYMsTLk/IE1j5XQc5R1UUgFRTCQ7A25SUzU4lYz/ZuwY9ke6M6faBHHjb
	wfb0K0=
X-Received: by 2002:a17:90b:4a09:b0:38e:9c45:3b5 with SMTP id 98e67ed59e1d1-38f2977e15fmr4712879a91.8.1785112136116;
        Sun, 26 Jul 2026 17:28:56 -0700 (PDT)
Received: from com-76773.corp.openai.org ([20.102.114.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm19920328c88.8.2026.07.26.17.28.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 17:28:55 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v6 0/6] packfile URIs: support concurrent downloads
Date: Sun, 26 Jul 2026 17:28:37 -0700
Message-ID: <cover.1785111375.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785047139.git.tnyman@openai.com>
References: <cover.1785047139.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packfile URI and dumb HTTP downloads stage packs at
objects/pack/pack-<hash>.pack.temp so an interrupted transfer can
resume. Opening that file in append mode forces every write to its
current end. Two Git processes fetching the same pack into one object
database can therefore append duplicate data and corrupt the pack.

The first patch separates the unrelated --index-pack-arg documentation
and error-message correction requested during review.

The second patch fixes an existing double-close when
finish_http_pack_request() passes its staging-file descriptor to
index-pack. start_command() already takes ownership of that descriptor,
including when starting the child fails.

The third patch handles a completed partial pack independently of
concurrent downloads. A previous attempt can finish the transfer but
fail before indexing it; retrying then requests a range starting at EOF.
Servers may respond with HTTP 416 in that case. Treat the response as a
completed download and let index-pack validate the pack.

The fourth patch keeps the predictable staging name but removes append
mode. Each downloader seeks once to the current end, requests the
corresponding Range, and writes using its own descriptor offset. Since
the staging key must identify immutable pack contents, overlapping
responses write identical bytes at identical offsets. There is no need
for pwrite(2) or cross-process coordination, and resumption continues to
work for both packfile URI and ordinary dumb HTTP downloads.

The fifth patch handles the additional MinGW sharing requirement. Its
non-append O_RDWR open grants FILE_SHARE_DELETE only for an existing
file. Create a missing staging file exclusively, close it, and reopen
it without O_CREAT so every retained descriptor permits another
downloader to unlink the path.

The final patch handles the related .keep race. When another process has
already created the keep file, index-pack reports "pack<TAB><hash>"
instead of "keep<TAB><hash>". Accept both successful forms and remove
only keep files created by the current process. Read only the prefix and
hash so any following fsck output remains available to fetch-pack.

The tests cover resumption, a completed partial returning 416,
overlapping downloads, unlinking the staging path while index-pack holds
its descriptor, and a pre-existing .keep file. The completed-partial and
unlink tests do not require FIFOs, so they can run on MinGW even though
the concurrent-download test is skipped there.

Changes since v5:

* Split the existing double-close fix, HTTP 416 handling, generic
  concurrent-download fix, and Windows sharing fix into separate
  patches.
* Replace the FIFO-based concurrent HTTP 416 test with a standalone
  completed-partial test. Besides simplifying the test, this covers the
  non-concurrent interrupted-download case directly.
* Keep the final production code unchanged.

Each patch passes t5550-http-fetch-dumb.sh. The final series also passes
t5702-protocol-v2.sh, and the overlapping-download test passes 240 runs
with 12 parallel stress jobs.

The v5 discussion is at:

https://lore.kernel.org/git/cover.1785047139.git.tnyman@openai.com/

Ted Nyman (6):
  http-fetch: correct --index-pack-arg documentation
  http: avoid closing index-pack input twice
  http: accept HTTP 416 for complete partial packs
  http: avoid concurrent appends to partial packs
  http: permit unlinking partial packs on Windows
  fetch-pack: accept "pack" output for packfile URIs

 Documentation/git-http-fetch.adoc |  14 +-
 fetch-pack.c                      |  33 ++---
 http-fetch.c                      |   7 +-
 http-push.c                       |   3 +-
 http-walker.c                     |   3 +-
 http.c                            |  56 +++++---
 t/t5550-http-fetch-dumb.sh        | 204 ++++++++++++++++++++++++++++++
 t/t5702-protocol-v2.sh            |  31 +++++
 8 files changed, 305 insertions(+), 46 deletions(-)

Range-diff against v5:
1:  a79af009ea = 1:  b5050a88ca http-fetch: correct --index-pack-arg documentation
-:  ---------- > 2:  28662b0fd8 http: avoid closing index-pack input twice
-:  ---------- > 3:  677e5399eb http: accept HTTP 416 for complete partial packs
2:  d9667c93b0 ! 4:  7a83eb7091 http: avoid concurrent appends to partial packs
    @@ Commit message
         pack contents, overlapping responses write the same bytes at the same
         offsets instead of extending the file with duplicate data.
     
    -    MinGW's non-append O_RDWR open grants FILE_SHARE_DELETE only for an
    -    existing file. Create a missing partial pack exclusively, close it, and
    -    reopen it without O_CREAT so every retained descriptor permits another
    -    downloader to unlink the staging path. Duplicate that descriptor for
    -    index-pack instead of reopening the path after closing the stream;
    -    index-pack installs its own pack and the shared staging file is only
    -    unlinked, never renamed. Accept HTTP 416 when a partial pack is already
    -    complete and let index-pack validate its contents.
    +    Duplicate the staging descriptor for index-pack instead of reopening the
    +    path after closing the stream. Another downloader may unlink the staging
    +    path before indexing begins, but index-pack can still read the retained
    +    descriptor.
     
    -    Exercise resumed transfers, EOF ranges, overlapping 200 and 206
    -    responses, and unlinking the staging path while index-pack still holds
    -    its descriptor. Clarify the staging-key documentation.
    +    Exercise resumed transfers and overlapping 200 and 206 responses, and
    +    clarify the staging-key documentation.
     
         Signed-off-by: Ted Nyman <tnyman@openai.com>
     
    @@ Documentation/git-http-fetch.adoc: commit-id::
      
      --index-pack-arg=<arg>::
     
    - ## http-fetch.c ##
    -@@ http-fetch.c: static void fetch_single_packfile(struct object_id *packfile_hash,
    - 
    - 	if (start_active_slot(preq->slot)) {
    - 		run_active_slot(preq->slot);
    --		if (results.curl_result != CURLE_OK) {
    -+		if (results.curl_result != CURLE_OK &&
    -+		    results.http_code != 416) {
    - 			struct url_info url;
    - 			char *nurl = url_normalize(preq->url, &url);
    - 			if (!nurl || !git_env_bool("GIT_TRACE_REDACT", 1)) {
    -
    - ## http-push.c ##
    -@@ http-push.c: static void finish_request(struct transfer_request *request)
    - 
    - 	} else if (request->state == RUN_FETCH_PACKED) {
    - 		int fail = 1;
    --		if (request->curl_result != CURLE_OK) {
    -+		if (request->curl_result != CURLE_OK &&
    -+		    request->http_code != 416) {
    - 			fprintf(stderr, "Unable to get pack file %s\n%s",
    - 				request->url, curl_errorstr);
    - 		} else {
    -
    - ## http-walker.c ##
    -@@ http-walker.c: static int http_fetch_pack(struct walker *walker, struct alt_base *repo,
    - 
    - 	if (start_active_slot(preq->slot)) {
    - 		run_active_slot(preq->slot);
    --		if (results.curl_result != CURLE_OK) {
    -+		if (results.curl_result != CURLE_OK &&
    -+		    results.http_code != 416) {
    - 			error("Unable to get pack file %s\n%s", preq->url,
    - 			      curl_errorstr);
    - 			goto abort;
    -
      ## http.c ##
     @@ http.c: int finish_http_pack_request(struct http_pack_request *preq)
      	int tmpfile_fd;
    @@ http.c: int finish_http_pack_request(struct http_pack_request *preq)
      
      	ip.git_cmd = 1;
      	ip.in = tmpfile_fd;
    -@@ http.c: int finish_http_pack_request(struct http_pack_request *preq)
    - 	else
    - 		ip.no_stdout = 1;
    - 
    --	if (run_command(&ip)) {
    -+	if (run_command(&ip))
    - 		ret = -1;
    --		goto cleanup;
    --	}
    --
    --cleanup:
    --	close(tmpfile_fd);
    - 	unlink(preq->tmpfile.buf);
    - 	return ret;
    - }
     @@ http.c: struct http_pack_request *new_http_pack_request(
      struct http_pack_request *new_direct_http_pack_request(
      	const unsigned char *packed_git_hash, char *url)
    @@ http.c: struct http_pack_request *new_http_pack_request(
     -	if (!preq->packfile) {
     -		error("Unable to open local file %s for pack",
     -		      preq->tmpfile.buf);
    -+	/*
    -+	 * MinGW's non-append O_RDWR open grants FILE_SHARE_DELETE only for an
    -+	 * existing file; reopen a newly created file so others may unlink it.
    -+	 */
    -+	for (;;) {
    -+		fd = open(preq->tmpfile.buf, O_RDWR);
    -+		if (fd >= 0 || errno != ENOENT)
    -+			break;
    -+		fd = open(preq->tmpfile.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
    -+		if (fd >= 0) {
    -+			close(fd);
    -+			continue;
    -+		}
    -+		if (errno != EEXIST)
    -+			break;
    -+	}
    ++	fd = open(preq->tmpfile.buf, O_RDWR | O_CREAT, 0666);
     +	if (fd < 0) {
     +		error_errno("unable to open local file %s for pack",
     +			    preq->tmpfile.buf);
    - 		goto abort;
    - 	}
    ++		goto abort;
    ++	}
     +	prev_posn = lseek(fd, 0, SEEK_END);
     +	if (prev_posn < 0) {
     +		error_errno("unable to seek local file %s for pack",
     +			    preq->tmpfile.buf);
     +		close(fd);
    -+		goto abort;
    -+	}
    + 		goto abort;
    + 	}
     +	preq->packfile = xfdopen(fd, "w");
      
      	preq->slot = get_active_slot();
    @@ http.c: struct http_pack_request *new_direct_http_pack_request(
      				"Resuming fetch of pack %s at byte %"PRIuMAX"\n",
     
      ## t/t5550-http-fetch-dumb.sh ##
    -@@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
    - 	git -C packfileclient cat-file -e "$HASH"
    +@@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile accepts an already complete partial'
    + 	git -C packfileclient-complete cat-file -e "$HASH"
      '
      
     +test_expect_success 'http-fetch --packfile resumes a partial download' '
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
     +	git -C packfileclient-resume cat-file -e "$HASH"
     +'
     +
    -+test_expect_success 'http-fetch --packfile permits unlink while indexing' '
    -+	git init packfileclient-unlink &&
    -+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
    -+		ls objects/pack/pack-*.pack) &&
    -+	tmpfile="packfileclient-unlink/.git/objects/pack/pack-$ARBITRARY.pack.temp" &&
    -+	write_script git-unlink-index-pack <<-\EOF &&
    -+	test -f "$GIT_TEST_PACK_TEMP" || exit 1
    -+	rm "$GIT_TEST_PACK_TEMP" || exit 1
    -+	exec git index-pack "$@"
    -+	EOF
    -+	test_when_finished "rm -f git-unlink-index-pack" &&
    -+	PATH="$TRASH_DIRECTORY:$PATH" \
    -+	GIT_TEST_PACK_TEMP="$TRASH_DIRECTORY/$tmpfile" \
    -+	git -C packfileclient-unlink http-fetch --packfile="$ARBITRARY" \
    -+		--index-pack-arg=unlink-index-pack \
    -+		--index-pack-arg=--stdin --index-pack-arg=--keep \
    -+		"$HTTPD_URL/dumb/repo_pack.git/$p" >out &&
    -+	test_path_is_missing "$tmpfile" &&
    -+	git -C packfileclient-unlink cat-file -e "$HASH"
    -+'
    -+
    -+test_expect_success PIPE 'concurrent http-fetch --packfile accepts a complete partial' '
    -+	git init packfileclient-concurrent &&
    -+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
    -+		ls objects/pack/pack-*.pack) &&
    -+	packhash=$(basename "$p" .pack) &&
    -+	packhash=${packhash#pack-} &&
    -+	tmpfile="packfileclient-concurrent/.git/objects/pack/pack-$packhash.pack.temp" &&
    -+	test_copy_bytes 64 <"$HTTPD_DOCUMENT_ROOT_PATH/repo_pack.git/$p" >"$tmpfile" &&
    -+	mkfifo first-ready first-continue &&
    -+	exec 8<>first-ready &&
    -+	exec 9<>first-continue &&
    -+	write_script git-wait-index-pack <<-\EOF &&
    -+	echo ready >"$GIT_TEST_WAIT_READY" &&
    -+	read continue <"$GIT_TEST_WAIT_CONTINUE" &&
    -+	exec git index-pack "$@"
    -+	EOF
    -+	{
    -+		(
    -+			if ! PATH="$TRASH_DIRECTORY:$PATH" \
    -+			GIT_TEST_WAIT_READY="$TRASH_DIRECTORY/first-ready" \
    -+			GIT_TEST_WAIT_CONTINUE="$TRASH_DIRECTORY/first-continue" \
    -+			GIT_TRACE_CURL="$TRASH_DIRECTORY/first.trace" \
    -+			git -C packfileclient-concurrent http-fetch --packfile="$packhash" \
    -+				--index-pack-arg=wait-index-pack \
    -+				--index-pack-arg=--stdin --index-pack-arg=--keep \
    -+				"$HTTPD_URL/dumb/repo_pack.git/$p" >first.out
    -+			then
    -+				echo failed >"$TRASH_DIRECTORY/first-ready" &&
    -+				exit 1
    -+			fi
    -+		) &
    -+		first_pid=$!
    -+	} &&
    -+	test_when_finished "
    -+		echo continue >&9
    -+		kill $first_pid 2>/dev/null || :
    -+		wait $first_pid 2>/dev/null || :
    -+		exec 8>&-
    -+		exec 9>&-
    -+		rm -f first-ready first-continue git-wait-index-pack
    -+	" &&
    -+	read ready <&8 &&
    -+	test "$ready" = ready &&
    -+	GIT_TRACE_CURL="$TRASH_DIRECTORY/second.trace" \
    -+	git -C packfileclient-concurrent http-fetch --packfile="$packhash" \
    -+		--index-pack-arg=index-pack \
    -+		--index-pack-arg=--stdin --index-pack-arg=--keep \
    -+		"$HTTPD_URL/dumb/repo_pack.git/$p" >second.out &&
    -+	echo continue >&9 &&
    -+	wait "$first_pid" &&
    -+	printf "pack\t%s\n" "$packhash" >expect &&
    -+	test_cmp expect first.out &&
    -+	printf "keep\t%s\n" "$packhash" >expect &&
    -+	test_cmp expect second.out &&
    -+	test_grep "Range: bytes=64-" first.trace &&
    -+	test_grep "Range: bytes=[0-9]*-" second.trace &&
    -+	test_grep "416 Requested Range Not Satisfiable" second.trace &&
    -+	test_path_is_missing "$tmpfile" &&
    -+	git -C packfileclient-concurrent cat-file -e "$HASH"
    -+'
    -+
     +test_expect_success PERL,PIPE 'concurrent http-fetch --packfile cannot corrupt an overlapping download' '
     +	git init packfileclient-overlap &&
     +	blob=$(test-tool genrandom pack-overlap 2m |
-:  ---------- > 5:  87a20ac80f http: permit unlinking partial packs on Windows
3:  fee6f292cb = 6:  be9e2fe273 fetch-pack: accept "pack" output for packfile URIs

base-commit: 5d2e7709234afea1b6ddb25cd4f60d3d5fb3c200
-- 
2.55.0.openai.131.g83a728de1eb6
