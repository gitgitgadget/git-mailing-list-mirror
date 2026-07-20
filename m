Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728E3D4108
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 22:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784586848; cv=none; b=Za6a5IEl8924Bhq1KiQ9aIW0DqSRrIhKYo3a0sxFzwCXnlEkzo6ou/GazWcSJ6vjRq18+RgzwUeRC5RicoPlD3/vi2zY3BENA57GoihvidWbJYH5uh4o1qQ+eoe9Qn58GG3oOzEW8mySSfa1+0Qn+t09C3LamElGRkezzzdY0Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784586848; c=relaxed/simple;
	bh=+BcYc4iOz3ijAoKM5Tu1f/fK+TObqIVThAQG8F83A2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2BM0sDDBs9jsDfn9oIu4DEzJC5DVMKi3cSnQ2hoA2LA+/8E5a0nFMeBfhEhR8iuKgZ543JE6oMac5ajinasqXYZjUC9frruc/L+5Ue1iSuDVkZFkDiJx5MW0NvDDzIPIOnaeAr+lzhsOCFOxzu3SEx9z9qzb8ykk7fnWHqOByc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ZNnydgdX; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ZNnydgdX"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e4eca3a50so107803785a.0
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784586843; x=1785191643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NmzGauSDmBHhRi8UYKsr1Ya8bZSKiUNH8HJBfL6tBx4=;
        b=ZNnydgdX/ICXV8wDAXZz+N0VXsApWR+0PuBE6PBMTUfRC5mZhSgTCEbh9byWzNg1QP
         WisVjXWhnpmQJB59ZVhDIa9TdVnT0mcmuCV8GooceegtclXUe5OPNmha1nQrBLmzNRxE
         zS2DBH41wOBx9l/DMjQtdvgLSgFNE9cz7r3RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784586843; x=1785191643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NmzGauSDmBHhRi8UYKsr1Ya8bZSKiUNH8HJBfL6tBx4=;
        b=ciEBg00bZX6l2XO95wByawS4UHDTbcOhW5XHnVWSXL479gxJF2lfFjUi9u0oJ5bLOE
         tSHaNhj4xuA5aAkAHZ8gS9b4VXgYBGW6CXEy96AucPejJkIZ43L1q4kgFktO+4e9NgVV
         evdZhSBHeCO9+0ZikA9yiW62ChiED1BEmDEMDE/GDb+2UKP+usA2ed5gEUfeiMkPBM+S
         r4WJf5pjvNXgnz7+thKxvKl8yPc0+aGDJ0PB0qQVH+b3pDM7L47RHEU2avPFK1E+D8fR
         UZAVj35j0u+G/WafvDf2mXusHVFVBTYUJg9Cx+a4Z+AM9ferQ5158B93GhNOmoPF2T61
         406w==
X-Gm-Message-State: AOJu0Yw3oy/kE6bGCNlvSHVwRBfqtriSfflsHIsdokvnPcAzrk4p2pvs
	/Kv3yedCZdeUzBDsGgf7rV7W+zpxpad83NFfnrImKMLx9SDh628XDbBB7nJdmUik1eIETdSd1GR
	EfSWvXMc=
X-Gm-Gg: AfdE7cld5utHo8hC6JcpYZuz0J3JuiGIhFk2YRLStNZIi24PDaeI2/2f+v/ji1DOVIo
	WfwUjjschU+Koudo6Xz65L0oZA5q98YgX20qbYUs177MlGSKcGwwJkgLP16QvHzTRygMKRQ+Lp2
	tp2mBme31Cqkqcy2126SZYVQfxz1uyyUfgUxjAKNwMtBOunSA5DF8zN6TPkKlv65tybl0TH0GLl
	Om0JVrz9i0u6AxgwiOAyeYAF3k/THG8AGrhcM2n2bo/DmTN63RUsTqG/H+y1rCsBlFoNtBjc1wY
	l0u+ks2IviHfeKQIHr3HB8TKxzIiAaDZ14VslaXsLZBOmW+jN0MgfX9OjSZga+oaRLbMb18N81d
	GJBsTu9jNSfFQx2uuJ4xVSLJx+G4GRGWugW16TJeN2kx2EAo+7+XzRuwMD9kNU1zCMXB4vA3dEW
	1PcuaNW/CJr3WnFrykbm/2k6kYYJBiE06jd//NfjD4sJLpPZ/ZVJpru97+kz8Fgo/fEsKdBp0Z/
	1mCnNqEJQ07mo9s2g==
X-Received: by 2002:a05:620a:2947:b0:918:588c:d095 with SMTP id af79cd13be357-930e70ce07emr79959485a.8.1784586843316;
        Mon, 20 Jul 2026 15:34:03 -0700 (PDT)
