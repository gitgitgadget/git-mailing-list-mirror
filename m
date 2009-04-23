From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile: ignore perl/ subdirectory under NO_PERL
Date: Wed, 22 Apr 2009 22:42:28 -0700
Message-ID: <7v3ac0x6wr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Robin H. Johnson" <robbat2@gentoo.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 07:44:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwrjI-0005Ab-B4
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 07:44:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbZDWFmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 01:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbZDWFmj
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 01:42:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41960 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZDWFmi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 01:42:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EBC01ADCE2;
	Thu, 23 Apr 2009 01:42:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9436BADCE1; Thu,
 23 Apr 2009 01:42:30 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8D1282BE-2FC9-11DE-A21D-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117298>

The install target still descends into perl subdirectory when NO_PERL is
requested.  Fix this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I think the very original from Robin had this exclusion, but somehow it
   seems to have got lost.  Right now, perl/Makefile does not do anything
   that depends on having perl, but I think we do not have/need to rely on
   that.

 Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 49f36f5..6f602c7 100644
--- a/Makefile
+++ b/Makefile
@@ -1529,7 +1529,9 @@ install: all
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archive$X git-shell$X git-cvsserver '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
+ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
+endif
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
 	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
