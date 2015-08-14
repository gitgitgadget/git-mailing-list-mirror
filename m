From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH] vsnprintf in Visual Studio 2015 doesn't need
 SNPRINTF_SIZE_CORR any more
Date: Fri, 14 Aug 2015 21:39:04 +0200
Message-ID: <55CE43D8.6000108@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 21:39:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQKp4-0007qr-Mg
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 21:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbbHNTjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 15:39:22 -0400
Received: from srv1.79p.de ([213.239.234.118]:48234 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751321AbbHNTjW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 15:39:22 -0400
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6b2b:1300:a502:7b37:ac72:2ad5] (p200300886B2B1300A5027B37AC722AD5.dip0.t-ipconnect.de [IPv6:2003:88:6b2b:1300:a502:7b37:ac72:2ad5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 02294223D7C;
	Fri, 14 Aug 2015 21:39:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015; t=1439581160;
	bh=Lmj57KGWd9Fv/d3+tdJygJOFMj/0DTeCUM6vKKesl9w=;
	h=From:Subject:To:Date;
	b=BZ6/h0kfDrqcMM7hQkdBBhKTDGFC1/xJAKOBtDUXh8RcG5cpjCO4T3HvdJHoewGNT
	 dSNTs2LP2VZciSL1wg8nj8qftjzXFLKPlpxz4PpyKdNfE9gOqQIc4pgW5uA43hDm0M
	 hzrpKGv0irm1qNdJNafYdIVGzmi/wKSiClLXiNw8CWMGdVmoZHOLawLtkykLt4OQnp
	 u8xvhCQjPoWX/viHYDiTBNjrYnlZWIV8BWSabAlasg0OnRmOab6On9dREe2ZqhHj/a
	 ZOjqf4r2chhcock5ZIuRMZrtRJ4htE3nI1KiyXyK99axVsjZwZK6WWDW+QXwFgLiRj
	 Aakxv7wRGl6Nw==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275928>

W/o this fix there is one character missing at the end.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 compat/snprintf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/snprintf.c b/compat/snprintf.c
index 42ea1ac..0b11688 100644
--- a/compat/snprintf.c
+++ b/compat/snprintf.c
@@ -9,7 +9,7 @@
  * always have room for a trailing NUL byte.
  */
 #ifndef SNPRINTF_SIZE_CORR
-#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4)
+#if defined(WIN32) && (!defined(__GNUC__) || __GNUC__ < 4) && (!defined(_MSC_VER) || _MSC_VER < 1900)
 #define SNPRINTF_SIZE_CORR 1
 #else
 #define SNPRINTF_SIZE_CORR 0
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
