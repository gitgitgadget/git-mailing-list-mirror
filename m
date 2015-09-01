From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] path.c: make 'common_list' a file local symbol
Date: Tue, 1 Sep 2015 16:54:09 +0100
Message-ID: <55E5CA21.5080306@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 18:01:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWo0N-0001Xf-JW
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 18:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbbIAQBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 12:01:47 -0400
Received: from avasout05.plus.net ([84.93.230.250]:51752 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbbIAQBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 12:01:46 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2015 12:01:46 EDT
Received: from [10.0.2.15] ([146.200.92.77])
	by avasout05 with smtp
	id Bru91r0091g8v4q01ruApq; Tue, 01 Sep 2015 16:54:11 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=M8SwUHEs c=1 sm=1 tr=0
 a=nn16DVc344fa5cAYhNr7tw==:117 a=nn16DVc344fa5cAYhNr7tw==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=RbcJZid7ygW-bEsiRaMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276985>


Commit 04afda89 ("refs: clean up common_list", 26-08-2015) changed
the type of the 'common_list' symbol from an array of 'formatted'
strings to an array of struct containing the same data. However, in
addition it also (inadvertently) changed the visibility of the
symbol from file local to external.

In order to revert the visibility of the symbol to file local, add
the static modifier to the declaration of 'common_list'.

Noticed by sparse (symbol 'common_list' was not declared. Should it
be static?).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi David,

If you need to re-roll the patches on your 'dt/refs-bisection' branch, could you
please squash this into the relevant patch.

Thanks!

ATB,
Ramsay Jones

 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 9d32d19..a80eaf7 100644
--- a/path.c
+++ b/path.c
@@ -100,7 +100,7 @@ struct common_dir {
     const char *dirname;
 };
 
-struct common_dir common_list[] = {
+static struct common_dir common_list[] = {
     { 0, 1, 0, "branches" },
     { 0, 1, 0, "hooks" },
     { 0, 1, 0, "info" },
-- 
2.5.0
