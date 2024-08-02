Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146020B28
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722576012; cv=none; b=B1zHDEXR29FV9BMzFqjMIiE03YLYgbJVFDoGfVo5IoczUPHJdrz59wAFW/Y4yWCviwg30EzzySoSibQ1+Yz8m4EQy/4RBTTXvhGkdc5BaNTdDfGfpvd8CsYT+FMe7zcUTH9DlzmNHsSGZF6S8I4Dl6peTyFaPBd7cTx5zj12Ul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722576012; c=relaxed/simple;
	bh=IroZecvWE7L+Y96no9s8RTHOHV9Tb0AriDdYnKZ76lI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EsqZU+FzPYVa3rQCExnaAy/d/Fk32xyJCZiVm9E1F2oeV1f36jNzQkkYJfgL132ZjecmHbHN6+jy7KvPlLnHshjeYum+lGkeMWbmcGpKKeDbZ9cjmqI9aN/aDoMJ6kMJl/GyVUL8mT3MBIuD0rwFyvwyfcjvjnBq4t6z1D1oMbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwYZi616; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwYZi616"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42808071810so51368325e9.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 22:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722576009; x=1723180809; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ir6UQiciyJHfF80Tj0IZ/psH0onyELfXUgVWRsANdtI=;
        b=VwYZi616+l9ZHAyZFBKbKAtzw6vhvd1qGNUFUz+dJCVsVUS0hf72vpxKYkZAUU/RYv
         qE5uvjoj047ua3cT60U+RlRKsD4k4tYkhdZ6NukJAvnuPh77vYYrND7t68QfQrWi1mPt
         lyBbi4BCZ4jXyOTrISzSn55j34wGXL9jo5zhKwdBMLq+swp/hzlBqT1uXRF6puC5Ehp6
         JsULjZq3TI5sTo4ZfV3lxzIPKCx1DwlWAJ1CzHS/gKN5aYKtt2DneuB9MrY0+aIHv2q/
         jl7g3+bDD7zUMewRx2iRdJ8RHWHRjew4/Vjo6uogsEc75oWdk2I4Ey1iM0061RdILNpN
         AOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722576009; x=1723180809;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ir6UQiciyJHfF80Tj0IZ/psH0onyELfXUgVWRsANdtI=;
        b=rfj9scZe1mtL5iL7EHFzSMoDeEpu+kn/tkzUdZeWRuoDdQdPAaWNPYW9Y2lDITorSg
         BYd45H08Gq2Ct8JZ+PClS1zEmXjub8W3XP0dGUjPwjioymNH/GdCuwFTjcvYl0C2/Pp4
         UW2zni18dZHQG5LrZ3Y4n0GiiCtT2GvD9usgHJFhMyiibp9lseuhD1puNA7oETLbZp2g
         s9d5HL5ESyPHN+SgqJ/uTJKD1118NteKnQ8eYq6olIsduZyZTlfUriJYnKbrO0dZm618
         bWnOnDU0yeFZtce2TJ4zXk0p1UrERjprwwI4QY3ce9n2bSHoi95lTOOTJko7gcDW7Sr2
         KuRw==
X-Gm-Message-State: AOJu0YwOshXxjJi+c2LfS0Ko/NjaE5g5iFXLgag2jnOvwVrA8LduexIx
	GobxjhPmLaio6bMm09estES3Tf+WgiUbqWZpJrUEZEncUqzMD8jvsBBGgA==
X-Google-Smtp-Source: AGHT+IGA7hS2WVPR+2wAZ5QAwpq5C59VdkYMnoNw5ROgz8Lum+BdIRs7D/9iBo8YSczEzGge8/9+KA==
X-Received: by 2002:a05:600c:474d:b0:428:150e:4f13 with SMTP id 5b1f17b1804b1-428e6b95014mr12804235e9.33.1722576008465;
        Thu, 01 Aug 2024 22:20:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e727084dsm16331445e9.36.2024.08.01.22.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 22:20:08 -0700 (PDT)
Message-Id: <pull.1767.v5.git.1722576007398.gitgitgadget@gmail.com>
In-Reply-To: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>
References: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>
From: "Ryan Hendrickson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 05:20:07 +0000
Subject: [PATCH v5] http: do not ignore proxy path
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
    Jeff King <peff@peff.net>,
    Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>,
    Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>

From: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>

The documentation for `http.proxy` describes that option, and the
environment variables it overrides, as supporting "the syntax understood
by curl". curl allows SOCKS proxies to use a path to a Unix domain
socket, like `socks5h://localhost/path/to/socket.sock`. Git should
therefore include, if present, the path part of the proxy URL in what it
passes to libcurl.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Signed-off-by: Jeff King <peff@peff.net>
---
    http: do not ignore proxy path

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1767%2Frhendric%2Frhendric%2Fhttp-proxy-path-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1767/rhendric/rhendric/http-proxy-path-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1767

