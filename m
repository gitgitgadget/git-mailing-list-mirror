Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690313D8B0
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 05:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722489782; cv=none; b=CB2Ls1/jOMS19W5zoed5uK8x2/UWggNTmsPdWTeX3ljExNU4dTXoRQ0F70taRolkXN3srMxW5eFwRgXE18zmbx80Si882zZrvZL+OgqTeW72RQ4+K8YJzQZTLJMNqAgBzO4mkQ4Fs+jwaUw+Yt2m0/qAhVQHgjxf2xzsNG+/p80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722489782; c=relaxed/simple;
	bh=Y/xWNs688Qt4N58wsn/YO5tb9tCoqVt3boZnPdMw3IE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o72I/exP7xnpLYiDb+t6B7AD8cD0iOo7KlFUDDXUrko+ayEi+8V6mzsGzGD0nlnehvke8t9K+s8zRyTgnh5pTGaaqeKVt+0oblVyZY20JmgLCSWr6xfymajyfuT02VF4JrSP6E2DwvEmQyFROC41hq51RHw/IGhBRgibX+wY3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDeUlKpT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDeUlKpT"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-368526b1333so1029892f8f.1
        for <git@vger.kernel.org>; Wed, 31 Jul 2024 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722489778; x=1723094578; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuHeHumi4adwCqvMzcersfwT6cA8m/HXA9b2UXb4HPw=;
        b=KDeUlKpThY+CtVjWBU1Xn0KhM8Hr3aVxVufiYcbD3V0HmjBH8PFUdx8jZ+QiurCTi4
         /m1XlIoI6GYvXNtWapj9WYX+PJt4OFIzIPJ/CwMOWMbInVrt3r9J+VhflsugIO8ugCmO
         K58xKw2ybt2lvK7dMYE3+wwmVXCXzTLx6DDQii0MKo0LlTuF+2C+LfHgiUh6cI588H7x
         Uvveah6UIJEUvZteDFNZZQbsROIATQ7YBiJy8P0YBuam8uyoioMhin9LIlJ7Zfkc0/54
         243TIDzsugcDpdtsmvIH+s5CKZURVWHkJrQvet8WdRpGbqfWO4KfjQx/RCwe3VfdTvkr
         vyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722489778; x=1723094578;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuHeHumi4adwCqvMzcersfwT6cA8m/HXA9b2UXb4HPw=;
        b=aLy1yZT/s5p6IwvWl7O2THXvPg2Rceagb88H0D+4DuCTfOgyeL6xaAZAxlTZt6/PRl
         Pv4NsyM7HWD7SDOcHGTaVXxAHnzm5BgEN/Hmc9z9DaYHT5YhMZInoJHP3dx8Qwv3lDFM
         5qwFKRmy8V8fRzANkuAjTNfJFAlXALMwQICIz4N8GaJ4djWFwbBgz7NvvbgyVA5xU4XR
         V4N6xM96eye0RRB+BkOBgy1pY+cga8PBcbzYpKDTt98nQfLzEAhFZg7icbCCshfCIqXh
         8BEyuVUhw7VNDtL2XQfCGlxsEZahWJ9wcTxdbEA9snstSy4eX6yK7K6r0afmPflKuSpn
         B0kw==
X-Gm-Message-State: AOJu0YydNAvXF+vieZns7+j1ZBHVK4jft1YxRseUqk5brt8RjepfGj+Z
	TUM2uycV7ZPBl8Z5NMvqn+psNSqtOVMycGJ4ya5dCeVt7KTkTg07dn/1AA==
X-Google-Smtp-Source: AGHT+IENWreRQ0RS6zEYO1+tCt7qMRFnv8PkKWk1FsiciX1HfZ/9/pjYM3tyXcVTzqfOg/Eavw0uZw==
X-Received: by 2002:a05:6000:b50:b0:367:938f:550 with SMTP id ffacd0b85a97d-36bb35de344mr125527f8f.25.1722489777723;
        Wed, 31 Jul 2024 22:22:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb9d464sm43254895e9.42.2024.07.31.22.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 22:22:57 -0700 (PDT)
