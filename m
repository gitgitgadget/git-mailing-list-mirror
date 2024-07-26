Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF624101F7
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009176; cv=none; b=T97NJvs4N2s9SSkTboyCBe61Enh9n5VA6SLb3sR0+tx9za37ASfb/IBXTq4L14hxcMPZiybDLeNMmkTr8obfMG1vPuFuB4udzv/cMZDh47lYHKl/e2I5WkgMvD/DJu9JqsToH2JLVp6NZu96u2kwmqk3ErbFUVyxP6rJ7CZSRLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009176; c=relaxed/simple;
	bh=qMPhNMm5r9S4EwNnkAtcFzIm5Fzq0Vl1UK10ESn4AYs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=kHZq3UIONwLw6sCn65VzEj51x7BisnmTWhDXYgeJgcl6kG3Bo6ljEIGjTkVIMAyGYdn9mpLWCX8/ciY8/rkSLMu+6zzWDT7SmKUjhXxE3spGgKgXx8dK5Zvaqj3AAxANeSrGdL3MHf6aRI2gDECLD94l86MUk/a/oeE8eyxUCV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgZbmFGX; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgZbmFGX"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5a15c2dc569so1672664a12.3
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722009172; x=1722613972; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3aXMybjNjjhFz94YvZCPd09VnK/JecQ5SpXgKUxJ6p0=;
        b=LgZbmFGXn8tj74RCJl9i6OPcwzhdMCzb95ZKjyGstks1rO8Eqo+NVUaYAAZ6prSQcl
         lPWOY4gEhKoJDVN+dUXKSICAhp0wZ8QPxeqthVbMJkFukme9ry2hIxzz86UGn14pestb
         fErvk9tQFH1qLGi6qgxJ6OEhfYFLKnldDBI9fSngEIvje40rvzIzKZIPQbkXxkYPnz9E
         qcePJOjJXUQo2AzmO15YKCM4PJdukj+oDP3Wwsk3hw1S8TJBCtwDgjUVrBBnfBQYsRut
         L/0O4Cg5YuNI1MYSw4aXQBKGkasZ12+EB9z3fu+Ad354p+c2OvKlOxHVCgNseQIEtYBf
         j5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722009172; x=1722613972;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3aXMybjNjjhFz94YvZCPd09VnK/JecQ5SpXgKUxJ6p0=;
        b=YfHKkrIGIJWOrCNGyptjbmg2xnGLsa5Lz66DrwPcynRvcbmk+BVuN4A054bvTY/VlG
         iJcW0KOMCinG5TI0mVWhQPTNzZblj4wIhfG1I/R2B5Paoe8CgIB4C52cDCpmDFwZ1XYe
         ZtQYNeYtTbiwMfVIN44nhcCw3BNTcXpVcVx+SD41KTutGphiK87yeDOMgqW0CK6fDoDA
         psmQYtsKDF2dRA/imDj6Pc4GnyJUrFa2zy4YKNv0aEPGwk9Wl7jpHPo/yPNr4xFbQnYy
         ApKcCgM3oFQyf53zhGN23aoxUXUM65t/Ih+0Ja5xK82UtqeZ6MKZlCPLMwRf6pCA1EuV
         Zugw==
X-Gm-Message-State: AOJu0Yx1Cd3M5g7Kbo+bEgexXuuGBOMzPcxTHflhyDWXnaUYcdV5uv0A
	Ne1ZbQFqMjcnUbqYJrdkUrRgY8wjuMkYXux9jRHNy3AevrUk6EhC1yR8SQ==
X-Google-Smtp-Source: AGHT+IGXKqPvHdqReOxtDZFypTEDjUlSN+pFHEqj2PF53TTkQCVS3aU4KVyBgULzoASVZ0rAyHCLhw==
X-Received: by 2002:a50:8a91:0:b0:5a2:8f7d:aff4 with SMTP id 4fb4d7f45d1cf-5ac62906b5bmr5330299a12.20.1722009171558;
        Fri, 26 Jul 2024 08:52:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b033fsm2096485a12.1.2024.07.26.08.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:52:51 -0700 (PDT)
Message-Id: <pull.1767.git.1722009170590.gitgitgadget@gmail.com>
From: "Ryan Hendrickson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 26 Jul 2024 15:52:50 +0000
Subject: [PATCH] http: do not ignore proxy path
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
Cc: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>,
    Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>

From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>

The documentation for `http.proxy` describes that option, and the
environment variables it overrides, as supporting "the syntax understood
by curl". curl allows SOCKS proxies to use a path to a Unix domain
socket, like `socks5h://localhost/path/to/socket.sock`. Git should
therefore include, if present, the path part of the proxy URL in what it
passes to libcurl.

Signed-off-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
---
    http: do not ignore proxy path
    
     * Documentation: do I need to add anything?
     * Tests: I could use a pointer on how best to add a test for this.
       Adding a case to t5564-http-proxy.sh seems straightforward but I
       don't think httpd can be configured to listen to domain sockets; can
       I use netcat?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1767%2Frhendric%2Frhendric%2Fhttp-proxy-path-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1767/rhendric/rhendric/http-proxy-path-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1767

 http.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 623ed234891..0cd75986a6b 100644
--- a/http.c
+++ b/http.c
@@ -1265,7 +1265,13 @@ static CURL *get_curl_handle(void)
 		if (!proxy_auth.host)
 			die("Invalid proxy URL '%s'", curl_http_proxy);
 
-		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
+		if (proxy_auth.path) {
+			struct strbuf proxy = STRBUF_INIT;
+			strbuf_addf(&proxy, "%s/%s", proxy_auth.host, proxy_auth.path);
+			curl_easy_setopt(result, CURLOPT_PROXY, proxy.buf);
+			strbuf_release(&proxy);
+		} else
+			curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
 		var_override(&curl_no_proxy, getenv("NO_PROXY"));
 		var_override(&curl_no_proxy, getenv("no_proxy"));
 		curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);

base-commit: ad57f148c6b5f8735b62238dda8f571c582e0e54
-- 
gitgitgadget
