Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12221F8723
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785112152; cv=none; b=SW+9rMedDVazVQqcLcjJrl9FUwfnG5yc6nTv5hlfyw+plov7FGs+R9xmZ/uA3796AxyVHm7085fWs//y8j7xwXCwaLn+UOPnFj0kX5q2iqP9vUr6dn/RDeu8xvo5xqmPCr405toX6wrKRLJkiWP96oT4GMVys41z67Tmgs0Ml4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785112152; c=relaxed/simple;
	bh=TTmEIP35KQ1NT74AGy39gkgsegsazslkK4tlgVjbqlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPQBRFq1xxSIHAB+fmyEiLuA/QPyLY+uoywiC3Ebr4Lr5DNs0a4OP6PMD7whFHq5p8//yOET/Jbeik+o4X5mnnOcWNwwFH9N8ijpE4eafwjF+ycU15FmiFZieR4fRi23C2WHY63fD4fmfQEYxu0+RGW93xuGlPyOoOVEBIEfJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=bVWPwz8U; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="bVWPwz8U"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38f57e312ecso2583a91.1
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 17:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1785112150; x=1785716950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qvi24Q9TlzM5rUr+dIPhAECbMKR2fENYyz5SnFTz+GI=;
        b=bVWPwz8UR3M0VNyrsKXeM6uvsUQ7TSHoi1qmlestJ+lzfXiq/MefjE5O4C8diMEW5g
         JMug0KsNVTnXEA6xOvBnOgVGFW2AB0xOb1e+AAIDRXsOg/cB2Et0diHe2WcuLRQRvpob
         CRz6EOugaZQAsAZEW7rwTGpVv8tM5911TmgCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785112150; x=1785716950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qvi24Q9TlzM5rUr+dIPhAECbMKR2fENYyz5SnFTz+GI=;
        b=QF/6Fsr4YfHYrtRiQGsTpXOK+INM1A94b75l7LRsUdQmJ3+46O5W/AEC0VO/XtOfmK
         7VQ7Y7w4hTGbWqK4/WcRZAXP3KX+nyqMKtKWmMNdRkaWqD8Kw088uv8OqA6JkEIff30A
         fAwckpnzioGIHl3cYC/tytx7nLVD6bpU4eETg8ujXDhw9WiB8ICsOCbatsEbRrlLDg/u
         R6T4Y58Fgh6aKJNcRThQF4bAFQMLBtGc76R7ae6tOPbTwZAqWrStHTGFPlx81VnQK18x
         BqcmaMSkvnlec2pmK/o6m6t6vw1q52LTc3YIT2zMBMCL5HcDD9w2uESbx7oUe9JqTkXZ
         9QbA==
X-Gm-Message-State: AOJu0YztSzhgJXTJtyUSFjOfblLzS8pFyoVcToeVjcIMmW0q8s8UkFlm
	T8XhgPar62j5MbAB8+npcR89ITIVrZDtD6aozSByUnruKvNRWb/UHlWC+VyA1t7NUGkYblJFWeK
	jYfLEcPE=
X-Gm-Gg: AR+sD12C4P1q1cucUyfeytRVoXJ22xvBWPH1xzjwyDzBUbQ/q0IXwYMx/xtn+hBJ6qp
	Kq48POXZS/Pko+n6ZdEV07qbdikubh72VR0qP2jbKiWZdHeslVJxU8QDvi2rfdwTKxKo4fX6bea
	8F4pcr+Tg85G8M6phFNHBSLWygog0qUNY8cV8CFDOnx9SH+TDoNTh9T9hRFBINL46BUQoT3jI+y
	wIYvVn0VbbbHD4yGXungHCv+VtovuHX/3c/2bM7TbKytpNZ1c71SH4pVLZWtTLrcudVlyJ5sreu
	P3vM3a1QCROJTc7BCmheCNpqJ0IrTzPpjnWgJO7SX3K25VCiPwsra+khN2IE9dT0c77mlR9bItX
	Xd9Fy2IEqtJ2CrTFjbXlsQiiz7CHrm1ih2z1E5poOBysmtQ6rGJnoJKGvcPe20FnYI1ALMVXQOS
	y5NCm37ZjuyY7e4vcETevAT+61O9R72xDFk/Oz0RPavA/++jML/jnlraSn/VpKr/ETqnHDU8n0Y
	9jl9hI=
X-Received: by 2002:a17:90b:1b08:b0:381:fa5:5217 with SMTP id 98e67ed59e1d1-38f2977c441mr4437321a91.7.1785112150122;
        Sun, 26 Jul 2026 17:29:10 -0700 (PDT)
Received: from com-76773.corp.openai.org ([20.102.114.220])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d6ba579c3sm19920328c88.8.2026.07.26.17.29.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 17:29:09 -0700 (PDT)
From: Ted Nyman <tnyman@openai.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	me@ttaylorr.com,
	peff@peff.net,
	ps@pks.im,
	karthik.188@gmail.com,
	sandals@crustytoothpaste.net,
	avarab@gmail.com
Subject: [PATCH v6 5/6] http: permit unlinking partial packs on Windows
Date: Sun, 26 Jul 2026 17:28:42 -0700
Message-ID: <87a20ac80fcaaaa3f69a24a650f5c135b24956ff.1785111375.git.tnyman@openai.com>
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

On Windows, an open file must permit FILE_SHARE_DELETE before another
process can unlink it. MinGW's non-append O_RDWR open enables that
sharing mode only for an existing file; adding O_CREAT falls back to
_wopen(), which cannot set it.

First try opening the partial pack without O_CREAT. If it does not
exist, create it exclusively, close that descriptor, and retry through
the existing-file path. A racing creator retries after EEXIST.

This ensures that every retained descriptor permits another downloader
to unlink the staging path. Add an unlink-while-indexing test that does
not require FIFOs and can therefore run on MinGW.

Signed-off-by: Ted Nyman <tnyman@openai.com>
---
 http.c                     | 17 ++++++++++++++++-
 t/t5550-http-fetch-dumb.sh | 21 +++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index ad07ef3549..a0d399b274 100644
--- a/http.c
+++ b/http.c
@@ -2746,7 +2746,22 @@ struct http_pack_request *new_direct_http_pack_request(
 
 	odb_pack_name(the_repository, &preq->tmpfile, packed_git_hash, "pack");
 	strbuf_addstr(&preq->tmpfile, ".temp");
-	fd = open(preq->tmpfile.buf, O_RDWR | O_CREAT, 0666);
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
 	if (fd < 0) {
 		error_errno("unable to open local file %s for pack",
 			    preq->tmpfile.buf);
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 86b9d87ef5..b5758f1c9c 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -328,6 +328,27 @@ test_expect_success 'http-fetch --packfile resumes a partial download' '
 	git -C packfileclient-resume cat-file -e "$HASH"
 '
 
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
 test_expect_success PERL,PIPE 'concurrent http-fetch --packfile cannot corrupt an overlapping download' '
 	git init packfileclient-overlap &&
 	blob=$(test-tool genrandom pack-overlap 2m |
-- 
2.55.0.openai.131.g83a728de1eb6

