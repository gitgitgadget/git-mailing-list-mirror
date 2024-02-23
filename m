Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8384BE7D
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 01:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653541; cv=none; b=d0RXmF+OJP4FHsxaxF3M6sqRuJx4F38k7+iE/GSI9A4ZvXR5nAf9KA7EmmJOxKlXPxtmBorYKKv2tMQ/adHy/E7euJZRdJA1yxDp7HSShzr31gZT38DD6MWPYR9bjVyjEjKz/f2U1IeflVJd4HT3/n5uv0R2j8Q/CgZRfIgse9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653541; c=relaxed/simple;
	bh=ZWg+kmgeSsT3Lk7PuU4lzRwMNstQkk0K43iJy4xEiQE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dCB/50F16FH3b9Vo3DUyDABIw7EzgvCAQ1G6zMrGI1aFkoVAq4y3H9EiTEpxACttBB5BHmVxYrXcEBLcSi1jDL8jms31fT+j7lsueb5TscbbACmKIEyOaYP+x3fBmNakTF3boohlMOtbl+/KblC8WpBfg6w44wZkUFKRdReUyDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZB8aX0y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZB8aX0y"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412730c6228so2882685e9.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 17:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708653538; x=1709258338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H54iigBzLZOwWiyw/YfDehEHhs0LG4JUYPAoX0P0I30=;
        b=bZB8aX0yB/nVckAVpw/jXzEPSL1PWeqVS0zuRtZTC6cganecta1NdHS9rKGhkMgNoS
         yT61OVGpmgeg/EuI6MNh/mIb1UBxHjB/szNmr6wWXwiZOYom8L1S+fxc15dB0st5ecix
         U2zA88bRrhOci3hkbgZpk8knHOMtz0AP88reuc9eaBzt8djWqAzhGC0XMMDvUTbo5LJX
         twKSAqCDQkdvUiUfKebNrSWGYHbBvBZb39dSzV+FAHpvlXueZtBzQ+mASO1FF7xCKH3f
         kWcuh0JlcrihTA4e/cCThQJqRqTqfL/NN2irjR+PutqQr9dETm3kSdDDtexFu8Y1igge
         KRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708653538; x=1709258338;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H54iigBzLZOwWiyw/YfDehEHhs0LG4JUYPAoX0P0I30=;
        b=ILpIr5P2aLRTbaqS/8c6hQPMrORSWKmY4MkAZvyxG8Mh7Qo9umS6hKqtsIJyOuzPJL
         wAHDv6ENfgehZWpZjFWE+z9Y5kJ+WTKFP1/my/55KvYNr+pRN+bEjGfkURAelPd3zNWt
         wkUgqyM7eW3TwG/F4b7pN1HbMqWodBSqKgQahCztQqVckBSMwz/z9BedDplirNMwsIUg
         aiGeeUQvLWZvWMiWH+FItBgBFB/BR9SWwO3Ihtc92XBYiqM57OML0QCh8dqBNPytwdjw
         71IPSKu5IUlqE6XBq2Bs1uTueNgtgAqCcmi+ElJ/OuPzgGf83xtmdrdr/LJBbb+swWHh
         vf5Q==
X-Gm-Message-State: AOJu0YwmdW/i0ZVa6dFBp1OPYVOhW1irjDUJ67/qAHSIdXKYvtviHAa2
	YxfFVjeerrUgQ9hPZesMJ/92ugkHCMpB9MKSSDBk8FpZX7piaJlAzHHsUYfw
X-Google-Smtp-Source: AGHT+IEkxlSkrp/E/MLkZjfD7cIWQ9Rl+HyVNhNp1xPXMck3EgSf/z1j5dWe7aUEXpZ7D3nOG9qo4w==
X-Received: by 2002:a05:600c:45ca:b0:412:6dd7:1d44 with SMTP id s10-20020a05600c45ca00b004126dd71d44mr222916wmo.17.1708653537479;
        Thu, 22 Feb 2024 17:58:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b00411d0b58056sm423103wms.5.2024.02.22.17.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 17:58:57 -0800 (PST)
