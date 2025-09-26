Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3C2F4A13
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 10:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758882782; cv=none; b=CW9EgTAmdwhwa2NyZqD3kf3yK2vckYrjNR5KCjozBNVbch6nWLNTULEcbVSF80BvK/8/U+1yeFRcE7dO8CHzBTPxEY84kiKEgnqPuRb/6NCQzJT+x9B/IH0pGuZowbM+hmtR+SZukECh4Dt/jJp3EhTGTIAw5eUAaNPxWViJTYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758882782; c=relaxed/simple;
	bh=/hjLUXftX4i7JKE+lBJRzysrHrEVUI3vQtJ3IWtKLkc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NBvO3P3GTz2mnhxvkA9PvMOopTTYI17dFNE9pnfLms9FBnwk3/BkXkWkn4JyzvRuvNR2+9aI98QAH7143IEb/U7TsK30kU2fFtbCWvCwhnBd05bNlmrFWGS0t6vEW6nK97vTuOU5FE2kcRAJFqfHrBEQ1CZud2dlvI2RaRoHKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7Kst1Je; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7Kst1Je"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78f15d58576so15956516d6.0
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 03:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758882779; x=1759487579; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JI40US1j2L0AL50sABRUzcYhvzC2y4gUNm6et1VQB5E=;
        b=X7Kst1JecvShvR038eMNVpixycCJoqNr/0MYKhahXjt+ROqVd8H735fUxekfgn53L7
         77ZOSJdyF/KC8q9FrlOPl8xe9YDUbfK3tjxil6iulMbHuo25VECxkouxegbhnJzwHx9V
         P4RRzv9pfXyWUWUVYTvdIdR+H0AheFYN8XcM5euc/LDMmdmxIoWDsER/7P5HNEQ3msiZ
         iGoGZ3TvWIqm2mLa+E4D52kiunPCOgqx1/Wwo1cDwIO08emOC6WjppIGPGwxhCH110Qm
         X4zJy1ZdmQXn4cd4MFTQ65MJ0tRUV3JyQMRv7LU/20zGDPqIVFdn0/KMzSK0kTv5Hkry
         zPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758882779; x=1759487579;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JI40US1j2L0AL50sABRUzcYhvzC2y4gUNm6et1VQB5E=;
        b=I6gftsZhQPxZAwtrp1e02Ev7F8ZcpAWnXoR1wrHSXRQqx1xx3x6MBBQX5dsC2OsDag
         5QitXjK1YLsQLyubEEiO5czUrEXksFE2F2CsITt1QpBpWiGOpcrBooi9ClXJcx1Tf/78
         MDyvG8T+Bf+3Q3DEgLGdglXGBRod8OkEqYq30fBTPsFTr8gBqC8UjgFuu11kGiiJ5/eI
         3opiky2P9DAZIfgAzxrQW06oFfjQkpvQrXjRfrD2xCMoaAg/3OoVqfhtoVv28Itwjr6V
         MEaXVB4cqVPjItGjGQmp05sR8BAhQl3m67IDf2vkfkvZlLyJClc3CWiBmUAbdLtL2yAu
         iaEQ==
X-Gm-Message-State: AOJu0YyiJhg5587FbTtjCNsEPXU9ZP78N31BUAlws8I212Dy4VHXztSM
	RJ8DIY3uhv3DfdEkYT58cC7ac/8gGqO+Njgy6BpDNJNGuIDV/nLYdWSwdHboHzo5
