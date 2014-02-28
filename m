From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 10/11] dir.c: change create_simplify() to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 13:46:53 +0400
Message-ID: <53105B0D.2090407@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:47:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJK2c-0005Fu-At
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbaB1Jrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:47:32 -0500
Received: from forward3l.mail.yandex.net ([84.201.143.136]:59670 "EHLO
	forward3l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbaB1Jrb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:47:31 -0500
Received: from smtp17.mail.yandex.net (smtp17.mail.yandex.net [95.108.252.17])
	by forward3l.mail.yandex.net (Yandex) with ESMTP id A02181500D73
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:47:29 +0400 (MSK)
Received: from smtp17.mail.yandex.net (localhost [127.0.0.1])
	by smtp17.mail.yandex.net (Yandex) with ESMTP id 55EC219004F4
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:47:29 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp17.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id hK2otpEiiC-lS1iwkiL;
	Fri, 28 Feb 2014 13:47:29 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: e672ce31-4a29-4948-b38d-944e4e87be9f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393580849;
	bh=8lemI1aVU987Z7y/R957AyQ/6vcx90uISgsQb87YwRE=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=CZJHsj5Bpt66PcN9LMUBZUAKrXZssdNgrxqz9jHsX6QX9p2CIhO8GLkcHHuI955rk
	 9ZHxCiO5A4hk27BZq3UQk/DbxoiYwDbj2aNhKzeDmddRXb+oONs2B1OBy2I1rLCugG
	 4e4Ys9U/pHUHBRspsefL3YRE1M4Cnz6p3IiyhOOc=
Authentication-Results: smtp17.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242930>

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
