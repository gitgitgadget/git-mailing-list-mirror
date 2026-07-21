Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DE346ADB
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784676618; cv=none; b=qtTNRmrOJtnVy+tzFQaMoche7i6IFuwnT3sxgbV8xZiyIIVzKouSyfEobQ4UQBo+jDpwrNsXDZBQa2LPK0FVv4F/ohEn7dzQNbK7Banjz7ZzPaMKDqo9eReeroQKEQoPXvPyHWN+QWeWx2Hd14aED0tEKix+9dED79uu1XpGd8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784676618; c=relaxed/simple;
	bh=HUZPY116fKZi5qnAcLr06p9wtoKvvzyWKBkdwfW2ML8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQjQKhlQmrDzraEBHVwtRERhJJ+cOCLCdpojkyykTzXnrPlWJPnqNI2UHpnbDR/ChmBvT7LzJRLhG6wuZziDALBjK51k24mGO74R9CCsFaEnQ9WYGRGGjkcXUJWjvWjLkJk4zV5IeS0PQYsS5zLiWSh5ZnStlyGxZ2RIg05t8mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=N0S+3+KN; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="N0S+3+KN"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e814b433bso133325185a.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 16:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784676616; x=1785281416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PWiri/C5dgNzGl9oB3LMHZ40uZ5iUtDdTHzi/vkvy8Y=;
        b=N0S+3+KNpytjWDAmaAlV89ux5BFso2o2A9k2qou8Do0KmCbsiYtCnuU0bRlGrxMFBW
         uDWExpE+rzwnlMafJKFBuBJ4hfA7oqUAcQZYAZG5Rnb/NZXcpgoybIdypavKikhthjHU
         HhgVPHX2oXUDdFu9bJK7TOiI+qzfHJbJq6u6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784676616; x=1785281416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PWiri/C5dgNzGl9oB3LMHZ40uZ5iUtDdTHzi/vkvy8Y=;
        b=QIbY6XirkaG2qb4qzuXlgwJq+veLxipWob6hRmGDzwTjm+Lhny32JGive44wotyxB/
         I1IDQVrV3hJtWwuoeBMMcrO2stfObImd6Zi5hRRZdrT7KmmbeK/Ry1TW1JZ+DQ7aF0Xp
         swqtyRpDMt4OQKk5hWddBnZa6k+mn7sqgfCbwEMc7uASuAFn+vgr5cTx0W25suvaFW8g
         Pge0cBO5S/MoOEnpgTZR4q1g+omMiVuu9GVO9I+Z6MN+t5zqfjKM26A/6xmaR8S+/QM5
         bwom7Vahtbtva8iusqIrul+o56xBamWV8aus6rnCHbs/j/rJgOutXZWVZv7V1Iqq6Z7c
         lGCA==
X-Gm-Message-State: AOJu0Yz2bHArwXvkhLr2M1zDxaCj3buUoRmi7USfgRFKyPs6ujfpaTyH
	A3ywiYP9/SGiURKC8ZR4dNpQ1eRq5hBuFqpwzYBQ/cFqf4YpxnxRwLljHoQ/tQNJPY12v/YXxpj
	o2h5lf6E=
X-Gm-Gg: AfdE7cn8HzFIThnYQD8FtYHrVmd4oOoAWB2ohz1u1xCz3+NTDDLrXSgorACi0CdfiW6
	BQbmF7rewrPdJO+i5pWElPbqL19VW5P0IaodCi22m/b8y+DeuS2AXm8xa6Ifh0IzKMp4x9m5eBf
	auf6TZrgLIYCm1eXgbj/o11s9MKAwB22tblatiyppATkOwXoNqhyflEAoOjxoG5lWGFMQUHRtBF
	V8gbjGpHJlhoEVuJm63fkHAYU9Omm6buWr9a65OV5dH9iS9axzg2clLgQvUCi+37qR4JLJxwbqQ
	o2uoGQn65bWaG6Xcs+L4ZdDfdwGh2qD7XBEbMu8CbRqxAy/ImNliSATmuOI/4La77KSoLBTVhX7
	d7KxNqfxFdtPI3pi5teRoNj+2hiuSbg5RvpMwx/3fh1lxFQAeOXYKVpKEcgLB2u4pdJUlh1fXOo
	ipBeb7G8wnkUqMUBnvf8fkAd/7Fo6ui64O54d9T2dw3GN4KArxhl8MzI8IuPhXuogCgASblfQ/7
	KiaJk4=