Message-ID: <pull.1681.v2.git.git.1708653536115.gitgitgadget@gmail.com>
In-Reply-To: <pull.1681.git.git.1708506863243.gitgitgadget@gmail.com>
References: <pull.1681.git.git.1708506863243.gitgitgadget@gmail.com>
From: "Leslie Cheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 01:58:55 +0000
Subject: [PATCH v2] Add unix domain socket support to HTTP transport
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
Cc: Eric Wong <e@80x24.org>,
    Leslie Cheng <leslie.cheng5@gmail.com>,
    Leslie Cheng <leslie@lc.fyi>,
    Leslie Cheng <leslie.cheng5@gmail.com>

From: Leslie Cheng <leslie.cheng5@gmail.com>

This changeset introduces an `http.unixSocket` option so that users can
proxy their git over HTTP remotes to a unix domain socket. In terms of
why, since UDS are local and git already has a local protocol: some
corporate environments use a UDS to proxy requests to internal resources
(ie. source control), so this change would support those use-cases. This
proxy can occasionally be necessary to attach MFA tokens or client
certificates for CLI tools.

The implementation leverages `--unix-socket` option [0] via the
`CURLOPT_UNIX_SOCKET_PATH` flag available with libcurl [1].

`GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH` and `NO_UNIX_SOCKETS` were kept
separate so that we can spit out better error messages for users if git
was compiled with `NO_UNIX_SOCKETS`.

[0] https://curl.se/docs/manpage.html#--unix-socket
[1] https://curl.se/libcurl/c/CURLOPT_UNIX_SOCKET_PATH.html

Signed-off-by: Leslie Cheng <leslie@lc.fyi>
---
    Add unix domain socket support to HTTP transport
    
    Changes since v1:
    
     * Updated test to use Perl instead of nc to proxy between UDS and TCP
       socket; I chose not to split this out into a library since its use is
       hyper-specific and has a dependency on lib-httpd.sh

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1681%2Flcfyi%2Flcfyi%2Fadd-unix-socket-support-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1681/lcfyi/lcfyi/add-unix-socket-support-v2
Pull-Request: https://github.com/git/git/pull/1681