Range-diff vs v4:

 1:  507fb75c1a6 ! 1:  fa101a3b264 http: do not ignore proxy path
     @@ Commit message
      
          Co-authored-by: Jeff King <peff@peff.net>
          Signed-off-by: Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
     +    Signed-off-by: Jeff King <peff@peff.net>
      
       ## Documentation/config/http.txt ##
      @@ Documentation/config/http.txt: http.proxy::
     @@ t/t5564-http-proxy.sh: test_expect_success 'clone can prompt for proxy password'
      +
      +test_atexit 'test ! -e "$TRASH_DIRECTORY/socks.pid" || kill "$(cat "$TRASH_DIRECTORY/socks.pid")"'
      +
     ++# The below tests morally ought to be gated on a prerequisite that Git is
     ++# linked with a libcurl that supports Unix socket paths for proxies (7.84 or
     ++# later), but this is not easy to test right now. Instead, we || the tests with
     ++# this function.
     ++old_libcurl_error() {
     ++	grep -Fx "fatal: libcurl 7.84 or later is required to support paths in proxy URLs" "$1"
     ++}
     ++
      +test_expect_success SOCKS_PROXY 'clone via Unix socket' '
      +	test_when_finished "rm -rf clone" &&
      +	test_config_global http.proxy "socks4://localhost$PWD/%2530.sock" && {
      +		{
      +			GIT_TRACE_CURL=$PWD/trace git clone "$HTTPD_URL/smart/repo.git" clone 2>err &&
     -+			grep -i "SOCKS4 request granted." trace
     ++			grep -i "SOCKS4 request granted" trace
      +		} ||
     -+		grep "^fatal: libcurl 7\.84 or later" err
     ++		old_libcurl_error err
      +	}
      +'
      +
     -+test_expect_success 'Unix socket requires socks*:' '
     ++test_expect_success 'Unix socket requires socks*:' - <<\EOT
      +	! git clone -c http.proxy=localhost/path https://example.com/repo.git 2>err && {
     -+		grep "^fatal: Invalid proxy URL '\''localhost/path'\'': only SOCKS proxies support paths" err ||
     -+		grep "^fatal: libcurl 7\.84 or later" err
     ++		grep -Fx "fatal: Invalid proxy URL 'localhost/path': only SOCKS proxies support paths" err ||
     ++		old_libcurl_error err
      +	}
     -+'
     ++EOT
      +
     -+test_expect_success 'Unix socket requires localhost' '
     ++test_expect_success 'Unix socket requires localhost' - <<\EOT
      +	! git clone -c http.proxy=socks4://127.0.0.1/path https://example.com/repo.git 2>err && {
     -+		grep "^fatal: Invalid proxy URL '\''socks4://127\.0\.0\.1/path'\'': host must be localhost if a path is present" err ||
     -+		grep "^fatal: libcurl 7\.84 or later" err
     ++		grep -Fx "fatal: Invalid proxy URL 'socks4://127.0.0.1/path': host must be localhost if a path is present" err ||
     ++		old_libcurl_error err
      +	}
     -+'
     ++EOT
      +
       test_done


 Documentation/config/http.txt |  4 +--
 http.c                        | 24 ++++++++++++++++-
 t/socks4-proxy.pl             | 48 ++++++++++++++++++++++++++++++++++
 t/t5564-http-proxy.sh         | 49 +++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 3 deletions(-)
 create mode 100644 t/socks4-proxy.pl

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 162b33fc52f..a14371b5c96 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -5,8 +5,8 @@ http.proxy::
 	proxy string with a user name but no password, in which case git will
 	attempt to acquire one in the same way it does for other credentials. See
 	linkgit:gitcredentials[7] for more information. The syntax thus is
-	'[protocol://][user[:password]@]proxyhost[:port]'. This can be overridden
-	on a per-remote basis; see remote.<name>.proxy
+	'[protocol://][user[:password]@]proxyhost[:port][/path]'. This can be
+	overridden on a per-remote basis; see remote.<name>.proxy
 +
 Any proxy, however configured, must be completely transparent and must not
 modify, transform, or buffer the request or response in any way.  Proxies which
