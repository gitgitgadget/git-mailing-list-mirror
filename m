Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185DF48CD59
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790283234; cv=none; b=H5MTv0rC/BQsBnmgHmColyT0uTk3xjujKZ7hXOenzGzpPIC4LJjXwP8qKb3f5sneksR6JGvvzkuvnsq1u2VcnT4CwbrjB9etGc5+kfUHTJrBjPTqUevIOf7hM47NY8ts3vw01fy8gstDxgKgLD0Jn2n6n8nW1Ip5M5yA2teVcUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790283234; c=relaxed/simple;
	bh=wHpC1DDrjjs/ohN0AtQ7+wWaodmx438vpR99FyWtu20=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TFDvpj6pGFksAac2TyjnTLvzleKbZ+bAaXKRXM8X75xxd407kvlFnhBa0cF6CgJ0wPaBT7IhHDDxgUBT8QGFxgzJPJptNfngHN9KlEkX3gZqufC1KIcIth2/d6WV+rGHOMXNxzoEnXM4rDH28Ids15xO52yvaWPpQcvPp9gep5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+gxCxhA; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+gxCxhA"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-5309a20a55bso2609971cf.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 13:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790283231; x=1790888031; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=znGfGsO1XVQAnPp1k9SY7EcTZZ8acblBWVKvm/zJFJ4=;
        b=F+gxCxhAe+x71cA7JGEyMc/aG7FR4xQO3BAQ+46jeou4BnaFODN6KVgRhDafnmnAyd
         1te3DSr7huYMrB8mANTxnZWcjrvZqSTjDz4/q+N3V9ThgwsxaeKVpZdnwJDjZYju/sfB
         cw5RdNiP5ZITmBYFFVU+MhXOYH/LKVaaH4ntNvJFabKB6tCiyGPI0bWs4pD0T5LV4gnr
         HJ/422SgBOvgUJq4A9bZZ4CWs5ko5FWNNT8WXRVvYQ6tPvuNZrSP92wEOlWgnyxMnJyY
         g+z2iHVPPVyIX/fOG/MjiNYeoKAa0bNrpRa/qwIsdeoteFpDSw3jr+tsK5JtN0R+YY4g
         sOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790283231; x=1790888031;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=znGfGsO1XVQAnPp1k9SY7EcTZZ8acblBWVKvm/zJFJ4=;
        b=DSJ4JyhfMaMhbgCTPXlxrzOILCyYLfc2MGGY2XeDKkDJy0LTrLyw22U3M1qPCTX4qg
         55TDjM27QvV/4XZguCiyAVgndwEiK01RYmTAgUNR0qaYYq+QQQcgnkWsgDx5lK4xCWUt
         Z1d7pS1deRWSJ4yFXSl9IE+dQI+WOHaQcn5ATe6s7VrbrdUeTVhZ190o01Noldvdg0rw
         11fstC/OrmcNeuE5i6zimVBth7iq07OTVHXsro2cEBVRlYTsyF5Y0suhmGALuY5Zin9u
         O7TOWWA0Q538fkfYAHGYBdkirMwQtu2+fA5z6LLAI/hiPl+cx069KiTrArl7188Prup4
         ynjg==
X-Gm-Message-State: AFuF++mE3KPRInoQVD2dnHuvAnYqnUk6zAI1YLKIqckSJdh10UfW4K5B
	17ZD59yJfXNyQ6niU7jwurVzJeo42FiofpzxY5W+o9DtfEuXQWpHqq8ZIIkNk4O7
X-Gm-Gg: AYBFou1gpo9ZlWr1WWm94RcfA6fLHHvwiSS0U6xKzfjgQM2WvROrJ0m2hjH0Z++bIw5
	hanrXGdc0CjKNA0O27ACZ5YLDY57TqxGXxtl4HEFMCRw9jYbJ6DtDmtu78BY+RyoTPO7o9NOd60
	MokieMl2CEcrILV7tPtaQkUJG4MXrJJCSh/LhIetOWUC9YM9ewehzfPHd8e1bvVMm4YYo598i4m
	VqLbwcO0Ya8kUFB++QYilF8PE7yVSsF4JWrKH03nDsXKU+mtAKnixLzwn1KZ90hG4DxiGpxxJs+
	GJ8vcP1SMpXfj43rQQrGPjzB80mN217BGWxB1vknwqRThIajmNkkEGUPcLHRAW/Nd5M/H0LV7uL
	HEyNQFAg1+7HGbT8yBVD+X+HT/gdoZhzAeH9Plu8Fv9RCjo3rL4Wnsk2v/7Nm5OknfE76tZdGyf
	i9qRgoMpWlX4Qk4Kb2QLpZiBrmwxsto+EU9OLi8jDbb5luZDkhfgywVzCvAZZXcAPC3vXMtF1+I
	jW3P/h+uWs=
