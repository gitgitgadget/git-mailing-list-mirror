From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] remove unnecessary test and dead diagnostic
Date: Thu, 26 May 2011 15:59:14 +0200
Message-ID: <87tych5zrh.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 15:59:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPb5y-0002ER-WA
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 15:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757863Ab1EZN7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 09:59:22 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:54133 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756616Ab1EZN7V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 09:59:21 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id EDAF19400F4
	for <git@vger.kernel.org>; Thu, 26 May 2011 15:59:15 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id AEF4160355; Thu, 26 May 2011 15:59:14 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174511>


* sha1_file.c (index_stream): Don't check for size_t < 0.
read_in_full does not return an indication of failure.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 sha1_file.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5fc877f..ea4549c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2736,8 +2736,6 @@ static int index_stream(unsigned char *sha1, int fd, size_t size,
 		size_t actual;

 		actual = read_in_full(fd, buf, sz);
-		if (actual < 0)
-			die_errno("index-stream: reading input");
 		if (write_in_full(fast_import.in, buf, actual) != actual)
 			die_errno("index-stream: feeding fast-import");
 		size -= actual;
--
1.7.5.2.660.g9f46c
