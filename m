From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 4/6] Squelch warning about an integer overflow
Date: Mon, 26 Oct 2015 14:15:21 +0100 (CET)
Message-ID: <b0e4b6736cc2ec88e5f7cf587629d6a4d7e502d8.1445865176.git.johannes.schindelin@gmx.de>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 14:15:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqhca-00011h-Nq
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 14:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbbJZNPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 09:15:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:55729 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753874AbbJZNPX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 09:15:23 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MU0pN-1ZzoGx0P45-00QkS1;
 Mon, 26 Oct 2015 14:15:22 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1445865176.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:wHbdu0INCFR9K+uaQDXvCCcBrE8gL1/v7fXsh8j1IKdJ2o935QT
 +dJ/8jueg0YqY13+9qdDygUEJCFJsvqM4CTYfv2QQj9zi3fwPpUxqmernOoOl0IXEaonjCV
 G+2sxRdchAxm0M+0R2GPJuHamV/i3i0RQvQRBGiISOe7Z5AZv4L+0ASbgjRXTypxoLoSaVW
 75hsWej75RHoH0cJJPNSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dr5GuzlGMh0=:D+QsrJcU8n/75QUDZrCij1
 cEpjRvGnjEkb242OTWhIVOrHey4fqGzzePswlpyhSHvziWt4Ua5lI6c/kTx6zdg+ZhMtZCv18
 xfU2ZxT/FyHbm2worL54E4NLnP5N8Vno3/rlBeywW3Gw8H4erqgRQHpMBhX7IYMJU3Jwg6V0o
 zpqK8ffRR2rh6wTyKl62kFLH2PT6HkXAhRfO/M7z2ZdqZtp4qsqPOJmlbsXMxF1kT1lG0eXOi
 D3cSJ1T8qYUBRQfdgeQbiAhGil8YX0Z2eRwWGa/J3eS+EhRJ+yzFAdF3IYE+Sg8b9T1lg4k7f
 Gkqc9YDREpccqVJXHnYQVe2KxSyGBtKa/938zQrAHk4QQBrtqKDcy6aGotteKUakINXVtR2OO
 X0h8h6g1h6cUgqNb14nyCEAyA5lQWgM5cai0g4RwFxVrEaxHigkjlICMfFDDIBDMgUomDLKnA
 cjDNEuz4kgv1QqB9NuAmrL2YDpTT4rkF93MAJTIEcdSfgW5KUCPs7GwJ5U3azRxOEX0kMo0xh
 9jMV1ELHjKzLZZzVj1SUvnnPvdGIvKjbXRlSC+XIsNBeSKwRbZpSCUz2k+X7fZlR3u9/FPqA4
 hL+ro17s/0kONBQfV9S08S7mN6bj++RCnMHMG0ar2FpkqpAcQoPhWqpkPuOaNUdY457uP3R5n
 eAOH7PlaUQ/fq1izRJsFoZKngs7CXOjc5Xq3v0fkZFbVfY3idLvDbdIVTLyItajCuQghuGSCw
 cFC4JOZWUopHxrVFOiC41kS+AHv8jCe0ZaQNFrTyIjKjh0jK2iZBnEfJ+SFliDZoLqtjNIkg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280194>

We cannot rely on long integers to have more than 32 bits...

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 805d0e2..610e8a5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -568,7 +568,7 @@ extern int git_lstat(const char *, struct stat *);
 #endif
 
 #define DEFAULT_PACKED_GIT_LIMIT \
-	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
+	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? 8192 : 256))
 
 #ifdef NO_PREAD
 #define pread git_pread
-- 
2.1.4
