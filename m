From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [RFC/PATCH 2/2] builtin-merge: show user-friendly error messages for fast-forward too.
Date: Sun, 29 Nov 2009 13:18:33 +0100
Message-ID: <1259497113-1393-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1259497113-1393-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 29 13:18:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEijt-0003vA-Al
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 13:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbZK2MSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 07:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbZK2MSm
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 07:18:42 -0500
Received: from mx1.imag.fr ([129.88.30.5]:49683 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754160AbZK2MSk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 07:18:40 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nATCGlNc024879
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 29 Nov 2009 13:16:47 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NEiji-00089T-RO; Sun, 29 Nov 2009 13:18:42 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1NEiji-0005J6-QL; Sun, 29 Nov 2009 13:18:42 +0100
X-Mailer: git-send-email 1.6.5.3.435.g5f2e3.dirty
In-Reply-To: <1259497113-1393-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 29 Nov 2009 13:16:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nATCGlNc024879
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1260101807.68547@FdVH0t0mHNeVlBEZpH02EQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134016>

fadd069d03 (merge-recursive: give less scary messages when merge did not
start, Sep 7 2009) introduced some friendlier error message for merge
failure, but the messages were shown only for non-fast forward merges.
This patch uses the same for fast-forward.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This is where I'm not 100% sure I'm not breaking some plumbing.

 builtin-merge.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index 57eedd4..0dd363f 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -656,6 +656,7 @@ static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
 	opts.verbose_update = 1;
 	opts.merge = 1;
 	opts.fn = twoway_merge;
+	opts.msgs = get_porcelain_error_msgs();
 
 	trees[nr_trees] = parse_tree_indirect(head);
 	if (!trees[nr_trees++])
-- 
1.6.5.3.435.g5f2e3.dirty
