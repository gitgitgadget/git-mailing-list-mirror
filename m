Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB6392C20
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 22:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783982081; cv=none; b=iSKu9+qVB/QnItCrCtCkQ8QJYzMSgf+UPePha11WSIMMUcRg8o/ImofJXXM1lcVSJOdT8zVsGQMEyAD23q1IsKAmKaqIIjoQfWKl1vCleKr0L3e35PWOK06GOS9jNMH5vZg7AJwWX35tLUwm9g+we1l5ovupinO30VX/pGT3YJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783982081; c=relaxed/simple;
	bh=xV3dRFGPSm9aSTH28B2dvrBq61Gz94qiBMgaqXTLwBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l53yI/lpE4wMmD70aiDZhGhyAX6kQ6OxxdSYxej7kUO5dZdBUH41bpqWsy4MFbNjWcfpAoB8HEjVMwuM9+VIBbaILynJR8A9aT0JO/RXR5Qg6/jybx7FNu4k+4LI95fTTdssgZtyZ0I3YFjIvQBUUO5Mk7dGfHpLuZaFbfkjox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=TGivM+8R; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="TGivM+8R"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-9042167ca52so2204446d6.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 15:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1783982078; x=1784586878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H8vjUsHS73N5iyipcQZ4hOoDsamZWIr3EeQwtIyN6hw=;
        b=TGivM+8RS7s8/86NuVlo+5cu3jrUry9IfuDh4+3s1jRTHB3ihm0x0PG2+pKkip4QKP
         31AVkYAm0mbksom/Ij5kXabJCFcKonRGHz+sqA63cyhvJnAFL/Nd3p6Qw0g59rkBAc2t
         0zLc6X4mpa0rXmMC/AEaoWYukDCKOxpcGo+d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783982078; x=1784586878;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H8vjUsHS73N5iyipcQZ4hOoDsamZWIr3EeQwtIyN6hw=;
        b=biwrAQ0CQGF4LhJUX/64VcPcdnc28YecMgcZPBqhQl3sKXmHURkk2jRXNTUAmCIIVI
         axlnGVoYHrpYSg+HHPv6q54qsJZIee7LGHrird/m40hJoaC5skfAh0YxbXYso98C8woy
         i2iM31gwMUa2v8Z+gp+MA2kVQQg2BcEsvbWhladTNYfGh5vB2d9EAt+OoSt2gDTk+oBy
         1N9u5wZcdDVU5S4fD1WA3Oy8fp3lHisXrnY5oQfyi/NnVzfr2VyKuvenW8LdrK6dXrgG
         SjCWP/G7AD2QGtpTmatuta1OsoxGnQ4caybcfjK6mJiSt+bovIfFfH1FWBWD7u67g0uC
         92xA==
X-Gm-Message-State: AOJu0YyNCiBNF36dOytDUKnDU4upyAOsHUcoCelLv2VHmT5K9ziP3si3
	o1+HwWG9jbchObhqATRHQ6NNkQFCE9eeJjRP3iBPVsPcvs0X8p/VDqGJteDAZ+8cROtXY5k8sgq
	DgA5/7L4=
X-Gm-Gg: AfdE7cnewEaKsaDSLaoy5SN5Njyrz9E9vfzYrxLKWwWy/lLSQly1VHwEFmUoq9h4tU7
	wCCyK0vcGTGX0kP1Ewn92/hvVb66AyXkNHLX7AMwFdgFNZH4y9jIws3dHS9GUwCUD1msPhwx9NL
	rApmFSYSlTpiPu7pTYJ4WfTd22/cruCk2aXwEjTk8W56FezcuJ/a40tky7Q3igsufXSRe9vgqjr
	4ZsTg71gnDbkAYjOb+xJfu/jQGLmRDxXssz+Z25WRtmHC+B45ZjGGpX+hIuLwVcHD69HEG2dHJj
	b6QAExpYCdUZxKqB2/GBSnL26oVsqaCrBqq8jehGcKtLVKHnptW9N8ht+xpEjUvf83R2rzITZEv
	mzz/kFyoVdQpnBEjeQsBHw792xaMCPyi+btjPvg/D8RUVkZ9MHTilgTHw1wtts9ufWtKX58or+s
	oSgyACFLzjvbVukOclIUVjyDamDcsmqbOCgrRPsfSAGTIBCIRfzn+SSIUHuF576Cy3f61J