X-Received: by 2002:a05:620a:2783:b0:930:831e:1299 with SMTP id af79cd13be357-930e70869b9mr470560985a.6.1784676615455;
        Tue, 21 Jul 2026 16:30:15 -0700 (PDT)
Received: from com-76773.corp.openai.org ([209.249.37.147])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f6a0b2c7sm16008585a.24.2026.07.21.16.30.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Jul 2026 16:30:14 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v3 2/3] http: avoid concurrent appends to partial packs
Date: Tue, 21 Jul 2026 16:29:41 -0700
Message-ID: <6c91054afcf911f10450df036526d7d374e1e56f.1784676106.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0.337.g1ee5d7e027
In-Reply-To: <cover.1784676106.git.tnyman@openai.com>
References: <cover.1783982021.git.tnyman@openai.com> <cover.1784676106.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pack requests stage downloads in a predictable partial-pack file so an
interrupted transfer can be resumed. Both packfile URI and ordinary dumb
HTTP requests use this staging path. Opening it in append mode forces
each write to the current end of the file, so concurrent responses can
append duplicate data and corrupt the pack.

Open the partial pack read-write without O_APPEND and seek once to its
current end. Each downloader then retains the offset matching the Range
it requested. Because the staging key must uniquely identify immutable
pack contents, overlapping responses write the same bytes at the same
offsets instead of extending the file with duplicate data.

MinGW's non-append O_RDWR open grants FILE_SHARE_DELETE only for an
existing file. Create a missing partial pack exclusively, close it, and
reopen it without O_CREAT so every retained descriptor permits another
downloader to unlink the staging path. Duplicate that descriptor for
index-pack instead of reopening the path after closing the stream;
index-pack installs its own pack and the shared staging file is only
unlinked, never renamed. Accept HTTP 416 when a partial pack is already
complete and let index-pack validate its contents.

Exercise resumed transfers, EOF ranges, overlapping 200 and 206
responses, and unlinking the staging path while index-pack still holds
its descriptor. Clarify the staging-key documentation.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 Documentation/git-http-fetch.adoc |   5 +-
 http-fetch.c                      |   3 +-
 http-push.c                       |   3 +-
 http-walker.c                     |   3 +-
 http.c                            |  56 ++++---
 t/t5550-http-fetch-dumb.sh        | 244 ++++++++++++++++++++++++++++++
 6 files changed, 289 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
index 09b5d675ee..60ca91cf3a 100644
--- a/Documentation/git-http-fetch.adoc
+++ b/Documentation/git-http-fetch.adoc
@@ -48,8 +48,9 @@ commit-id::
 	line (which is not expected in
 	this case), 'git http-fetch' fetches the packfile directly at the given
 	URL and uses index-pack to generate corresponding .idx and .keep files.
-	The hash is used to determine the name of the temporary file and is
-	arbitrary. The output of index-pack is printed to stdout. Requires
+	The hash is used to determine the name of the temporary file. It need
+	not be the pack hash, but it must uniquely identify the pack contents
+	for resumption. The output of index-pack is printed to stdout. Requires
 	one or more --index-pack-arg options.
 
 --index-pack-arg=<arg>::
