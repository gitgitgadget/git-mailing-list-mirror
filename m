From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH] checkout: abbreviate hash in suggest_reattach
Date: Mon,  8 Apr 2013 18:53:42 +0300
Message-ID: <1365436422-25554-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 18:34:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPF1U-0004NB-Nf
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936650Ab3DHPyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 11:54:06 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:53714 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936630Ab3DHPyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 11:54:05 -0400
Received: from mail433.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 83615104EC5F
	for <git@vger.kernel.org>; Mon,  8 Apr 2013 18:06:09 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 8 Apr 2013 17:54:26 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 8 Apr 2013 17:54:23 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.445.gfcda34b
X-Ovh-Tracer-Id: 16730591140816654558
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeivddrtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.500017/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrledvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220435>

After printing the list of left-behind commits (with abbreviated
hashes), use an abbreviated hash in the suggested 'git branch' command;
there's no point in outputting a full 40-character hex string in some
friendly advice.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index a9c1b5a..e168bfb 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -700,7 +700,7 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 			"If you want to keep them by creating a new branch, "
 			"this may be a good time\nto do so with:\n\n"
 			" git branch new_branch_name %s\n\n"),
-			sha1_to_hex(commit->object.sha1));
+			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
 }
 
 /*
-- 
1.8.2.445.gfcda34b
