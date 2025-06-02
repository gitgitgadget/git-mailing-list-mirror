Received: from mail.comstyle.com (speedy.comstyle.com [206.51.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F043B65C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.51.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748834094; cv=none; b=CfAsIA5fA4EM5dijnwcx+KA+SJgXbyt+DDsUJBzRxfj0GJPs/gQ1qLy7pEEUUuDCIZXK2juvQf9GvXcfTYRoHhXtUPVfCW/hWe8a8aEMeJleHq2lZIOxTe1AKaTEQNGQEauLD91DKeztJUsfA6E8FrrtHtwIQCMXzBKRbdMMel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748834094; c=relaxed/simple;
	bh=QV4OROXNDYWTVDnKBz0VIWf1xMvedEnBvcf1Rv3IhVo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UuXDx407HrfdkEEHPiiV97N7aYfm2XYfpg4iyzo1YgDVgGI7a8gWn2T/km8qAiaq5nTcWcFW011DiRwOcJTDJLW/EVfEdn63njZYyF3wmgOLSsRw/EyMXSJdf3xhoakAseIJnRJaa6KkPkIvnmro3/9D0/7h4GctfX/82TGMhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com; spf=pass smtp.mailfrom=comstyle.com; dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b=RsPLhGPr; arc=none smtp.client-ip=206.51.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=comstyle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=comstyle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="RsPLhGPr"
Received: from mail.comstyle.com (localhost [127.0.0.1])
	by mail.comstyle.com (Postfix) with ESMTP id 4b9f8j34Nzz8PbP
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 23:14:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
	:from:to:subject:message-id:mime-version:content-type; s=
	default; bh=QV4OROXNDYWTVDnKBz0VIWf1xMvedEnBvcf1Rv3IhVo=; b=RsPL
	hGPrMg1WKGEa1Ic0JH1o3BWNzXByK1cIatwCNNswiPPCkyyEGDxo28AKsp7jLWar
	HE+5+oCxiYC1Qmc0PA1g6SpxWDIl58cKlgS4qRtrg1nkFbBFrJ1VhJa6UBFpFXAr
	FGwkSMTm/uE5vvuuA0GAQUfZQERifu1rrPqskyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
	:subject:message-id:mime-version:content-type; q=dns; s=default; b=
	rooLudgVyWYD/BkR4/7yjXLcpqIRcQ4D5yQylsEZF4tsupo3PDdvtV4k6L2gC8q4
	zeEhEakWAjYlFnudEGpj3+9164hdwQKXcjqeqGRDM+esquRup/DbUhmCNodEKK7z
	yuuYnV2WDvjAYOYaKItXAC3QaxcbXW72IVQGwhg44O0=
Received: from humpty.home.comstyle.com (unknown [IPv6:2001:470:b050:3:b29c:6e05:bafd:127d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	(Authenticated sender: brad)
	by mail.comstyle.com (Postfix) with ESMTPSA id 4b9f8j0wC4z8PbN
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 23:14:45 -0400 (EDT)
Date: Sun, 1 Jun 2025 23:14:43 -0400
From: Brad Smith <brad@comstyle.com>
To: git@vger.kernel.org
Subject: [PATCH] config.mak.uname: update settings for OpenBSD
Message-ID: <aD0XIxPRQjA5t8oi@humpty.home.comstyle.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

OpenBSD requires DIR_HAS_BSD_GROUP_SEMANTICS.

OpenBSD has never had the BSD sysctl KERN_PROC_PATHNAME nor
does it support or use the /proc filesystem.

OpenBSD has had strcasestr() since 3.8. OpenBSD has had memmem()
since 5.4.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 config.mak.uname | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index df172d5871..5a0b4200c3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -301,17 +301,14 @@ ifeq ($(uname_S),FreeBSD)
 	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
-	NO_STRCASESTR = YesPlease
-	NO_MEMMEM = YesPlease
+	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 	USE_ST_TIMESPEC = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -I/usr/local/include
 	BASIC_LDFLAGS += -L/usr/local/lib
 	HAVE_PATHS_H = YesPlease
 	HAVE_BSD_SYSCTL = YesPlease
-	HAVE_BSD_KERN_PROC_SYSCTL = YesPlease
 	CSPRNG_METHOD = arc4random
-	PROCFS_EXECUTABLE_PATH = /proc/curproc/file
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
-- 
2.49.0