diff --git a/http-fetch.c b/http-fetch.c
index 601a77c3c1..05f68f306a 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -70,7 +70,8 @@ static void fetch_single_packfile(struct object_id *packfile_hash,
 
 	if (start_active_slot(preq->slot)) {
 		run_active_slot(preq->slot);
-		if (results.curl_result != CURLE_OK) {
+		if (results.curl_result != CURLE_OK &&
+		    results.http_code != 416) {
 			struct url_info url;
 			char *nurl = url_normalize(preq->url, &url);
 			if (!nurl || !git_env_bool("GIT_TRACE_REDACT", 1)) {
diff --git a/http-push.c b/http-push.c
index 60f6f8f054..ef8abe3908 100644
--- a/http-push.c
+++ b/http-push.c
@@ -595,7 +595,8 @@ static void finish_request(struct transfer_request *request)
 
 	} else if (request->state == RUN_FETCH_PACKED) {
 		int fail = 1;
-		if (request->curl_result != CURLE_OK) {
+		if (request->curl_result != CURLE_OK &&
+		    request->http_code != 416) {
 			fprintf(stderr, "Unable to get pack file %s\n%s",
 				request->url, curl_errorstr);
 		} else {
diff --git a/http-walker.c b/http-walker.c
index b58a3b2a92..abafca84d6 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -451,7 +451,8 @@ static int http_fetch_pack(struct walker *walker, struct alt_base *repo,
 
 	if (start_active_slot(preq->slot)) {
 		run_active_slot(preq->slot);
-		if (results.curl_result != CURLE_OK) {
+		if (results.curl_result != CURLE_OK &&
+		    results.http_code != 416) {
 			error("Unable to get pack file %s\n%s", preq->url,
 			      curl_errorstr);
 			goto abort;
diff --git a/http.c b/http.c
index caccf2108e..a0d399b274 100644
--- a/http.c
+++ b/http.c
@@ -2688,10 +2688,13 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	int tmpfile_fd;
 	int ret = 0;
 
+	/* Another downloader may unlink the staging path while we index it. */
+	tmpfile_fd = xdup(fileno(preq->packfile));
 	fclose(preq->packfile);
 	preq->packfile = NULL;
-
-	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
+	if (lseek(tmpfile_fd, 0, SEEK_SET) < 0)
+		die_errno("unable to seek local file %s for pack",
+			  preq->tmpfile.buf);
 
 	ip.git_cmd = 1;
 	ip.in = tmpfile_fd;
@@ -2704,13 +2707,8 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	else
 		ip.no_stdout = 1;
 
-	if (run_command(&ip)) {
+	if (run_command(&ip))
 		ret = -1;
-		goto cleanup;
-	}
-
-cleanup:
-	close(tmpfile_fd);
 	unlink(preq->tmpfile.buf);
 	return ret;
 }
@@ -2738,22 +2736,45 @@ struct http_pack_request *new_http_pack_request(
 struct http_pack_request *new_direct_http_pack_request(
 	const unsigned char *packed_git_hash, char *url)
 {
-	off_t prev_posn = 0;
+	off_t prev_posn;
 	struct http_pack_request *preq;
+	int fd;
 
 	CALLOC_ARRAY(preq, 1);
 	strbuf_init(&preq->tmpfile, 0);
-
 	preq->url = url;
 
 	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
 	strbuf_addstr(&preq->tmpfile, ".temp");
-	preq->packfile = fopen(preq->tmpfile.buf, "a");
-	if (!preq->packfile) {
-		error("Unable to open local file %s for pack",
-		      preq->tmpfile.buf);
+	/*
+	 * MinGW's non-append O_RDWR open grants FILE_SHARE_DELETE only for an
+	 * existing file; reopen a newly created file so others may unlink it.
+	 */
+	for (;;) {
+		fd = open(preq->tmpfile.buf, O_RDWR);
+		if (fd >= 0 || errno != ENOENT)
+			break;
+		fd = open(preq->tmpfile.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
+		if (fd >= 0) {
+			close(fd);
+			continue;
+		}
+		if (errno != EEXIST)
+			break;
+	}
+	if (fd < 0) {
+		error_errno("unable to open local file %s for pack",
+			    preq->tmpfile.buf);
 		goto abort;
 	}
+	prev_posn = lseek(fd, 0, SEEK_END);
+	if (prev_posn < 0) {
+		error_errno("unable to seek local file %s for pack",
+			    preq->tmpfile.buf);
+		close(fd);
+		goto abort;
+	}
+	preq->packfile = xfdopen(fd, "w");
 
 	preq->slot = get_active_slot();
 	preq->headers = object_request_headers();
@@ -2762,12 +2783,7 @@ struct http_pack_request *new_direct_http_pack_request(
 	curl_easy_setopt(preq->slot->curl, CURLOPT_URL, preq->url);
 	curl_easy_setopt(preq->slot->curl, CURLOPT_HTTPHEADER, preq->headers);
 
-	/*
-	 * If there is data present from a previous transfer attempt,
-	 * resume where it left off
-	 */
-	prev_posn = ftello(preq->packfile);
-	if (prev_posn>0) {
+	if (prev_posn > 0) {
 		if (http_is_verbose)
 			fprintf(stderr,
 				"Resuming fetch of pack %s at byte %"PRIuMAX"\n",
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index f00eeae48f..65b42c4719 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -293,6 +293,250 @@ test_expect_success 'http-fetch --packfile' '
 	git -C packfileclient cat-file -e "$HASH"
 '
 
+test_expect_success 'http-fetch --packfile resumes a partial download' '
+	git init packfileclient-resume &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+		ls objects/pack/pack-*.pack) &&
+	tmpfile="packfileclient-resume/.git/objects/pack/pack-$ARBITRARY.pack.temp" &&
+	test_copy_bytes 64 <"$HTTPD_DOCUMENT_ROOT_PATH/repo_pack.git/$p" >"$tmpfile" &&
+	GIT_TRACE_CURL="$TRASH_DIRECTORY/resume.trace" \
+	git -C packfileclient-resume http-fetch --packfile="$ARBITRARY" \
+		--index-pack-arg=index-pack --index-pack-arg=--stdin \
+		--index-pack-arg=--keep \
+		"$HTTPD_URL/dumb/repo_pack.git/$p" >out &&
+	test_grep "Range: bytes=64-" resume.trace &&
+	test_path_is_missing "$tmpfile" &&
+	git -C packfileclient-resume cat-file -e "$HASH"
+'
+
+test_expect_success 'http-fetch --packfile permits unlink while indexing' '
+	git init packfileclient-unlink &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+		ls objects/pack/pack-*.pack) &&
+	tmpfile="packfileclient-unlink/.git/objects/pack/pack-$ARBITRARY.pack.temp" &&
+	write_script git-unlink-index-pack <<-\EOF &&
+	test -f "$GIT_TEST_PACK_TEMP" || exit 1
+	rm "$GIT_TEST_PACK_TEMP" || exit 1
+	exec git index-pack "$@"
+	EOF
+	test_when_finished "rm -f git-unlink-index-pack" &&
+	PATH="$TRASH_DIRECTORY:$PATH" \
+	GIT_TEST_PACK_TEMP="$TRASH_DIRECTORY/$tmpfile" \
+	git -C packfileclient-unlink http-fetch --packfile="$ARBITRARY" \
+		--index-pack-arg=unlink-index-pack \
+		--index-pack-arg=--stdin --index-pack-arg=--keep \
+		"$HTTPD_URL/dumb/repo_pack.git/$p" >out &&
+	test_path_is_missing "$tmpfile" &&
+	git -C packfileclient-unlink cat-file -e "$HASH"
+'
+
+test_expect_success PIPE 'concurrent http-fetch --packfile accepts a complete partial' '
+	git init packfileclient-concurrent &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+		ls objects/pack/pack-*.pack) &&
+	packhash=$(basename "$p" .pack) &&
+	packhash=${packhash#pack-} &&
+	tmpfile="packfileclient-concurrent/.git/objects/pack/pack-$packhash.pack.temp" &&
+	test_copy_bytes 64 <"$HTTPD_DOCUMENT_ROOT_PATH/repo_pack.git/$p" >"$tmpfile" &&
+	mkfifo first-ready first-continue &&
+	exec 8<>first-ready &&
+	exec 9<>first-continue &&
+	write_script git-wait-index-pack <<-\EOF &&
+	echo ready >"$GIT_TEST_WAIT_READY" &&
+	read continue <"$GIT_TEST_WAIT_CONTINUE" &&
+	exec git index-pack "$@"
+	EOF
+	{
+		(
+			if ! PATH="$TRASH_DIRECTORY:$PATH" \
+			GIT_TEST_WAIT_READY="$TRASH_DIRECTORY/first-ready" \
+			GIT_TEST_WAIT_CONTINUE="$TRASH_DIRECTORY/first-continue" \
+			GIT_TRACE_CURL="$TRASH_DIRECTORY/first.trace" \
+			git -C packfileclient-concurrent http-fetch --packfile="$packhash" \
+				--index-pack-arg=wait-index-pack \
+				--index-pack-arg=--stdin --index-pack-arg=--keep \
+				"$HTTPD_URL/dumb/repo_pack.git/$p" >first.out
+			then
+				echo failed >"$TRASH_DIRECTORY/first-ready" &&
+				exit 1
+			fi
+		) &
+		first_pid=$!
+	} &&
+	test_when_finished "
+		echo continue >&9
+		kill $first_pid 2>/dev/null || :
+		wait $first_pid 2>/dev/null || :
+		exec 8>&-
+		exec 9>&-
+		rm -f first-ready first-continue git-wait-index-pack
+	" &&
+	read ready <&8 &&
+	test "$ready" = ready &&
+	GIT_TRACE_CURL="$TRASH_DIRECTORY/second.trace" \
+	git -C packfileclient-concurrent http-fetch --packfile="$packhash" \
+		--index-pack-arg=index-pack \
+		--index-pack-arg=--stdin --index-pack-arg=--keep \
+		"$HTTPD_URL/dumb/repo_pack.git/$p" >second.out &&
+	echo continue >&9 &&
+	wait "$first_pid" &&
+	printf "pack\t%s\n" "$packhash" >expect &&
+	test_cmp expect first.out &&
+	printf "keep\t%s\n" "$packhash" >expect &&
+	test_cmp expect second.out &&
+	test_grep "Range: bytes=64-" first.trace &&
+	test_grep "Range: bytes=[0-9]*-" second.trace &&
+	test_grep "HTTP/[0-9.]* 416" second.trace &&
+	test_path_is_missing "$tmpfile" &&
+	git -C packfileclient-concurrent cat-file -e "$HASH"
+'
+
+test_expect_success PERL,PIPE 'concurrent http-fetch --packfile cannot corrupt an overlapping download' '
+	git init packfileclient-overlap &&
+	blob=$(test-tool genrandom pack-overlap 2m |
+		git -C "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git \
+			hash-object -w --stdin) &&
+	packhash=$(printf "%s\n" "$blob" |
+		git -C "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git \
+			pack-objects "$TRASH_DIRECTORY/overlap-pack") &&
+	pack="$TRASH_DIRECTORY/overlap-pack-$packhash.pack" &&
+	tmpfile="packfileclient-overlap/.git/objects/pack/pack-$packhash.pack.temp" &&
+	mkfifo server-ready first-ready &&
+	exec 7<>server-ready &&
+	exec 8<>first-ready &&
+	write_script slow-pack-server "$PERL_PATH" <<-\EOF &&
+	use strict;
+	use warnings;
+	use IO::Socket::INET;
+
+	my ($packfile, $server_ready, $first_ready) = @ARGV;
+	open(my $in, "<:raw", $packfile) or die "open $packfile: $!";
+	my $pack = do { local $/; <$in> };
+	close($in) or die "close $packfile: $!";
+	my $server = IO::Socket::INET->new(LocalAddr => "127.0.0.1",
+		LocalPort => 0, Proto => "tcp", Listen => 2, ReuseAddr => 1)
+		or die "listen: $!";
+
+	sub signal_ready {
+		my ($file, $value) = @_;
+		open(my $out, ">", $file) or die "open $file: $!";
+		print $out "$value\n" or die "write $file: $!";
+		close($out) or die "close $file: $!";
+	}
+
+	sub write_all {
+		my ($out, $data) = @_;
+		my $offset = 0;
+		while ($offset < length($data)) {
+			my $written = syswrite($out, $data,
+				length($data) - $offset, $offset);
+			defined($written) && $written or die "write response: $!";
+			$offset += $written;
+		}
+	}
+
+	sub start_response {
+		my $out = $server->accept() or die "accept: $!";
+		<$out> or die "read request: $!";
+		my $start = 0;
+		while (<$out>) {
+			last if /^\r?\n$/;
+			$start = $1 if /^Range: bytes=(\d+)-/i;
+		}
+		$start < length($pack) or die "invalid range $start";
+		my $length = length($pack) - $start;
+		my $middle = int($length / 2);
+		my $status = $start ? "206 Partial Content" : "200 OK";
+		my $headers = "HTTP/1.1 $status\r\n" .
+			"Content-Length: $length\r\n" .
+			($start ? "Content-Range: bytes $start-" .
+				(length($pack) - 1) . "/" . length($pack) . "\r\n" : "") .
+			"Connection: close\r\n\r\n";
+		write_all($out, $headers);
+		write_all($out, substr($pack, $start, $middle));
+		return ($out, $start + $middle);
+	}
+
+	signal_ready($server_ready, $server->sockport());
+	my ($first, $first_pos) = start_response();
+	signal_ready($first_ready, "ready");
+	my ($second, $second_pos) = start_response();
+	write_all($first, substr($pack, $first_pos));
+	write_all($second, substr($pack, $second_pos));
+	close($first) or die "close first response: $!";
+	close($second) or die "close second response: $!";
+	EOF
+	{
+		(
+			if ! "$TRASH_DIRECTORY/slow-pack-server" "$pack" \
+				"$TRASH_DIRECTORY/server-ready" \
+				"$TRASH_DIRECTORY/first-ready"
+			then
+				echo failed >"$TRASH_DIRECTORY/server-ready" &&
+				echo failed >"$TRASH_DIRECTORY/first-ready" &&
+				exit 1
+			fi
+		) >server.log 2>&1 &
+		server_pid=$!
+	} &&
+	test_when_finished "
+		kill $server_pid 2>/dev/null || :
+		wait $server_pid 2>/dev/null || :
+		exec 7>&-
+		exec 8>&-
+		rm -f server-ready first-ready slow-pack-server
+	" &&
+	read port <&7 &&
+	url="http://127.0.0.1:$port/pack" &&
+	{
+		(
+			if ! GIT_TRACE_CURL="$TRASH_DIRECTORY/overlap-first.trace" \
+			GIT_TRACE_CURL_NO_DATA=1 \
+			git -C packfileclient-overlap http-fetch --packfile="$packhash" \
+				--index-pack-arg=index-pack \
+				--index-pack-arg=--stdin --index-pack-arg=--keep \
+				"$url" >first.out
+			then
+				echo failed >"$TRASH_DIRECTORY/first-ready" &&
+				exit 1
+			fi
+		) &
+		first_pid=$!
+	} &&
+	test_when_finished "
+		kill $first_pid 2>/dev/null || :
+		wait $first_pid 2>/dev/null || :
+	" &&
+	read ready <&8 &&
+	test "$ready" = ready &&
+	test_path_is_file "$tmpfile" &&
+	test -s "$tmpfile" &&
+	{
+		GIT_TRACE_CURL="$TRASH_DIRECTORY/overlap-second.trace" \
+		GIT_TRACE_CURL_NO_DATA=1 \
+		git -C packfileclient-overlap http-fetch --packfile="$packhash" \
+			--index-pack-arg=index-pack \
+			--index-pack-arg=--stdin --index-pack-arg=--keep \
+			"$url" >second.out &
+		second_pid=$!
+	} &&
+	test_when_finished "
+		kill $second_pid 2>/dev/null || :
+		wait $second_pid 2>/dev/null || :
+	" &&
+	wait "$server_pid" &&
+	wait "$first_pid" &&
+	wait "$second_pid" &&
+	test_grep "HTTP/[0-9.]* 200" overlap-first.trace &&
+	test_grep "Range: bytes=[1-9][0-9]*-" overlap-second.trace &&
+	test_grep "HTTP/[0-9.]* 206" overlap-second.trace &&
+	printf "keep\t%s\npack\t%s\n" "$packhash" "$packhash" | sort >expect &&
+	sort first.out second.out >actual &&
+	test_cmp expect actual &&
+	test_path_is_missing "$tmpfile" &&
+	git -C packfileclient-overlap cat-file -e "$blob"
+'
+
 test_expect_success 'fetch notices corrupt pack' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
-- 
2.55.0.openai.131.g83a728de1eb6

