From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] setup.c: Fix some "symbol not declared" sparse warnings
Date: Tue, 17 May 2011 18:43:10 +0100
Message-ID: <4DD2B3AE.8060208@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 19:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMOMb-0007YW-9R
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 19:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab1EQRrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 13:47:16 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:47348 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755745Ab1EQRrP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2011 13:47:15 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1QMOKc-00078X-jV; Tue, 17 May 2011 17:45:18 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173817>


In particular, sparse issues the "symbol 'a_symbol' was not declared.
Should it be static?" warnings for the following symbols:

    setup.c:159:3: 'pathspec_magic'
    setup.c:176:12: 'prefix_pathspec'

These symbols only require file scope, so we add the static modifier
to their declarations.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

I noticed these sparse warnings on the next branch (as of a few days
ago).

ATB,
Ramsay Jones

 setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 58dc16c..013ad11 100644
--- a/setup.c
+++ b/setup.c
@@ -152,7 +152,7 @@ void verify_non_filename(const char *prefix, const char *arg)
  */
 #define PATHSPEC_FROMTOP    (1<<0)
 
-struct pathspec_magic {
+static struct pathspec_magic {
 	unsigned bit;
 	char mnemonic; /* this cannot be ':'! */
 	const char *name;
@@ -173,7 +173,7 @@ struct pathspec_magic {
  * the prefix part must always match literally, and a single stupid
  * string cannot express such a case.
  */
-const char *prefix_pathspec(const char *prefix, int prefixlen, const char *elt)
+static const char *prefix_pathspec(const char *prefix, int prefixlen, const char *elt)
 {
 	unsigned magic = 0;
 	const char *copyfrom = elt;
-- 
1.7.5