Range-diff vs v1:

 1:  3e531632329 ! 1:  2af5cc8089b Add unix domain socket support to HTTP transport.
     @@ Metadata
      Author: Leslie Cheng <leslie.cheng5@gmail.com>
      
       ## Commit message ##
     -    Add unix domain socket support to HTTP transport.
     +    Add unix domain socket support to HTTP transport
      
          This changeset introduces an `http.unixSocket` option so that users can
          proxy their git over HTTP remotes to a unix domain socket. In terms of
     @@ t/t5565-http-unix-domain-socket.sh (new)
      +	test_done
      +}
      +
     -+UDS_TO_TCP_FIFO=uds_to_tcp
     -+TCP_TO_UDS_FIFO=tcp_to_uds
     -+UDS_PID=
     -+TCP_PID=
     ++if ! test_have_prereq PERL
     ++then
     ++	skip_all='skipping http-unix-socket tests; perl not available'
     ++	test_done
     ++fi
     ++
     ++SOCKET_PROXY_PIDFILE="$(pwd)/proxy.pid"
      +UDS_SOCKET="$(pwd)/uds.sock"
     -+UNRESOLVABLE_ENDPOINT=http://localhost:4242
     ++UNRESOLVABLE_ENDPOINT=http://unresolved
      +
      +start_proxy_unix_to_tcp() {
     -+    local socket_path="$UDS_SOCKET"
     -+    local host=127.0.0.1
     -+    local port=$LIB_HTTPD_PORT
     -+
     -+    rm -f "$UDS_TO_TCP_FIFO"
     -+    rm -f "$TCP_TO_UDS_FIFO"
     -+    rm -f "$socket_path"
     -+    mkfifo "$UDS_TO_TCP_FIFO"
     -+    mkfifo "$TCP_TO_UDS_FIFO"
     -+    nc -klU "$socket_path" <tcp_to_uds >uds_to_tcp &
     -+    UDS_PID=$!
     -+
     -+    nc "$host" "$port" >tcp_to_uds <uds_to_tcp &
     -+    TCP_PID=$!
     -+
     -+    test_atexit 'stop_proxy_unix_to_tcp'
     ++	test_atexit 'stop_proxy_unix_to_tcp'
     ++
     ++	perl -Mstrict -MIO::Select -MIO::Socket::INET -MIO::Socket::UNIX -e '
     ++		my $uds_path = $ARGV[0];
     ++		my $host = $ARGV[1];
     ++		my $port = $ARGV[2];
     ++		my $pidfile = $ARGV[3];
     ++
     ++		open(my $fh, ">", $pidfile) or die "failed to create pidfile";
     ++		print $fh "$$";
     ++		close($fh);
     ++
     ++		my $uds = IO::Socket::UNIX->new(
     ++			Local => $uds_path,
     ++			Type => SOCK_STREAM,
     ++			Listen => 5,
     ++		) or die "failed to create unix domain socket";
     ++
     ++		while (my $conn = $uds->accept()) {
     ++			my $tcp_client = IO::Socket::INET->new(
     ++				PeerAddr => $host,
     ++				PeerPort => $port,
     ++				Proto => "tcp",
     ++			) or die "failed to create TCP socket";
     ++
     ++			my $sel = IO::Select->new($conn, $tcp_client);
     ++
     ++			while (my @ready = $sel->can_read(10)) {
     ++				foreach my $socket (@ready) {
     ++					my $other = ($socket == $conn) ? $tcp_client : $conn;
     ++					my $data;
     ++					my $bytes = $socket->sysread($data, 4096);
     ++
     ++					if ($bytes) {
     ++						$other->syswrite($data, $bytes);
     ++					} else {
     ++						$socket->close();
     ++					}
     ++				}
     ++			}
     ++		}
     ++	' "$UDS_SOCKET" "127.0.0.1" "$LIB_HTTPD_PORT" "$SOCKET_PROXY_PIDFILE" &
     ++	SOCKET_PROXY_PID=$!
      +}
      +
      +stop_proxy_unix_to_tcp() {
     -+    kill "$UDS_PID"
     -+    kill "$TCP_PID"
     -+    rm -f "$UDS_TO_TCP_FIFO"
     -+    rm -f "$TCP_TO_UDS_FIFO"
     ++	kill -9 "$(cat "$SOCKET_PROXY_PIDFILE")"
     ++	rm -f "$SOCKET_PROXY_PIDFILE"
     ++	rm -f "$UDS_SOCKET"
      +}
      +
      +start_httpd
     @@ t/t5565-http-unix-domain-socket.sh (new)
      +
      +# sanity check that we can't clone normally
      +test_expect_success 'cloning without UDS fails' '
     -+    test_must_fail git clone "$UNRESOLVABLE_ENDPOINT/smart/repo.git" clone
     ++	test_must_fail git clone "$UNRESOLVABLE_ENDPOINT/smart/repo.git" clone
      +'
      +
      +test_expect_success 'cloning with UDS succeeds' '
     -+    test_when_finished "rm -rf clone" &&
     ++	test_when_finished "rm -rf clone" &&
      +	test_config_global http.unixsocket "$UDS_SOCKET" &&
      +	git clone "$UNRESOLVABLE_ENDPOINT/smart/repo.git" clone
      +'
      +
      +test_expect_success 'cloning with a non-existent http proxy fails' '
     -+    git clone $HTTPD_URL/smart/repo.git clone &&
     -+    rm -rf clone &&
     -+    test_config_global http.proxy 127.0.0.1:0 &&
     -+    test_must_fail git clone $HTTPD_URL/smart/repo.git clone
     ++	git clone $HTTPD_URL/smart/repo.git clone &&
     ++	rm -rf clone &&
     ++	test_config_global http.proxy 127.0.0.1:0 &&
     ++	test_must_fail git clone $HTTPD_URL/smart/repo.git clone
      +'
      +
      +test_expect_success 'UDS socket takes precedence over http proxy' '
     -+    test_when_finished "rm -rf clone" &&
     -+    test_config_global http.proxy 127.0.0.1:0 &&
     -+    test_config_global http.unixsocket "$UDS_SOCKET" &&
     -+    git clone $HTTPD_URL/smart/repo.git clone
     ++	test_when_finished "rm -rf clone" &&
     ++	test_config_global http.proxy 127.0.0.1:0 &&
     ++	test_config_global http.unixsocket "$UDS_SOCKET" &&
     ++	git clone $HTTPD_URL/smart/repo.git clone
      +'
      +
      +test_done


 Documentation/config/http.txt      |   5 ++
 git-curl-compat.h                  |   7 ++
 http.c                             |  23 ++++++
 t/t5565-http-unix-domain-socket.sh | 109 +++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+)
 create mode 100755 t/t5565-http-unix-domain-socket.sh

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 2d4e0c9b869..bf48cbd599a 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -277,6 +277,11 @@ http.followRedirects::
 	the base for the follow-up requests, this is generally
 	sufficient. The default is `initial`.
 
