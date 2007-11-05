From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] send-pack: require --verbose to show update of
	tracking refs
Date: Mon, 5 Nov 2007 00:12:18 -0500
Message-ID: <20071105051218.GC13144@sigill.intra.peff.net>
References: <20071105050517.GA6244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 06:12:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IouGU-0002Tj-C7
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 06:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbXKEFMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 00:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbXKEFMW
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 00:12:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4714 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061AbXKEFMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 00:12:21 -0500
Received: (qmail 21117 invoked by uid 111); 5 Nov 2007 05:12:20 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 00:12:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2007 00:12:18 -0500
Content-Disposition: inline
In-Reply-To: <20071105050517.GA6244@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63486>

This is really an uninteresting detail, and it just takes
attention away from the actual push updates and posssible
errors.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-send-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d74cc3c..c1fd3f5 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -195,7 +195,8 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 		return;
 
 	if (!remote_find_tracking(remote, &rs)) {
-		fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
+		if (args.verbose)
+			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
 		if (is_null_sha1(ref->peer_ref->new_sha1)) {
 			if (delete_ref(rs.dst, NULL))
 				error("Failed to delete");
-- 
1.5.3.5.1530.g7353
