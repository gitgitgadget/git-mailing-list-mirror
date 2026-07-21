Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB593AF643
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676614; cv=none; b=HOICmS3xJEieu7phtsoq6JsJOQHp8mpssaLt1pGBuJBIpc0PhmSAgXXdy3v2gSbARYJ4GezcG52RruiYyLVfeHfrfR43oaO0OskNR/B1cW/Y4xTyxPShLxv7G/6I2KuyQpM8x3mPlKR71DsVx8U5GqCsmYnZWLOBrU06k3x8Zvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676614; c=relaxed/simple;
	bh=9uRwEhhD4i3J9iNeDtDFtNoY3GC0hZUv3b0HZCD0kl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyNL10ynqxQmvuRvXp4RNzY+VDfrF2qbEX4TXwq201IiiBjd9g0Lr3pGeQI77tDzQTvJdb3ghfFQpPibK5gFPYnfZ3KHe15nhk0eTi6WzJO5fkE/4qSFJHcpN3cWeiBwLmkpFgJw4Ml+OvZ9VrsOX9usIOpwrU2f2HiVa2eBuDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=JUlD2ebM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="JUlD2ebM"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ea2b8f128aso15601136d6.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784676612; x=1785281412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GArZXdDASpnW1B9QVBJPtIO14MSnGQoUV2WKSEwLeSs=;
        b=JUlD2ebMwQ0yAKhKZujaFzIMgsAawBihhp/FqrEZ3jn/AeTQfc3LLLeWRyS1SI3JhX
         4+djGwSSdKuJErxPHE385A8mQUu0ykL+fnC+ngwQ4vjvCh3WL8rY75+TbzKocqFDwdZY
         Y+23N7JCwNxqKa+E+WazGYFG47XFXmr+KNKBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784676612; x=1785281412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GArZXdDASpnW1B9QVBJPtIO14MSnGQoUV2WKSEwLeSs=;
        b=pNLTPXIg7WoSoYk/OouKJomnhpmElafK9ciLoU9ywdGQkFrLUqClNmvDnNMq5TUvXK
         5jZvKe1hKcj24n5xKFDFxhCPCv3spQIqIAqORGR2akHK2mJoblun2AORPRsoMBPYjL0h
         mR5VyjvLaPgEWDTJS+v6g+aGVoviLw7wz5ail2kaqaJaI9Kjbw7Yng/dDA2kk3CmYTPV
         35piTgM1SBkia+21O+r1kEUgsv5hyFGiLO5VM8T2bLlPP8sHykzY4ZeTje100wnb0h/m
         OUittPFjLUG1xdv1+voBmqbNhwt+tU+Hd+IuMzzJWTebfA6JRxUBGKa2irxSpp8FLSFr
         PRuA==
X-Gm-Message-State: AOJu0Yxnon20CR5SSO7617C1vW06gMPPcOQ5652S7k6nSHQq1B98ggbP
	gqY92XxkBvbyrS3zWVw/K/eMgHTgjJT1ZJJZtHDcvLg5XtxNWwv7Lw9Sak1paeo4ww1VfelsC3+
	wZndgRZQ=
X-Gm-Gg: AR+sD12A0ZxF8v/0DcoKKxdY5Qg2uSV1c7sF/06+IhcsgWPju9mD8a7EuNbl7z8Wjdj
	9JLhDXTLqbyOG9AVI99qJ8VLbo0sjxXHicCaqNW3/8gJy1srow/6ZpJtbbVZLkYMRUxpDFLggOB
	ODsd4uuYBBaM3h9Cykp6cIwIvCNOKr6Apml9XKVRQqjGZQD6ZdP/BUXmVJsHq9+TqI/F/D+q6t4
	zK5p/WLq7crXTaZbL6eKRzgIRh8fHjihulYrn2CYFV7tz55Hc7jsBqXVp6xJ543ive3TKMCzcSj
	rH+DwoHHR0KWyySkshoRgWh/+H147p6cjAlLK7X4LPIvYaSD0NxbMgBBKe7hSSGas4u4sf0l0p5
	J09nBQnrs7T9sOrDATGcNACfNHj/VKhGtY5k73uYKMv+VYiVr/JS5sD7LhdABl1Ah4n6Z7t9qDt
	xpKeeRbSwo31SlbLOkP2FMkgdJSTmz7ADrKl58oSMcSYhqlZPpaAWs1nHNqrQVYIo9sSuJTSb64
	VmG5+o=
