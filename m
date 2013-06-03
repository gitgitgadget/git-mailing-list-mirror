From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH v2 8/7] unpack-trees: document that pointer ce can be NULL
Date: Mon, 03 Jun 2013 18:57:56 +0200
Message-ID: <51ACCB14.7030308@lsrfire.ath.cx>
References: <1370188017-24672-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <1370188017-24672-8-git-send-email-rene.scharfe@lsrfire.ath.cx> <CAMP44s2ym5UEPo8kr6YKf1x_P_0L+o_9vWdCTA6MPDQsRy7d1A@mail.gmail.com> <51AB86BB.3080203@lsrfire.ath.cx> <CAMP44s0Af90Sfi47_mxEGRFHAsAhaoO6T1jjbj7SptucNO-k0w@mail.gmail.com> <51ABAA84.8090301@lsrfire.ath.cx> <CAMP44s3cqa-jETHX+ftbAVMx+oV6PMcVkdH63P93ER-4fH28Hw@mail.gmail.com> <51ABD00C.7080503@lsrfire.ath.cx> <CAMP44s2+Hx-6E7DkmWL_m92jDt5-Cj8FGHpACBZcqp1sn5Tfzw@mail.gmail.com> <51ABD99A.2030303@lsrfire.ath.cx> <CAMP44s2HotyK7hh0nFjCe+BBtu1pyqmkn6=yt9WV6UyhxjrXoQ@mail.gmail.com> <51ACBD68.4070506@lsrfire.ath.cx> <CAMP44s09s26Gyvqu___cQg2LsUnMrzZAa0pbUnGp85fDUEeapg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 18:58:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjY5F-0005F0-8p
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 18:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759268Ab3FCQ6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 12:58:09 -0400
Received: from india601.server4you.de ([85.25.151.105]:58269 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759128Ab3FCQ6I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 12:58:08 -0400
Received: from [192.168.2.105] (p4FFD8137.dip0.t-ipconnect.de [79.253.129.55])
	by india601.server4you.de (Postfix) with ESMTPSA id C9603A6;
	Mon,  3 Jun 2013 18:58:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CAMP44s09s26Gyvqu___cQg2LsUnMrzZAa0pbUnGp85fDUEeapg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226235>

From: Felipe Contreras <felipe.contreras@gmail.com>

If someone adds code that dereferences ce before it is freed without
checking for NULL it will crash sometimes.  Spare that person from
having to wonder about the reason.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
Signoff from http://article.gmane.org/gmane.comp.version-control.git/225972.
No signoff from me because I don't see the point of adding a check for
a developer that probably won't appear.

 unpack-trees.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 57b4074..f22bd89 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -605,7 +605,7 @@ static int unpack_nondirectories(int n, unsigned long mask,
 					o);
 		for (i = 0; i < n; i++) {
 			struct cache_entry *ce = src[i + o->merge];
-			if (ce != o->df_conflict_entry)
+			if (ce && ce != o->df_conflict_entry)
 				free(ce);
 		}
 		return rc;
-- 
1.8.3
