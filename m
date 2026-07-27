Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3B1DDC2B
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112149; cv=none; b=VacdKvSoO+RvoRP905Q/07lE4yZxxPmpPpBL2zLfnkQ65XJ7wS5EpSmod+nf2j4UTqWxhfaufcppqxVMB0QQLkIcn+YVsw+VTL1aG5Hmvo3nrHg43r82egzJeI2D5Q82BI/rU/t0et9lfaT42HwOlBGSZqgv5DPvIHGnihwMh6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112149; c=relaxed/simple;
	bh=uPLUkRR4F7rfFwO5rlf2laiosgmc1OjAOwC1xB5FV6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYJ0W/0wwWzKaAkbiRaqADhBt0UPnsx6WnWrXUp5pO8sTfCP/dyNuXlUTG8EVnqkM7PuLyxa+p1nDBPJ8NDENuJhTYlUN8Fd9G7Kuz+9M9AemdFypI9mMGMHLEI4JOOeP8HmbI9EdrfWzB0elSdPnFcw4jutQYVTPixeWvgwyrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=GImiO99F; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="GImiO99F"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-385b78b4f9bso101147a91.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785112148; x=1785716948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AKoHrBvqBm8Q6kA4DfgplJk48FMzOxC6myyO3R2kiC4=;
        b=GImiO99FQrquerBkym8sF4Z+KhnifwigJgN3lRBfL56RMwy7hVHmF/qDKJgQDTdmiH
         WDu9ko8jJ31WtoESPlXXagD8HCZlAwuvTZmHpUHycO84rkjLtSJSyUgaUO+EtGVD3gWT
         S4oigTl+F2fecfeV5eopumb7u9ePxVGc5I9zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785112148; x=1785716948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AKoHrBvqBm8Q6kA4DfgplJk48FMzOxC6myyO3R2kiC4=;
        b=jyBhpnHH1NjocB8aXzksFETS1nstYR63pgXLq8z0+EBujkqMsqT0hfB71xeobUYaUq
         kU+ze7q/dC1kOgD2o9iWQBb8nG+x8/ui0Anmuj0wVD3AaZ/3sFiSma9NeJPHB73z5cx8
         hWlAo6JOvumLg55Fizc8SbbutkZMUsswbWFqtoG6TgvtT1x4vsKg4qirc82nLwfChmMp
         jmrmQETu4xODfYxQFu8BVE3x9Yn2RdCCwI0HINMzeOdMO2wF0nBziJwrW8v1PEFgMQZQ
         G3S9ok0tx5h3SxOnL27xz+hXqOR+5YUouV5fReYzDxVPQ1ZYLaga9ac5A7KyK+Cy3Upg
         /IQg==
X-Gm-Message-State: AOJu0YzSlXYy00M3c/d8/c05ZNzS2N7HLpKJGHHInuA67mlRxpUvIdNm
	tvFIqxO5EEqkxuqVbfyYAWiqVPDwxew7uZe1eZVBSGDZBeG9W+UGqAf5sjlRsJgusmr94BtW1Hg
	Q0TqF
X-Gm-Gg: AR+sD11IQGHoKcGj9daQdkCg5SaBKxaq1CPbVQzxTk1IFVQVNR4zv7CliMEHYQ17Tp1
	ZV/HgFpQuc+i8rKr5ZkQlspwc2verqErcMSfCn4KKfRcIdYbLNik/TGBmde3DNswej7dCiU/iaL
	eIgvzQPCAb6AQUwPB0/DpUc2C77W4t2LgUchnoBtWUf+8I8hdA7aX4oMl54G/lXBBEfMo+Hk0yH
	rRxKdZgW5pkALPR+gvN4fFfYDYGZ/aRe78VHxD8yqz74rNgaCdjmHIkc7R1XyWaDvriKfyepMDD
	GP/s2Ima4iyxqhNEeEERCz6CwZop96N8ZxuqfrNI2X6RVMZ19SybiHoB6xdvHYcroL80xkdiceN
	S+wc6C04VHVesf1JQ2p80WriYb2AHuv/IbvxTIxlwnG+u+ZEiNTjM7SHcB42pkTzxbh+dtc2BPw
	6bUfcz21/e2DfJK0+3ddGhtuSYWNpYAlXj74wTeg3YIP5ulw2/jZsi6ZmlHG+EjjlpcwIUgjK36
	MN6zsM=
X-Received: by 2002:a17:90b:2f8c:b0:38e:c140:2a0b with SMTP id 98e67ed59e1d1-38f29604998mr4437413a91.3.1785112147537;
        Sun, 26 Jul 2026 17:29:07 -0700 (PDT)
Received: from com-76773.corp.openai.org ([20.102.114.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm19920328c88.8.2026.07.26.17.29.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 17:29:07 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v6 4/6] http: avoid concurrent appends to partial packs
Date: Sun, 26 Jul 2026 17:28:41 -0700
Message-ID: <7a83eb7091473d12839f357212a224fd53b09cda.1785111375.git.tnyman@openai.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785111375.git.tnyman@openai.com>
References: <cover.1785047139.git.tnyman@openai.com> <cover.1785111375.git.tnyman@openai.com>
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

Duplicate the staging descriptor for index-pack instead of reopening the
path after closing the stream. Another downloader may unlink the staging
path before indexing begins, but index-pack can still read the retained
descriptor.

Exercise resumed transfers and overlapping 200 and 206 responses, and
clarify the staging-key documentation.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 Documentation/git-http-fetch.adoc |   5 +-
 http.c                            |  34 ++++---
 t/t5550-http-fetch-dumb.sh        | 164 ++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+), 16 deletions(-)

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
diff --git a/http.c b/http.c
index 89a1ccc6d2..ad07ef3549 100644
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
@@ -2733,22 +2736,30 @@ struct http_pack_request *new_http_pack_request(
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
+	fd = open(preq->tmpfile.buf, O_RDWR | O_CREAT, 0666);
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
@@ -2757,12 +2768,7 @@ struct http_pack_request *new_direct_http_pack_request(
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
index 698bbb3160..86b9d87ef5 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -312,6 +312,170 @@ test_expect_success 'http-fetch --packfile accepts an already complete partial'
 	git -C packfileclient-complete cat-file -e "$HASH"
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

