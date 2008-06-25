From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Keep some git-* programs in $(bindir)
Date: Tue, 24 Jun 2008 20:22:17 -0700
Message-ID: <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org>
References: <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
 <20080621121429.GI29404@genesis.frugalware.org>
 <7vwskfclfs.fsf@gitster.siamese.dyndns.org>
 <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
 <20080624160224.GA29404@genesis.frugalware.org>
 <alpine.DEB.1.00.0806241709330.9925@racer>
 <20080624185403.GB29404@genesis.frugalware.org>
 <alpine.DEB.1.00.0806242007150.9925@racer>
 <7vskv2d0lp.fsf@gitster.siamese.dyndns.org>
 <20080624221049.GE29404@genesis.frugalware.org>
 <7vk5gea0ff.fsf@gitster.siamese.dyndns.org>
 <20080624233236.GI29404@genesis.frugalware.org>
 <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org>
 <20080625120832.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 05:23:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLbV-0002fn-AS
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455AbYFYDWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbYFYDWd
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:22:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbYFYDWd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:22:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8114F16B46;
	Tue, 24 Jun 2008 23:22:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 66F7A16B45; Tue, 24 Jun 2008 23:22:20 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F11A72BE-4265-11DD-9E1F-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86205>

Otherwise remote executions directly over ssh won't find them as they used
to.  --upload-pack and --receive-pack options _could_ be used on the
client side, but things should keep working out-of-box for older clients.

Later versions of clients (fetch-pack and send-pack) probably could start
asking for these programs with dashless form, but that is a different
topic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * しらいしななこ <nanako3@lavabit.com> writes:
 > Doesn't "git archive --remote=<repo>" also execute git program on a remote machine?

 Ok, how about this?

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 929136b..742e7d3 100644
--- a/Makefile
+++ b/Makefile
@@ -1268,7 +1268,7 @@ install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexecdir_SQ)'
 	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexecdir_SQ)'
-	$(INSTALL) git$X '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-archive$X '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 ifndef NO_TCLTK
-- 
1.5.6.56.g29b0d
