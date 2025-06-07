Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D200E8F6B
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749263742; cv=none; b=Y49l1dxqJBiG7h2/rX3OSe/S/OZKb3MWvC0WGqfLuwRR3vFIgThvAWbX3f76O1OIm/+RLz5XoVgay9a20SJyIo3nor0kChPhqCEm2Yf9QdubtI4uRHbgA3mQ5Oiba41CCTKGxpq14/kPnM9BrW2xp4HzWdaIzveuIfoBOWROhgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749263742; c=relaxed/simple;
	bh=ewZ/cP5at+JuzayeCKCtOb2gqUIe7nyukOrhhFMnI/0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fj5s6u0puACuYmNz8J7P7lsjk5RLCyk+qwZ47wNv0K5brH2TAmV5LGoGzsqRcj93aWE0YfRR6zbm6d/XZx4ojpZhHu5hENmW46dUMOIlEIXwCtvkWuaCKZ/z/mzWiz8nY5LAWjgaJhZRrIozo4IBrfcsoDDzV2Iey3UELalDueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=K8Sgw030; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="K8Sgw030"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4bDj3907GNz8PbP
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 22:35:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
	:from:to:subject:message-id:mime-version:content-type; s=
	default; bh=ewZ/cP5at+JuzayeCKCtOb2gqUIe7nyukOrhhFMnI/0=; b=K8Sg
	w030G+9mG156n3LdVR8Ou19d9jRxZ/pCXVk0Ba4WEwviucgms+c5w0RJuj1xxkqW
	NR2Yd6ZrKtwH63MX/DdyPji2pD7ehUzdSaUfPBh55d+RXt+gbf4gzzNXCY6ogWGt
	wK1okXTwtEsc1O6WUEJ6ZEsEkOO53CDiN+Un57w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=default; b=
	okTD3U7GSPaPgqnySvqHCPFGO1gxptVYeKKxZLZnaQHbxcTMgepiAo2qNDV5nAJ1
	K/0CTqNCtZRHyny/Vu9gbW7cDZm1AzpGzZ8i+s8roROydMr98nABr/5KaXyPrD5C
	TIRRi1YKyk9sQ76CqmWovOcklQC2XQm/ZjZoF4DZGrM=
Received: from humpty.home.comstyle.com (unknown [IPv6:2001:470:b050:3:531a:1db3:502d:aeac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4bDj386ftcz8PbN
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 22:35:32 -0400 (EDT)
Date: Fri, 6 Jun 2025 22:35:31 -0400
From: Brad Smith <brad@comstyle.com>
To: git@vger.kernel.org
Subject: [PATCH] config.mak.uname: update settings for Solaris 11
Message-ID: <aEOlc_PV7ZngUdj0@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Solaris 11.0 and newer have mkdtemp(), memmem(), strcasestr()
and strtoumax().

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 config.mak.uname | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 5a0b4200c3..1e933ead1e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -190,9 +190,6 @@ ifeq ($(uname_S),SunOS)
 	SHELL_PATH = /bin/bash
 	SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
 	HAVE_ALLOCA_H = YesPlease
-	NO_STRCASESTR = YesPlease
-	NO_MEMMEM = YesPlease
-	NO_MKDTEMP = YesPlease
 	NO_REGEX = YesPlease
 	NO_MSGFMT_EXTENDED_OPTIONS = YesPlease
 	HAVE_DEV_TTY = YesPlease
@@ -202,7 +199,10 @@ ifeq ($(uname_S),SunOS)
 		NO_IPV6 = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
 		NO_UNSETENV = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_MEMMEM = YesPlease
 		NO_SETENV = YesPlease
+		NO_STRCASESTR = YesPlease
 		NO_STRLCPY = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
@@ -212,23 +212,45 @@ ifeq ($(uname_S),SunOS)
 		NO_IPV6 = YesPlease
 		NO_SOCKADDR_STORAGE = YesPlease
 		NO_UNSETENV = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_MEMMEM = YesPlease
 		NO_SETENV = YesPlease
+		NO_STRCASESTR = YesPlease
 		NO_STRLCPY = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
         endif
         ifeq ($(uname_R),5.8)
 		NO_UNSETENV = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_MEMMEM = YesPlease
 		NO_SETENV = YesPlease
+		NO_STRCASESTR = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
         endif
         ifeq ($(uname_R),5.9)
 		NO_UNSETENV = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_MEMMEM = YesPlease
 		NO_SETENV = YesPlease
+		NO_STRCASESTR = YesPlease
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
         endif
+        ifeq ($(uname_R),5.10)
+		NO_UNSETENV = YesPlease
+		NO_MKDTEMP = YesPlease
+		NO_MEMMEM = YesPlease
+		NO_SETENV = YesPlease
+		NO_STRCASESTR = YesPlease
+		GIT_TEST_CMP = cmp
+        endif
+        ifeq ($(uname_R),5.11)
+		NO_UNSETENV = YesPlease
+		NO_SETENV = YesPlease
+		GIT_TEST_CMP = cmp
+        endif
 	INSTALL = /usr/ucb/install
 	TAR = gtar
 	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
-- 
2.49.0