X-Received: by 2002:a05:620a:271b:b0:92e:5272:4e3e with SMTP id af79cd13be357-930e6dd6fe8mr453806685a.0.1784676611465;
        Tue, 21 Jul 2026 16:30:11 -0700 (PDT)
Received: from com-76773.corp.openai.org ([209.249.37.147])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a0b2c7sm16008585a.24.2026.07.21.16.30.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 16:30:10 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v3 0/3] packfile URIs: support concurrent downloads
Date: Tue, 21 Jul 2026 16:29:39 -0700
Message-ID: <cover.1784676106.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0.337.g1ee5d7e027
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
resume. Opening that file in append mode forces every write to its
current end. Two Git processes fetching the same pack into one object
database can therefore append duplicate data and corrupt the pack.

The first patch separates the unrelated --index-pack-arg documentation
and error-message correction requested during review.

The second patch keeps the predictable staging name but removes append
mode. Each downloader seeks once to the current end, requests the
corresponding Range, and writes using its own descriptor offset. Since
the staging key must identify immutable pack contents, overlapping
responses write identical bytes at identical offsets. There is no need
for pwrite(2) or cross-process coordination, and resumption continues to
work for both packfile URI and ordinary dumb HTTP downloads.

A downloader can also find that the partial pack has completed and
request a range starting at EOF. Servers may respond with HTTP 416 in
that case. Treat the response as a completed download and let
index-pack validate the pack.

On MinGW, the non-append O_RDWR open grants FILE_SHARE_DELETE only for an
existing file. Create a missing staging file exclusively, close it, and
reopen it without O_CREAT so every retained descriptor permits another
downloader to unlink the path. Keep the open descriptor for index-pack;
it installs its own pack, so the shared staging file is only unlinked,
never renamed.

The third patch handles the related .keep race. When another process has
already created the keep file, index-pack reports "pack<TAB><hash>"
instead of "keep<TAB><hash>". Accept both successful forms and remove
only keep files created by the current process. Read only the prefix and
hash so any following fsck output remains available to fetch-pack.

The tests cover resumption, a completed partial returning 416,
overlapping 200 and 206 responses, unlinking the staging path while
index-pack holds its descriptor, and a pre-existing .keep file. The
unlink test does not require FIFOs, so it can exercise MinGW's sharing
behavior even though the concurrent-download tests are skipped there.

Changes since v2:

  * Split the --index-pack-arg documentation and error-message cleanup
    into a preliminary patch, as requested by Junio.
  * Clarify why per-descriptor offsets keep overlapping writes safe and
    why MinGW permits the shared staging path to be unlinked.
  * Add a non-FIFO unlink-while-indexing regression test that can run on
    MinGW.
  * Rebase onto the current master.

The v2 discussion is at:

  https://lore.kernel.org/git/cover.1784582665.git.tnyman@openai.com/

Ted Nyman (3):
  http-fetch: correct --index-pack-arg documentation
  http: avoid concurrent appends to partial packs
  fetch-pack: accept "pack" output for packfile URIs

 Documentation/git-http-fetch.adoc |  13 +-
 fetch-pack.c                      |  33 ++--
 http-fetch.c                      |   7 +-
 http-push.c                       |   3 +-
 http-walker.c                     |   3 +-
 http.c                            |  56 ++++---
 t/t5550-http-fetch-dumb.sh        | 244 ++++++++++++++++++++++++++++++
 t/t5702-protocol-v2.sh            |  31 ++++
 8 files changed, 344 insertions(+), 46 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  a6a40b8046 http-fetch: correct --index-pack-arg documentation
