From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 19/20] mingw: skip a test in t9130 that cannot pass on
 Windows
Date: Wed, 27 Jan 2016 17:20:22 +0100 (CET)
Message-ID: <83a2c2fac0a8737586b4d3c1dcca6fc61de7bb96.1453911367.git.johannes.schindelin@gmx.de>
References: <cover.1453818789.git.johannes.schindelin@gmx.de> <cover.1453911367.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 17:20:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOSpf-0002ul-5t
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 17:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934100AbcA0QU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 11:20:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:59724 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934097AbcA0QUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 11:20:25 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Mh9cj-1akgeF3N8T-00MLMF; Wed, 27 Jan 2016 17:20:22
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1453911367.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:deQDJfEB2YCxXEC7VRJvQLy2a/rseXEGWgHN0ONDFltT9nun/JG
 Xu2kS/7XWAaPrxr3dFFxHrFQyBqx1AYCymr1sWF6XxMN5WT3AGU3SajGSFWxgYL1VkE1Afw
 s8EcdGXRiVplgV2RYfoZBtPGDIaHyGwSQQm80CuGL8iN1LudsdmQNuk3xBtktF4QRRVS1HA
 5gzQ8AjG58QU4BECS/FDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VvjjQuMQKOI=:Sdrn9oJ4aU1gTIdFTSX+9+
 u5yj8Yy5cSCdtnOH9QWCVtjf48nDbZx+cJDXxaLNYDvKPLuIQ6NRRt1i74W8IUunpECOkeGp9
 NVsDd0WK0BAYwExklCDmB8j8dqC6Ra9rXd+zzgdZTfL4T7WrHJrAUkMtV2a74mkkMu1rgVt5N
 ksLFP3PGD/gZ91ucBqpGAUkucIl4tT8tByA6ZuK0x9BYYv4Nz4pweCi3ydLbD+MjXIIR/ddsl
 i9f6TksxjOWV97lz/2DjyJ3aGEY7RGBWNzihzpyj4OJ6WyrpY0Uc7uF/NRVqk9Qle7QU3Wa6G
 pO+GvHCUy3OpofxtMMl7ZiqN0bBBvzYDjkHSVWJIzdyGWuI8uuMuvZyYSx53T08lxxPEysAGa
 RLjXdTrWLiM9uAWhNfZpz05HmUhxd5hif4Oa50ifQTOQdF4118K2XuhKi0yFNW1k4mipTHAoj
 N5ShyCqhC9L9D05h4LWqSmaRcU5XuVqUbuW5S+vAVqGY2d681gYTIKy6LudY2cjKqY0Ahoty7
 7njP8R23LDIwSxhMdeYc4nUcY3g2QizR+tU4QiJcbUsHSsM4Zwa7fEWxkZMXZeu0Ksr60w683
 gXDhxNDJiP6sGX7t2p/R9HvYp0QH1N2CthG8VTyNZ1b9RRr6jl2mvBgTJMHNA0MbSWj54zu03
 pUJGg9JIscfRUUNbZpIdEuNLxy98KA0qRu+12vowM6D+n7VkfGPC/DXvRE8XZ+dnqyOPmsw1g
 MAMc0oEJry84Ai/fSyOg8V/1V9Ka9flpcboxsFAbNpIISPCKKbLym3X17nKuPSvEJh4VFjCn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284936>

On Windows, Git itself has no clue about POSIX paths, but its shell
scripts do. In this instance, we get mixed paths as a result, and when
comparing the path of the author file, we get a mismatch that is
entirely due to the POSIX path vs Windows path clash.

Let's just skip this test so that t9130-git-svn-authors-file.sh passes
in Git for Windows' SDK.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t9130-git-svn-authors-file.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index d306b77..4126481 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -91,7 +91,7 @@ test_expect_success 'fetch continues after authors-file is fixed' '
 	)
 	'
 
-test_expect_success 'fresh clone with svn.authors-file in config' '
+test_expect_success !MINGW 'fresh clone with svn.authors-file in config' '
 	(
 		rm -r "$GIT_DIR" &&
 		test x = x"$(git config svn.authorsfile)" &&
-- 
2.7.0.windows.1.7.g55a05c8