diff --git a/http.c b/http.c
index 623ed234891..6c6cc5c822a 100644
--- a/http.c
+++ b/http.c
@@ -1227,6 +1227,8 @@ static CURL *get_curl_handle(void)
 		 */
 		curl_easy_setopt(result, CURLOPT_PROXY, "");
 	} else if (curl_http_proxy) {
+		struct strbuf proxy = STRBUF_INIT;
+
 		if (starts_with(curl_http_proxy, "socks5h"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
@@ -1265,7 +1267,27 @@ static CURL *get_curl_handle(void)
 		if (!proxy_auth.host)
 			die("Invalid proxy URL '%s'", curl_http_proxy);
 
-		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
+		strbuf_addstr(&proxy, proxy_auth.host);
+		if (proxy_auth.path) {
+			curl_version_info_data *ver = curl_version_info(CURLVERSION_NOW);
+
+			if (ver->version_num < 0x075400)
+				die("libcurl 7.84 or later is required to support paths in proxy URLs");
+
+			if (!starts_with(proxy_auth.protocol, "socks"))
+				die("Invalid proxy URL '%s': only SOCKS proxies support paths",
+				    curl_http_proxy);
+
+			if (strcasecmp(proxy_auth.host, "localhost"))
+				die("Invalid proxy URL '%s': host must be localhost if a path is present",
+				    curl_http_proxy);
+
+			strbuf_addch(&proxy, '/');
+			strbuf_add_percentencode(&proxy, proxy_auth.path, 0);
+		}
+		curl_easy_setopt(result, CURLOPT_PROXY, proxy.buf);
+		strbuf_release(&proxy);
+
 		var_override(&curl_no_proxy, getenv("NO_PROXY"));
 		var_override(&curl_no_proxy, getenv("no_proxy"));
 		curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
diff --git a/t/socks4-proxy.pl b/t/socks4-proxy.pl
new file mode 100644
index 00000000000..4c3a35c0083
--- /dev/null
+++ b/t/socks4-proxy.pl
@@ -0,0 +1,48 @@
+use strict;
+use IO::Select;
+use IO::Socket::UNIX;
+use IO::Socket::INET;
+
+my $path = shift;
+
+unlink($path);
+my $server = IO::Socket::UNIX->new(Listen => 1, Local => $path)
+	or die "unable to listen on $path: $!";
+
+$| = 1;
+print "ready\n";
+
+while (my $client = $server->accept()) {
+	sysread $client, my $buf, 8;
+	my ($version, $cmd, $port, $ip) = unpack 'CCnN', $buf;
+	next unless $version == 4; # socks4
+	next unless $cmd == 1; # TCP stream connection
+
+	# skip NUL-terminated id
+	while (sysread $client, my $char, 1) {
+		last unless ord($char);
+	}
+
+	# version(0), reply(5a == granted), port (ignored), ip (ignored)
+	syswrite $client, "\x00\x5a\x00\x00\x00\x00\x00\x00";
+
+	my $remote = IO::Socket::INET->new(PeerHost => $ip, PeerPort => $port)
+		or die "unable to connect to $ip/$port: $!";
+
+	my $io = IO::Select->new($client, $remote);
+	while ($io->count) {
+		for my $fh ($io->can_read(0)) {
+			for my $pair ([$client, $remote], [$remote, $client]) {
+				my ($from, $to) = @$pair;
+				next unless $fh == $from;
+
+				my $r = sysread $from, my $buf, 1024;
+				if (!defined $r || $r <= 0) {
+					$io->remove($from);
+					next;
+				}
+				syswrite $to, $buf;
+			}
+		}
+	}
+}
diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index bb35b87071d..0d6cfebbfab 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -39,4 +39,53 @@ test_expect_success 'clone can prompt for proxy password' '
 	expect_askpass pass proxuser
 '
 
+start_socks() {
+	mkfifo socks_output &&
+	{
+		"$PERL_PATH" "$TEST_DIRECTORY/socks4-proxy.pl" "$1" >socks_output &
+		echo $! > "$TRASH_DIRECTORY/socks.pid"
+	} &&
+	read line <socks_output &&
+	test "$line" = ready
+}
+
+# The %30 tests that the correct amount of percent-encoding is applied to the
+# proxy string passed to curl.
+test_lazy_prereq SOCKS_PROXY 'test_have_prereq PERL && start_socks "$TRASH_DIRECTORY/%30.sock"'
+
+test_atexit 'test ! -e "$TRASH_DIRECTORY/socks.pid" || kill "$(cat "$TRASH_DIRECTORY/socks.pid")"'
+
+# The below tests morally ought to be gated on a prerequisite that Git is
+# linked with a libcurl that supports Unix socket paths for proxies (7.84 or
+# later), but this is not easy to test right now. Instead, we || the tests with
+# this function.
+old_libcurl_error() {
+	grep -Fx "fatal: libcurl 7.84 or later is required to support paths in proxy URLs" "$1"
+}
+
+test_expect_success SOCKS_PROXY 'clone via Unix socket' '
+	test_when_finished "rm -rf clone" &&
+	test_config_global http.proxy "socks4://localhost$PWD/%2530.sock" && {
+		{
+			GIT_TRACE_CURL=$PWD/trace git clone "$HTTPD_URL/smart/repo.git" clone 2>err &&
+			grep -i "SOCKS4 request granted" trace
+		} ||
+		old_libcurl_error err
+	}
+'
+
+test_expect_success 'Unix socket requires socks*:' - <<\EOT
+	! git clone -c http.proxy=localhost/path https://example.com/repo.git 2>err && {
+		grep -Fx "fatal: Invalid proxy URL 'localhost/path': only SOCKS proxies support paths" err ||
+		old_libcurl_error err
+	}
+EOT
+
+test_expect_success 'Unix socket requires localhost' - <<\EOT
+	! git clone -c http.proxy=socks4://127.0.0.1/path https://example.com/repo.git 2>err && {
+		grep -Fx "fatal: Invalid proxy URL 'socks4://127.0.0.1/path': host must be localhost if a path is present" err ||
+		old_libcurl_error err
+	}
+EOT
+
 test_done

base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
gitgitgadget