1:  160a9b9fd0 ! 2:  6c91054afc http: avoid concurrent appends to partial packs
    @@ Commit message
     
         Pack requests stage downloads in a predictable partial-pack file so an
         interrupted transfer can be resumed. Both packfile URI and ordinary dumb
    -    HTTP requests use this staging path. Opening it in append mode lets
    -    concurrent fetches interleave their writes, corrupting the pack or
    -    causing a later fetch to request a range at EOF.
    +    HTTP requests use this staging path. Opening it in append mode forces
    +    each write to the current end of the file, so concurrent responses can
    +    append duplicate data and corrupt the pack.
     
    -    Open the partial pack read-write, seek to its current end, and retain a
    -    per-descriptor offset for incoming data. Reopen newly created partial
    -    packs without O_CREAT so Windows permits concurrent unlink, and keep the
    -    descriptor for index-pack when another downloader removes the staging
    -    path. Accept HTTP 416 when a partial pack is already complete.
    +    Open the partial pack read-write without O_APPEND and seek once to its
    +    current end. Each downloader then retains the offset matching the Range
    +    it requested. Because the staging key must uniquely identify immutable
    +    pack contents, overlapping responses write the same bytes at the same
    +    offsets instead of extending the file with duplicate data.
     
    -    Exercise resumed transfers, EOF ranges, and overlapping 200 and 206
    -    responses. Clarify the staging-key documentation and correct the stale
    -    --index-pack-args spelling in the documentation and error messages; the
    -    repeatable --index-pack-arg option is already accepted.
    +    MinGW's non-append O_RDWR open grants FILE_SHARE_DELETE only for an
    +    existing file. Create a missing partial pack exclusively, close it, and
    +    reopen it without O_CREAT so every retained descriptor permits another
    +    downloader to unlink the staging path. Duplicate that descriptor for
    +    index-pack instead of reopening the path after closing the stream;
    +    index-pack installs its own pack and the shared staging file is only
    +    unlinked, never renamed. Accept HTTP 416 when a partial pack is already
    +    complete and let index-pack validate its contents.
    +
    +    Exercise resumed transfers, EOF ranges, overlapping 200 and 206
    +    responses, and unlinking the staging path while index-pack still holds
    +    its descriptor. Clarify the staging-key documentation.
     
         Signed-off-by: Ted Nyman <tnyman@openai.com>
     
    @@ Documentation/git-http-fetch.adoc: commit-id::
      	URL and uses index-pack to generate corresponding .idx and .keep files.
     -	The hash is used to determine the name of the temporary file and is
     -	arbitrary. The output of index-pack is printed to stdout. Requires
    --	--index-pack-args.
     +	The hash is used to determine the name of the temporary file. It need
     +	not be the pack hash, but it must uniquely identify the pack contents
     +	for resumption. The output of index-pack is printed to stdout. Requires
    -+	one or more --index-pack-arg options.
    - 
    ----index-pack-args=<args>::
    --	For internal use only. The command to run on the contents of the
    --	downloaded pack. Arguments are URL-encoded separated by spaces.
    -+--index-pack-arg=<arg>::
    -+	For internal use only. An argument to the command run on the contents
    -+	of the downloaded pack. This option can be specified multiple times.
    + 	one or more --index-pack-arg options.
      
    - --recover::
    - 	Verify that everything reachable from target is fetched.  Used after
    + --index-pack-arg=<arg>::
     
      ## http-fetch.c ##
     @@ http-fetch.c: static void fetch_single_packfile(struct object_id *packfile_hash,
    @@ http-fetch.c: static void fetch_single_packfile(struct object_id *packfile_hash,
      			struct url_info url;
      			char *nurl = url_normalize(preq->url, &url);
      			if (!nurl || !git_env_bool("GIT_TRACE_REDACT", 1)) {
    -@@ http-fetch.c: int cmd_main(int argc, const char **argv)
    - 
    - 	if (packfile) {
    - 		if (!index_pack_args.nr)
    --			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-args");
    -+			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-arg");
    - 
    - 		fetch_single_packfile(&packfile_hash, argv[arg],
    - 				      index_pack_args.v);
    -@@ http-fetch.c: int cmd_main(int argc, const char **argv)
    - 	}
    - 
    - 	if (index_pack_args.nr)
    --		die(_("the option '%s' requires '%s'"), "--index-pack-args", "--packfile");
    -+		die(_("the option '%s' requires '%s'"), "--index-pack-arg", "--packfile");
    - 
    - 	if (commits_on_stdin) {
    - 		commits = walker_targets_stdin(&commit_id, &write_ref);
     
      ## http-push.c ##
     @@ http-push.c: static void finish_request(struct transfer_request *request)
    @@ http.c: struct http_pack_request *new_http_pack_request(
     -	if (!preq->packfile) {
     -		error("Unable to open local file %s for pack",
     -		      preq->tmpfile.buf);
    -+	/* Reopen without O_CREAT so MinGW permits another writer to unlink it. */
    ++	/*
    ++	 * MinGW's non-append O_RDWR open grants FILE_SHARE_DELETE only for an
    ++	 * existing file; reopen a newly created file so others may unlink it.
    ++	 */
     +	for (;;) {
     +		fd = open(preq->tmpfile.buf, O_RDWR);
     +		if (fd >= 0 || errno != ENOENT)
    @@ http.c: struct http_pack_request *new_http_pack_request(
     +	if (fd < 0) {
     +		error_errno("unable to open local file %s for pack",
     +			    preq->tmpfile.buf);
    -+		goto abort;
    -+	}
    + 		goto abort;
    + 	}
     +	prev_posn = lseek(fd, 0, SEEK_END);
     +	if (prev_posn < 0) {
     +		error_errno("unable to seek local file %s for pack",
     +			    preq->tmpfile.buf);
     +		close(fd);
    - 		goto abort;
    - 	}
    ++		goto abort;
    ++	}
     +	preq->packfile = xfdopen(fd, "w");
      
      	preq->slot = get_active_slot();
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'http-fetch --packfile' '
     +	git -C packfileclient-resume cat-file -e "$HASH"
     +'
     +
    ++test_expect_success 'http-fetch --packfile permits unlink while indexing' '
    ++	git init packfileclient-unlink &&
    ++	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
    ++		ls objects/pack/pack-*.pack) &&
    ++	tmpfile="packfileclient-unlink/.git/objects/pack/pack-$ARBITRARY.pack.temp" &&
    ++	write_script git-unlink-index-pack <<-\EOF &&
    ++	test -f "$GIT_TEST_PACK_TEMP" || exit 1
    ++	rm "$GIT_TEST_PACK_TEMP" || exit 1
    ++	exec git index-pack "$@"
    ++	EOF
    ++	test_when_finished "rm -f git-unlink-index-pack" &&
    ++	PATH="$TRASH_DIRECTORY:$PATH" \
    ++	GIT_TEST_PACK_TEMP="$TRASH_DIRECTORY/$tmpfile" \
    ++	git -C packfileclient-unlink http-fetch --packfile="$ARBITRARY" \
    ++		--index-pack-arg=unlink-index-pack \
    ++		--index-pack-arg=--stdin --index-pack-arg=--keep \
    ++		"$HTTPD_URL/dumb/repo_pack.git/$p" >out &&
    ++	test_path_is_missing "$tmpfile" &&
    ++	git -C packfileclient-unlink cat-file -e "$HASH"
    ++'
    ++
     +test_expect_success PIPE 'concurrent http-fetch --packfile accepts a complete partial' '
     +	git init packfileclient-concurrent &&
     +	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
2:  9b41d4ddb3 = 3:  1ee5d7e027 fetch-pack: accept "pack" output for packfile URIs

base-commit: 5d2e7709234afea1b6ddb25cd4f60d3d5fb3c200
-- 
2.55.0.openai.131.g83a728de1eb6
