Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E50189F53
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 23:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720568336; cv=none; b=u92h4kNkmRdRLRwgTqj1p4Yy1SefvRp6zNBMr2tDMytdQEzbPLgc1bWvnskhqA6xqExvBWpNhNXMHNsL8V279M55oZKPwelcNOGxo50MgnGns1dNfOJur7lKboEVcSfSjS53yxzFI8G6yd3wpP0OCV9YddKGcsWzfdrj7EXx5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720568336; c=relaxed/simple;
	bh=B8m4f5yFWS/y869OG/dDnD5pF0tJnXz+lxQAnaC3FDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L5kv/8Ber8gUIWJhCqXw7cCXWakr0h7N7+DFRdvvsiTRiDqz6OgdY29DpBPPN6Zmmj9k7x0WpluUnLia2Yvq9pYY3JqpWVewJFJ4AJB7qVchLPP/W041tY3JG0UEYPB2W+EmIXl8dJLglzuoyg0RqQu2vGj5dmEuqnhDV4ox/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=a9uCNbxw; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="a9uCNbxw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720568333;
	bh=B8m4f5yFWS/y869OG/dDnD5pF0tJnXz+lxQAnaC3FDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=a9uCNbxws1h8GW8jcp4OuQN0rwdibsDR7O4r4X5gekmDTkGNftGoAvCv4Atv9ye/r
	 Dv7heLsh30DskhWXhIREqkU+yTA8xQQdAbydpH0gjHxZrMbshBMDRgQbVh4+gpZlDl
	 v6XDk7LMdgkhvW8PRv4+H3BoWpioj4iweLHwx34Denjon/s0sd9jJ9bz4deWgcHNrt
	 3IuHZlvWu/ZBKs8UgmZllQyhTQSm9GIFwwBV96pJeic+O1OFP+dyUt9wo0IagJ39Fp
	 mV7N2xyhNSD8qQTAJxilUhhcfzGYwCw6Ry8RXBk9UzV1/jv2+6ANU+i5FO9X0jA2gY
	 8tu8oMqJy2pxnuf5f566hVsILIZ8ifJbx+WSd/FtA+WOIApL/ljrYgceQlnub6lw1V
	 1zoHMQK0Ha3aGH7JQE2vN4JGJJh6V3Uihu86LXVzmZFBKHp8NZKdAPVTt3BwsftWhR
	 H6bzO932PlGH7Wg1EdmmZMzn1YnW21ld4F71d/nCXGa7aejRZcD
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D41A6209A8;
	Tue,  9 Jul 2024 23:38:53 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 1/4] gitfaq: add documentation on proxies
Date: Tue,  9 Jul 2024 23:37:43 +0000
Message-ID: <20240709233746.445860-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240709233746.445860-1-sandals@crustytoothpaste.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
 <20240709233746.445860-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many corporate environments and local systems have proxies in use.  Note
the situations in which proxies can be used and how to configure them.
At the same time, note what standards a proxy must follow to work with
Git.  Explicitly call out certain classes that are known to routinely
have problems reported various places online, including in the Git for
Windows issue tracker and on Stack Overflow, and recommend against the
use of such software, noting that they are associated with myriad
security problems (including, for example, breaking sandboxing and image
integrity[0], and, for TLS middleboxes, the use of insecure protocols
and ciphers and lack of certificate verification[1]). Don't mention the
specific nature of these security problems in the FAQ entry because they
are extremely numerous and varied and we wish to keep the FAQ entry
relatively brief.

[0] https://issues.chromium.org/issues/40285192
[1] https://faculty.cc.gatech.edu/~mbailey/publications/ndss17_interception.pdf

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 8c1f2d5675..e4125b1178 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -241,6 +241,42 @@ How do I know if I want to do a fetch or a pull?::
 	ignore the upstream changes.  A pull consists of a fetch followed
 	immediately by either a merge or rebase.  See linkgit:git-pull[1].
 
+[[proxy]]
+Can I use a proxy with Git?::
+	Yes, Git supports the use of proxies.  Git honors the standard `http_proxy`,
+	`https_proxy`, and `no_proxy` environment variables commonly used on Unix, and
+	it also can be configured with `http.proxy` and similar options for HTTPS (see
+	linkgit:git-config[1]).  The `http.proxy` and related options can be
+	customized on a per-URL pattern basis.  In addition, Git can in theory
+	function normally with transparent proxies that exist on the network.
++
+For SSH, Git can support a proxy using OpenSSH's `ProxyCommand`. Commonly used
+tools include `netcat` and `socat`.  However, they must be configured not to
+exit when seeing EOF on standard input, which usually means that `netcat` will
+require `-q` and `socat` will require a timeout with something like `-t 10`.
+This is required because the way the Git SSH server knows that no more requests
+will be made is an EOF on standard input, but when that happens, the server may
+not have yet processed the final request, so dropping the connection at that
+point would interrupt that request.
++
+An example configuration entry in `~/.ssh/config` with an HTTP proxy might look
+like this:
++
+----
+Host git.example.org
+    User git
+    ProxyCommand socat -t 10 - PROXY:proxy.example.org:%h:%p,proxyport=8080
+----
++
+Note that in all cases, for Git to work properly, the proxy must be completely
+transparent.  The proxy cannot modify, tamper with, or buffer the connection in
+any way, or Git will almost certainly fail to work.  Note that many proxies,
+including many TLS middleboxes, Windows antivirus and firewall programs other
+than Windows Defender and Windows Firewall, and filtering proxies fail to meet
+this standard, and as a result end up breaking Git.  Because of the many
+reports of problems and their poor security history, we recommend against the
+use of these classes of software and devices.
+
 Merging and Rebasing
 --------------------
 