X-Received: by 2002:a05:6214:238c:b0:8fe:6078:d35d with SMTP id 6a1803df08f44-90400e81e55mr98304766d6.2.1783982078092;
        Mon, 13 Jul 2026 15:34:38 -0700 (PDT)
Received: from com-76773 ([209.249.37.148])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd248e666sm143684896d6.0.2026.07.13.15.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:34:37 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:34:33 -0700
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 1/2] http: use unique tempfiles for packfile URI downloads
Message-ID: <alVn-QmK3K91_tkH@com-76773>
References: <cover.1783982021.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783982021.git.tnyman@openai.com>

Since 8d5d2a34df (http-fetch: support fetching packfiles by URL,
2020-06-10), packfile URI downloads have been staged at
objects/pack/pack-<hash>.pack.temp.

The path is derived from the advertised pack hash. Two processes
fetching the same pack into a shared object database therefore open the
same file for append. Their writes can corrupt the temporary pack. If
one process arrives after the other has completed the download, it may
instead try to resume at EOF, which some HTTP servers reject with 416.

Use the tempfile API to give direct packfile URI downloads unique
temporary files. Keep the deterministic path for ordinary dumb HTTP
pack requests, which use it to resume a partial download left by an
earlier invocation.

This means that a packfile URI download cannot be resumed by a later
invocation. A retry starts with an empty temporary file instead.

Add a test which pauses one process after downloading the pack and
starts another process using the same object database.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 Documentation/git-http-fetch.adoc |  5 +-
 http.c                            | 77 +++++++++++++++++++++----------
 http.h                            |  1 +
 t/t5550-http-fetch-dumb.sh        | 72 ++++++++++++++++++++++++++++-
 4 files changed, 126 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-http-fetch.adoc b/Documentation/git-http-fetch.adoc
index 2200f073c4..533bf381c4 100644
--- a/Documentation/git-http-fetch.adoc
+++ b/Documentation/git-http-fetch.adoc
@@ -48,9 +48,8 @@ commit-id::
 	line (which is not expected in
 	this case), 'git http-fetch' fetches the packfile directly at the given
 	URL and uses index-pack to generate corresponding .idx and .keep files.
-	The hash is used to determine the name of the temporary file and is
-	arbitrary. The output of index-pack is printed to stdout. Requires
-	--index-pack-args.
+	The hash is arbitrary. The output of index-pack is printed to stdout.
+	Requires --index-pack-args.
 
 --index-pack-args=<args>::
 	For internal use only. The command to run on the contents of the
