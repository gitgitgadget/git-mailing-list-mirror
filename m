From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 10/11] dir.c: use ALLOC_GROW() in create_simplify()
Date: Mon, 03 Mar 2014 11:25:31 +0400
Message-ID: <53142E6B.6030602@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:26:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNGS-000414-Fx
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753958AbaCCH0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:26:11 -0500
Received: from forward2l.mail.yandex.net ([84.201.143.145]:45720 "EHLO
	forward2l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbaCCH0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:26:07 -0500
Received: from smtp16.mail.yandex.net (smtp16.mail.yandex.net [95.108.252.16])
	by forward2l.mail.yandex.net (Yandex) with ESMTP id 9D89E1AC0CDE
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:26:06 +0400 (MSK)
Received: from smtp16.mail.yandex.net (localhost [127.0.0.1])
	by smtp16.mail.yandex.net (Yandex) with ESMTP id 55F486A06AD
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:26:06 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp16.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id PLNwovc8VN-Q5Z0BtkK;
	Mon,  3 Mar 2014 11:26:06 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 397e7bda-f7b1-43b7-9a50-f1a87e331bc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831566;
	bh=8lemI1aVU987Z7y/R957AyQ/6vcx90uISgsQb87YwRE=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=C1GK2EIgYvLN/00RmNEixdRYUzIkMfoaTnQAikiicqRigmfS3ilJSYOasvHfL8W65
	 u0mZwWkCWCFmx3BsVo/qZ3oWLPzr29K9/W5Vk/lzn1Sf2yTnRlmcJ3bHNSVrjW8wTF
	 isBegb+1FkoM/1ayIW7GdKy0D0Df7SGGP77mEETU=
Authentication-Results: smtp16.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53142CB9.80100@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243189>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 dir.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 98bb50f..4ae38e4 100644
--- a/dir.c
+++ b/dir.c
@@ -1341,10 +1341,7 @@ static struct path_simplify *create_simplify(const char **pathspec)
 
 	for (nr = 0 ; ; nr++) {
 		const char *match;
-		if (nr >= alloc) {
-			alloc = alloc_nr(alloc);
-			simplify = xrealloc(simplify, alloc * sizeof(*simplify));
-		}
+		ALLOC_GROW(simplify, nr + 1, alloc);
 		match = *pathspec++;
 		if (!match)
 			break;
-- 
1.8.5.3
