From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/4] Remove unused variable in builtin-fetch find_non_local_tags
Date: Thu, 28 Feb 2008 03:42:31 -0500
Message-ID: <20080228084231.GA16870@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 09:43:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUeMG-0008Cq-6m
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 09:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbYB1Img (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 03:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbYB1Img
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 03:42:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60813 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbYB1Imf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 03:42:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JUeLX-0000yK-8Q; Thu, 28 Feb 2008 03:42:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B32DC20FBAE; Thu, 28 Feb 2008 03:42:31 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75366>

Apparently fetch_map is passed through, but is not actually used.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-fetch.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index ac335f2..f8b9542 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -452,8 +452,7 @@ static int add_existing(const char *refname, const unsigned char *sha1,
 	return 0;
 }
 
-static struct ref *find_non_local_tags(struct transport *transport,
-				       struct ref *fetch_map)
+static struct ref *find_non_local_tags(struct transport *transport)
 {
 	static struct path_list existing_refs = { NULL, 0, 0, 0 };
 	struct path_list new_refs = { NULL, 0, 0, 1 };
@@ -547,7 +546,7 @@ static int do_fetch(struct transport *transport,
 	/* if neither --no-tags nor --tags was specified, do automated tag
 	 * following ... */
 	if (tags == TAGS_DEFAULT && autotags) {
-		ref_map = find_non_local_tags(transport, fetch_map);
+		ref_map = find_non_local_tags(transport);
 		if (ref_map) {
 			transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 			fetch_refs(transport, ref_map);
-- 
1.5.4.3.393.g5540