diff --git a/http.c b/http.c
index b4e7b8d00b..5a46e7c65c 100644
--- a/http.c
+++ b/http.c
@@ -2668,7 +2668,10 @@ int http_get_info_packs(const char *base_url, struct packfile_list *packs)
 
 void release_http_pack_request(struct http_pack_request *preq)
 {
-	if (preq->packfile) {
+	if (preq->tempfile) {
+		delete_tempfile(&preq->tempfile);
+		preq->packfile = NULL;
+	} else if (preq->packfile) {
 		fclose(preq->packfile);
 		preq->packfile = NULL;
 	}
@@ -2688,7 +2691,10 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	int tmpfile_fd;
 	int ret = 0;
 
-	fclose(preq->packfile);
+	if (preq->tempfile)
+		close_tempfile_gently(preq->tempfile);
+	else
+		fclose(preq->packfile);
 	preq->packfile = NULL;
 
 	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
@@ -2711,7 +2717,10 @@ int finish_http_pack_request(struct http_pack_request *preq)
 
 cleanup:
 	close(tmpfile_fd);
-	unlink(preq->tmpfile.buf);
+	if (preq->tempfile)
+		delete_tempfile(&preq->tempfile);
+	else
+		unlink(preq->tmpfile.buf);
 	return ret;
 }
 
@@ -2723,20 +2732,8 @@ void http_install_packfile(struct packed_git *p,
 	packfile_store_add_pack(files->packed, p);
 }
 
-struct http_pack_request *new_http_pack_request(
-	const unsigned char *packed_git_hash, const char *base_url) {
-
-	struct strbuf buf = STRBUF_INIT;
-
-	end_url_with_slash(&buf, base_url);
-	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
-		hash_to_hex(packed_git_hash));
-	return new_direct_http_pack_request(packed_git_hash,
-					    strbuf_detach(&buf, NULL));
-}
-
-struct http_pack_request *new_direct_http_pack_request(
-	const unsigned char *packed_git_hash, char *url)
+static struct http_pack_request *new_http_pack_request_for_url(
+	const unsigned char *packed_git_hash, char *url, int resumable)
 {
 	off_t prev_posn = 0;
 	struct http_pack_request *preq;
@@ -2746,9 +2743,22 @@ struct http_pack_request *new_direct_http_pack_request(
 
 	preq->url = url;
 
-	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
-	strbuf_addstr(&preq->tmpfile, ".temp");
-	preq->packfile = fopen(preq->tmpfile.buf, "a");
+	if (resumable) {
+		odb_pack_name(the_repository, &preq->tmpfile,
+			      packed_git_hash, "pack");
+		strbuf_addstr(&preq->tmpfile, ".temp");
+		preq->packfile = fopen(preq->tmpfile.buf, "a");
+	} else {
+		strbuf_addf(&preq->tmpfile, "%s/pack/tmp_pack_XXXXXX",
+			    repo_get_object_directory(the_repository));
+		preq->tempfile = mks_tempfile_m(preq->tmpfile.buf, 0444);
+		if (preq->tempfile) {
+			strbuf_reset(&preq->tmpfile);
+			strbuf_addstr(&preq->tmpfile,
+				      get_tempfile_path(preq->tempfile));
+			preq->packfile = fdopen_tempfile(preq->tempfile, "w");
+		}
+	}
 	if (!preq->packfile) {
 		error("Unable to open local file %s for pack",
 		      preq->tmpfile.buf);
@@ -2766,8 +2776,9 @@ struct http_pack_request *new_direct_http_pack_request(
 	 * If there is data present from a previous transfer attempt,
 	 * resume where it left off
 	 */
-	prev_posn = ftello(preq->packfile);
-	if (prev_posn>0) {
+	if (resumable)
+		prev_posn = ftello(preq->packfile);
+	if (prev_posn > 0) {
 		if (http_is_verbose)
 			fprintf(stderr,
 				"Resuming fetch of pack %s at byte %"PRIuMAX"\n",
@@ -2779,12 +2790,28 @@ struct http_pack_request *new_direct_http_pack_request(
 	return preq;
 
 abort:
-	strbuf_release(&preq->tmpfile);
-	free(preq->url);
-	free(preq);
+	release_http_pack_request(preq);
 	return NULL;
 }
 
+struct http_pack_request *new_http_pack_request(
+	const unsigned char *packed_git_hash, const char *base_url)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	end_url_with_slash(&buf, base_url);
+	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
+		hash_to_hex(packed_git_hash));
+	return new_http_pack_request_for_url(packed_git_hash,
+					     strbuf_detach(&buf, NULL), 1);
+}
+
+struct http_pack_request *new_direct_http_pack_request(
+	const unsigned char *packed_git_hash, char *url)
+{
+	return new_http_pack_request_for_url(packed_git_hash, url, 0);
+}
+
 /* Helpers for fetching objects (loose) */
 static size_t fwrite_sha1_file(char *ptr, size_t eltsize, size_t nmemb,
 			       void *data)
diff --git a/http.h b/http.h
index 729c51904d..2c900779f5 100644
--- a/http.h
+++ b/http.h
@@ -224,6 +224,7 @@ struct http_pack_request {
 
 	FILE *packfile;
 	struct strbuf tmpfile;
+	struct tempfile *tempfile;
 	struct active_request_slot *slot;
 	struct curl_slist *headers;
 };
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index b0080bf204..314a74c433 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -293,6 +293,74 @@ test_expect_success 'http-fetch --packfile' '
 	git -C packfileclient cat-file -e "$HASH"
 '
 
+test_expect_success PIPE 'concurrent http-fetch --packfile' '
+	git init packfileclient-concurrent &&
+	HASH=$(git -C "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git rev-parse HEAD) &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+		ls objects/pack/pack-*.pack) &&
+	packhash=$(basename "$p" .pack) &&
+	packhash=${packhash#pack-} &&
+
+	mkfifo first-ready first-continue &&
+	exec 8<>first-ready &&
+	exec 9<>first-continue &&
+	write_script git-wait-index-pack <<-\EOF &&
+	echo ready >"$GIT_TEST_WAIT_READY" &&
+	read continue <"$GIT_TEST_WAIT_CONTINUE" &&
+	exec git index-pack "$@"
+	EOF
+
+	# Hold the first download before it is indexed, so that the second
+	# download installs the pack first.
+	{
+		(
+			if ! PATH="$TRASH_DIRECTORY:$PATH" \
+			GIT_TEST_WAIT_READY="$TRASH_DIRECTORY/first-ready" \
+			GIT_TEST_WAIT_CONTINUE="$TRASH_DIRECTORY/first-continue" \
+			git -C packfileclient-concurrent http-fetch \
+				--packfile="$packhash" \
+				--index-pack-arg=wait-index-pack \
+				--index-pack-arg=--stdin \
+				--index-pack-arg=--keep \
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
+		wait $first_pid 2>/dev/null || :
+		exec 8>&-
+		exec 9>&-
+		rm -f first-ready first-continue git-wait-index-pack
+	" &&
+
+	read ready <&8 &&
+	test "$ready" = ready &&
+	git -C packfileclient-concurrent http-fetch \
+		--packfile="$packhash" \
+		--index-pack-arg=index-pack \
+		--index-pack-arg=--stdin \
+		--index-pack-arg=--keep \
+		"$HTTPD_URL/dumb/repo_pack.git/$p" >second.out &&
+	echo continue >&9 &&
+	wait "$first_pid" &&
+
+	printf "pack\t%s\n" "$packhash" >expect &&
+	test_cmp expect first.out &&
+	printf "keep\t%s\n" "$packhash" >expect &&
+	test_cmp expect second.out &&
+	test_path_is_missing \
+		"packfileclient-concurrent/.git/objects/pack/pack-$packhash.pack.temp" &&
+	find packfileclient-concurrent/.git/objects/pack \
+		-name "tmp_pack_*" -print >tmpfiles &&
+	test_must_be_empty tmpfiles &&
+	git -C packfileclient-concurrent cat-file -e "$HASH"
+'
+
 test_expect_success 'fetch notices corrupt pack' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
@@ -313,7 +381,9 @@ test_expect_success 'http-fetch --packfile with corrupt pack' '
 	git init packfileclient &&
 	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git && ls objects/pack/pack-*.pack) &&
 	test_must_fail git -C packfileclient http-fetch --packfile \
-		"$HTTPD_URL"/dumb/repo_bad1.git/$p
+		"$HTTPD_URL"/dumb/repo_bad1.git/$p &&
+	find packfileclient/.git/objects/pack -name "tmp_pack_*" -print >tmpfiles &&
+	test_must_be_empty tmpfiles
 '
 
 test_expect_success 'fetch notices corrupt idx' '
-- 
2.55.0

