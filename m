From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] builtin/commit.c: fix type warnings from gcc and sparse
Date: Fri, 29 Aug 2014 17:36:21 +0100
Message-ID: <5400AC05.9060900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 29 18:36:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPAE-0001iN-J6
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 18:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbaH2Qg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 12:36:29 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:44592 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753256AbaH2Qg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 12:36:27 -0400
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id B6F60A64D3A;
	Fri, 29 Aug 2014 17:36:24 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 740BAA64DCA;
	Fri, 29 Aug 2014 17:36:24 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Fri, 29 Aug 2014 17:36:23 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256153>


On 32-bit platforms (only), gcc and sparse both issue warnings
about the type of the pointer expression passed as the third
argument to find_commit_header().  In order to suppress the
warnings, we simply change the type of the 'len' variable to
size_t.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

If you need to re-roll your 'jk/commit-author-parsing' series, could
you please squash this into the equivalent of commit 95b5989
("determine_author_info(): reuse parsing functions", 27-08-2014).

Thanks!

ATB,
Ramsay Jones

 builtin/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a9bef73..7cb9981 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -583,7 +583,7 @@ static void determine_author_info(struct strbuf *author_ident)
 
 	if (author_message) {
 		struct ident_split ident;
-		unsigned long len;
+		size_t len;
 		const char *a;
 
 		a = find_commit_header(author_message_buffer, "author", &len);
-- 
2.1.0
