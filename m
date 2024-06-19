Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6219715B147
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 21:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834299; cv=none; b=jNt4LVE+XyMtNbbli2UVXY936Q4fTlcFRY3riHZ/FXveNFJ1x+i3hzNuDoud3i4ubc4E4Si1oWahzmAq6E85LUpfS0yGWn0gRVlWmnyED0hxh5M+iTnH1XH/39vsF0o0UdQ5O9SSIQ3I8XPPvaLXkv2VgSNI1osg3xgkQn6a880=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834299; c=relaxed/simple;
	bh=nACDKcxOrv2o0oTNGEq/qQQ6UyyiuFDj+qgkE3JFrWk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QERs2DIZTDg7T1m/zMyRjSHoP9KchrRoMVxh654PXWy0j53lYN46lPCjgMG7eUlp69myFkv1SKK7/fJXZ8xlI8H2KxQKJ4srcnkNCVdbrvi4sTmwWW57pkCfl/lXvGhGvqcoUrGmv0WexrTEMzA6M8QZVdEvhrdAUN9QXAR3HIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8NoysDI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8NoysDI"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f2d723ef0so235861f8f.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2024 14:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718834295; x=1719439095; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRBtzJ5mfgKVDSxfgx1Fb3pde4RRZitCidiTwuQoEKI=;
        b=T8NoysDIVoQx3H+dl1lyz0fZb9WKAJsE2NpysVwHFw8pOZ+tPoj+5EYDY+qxkfYvq5
         u4mjdgCLz5eAuDcXdKN+n/t7fK3BKC9WD+UTXc0FdrWsI1dSw82ONNJciBfod1EzmVYv
         uxZJNVmwbUuSiTf2B2JZYv9t8EOrCyyPjmYrHsQjkqVzSOVifS9oGPY80rEWgFLdPKXu
         EQU+b5aTgyUmcDtzF7RkH6LzOAyQ3ER2ZeIpJdtEQ2ZosWaw6h3WJ3JENsutRvzPA4Mx
         E7kiMPtTDY3u9Yujg4vbO/D8wtNOfXks9NuK5Lt/p7WwJFk5GO53rFWbNF59Ia+rL0WC
         zwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718834295; x=1719439095;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRBtzJ5mfgKVDSxfgx1Fb3pde4RRZitCidiTwuQoEKI=;
        b=g8Le33kVHkYWm+mkVQGF7Z6b/R5NgH5uDqMbeASfWAJHNc4Fj5tN4bzdQ7cw5eDEbT
         sptZHtbNjRUAb+VaanmhQGlit/uZ41uZk53u/l2MEVTzTkh2nddDyEzB4ySk2+aWBKYA
         71Yf6SP1TorCXne816P3wgbMs1zQHUsZAcZrDUW6TlPzSysYXup1lOhiNNcemdd8tvA8
         jRXYsJdxVW315XLCWV8Pr0Gv4WNiSBHd+KVSJdqh37fLlx0nfbmvOvqTbzo/bl4r2KJr
         tUZuaRBKuGOqRfoKv1RgptscwVLLpMK/2vJ8Kjr/h83zg3vlCVQovcFktTcpaVFGOXI0
         FMbw==
X-Gm-Message-State: AOJu0YyyJpbKW2jPtLdxk88fr784ZZiJZ3QufIgeouOBJvmLPeHlTNhd
	5Ygwrf16WL8cmUCZn22wdW0d7DltLB6FTAbwNRWzdD62E5j8MNid90ATGg==
X-Google-Smtp-Source: AGHT+IFEd1THSjTBdtVUbbzN6EUP3ig7lqiJNfcEdZf1e1biAJYM4p6cel2M8qjuvxPuCxiDGU8mRg==
X-Received: by 2002:adf:fdca:0:b0:35f:1128:250d with SMTP id ffacd0b85a97d-36319990fd8mr2322275f8f.68.1718834295078;
        Wed, 19 Jun 2024 14:58:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c5485sm3855625e9.21.2024.06.19.14.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 14:58:13 -0700 (PDT)