Received: from com-76773.corp.openai.org ([209.249.37.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b542dd27sm972590185a.29.2026.07.20.15.34.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 15:34:02 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v2 1/2] http: avoid concurrent appends to partial packs
Date: Mon, 20 Jul 2026 15:33:59 -0700
Message-ID: <160a9b9fd0982dadfbf6f8fbb378d1a3e9173698.1784582665.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0.125.g9b41d4ddb3
In-Reply-To: <cover.1784582665.git.tnyman@openai.com>
References: <cover.1783982021.git.tnyman@openai.com> <cover.1784582665.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pack requests stage downloads in a predictable partial-pack file so an
interrupted transfer can be resumed. Both packfile URI and ordinary dumb
HTTP requests use this staging path. Opening it in append mode lets
concurrent fetches interleave their writes, corrupting the pack or
causing a later fetch to request a range at EOF.

Open the partial pack read-write, seek to its current end, and retain a
per-descriptor offset for incoming data. Reopen newly created partial
packs without O_CREAT so Windows permits concurrent unlink, and keep the
descriptor for index-pack when another downloader removes the staging
path. Accept HTTP 416 when a partial pack is already complete.

Exercise resumed transfers, EOF ranges, and overlapping 200 and 206
responses. Clarify the staging-key documentation and correct the stale
--index-pack-args spelling in the documentation and error messages; the
repeatable --index-pack-arg option is already accepted.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 Documentation/git-http-fetch.adoc |  13 +-
 http-fetch.c                      |   7 +-
 http-push.c                       |   3 +-
 http-walker.c                     |   3 +-
 http.c                            |  53 ++++---
 t/t5550-http-fetch-dumb.sh        | 223 ++++++++++++++++++++++++++++++
 6 files changed, 271 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
index 2200f073c4..60ca91cf3a 100644
--- a/Documentation/git-http-fetch.adoc
+++ b/Documentation/git-http-fetch.adoc
@@ -48,13 +48,14 @@ commit-id::
 	line (which is not expected in
 	this case), 'git http-fetch' fetches the packfile directly at the given
 	URL and uses index-pack to generate corresponding .idx and .keep files.
-	The hash is used to determine the name of the temporary file and is
-	arbitrary. The output of index-pack is printed to stdout. Requires
-	--index-pack-args.
+	The hash is used to determine the name of the temporary file. It need
+	not be the pack hash, but it must uniquely identify the pack contents
+	for resumption. The output of index-pack is printed to stdout. Requires
+	one or more --index-pack-arg options.
 
---index-pack-args=<args>::
-	For internal use only. The command to run on the contents of the
-	downloaded pack. Arguments are URL-encoded separated by spaces.
+--index-pack-arg=<arg>::
+	For internal use only. An argument to the command run on the contents
+	of the downloaded pack. This option can be specified multiple times.
 
 --recover::
 	Verify that everything reachable from target is fetched.  Used after
diff --git a/http-fetch.c b/http-fetch.c
index f9b6ecb061..05f68f306a 100644
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
@@ -155,7 +156,7 @@ int cmd_main(int argc, const char **argv)
 
 	if (packfile) {
 		if (!index_pack_args.nr)
-			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-args");
+			die(_("the option '%s' requires '%s'"), "--packfile", "--index-pack-arg");
 
 		fetch_single_packfile(&packfile_hash, argv[arg],
 				      index_pack_args.v);
@@ -164,7 +165,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (index_pack_args.nr)
-		die(_("the option '%s' requires '%s'"), "--index-pack-args", "--packfile");
+		die(_("the option '%s' requires '%s'"), "--index-pack-arg", "--packfile");
 
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
diff --git a/http-push.c b/http-push.c
index 3c23cbba27..03dc8102a1 100644
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
index b4e7b8d00b..9b9f4efe28 100644
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
@@ -2738,22 +2736,42 @@ struct http_pack_request *new_http_pack_request(
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
+	/* Reopen without O_CREAT so MinGW permits another writer to unlink it. */
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
+		goto abort;
+	}
+	prev_posn = lseek(fd, 0, SEEK_END);
+	if (prev_posn < 0) {
+		error_errno("unable to seek local file %s for pack",
+			    preq->tmpfile.buf);
+		close(fd);
 		goto abort;
 	}
+	preq->packfile = xfdopen(fd, "w");
 
 	preq->slot = get_active_slot();
 	preq->headers = object_request_headers();
@@ -2762,12 +2780,7 @@ struct http_pack_request *new_direct_http_pack_request(
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
index b0080bf204..7acae96a96 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -293,6 +293,229 @@ test_expect_success 'http-fetch --packfile' '
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
2.55.0.125.g9b41d4ddb3

