Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC01B974
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722062689; cv=none; b=L7uOnLsKdRO1Go50o+5Tv39anKh0KvP+A03RiYrFQbSuRdHWSG3S/Tui6MT4IJX80MdXT+Sg5enhzqdgzqEZmIf6M6gi1ry4sZJhD/vmS8DRBxfabKvK96Tr5pERBaPvnDh59R6kcn5MhmmnJtRfKpVZTyZ4eeIBqqGo0ytxqNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722062689; c=relaxed/simple;
	bh=GOGFlDD5oOo4Swlfaem+Vm0LTAiiSlPCsOns3qmv7EA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tWuYomoyseJGnTGGhlz+QLYJ2nPKX8fxJln2u4js8/05rSKXtxe7IZhzaOGu7jgfvLhSKAlD6fILHuQRCkRtKccqP9wVe9ChfU2ljDBJRcy8cX7F2yroPy065INmJMeiVrh6604yi5IspxvgZnC/fcrqtyWLp2gLoW4ivySPNDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDlLGAb0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDlLGAb0"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso263647066b.0
        for <git@vger.kernel.org>; Fri, 26 Jul 2024 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722062685; x=1722667485; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whm5mQ3pjHlpvCgdnkoJWchekw+dr5peqrVIc6k7O3w=;
        b=RDlLGAb0gqQF4qtgkwb0nCzwbDzD3doEue1gXK5y8S+ZqaQB5BCBm4Fjm3/YnU7E8h
         c1iMO3y3Q9I2e4PPvQP1dX+InA3zLevfHkovxyHtNotpUzkMKbR7rJzRk0ylrcJgoaAH
         EcuFAdjUDvmAqcdO6n118yYCT4RqHyKGxuDF4AZMWuQBtDMAXC4u39ZQ8Zzxwz3NpqRt
         +WhnSKuRA66IxEFLz7cGmlthgQEudeST48wSF7lpwOefFpbcpqLGtzHtVHlIFjDTu+0V
         pmokTR3trva0QfmAo4vV4NU5AKoHl/yxlz84DnHrfIjUwbxQ2/7icgz7J+VPaDQ2A06l
         oJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722062685; x=1722667485;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whm5mQ3pjHlpvCgdnkoJWchekw+dr5peqrVIc6k7O3w=;
        b=YHdNAoISNolujj5pVpWBxMHIO4Q8MR0rGBMvoM/iWUA3j4kGvZUjp/XZkedzkmWpmJ
         Pb184cHPPFRBnTyElbruXPra4dE6wcYFyVTQh0DrJ69ioY47UURwSCmx+ReuYlGvf7qj
         fSFh8H2DqccLZ834EofWYUlahRs+SGX1UsCTBsZGZB3+gYioRCSjqk+1VfdKXi3TN4f3
         UrDYDZko6EEdGCV6CWq2NqD/JrQW+YIvW+uagt5FLGOLoumlY6KLarl4T8l5NzCggXnM
         eW6w642Ia6prmaN2hueC9F0zBp3d7RcHA6TEe5qZVQV57ke+9KG1k3zggvFh89LGvgTU
         rkMQ==
X-Gm-Message-State: AOJu0YyRRUepUluXi/qhgNYHmM1OIh2cPwm8Rfx7ol5Ut2SK4IGm6e4q
	AmfkhV59SliSDGgGglw9s1oOv6RsEzbJ+ojstn6LcI3rh7iAodCvd6/WMQ==
X-Google-Smtp-Source: AGHT+IGNBsRT0TbKBYTFtM9iGlHsfYOVdXm9ubyNUf4PK5ICg9PpUGutMhul3j+le4ymv4v892y8MQ==
X-Received: by 2002:a17:907:9621:b0:a7a:ac5f:bbfa with SMTP id a640c23a62f3a-a7d3f9fa2f9mr125560266b.0.1722062684482;
        Fri, 26 Jul 2024 23:44:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90130sm254383766b.144.2024.07.26.23.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 23:44:43 -0700 (PDT)
Message-Id: <pull.1767.v2.git.1722062682858.gitgitgadget@gmail.com>
In-Reply-To: <pull.1767.git.1722009170590.gitgitgadget@gmail.com>
References: <pull.1767.git.1722009170590.gitgitgadget@gmail.com>
From: "Ryan Hendrickson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jul 2024 06:44:42 +0000
Subject: [PATCH v2] http: do not ignore proxy path
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1767%2Frhendric%2Frhendric%2Fhttp-proxy-path-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1767/rhendric/rhendric/http-proxy-path-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1767

