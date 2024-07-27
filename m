Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5401864C
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 05:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.43.20.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722058625; cv=none; b=QYYD/3ZzvH/43aMBJnsXqBO6FGZnLmcFUtSQUVgmK/6uQ/4C+qIjdWqTHLmzLpFF5WKJuwaDT8keYlYYaJYmEW+KJWDwDRWGU9aPqUYLmQUqEyTumG5zrsrKDKTmW7XISx60onzfFuMEZhYJjbDORdWMcKIY0r7lut+xEwuAeVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722058625; c=relaxed/simple;
	bh=ZYHJVIPMvFBn/IdnBF1bHTcG0un+pIqZrgt8WFubTuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlqgcMhleswFjT2HLx8GhXq682qBtRfueffhCdykUnYa2lglDUUqS6aTHFCoVYPMXvIWB1+zLRNlA7ZlK7xf30I/qIIRT7uM6s17h66NQ3jiLr6uKVBbyRgJPi7BKfv8KOdBfvl08XROiPQpoaaOJ/fu/wA2Ji4YrmsAm/w5XLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net; spf=pass smtp.mailfrom=charter.net; dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b=vRNqctJY; arc=none smtp.client-ip=47.43.20.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=charter.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=charter.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=charter.net header.i=@charter.net header.b="vRNqctJY"
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id Xa5PsVwc3l0ATXa5VszqwJ; Sat, 27 Jul 2024 05:35:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=charter.net;
	s=c20240129; t=1722058525;
	bh=ZYHJVIPMvFBn/IdnBF1bHTcG0un+pIqZrgt8WFubTuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vRNqctJYpBOselrEkfA9+Q8ua6VkxgD3EZr7IBzlBRYwg5yMpQcUTyshwBrClD9pr
	 dsFaP+gO9NgeX9yEtv3/ufo+RSN7b/JZaE6MAV184PcfFzCPbS9uxSZ5tDa/A2U7bV
	 abgMDle5aWmiNVFY5efSm5FDxIjRtVxZrakKOwTNcpduTA1q2FdFdnmBRlKrB5oULO
	 s47Y6C+19+gIpobxQXpsE9pemW/D0TfQnP2HAFBsTl0SlAHysjXcor+1sy6uCKVlbh
	 g6M5z/HkyiZCqP5xB/PZa/+ohdgQMsoqT049YjVmAjTWKkJbQEhm2aOUid95C7mJKR
	 NS5nv7czsuP6A==
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=b6u04MGx c=1 sm=1 tr=0 ts=66a4871d
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=tEj-drDq3PFC0m8d5k0A:9 a=jYKBPJSq9nmHKCndOPe9:22
 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 3/5] check-non-portable-shell: loosen one-shot assignment error message
Date: Sat, 27 Jul 2024 01:35:07 -0400
Message-ID: <20240727053509.34339-4-ericsunshine@charter.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727053509.34339-1-ericsunshine@charter.net>
References: <20240726081522.28015-1-ericsunshine@charter.net>
 <20240727053509.34339-1-ericsunshine@charter.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDQ4lbQ+rhVLcEemJah5/f2ue7BEFdlFOM4YzRBxrwU87UvUbD1wgqXH1m5WpSOqPj5YK/5iusS/QmsFUvcjNc2JCkE304Ox7tD4YGl8FDhab4FhYcOs
 tnKhBK0/tkfCIr3eelAnmaH8rA0kH5YOTOtsp55RLHbOc3cuEDJHWCNzx7AiZ993GEIw03OObi8ZdPFEf+d2+1ejXjvRwDkWZ31+KZd9PKzCsXluRWAuhQ6r
 WzVg16KYhHnKzMMfJCmTWSvQyA3M9mkF4L7u5OOoQ+7Iqt/FSI1h2DqDrzNSLNW9x2raoCrGV7j7jcn9mIfTXPBhl6AU+LAFFEc7SNgsHRM5qpV0oOy9o5id
 ZWcT2jJB

From: Eric Sunshine <sunshine@sunshineco.com>

When a0a630192d (t/check-non-portable-shell: detect "FOO=bar
shell_func", 2018-07-13) added the check for one-shot environment
variable assignment for shell functions, the primary reason given for
avoiding them was that, under some shells, the assignment outlives the
invocation of the shell function, thus could potentially negatively
impact subsequent commands in the same test, as well as subsequent
tests.

However, it has recently become apparent that this is not the only
potential problem with one-shot assignments and shell functions. Another
problem is that some shells do not actually export the variable to
commands which the function invokes[1]. More significantly, however, the
behavior of one-shot assignments with shell functions is not specified
by POSIX[2].

Given this new understanding, the presented error message ("assignment
extends beyond 'shell_func'") is too specific and potentially
misleading. Address this by emitting a less specific error message.

(Note that the wording "is not portable" is chosen over the more
specific "behavior not specified by POSIX" for consistency with almost
all other error message issued by this "lint" script.)

[1]: https://lore.kernel.org/git/xmqqbk2p9lwi.fsf_-_@gitster.g/
[2]: https://lore.kernel.org/git/xmqq34o19jj1.fsf@gitster.g/

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index b2b28c2ced..179efaa39d 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -50,7 +50,7 @@ sub err {
 	/\blocal\s+[A-Za-z0-9_]*=\$([A-Za-z0-9_{]|[(][^(])/ and
 		err q(quote "$val" in 'local var=$val');
 	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
-		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
+		err '"FOO=bar shell_func" is not portable';
 	$line = '';
 	# this resets our $. for each file
 	close ARGV if eof;
-- 
2.45.2