+http.unixSocket::
+	Connect through this Unix domain socket via HTTP, instead of using the
+	network. If set, this config takes precendence over `http.proxy` and
+	is incompatible with the proxy options (see `curl(1)`).
+
 http.<url>.*::
 	Any of the http.* options above can be applied selectively to some URLs.
 	For a config key to match a URL, each element of the config key is
diff --git a/git-curl-compat.h b/git-curl-compat.h
index fd96b3cdffd..f0f3bec0e17 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -74,6 +74,13 @@
 #define GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH 1
 #endif
 
+/**
+ * CURLOPT_UNIX_SOCKET_PATH was added in 7.40.0, released in January 2015.
+ */
+#if LIBCURL_VERSION_NUM >= 0x074000
+#define GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH 1
+#endif
+
 /**
  * CURL_HTTP_VERSION_2 was added in 7.43.0, released in June 2015.
  *
diff --git a/http.c b/http.c
index e73b136e589..8cfdcaeac82 100644
--- a/http.c
+++ b/http.c
@@ -79,6 +79,9 @@ static const char *http_proxy_ssl_ca_info;
 static struct credential proxy_cert_auth = CREDENTIAL_INIT;
 static int proxy_ssl_cert_password_required;
 
+#if defined(GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH) && !defined(NO_UNIX_SOCKETS)
+static const char *curl_unix_socket_path;
+#endif
 static struct {
 	const char *name;
 	long curlauth_param;
@@ -455,6 +458,20 @@ static int http_options(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp("http.unixsocket", var)) {
+#ifdef GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH
+#ifndef NO_UNIX_SOCKETS
+		return git_config_string(&curl_unix_socket_path, var, value);
+#else
+		warning(_("Unix socket support unavailable in this build of Git"));
+		return 0;
+#endif
+#else
+		warning(_("Unix socket support is not supported with cURL < 7.40.0"));
+		return 0;
+#endif
+	}
+
 	if (!strcmp("http.cookiefile", var))
 		return git_config_pathname(&curl_cookie_file, var, value);
 	if (!strcmp("http.savecookies", var)) {
@@ -1203,6 +1220,12 @@ static CURL *get_curl_handle(void)
 	}
 	init_curl_proxy_auth(result);
 
+#if defined(GIT_CURL_HAVE_CURLOPT_UNIX_SOCKET_PATH) && !defined(NO_UNIX_SOCKETS)
+	if (curl_unix_socket_path) {
+		curl_easy_setopt(result, CURLOPT_UNIX_SOCKET_PATH, curl_unix_socket_path);
+	}
+#endif
+
 	set_curl_keepalive(result);
 
 	return result;
diff --git a/t/t5565-http-unix-domain-socket.sh b/t/t5565-http-unix-domain-socket.sh
new file mode 100755
index 00000000000..2f9c53ab14f
--- /dev/null
+++ b/t/t5565-http-unix-domain-socket.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+
+test_description="test fetching through http via unix domain socket"
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+test -z "$NO_UNIX_SOCKETS" || {
+	skip_all='skipping http-unix-socket tests, unix sockets not available'
+	test_done
+}
+
+if ! test_have_prereq PERL
+then
+	skip_all='skipping http-unix-socket tests; perl not available'
+	test_done
+fi
+
+SOCKET_PROXY_PIDFILE="$(pwd)/proxy.pid"
+UDS_SOCKET="$(pwd)/uds.sock"
+UNRESOLVABLE_ENDPOINT=http://unresolved
+
+start_proxy_unix_to_tcp() {
+	test_atexit 'stop_proxy_unix_to_tcp'
+
+	perl -Mstrict -MIO::Select -MIO::Socket::INET -MIO::Socket::UNIX -e '
+		my $uds_path = $ARGV[0];
+		my $host = $ARGV[1];
+		my $port = $ARGV[2];
+		my $pidfile = $ARGV[3];
+
+		open(my $fh, ">", $pidfile) or die "failed to create pidfile";
+		print $fh "$$";
+		close($fh);
+
+		my $uds = IO::Socket::UNIX->new(
+			Local => $uds_path,
+			Type => SOCK_STREAM,
+			Listen => 5,
+		) or die "failed to create unix domain socket";
+
+		while (my $conn = $uds->accept()) {
+			my $tcp_client = IO::Socket::INET->new(
+				PeerAddr => $host,
+				PeerPort => $port,
+				Proto => "tcp",
+			) or die "failed to create TCP socket";
+
+			my $sel = IO::Select->new($conn, $tcp_client);
+
+			while (my @ready = $sel->can_read(10)) {
+				foreach my $socket (@ready) {
+					my $other = ($socket == $conn) ? $tcp_client : $conn;
+					my $data;
+					my $bytes = $socket->sysread($data, 4096);
+
+					if ($bytes) {
+						$other->syswrite($data, $bytes);
+					} else {
+						$socket->close();
+					}
+				}
+			}
+		}
+	' "$UDS_SOCKET" "127.0.0.1" "$LIB_HTTPD_PORT" "$SOCKET_PROXY_PIDFILE" &
+	SOCKET_PROXY_PID=$!
+}
+
+stop_proxy_unix_to_tcp() {
+	kill -9 "$(cat "$SOCKET_PROXY_PIDFILE")"
+	rm -f "$SOCKET_PROXY_PIDFILE"
+	rm -f "$UDS_SOCKET"
+}
+
+start_httpd
+start_proxy_unix_to_tcp
+
+test_expect_success 'setup repository' '
+	test_commit foo &&
+	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git"
+'
+
+# sanity check that we can't clone normally
+test_expect_success 'cloning without UDS fails' '
+	test_must_fail git clone "$UNRESOLVABLE_ENDPOINT/smart/repo.git" clone
+'
+
+test_expect_success 'cloning with UDS succeeds' '
+	test_when_finished "rm -rf clone" &&
+	test_config_global http.unixsocket "$UDS_SOCKET" &&
+	git clone "$UNRESOLVABLE_ENDPOINT/smart/repo.git" clone
+'
+
+test_expect_success 'cloning with a non-existent http proxy fails' '
+	git clone $HTTPD_URL/smart/repo.git clone &&
+	rm -rf clone &&
+	test_config_global http.proxy 127.0.0.1:0 &&
+	test_must_fail git clone $HTTPD_URL/smart/repo.git clone
+'
+
+test_expect_success 'UDS socket takes precedence over http proxy' '
+	test_when_finished "rm -rf clone" &&
+	test_config_global http.proxy 127.0.0.1:0 &&
+	test_config_global http.unixsocket "$UDS_SOCKET" &&
+	git clone $HTTPD_URL/smart/repo.git clone
+'
+
+test_done

base-commit: 3e0d3cd5c7def4808247caf168e17f2bbf47892b
-- 
gitgitgadget