X-Received: by 2002:a05:622a:4c14:b0:532:810e:ec29 with SMTP id d75a77b69052e-5330b5a711emr9745251cf.12.1790283230893;
        Thu, 24 Sep 2026 13:53:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.71.57])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430ecf80csm1995296d6.49.2026.09.24.13.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:53:50 -0700 (PDT)
Message-Id: <pull.2236.v2.git.1790283229626.gitgitgadget@gmail.com>
In-Reply-To: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
References: <pull.2236.git.1790118373340.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 20:53:49 +0000
Subject: [PATCH v2] ci: work around Debian 12's HTTP/2 authentication failures
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
Cc: Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since 00fa8502354 (ci: bump debian-11 job to debian-12, 2026-09-05), the
`debian-12` job has intermittently failed t5559's half-auth clone with:

  curl 92 Stream error in the HTTP/2 framing layer

Anonymous discovery succeeds, but the upload-pack POST requires
authentication. Apache can return an early 401 and close the HTTP/2
stream before libcurl finishes sending the request body. Debian 12's
curl 7.88.1 treats that closure as a transport error instead of allowing
an authentication retry. Curl fixed this handling in 331b89a319d0
(http2: polish things around POST), included in 8.3.0:
https://github.com/curl/curl/pull/11756

This did not happen before switching to Debian 12 because Debian 11
ships with libcurl 7.74.0-1.3+deb11u16, which does not have that bug, it
was only introduced in cURL 7.88.0.

Replacing the packaged libcurl with a modern build would defeat this
job's purpose of testing older supported distributions. So let's simply
skip the flaky test cases when a buggy libcurl version is detected.

Assisted-by: GPT-6 Astra, GPT-6 Sol
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: work around Debian 12's HTTP/2 authentication failures
    
    While this is a regression in v2.56, it does not affect production code,
    it's just working around a flaky test. In other words: This patch does
    not need to be fast-tracked into v2.56.0, but it would be good to get it
    into master pretty soon after that, to reduce developer friction.
    
    Changes since v1:
    
     * Instead of hard-coding the test case numbers specifically on Debian
       12, thanks to Jeff King the test cases now have a
       libcurl-version-gating prereq.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2236%2Fdscho%2Fwork-around-debian-curl-stream-error-92-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2236/dscho/work-around-debian-curl-stream-error-92-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2236

Range-diff vs v1:

 1:  1dfabf3ece < -:  ---------- ci: work around Debian 12's HTTP/2 authentication failures
 -:  ---------- > 1:  e4c5658fb1 ci: work around Debian 12's HTTP/2 authentication failures


 t/t5551-http-fetch-smart.sh | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 805bec025c..57f263ca5b 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -17,6 +17,19 @@ fi
 test "$HTTP_PROTO" = "HTTP/2" && enable_http2
 start_httpd
 
+# The cURL version which Debian 12 ships (v7.88.1) can fail to retry
+# authentication after an early HTTP/2 response. This bug was introduced
+# in cURL v7.88.0 (8c762f5998 (http2: minor buffer and error path fixes,
+# 2023-02-08)) and fixed in v8.3.0 (https://github.com/curl/curl/pull/11756).
+test_lazy_prereq HAVE_CURL_HTTP2_BUG "
+	test_have_prereq HTTP2 &&
+	build_option libcurl |
+	awk -F. '
+		($1 == 7 && $2 >= 88) || ($1 == 8 && $2 < 3) { broken = 1 }
+		END { exit !broken }
+	'
+"
+
 test_expect_success HTTP2 'enable client-side http/2' '
 	git config --global http.version HTTP/2
 '
@@ -224,7 +237,8 @@ test_expect_success 'clone from auth-only-for-push repository' '
 	test_cmp expect actual
 '
 
-test_expect_success 'clone from auth-only-for-objects repository' '
+test_expect_success !HAVE_CURL_HTTP2_BUG \
+	'clone from auth-only-for-objects repository' '
 	echo two >expect &&
 	set_askpass user@host pass@host &&
 	git clone --bare "$HTTPD_URL/auth-fetch/smart/repo.git" half-auth &&
@@ -233,7 +247,8 @@ test_expect_success 'clone from auth-only-for-objects repository' '
 	test_cmp expect actual
 '
 
-test_expect_success 'no-op half-auth fetch does not require a password' '
+test_expect_success !HAVE_CURL_HTTP2_BUG \
+	'no-op half-auth fetch does not require a password' '
 	set_askpass wrong &&
 
 	# NEEDSWORK: When using HTTP(S), protocol v0 supports a "half-auth"

base-commit: 3bc0341126508f78f5869cbfc0005e987efdf0c7
-- 
gitgitgadget