Message-Id: <pull.1767.v4.git.1722489776279.gitgitgadget@gmail.com>
In-Reply-To: <pull.1767.v3.git.1722441675945.gitgitgadget@gmail.com>
References: <pull.1767.v3.git.1722441675945.gitgitgadget@gmail.com>
From: "Ryan Hendrickson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Aug 2024 05:22:56 +0000
Subject: [PATCH v4] http: do not ignore proxy path
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
---
    http: do not ignore proxy path
    
    Re earlier discussion about regressions, it turns out that curl has only
    supported this syntax since 2022 [https://curl.se/ch/7.84.0.html].
    Earlier versions of curl, if provided an http_proxy that contained a
    path, would also ignore it. curl didn't seem to consider this a breaking
    change when the feature was introduced
    [https://github.com/curl/curl/pull/8668], though; is that a valid
    argument for Git not to lose sleep over it either?
    
    A test has been added, but unfortunately it is not being run on any of
    GitHub's CI workflows, because the runner images in use all have
    versions of libcurl that are too old. It works on my machine, but
    unknown troubles may await someone else.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1767%2Frhendric%2Frhendric%2Fhttp-proxy-path-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1767/rhendric/rhendric/http-proxy-path-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1767

Range-diff vs v3:

 1:  7a58da7102e ! 1:  507fb75c1a6 http: do not ignore proxy path
     @@ http.c: static CURL *get_curl_handle(void)
       		curl_easy_setopt(result, CURLOPT_PROXY, "");
       	} else if (curl_http_proxy) {
      +		struct strbuf proxy = STRBUF_INIT;
     ++
       		if (starts_with(curl_http_proxy, "socks5h"))
       			curl_easy_setopt(result,
       				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
     @@ http.c: static CURL *get_curl_handle(void)
      +		strbuf_addstr(&proxy, proxy_auth.host);
      +		if (proxy_auth.path) {
      +			curl_version_info_data *ver = curl_version_info(CURLVERSION_NOW);
     ++
      +			if (ver->version_num < 0x075400)
      +				die("libcurl 7.84 or later is required to support paths in proxy URLs");
      +
     @@ t/t5564-http-proxy.sh: test_expect_success 'clone can prompt for proxy password'
      +	mkfifo socks_output &&
      +	{
      +		"$PERL_PATH" "$TEST_DIRECTORY/socks4-proxy.pl" "$1" >socks_output &
     -+		socks_pid=$!
     ++		echo $! > "$TRASH_DIRECTORY/socks.pid"
      +	} &&
      +	read line <socks_output &&
      +	test "$line" = ready
      +}
      +
     -+test_expect_success PERL 'try to start SOCKS proxy' '
     -+	# The %30 tests that the correct amount of percent-encoding is applied
     -+	# to the proxy string passed to curl.
     -+	if start_socks %30.sock
     -+	then
     -+		test_set_prereq SOCKS_PROXY
     -+	fi
     -+'
     ++# The %30 tests that the correct amount of percent-encoding is applied to the
     ++# proxy string passed to curl.
     ++test_lazy_prereq SOCKS_PROXY 'test_have_prereq PERL && start_socks "$TRASH_DIRECTORY/%30.sock"'
     ++
     ++test_atexit 'test ! -e "$TRASH_DIRECTORY/socks.pid" || kill "$(cat "$TRASH_DIRECTORY/socks.pid")"'
      +
      +test_expect_success SOCKS_PROXY 'clone via Unix socket' '
      +	test_when_finished "rm -rf clone" &&
     @@ t/t5564-http-proxy.sh: test_expect_success 'clone can prompt for proxy password'
      +	}
      +'
      +
     -+test_expect_success SOCKS_PROXY 'stop SOCKS proxy' 'kill "$socks_pid"'
     -+
      +test_expect_success 'Unix socket requires socks*:' '
      +	! git clone -c http.proxy=localhost/path https://example.com/repo.git 2>err && {
      +		grep "^fatal: Invalid proxy URL '\''localhost/path'\'': only SOCKS proxies support paths" err ||


 Documentation/config/http.txt |  4 +--
 http.c                        | 24 +++++++++++++++++-
 t/socks4-proxy.pl             | 48 +++++++++++++++++++++++++++++++++++
 t/t5564-http-proxy.sh         | 41 ++++++++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 3 deletions(-)
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
index bb35b87071d..039d7fc748e 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -39,4 +39,45 @@ test_expect_success 'clone can prompt for proxy password' '
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
+test_expect_success SOCKS_PROXY 'clone via Unix socket' '
+	test_when_finished "rm -rf clone" &&
+	test_config_global http.proxy "socks4://localhost$PWD/%2530.sock" && {
+		{
+			GIT_TRACE_CURL=$PWD/trace git clone "$HTTPD_URL/smart/repo.git" clone 2>err &&
+			grep -i "SOCKS4 request granted." trace
+		} ||
+		grep "^fatal: libcurl 7\.84 or later" err
+	}
+'
+
+test_expect_success 'Unix socket requires socks*:' '
+	! git clone -c http.proxy=localhost/path https://example.com/repo.git 2>err && {
+		grep "^fatal: Invalid proxy URL '\''localhost/path'\'': only SOCKS proxies support paths" err ||
+		grep "^fatal: libcurl 7\.84 or later" err
+	}
+'
+
+test_expect_success 'Unix socket requires localhost' '
+	! git clone -c http.proxy=socks4://127.0.0.1/path https://example.com/repo.git 2>err && {
+		grep "^fatal: Invalid proxy URL '\''socks4://127\.0\.0\.1/path'\'': host must be localhost if a path is present" err ||
+		grep "^fatal: libcurl 7\.84 or later" err
+	}
+'
+
 test_done

base-commit: 39bf06adf96da25b87c9aa7d35a32ef3683eb4a4
-- 
gitgitgadget
