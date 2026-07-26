Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8F370D61
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785048295; cv=none; b=VI2GKRg9XAuX48aQgpxGB7UrTbz//MUbj4y9gDlP/lQ8MtyTHKkScKg/7o2NdrScTNQghO0Z3Gv3dSBtcIVixEvpLiYecM5HCtop+/CVA+zhK4zQznSwZbF8YjQaEwDgNI1pr3dIsVuhEo3eZ0Q48l1HVeOn2Ig4rWL9K2QB7aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785048295; c=relaxed/simple;
	bh=JcNN6IKZ13vBLO41rF6tuxaxA85+8PIC4hk/6BG4cZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVpQdDwm1YcchKPxmZrYxabntKUrOiY17l4S1LNdGWkmL588gGTSAkcWFJZNkpRfWI/1oKl0aVBVk6GMu2pKa4VZKNZjLneInogkpuR39s1ob9p9AOoSiFrlIzWAr5QpvB+QejbZmicOZbHC2eG2c+hMCHwPXluFypYea5CsdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=GF5IHIQw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="GF5IHIQw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cad85b7b5aso2604685ad.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2026 23:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785048293; x=1785653093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3UaMhYmHliGoIxLAZAsCSTAs8CMSzlPV2FpnkG688MY=;
        b=GF5IHIQw8CgcbIYwFpZZ+36FgDx5Mbc/lfltWAoPjAmD/xd2sywCxmoZs+6gCTa020
         EGPUWIbuJ2R7hGfG7qUWrKZUCRKgqFJSaaDiyCvQUBcRpa27x/jLezvNmPMVZB9nN3oA
         x0MEgHB5YINWFrXjRBjwD3EYpdI3dzrItzwqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785048293; x=1785653093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3UaMhYmHliGoIxLAZAsCSTAs8CMSzlPV2FpnkG688MY=;
        b=LQ62DG8+DIExqHb2nyCBFmSiMu3rZ/YOyioSpkfsf+Q5f7C1+IKqdCQR5OZjxep7Lr
         hy4/2yDyV2PS69/C7W+wVFpH90Mys0jL76QTzp082d2fWuWqmb0bV3B3ZLbi1fKol1BL
         vZO2z2Xk4MxNPYlt+MxXORGDI4Q0u59PA6zWiPdxAfJKrXfCvmNblDZlZJvS9CVohutF
         4fHjCjBLPEP5QelyY1Gq7HaOR1vWRGY5NlkOLO0b77txDSBTF0ugB3VUdZDj8kzXH0Xk
         3+98iIK4h25EVUuzeiEdB4rrVszkjHk0gs34J1cLZ/X0lqUK/PVljmOnmfXnRj4d8lWQ
         AUYQ==
X-Gm-Message-State: AOJu0YzaBIkKpDFpAKf8SCWj++2jaJ5DUuTaxzvVNDZt1qXeSEup2JYT
	H0RdISLARlczhdXcXylKZfRyTl3cCKLa51aRA7OeWZo5H+IRZ8KIJftK91Ky6z31OnIQFbw87CP
	YXSqa7Ow=
X-Gm-Gg: AR+sD12hyaWChnTQE1g5+RyK0SrtJqp1HMJXyZ2prBrL4NAwoh9JxLoLQNBo3beXXsq
	3SbAQhI4+UXpYbncieFofIhaeR//k3zYRXE4mwO/v8i2JphhWpgqlwSU2qqGpk3PVoapPjF5Pl/
	QnEouvwyRD+6C5a3R9l5iondsWQuGgk2C1Dsqt00guKsB5LHZ782YWKVt9hvQ8wTqMM7rPbQ8HZ
	0obWMijKsrW6DF43q2tI5QS9KzFaDsNecUwPVt5C46awQjqxqnKs0b0ONFpqIAtBggNuJEgLvKj
	VwJr2x7aOOxZ/QGu0ODLzd4jBl4T7a8a0p5TSsHArIkp/SfplqU8yotNfeszasoCvotpIv04VEn
	UJhqIcGe3v/1EXmjwhQi/EzDKBs2pu1zGSz5glIZctJhEHxsUNOZlspD2CVzu19qi1BVlIrd3Wc
	g+ZYKcTwYs50SdiHlXGcZVS8kLEeXe1p/HBDUH60OWKFIj6NulZmg8NgwphrbF2A2rjnvIg8yWl
	A52P+OZfSB3SO4=
X-Received: by 2002:a17:903:390c:b0:2c9:fbde:ab68 with SMTP id d9443c01a7336-2cfde844f2bmr56628935ad.3.1785048292648;
        Sat, 25 Jul 2026 23:44:52 -0700 (PDT)
Received: from com-76773.corp.openai.org ([2601:646:300:69b0:f912:1358:fd39:7404])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm18622982eec.18.2026.07.25.23.44.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 25 Jul 2026 23:44:52 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v5 2/3] http: avoid concurrent appends to partial packs
Date: Sat, 25 Jul 2026 23:44:47 -0700
Message-ID: <d9667c93b03d1a71df55a33f90538b31afd08677.1785047139.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785047139.git.tnyman@openai.com>
References: <cover.1784874850.git.tnyman@openai.com> <cover.1785047139.git.tnyman@openai.com>
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
 t/t5550-http-fetch-dumb.sh        | 246 ++++++++++++++++++++++++++++++
 6 files changed, 291 insertions(+), 25 deletions(-)

diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
index 12036e65e9..45e0d3d07c 100644
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
index f00eeae48f..07aa218049 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -293,6 +293,252 @@ test_expect_success 'http-fetch --packfile' '
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
+	test_grep "416 Requested Range Not Satisfiable" second.trace &&
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
+	my $completed = 0;
+	END {
+		if (!$completed) {
+			signal_ready($server_ready, "failed");
+			signal_ready($first_ready, "failed");
+		}
+	}
+
+	$SIG{ALRM} = sub { die "timed out serving concurrent pack requests\n" };
+	alarm 60;
+
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
+	$completed = 1;
+	alarm 0;
+	EOF
+	{
+		"$TRASH_DIRECTORY/slow-pack-server" "$pack" \
+			"$TRASH_DIRECTORY/server-ready" \
+			"$TRASH_DIRECTORY/first-ready" >server.log 2>&1 &
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
+	wait "$second_pid" &&
+	wait "$first_pid" &&
+	wait "$server_pid" &&
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

