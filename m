From: mhagger@alum.mit.edu
Subject: [PATCH 0/3] Eliminate one user of extra_refs
Date: Fri,  6 Jan 2012 15:12:30 +0100
Message-ID: <1325859153-31016-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 06 15:13:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjAXR-0004dd-Hs
	for gcvg-git-2@lo.gmane.org; Fri, 06 Jan 2012 15:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758695Ab2AFOMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 09:12:45 -0500
Received: from mail.berlin.jpk.com ([212.222.128.130]:55311 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758674Ab2AFOMo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 09:12:44 -0500
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RjANa-0007TD-RR; Fri, 06 Jan 2012 15:02:46 +0100
X-Mailer: git-send-email 1.7.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188027>

From: Michael Haggerty <mhagger@alum.mit.edu>

Receive pack currently uses "extra refs" to keep track of ".have"
references, which in turn are used to tell the source the SHA1s of
references that are already known to the repository via alternates.

But the code already creates an array holding the alternate SHA1s.  So
just read the SHA1s out of this array rather then round-tripping them
through the extra_refs mechanism.

This is one step towards hopefully abolishing extra_refs altogether.
I still have to examine the other user.

Michael Haggerty (3):
  receive-pack: move more work into write_head_info()
  show_ref(): remove unused "flag" and "cb_data" arguments
  write_head_info(): handle "extra refs" locally

 builtin/receive-pack.c |   51 ++++++++++++++++++++---------------------------
 1 files changed, 22 insertions(+), 29 deletions(-)

-- 
1.7.8.2