Message-Id: <4f4d54c8d075a43960af36ccb025b2ddb34266f8.1718834285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 21:57:53 +0000
Subject: [PATCH v2 05/17] index-info.c: return unrecognized lines to caller
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Update 'read_index_info()' to return INDEX_INFO_UNRECOGNIZED_LINE (value 1),
rather than die()-ing when the function encounters a line that cannot be
parsed according to one of the accepted formats. This grants the caller the
flexibility to fall back on custom handling for such lines rather than a
returning a catch-all error. In the case of 'update-index', we'll still exit
with a "malformed input line" error. However, when 'read_index_info()' is
used to process the input to 'mktree' in a later patch, an empty line return
value will signal a new tree in --batch mode.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/update-index.c |  9 +++++++--
 index-info.c           | 16 +++++++++-------
 index-info.h           |  5 ++++-
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index fddf59b54c1..8d0b40a6fd6 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -787,11 +787,16 @@ static enum parse_opt_result stdin_cacheinfo_callback(
 		ret = error("option '%s' must be the last argument", opt->long_name);
 	} else {
 		int *nul_term_line = opt->value;
+		struct strbuf line = STRBUF_INIT;
 
 		allow_add = allow_replace = allow_remove = 1;
-		ret = read_index_info(*nul_term_line, apply_index_info, NULL);
-		if (ret)
+		ret = read_index_info(*nul_term_line, apply_index_info, NULL, &line);
+
+		if (ret == INDEX_INFO_UNRECOGNIZED_LINE)
+			ret = error("malformed input line '%s'", line.buf);
+		else if (ret)
 			ret = -1;
+		strbuf_release(&line);
 	}
 
 	return ret;
diff --git a/index-info.c b/index-info.c
index 8ccaac5487b..7a02f66426a 100644
--- a/index-info.c
+++ b/index-info.c
@@ -5,16 +5,16 @@
 #include "strbuf.h"
 #include "quote.h"
 
-int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
+int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata,
+		    struct strbuf *line)
 {
 	const int hexsz = the_hash_algo->hexsz;
-	struct strbuf buf = STRBUF_INIT;
 	struct strbuf uq = STRBUF_INIT;
 	strbuf_getline_fn getline_fn;
 	int ret = 0;
 
 	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
-	while (getline_fn(&buf, stdin) != EOF) {
+	while (getline_fn(line, stdin) != EOF) {
 		char *ptr, *tab;
 		char *path_name;
 		struct object_id oid;
@@ -39,8 +39,8 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
 		 * index file and matches "git ls-files --stage" output.
 		 */
 		errno = 0;
-		ul = strtoul(buf.buf, &ptr, 8);
-		if (ptr == buf.buf || *ptr != ' '
+		ul = strtoul(line->buf, &ptr, 8);
+		if (ptr == line->buf || *ptr != ' '
 		    || errno || (unsigned int) ul != ul)
 			goto bad_line;
 		mode = ul;
@@ -81,10 +81,12 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
 		continue;
 
 	bad_line:
-		die("malformed input line '%s'", buf.buf);
+		ret = INDEX_INFO_UNRECOGNIZED_LINE;
+		break;
 	}
-	strbuf_release(&buf);
 	strbuf_release(&uq);
+	if (!ret)
+		strbuf_reset(line);
 
 	return ret;
 }
diff --git a/index-info.h b/index-info.h
index d650498325a..9258011462d 100644
--- a/index-info.h
+++ b/index-info.h
@@ -5,7 +5,10 @@
 
 typedef int (*each_index_info_fn)(unsigned int, struct object_id *, int, const char *, void *);
 
+#define INDEX_INFO_UNRECOGNIZED_LINE 1
+
 /* Iterate over parsed index info from stdin */
-int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata);
+int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata,
+		    struct strbuf *line);
 
 #endif /* INDEX_INFO_H */
-- 
gitgitgadget