X-Gm-Gg: ASbGncslkP3zLFmeGfLeoJ9trCTDX5sfxl4pdim1KcpcNByW71oRJg7RXeHqeiErCnV
	dhadcPYNUcq8o7NNg5NNSt5KCNHj7APPD3eNRkHAIY9XM9yAlK+1ThlTJZbkt0ZLgOfaZnet1Xs
	JCEOpqpCRUNtBdgz3Xl/3evOyiel2arHL8JF+vcK6egvVHit7zYV27jNstAMyte6mWPmLONGjRf
	VoagBGnfn4scFI8Az1lF4IJiUvW5m2w4U7ENfs5m5Y9ha6LEImEX9pkgsKhEir4DHhZ5BjqPZlF
	2Wp6UjnXMwAxk8Oc+pLHtUv3voQJSToYQ93B2Nx7hPR+DMBe0qTqxAI+mBO71rb0yvdf1GCaezM
	ehgvuzXgRtsOFiwc+eYEZp1eurzpVXLUE
X-Google-Smtp-Source: AGHT+IH4fh3TyTxB2V9J/hsTfkto3EKztxtkBkiC56AHDJ2Jwk1STAdmuJn/oGBCQfw72pXzQbscbg==
X-Received: by 2002:a05:6214:4108:b0:796:e048:ee97 with SMTP id 6a1803df08f44-800f6042e93mr80976586d6.19.1758882779024;
        Fri, 26 Sep 2025 03:32:59 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-81c8496e0besm7829066d6.24.2025.09.26.03.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:32:58 -0700 (PDT)
Message-Id: <140755673d7a5ab211e3e25dd741e705410036cb.1758882772.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1974.v2.git.1758882772.gitgitgadget@gmail.com>
References: <pull.1974.git.1758457356.gitgitgadget@gmail.com>
	<pull.1974.v2.git.1758882772.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Sep 2025 10:32:52 +0000
Subject: [PATCH v2 3/3] http-push: avoid new compile error
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

With the recent update in Git for Windows/ARM64 as of
https://github.com/git-for-windows/git-sdk-arm64/commit/21b288e16358
cURL was updated from v8.15.0 to v8.16.0, and the LLVM-based builds (but
strangely not the GCC-based builds) continuously greet me thusly:

  http-push.c:211:2: error: call to '_curl_easy_setopt_err_long' declared
  with 'warning' attribute: curl_easy_setopt expects a long argument
  [-Werror,-Wattribute-warning]
      CC builtin/apply.o
    211 |         curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
        |         ^
  C:/a/git-sdk-arm64/git-sdk-arm64/minimal-sdk/clangarm64/include/curl/typecheck-gcc.h:50:15:
  note: expanded from macro 'curl_easy_setopt'
     50 |               _curl_easy_setopt_err_long();                             \
        |               ^
  1 error generated.
  make: *** [Makefile:2877: http-push.o] Error 1

The easiest way to shut up that compile error (which is legitimate,
seeing as the `CURLOPT_INFILESIZE` options expects a `long` parameter,
but `buffer->buf.len` refers to the `size_t` attribute of a `strbuf`)
would be to simply cast the parameter to a `long`.

However, there is a much better solution: To use the
`CURLOPT_INFILESIZE_LARGE` option instead, which was added in cURL
v7.11.0 (see https://curl.se/ch/7.11.0.html) and which Git _already_
uses in `curl_append_msgs_to_imap()`.

This fix was the motivation for renaming `xcurl_off_t()` to
`cast_size_t_to_curl_off_t()` and making it available more broadly,
which is the reason why it is used here, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http-push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 91a5465afb..7a9b96a6d0 100644
--- a/http-push.c
+++ b/http-push.c
@@ -208,7 +208,8 @@ static void curl_setup_http(CURL *curl, const char *url,
 	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
 	curl_easy_setopt(curl, CURLOPT_URL, url);
 	curl_easy_setopt(curl, CURLOPT_INFILE, buffer);
-	curl_easy_setopt(curl, CURLOPT_INFILESIZE, buffer->buf.len);
+	curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE,
+			 cast_size_t_to_curl_off_t(buffer->buf.len));
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
 	curl_easy_setopt(curl, CURLOPT_SEEKFUNCTION, seek_buffer);
 	curl_easy_setopt(curl, CURLOPT_SEEKDATA, buffer);
-- 
gitgitgadget
