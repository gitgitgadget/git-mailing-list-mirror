Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD9342510
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 00:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788222485; cv=none; b=LFcR80oJdzPFnK6/kiYUbnpvi9tw6nI9E2hU8OaMDMipFLfQahO9Pk+AeJGD1VXtImYBMxIBu1+cW4tL4b/9hux2pbssjQddQ4g7KhwiiWaeDtRR7Qd+O3aDfj++D2h1eWhmBDKMx7ncckLLtdHN19bpKuZOt7tmHeW6HRJu0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788222485; c=relaxed/simple;
	bh=xfrvMieCluWWEivG7c+WsgN5b4TELFOztko//8JIm7w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aOAJ/A1flXwk0F56z3jllstj8tMScer+k0H+5jvKkwD5rDybF0VUzJb1wbb1GW1aSw7LfPQM4KiJaOUWGwh9/jKxu+nMB3qDpTEFjLHuAsre4bUasBxUXB12AjmtDh/J/KcoOAVhGgSnfxs2mWSebOYLHWZHqP85oEc+c/xvuls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8HHRKGr; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8HHRKGr"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso3645849a12.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 17:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788222482; x=1788827282; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+FHHxyZWuTvwfxVMWptB5jhtf/iKs7NIjyBFyqXHjLs=;
        b=F8HHRKGrrpEnP6HxU97g8gv5WvZG1KSr6aD82h45wl30NYGIVtIb1ZQyRzeLRNYS4I
         fIryEgAX7baj89+7gejXpRcOfdjQdRNwRE03Sj5gmimzJScUrvo9aDat5TxujHLjeCvr
         jag398Et0NhUQ6G52WGF03VKa90+dHG76QCE54IJMp0CjXzIECLysIFbnLfESZZJHnTi
         BQloiiCtjEpLvsdBDVuka6smNIVqtT4ZfAq14WIRhzzt1ijykBzAqLlhFPXZJNCuXON/
         TVPE88yef65aKaxu/tCuHEEJG2m5/cUg+utwnD2Mi4ASkGyaJUwn9Qj3P0xNKqGiVnvC
         f7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788222482; x=1788827282;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+FHHxyZWuTvwfxVMWptB5jhtf/iKs7NIjyBFyqXHjLs=;
        b=oE9PD4deIFIhZDnrEv9SGvpHaZprT33cknX5qzYCQtadlQZHW4LUEYeO3Qt6VfpApj
         EalAVQzBu9L3W6vxCrILKNj5RelwjKKXVf8Fd70wnFqdq9/3CynitdAZswES44clSGTL
         3//1G1uhPLW7MUeyqeRSweP+a6oMnOlq58umW96Gtf2SZBxa6anWtcFDjDcQdOruTMow
         Ct2dy1CE8imGwfIzceqEDqGZ6pu4d+IH1ctg4vQ+UkOZQexpUDUT6m4UQmmZAtcwfy6Q
         US43ujUhrVGZ+lyc9cmktnF/Zxw18LUHKf/TiKp1fhY3xEt7iVWUUmz/3Rn0MOWf//oU
         pVQg==
X-Gm-Message-State: AFuF++mVmtNEt+OT4wzpxlOALiY/yuyPiGERAcKtlZXvtmgnwO2VU3m8
	XAjQYGKX0B+IsEp0Y6bp/mYHdlSDaZSmxM0yF8K8upwn3YtyJgGRc3z8e0X/NeCc
X-Gm-Gg: AYBFou3AmZWX8pVAQYwMzXaYA2suuE8W6AKloW6XN9UYDKy/T7B8hSV9XuhuhoangEJ
	5Cdz/0kgiOOLeC2kTfuLKrhaBI+N8cC4bUB0WLMZKQams2tC0QEociPmyHWD7ihut7r0PkwWrA4
	uzColHTmy6er1VJFhbaSMD6GzLeX2DqmzS4Mz084wN4tPA6R3SGYJgfrZkff8hSv3VdDlTcP3vC
	YJGviPopksb9YVZvdxskhBafWFJ4+viN2ymlcqVT3BY3gEBBUEbirn7Al5DTYgCw69CKZcKyj9w
	A1fugLCeBVPfdSS8JaHV4+RO3yQtD1rs1FE2PvvDLsl7i+cN1baUYYXJRBXxDzfI8FU1/3PGlVG
	5u9ELG8wtLwSsNrGbZfVJg6zsZPXXTF8RVD8PSUTTY4bOU8hdtAwNfiZ03wxSQFcGwmfjKbQwK9
	nCjCdsPMS71Xjg/AT8UOYrJ73HiN39gOE16Qib8qwH199llgOmj3TF/TZemxC5iQE+
X-Received: by 2002:a17:90b:1d43:b0:398:9be6:f995 with SMTP id 98e67ed59e1d1-39907e05739mr5992639a91.20.1788222482411;
        Mon, 31 Aug 2026 17:28:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.55.133])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d18eaasm34316693c88.1.2026.08.31.17.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 17:28:01 -0700 (PDT)
Message-Id: <d8d11ad246b2e5ca73ea131e908d74111bb0fcf9.1788222476.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2171.v4.git.1788222476.gitgitgadget@gmail.com>
References: <pull.2171.git.1783479584.gitgitgadget@gmail.com>
	<pull.2171.v4.git.1788222476.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 00:27:56 +0000
Subject: [PATCH v4 3/3] t/lib-httpd: document writing concurrency-safe CGI
 helpers
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Update t/lib-httpd.sh to document the fixes applied to
apply-one-time-script.sh and http-429.sh for future developers working
on helper scripts. Add concrete examples of patterns and anti-patterns
that should be considered when handling state management.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-httpd.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index a216e5376f..8ca09fe85b 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -159,6 +159,17 @@ prepare_httpd() {
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH"
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	cp "$TEST_PATH"/proxy-passwd "$HTTPD_ROOT_PATH"
+	# Apache can run the following scripts concurrently per request. Make
+	# sure any state management logic is resilient to race conditions.
+	#
+	# For example:
+	#   - use "mkdir dir" to ensure only one request "succeeds" under some
+	#     condition (see http-429.sh).
+	#   - chain (&&) atomic operations like "rm marker" (no -f) with the
+	#     logic that "claims" the marker instead of relying on a separate
+	#     "test -f" and "rm marker" check (see apply-one-time-script.sh).
+	#   - use scratch file names that include the process ID ($$), so
+	#     concurrent requests do not overwrite each other's state.
 	install_script incomplete-length-upload-pack-v2-http.sh
 	install_script incomplete-body-upload-pack-v2-http.sh
 	install_script error-no-report.sh
-- 
gitgitgadget
