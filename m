Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869D01F91D6
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112145; cv=none; b=Ls5nai7dS4CmUmw3esRNeBOERypCdUThmR9bGJ4wROFAom9kgEVDD3JXCrHwmLMdpzF9xIpMD2IHExjXYxb0mLcDLIVuraThyFOOQiJ0unCyRe+wjSyqy44PCsoHoWFWaY/VPgPUMwq5pgVeHEYjcqBEaHedcQibOlOygU4atTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112145; c=relaxed/simple;
	bh=HcuybJad3bhYW2tuZt9cZTX6aVP+MjyGkXIb0HXUQ5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/xAX7K2CueXcrRDfSKMkGb4dY71nuJkU35xCtl0mENmp+aSdMmEm1C48SflhcchzOBMdMGcZerLUG/3gv6IN85FYBRMRqNtekHfoixvVXtdGTfZ8R6MwkV8alBOvxFYskou4+zUeuLYVR+oI5xEhLPkmB6QG4nBgQhhJa3rWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=JnrSMsmd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="JnrSMsmd"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cfd2e4e83cso4426755ad.2
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 17:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785112144; x=1785716944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHgPQQFV5ZAOGXeFhDbqLZP2l3ufwZjHomi6T043wMg=;
        b=JnrSMsmdyTFutd6y0QYKJ2GzsLkbP9Y3tw6EZHd4eQkl/OiI0GWM43f1AeYHlVbCRG
         C/U+6a27us1ukmD7pWjp9V6CXfXUEQcWNwPX6vP9RjUGy68QJYsC4P12yARTS0wbILcT
         OmXxkvDkPq7g8zec+VX7nY7ZbTPLIw7JveHJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785112144; x=1785716944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHgPQQFV5ZAOGXeFhDbqLZP2l3ufwZjHomi6T043wMg=;
        b=Rvmzm7aSAGwWly9BTsqYTgm61Enfv7MQUSBOa0TkddbNwt/yhCGUhSVO6x1V4m9gC6
         9xy31ejjO+qQ/nI44ojx9HJjKGulcSYdIxF4jIPcUpDoILvB/G/k9iRMlc7IMyE5Vnv3
         gjCyVYaTNFciOg2hSJJ3yPvPqQCL21zh71BoP9fAEkbYk6bKlcpxSOXz3iZhVvoWLqs3
         UmIwmmcBQAk2CUVuuCmUIEYzr6sYVylQWk41ZlyAl6wXOoGtVmTyX7ceNgrgo4KNK95L
         F5Rr5yYBq6xcr73ffHWErr1f59RB22qui2hrDww4F6/AbRHyp5tW7cyD2++Aij2maPuK
         Gx8w==
X-Gm-Message-State: AOJu0Yz2LQhyvABX49eYm8va6lzmiMMJqoib+yxaNRBQ5HeLZoy3ahCg
	IRDZ71rPbUdg1hIIQKlf1fuLPDG7LOZhFTCO4nSWvf+YoBKcSBd+XXJDDUfa0eMP7LKS3H3sGTw
	G3bNB
X-Gm-Gg: AR+sD11kahHHadL0xRp4lWOgFBlUMd46/tgi657HJTsrRtmWY/S850TjHRlDVlOG7Gd
	3lV802IPsI9ST7ZxtsFc4NycGdIkm/+2DqfEb18LwcJYl56I51hJq/gCDOw/Ty5AVPSbPKcTTdl
	nhoHS3LGZhP9tTY6bmmwOqrOLmxLDPLs2YiPGFO/v7Hi66qPSggW4rCLmd2Fr0IS35ySXBtWwNu
	8Sge/hbeDm9flTZWCwCJsa411mUCxrfCpYKAtyw5DwM8dHzXJ/tUDNHCgs7XSOmMOQEyqtjj269
	/WTsm/Uz+/ctATh6+7iUQL4vWM0LZyp7ZWuN3zOhrqLLhJNLVXbqHOiPK474pudsDARK+7Kv49Z
	La/E7Q6KxGUq6jyS6LHwF+QHzCDlR4zZBGExydgQJKMoCsM8Gy44++OB+VoNpt0TutMrjufLR8Q
	I6kfTRKjcFxw/wOzcj7kli8mTvc/ZULPOfrvihHgb0BtYr7oGPa3PezB+VZuwkeBSmo495kOnqw
	HTXyHg=
X-Received: by 2002:a17:90b:3952:b0:36d:de94:f31 with SMTP id 98e67ed59e1d1-38f29784889mr4391211a91.7.1785112143910;
        Sun, 26 Jul 2026 17:29:03 -0700 (PDT)
Received: from com-76773.corp.openai.org ([20.102.114.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm19920328c88.8.2026.07.26.17.29.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 17:29:03 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v6 3/6] http: accept HTTP 416 for complete partial packs
Date: Sun, 26 Jul 2026 17:28:40 -0700
Message-ID: <677e5399eb8ce260f6aa98d91b5b2634ff95e46c.1785111375.git.tnyman@openai.com>
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

A resumed pack request may already have all bytes of the remote pack.
A server can respond to the resulting Range request with HTTP 416
instead of returning an empty response.

Accept that response in each pack-download caller and let index-pack
validate the completed staging file. This can happen without concurrent
downloads when a previous attempt completed the transfer but failed
before indexing it.

Add a regression test that seeds a complete partial pack and checks that
http-fetch indexes it after the server returns HTTP 416.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 http-fetch.c               |  3 ++-
 http-push.c                |  3 ++-
 http-walker.c              |  3 ++-
 t/t5550-http-fetch-dumb.sh | 19 +++++++++++++++++++
 4 files changed, 25 insertions(+), 3 deletions(-)

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
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index f00eeae48f..698bbb3160 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -293,6 +293,25 @@ test_expect_success 'http-fetch --packfile' '
 	git -C packfileclient cat-file -e "$HASH"
 '
 
+test_expect_success 'http-fetch --packfile accepts an already complete partial' '
+	git init packfileclient-complete &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+		ls objects/pack/pack-*.pack) &&
+	packhash=$(basename "$p" .pack) &&
+	packhash=${packhash#pack-} &&
+	tmpfile="packfileclient-complete/.git/objects/pack/pack-$packhash.pack.temp" &&
+	cp "$HTTPD_DOCUMENT_ROOT_PATH/repo_pack.git/$p" "$tmpfile" &&
+	chmod u+w "$tmpfile" &&
+	GIT_TRACE_CURL="$TRASH_DIRECTORY/complete.trace" \
+	git -C packfileclient-complete http-fetch --packfile="$packhash" \
+		--index-pack-arg=index-pack \
+		--index-pack-arg=--stdin --index-pack-arg=--keep \
+		"$HTTPD_URL/dumb/repo_pack.git/$p" >out &&
+	test_grep "416 Requested Range Not Satisfiable" complete.trace &&
+	test_path_is_missing "$tmpfile" &&
+	git -C packfileclient-complete cat-file -e "$HASH"
+'
+
 test_expect_success 'fetch notices corrupt pack' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
-- 
2.55.0.openai.131.g83a728de1eb6