Range-diff vs v1:

 1:  6b6ef680dce < -:  ----------- http: do not ignore proxy path
 -:  ----------- > 1:  b4715eba5b1 http: do not ignore proxy path


 Documentation/config/http.txt       |   4 +-
 http.c                              |  20 ++-
 t/socks5-proxy-server/LICENSE       |  21 +++
 t/socks5-proxy-server/README.md     |  27 +++
 t/socks5-proxy-server/src/socks5.pl | 260 ++++++++++++++++++++++++++++
 t/t5564-http-proxy.sh               |  18 ++
 6 files changed, 347 insertions(+), 3 deletions(-)
 create mode 100644 t/socks5-proxy-server/LICENSE
 create mode 100644 t/socks5-proxy-server/README.md
 create mode 100755 t/socks5-proxy-server/src/socks5.pl

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
index 623ed234891..a6001296dd0 100644
--- a/http.c
+++ b/http.c
@@ -1227,6 +1227,7 @@ static CURL *get_curl_handle(void)
 		 */
 		curl_easy_setopt(result, CURLOPT_PROXY, "");
 	} else if (curl_http_proxy) {
+		struct strbuf proxy = STRBUF_INIT;
 		if (starts_with(curl_http_proxy, "socks5h"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
@@ -1265,7 +1266,24 @@ static CURL *get_curl_handle(void)
 		if (!proxy_auth.host)
 			die("Invalid proxy URL '%s'", curl_http_proxy);
 
-		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
+		strbuf_addstr(&proxy, proxy_auth.host);
+		if (proxy_auth.path) {
+			int path_is_supported = 0;
+			/* curl_version_info was added in curl 7.10 */
+#if LIBCURL_VERSION_NUM >= 0x070a00
+			curl_version_info_data *ver = curl_version_info(CURLVERSION_NOW);
+			path_is_supported = ver->version_num >= 0x075400;
+#endif
+			if (path_is_supported) {
+				strbuf_addch(&proxy, '/');
+				strbuf_add_percentencode(&proxy, proxy_auth.path, 0);
+			} else {
+				die("libcurl 7.84 or later is required to support paths in proxy URLs");
+			}
+		}
+		curl_easy_setopt(result, CURLOPT_PROXY, proxy.buf);
+		strbuf_release(&proxy);
+
 		var_override(&curl_no_proxy, getenv("NO_PROXY"));
 		var_override(&curl_no_proxy, getenv("no_proxy"));
 		curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);
diff --git a/t/socks5-proxy-server/LICENSE b/t/socks5-proxy-server/LICENSE
new file mode 100644
index 00000000000..94981550c94
--- /dev/null
+++ b/t/socks5-proxy-server/LICENSE
@@ -0,0 +1,21 @@
+MIT License
+
+Copyright (c) 2014 kaimi.io
+
+Permission is hereby granted, free of charge, to any person obtaining a copy
+of this software and associated documentation files (the "Software"), to deal
+in the Software without restriction, including without limitation the rights
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+copies of the Software, and to permit persons to whom the Software is
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in all
+copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+SOFTWARE.
diff --git a/t/socks5-proxy-server/README.md b/t/socks5-proxy-server/README.md
new file mode 100644
index 00000000000..6eed0e5ce7a
--- /dev/null
+++ b/t/socks5-proxy-server/README.md
@@ -0,0 +1,27 @@
+socks5-proxy-server
+===================
+
+This Perl code implements a SOCKS5 proxy server that listens for incoming connections and processes them in separate threads. The server takes three input parameters: `path`, `login`, and `password`.
+
+When a client attempts to connect to the server, the server checks if the client supports any of the available authentication methods (no authentication or login/password authentication). If a suitable method is found, the server establishes a connection with the target server and begins forwarding data between the client and the target server.
+
+The code uses the `IO::Select` module for working with sockets and the `threads` module for creating and managing threads. It includes several functions, including:
+
+- `main`: the main function that creates threads for processing incoming connections.
+- `replenish`: a function that creates additional threads if the number of free threads is less than the specified value.
+- `new_client`: a function that handles incoming client connections and checks if the available authentication methods are supported by the client.
+- `socks_auth`: a function that performs login and password authentication.
+- `handle_client`: a function that establishes a connection with the target server and forwards data between the client and the target server.
+
+This code includes the use of the following Perl modules: `IO::Select`, `Socket`, `threads`, `threads::shared`.
+
+To run this code, enter the following command:
+`perl socks5.pl path login password`
+
+Note that this code is designed for educational purposes and should not be used in production environments without proper modifications and security measures. 😊
+
+This code is distributed under the [MIT License](LICENSE), which allows for free use, modification, and distribution of the code as long as the original copyright notice and license are included.
+
+---
+
+Originally from: https://github.com/kaimi-io/socks5-proxy-server
diff --git a/t/socks5-proxy-server/src/socks5.pl b/t/socks5-proxy-server/src/socks5.pl
new file mode 100755
index 00000000000..3ef66a1a287
--- /dev/null
+++ b/t/socks5-proxy-server/src/socks5.pl
@@ -0,0 +1,260 @@
+#!/usr/bin/perl
+#В коде использованы части rdss (.Slip) и sss (hm2k)
+use strict;
+use IO::Select;
+use Socket;
+use threads;
+use threads::shared;
+
+if(scalar @ARGV < 1)
+{
+	die "Usage: serv.pl path login pass\n";
+}
+
+my ($path, $login, $passw) = @ARGV;
+
+my %config = (thr_init => 10, thr_min => 2, thr_max => 20, conn_limit => SOMAXCONN);
+
+$| = 1;
+
+my %status : shared;
+my $accept : shared;
+
+my $sock_addr = sockaddr_un $path or die $!;
+socket my $socket, PF_UNIX, SOCK_STREAM, 0;
+bind $socket, $sock_addr or die $!;
+listen $socket, $config{'conn_limit'} or die $!;
+
+
+my $sel = IO::Select->new($socket);
+
+print "Starting...\n";
+
+replenish($config{'thr_init'});
+
+while(1)
+{
+	lock %status;
+	cond_wait %status;
+
+	my @free = sort {$a <=> $b} grep {$status{$_} eq 'free'} keys %status;
+
+	if(scalar @free < $config{'thr_min'})
+	{
+		replenish($#free - $config{'thr_min'});
+	}
+	elsif(scalar @free > $config{'thr_max'})
+	{
+		my @kill = @free[0..$#free - $config{'thr_max'}];
+		status($_ => 'kill') for @kill;
+	}
+}
+
+status($_ => 'kill') for keys %status;
+
+sub main
+{
+	my $sock = shift;
+	my $loop = 50;
+
+	my $tid = threads->tid;
+	my $conn;
+
+	threads->self->detach;
+	status($tid, 'free');
+
+	while(status($tid) ne 'kill' && $loop > 0)
+	{
+		next unless $sel->can_read(.1);
+		{
+			lock $accept;
+			next unless accept $conn, $sock;
+		}
+		$loop--;
+		status($tid => 'work');
+		new_client($conn);
+		close $conn;
+		status($tid => 'free');
+	}
+
+	status($tid, 'kill');
+}
+
+sub status
+{
+	my ($tid, $state) = @_;
+	lock %status;
+
+	return $status{$tid} unless $state;
+	if($state)
+	{
+		$status{$tid} = $state unless defined $status{$tid} and $status{$tid} eq 'kill';
+	}
+	else
+	{
+		delete $status{$tid};
+	}
+
+	cond_broadcast %status;
+}
+
+sub replenish
+{
+	threads->create(\&main, $socket) for 1..$_[0];
+}
+
+sub new_client
+{
+	my $sock = shift;
+
+	sysread $sock, my $buf, 2;
+
+	my ($ver, $auth_num) = unpack('H2H2', $buf);
+	#Версия протокола
+	return unless $ver eq '05';
+	sysread $sock, $buf, $auth_num;
+
+	my $ok = 0;
+	#Перечисление методов авторизации
+	for(my ($mode, $i) = (0, 0); $i < $auth_num; $mode = ord substr $buf, ++$i, 1)
+	{
+		#0 - Без авторизации; 2 - Username/Password
+		if($mode == 0 && !$login)
+		{
+			syswrite $sock, "\x05\x00";
+			$ok++;
+			last;
+		}
+		elsif($mode == 2 && $login)
+		{
+			return unless socks_auth($sock);
+			$ok++;
+			last;
+		}
+	}
+	#Подходящие методы есть
+	if($ok)
+	{
+		sysread $sock, $buf, 3;
+		my ($ver, $cmd, $r) = unpack 'H2H2H2', $buf;
+
+		if($ver eq '05' && $r eq '00')
+		{
+			my ($client_host, $client_host_raw, $client_port, $client_port_raw) = get_conn_info($sock);
+			return unless ($client_host || $client_port);
+
+			syswrite $sock, "\x05\x00\x00".$client_host_raw.$client_port_raw;
+			handle_client($sock, $client_host, $client_port, $cmd);
+		}
+	}
+	else
+	{
+		syswrite $sock, "\x05\xFF";
+	}
+}
+
+sub socks_auth
+{
+	my $sock = shift;
+
+	syswrite $sock, "\x05\x02";
+	sysread $sock, my $buf, 1;
+
+	if(ord $buf == 1)
+	{
+		#username length : username : password length : password
+		sysread $sock, $buf, 1;
+		sysread $sock, my $s_login, ord($buf);
+		sysread $sock, $buf, 1;
+		sysread $sock, my $s_passw, ord($buf);
+
+		#0x00 = success; any other value = failure
+		if($login eq $s_login && $passw eq $s_passw)
+		{
+			syswrite $sock, "\x05\x00";
+			return 1;
+		}
+		else
+		{
+			syswrite $sock, "\x05\x01";
+		}
+	}
+
+	return 0;
+}
+
+sub handle_client
+{
+	my ($sock, $host, $port, $cmd) = @_;
+
+	#0x01 = establish a TCP/IP stream connection
+	if($cmd == 1)
+	{
+		my $sock_addr = sockaddr_in $port, inet_aton($host) or return;
+		socket my $target, PF_INET, SOCK_STREAM, getprotobyname('tcp') or return;
+		connect $target, $sock_addr or return;
+
+		while($sock || $target)
+		{
+			my ($rin, $cbuf, $tbuf, $rout, $eout) = ('', '', '', '', '');
+			vec($rin, fileno($sock), 1) = 1 if $sock;
+			vec($rin, fileno($target), 1) = 1 if $target;
+			select($rout = $rin, undef, $eout = $rin, 120);
+			return if(!$rout && !$eout);
+
+			if($sock && (vec($eout, fileno($sock), 1) || vec($rout, fileno($sock), 1)))
+			{
+				my $res = sysread $sock, $tbuf, 1024;
+				return if(!defined $res || !$res);
+			}
+			if($target && (vec($eout, fileno($target), 1) || vec($rout, fileno($target), 1)))
+			{
+				my $res = sysread $target, $cbuf, 1024;
+				return if(!defined $res || !$res);
+			}
+			while(my $len = length($tbuf))
+			{
+				my $r = syswrite $target, $tbuf, $len;
+				return if(!defined $r || $r <= 0);
+				$tbuf = substr($tbuf, $r);
+			}
+			while(my $len = length($cbuf))
+			{
+				my $r = syswrite $sock, $cbuf, $len;
+				return if(!defined $r || $r <= 0);
+				$cbuf = substr($cbuf, $r);
+			}
+		}
+	}
+}
+
+sub get_conn_info
+{
+	my $sock = shift;
+
+	my ($host, $raw_host) = ('', '');
+	sysread $sock, my $buf, 1;
+	($raw_host, $buf) = ($buf, ord $buf);
+	#0x01 = IPv4 address; 0x03 = Domain name
+	if($buf == 1)
+	{
+		#4 bytes for IPv4 address
+		sysread $sock, $buf, 4;
+		$raw_host .= $buf;
+		$host = join '.', map(ord, split //, $buf);
+	}
+	elsif($buf == 3)
+	{
+		#1 byte of name length followed by the name for Domain name
+		sysread $sock, $buf, 1;
+		sysread $sock, $host, ord($buf);
+		$raw_host .= $host;
+	}
+
+	#port number in a network byte order, 2 bytes
+	my ($port, $raw_port) = ('', '');
+	sysread $sock, $raw_port, 2;
+	$port = ord(substr($raw_port, 0, 1)) << 8 | ord(substr($raw_port, 1, 1));
+
+	return $host, $raw_host, $port, $raw_port;
+}
diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index bb35b87071d..bafaa31adf8 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -39,4 +39,22 @@ test_expect_success 'clone can prompt for proxy password' '
 	expect_askpass pass proxuser
 '
 
+start_socks() {
+	# The %30 tests that the correct amount of percent-encoding is applied
+	# to the proxy string passed to curl.
+	"$PERL_PATH" "$TEST_DIRECTORY/socks5-proxy-server/src/socks5.pl" \
+		"$TRASH_DIRECTORY/%30.sock" proxuser proxpass &
+	socks_pid=$!
+}
+
+test_lazy_prereq LIBCURL_7_84 'expr x$(curl-config --vernum) \>= x075400'
+
+test_expect_success PERL,LIBCURL_7_84 'clone via Unix socket' '
+	start_socks &&
+	test_when_finished "rm -rf clone && kill $socks_pid" &&
+	test_config_global http.proxy "socks5://proxuser:proxpass@localhost$PWD/%2530.sock" &&
+	GIT_TRACE_CURL=$PWD/trace git clone "$HTTPD_URL/smart/repo.git" clone &&
+	grep -i "SOCKS5 request granted." trace
+'
+
 test_done

base-commit: ad57f148c6b5f8735b62238dda8f571c582e0e54
-- 
gitgitgadget
